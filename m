Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29637C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC083206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BfXCTPtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC083206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTfyw-0002Og-50
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfw9-0005eL-VP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfw9-00027q-E7
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:13 -0400
Received: from mail-vi1eur05on2121.outbound.protection.outlook.com
 ([40.107.21.121]:61758 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTfw6-000240-IU; Wed, 29 Apr 2020 02:11:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACYW/Qa4yxHrINmUCpiqQaI62oaYcMuR/xPu9Cu0Wci/PD+LQpd/9QZ2rsWdJYwrmkGomKIjHaofEQhKtHkZ3mPnR1a1LhePTp3MLO4+VVVVR/t91rHUr3599oJZcq19NcsyH3zP1AExQmTGScVHHLryyNyY/FUbDlgRhE4khNzmOhN7AxcZ2n0yTT+NWUDO+BvV7/nwYn8twcyf1ReJbrpLqHJ4FI+wiY9JmUWZq7XX5MB2Tn3vJ2+QdrXwonC78vf8+Lv7IoRjt7vcaqIOtS340uCD2fccPloLrnOh9JO72AfWUeA2cDy9qC59NdHj8eXxLTBSrejeehSjkC9E6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbDSSgyfAn2eQ3B78rvdS9sD+o3H2ESB4pBZdgcChJU=;
 b=AopZMzq2/MDgD4qLaNRzpua6X9hmq9OTfcGW8sesJNZZLk5Quni3Rh5+tninoQL747+0Fb1pdb1q0POny/EbdTAqvWiQbL2fberhRXpgMFdiPuarP3yMp7oUVKpf7gs0lVPhqJ3Keidxo6iIs6wZdPTcTk1vMVOAdF10gVVDsSo9OaOz1iP8cbarzRrK/bj+2ER8pww4hft3oZ22KlUjDlrnHPFsRpS5v1frOWSOoQIIT9nZpf94CYMHaX+ShR9QOe5QhxpBCZ62ZhK7GB40krO9xOt1S4t4+zRotBr0Uy1mkh2RrhPnoQN1GpKP6tjbBGR4SuTf7B8mX92usvvJXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbDSSgyfAn2eQ3B78rvdS9sD+o3H2ESB4pBZdgcChJU=;
 b=BfXCTPtWYTkcORo6byFbY3J+fzQiI20Lr0fhvRnPvl6tH08oMnCsosYnsbUrhufuQVAwLRjYEzPUyxWdla1AxL2kOTeUqmYTYNil2eIy/jkPoFI+0cj0PvyNbq1T6uHDTPFAwQZ2gbjcuwBBauPPhM+O0VHA3ug9rvvf+UGloQA=
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
 06:11:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 3/5] block/block-copy: add state pointer to BlockCopyTask
Date: Wed, 29 Apr 2020 09:10:37 +0300
Message-Id: <20200429061039.12687-4-vsementsov@virtuozzo.com>
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
 15.20.2937.13 via Frontend Transport; Wed, 29 Apr 2020 06:11:06 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0acb8996-5843-4c6d-2719-08d7ec041a9a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53018509056283335E07C331C1AD0@AM7PR08MB5301.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-Forefront-PRVS: 03883BD916
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3YNAiDFudxtMTUCBxvbVttwYlZyskga7j8E0n0WSu9JajlFc3ywRl+HT+2zfXDL0DjE53+Em6gGiTzAH9IKImum6fznHvWMXHk3Vu23fKoDiGb9v01W6dO0tx5X83kSjffWWTOmpB2A3icQ6zUcREwNRM64pudREOkTOe9outcL7bnEjI3LjcJ191iPZQP6eWtnz7jT5bsy2TEQQ6pHQOw0of0QSMQXELAlgL/udzyPLVbU+beeiCh3zKMOob0/CCIosAxPmcI5Xt86xZ/dMEwhtyDbH+6CfVGk8g0sXxMYwpzJ6Gtd9zsszbTa1WC4JPH7Z/bUwgOlr8BmQQojRxfa0zScA8DR5GxOou8JaE+mqV2TzKQsIHkOEViZVlbgjKG8RMWama6foTtd71mqiqjCHj4hOLRSx6yOcilztN4TLuSSWiFKmuyklFhAxuepSDbGTvMwWumr1bnZQ18ARsZrmr0Al7dxeGeEHeoc5GUJI7q9g0ooBRW8vtDDA67O8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39830400003)(136003)(376002)(396003)(366004)(2906002)(1076003)(86362001)(36756003)(186003)(16526019)(26005)(956004)(4326008)(52116002)(5660300002)(6506007)(69590400007)(107886003)(6512007)(6486002)(2616005)(6666004)(478600001)(316002)(6916009)(8676002)(66556008)(66476007)(8936002)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: SPGVjCdZ4rLmlWk3OZvOYGg0er8w6B6rwCwRcOEYVaizD2Zivscmesxqsc6RtCz5EwGdK61/rBZH5E/OwimrnYxH+GkEAJjivj3CV7AuwM4wF8kzQAk+Q99WBetYs1HcyWvPdz0oSJaXWLKV+QKeALT6bQbwzZaDB2EgN7jAyQSnn7r4JPymhG4rrP+6PDkkeoQFeHaIkI6MEEd1n6fCQXGyzMK2Ma+uOybMHjzKy09hcXU7+CXF/flKYmobzzavEMVIMtukK5h7ZLtLFU2+wnjfrtJKdx7l3IdkdGpef+XIhLuvQjFDDvvkIF1II3TDaScR6OJl5jGhptEQ7re3GEaJs0TC8ibk1/TYv3i0Hg2k3aCvT0qBTNb3dzHpCxIQapfRzW3aF9kR7xxq3XyrCWBWJzuhAESpBLcKHjTuXBNmTVL1rgkUzCYDZ4pc/zkii09EslF49cL8pS/7VawdJ89ExZVb4s9sVZVL5FMSfNfJCSo5pIZcskrvmIqw7EwRmDatT+LFU9ahiIGrPnfOuDuw/1YuzSIJ0amJTaYF+GnmRGfvqKlPyIrIW1+Kja2ztKE6a43mmkVdEaNzaH/vv3DgCmxPhw7gFXvaUfetTgT54hyCTcoCiFU4NscYbSxVyKm60KKYKhaXnj8nNBqeL0bGY0Dgmfc0Y4IQsaY4AmvW8YHHTriNQvAxSJpUX7ndJH4cCWQevVkb1T1cNa/lw0dACjIGpk2oKX4kJn+bSdo5+6mAyLhYFytziQYYFuxlEXQWQpcA3LtitbRfd9DcMDvCgPCbNFuPFdpjHEZ02GQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acb8996-5843-4c6d-2719-08d7ec041a9a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 06:11:06.9008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rApIw2+7ts60Kb0wINO1MeP8h4lwYMrKU+LHNUMxZJeHY+dwN9csLEkEsRC22bYPjqHqQGzAOeRmhR+iptlL+7VIJPRR2saYA9+zc513Rj4=
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


