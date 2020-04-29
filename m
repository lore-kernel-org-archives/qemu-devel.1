Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8679C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3ED2072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GN9POb6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3ED2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTg03-0004Qg-J9
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfwA-0005fo-Ld
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfwA-0002BD-1q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:14 -0400
Received: from mail-vi1eur05on2121.outbound.protection.outlook.com
 ([40.107.21.121]:61758 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTfw7-000240-Gu; Wed, 29 Apr 2020 02:11:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxggDYziOBwH01rJ9PsGg4GhONW0Gz2z2AinwADu+o1TMwFfl8U4kVKxtM1c6g7SBNp9XDfCLeMqXMIdYNoAeRA8kKMzcSiPgoNXo2vecTVrPWKSMeJhTI68k+m5BCc9nksmqKIoNn1zXLxYHKhSeRDpqh/CSlqir+ItaXHTBvQF7BOIRqg+PEAoz9/I2J2hSQwPHPpmwn0Hn1xBhHA39NxnUocEk5S9GZBK1x32Is3OIGIEjxD/q7hg0d6Hevf2L1IATq+X7DCHiYjdj0LKhpdygJcHkyzSi6lV9jYcx8Zm7x9zWmMirGCRxrdopEYFevw3ofrLL6UYBc1lLJj+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndLM+pDrRi2zXlSAdNs7jK9RIu4e1Dymp/VaFhvDmVg=;
 b=cTqOeS+SORrIMOqqRP8p1sX4BYYnl+xytOdgm7r1lF/4yZZx3XiuTDPIxmgKxBuK32FtfCIg7+/dbLl3ZihbefwyK9zDFAxckPnhUL6vAZ5yKE0R65+i6C4rTgMf43rKCAXSkrPPQPSdTmluPhSwjkcfo8HnSG4QZM4hmiXl5whn5RaTqgDnujxyVijLLoDYACI9SM8RlY6ikrcD16XjzZ72GAFm85n9VdNHXPP+SaOfXvDv5qCkMMF1FrnF7WWWgVpOFBCOzXVZ16O2zgaT0aTJBMirdEgNjuzaShRymgkf+NUGNgh81Tt2rG72d7P0rF0px8P7MMP2D325xKF5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndLM+pDrRi2zXlSAdNs7jK9RIu4e1Dymp/VaFhvDmVg=;
 b=GN9POb6Kmi6gLuVPh0J9vtRiZbQZ74J4Ti0hHifdM2t3bt1Wbk7Nsr0/72TtierzzZQCra4oT8d5j3blqR71foZLayjxoMfj+lj4jLOYV2I3vrKfCjofyV98Oqg5ui0er+cNMU2tGw1k3njMr7eaj2DbKwcoMitJJisDKgm0NwA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5301.eurprd08.prod.outlook.com (2603:10a6:20b:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 29 Apr
 2020 06:11:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 06:11:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 4/5] block/block-copy: refactor task creation
Date: Wed, 29 Apr 2020 09:10:38 +0300
Message-Id: <20200429061039.12687-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200429061039.12687-1-vsementsov@virtuozzo.com>
References: <20200429061039.12687-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.184) by
 FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Wed, 29 Apr 2020 06:11:07 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f9fc520-e3f1-4cb7-8304-08d7ec041b15
