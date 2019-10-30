Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B699C47E49
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BFF20856
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="fvsM6xvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BFF20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPpMO-0002Pv-H0
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 10:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iPpIP-0004zS-2F
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iPpIN-0007GD-DV
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:50:00 -0400
Received: from mail-eopbgr690115.outbound.protection.outlook.com
 ([40.107.69.115]:23033 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iPpIN-0007Ax-4z
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 10:49:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PF8vblMSb/2W+DVHWpMYuVS1vj0FKPjWhl+FJl2QNFbuGbsoxcRhGX9qtsVLt4V4NnzwyMx+90xxWpr51SnQaBOSFYzz3meIuCeRBd+jVGoak8mGS/kie/0hnH80sDPSU25JnjPrjXHCVEnGsc3SneXR46YCaQ8TJHmcsWU8MOWT4elWB1JnN4ZXWWbPOix7MJliWGDAnil0XPNpaolaHraFFOhtjtSYgMFy+BJRfvYPQ/ncrWlqhGk4mcLmSo8iH8hYIYg2rxxeGpGRDHcyA5eHMZ+M3jhg3bXh4Oc4XJm/gLvrzFm2cRqswg9x44aVbjkn+vIWFivR2wowhfhjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlohKFEeNPENybhHei2e0FVYkxQgsNZXNNMup9nrD+A=;
 b=OnI7PdMDzPDFrOl3OIfdpP5oFGUc/wmlv1LmetNDfqtoV+HidkDOXS8iMgkJmt4qu0r0cLl4XXPqac6lePaPUOq941ht+Y2PCiwHFQ8m30iiX1L4K6gJBtAUQw0u36nSgqInTDP+lhMdi9F336ZdVjNKj7km6Nx6atKCvLsHSFa+cmOUg/UBD/4XMgWUn0gxLL1Zcu54LFwd1gaOdGD3wDLmWnFy66cQmunsL2xhPfSiqHBExGR3dC71IvPs71z2mL8v6PnJZf9VKJ/MHtTT1XBT0s8QiyHDZJa8jX1tp8DcpKBpWPch9zaP3VQ+sx4gVs1Znm0vU2/6Zj0oPCk5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlohKFEeNPENybhHei2e0FVYkxQgsNZXNNMup9nrD+A=;
 b=fvsM6xvUZr6chT0VgreWo8wxeEMyXb8OlzTw44oS/fPBVWpsdOQsAscZ+7Y3ChtCVUANI/W/R6Bp0dBG6bUvRzdVFYVU1CfhUWyA9yyRif8ZpKmlk4/nUCSRIl1ZPQ1vOC5h2S49mwEnMIeM96pjy6IXZbY5KMkOr2F8ww263h0=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB4959.namprd03.prod.outlook.com (52.132.168.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 30 Oct 2019 14:49:55 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 14:49:55 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v4 09/20] libqos: split qos-test and libqos makefile vars
Thread-Topic: [PATCH v4 09/20] libqos: split qos-test and libqos makefile vars
Thread-Index: AQHVjzFLUjZTO9knKEKo+uppkwfcLA==
Date: Wed, 30 Oct 2019 14:49:55 +0000
Message-ID: <20191030144926.11873-10-alxndr@bu.edu>
References: <20191030144926.11873-1-alxndr@bu.edu>
In-Reply-To: <20191030144926.11873-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: DM5PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:4:60::37) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0119ee4-4a0d-4630-4f9c-08d75d486d90
x-ms-traffictypediagnostic: MN2PR03MB4959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB49599E211B4F40DB90FBD67ABA600@MN2PR03MB4959.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(102836004)(386003)(6506007)(66946007)(66446008)(64756008)(66476007)(2616005)(186003)(2351001)(446003)(26005)(36756003)(66556008)(3846002)(6116002)(2501003)(14454004)(11346002)(66066001)(256004)(4326008)(6916009)(305945005)(1076003)(6486002)(486006)(5660300002)(71190400001)(50226002)(71200400001)(476003)(86362001)(88552002)(7736002)(52116002)(76176011)(2906002)(478600001)(99286004)(786003)(316002)(8676002)(81166006)(5640700003)(81156014)(25786009)(6436002)(75432002)(8936002)(6512007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB4959;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2eCn3HtlvBMeL9xFdUL/GCnG4J8NDdugo1mPEdL8clOvtHku9gWe1JkjKHA+wF5pL/Ny4oDQdeGhm8REzmt84yxb2NnMuqa9LVuN49/NCt8oKWXUD3CVXpZ/56eDjfn2FSVpKsIgNqDRFn7YtEMTHDmGEOT8QTNhjKN55us5sG3yd6XP0bm2TuUAxdIeuQB4OmOzBr+NzwycCPbQ9xQ2EqG1hBG5Brl1m6lT81u1JhXMbtryV9z87JBGL/961X453hoNJfekrdN0nqee3TwEwVVMcxoVhFTDczLbVHsigQf6C1+nox2RKBHVHRLKfnsDRk12qoIpmFuMmPB3VcW4kWF0amJXAEUrv0k/hJX9++i/XKGRM4SsbmqaAwqv7McWPg6yj6xF4x6B1HxS61dlR85s2n0NWbk13YS8zPqWAm5bVL0fO+iNpbM5BF6yighb
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: d0119ee4-4a0d-4630-4f9c-08d75d486d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 14:49:55.5765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYGGPht1AQlJDhYPPHSpjTQw6TUz2qV2+t847U9qc+SctwU0D+vF+nOMwJ6OfTu3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4959
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.69.115
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Oleinik <alxndr@bu.edu>

Most qos-related objects were specified in the qos-test-obj-y variable.
qos-test-obj-y also included qos-test.o which defines a main().
This made it difficult to repurpose qos-test-obj-y to link anything
beside tests/qos-test against libqos. This change separates objects that
are libqos-specific and ones that are qos-test specific into different
variables.

Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
---
 tests/Makefile.include | 71 +++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 67853d10c3..1517c4817e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -699,52 +699,53 @@ tests/test-crypto-block$(EXESUF): tests/test-crypto-b=
lock.o $(test-crypto-obj-y)
=20
 libqgraph-obj-y =3D tests/libqos/qgraph.o
=20
-libqos-obj-y =3D $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/fw_cfg=
.o
-libqos-obj-y +=3D tests/libqos/malloc.o
-libqos-obj-y +=3D tests/libqos/libqos.o
-libqos-spapr-obj-y =3D $(libqos-obj-y) tests/libqos/malloc-spapr.o
+libqos-core-obj-y =3D $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/f=
w_cfg.o
+libqos-core-obj-y +=3D tests/libqos/malloc.o
+libqos-core-obj-y +=3D tests/libqos/libqos.o
+libqos-spapr-obj-y =3D $(libqos-core-obj-y) tests/libqos/malloc-spapr.o
 libqos-spapr-obj-y +=3D tests/libqos/libqos-spapr.o
 libqos-spapr-obj-y +=3D tests/libqos/rtas.o
 libqos-spapr-obj-y +=3D tests/libqos/pci-spapr.o
-libqos-pc-obj-y =3D $(libqos-obj-y) tests/libqos/pci-pc.o
+libqos-pc-obj-y =3D $(libqos-core-obj-y) tests/libqos/pci-pc.o
 libqos-pc-obj-y +=3D tests/libqos/malloc-pc.o tests/libqos/libqos-pc.o
 libqos-pc-obj-y +=3D tests/libqos/ahci.o
 libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos=
/usb.o
=20
 # Devices
-qos-test-obj-y =3D tests/qos-test.o $(libqgraph-obj-y)
-qos-test-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
-qos-test-obj-y +=3D tests/libqos/e1000e.o
-qos-test-obj-y +=3D tests/libqos/i2c.o
-qos-test-obj-y +=3D tests/libqos/i2c-imx.o
-qos-test-obj-y +=3D tests/libqos/i2c-omap.o
-qos-test-obj-y +=3D tests/libqos/sdhci.o
-qos-test-obj-y +=3D tests/libqos/tpci200.o
-qos-test-obj-y +=3D tests/libqos/virtio.o
-qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/libqos/virtio-9p.o
-qos-test-obj-y +=3D tests/libqos/virtio-balloon.o
-qos-test-obj-y +=3D tests/libqos/virtio-blk.o
-qos-test-obj-y +=3D tests/libqos/virtio-mmio.o
-qos-test-obj-y +=3D tests/libqos/virtio-net.o
-qos-test-obj-y +=3D tests/libqos/virtio-pci.o
-qos-test-obj-y +=3D tests/libqos/virtio-pci-modern.o
-qos-test-obj-y +=3D tests/libqos/virtio-rng.o
-qos-test-obj-y +=3D tests/libqos/virtio-scsi.o
-qos-test-obj-y +=3D tests/libqos/virtio-serial.o
+libqos-obj-y =3D $(libqgraph-obj-y)
+libqos-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+libqos-obj-y +=3D tests/libqos/e1000e.o
+libqos-obj-y +=3D tests/libqos/i2c.o
+libqos-obj-y +=3D tests/libqos/i2c-imx.o
+libqos-obj-y +=3D tests/libqos/i2c-omap.o
+libqos-obj-y +=3D tests/libqos/sdhci.o
+libqos-obj-y +=3D tests/libqos/tpci200.o
+libqos-obj-y +=3D tests/libqos/virtio.o
+libqos-obj-$(CONFIG_VIRTFS) +=3D tests/libqos/virtio-9p.o
+libqos-obj-y +=3D tests/libqos/virtio-balloon.o
+libqos-obj-y +=3D tests/libqos/virtio-blk.o
+libqos-obj-y +=3D tests/libqos/virtio-mmio.o
+libqos-obj-y +=3D tests/libqos/virtio-net.o
+libqos-obj-y +=3D tests/libqos/virtio-pci.o
+libqos-obj-y +=3D tests/libqos/virtio-pci-modern.o
+libqos-obj-y +=3D tests/libqos/virtio-rng.o
+libqos-obj-y +=3D tests/libqos/virtio-scsi.o
+libqos-obj-y +=3D tests/libqos/virtio-serial.o
=20
 # Machines
-qos-test-obj-y +=3D tests/libqos/aarch64-xlnx-zcu102-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-imx25-pdk-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-n800-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-raspi2-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-sabrelite-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-smdkc210-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-virt-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-xilinx-zynq-a9-machine.o
-qos-test-obj-y +=3D tests/libqos/ppc64_pseries-machine.o
-qos-test-obj-y +=3D tests/libqos/x86_64_pc-machine.o
+libqos-obj-y +=3D tests/libqos/aarch64-xlnx-zcu102-machine.o
+libqos-obj-y +=3D tests/libqos/arm-imx25-pdk-machine.o
+libqos-obj-y +=3D tests/libqos/arm-n800-machine.o
+libqos-obj-y +=3D tests/libqos/arm-raspi2-machine.o
+libqos-obj-y +=3D tests/libqos/arm-sabrelite-machine.o
+libqos-obj-y +=3D tests/libqos/arm-smdkc210-machine.o
+libqos-obj-y +=3D tests/libqos/arm-virt-machine.o
+libqos-obj-y +=3D tests/libqos/arm-xilinx-zynq-a9-machine.o
+libqos-obj-y +=3D tests/libqos/ppc64_pseries-machine.o
+libqos-obj-y +=3D tests/libqos/x86_64_pc-machine.o
=20
 # Tests
+qos-test-obj-y =3D tests/qos-test.o
 qos-test-obj-y +=3D tests/ac97-test.o
 qos-test-obj-y +=3D tests/ds1338-test.o
 qos-test-obj-y +=3D tests/e1000-test.o
@@ -776,7 +777,7 @@ check-unit-y +=3D tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
=20
 check-qtest-generic-y +=3D tests/qos-test$(EXESUF)
-tests/qos-test$(EXESUF): $(qos-test-obj-y)
+tests/qos-test$(EXESUF): $(qos-test-obj-y) $(libqos-obj-y)
=20
 tests/qmp-test$(EXESUF): tests/qmp-test.o
 tests/qmp-cmd-test$(EXESUF): tests/qmp-cmd-test.o
--=20
2.23.0


