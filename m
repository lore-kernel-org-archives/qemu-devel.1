Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11580C34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB30A2465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 04:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="vvPS9cuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB30A2465D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4dKT-0003uE-16
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 23:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1j4dBj-0004QY-Al
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1j4dBi-0005x7-0W
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:47 -0500
Received: from mail-co1nam11on2125.outbound.protection.outlook.com
 ([40.107.220.125]:2574 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1j4dBh-0005wh-Po
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 23:11:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRhaQeetz1rME/WsCKe0xQj0wr82DwuJjb3R3I+Ut9UZtHcp5mordANnh1VyOS4uN6k8RPtggtrdwrtI+0XBYbYg7CmB5gMh6Y8EfkeP6SXQOpoQmJ8ry/ZKsKbACDGO9sElz+wt/ETlZUD/GLG2CawyIoMHznkjx/7meKkLhwwFk0DUtRZu6KMPXMNFTjLntZ0BDtPf9/SP2UmcgsJXHoW+8xCazid2J9eZkTtMc0NFdQ5vSGiYFsRO10ixC3MZwPkB098Ha/cZH91iCXKnSz2aSiLg1+cqhjwTHjBQAV5v30R5ada12/FRVne/AaD1mIr74AUg1nswevGYMg6zAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YXO4KxSPPP4hgjTRMldQ4BoMfOC/VUpzyw0Wj+2Xdc=;
 b=n3bhz16Mi8II33ymzs4/jG9aXNMHsUwxvi7X0xGYstwSbQ88CMy+nSnBx/XFMiI1AXwDgE6524IZboCu6PHhSCWfQ/Yxc10HxVeSVtGHCTMBnXh9B1rJTD1VKXgVRjE6bH6s57B8W5odayoKDk44UFE98BF8wr+uBi+6Jag1IjHqPvTkKayfieFZe2l03OHdp59Pjxt7ycTlhZioaWRGB8+k5JPAyzvQ3Ryclal93hr+jweaFBNa16NjotJMMBMkJDAezGhE6tWgLNyoq2B4XCTbMQ7OobsaG/w21IDhJ2Z5zUJ+2xKNJCofBpNeV0KKJaAoHZpBOzu35wp6+IoIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YXO4KxSPPP4hgjTRMldQ4BoMfOC/VUpzyw0Wj+2Xdc=;
 b=vvPS9cuCGIes+bhaqY32J8mma5tkz1nSTfvpobrLsCZpQoafYQUC3Bj5OiekfPj+FyGBwBKspjQiH8duZz3cZsCMakfleNw0bd9NpDg5SAFOzENxvF+o/xu0dxcAML6ByXjl8GiCs+CUzHBLLIFrnEee4xIVwHRW4mfyCvRPphk=
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
Received: from SN6PR03MB3871.namprd03.prod.outlook.com (2603:10b6:805:6d::32)
 by SN6PR03MB3807.namprd03.prod.outlook.com (2603:10b6:805:6a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Thu, 20 Feb
 2020 04:11:44 +0000
Received: from SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8]) by SN6PR03MB3871.namprd03.prod.outlook.com
 ([fe80::9c11:10cd:6e97:bbe8%7]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 04:11:44 +0000
From: Alexander Bulekov <alxndr@bu.edu>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 09/22] libqos: rename i2c_send and i2c_recv
Date: Wed, 19 Feb 2020 23:11:05 -0500
Message-ID: <20200220041118.23264-10-alxndr@bu.edu>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220041118.23264-1-alxndr@bu.edu>
References: <20200220041118.23264-1-alxndr@bu.edu>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0048.prod.exchangelabs.com
 (2603:10b6:208:25::25) To SN6PR03MB3871.namprd03.prod.outlook.com
 (2603:10b6:805:6d::32)