X-MS-TrafficTypeDiagnostic: AM7PR08MB5301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB530174A594B7BF142AD8C3A4C1AD0@AM7PR08MB5301.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-Forefront-PRVS: 03883BD916
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5L247MwYZonMRb6DZEiz83fOBjvRB6emp1N/pzxxq86k7lWGtxkR3Bgy22tRIeSefPbFaPOZAeHLIDNi/DdZnv10dakJrxdirunLQSgXhxqYT/thW4OgPtsB9K1XqSzA8lr9GJseyGndHzwMhP+t6AgNXnumd5W5JUfHGQrsVjQH6Li/wF68tjImeiJWMhbAHnIGtUsDUwSTwFk+Hk8VMaY4kkKni2isGUu4kaRT3IVAaCPY8WfIocy27rbeOOelU1G7n2lPEPnQMwhcGeSX8LouyOcKCad7fCEoD4yAsu2W4vpVeJjYuLWNuQHqFZlvqIopbFl3t/cHC8HfWzZ7Aia5GPF58tA/kFqLGouR605is1zChZN07qq3KJuuzNUatMnNzrf+sVvNUHkXFzpEAhO+L7QLab0M4IhZKNVy/CODrcvvAd3nsPe4L5lrteMvPL3K9i5YCiHI5VVNzGb44+zZTmwFNSLQde4/n+OQ2xitrB1KvmdqliXYFcHrnvgv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39830400003)(136003)(376002)(396003)(366004)(2906002)(1076003)(86362001)(36756003)(186003)(16526019)(26005)(956004)(4326008)(52116002)(5660300002)(6506007)(69590400007)(107886003)(6512007)(6486002)(2616005)(6666004)(478600001)(316002)(6916009)(8676002)(66556008)(66476007)(8936002)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hv8yU+bA6oodu9XMeze4BxjZj0sVhQqwDv/kyZiSLUG3jhDMa8ict1ZlAEGw65xXjZENXi8Sq+ylnNN6ai5cXt71ItH85k2tnL1jaRxAlTbWrH/L7tEQuDn2oVDiJHvRDUQjXQ6Qn5nq6vZNPYDrEArqgfaWM158VuOCDlshmcmTL1Y5o1UAJ+ure2Z1xg8CvthcFTltMrpl0lgj9TRFvWuo6JAYLPxY7FzD5AP6mUvjVtzPxFW7Saj2tE1n7w1992XRtz+Ius1gPiDHflLlCjdeQUQnNbRHQZGMw8yTzYJGcWtezsCaFAi1g2/Y1NL2EguPqU3AM94B2gpfCcmvvlGGUIPBusrM3qyG8wU6QAOrTCFrbUBhv74dcUasYqvk3bI52H5p0CeZWIZWHvATMcnkgm0LbU4c4n9meMwYPsXGeAo/VwoX0yMo5xT6K4swDkUyz2P3Op83w2dtMVOdsIIimbzdbqVWhqJACSZUYrJ2WiNpj87pJ3bWXu8KLBsDHb9UJgIE6XjYJSuSGDkQuvHPKYK/7JvrpcTAy62mIuVaqICIPCZzferP7aN5vT3qHSUwnCUh/nxXTuAFD9z67iN8s2upvzCQSs3pzc3/D7y/owUrV3TxEKBJ0xbjer1bz/p8BeyTx/W4G+/IcxMdC6aNSMRzun85DUnszyWZ3aMqOEbXqHjl/c3+so3m3qzEtlFNFEzwRVS6sYwnCdwFz6M4yk4fDzHohvxU6cI8McH9mA86zpv7HZVc7OlynW3cYUEL8+muyZc4hNOYPE1fZAxOmdIu25G1n5lZftTF5/8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9fc520-e3f1-4cb7-8304-08d7ec041b15
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 06:11:07.6594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfnjBD6iPR8WrtYGL6dVievlu6ljyMEDEldC/XAnO9alfo7Ipr5i1vbfXWAkHCA44Mrs9WqIR8a9kmRQaUbz84nIPKtRsnfTXrJzb9vBdjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5301
Received-SPF: pass client-ip=40.107.21.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:11:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.121
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of just relying on the comment "Called only on full-dirty
region" in block_copy_task_create() let's move initial dirty area
search directly to block_copy_task_create(). Let's also use effective
bdrv_dirty_bitmap_next_dirty_area instead of looping through all
non-dirty clusters.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 78 ++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 35ff9cc3ef..5cf032c4d8 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -32,6 +32,11 @@ typedef struct BlockCopyTask {
     CoQueue wait_queue; /* coroutines blocked on this task */
 } BlockCopyTask;
 
