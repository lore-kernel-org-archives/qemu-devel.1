Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E18C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE792068D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oMmjYehz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE792068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfp2C-0005z6-25
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouY-00052V-7A; Mon, 01 Jun 2020 14:11:46 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:39047 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouX-00026c-1a; Mon, 01 Jun 2020 14:11:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqzTAByICg9bl7mhpJDK9GdOn3zjN2a7afflnJcnEtg2RelUyz/L7Gc17Rvgw6ZSqbh8CQLMPbbHUg8WDEnmEO6uvrI60mxLnU8DiXZdtei2ikKSL0tR6Dpvzg2pBZES8QiUtaxPVxMyDAbsvHiuO+BytU3KK0X5eNzT3vw80T1WaLf6Z8c5nSeAkhDjcUqP40pfI1Do/n7RGglU89nX/beb63/HMuwOYK5ZYUCDEy7uQXh+yXkfNOJekSuKvMZcWCi10EgVdqIqhgYaUJjyK1f0EILjaq42ZI9qMcJh+h+Em/G82LJrXAPKeZFjSnBvF05NH7Qr/CDgJ+wlI8RXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85i5+xBw2B6rOENuXOGZJnaqvBK5TcYKVhlQx0CFcz4=;
 b=SvYU0gweRoDopflodnzzPdYypsD5KjXUtZ8+YFLlB8d2qdHI5zlSj/xQLqB4wML/q6MILnAqUZ5+C9Z9LVMG0/Y45jY74+yeNgxEHoJMBwlHq+kqaqVYwA1efWCwYIuNsLYQHEf2lFcxV6oVVa9UWs/kemPDURITqqZN84A73BJFWObEN5g/YjuvhOCoPUJ4rrs2LF6FndxKzyIU9aeJDsdLxZCqx2FRDxAKayGfcYJQGAXud4V3yrKkm6MjLX4NHQWd1vOCRyvCrfdBfcLJMWKkocuqi2YubT6KNXatsLP68BGIPEFt0z/r2sPF4/JNW8KiIH0uK8M8w9I/eenv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85i5+xBw2B6rOENuXOGZJnaqvBK5TcYKVhlQx0CFcz4=;
 b=oMmjYehz43lERJrNmEHfFFPrHJe/ipYkQqAe0O3vXZFuFi/3DE50kBweMGMCQU4WAA14eztHlUzkLpQPCB+jUp3/WixQmdP35L4Og+RrZXS4UazZ7baEp9R7IhId7irdEyjitkNG8Y1RGeyrXkFN4HpoMraQVs2JPCtYbya1DJU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:37 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 07/20] block/block-copy: add ratelimit to block-copy
Date: Mon,  1 Jun 2020 21:11:05 +0300
Message-Id: <20200601181118.579-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200601181118.579-1-vsementsov@virtuozzo.com>
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.170) by
 AM0P190CA0028.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:36 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9269cd3c-beb5-476f-d1cf-08d8065739a2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB531704BD1FF1D54A221ABBF2C18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kr2+j103aaNjRDv9Nal3anWEwQNqaVxJOLKYqVhto904H5zopXxofFN23QGqlR7+JPshwGnjTW7fAcCOU9EN+hc22Tg2bbuLdvZQ/cXz6yoA7poYdAXC/MGU9n+bl66eiZIs/lAen5D647xT57IqnVjXfkbqL7F9cV/RpYe/XrHurMfucQtYCa5RnuyNUpJFffr4BC0WvIrBrRcT79nMtx0KKhYORr0IVENtM3E8EXoSfahKxYYv/CxWMzeJD0Sg655bk1s0SnHr3717ULtUkRQ19YFTQvE0zQAEMWpJkdVCTt8wuU1BECvXFE9UKgrKs+f5XeDtSJcl3/LahlFYQdd1+/Jq0jflhSE108mbWImQltUnsp2p5dGoYOjOJNk9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Y+oCV6PbTcAIUoXkokxj55Zfm6vwbdnhf4PJ7D+MzQcJQFtroc53VBJlcQSUzYPYmiwV7Yi8Fp2xNIWazPbZRNHp3wVc8qP13LGtHQD8UXBy5dbXy6PQsUfpvvhcHahYKR+a+IPr5vsVngi1mUaEjep8BUwdt02GbUb1Yay5RifjSpl74QjuBWggSLxOfVaAeQe6YiCYXF7VuQqUOqEvrFeVLMXiteK98EkKgpjUMDK6vu0Sd0h+UVTIhwXK21C+nqaoJpQBteP8KyoWw4f2NUQYgRXO6qEr+nkorGZpyufVUDN+tmzUOiMBx681dqE9L7OAcMNi34U7Mf8ETY7j+034P4sY85hzEvVaTV9CWX0On80LS8SOTGUyvwn9b0fOrTJ6vqmN3SbTn9iQmpPPi7EdR/+YOsEGnaUKRGYTEFOSQqpz64LkH4VQ5NacX8M4g2kFLiGJ9BVIrSOflBo2JZnQrjZvug/foHVxBet32sw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9269cd3c-beb5-476f-d1cf-08d8065739a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:37.3306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N+FPlSG32niV16jp/NfurEpflgExoC0HyZola6BgHroc2TmhWLhUaGMit5twiCHlH6jNNWy43KazQM1ITovhX/asbETOB8A77F8hb/pLL7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.7.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:11:32
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 wencongyang2@huawei.com, xiechanglong.d@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to directly use one async block-copy operation for backup
job, so we need rate limitator.

