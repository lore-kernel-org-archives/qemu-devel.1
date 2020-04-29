Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12736C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31E72184D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="sEMytH3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31E72184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTmWc-0001xg-UB
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmV9-0007zT-5x
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmV0-00085Q-Oe
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:11:46 -0400
Received: from mail-eopbgr80118.outbound.protection.outlook.com
 ([40.107.8.118]:18917 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTmSn-0007bZ-6x; Wed, 29 Apr 2020 09:09:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lr1mqp7i6oDIS8WIPp9Dro1daO8uH48jISoD5cWLVIm7OmUOJ8guaO5qCpoOgZOLgXXi74auAeoZ+xG/lH2Nyc1NSPs3BLHBbUDDWndIBsCLSdyent4Xi+Vpnsdx8XwtXN011jrjT/POZfpjpwEoObX0R9yih0GIFD1snP574aWcELI9y58RqzPMWkDa6Nlq+qCJMsD/o2a03b1vr2CgzmCHh/QVTta836hC+hSKWyKu4KAhhSHamBPbwbGFMFGwavwLuaL4oYlH4H31GUsIpoKpHTBLBb1ZfwCyHabGWAgOgDBaFOydgRmShllCQ57w+2gbkYR660YqkKfNSJrRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbDSSgyfAn2eQ3B78rvdS9sD+o3H2ESB4pBZdgcChJU=;
 b=mgPIKJS1Nj84TRyLIqrCQMcjtCA58zHyfXGZytmy9lQZCU+BvJkAZu1xcyImAq1igPGNFa3JKqD8YShN21iLEFG8vMK8+TjLbI33lBUg7LmxJnSZkqbeO8QQRTEspwu0es0fU4YQtJ2OCunipfmZFOiw+k4ZVUW8VZLzr8ZodUMpufjQBaVZsI/u1HlaDpOVmsC93di2LgtGqIByrIRS9/7aDX8ZWxbqo89UPId4pZ/JXgsDKxEpqqQ+PGpXy8jYYfFR3ofymq4Kc7XHTa6xA0j84Yi83zMnaCUeYFYAHl3b7F9r77SiNA8kHS2xHkegiy7Leml4z1O5klEQvUiQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbDSSgyfAn2eQ3B78rvdS9sD+o3H2ESB4pBZdgcChJU=;
 b=sEMytH3tRMq0iCGiT3GZHjaLLoujx9C+zZWc+GJ7BrC6WyXSXpaqDx+D6W8PfgK9Grpv9DhmlofUW1dXTK5GMdrtVFagMLMYagWI7WRB2P6hUr4SCLNMLkB50Q4CBIqkoLRDOOjQ96/zgshnnZEhLy3VtiPvMz4dernHNrG1/es=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5446.eurprd08.prod.outlook.com (2603:10a6:20b:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 13:09:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 13:09:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 3/5] block/block-copy: add state pointer to BlockCopyTask
Date: Wed, 29 Apr 2020 16:08:45 +0300
Message-Id: <20200429130847.28124-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200429130847.28124-1-vsementsov@virtuozzo.com>
References: <20200429130847.28124-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:208:122::44) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.184) by
 AM0PR04CA0031.eurprd04.prod.outlook.com (2603:10a6:208:122::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Wed, 29 Apr 2020 13:09:15 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a721c68-2416-48a6-8d47-08d7ec3e850f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5446A79052324E16F6CD37ECC1AD0@AM7PR08MB5446.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39840400004)(366004)(396003)(8936002)(16526019)(2616005)(107886003)(6512007)(66946007)(66556008)(66476007)(316002)(36756003)(6486002)(52116002)(5660300002)(186003)(6506007)(26005)(4326008)(956004)(1076003)(69590400007)(478600001)(6666004)(86362001)(2906002)(6916009)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2xiVl1IbhPFZGWYP/QxpoSg+9ZUoiUG/nj6WjzdzuFUPgEX2S5B0QNwXR8AhxDGEThBo6CkULjJNRWCDw7WwtZOSf+rglBY1+hBoP7KNfcwMpTUH3GfntgF3XIySOklHfo5atBJAO4158rG+uvj4ERWqbByEFxaiXpAcXqPbX9sgj5As4oIKyaWRcZ6cEoOaiDV98L/1GVIusN9Aesj8S4h39by8bH+ul7Dok20NumSad8lhCsfpp3UiKW5dNS7n8yK1hbhJRDiINCpioIpVNLceT25A6DZCH6+qEyNr50eWmtiX3FbGhGBr0haOzA8d5e2TXQlvFxuqRttfXeLKqwj8DKzfUaDqzRyJhjCCsb4i2FioqCWlCejqZ9ffpn/1e2gvBDth9HjvO6E3Jnwr7XxiumM9PdZk1fFWlfNMIMQfTIhvY8XPGT81HFBtSw0vCx2/gree9eCxrTFNwyGfjm4JOd0rEVsZtlJ3byKIyzdIjN0/c7q6NMPlaEEB/d7