+static int64_t task_end(BlockCopyTask *task)
+{
+    return task->offset + task->bytes;
+}
+
 typedef struct BlockCopyState {
     /*
      * BdrvChild objects are not owned or managed by block-copy. They are
@@ -106,17 +111,27 @@ static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t offset,
     return true;
 }
 
-/* Called only on full-dirty region */
+/*
+ * Search for the first dirty area in offset/bytes range and create task at
+ * the beginning of it.
+ */
 static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
                                              int64_t offset, int64_t bytes)
 {
-    BlockCopyTask *task = g_new(BlockCopyTask, 1);
+    if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap,
+                                           offset, offset + bytes,
+                                           s->copy_size, &offset, &bytes))
+    {
+        return NULL;
+    }
 
+    /* region is dirty, so no existent tasks possible in it */
     assert(!find_conflicting_task(s, offset, bytes));
 
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
     s->in_flight_bytes += bytes;
 
+    BlockCopyTask *task = g_new(BlockCopyTask, 1);
     *task = (BlockCopyTask) {
         .s = s,
         .offset = offset,
@@ -466,6 +481,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
 {
     int ret = 0;
     bool found_dirty = false;
+    int64_t end = offset + bytes;
 
     /*
      * block_copy() user is responsible for keeping source and target in same
@@ -479,58 +495,52 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
 
     while (bytes) {
         g_autofree BlockCopyTask *task = NULL;
-        int64_t next_zero, cur_bytes, status_bytes;
+        int64_t status_bytes;
 
-        if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
-            trace_block_copy_skip(s, offset);
-            offset += s->cluster_size;
-            bytes -= s->cluster_size;
-            continue; /* already copied */
+        task = block_copy_task_create(s, offset, bytes);
+        if (!task) {
+            /* No more dirty bits in the bitmap */
+            trace_block_copy_skip_range(s, offset, bytes);
+            break;
+        }
+        if (task->offset > offset) {
+            trace_block_copy_skip_range(s, offset, task->offset - offset);
         }
 
         found_dirty = true;
 
-        cur_bytes = MIN(bytes, s->copy_size);
-
-        next_zero = bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset,
-                                                cur_bytes);
-        if (next_zero >= 0) {
-            assert(next_zero > offset); /* offset is dirty */
-            assert(next_zero < offset + cur_bytes); /* no need to do MIN() */
-            cur_bytes = next_zero - offset;
-        }
-        task = block_copy_task_create(s, offset, cur_bytes);
-
-        ret = block_copy_block_status(s, offset, cur_bytes, &status_bytes);
+        ret = block_copy_block_status(s, task->offset, task->bytes,
+                                      &status_bytes);
         assert(ret >= 0); /* never fail */
-        cur_bytes = MIN(cur_bytes, status_bytes);
-        block_copy_task_shrink(task, cur_bytes);
+        if (status_bytes < task->bytes) {
+            block_copy_task_shrink(task, status_bytes);
+        }
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
             block_copy_task_end(task, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
-            trace_block_copy_skip_range(s, offset, status_bytes);
-            offset += status_bytes;
-            bytes -= status_bytes;
+            trace_block_copy_skip_range(s, task->offset, task->bytes);
+            offset = task_end(task);
+            bytes = end - offset;
             continue;
         }
 
-        trace_block_copy_process(s, offset);
+        trace_block_copy_process(s, task->offset);
 
-        co_get_from_shres(s->mem, cur_bytes);
-        ret = block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
-                                 error_is_read);
-        co_put_to_shres(s->mem, cur_bytes);
+        co_get_from_shres(s->mem, task->bytes);
+        ret = block_copy_do_copy(s, task->offset, task->bytes,
+                                 ret & BDRV_BLOCK_ZERO, error_is_read);
+        co_put_to_shres(s->mem, task->bytes);
         block_copy_task_end(task, ret);
         if (ret < 0) {
             return ret;
         }
 
-        progress_work_done(s->progress, cur_bytes);
-        s->progress_bytes_callback(cur_bytes, s->progress_opaque);
-        offset += cur_bytes;
-        bytes -= cur_bytes;
+        progress_work_done(s->progress, task->bytes);
+        s->progress_bytes_callback(task->bytes, s->progress_opaque);
+        offset = task_end(task);
+        bytes = end - offset;
     }
 
     return found_dirty;
-- 
2.21.0


