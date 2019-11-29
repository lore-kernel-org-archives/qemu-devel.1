Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6C1C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40981206B5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 21:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="sLelXzwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40981206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ianwm-000263-0Z
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 16:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1ianug-00006N-R1
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1ianue-0002tr-TC
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:54 -0500
Received: from mail-eopbgr740102.outbound.protection.outlook.com
 ([40.107.74.102]:45028 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1ianue-0002ik-OB
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 16:34:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J65QzqwDkGw31QhB5yTDIfKtkreWOlm8BOFx58Wp6Jux5uLbnCV+8s6hlNpThVEpy869IMgugeC8zkC0jXoPJXI4pa1qfSj98CqKp4JvddN1XGMzfmU94tGSmLlb+TnCxQb/CG9mg5DQb4vh/aNPI03p/v7/PKjoOf46WrlRXLG4HyNhR7ZyE6cUgDqsvRKTrbFIQXHwND5H2/LWPkJ/VN8HFZWC4fvOD7jUld3CII3J5JGvjC/rHxoaNe6S8/gNLL01Z3Ppf5zYfur1wgv+V50gLPUw/h4YPyPXae7l0sv4+11s4MKWY23I4p2DRlCddoniDXPgxgs/qMBrb0HFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4nelNm3ViXjGXTRA25BmE9nzrHl/hX1sLHB7lbI+P8=;
 b=WdmHP9pFFok1rtJuzw5F3jrdU8F9b1+ikmBRMhzz20zJ2gpAc9CurRRr8o/GKIouaMz1ogQEOexpJl3zESF2Pf756qzZk01ByJSF06YTy7ToucjMURTYxmQF1mVmAsuko450aFybNZTqzxVSkLleE5N3qo/3zoIGWb03iR3TUSGEyLEpfkHpDfqReobKTF4RtwpKnwOz8jYqT1d2d4smqH+wq6ZQmnOO5YXauRowPDJzCB1A480oQ1l0uP85KQfjgMZPHeEN7VNyE6fqJmbJZgudJ9Yk85e1/vFKVUoEIv9Qu7SIwlDu2pwLwkAnck4Dr0KYjkJe6uGSV9OL+7yZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4nelNm3ViXjGXTRA25BmE9nzrHl/hX1sLHB7lbI+P8=;
 b=sLelXzwS/HPhK6Lfi74phHGFY2gv5XgSoR7J7RyXcGaNbanENTD0j+b62IK0bTp6UVIMCgug+eEs1T5dKU1Kld0OwvpZfQTbOGYDe2m19oTjEgvduVhSgJEZ9vcRqQaVnryWqYgq+AkC8Me9uR028or8njYKY00dQlJCOb6c1BU=
Received: from DM6PR03MB4795.namprd03.prod.outlook.com (20.179.107.22) by
 DM6PR03MB5050.namprd03.prod.outlook.com (10.141.161.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 29 Nov 2019 21:34:45 +0000
Received: from DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74]) by DM6PR03MB4795.namprd03.prod.outlook.com
 ([fe80::2557:454e:205e:4d74%2]) with mapi id 15.20.2495.014; Fri, 29 Nov 2019
 21:34:45 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v6 09/21] libqos: split qos-test and libqos makefile vars
Thread-Topic: [PATCH v6 09/21] libqos: split qos-test and libqos makefile vars
Thread-Index: AQHVpvzRY5riVEmp4kicqYKMIrRnGQ==
Date: Fri, 29 Nov 2019 21:34:44 +0000
Message-ID: <20191129213424.6290-10-alxndr@bu.edu>
References: <20191129213424.6290-1-alxndr@bu.edu>
In-Reply-To: <20191129213424.6290-1-alxndr@bu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.23.0
x-originating-ip: [128.197.127.33]
x-clientproxiedby: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To DM6PR03MB4795.namprd03.prod.outlook.com
 (2603:10b6:5:18c::22)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46d2f7f7-984a-4f9e-25c1-08d77513f3a0
x-ms-traffictypediagnostic: DM6PR03MB5050:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB5050B46984277604F1B8A092BA460@DM6PR03MB5050.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0236114672
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(366004)(346002)(39860400002)(136003)(396003)(199004)(189003)(54906003)(81156014)(81166006)(66066001)(6436002)(3846002)(8936002)(66946007)(6116002)(1076003)(66446008)(64756008)(66476007)(256004)(66556008)(316002)(786003)(8676002)(6512007)(102836004)(6486002)(478600001)(71190400001)(71200400001)(2351001)(86362001)(6506007)(14454004)(2501003)(75432002)(386003)(5640700003)(2906002)(6916009)(7736002)(2616005)(25786009)(26005)(52116002)(88552002)(99286004)(5660300002)(76176011)(186003)(446003)(11346002)(305945005)(50226002)(36756003)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DM6PR03MB5050;
 H:DM6PR03MB4795.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hOXbl2sZk4+I3hdVnCtIIElUCZPGpXfFVUGS7l07xq4pqVLYbTfDQa1BlT2RgoBpR84mJcem3+9Ro7rCTjV6DtAX8vRiNTtl+3IaaE0pB97sw2oYi0QeBDo3R/5Tt4TdactZrA8fLzEb/ikrfZTJFNOosuwUdLWSw26EPp8H3E7AtzqZR6BWdZ4pWNBsjfFbR+xp5i3vs1WZukeG6Oay6OfRYHGDZbzBTrhI2AuiceJArpsuIZ9IcA+A2eaC5ctC6YMYNZNA6YDb3FOPPioEZ0oPiR+Ion2zSQQzEeyMsmL6+UJkjWONOtSrDVpljq/NGyorf/3X6glXscy0Nt3KpLXe16mRAvnsDzY8YRjSKbkmAQ2ktAtJx9gen6AsS0OYOvhsQb15BHJ0DTRdanMG0Yf6jkUWnbzW+ttWGYOWK4IhP9sbVFgsywF28MAarzHS
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d2f7f7-984a-4f9e-25c1-08d77513f3a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2019 21:34:45.0210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ny3G5H/fEH6Tw8PcUpORfr10gBfBR0yBrK4JEkkXISSf0lRyDDTYtSh4KNVEmwy7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5050
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.102
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
 "bsd@redhat.com" <bsd@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "Oleinik, 
 Alexander" <alxndr@bu.edu>
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
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
---
 tests/Makefile.include | 71 +++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3669fd1dc3..031240df4b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -703,52 +703,53 @@ tests/test-crypto-block$(EXESUF): tests/test-crypto-b=
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
@@ -780,7 +781,7 @@ check-unit-y +=3D tests/test-qgraph$(EXESUF)
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