X-MS-Exchange-AntiSpam-MessageData: ZzfW4dJDWKn2bPuyw1r5f7m6pvW9qJqdGXM/ktRJK6084F0t196rt06JZP0VHmSA/dTWAB+T7YzA0xdvnK+pQSvw2wxwBeBdosgfWnFJ2dwb1ieat9h7RYNWJBWFQYALf1qUh+MNhXcXDdSJ14LEgZ2hmK7e1O8jUZasSLQ3m+h+r3LsEReYpTh93Cu/+1zlOuBShj1deW4MIwacaAp1fh2PZgaA1jx5kmU22DMAhRSI5GhTpPFZlX89H2UDoledyuz7QiNeXS3ZL+EPdnEjAdCCD1yz05VOCUNwL7QCp4NdPCml89aAt0e7fZttQ9ryHzsJuHLouqEeSYQv/S3YgaS9HW4wdlv4FeuzVuofSrjyah7C0qfPHzjSLhzia16VcdfWxq5LVABpneUpfiDY2dutd7lV1e3LoNah4AJSw+QCEbJ1NPy5xTmuGWfegj+hhi7UBETMv5crXlB636wKSsDAOcyuuZkY1pmi+8RcUtW34D/dJN7PGPXba0hn0y/LRmJIC6sjgEPYGyT/qgCK08myOCcMoSCwiWZ0qJhoeuLhYb63IYyqMWUawJ8/METw1qAaAguQSwoWCgKcUqhW9Ptv1QyLuDHd8CXrBwdrjIMBUHLk5P/TAiTid03UhZI8eww5UF+4obJx+2ugxqxFynmMtptGcihGEc/xEQRKPfGobdTGck16TYXahp1P7iJJEbY1dVn2C/LRHq8FfU/E6MaB6vmVFlptU6BMp5GPouO3089oXEZDs7fbOCus6vVbsn71KTAv5QwU4mbmBAmHuQo10zpAHn+VahZiyA2jBUE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a721c68-2416-48a6-8d47-08d7ec3e850f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 13:09:16.2333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZrxqNaBPxMFnVQygttj5tRxvwMMWELfQgpyEXYPE6xMl8weufS/pko+WaXpsOB2uPRP0Tf08nHrvUIIXBE7XAoxEW8oDJks9bdGEwzS8rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5446
Received-SPF: pass client-ip=40.107.8.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 09:09:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.8.118
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

We are going to use aio-task-pool API, so we'll need state pointer in
BlockCopyTask anyway. Add it now and use where possible.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 8d1b9ab9f0..35ff9cc3ef 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -25,6 +25,7 @@
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
 
 typedef struct BlockCopyTask {
+    BlockCopyState *s;
     int64_t offset;
     int64_t bytes;
     QLIST_ENTRY(BlockCopyTask) list;
@@ -116,8 +117,11 @@ static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
     s->in_flight_bytes += bytes;
 
-    task->offset = offset;
-    task->bytes = bytes;
+    *task = (BlockCopyTask) {
+        .s = s,
+        .offset = offset,
+        .bytes = bytes,
+    };
     qemu_co_queue_init(&task->wait_queue);
     QLIST_INSERT_HEAD(&s->tasks, task, list);
 
@@ -131,8 +135,7 @@ static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
  * wake up all tasks waiting for us (may be some of them are not intersecting
  * with shrunk task)
  */
-static void coroutine_fn block_copy_task_shrink(BlockCopyState *s,
-                                                BlockCopyTask *task,
+static void coroutine_fn block_copy_task_shrink(BlockCopyTask *task,
                                                 int64_t new_bytes)
 {
     if (new_bytes == task->bytes) {
@@ -141,20 +144,19 @@ static void coroutine_fn block_copy_task_shrink(BlockCopyState *s,
 
     assert(new_bytes > 0 && new_bytes < task->bytes);
 
-    s->in_flight_bytes -= task->bytes - new_bytes;
-    bdrv_set_dirty_bitmap(s->copy_bitmap,
+    task->s->in_flight_bytes -= task->bytes - new_bytes;
+    bdrv_set_dirty_bitmap(task->s->copy_bitmap,
                           task->offset + new_bytes, task->bytes - new_bytes);
 
     task->bytes = new_bytes;
     qemu_co_queue_restart_all(&task->wait_queue);
 }
 
-static void coroutine_fn block_copy_task_end(BlockCopyState *s,
-                                             BlockCopyTask *task, int ret)
+static void coroutine_fn block_copy_task_end(BlockCopyTask *task, int ret)
 {
-    s->in_flight_bytes -= task->bytes;
+    task->s->in_flight_bytes -= task->bytes;
     if (ret < 0) {
-        bdrv_set_dirty_bitmap(s->copy_bitmap, task->offset, task->bytes);
+        bdrv_set_dirty_bitmap(task->s->copy_bitmap, task->offset, task->bytes);
     }
     QLIST_REMOVE(task, list);
     qemu_co_queue_restart_all(&task->wait_queue);
@@ -502,9 +504,9 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
         ret = block_copy_block_status(s, offset, cur_bytes, &status_bytes);
         assert(ret >= 0); /* never fail */
         cur_bytes = MIN(cur_bytes, status_bytes);
-        block_copy_task_shrink(s, task, cur_bytes);
+        block_copy_task_shrink(task, cur_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            block_copy_task_end(s, task, 0);
+            block_copy_task_end(task, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -520,7 +522,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
         ret = block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
-        block_copy_task_end(s, task, ret);
+        block_copy_task_end(task, ret);
         if (ret < 0) {
             return ret;
         }
-- 
2.21.0