MIME-Version: 1.0
Received: from mozz.bu.edu (128.197.127.33) by
 BL0PR0102CA0048.prod.exchangelabs.com (2603:10b6:208:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Thu, 20 Feb 2020 04:11:43 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [128.197.127.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44458d61-3f77-444d-c138-08d7b5bafef6
X-MS-TrafficTypeDiagnostic: SN6PR03MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR03MB38079908E5C108AA05A8A48DBA130@SN6PR03MB3807.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
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
X-Microsoft-Antispam-Message-Info: 3+uANi6RwOdDrdNFgLrJY9Yzc41aRBi7tMBM7CHlZY843RpTl/XY6A/nIazJlYqkXdRC14p/G2NM49Meb2b7Oc2hRdfuVASO0ymWznEUlm6nae6+OEHaL+ec6LsPrwRm6/0Tc5JkLBAC41g70UKuZD9ayYmqSXign3wicxxHLQaMSS+Fn1hxa11eUkkyFMHJ+bwH4/5/j1GU2gYVcB9xbFmP1drBMTOphxnxKwslcJiwK4Se6IZVJ/aGoGbJ5Q2nA95Z6szKyRq3diUS7LqyoEB2yQd0QoraPmPRlX4WUQ8sCBF7BRP+JizOpU2tqSf3Bhswj0hr4ZoK+EBY7ZAVSOVJr3+E0b1zqlwC9N6MuXX+tE/uK970WhCXPR3rlb2/tRtpG9bOvI6UDP1OysASkP5Rn8f7z10dx7G7Bc5qzSwdyeQ8HeA58XlSmePvUbhX
X-MS-Exchange-AntiSpam-MessageData: x7eZx84WryVQrpjQrU5K5af71TvBf2jhZ9C6Hj/FUmJ6eua9bOV/7slaiSFlA/+128HpO5YZEmpFC0TqSylziWo/BcogeD/EnOg5K5qGEdhMrtPzm5uLwcTiwpHGegqBrQOmffBUuHKeZp35Jq1xbg==
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 44458d61-3f77-444d-c138-08d7b5bafef6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 04:11:44.4891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: va060kG9o2iFv4LoQgYGn1uwuzn92J8XdB7LUeG57WDwPjhgP+UO5J+ouSFNJBEY
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
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The names i2c_send and i2c_recv collide with functions defined in
hw/i2c/core.c. This causes an error when linking against libqos and
softmmu simultaneously (for example when using qtest inproc). Rename the
libqos functions to avoid this.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqos/i2c.c   | 10 +++++-----
 tests/qtest/libqos/i2c.h   |  4 ++--
 tests/qtest/pca9552-test.c | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/libqos/i2c.c b/tests/qtest/libqos/i2c.c
index 156114e745..38f800dbab 100644
--- a/tests/qtest/libqos/i2c.c
+++ b/tests/qtest/libqos/i2c.c
@@ -10,12 +10,12 @@
 #include "libqos/i2c.h"
 #include "libqtest.h"
=20
-void i2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
+void qi2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
 {
     i2cdev->bus->send(i2cdev->bus, i2cdev->addr, buf, len);
 }
=20
-void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
+void qi2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
 {
     i2cdev->bus->recv(i2cdev->bus, i2cdev->addr, buf, len);
 }
@@ -23,8 +23,8 @@ void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t =
len)
 void i2c_read_block(QI2CDevice *i2cdev, uint8_t reg,
                     uint8_t *buf, uint16_t len)
 {
-    i2c_send(i2cdev, &reg, 1);
-    i2c_recv(i2cdev, buf, len);
+    qi2c_send(i2cdev, &reg, 1);
+    qi2c_recv(i2cdev, buf, len);
 }
=20
 void i2c_write_block(QI2CDevice *i2cdev, uint8_t reg,
@@ -33,7 +33,7 @@ void i2c_write_block(QI2CDevice *i2cdev, uint8_t reg,
     uint8_t *cmd =3D g_malloc(len + 1);
     cmd[0] =3D reg;
     memcpy(&cmd[1], buf, len);
-    i2c_send(i2cdev, cmd, len + 1);
+    qi2c_send(i2cdev, cmd, len + 1);
     g_free(cmd);
 }
=20
diff --git a/tests/qtest/libqos/i2c.h b/tests/qtest/libqos/i2c.h
index 945b65b34c..c65f087834 100644
--- a/tests/qtest/libqos/i2c.h
+++ b/tests/qtest/libqos/i2c.h
@@ -47,8 +47,8 @@ struct QI2CDevice {
 void *i2c_device_create(void *i2c_bus, QGuestAllocator *alloc, void *addr)=
;
 void add_qi2c_address(QOSGraphEdgeOptions *opts, QI2CAddress *addr);
=20
-void i2c_send(QI2CDevice *dev, const uint8_t *buf, uint16_t len);
-void i2c_recv(QI2CDevice *dev, uint8_t *buf, uint16_t len);
+void qi2c_send(QI2CDevice *dev, const uint8_t *buf, uint16_t len);
+void qi2c_recv(QI2CDevice *dev, uint8_t *buf, uint16_t len);
=20
 void i2c_read_block(QI2CDevice *dev, uint8_t reg,
                     uint8_t *buf, uint16_t len);
diff --git a/tests/qtest/pca9552-test.c b/tests/qtest/pca9552-test.c
index 4b800d3c3e..d80ed93cd3 100644
--- a/tests/qtest/pca9552-test.c
+++ b/tests/qtest/pca9552-test.c
@@ -32,22 +32,22 @@ static void receive_autoinc(void *obj, void *data, QGue=
stAllocator *alloc)
=20
     pca9552_init(i2cdev);
=20
-    i2c_send(i2cdev, &reg, 1);
+    qi2c_send(i2cdev, &reg, 1);
=20
     /* PCA9552_LS0 */
-    i2c_recv(i2cdev, &resp, 1);
+    qi2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x54);
=20
     /* PCA9552_LS1 */
-    i2c_recv(i2cdev, &resp, 1);
+    qi2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x55);
=20
     /* PCA9552_LS2 */
-    i2c_recv(i2cdev, &resp, 1);
+    qi2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x55);
=20
     /* PCA9552_LS3 */
-    i2c_recv(i2cdev, &resp, 1);
+    qi2c_recv(i2cdev, &resp, 1);
     g_assert_cmphex(resp, =3D=3D, 0x54);
 }
=20
--=20
2.25.0


