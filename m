Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7D9C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A51F20656
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AFCKLEES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A51F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTfyO-0001ZP-BR
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfw8-0005ar-4u
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTfw7-00026e-FH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:11 -0400
Received: from mail-vi1eur05on2121.outbound.protection.outlook.com
 ([40.107.21.121]:61758 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTfw5-000240-Iq; Wed, 29 Apr 2020 02:11:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F06Wi9s12zUudKkKhNKdlW4DtO+fhvNDLN3N00R9pzZyTYQuNSTeq188YLx7clrE6dwyQI1QkYdTIV+Nq9ACFpkFDUYnEjLqZJIz8V1kAkPp8eEbggXY1056EZUzZg4I6v/o1aA/2+89jEbAmCh8zqj522OY5Ffatzj1PVL0lDQu3xHmHvDYA65qUPlv/7Aejdi+VGU2/OdF4sGwPkHTfSIjTe6Pbr34L8lQlO8LbbU6WHCWpG7gdAsfxexHRW6n298c2D4SPtk2G1wDzSsiASuIK+YfecJu5iQQsfLoVoTYEIv1qYYVj4VL46s4hOfUX8kKjTp6ASKOCLhsAEuY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FseS9y9dE4GNUMXB/bqW54x6DCElqlOU+2wOmVvQJdc=;
 b=UenBraikBtLqRUiHcIrtrm5JS89edWpifU5QlvdODxO0eTUWhLph2D0vSaMDKj97OX1eWlcS+24jdLN/1wnxy7LvkI3Ogf9m4Qg7jEsGZsxps60or3yPCISP9trJuUw1jyqSK+Myb/qCVBHtO4titsiPA0qICVjgcFduODV3iMoXXp2ttV8YUa/R+pzBWDppGNWw7SQnhPRbgaTOt2tgcIxb6aesJb93Vq2LNUglm6pz2sQexeIcCVpMquVMc9hG3MDHNYoxBnTodVxI9j+f3Dq38GrbtjEMyFzr1mKtB8roCdFUD7huAVNxzv8oAjqWwtM56Y02wU89dMYSt8B/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FseS9y9dE4GNUMXB/bqW54x6DCElqlOU+2wOmVvQJdc=;
 b=AFCKLEESG0SqL24jNJeAyiGuDV4RZZ3/xGMtqvVpQWBBYDJS0J9iJXVBBuCNuuhsB3GUJJXIWyH/q6vsr2JE/qmQV/hP456zXiZWzy+DH/YDSaivDczVDQ+IlFzemonvmWkYqLKOz2+DXzgGbrOnmYILlh9WYKnAHgfknRUCy18=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5301.eurprd08.prod.outlook.com (2603:10a6:20b:dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 29 Apr
 2020 06:11:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 06:11:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 2/5] block/block-copy: alloc task on each iteration
Date: Wed, 29 Apr 2020 09:10:36 +0300
Message-Id: <20200429061039.12687-3-vsementsov@virtuozzo.com>
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
 15.20.2937.13 via Frontend Transport; Wed, 29 Apr 2020 06:11:05 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75678ebe-e4a1-41be-4a7f-08d7ec041a3a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5301AC1796BBCB05D9518517C1AD0@AM7PR08MB5301.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:69;
X-Forefront-PRVS: 03883BD916
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gMvTvGWsLP9NH758jncDsou1xDcOZvNOp1DDalFD4FU+FE/5VJMt3pFysvf4fgUKWFjFDai5PQdRJ2i5lpu/hOcekhzHUMvcGIuit+RwrqnUK+S1tQUWU4JS/l0MFToJr2U+YjC4PlPABFujzaqtP9vxsIAeJ4eGnvSkfaTXfzA4N80LC/SgDQlNrZv87EvGBt3lqjp4nXXaLLhnifAXbwllsw+YDle2d04JicZZJpWYDgBHJS00n7zg3IcvoQJ3UoMKbfe3oItB3p9wGkVpo4O7LFF50bTI2Gxv6ff8yUk8yZq96sDM8oYd+IkqCGfKzVWaD+4N01EwEz8xYok0W0fhuih5u5/NWtcyzt+xkZz0S8QRC60lGjRMKUWSOGsIP1Igxs1irqm/V2JK/3l1YrzYP9YUK9xmqyQvP5omI97zOpm6CrHDypinvigrwXy1QVmOBaegsS6xbhcqPAgj6mOxCHhTUjf6AwdX++pOGFDm+ZzjUognSZD/94nU1cr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39830400003)(136003)(376002)(396003)(366004)(2906002)(1076003)(86362001)(36756003)(186003)(16526019)(26005)(956004)(4326008)(52116002)(5660300002)(6506007)(69590400007)(107886003)(6512007)(6486002)(2616005)(6666004)(478600001)(316002)(6916009)(8676002)(66556008)(66476007)(8936002)(66946007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4nikeuNCKbu8/Fz+XD7fKMhF2BFg3Q4pFW4MBPoHz1++ixfp5Mpoazx9UG735uY87tx+V4dua1O4XH/cy/K3OEI/4wiqffksqXCXP1VdmQvdb0a5KPi0RRvA6G7HE0jpuuMmRUulS4bpnD/SJq0pyr6ntKTz6jKgQiq2iHw6bGcKyPuSqBA20k983dBPsDcohd+WAC0elM8Bp9Rm2tMWiSWY1PXXK4J6kcXPrT+L3wLcjpHZu66NAaeen5dChdzHkMOnWfl0IcIcOGBIsfsEU3K3wmvpJ6cpM6bHH+1fe9np3qorvpxd1zj/GLzcVphqX6OlD3BsXfwT2+fGRp0aNEt3po+MdpxExE3f5fVUweFoIPqUid9//rsf3o75j0f5kWZetfyTG/4Y3FioeQ2LLyOEucI/vEuHnh0gx39j1TOkqQwp7dFDjTO/K5Prf3E7VwH5cwwADtKGuJ7/bV/E3G8JNyZTTUFfonMMGsC0lxuH97bmeeLRpymmYXt1G97cRJ4S4UUseYnXUlvA6i5u0jnWmoWJ/ClAyyiaq0Czq2GV2WWm9CaFmvhSQRYBqa+BrKhC+dtNO62TTBB0an9TMfKPQtAGViqAau8e3fjHlgPg8Vw3XT8T1M1l742f4wKJGwSzSrDsJ+0bA2TZn6gewVLbBGMN/rLyBXxE8VgIJ5hs1UHkkNk4HyStk1zkgnIyoSL9S4B8y1uePfg1x69kUXFv331k/n6nr4GeP/gZ3q7wII3OElMGGIjERgzaNNWTjD/c1zXMQUYdG26XE5JwKiOlHPuXZLWlQD6Z+R/7zBA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75678ebe-e4a1-41be-4a7f-08d7ec041a3a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 06:11:06.1600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLrqu8YI6x0VoT+OQs/vXXSVUfP831sB+lRxBz17PQWuUwdKNtyA87XI1DQ8isxV2S2Wovda61OGNboekM02QKUGM9tLGQPzj8or60OKd0I=
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

We are going to use aio-task-pool API, so tasks will be handled in
parallel. We need therefore separate allocated task on each iteration.
Introduce this logic now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index bbb29366dc..8d1b9ab9f0 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -106,9 +106,11 @@ static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t offset,
 }
 
 /* Called only on full-dirty region */
