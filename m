Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236F6C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF8F206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 23:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="BRQ/sWc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF8F206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV1it-0006KW-2R
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 18:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iV1TQ-00084T-V7
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iV1TP-0007fk-3r
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:52 -0500
Received: from mail-eopbgr820113.outbound.protection.outlook.com
 ([40.107.82.113]:22310 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iV1TO-0007aZ-TC
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:50:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWen9T14xFSOlZLxDX4NCM9iYek0ldsta74Yi6XPT/ZW+rwSxIMCFaf63RC3qaf7jlbc0V6MqJtroORyJBvKnmVC22u32wdjkRu6MFcqW4F2fMVJ14knNY3PjTUQoRszn4vSRRfwEEMEWW2eXXNidH/c5UmBgCs3oQFAKPTxJ1SICNJH2j1QJsP4Lo1GsKilOjP73D0fgRMjoW5vO/XekNApjH4UXnT+b7a8xwJXproD3hRtHL3YbVXDK5zf6DqPwRiuOuqrAWNNiCsWwxTAHKtkAQZjpzqowafBHLasjk/GPjqAhbUh8U98RWAwIYUosLfevvCROVZL/zeO5S6t4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38yEcC/iq4hGnspSBbOSdiKqOVst6Vf8Xzio+0xyMQ0=;
 b=gefQ+1QEHdJTy1ksoR+bSxpsm5b50Amf1ovD7v8DVOPACdsGHksAT0cs9gPwvfhos1rLPMSeNd57QoR6PcoDJM/J0WNIcU5LQrWoCmMehhQrUpaFKcpIY+HG5MvRHCy0VswFD/n4fI/pZrZAcWV7Xr/EyKeF3wMpgJZHpJvQ0P0WRXmjgsImoShLV25p1W8DahW9HAP1kYi8Sgit5Kj5trBZvZKrBxXyOyXRW8xABrGoJGYSPW5xDvTU87lFmMPH79mkzj9PtP6/35ggQTdlvsJ/cvIO6+HD3m6yN59QwpnjuCrQUJdiu9Tn1lJGN+MTPB16pK9BHNoelEPZTQUrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38yEcC/iq4hGnspSBbOSdiKqOVst6Vf8Xzio+0xyMQ0=;
 b=BRQ/sWc2b/e0IWEris8gP4G+UPYYBR6UiqqYCk2VSEzyJ6LPORkkSkvqwOSJu3R3SOyXSgMCb9esyu4sitUvU1bW6E1ZCkXQwR04DC9VS+6g+AdtBJok8QR5d/u2xfkluqbu5p+ZKomoLxLmpvmgBg9T/sYrohmbxwspacK2rrI=
Received: from MN2PR03MB4800.namprd03.prod.outlook.com (20.179.82.78) by
 MN2PR03MB5024.namprd03.prod.outlook.com (52.132.169.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 22:50:47 +0000
Received: from MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66]) by MN2PR03MB4800.namprd03.prod.outlook.com
 ([fe80::344f:b88:26f0:9f66%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 22:50:47 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v5 09/20] libqos: split qos-test and libqos makefile vars
Thread-Topic: [PATCH v5 09/20] libqos: split qos-test and libqos makefile vars
Thread-Index: AQHVmnTJ281BgUG1rEC0HZrhrCW03Q==
Date: Wed, 13 Nov 2019 22:50:47 +0000
Message-ID: <20191113225030.17023-10-alxndr@bu.edu>
References: <20191113225030.17023-1-alxndr@bu.edu>
In-Reply-To: <20191113225030.17023-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: MN2PR15CA0028.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::41) To MN2PR03MB4800.namprd03.prod.outlook.com
 (2603:10b6:208:101::14)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54970c5e-74cb-4236-f1c1-08d7688bec4d
x-ms-traffictypediagnostic: MN2PR03MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR03MB5024716EB97B33AC088E896FBA760@MN2PR03MB5024.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(2501003)(88552002)(75432002)(54906003)(446003)(7736002)(99286004)(11346002)(6436002)(6486002)(5640700003)(476003)(305945005)(256004)(786003)(2906002)(2351001)(316002)(14454004)(6116002)(86362001)(2616005)(6512007)(6916009)(486006)(3846002)(71200400001)(71190400001)(4326008)(1076003)(36756003)(386003)(8676002)(478600001)(66066001)(76176011)(81166006)(186003)(66946007)(5660300002)(6506007)(81156014)(64756008)(52116002)(26005)(102836004)(50226002)(25786009)(8936002)(66476007)(66556008)(66446008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MN2PR03MB5024;
 H:MN2PR03MB4800.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HZIKSbL3uTrhaCJysfyLRXshgFR96r6bcwMUYpW3JvSIxwe9TbAb74ysHVDzzz5WEY+6lj4tOCdTFRZPjeaE37VwUuLUCHwv5aGlcrMGmoX9A4lZ8mJelfn5wJ4cmN+YzL8eYFdexwN9OA8ihk1VezZJZw4CHZgaYWHbXrS02t2GUlKb0I1PztJPuhm1wO9CEBBxCioeqm6Od+K5wq+mMFFJOhdo5SSdB1wYgiY2t7P5aXkm/SMiGa3Rhaeji7se9tLrAAy0NuPNNCkuFUkjjEt2+Y1qtgs2iz94M/OwvgPoQ+wwB3GpLwvYwZjNfUtZnqd1eeeGzMTHktOADUMzopF3XmzVxudbhaA9Zrh5f26KlhR9855hkr3BkThAADPmbYKK1NNPZRSHtPuhVXDDNPeazc4lQjcy12cvNpl54Np4hE1KzUsjBDrh0FYOu3uv
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 54970c5e-74cb-4236-f1c1-08d7688bec4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 22:50:47.2607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uIt8kKhXJc/IgO6wW9gXPZJEAFu++zu/nFr0I2TQuxF8uq9Owx556d/yGREZ5H6E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5024
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.113
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "Oleinik, Alexander" <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most qos-related objects were specified in the qos-test-obj-y variable.
qos-test-obj-y also included qos-test.o which defines a main().
This made it difficult to repurpose qos-test-obj-y to link anything
beside tests/qos-test against libqos. This change separates objects that
are libqos-specific and ones that are qos-test specific into different
variables.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
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


