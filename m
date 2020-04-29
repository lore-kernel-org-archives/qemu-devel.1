Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C950BC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9631B21974
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 13:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NgS0R+QI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9631B21974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTmWb-0001mc-LK
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 09:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmV8-0007xp-Gr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jTmV0-00085D-7p
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 09:11:46 -0400
Received: from mail-eopbgr80118.outbound.protection.outlook.com
 ([40.107.8.118]:18917 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jTmSm-0007bZ-7J; Wed, 29 Apr 2020 09:09:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtgyVtESb2QJEJ287jLp4SzE6tbel41MKaCwG8ZO2/d6yDxHPBpZ5gVMx8fKE7C7oX/nEIZjhy0urp7DRb744iwKD/s8Hh7H9fsz6MKEAFGLh/q9gkXEZ+Q/VBYhfsYV0wcNSMTGkwlwKZQxFt8iJM7V/0djPFU4djCIQiofHRJXBzn7B2iADiWnezPeMpsOOjb2B0vmsYaVe4gC3OgsHpU+sQiY10pUa0HGBkPO/5jImweFa/YxuhfD+RqiU7yb9dZ9t9ipSGHh9ARf7grnzm73YEZmfeR4iwzOvVVEOvuHIa601GzmLQrRGh3i1BEqXWiv+cJJN26pkh3ynT+8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FseS9y9dE4GNUMXB/bqW54x6DCElqlOU+2wOmVvQJdc=;
 b=ASlW30wN3lLx4pVyIxJMw5GnKmsQ7UmQRh/WAp7s2S0QoBhFGW4eoGkFXL/Mu5gMmgz1YR+smgWTVM565S11Pf4qhYuZoT2Q1WKs+UjDw+A5MR15HANKRBF81vz4hc9evQeaF9ACZCi1dvCFyHJ+159iuGvtfmjqDcNSN27fSNDfU1s/pEM3XwBYE4vx2mjFQEQgVREYv8UJA4DHjTQRl/OGWkBSoZpsnWtqv10XugGibKxZSIQI98psZN+gQjLDaoFt2WKCFCOC6AMciwbTxc6yNs5ElaBxCHk+7b+aU7tctpFdRL74NalwinF5dc0OjtKzgAQsu/9r/kt1a4//gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FseS9y9dE4GNUMXB/bqW54x6DCElqlOU+2wOmVvQJdc=;
 b=NgS0R+QIlfYtBxedXzQn3Alee3pd9uCd0rVTljfgWCqZ98YrTaIdAP8UWu2KEtpEZGgCC7atSaWnwsQ0bgZYViNHnc7fHflJpQp0aLqLN771QERPDB2n0VUU5lQock0UwXziLcnoFkBoT42xsjYzlJjUnKrUMzlHqJ/Yi789I80=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5446.eurprd08.prod.outlook.com (2603:10a6:20b:107::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 13:09:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 13:09:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 2/5] block/block-copy: alloc task on each iteration
Date: Wed, 29 Apr 2020 16:08:44 +0300
Message-Id: <20200429130847.28124-3-vsementsov@virtuozzo.com>
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
 Transport; Wed, 29 Apr 2020 13:09:14 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30d870fa-dfce-41cb-edd3-08d7ec3e84a2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54465D5BF79F7C9385231257C1AD0@AM7PR08MB5446.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:69;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39840400004)(366004)(396003)(8936002)(16526019)(2616005)(107886003)(6512007)(66946007)(66556008)(66476007)(316002)(36756003)(6486002)(52116002)(5660300002)(186003)(6506007)(26005)(4326008)(956004)(1076003)(69590400007)(478600001)(6666004)(86362001)(2906002)(6916009)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /sXK6xZ/mhHhXLRu5eA2BaVqch87W+dS+9yOkJ4ZxUFz/ASvjXZNumB1u229tWtWK2W9y5qi8IsATANc3PSX24svnS6PLmnS346mfqFgKbRaAN1HuP8AKy1IjPoiIy7+ulKsqSvXfOfyneR8yScMrG2wC4sPjQXLaF0K2mEDrpeeMXBm/VXnxC14yk/GfCu27fqDTuWDxsY7maqpqAnq4LE3TS+n7ARFPtCbXlfdpvZUguLq2N8yD+ZDqwavwiEHWRO11KVL74f25n3vOkA+Fc1e5+72q55kJcBYmyy9Rxm1Z6babma4BvI52J6AYwsuuoKO+aKBFPOfE1Ui1v7dXZ1aTP/0DvvlsRWOZ5Jn3cflV38kXKQRFQXHrkBhRTmY/twwGNMMD0HEEuGm0MyiB/lxfXyYHCBc30QC7LCmlzW6jnTUdGlXzvboUb+qUegFg2primHl9Uzbt39tw8gONzyJK6KlhYZt+qdNtgSzfSLCJRtcKGaC6apU0cEQqseT
X-MS-Exchange-AntiSpam-MessageData: wHyxkz1J+JXgKXNExuMvFbtLyj5WrBOB1eT3pHmdawB0lUqauPeWGnzYGm4G9ejKC6Z0IBB+vkM5IZFI2EbS9BgTydNAbiFN488C/GJpqicbTNwJHP7P4zbUZi4zR/S9ZAJ5xZQUKE9wA6SsoGlGcZsoWF2/HNGWcXSXPmxrSQF+S5SywvZ3tj0OHwjqWOzIQMloweR8R0xlQxIDv+8gqKlvHIdhjj6Iu8AyHfCdLOjFnmPUMwRWvdRk2CTihcznPHlg+geGnJM6hlxDbOM/s1QQI0B2I1ug/IyVcQWz9NUQFtfwFAf8F0QRxCyybTnfzrE5QfxKVX4ySvPfBk7DkGv8MOf2QkW3GOwI2tbAd68W9FT9LAr4SJm5pXTUp8VbpUYiwMtzBBVj9vqihuG48vfpY6qgJiiqF/wQt+h1+mjBd41qgj40G6ttZsX3PDlovp3opJE98vejvnROee3tuaWv11kJKH1+YY1j/grNnZYYNcH5IXpgyIguRtI6bGyWBT85tCIltj829Pf3a+42TRbAsRYvWBMZql9hmuS4YXksOoVlqoZPhXVy2S33TO4zOBEQ0pEcqRbE8OlqbYXMLjMn9eSofNlF2AED2RE0K2gj/XtwV/3K2Hxs9OqEbGi/3HyKCovzlbd+DLl8AhSI+INfyttTk0KYtbzppVt8QAZwBmbWkYKYKhXx9IL1+Tt64OlEvYbwYay6FoG03mPsCclNjW0x207oO0QEdNcuGkwnfqYUa/A9BO0EEPOzL1c7kXEU/mW1mlCSwvrFuIx1sNWibBV05j2uBje5ffR/C54=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d870fa-dfce-41cb-edd3-08d7ec3e84a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 13:09:15.5205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DX6X351wMGSKmqXKHTSqsA2bi6F1E5NVlGEkUCwjJa4mh1JHLDow0ewgFvHaC3ObDrLdd7hO/zAXlOckIetT5tN3wm8lNC4rnVoENkgsw8c=
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


