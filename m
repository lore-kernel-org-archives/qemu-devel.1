Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6364AC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2591F206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IxS9LWvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2591F206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT4yw-0006z3-St
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4vA-0008J8-Il
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jT4vA-0007nW-3p
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:39:44 -0400
Received: from mail-am6eur05on2133.outbound.protection.outlook.com
 ([40.107.22.133]:24288 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jT4v6-0007iF-4f; Mon, 27 Apr 2020 10:39:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfMZFv4rJKVixS9BlPVd0R8+vtqJpWsfr+qtfF3Y/s9cu6Ke3oPgVT/y4UWnEHiCAJXKdTxU0vhiQ6I4L2jJv2Wn4Pnar2l/aCFMOW1/XNf1qoynhB8niu4HpWLvbaAIQUd7CImwzcKTNOkAPZpFNvPBLtqmdlhj//Xmt0XBmqatAd/p4ZIOJL4i57hoGTQ8HysUQ46Opd6SQ1LNXwawwWV7j4lx2x7SgHmQfDXEOya2J5M/5L5spd1WcNse1/ifU5cyFiY9nxIjrrvj4VGD3v/zzw8SGnZ+33QljImrEACbL0DeIy2PM38rXLVW0PAhJfvdxvuUb3d4t/EIeJoJAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWf3gkufmonKz+QtUw5YgibQn493tksGtYBwyWswqGs=;
 b=ZzShixzUpyfLPgNVubDNaNbxEQ7Wzmj8fIlAeMeV96hkFCAHulaMUPbUFA6NbpAAMylc4ZQktUR3n9geXR6Hw6irxqu9fYKYPPzYlUOBrrIDL9mwWPM31gIyk7ulpGWjxKT70nSuPV7W7s2cQ6eOhvemfCBvHUfaUXI9tsDkCx3f+xC0uPY7XdhWldCMXn7h92L5xyshdiysu3esorAqxZ5bRgLwPe4yLlofEf9Bp+vdAQpUP2+w09ejD4N88Xdj7fptj7E1WVpizYrg9S2UrDV5SQQuiMDf7lpcSiZ9vpqO5uBJwnJxL6wioLb53PKXstRsXQwywjtmLSzc+GXJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWf3gkufmonKz+QtUw5YgibQn493tksGtYBwyWswqGs=;
 b=IxS9LWvqVhLrrLihDwnv1NYj6dkRH3ZGvVMRhObig6L6uHzYFgwEykx1xCB5rVM0bG61Pi0r/1f1YD20hLEXA8Pl4s1hzSxYRgZxvWpUFioXn3kYc12dDi3/TUDFS7E//vydgI4sUhSQSCnSWKuUOFUbf1+IVe7U0fw0216rmIo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5527.eurprd08.prod.outlook.com (2603:10a6:20b:de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 14:39:36 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 14:39:36 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 8/9] block/io: move bdrv_make_zero under block-status
Date: Mon, 27 Apr 2020 17:39:06 +0300
Message-Id: <20200427143907.5710-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427143907.5710-1-vsementsov@virtuozzo.com>
References: <20200427143907.5710-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 14:39:36 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca1149bb-bdda-4fa0-3d38-08d7eab8cf1f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5527:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5527B5757333BBFAB853E8B2C1AF0@AM7PR08MB5527.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(376002)(396003)(366004)(136003)(346002)(5660300002)(107886003)(316002)(2906002)(6512007)(478600001)(6486002)(66946007)(66476007)(66556008)(69590400007)(1076003)(2616005)(956004)(81156014)(16526019)(86362001)(6506007)(52116002)(186003)(36756003)(8676002)(8936002)(6666004)(26005)(6916009)(4326008);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8pKkRoSviTLu7TvSZn4ewKAaQTtaxuxQO6IkBqeDug3KUvU8k6gxA5yqXSHpkXulLz+q4/01QlY5mzsdWMs0rvLMzwpslKCDQ+yuRbcGOPIuIMLMFqn1YFSe2eqkUm292xsVJENWoYrSWoJMCfaZyVwvXIqPx0LQDAud3/ZcUkSY0r6ucWh67sFpbksd/Vyu5h+Oj+B7gYtKzuKgrlWFSGWKvR0dTnmTDLn/JpvnDhZBbU730TE6RlWPpj5o81iAclYcv7Ht2tq0PqmMxzmf/xc5XejL287iRgtGtPC26PLHGMWprtg5S8HBOTypVOr8l8wAuwyT+pJ0td/zb4b6evsBF9VGZEU0XIEZ3H+NY7jA5qwSioAqMr19ACjq3/EndVmLQEZ+LSkDiC2Q4PvV+/hLeYYBXL68Mx6N0B14NJL0r7iWOyF7S75vqu0cCORxBYwCUKgk8JPhOUjkx3eurNUtOglLLN68Z0yk58hFDP0e/a8/rZUxQ3OV2k03jEZe
X-MS-Exchange-AntiSpam-MessageData: 7SEJHIcN8JIWbaqbdO/faTTZ9BnIS1+Ndf9rSnhr3b9VlmfZFd1lO3NFrKDz6Naq+o9bCVBrZbC4fmCSz4Io+kXvG3Ax0WBXe54/t2ZyjpVYRpD/pSuwjMdOI8+s++uta0qfypYVXPdDo7OkdMCV3IIdzS3B+wP0smO+1rKvIupOxVfquYvqkGkkOfiGHSF7B/HSwUAO/Xysj343TDBvJYtwfmHOkE0o32lfdh3hTyNNLKYyyyzrzjoFjkGNEZqhP6KPS23J8bYPGhMlPeZZlOHS3xjVQrVwr9x1LBKWNaOxrN2QnaWRu0LF9HT7G+nQuG1lGmqnNYMW8smEvhztmHQtakj/Q1rGdngAFX6icn5WpNmdW3oHeeVrrRhqD99kFmXvPnqgq0NmgFBRuskPV9X7T8lrhiMv8l5+qLvChKFhgvIgq6SzAXaencizovNHdR+qFuxh/E6kcV7NYZG/1ikekKUwECEUm3y5GJKHelc4DwXSD8It1TfPqXqyGYbr90sarkL2CdHnVSxlwN+TT4B4oekazBf322d4GOmk8tL1FxYJol8YTOPIsj6xAvsBdqn7G7G4r7eIpvmitAH5k5RGti1ilhkmN454RjAhqrkXSAcrTRwddyp6sAzn4EvuZiUDWzfmcodAmaF7T/89odZ6ZHR4ttSJatkYZE/CeatfjR4umOlx3I8x01vXPSeYggPH2RDOVWYkmf0ey9cd/ufIsi+jf9DRJ5/r5CYefWFDK9FuzVfCDbgZ4TOzxdN6N4HK164C3JBIOHx03qoaCpIxV6q7MD8CLGR1nULobg0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1149bb-bdda-4fa0-3d38-08d7eab8cf1f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 14:39:36.7710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPM2fMFi0XiRwEWqjl8m8lloZ224qo+VoN16COzuBuBtJ822RMHnZr8Mh4pwTXv2KOzhVJhuQv9cHxQLEt43+y7GM9jT6zcSVdW+fHbnB54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5527
Received-SPF: pass client-ip=40.107.22.133;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 10:39:31
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.22.133
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to use bdrv_co_block_status in bdrv_make_zero, so move it
now down.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 82 +++++++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/block/io.c b/block/io.c
index e6a8ead46c..3bc0daec33 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2178,47 +2178,6 @@ int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
     return 0;
 }
 
