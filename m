Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB61C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:39:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5145D20659
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="6eBauvx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5145D20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1cJI-0003Di-G2
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j1cFx-0006Wi-UV
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j1cFv-0008Ku-3g
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:41 -0500
Received: from mail-dm6nam12on2092.outbound.protection.outlook.com
 ([40.107.243.92]:50848 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j1cFu-0008HE-T4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:35:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVfnk/clVUWMCc6gczy7VIKc+DlAruui7i6sbFdg13Jv8oIb0gLFKtWjuzokVufjAYfmYA4WJIyFJo5aXXFh2+IeZjIk4dayuZULWw47iUMrCazt05dtAxKzn3JsToGuEOAlSDLMlMEn9NaVugv1AIBODFTS6IY0HhWJTygoonUpdlwzjn+OjLMEuvrLk0VIrhkyp4P1xueCf+D85aL0ZTd3Wxz6Q+oE5cMcU7npgDvqgE4IhjxxFG8umkvXkowTNc2BivRlYvYWxfQu/4qqjBHJg23MPkbvjlfuxfrPBDIiH5lAD2JyYbKXRc6hInx1GlRzvYtigZwhoRnPmZncLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EidSJguOjA9uQ8reMJ7rGZwKnYrZW8gHg9BjGSzrZk4=;
 b=YvnY0eLZcWvr9NnYRKA8CqWxWp9w3XSxhlouDNurzVZr7K2UYz2DZdahTRvrcBDng39JfmDuvlJ6Es7UMRdXbOl1RzElQPBC+k9M/lXmutmxFwVQnOyo0OtBlpO5K+g8GrqiGRp5ghEQ+F4qkIZhMJRPBSExQRwaiNiOpVoG7nvOEPmf4MpiyRVoBfAXXcD6LsvFQVqb9JqpDzhw+lzPBFogDaxyTOkE4zV8PL3gYc0o0BiyGfVVLGNFJC73hY8TnItM7Fw0twlZRSKNNcoa3bf271C2EQ7ts9lJ2tDOyZK/x+bhaawEHUMeKoWKM4zUgJ2Q7OK/C6sBp0oFj3IbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EidSJguOjA9uQ8reMJ7rGZwKnYrZW8gHg9BjGSzrZk4=;
 b=6eBauvx0T+7st6i4LRYKBJU64hsVzB+LnVnV3pQ92I+5Ii+yDTeb51u8AcY+lXL9ev9qJmypCC+C9GZ4ZFobXEKRDyyda1wNLbRQCu73l2Vt5+3/zMRnBAVJGDDEKKtkbf3SFhra9P9zc0iE7t3wYbIu+tsWefpaFz9ZFTXEivI=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (52.135.102.32) by
 SN6PR03MB4336.namprd03.prod.outlook.com (20.177.254.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 20:35:32 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 20:35:32 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 11/23] libqos: split qos-test and libqos makefile vars
Date: Tue, 11 Feb 2020 15:34:58 -0500
Message-ID: <20200211203510.3534-12-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211203510.3534-1-alxndr@bu.edu>
References: <20200211203510.3534-1-alxndr@bu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0124.namprd02.prod.outlook.com
 (2603:10b6:208:35::29) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR02CA0124.namprd02.prod.outlook.com (2603:10b6:208:35::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23 via Frontend Transport; Tue, 11 Feb 2020 20:35:31 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06e8430c-bde1-44af-205d-08d7af31f05c
X-MS-TrafficTypeDiagnostic: SN6PR03MB4336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB433668D1EC86388773CACEEBBA180@SN6PR03MB4336.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(16526019)(6666004)(1076003)(5660300002)(86362001)(316002)(186003)(786003)(66556008)(54906003)(6916009)(66476007)(6486002)(66946007)(8936002)(478600001)(4326008)(7696005)(52116002)(36756003)(75432002)(2616005)(2906002)(956004)(8676002)(26005)(81166006)(81156014);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB4336;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROxQk3f07rJpGuB/LoMyU1/zWvv5j8u2pXwGEeOobO9PrMDhcGVAzEfbLJcRGmCNAet8OLjGsUz6bDvZNeVZR3N4CGIl0uSizXx9UzA+b/25S8+0fbgpr6usHXd6NjPDWxd3SMfznMMS9OXFWBd7LntvS60d+UlsiDx/x4CuHBYwawf8unxTakJluJu9f3dh6ApsXjLr9xqHI3IBWFZEvpq0X0H6e3rX9z1w/F44Ay1NP4MxC8ZvdJqopZ0NX54ux4p5SfbCOImUkn1YsPsG+2pcc0otgXvKorneWz4OMGAumArnWwh/9u8fZMq9pnUh1Q7XTyqYUfv4Qjk+t6ORsaAOMuCqygXJs1qEOZGGC3VzFHfiDyxLlrnO5We69xRgR5+1ophtDp/tf2dA6AvfBMOpah0KDgsJNsWewfUfqQd3c7PfFxcS6mNrVguptJ5B
X-MS-Exchange-AntiSpam-MessageData: GaJwSvPNVsemkDrrDlYFXTKD2iisWPCquxb2jKEzVtILk40+DM2cQb+NFQiYE7vGDkNI6O9shIr9hMPXnYOOENjRISFDNtcqkBVYVDq5uMgIbRwYCG0Pe2W5CCHgC2ceePQUqDgXwnYBlycOZK2lWQ==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e8430c-bde1-44af-205d-08d7af31f05c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 20:35:31.9191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SL5ob1aAePsibpzSXq67hyKOsjFP8z7zjkVkA2yYnl5BwlCBuu0FjDYE7z3n4OCr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB4336
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.92
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 darren.kenny@oracle.com, Alexander Bulekov <alxndr@bu.edu>, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/qtest/Makefile.include | 71 ++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index eb0f23b108..838618e6f9 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -157,52 +157,53 @@ check-qtest-s390x-y +=3D migration-test
 # libqos / qgraph :
 libqgraph-obj-y =3D tests/qtest/libqos/qgraph.o
=20
-libqos-obj-y =3D $(libqgraph-obj-y) tests/qtest/libqos/pci.o tests/qtest/l=
ibqos/fw_cfg.o
-libqos-obj-y +=3D tests/qtest/libqos/malloc.o
-libqos-obj-y +=3D tests/qtest/libqos/libqos.o
-libqos-spapr-obj-y =3D $(libqos-obj-y) tests/qtest/libqos/malloc-spapr.o
+libqos-core-obj-y =3D $(libqgraph-obj-y) tests/qtest/libqos/pci.o tests/qt=
est/libqos/fw_cfg.o
+libqos-core-obj-y +=3D tests/qtest/libqos/malloc.o
+libqos-core-obj-y +=3D tests/qtest/libqos/libqos.o
+libqos-spapr-obj-y =3D $(libqos-core-obj-y) tests/qtest/libqos/malloc-spap=
r.o
 libqos-spapr-obj-y +=3D tests/qtest/libqos/libqos-spapr.o
 libqos-spapr-obj-y +=3D tests/qtest/libqos/rtas.o
 libqos-spapr-obj-y +=3D tests/qtest/libqos/pci-spapr.o
-libqos-pc-obj-y =3D $(libqos-obj-y) tests/qtest/libqos/pci-pc.o
+libqos-pc-obj-y =3D $(libqos-core-obj-y) tests/qtest/libqos/pci-pc.o
 libqos-pc-obj-y +=3D tests/qtest/libqos/malloc-pc.o tests/qtest/libqos/lib=
qos-pc.o
 libqos-pc-obj-y +=3D tests/qtest/libqos/ahci.o
 libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/qtest/=
libqos/usb.o
=20
 # qos devices:
-qos-test-obj-y =3D tests/qtest/qos-test.o $(libqgraph-obj-y)
-qos-test-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
-qos-test-obj-y +=3D tests/qtest/libqos/e1000e.o
-qos-test-obj-y +=3D tests/qtest/libqos/i2c.o
-qos-test-obj-y +=3D tests/qtest/libqos/i2c-imx.o
-qos-test-obj-y +=3D tests/qtest/libqos/i2c-omap.o
-qos-test-obj-y +=3D tests/qtest/libqos/sdhci.o
-qos-test-obj-y +=3D tests/qtest/libqos/tpci200.o
-qos-test-obj-y +=3D tests/qtest/libqos/virtio.o
-qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/qtest/libqos/virtio-9p.o
-qos-test-obj-y +=3D tests/qtest/libqos/virtio-balloon.o
-qos-test-obj-y +=3D tests/qtest/libqos/virtio-blk.o
-qos-test-obj-y +=3D tests/qtest/libqos/virtio-mmio.o
-qos-test-obj-y +=3D tests/qtest/libqos/virtio-net.o
-qos-test-obj-y +=3D tests/qtest/libqos/virtio-pci.o
-qos-test-obj-y +=3D tests/qtest/libqos/virtio-pci-modern.o
-qos-test-obj-y +=3D tests/qtest/libqos/virtio-rng.o
-qos-test-obj-y +=3D tests/qtest/libqos/virtio-scsi.o
-qos-test-obj-y +=3D tests/qtest/libqos/virtio-serial.o
+libqos-obj-y =3D  $(libqgraph-obj-y)
+libqos-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+libqos-obj-y +=3D tests/qtest/libqos/e1000e.o
+libqos-obj-y +=3D tests/qtest/libqos/i2c.o
+libqos-obj-y +=3D tests/qtest/libqos/i2c-imx.o
+libqos-obj-y +=3D tests/qtest/libqos/i2c-omap.o
+libqos-obj-y +=3D tests/qtest/libqos/sdhci.o
+libqos-obj-y +=3D tests/qtest/libqos/tpci200.o
+libqos-obj-y +=3D tests/qtest/libqos/virtio.o
+libqos-obj-$(CONFIG_VIRTFS) +=3D tests/qtest/libqos/virtio-9p.o
+libqos-obj-y +=3D tests/qtest/libqos/virtio-balloon.o
+libqos-obj-y +=3D tests/qtest/libqos/virtio-blk.o
+libqos-obj-y +=3D tests/qtest/libqos/virtio-mmio.o
+libqos-obj-y +=3D tests/qtest/libqos/virtio-net.o
+libqos-obj-y +=3D tests/qtest/libqos/virtio-pci.o
+libqos-obj-y +=3D tests/qtest/libqos/virtio-pci-modern.o
+libqos-obj-y +=3D tests/qtest/libqos/virtio-rng.o
+libqos-obj-y +=3D tests/qtest/libqos/virtio-scsi.o
+libqos-obj-y +=3D tests/qtest/libqos/virtio-serial.o
=20
 # qos machines:
-qos-test-obj-y +=3D tests/qtest/libqos/aarch64-xlnx-zcu102-machine.o
-qos-test-obj-y +=3D tests/qtest/libqos/arm-imx25-pdk-machine.o
-qos-test-obj-y +=3D tests/qtest/libqos/arm-n800-machine.o
-qos-test-obj-y +=3D tests/qtest/libqos/arm-raspi2-machine.o
-qos-test-obj-y +=3D tests/qtest/libqos/arm-sabrelite-machine.o
-qos-test-obj-y +=3D tests/qtest/libqos/arm-smdkc210-machine.o
-qos-test-obj-y +=3D tests/qtest/libqos/arm-virt-machine.o
-qos-test-obj-y +=3D tests/qtest/libqos/arm-xilinx-zynq-a9-machine.o
-qos-test-obj-y +=3D tests/qtest/libqos/ppc64_pseries-machine.o
-qos-test-obj-y +=3D tests/qtest/libqos/x86_64_pc-machine.o
+libqos-obj-y +=3D tests/qtest/libqos/aarch64-xlnx-zcu102-machine.o
+libqos-obj-y +=3D tests/qtest/libqos/arm-imx25-pdk-machine.o
+libqos-obj-y +=3D tests/qtest/libqos/arm-n800-machine.o
+libqos-obj-y +=3D tests/qtest/libqos/arm-raspi2-machine.o
+libqos-obj-y +=3D tests/qtest/libqos/arm-sabrelite-machine.o
+libqos-obj-y +=3D tests/qtest/libqos/arm-smdkc210-machine.o
+libqos-obj-y +=3D tests/qtest/libqos/arm-virt-machine.o
+libqos-obj-y +=3D tests/qtest/libqos/arm-xilinx-zynq-a9-machine.o
+libqos-obj-y +=3D tests/qtest/libqos/ppc64_pseries-machine.o
+libqos-obj-y +=3D tests/qtest/libqos/x86_64_pc-machine.o
=20
 # qos tests:
+qos-test-obj-y +=3D tests/qtest/qos-test.o
 qos-test-obj-y +=3D tests/qtest/ac97-test.o
 qos-test-obj-y +=3D tests/qtest/ds1338-test.o
 qos-test-obj-y +=3D tests/qtest/e1000-test.o
@@ -234,7 +235,7 @@ check-unit-y +=3D tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
=20
 check-qtest-generic-y +=3D qos-test
-tests/qtest/qos-test$(EXESUF): $(qos-test-obj-y)
+tests/qtest/qos-test$(EXESUF): $(qos-test-obj-y) $(libqos-obj-y)
=20
 # QTest dependencies:
 tests/qtest/qmp-test$(EXESUF): tests/qtest/qmp-test.o
--=20
2.25.0