-static void block_copy_task_begin(BlockCopyState *s, BlockCopyTask *task,
-                                  int64_t offset, int64_t bytes)
+static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
+                                             int64_t offset, int64_t bytes)
 {
+    BlockCopyTask *task = g_new(BlockCopyTask, 1);
+
     assert(!find_conflicting_task(s, offset, bytes));
 
     bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
@@ -118,6 +120,8 @@ static void block_copy_task_begin(BlockCopyState *s, BlockCopyTask *task,
     task->bytes = bytes;
     qemu_co_queue_init(&task->wait_queue);
     QLIST_INSERT_HEAD(&s->tasks, task, list);
+
+    return task;
 }
 
 /*
@@ -472,7 +476,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
     assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
 
     while (bytes) {
-        BlockCopyTask task;
+        g_autofree BlockCopyTask *task = NULL;
         int64_t next_zero, cur_bytes, status_bytes;
 
         if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
@@ -493,14 +497,14 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
             assert(next_zero < offset + cur_bytes); /* no need to do MIN() */
             cur_bytes = next_zero - offset;
         }
-        block_copy_task_begin(s, &task, offset, cur_bytes);
+        task = block_copy_task_create(s, offset, cur_bytes);
 
         ret = block_copy_block_status(s, offset, cur_bytes, &status_bytes);
         assert(ret >= 0); /* never fail */
         cur_bytes = MIN(cur_bytes, status_bytes);
-        block_copy_task_shrink(s, &task, cur_bytes);
+        block_copy_task_shrink(s, task, cur_bytes);
         if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
-            block_copy_task_end(s, &task, 0);
+            block_copy_task_end(s, task, 0);
             progress_set_remaining(s->progress,
                                    bdrv_get_dirty_count(s->copy_bitmap) +
                                    s->in_flight_bytes);
@@ -516,7 +520,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
         ret = block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOCK_ZERO,
                                  error_is_read);
         co_put_to_shres(s->mem, cur_bytes);
-        block_copy_task_end(s, &task, ret);
+        block_copy_task_end(s, task, ret);
         if (ret < 0) {
             return ret;
         }
-- 
2.21.0