-/*
- * Completely zero out a block device with the help of bdrv_pwrite_zeroes.
- * The operation is sped up by checking the block status and only writing
- * zeroes to the device if they currently do not return zeroes. Optional
- * flags are passed through to bdrv_pwrite_zeroes (e.g. BDRV_REQ_MAY_UNMAP,
- * BDRV_REQ_FUA).
- *
- * Returns < 0 on error, 0 on success. For error codes see bdrv_write().
- */
-int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
-{
-    int ret;
-    int64_t target_size, bytes, offset = 0;
-    BlockDriverState *bs = child->bs;
-
-    target_size = bdrv_getlength(bs);
-    if (target_size < 0) {
-        return target_size;
-    }
-
-    for (;;) {
-        bytes = MIN(target_size - offset, BDRV_REQUEST_MAX_BYTES);
-        if (bytes <= 0) {
-            return 0;
-        }
-        ret = bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
-        if (ret < 0) {
-            return ret;
-        }
-        if (ret & BDRV_BLOCK_ZERO) {
-            offset += bytes;
-            continue;
-        }
-        ret = bdrv_pwrite_zeroes(child, offset, bytes, flags);
-        if (ret < 0) {
-            return ret;
-        }
-        offset += bytes;
-    }
-}
-
 int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 {
     int ret;
@@ -2773,6 +2732,47 @@ int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
     return data.ret;
 }
 
+/*
+ * Completely zero out a block device with the help of bdrv_pwrite_zeroes.
+ * The operation is sped up by checking the block status and only writing
+ * zeroes to the device if they currently do not return zeroes. Optional
+ * flags are passed through to bdrv_pwrite_zeroes (e.g. BDRV_REQ_MAY_UNMAP,
+ * BDRV_REQ_FUA).
+ *
+ * Returns < 0 on error, 0 on success. For error codes see bdrv_write().
+ */
+int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags)
+{
+    int ret;
+    int64_t target_size, bytes, offset = 0;
+    BlockDriverState *bs = child->bs;
+
+    target_size = bdrv_getlength(bs);
+    if (target_size < 0) {
+        return target_size;
+    }
+
+    for (;;) {
+        bytes = MIN(target_size - offset, BDRV_REQUEST_MAX_BYTES);
+        if (bytes <= 0) {
+            return 0;
+        }
+        ret = bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
+        if (ret < 0) {
+            return ret;
+        }
+        if (ret & BDRV_BLOCK_ZERO) {
+            offset += bytes;
+            continue;
+        }
+        ret = bdrv_pwrite_zeroes(child, offset, bytes, flags);
+        if (ret < 0) {
+            return ret;
+        }
+        offset += bytes;
+    }
+}
+
 typedef struct BdrvVmstateCo {
     BlockDriverState    *bs;
     QEMUIOVector        *qiov;
-- 
2.21.0