We want to maintain current backup behavior: only background copying is
limited and copy-before-write operations only participate in limit
calculation. Therefore we need one rate limitator for block-copy state
and boolean flag for block-copy call state for actual limitation.

Note, that we can't just calculate each chunk in limitator after
successful copying: it will not save us from starting a lot of async
sub-requests which will exceed limit too much. Instead let's use the
following scheme on sub-request creation:
1. If at the moment limit is not exceeded, create the request and
account it immediately.
2. If at the moment limit is already exceeded, drop create sub-request
and handle limit instead (by sleep).
With this approach we'll never exceed the limit more than by one
sub-request (which pretty much matches current backup behavior).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h |  8 +++++++
 block/block-copy.c         | 44 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 600984c733..d40e691123 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -59,6 +59,14 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
                                      int64_t max_chunk,
                                      BlockCopyAsyncCallbackFunc cb);
 
+/*
+ * Set speed limit for block-copy instance. All block-copy operations related to
+ * this BlockCopyState will participate in speed calculation, but only
+ * block_copy_async calls with @ratelimit=true will be actually limited.
+ */
+void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_state,
+                          uint64_t speed);
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
 void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
 
diff --git a/block/block-copy.c b/block/block-copy.c
index 4114d1fd25..851d9c8aaf 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -26,6 +26,7 @@
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
 #define BLOCK_COPY_MAX_WORKERS 64
+#define BLOCK_COPY_SLICE_TIME 100000000ULL /* ns */
 
 static coroutine_fn int block_copy_task_entry(AioTask *task);
 
@@ -36,11 +37,13 @@ typedef struct BlockCopyCallState {
     int64_t bytes;
     int max_workers;
     int64_t max_chunk;
+    bool ratelimit;
     BlockCopyAsyncCallbackFunc cb;
 
     /* State */
     bool failed;
     bool finished;
+    QemuCoSleepState *sleep_state;
 
     /* OUT parameters */
     bool error_is_read;
@@ -103,6 +106,9 @@ typedef struct BlockCopyState {
     void *progress_opaque;
 
     SharedResource *mem;
+
+    uint64_t speed;
+    RateLimit rate_limit;
 } BlockCopyState;
 
 static BlockCopyTask *find_conflicting_task(BlockCopyState *s,
@@ -611,6 +617,21 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
         }
         task->zeroes = ret & BDRV_BLOCK_ZERO;
 
+        if (s->speed) {
+            if (call_state->ratelimit) {
+                uint64_t ns = ratelimit_calculate_delay(&s->rate_limit, 0);
+                if (ns > 0) {
+                    block_copy_task_end(task, -EAGAIN);
+                    g_free(task);
+                    qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, ns,
+                                              &call_state->sleep_state);
+                    continue;
+                }
+            }
+
+            ratelimit_calculate_delay(&s->rate_limit, task->bytes);
+        }
+
         trace_block_copy_process(s, task->offset);
 
         co_get_from_shres(s->mem, task->bytes);
@@ -649,6 +670,13 @@ out:
     return ret < 0 ? ret : found_dirty;
 }
 
+static void block_copy_kick(BlockCopyCallState *call_state)
+{
+    if (call_state->sleep_state) {
+        qemu_co_sleep_wake(call_state->sleep_state);
+    }
+}
+
 /*
  * block_copy_common
  *
@@ -729,6 +757,7 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
         .s = s,
         .offset = offset,
         .bytes = bytes,
+        .ratelimit = ratelimit,
         .cb = cb,
         .max_workers = max_workers ?: BLOCK_COPY_MAX_WORKERS,
         .max_chunk = max_chunk,
@@ -752,3 +781,18 @@ void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip)
 {
     s->skip_unallocated = skip;
 }
+
+void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_state,
+                          uint64_t speed)
+{
+    uint64_t old_speed = s->speed;
+
+    s->speed = speed;
+    if (speed > 0) {
+        ratelimit_set_speed(&s->rate_limit, speed, BLOCK_COPY_SLICE_TIME);
+    }
+
+    if (call_state && old_speed && (speed > old_speed || speed == 0)) {
+        block_copy_kick(call_state);
+    }
+}
-- 
2.21.0


