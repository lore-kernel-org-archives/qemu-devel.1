Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD5AC34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CF024658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="snueMTWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CF024658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dEM-0002HW-CJ
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:14:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBk-0004Se-0R
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBi-0005xJ-HF
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:47 -0500
Received: from mail-co1nam11on2125.outbound.protection.outlook.com
 ([40.107.220.125]:2574 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBi-0005wh-A3
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9up/hGd9tHE6N/1zQ3qKrB3Tdmrje0cARHXGmN8OrAw2wslT5HAjp5FOgijDrGizYIzwZCmt05qOSfUJuWzfzOPzCQMoQKNFwBu8tnCqKJK4wijxwd1TLTc7Wlx4t8Y5fIyKPatZ0igUn4GZe44cluzgDT+83vZwV/HdWwCYtxNLB3l3XWlgP1mtu4HAEl1s7nOahGhFtRkdg1auD/jC3oCQp9CteVMhDPv5/jQAz1phyhLby8tk/E1j1zX+pdZKZs/cvB4sK7oyyKqiXODMpqVg1S4fiY8suFm6Fp3mfTgTfLm582H7syLeQM3WWfQ1y0UYmfgJ9Vl2ZugecWfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EidSJguOjA9uQ8reMJ7rGZwKnYrZW8gHg9BjGSzrZk4=;
 b=cb6qg0tmQLYPELZRrY1lsN2kdm94RZJsw42p+5Ss1m5ynNv00eVz5RW8Qq9BD3pUEmUnkSqbiYgGLqvBz9112VRiiUevyZyTAJsbX8xwl2cHMbFK4iyVEKuNWTV3bHRFjFqrwK9CSi7UPV622bl0AKATcFG6KDipjGDsONLh7GpkoLIfYqlak1zhggzrtfFgv+bV7H/B84NcJtv4uddm7LcozPDtLjjvnPpKfB6ViDtYIWQc23tLypvpaUUuHhvV+O7xvhFAjXJRPuxrhstPC99Zwffe/kKnbSDcRFK31NJWtRx0+aiRBeln5fcDVDsQqe6Wp3WQXzVp8CEpbNdB/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EidSJguOjA9uQ8reMJ7rGZwKnYrZW8gHg9BjGSzrZk4=;
 b=snueMTWgPZcaFfV1J/LM4ouR8o0K1XZkyHGsKJqHotyKSpUYWm5wV+UKB/wxb3cj4/fI2EgUG9EzkigH2JZ/X4PZdXUrWJ005jvZyrmCg8XOjy5WnSWUAXFWU1k+EqdHXmA3ZrIDm2MhuAiPclSALzXpRlg+p+nKON+QncHqJc8=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:45 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:45 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 10/22] libqos: split qos-test and libqos makefile vars
Date: Wed, 19 Feb 2020 23:11:06 -0500
Message-ID: <20200220041118.23264-11-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220041118.23264-1-alxndr@bu.edu>
References: <20200220041118.23264-1-alxndr@bu.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:44 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c8f58cd-c41b-4691-4b0b-08d7b5baff8b
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB380762D08D8EA5EB0BD6F024BA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 031996B7EF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(199004)(189003)(36756003)(86362001)(81166006)(75432002)(8676002)(2616005)(478600001)(81156014)(8936002)(66476007)(5660300002)(6916009)(66556008)(66946007)(54906003)(956004)(316002)(786003)(6486002)(6666004)(7696005)(16526019)(186003)(26005)(4326008)(1076003)(2906002)(52116002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR03MB3807;
 H:SN6PR03MB3871.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHPHBxzCYaCfICeN1L9ksg0Qo1T+wxWkhZQsM3WAHr41cfsyY0IsNdZ+Z9brjo7n7dcHKJO3KnTCRinuseJEZdaOzKWFG/D2ZOlQBPk8Stdal9babFNTW3OdOqAa8qDQMDIa9ViXBB7xw1dDveJuihzuOxTpL43J5ac88a3QTa4WQ9vKBfyGNvGkWB1QxG+Hk61REup44Fm6k4SSog3KN9jSQs3x+IXamjFU4Xr7vzScU7d4aR0XWQ285UTTTL6Fv1D26Akov+DbXlQq7gU6pz4aWH5dANTPp37PAdVzdJzEY8+CKCgRQTZa6aVzYjDlqkkPXPv03A5FEjgiLG8z6/jnlCXxXa0ovhpygNjcrXkBK5K2c6rX9HU4WVuV6Y2o9Sb9GzNZc7FlLtoQXJ5IZhkp0peil2FMXjPnSp3uKVUDsfKprf3jnFcN35FakEIl
X-MS-Exchange-AntiSpam-MessageData: BUwAytvjbLDKQ1kC2/mw1r/UFN0bp819gRpKOOhghWIcRIXvmy9GmiNRITu0RgZLkYYT4kgHMOHVCXeKxrFac2bTOPPfdcZrx+eZeFrb415+bP8cj6+86GKM96xupQwSyEKE9191zgBxlfq5tGK8Pg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8f58cd-c41b-4691-4b0b-08d7b5baff8b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:45.4686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VP3QKAMorvcTIIL7Oq3IBCAq8cacjxxFluB0bQGjiFB87K635FMgB8zrMa8Cf9G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3807
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.220.125
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


