Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70487C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:12:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413342068D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gTs1973w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413342068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfovi-0006ko-CE
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouU-0004sQ-Jh; Mon, 01 Jun 2020 14:11:42 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:39047 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouT-00026c-Gd; Mon, 01 Jun 2020 14:11:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDGspwZjK9yk20+QqaI8W6Xl0DjFJupx3w9yfjtZESibOZGJ0+tNT2PXw3bF0b5UZBOhCV9+0N9obskuMOwwzf/W67Vx1x6gnH8EfxXLWaglgFz6uuKtED/hCcjQzffa8uxmR0NNObPvThHuF4rYXO+2mBQmR9hKaNVnNKXSMQ9xbIv3QyNNXAk07j+x2qK4G4nsR57z01qmGEcgG8aKsENbjTXg13Ad7eK4voj34rCkQDNkoHT/BxE9KdIa1NexZoMQLj1XMet0OyvAYSHqO0+2W5XEXf6Rqo8eFSXeQOiIBZKpvzpJ++eEpKeg1W/gFUhyHugUy6CDrTlaNVJ4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewZPhdTzYAYsj3v4A0UfZ1v0/DQIlT77yyMtWLAgvvM=;
 b=EbZgJSpqTdqeMoqzm4q/2l9ctao4kjU4ncjWPTQ63NFWMtt+Mc8oSPJmp0zutv6r1cESbtNjwk7XNIucf7s1/C8pYer8OpTPFG5d47vEwpfmfpRX6IxbG2bIF5zC0Msb5Gfp09PK6s/buBqfIsnrfR6De5bI6qyua7uCo7nOyUQJcD9aWtq3xdTrx/2TTbskZNOdlrt0cdw+s4Tct2lvM78rRQ3fhUlhByj6kpEqlGfodeBS8Z9KEPJBlklrtd0ZC+X9uDnSJlwfgz/pH+bXl7I8Y/9DfoQixgn25jGS/bhBHjWr2wNmewtyUETYWRPZL33vtsabPIXqP3dyFzltqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewZPhdTzYAYsj3v4A0UfZ1v0/DQIlT77yyMtWLAgvvM=;
 b=gTs1973wsJHBO2z3CNA1EvdpnJfCovF+Gow703Zqqi6/l9vCPQdYAquG4vH3Z90f/SmenX6WbvEr2Yeycktq0YBlpmAkRSPakL+h+0AG3XVUy8SrEr+SAf37xP4WYeWGtA/3F818C64hxACWVk1xTisJknFxLfYhRDGRIOs1dG8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 04/20] block/block-copy: More explicit call_state
Date: Mon,  1 Jun 2020 21:11:02 +0300
Message-Id: <20200601181118.579-5-vsementsov@virtuozzo.com>
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
 15.20.3045.18 via Frontend Transport; Mon, 1 Jun 2020 18:11:34 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.170]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a183cf8d-18db-453a-71c7-08d80657381d
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53176534C2C9C0301667EFA9C18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/5FupgJ3nu8xGQXZP+t007aeLPMdsAjUh/BhmgiFekU+5nKRibI+5jOhIWtaNf8n51qhY69T8TrlIN9V7Z/u+mUbF6y0bUjSBN1FIj887slDjqb7EGUc/Kc+sbUjWifmOguRQvzzQgEkuBa/zfewm0UOrMfyqTxAlwds4hemuI+tvEhpHg7M3d53yJ9neCAg85WMzQsyCCnROVDiwo8muGUahT4jJnv+glJyQu7jtxpMpsfn7a0S/TQ2aqX4hSISGPZgAuf1dk5FERcZSWy5O1P1qagZirs9cIsE3mNwtEvhdzXBZfIeOzDGBcdfs0hzJgMJHlI3ilWD9Ul9OzEVYJUVsaT3wOWUxXo+QOEemPbkptNENWU1sA4mcF6k6gl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: CCTiJtn2LvgRnMZrcQfnWh9+odnefP0EGq7sjdZ6NNRt5Qi0DH/aF1iey+rRhwv0I9UQh0qfwZYELuAyi/AOX2Z8GlFQ/guOWUPCHzGBGfiek3mVX5zqzPw+G60xpAb7NncIMgVJEq6lcg7sQ4o0wcbZfv1iLB6esL6XQ4MifWWoiCkBdAfRBu/nIeemFY2uL+ykbyLSebFzPCaNm35uytmX70F+/cn/E/HT4NdYqKAqocVmYxk+fRj9dw4wIk6Ta3YMxOD8owHZm/DN5vaUbDOeFxHfXYujoTa+nrnnK8x0dMgMvnuS9Y6zSyh0lvuw9ualcwVmbAM+RBOwu3dov29zOBVGcjgncp3GAqrfJGM9/DFkmBi7/CysMOPKhtfc/CayvD9NqSw5TZGEFZ1ZxpD7+tTpFfIpNl58yYwQNjCB2LpDmYQ0QGyZFkaTygR6UfhhWlXlw4MiipCAoM6YHCQ7Ua9T9zD1wAqL9jURRHg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a183cf8d-18db-453a-71c7-08d80657381d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:34.7669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeutApwlXQd3qpCh4Eli55iWUOQ6GfNZ4Jq86GZKruAbi2fB1DqoDBrpBxXqY9AGsfwrOi3tdHycNY6i8TQcSTXqrpRVOSjtFz/6U+6xmn0=
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

Refactor common path to use BlockCopyCallState pointer as parameter, to
prepare it for use in asynchronous block-copy (at least, we'll need to
run block-copy in a coroutine, passing the whole parameters as one
pointer).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-copy.c | 51 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 43a018d190..75882a094c 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -30,7 +30,15 @@
 static coroutine_fn int block_copy_task_entry(AioTask *task);
 
 typedef struct BlockCopyCallState {
+    /* IN parameters */
+    BlockCopyState *s;
+    int64_t offset;
+    int64_t bytes;
+
+    /* State */
     bool failed;
+
+    /* OUT parameters */
     bool error_is_read;
 } BlockCopyCallState;
 
@@ -541,15 +549,17 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
  * Returns 1 if dirty clusters found and successfully copied, 0 if no dirty
  * clusters found and -errno on failure.
  */
-static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
-                                                  int64_t offset, int64_t bytes,
-                                                  bool *error_is_read)
+static int coroutine_fn
+block_copy_dirty_clusters(BlockCopyCallState *call_state)
 {
+    BlockCopyState *s = call_state->s;
+    int64_t offset = call_state->offset;
+    int64_t bytes = call_state->bytes;
+
     int ret = 0;
     bool found_dirty = false;
     int64_t end = offset + bytes;
     AioTaskPool *aio = NULL;
-    BlockCopyCallState call_state = {false, false};
 
     /*
      * block_copy() user is responsible for keeping source and target in same
@@ -565,7 +575,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
         BlockCopyTask *task;
         int64_t status_bytes;
 
-        task = block_copy_task_create(s, &call_state, offset, bytes);
+        task = block_copy_task_create(s, call_state, offset, bytes);
         if (!task) {
             /* No more dirty bits in the bitmap */
             trace_block_copy_skip_range(s, offset, bytes);
@@ -630,15 +640,12 @@ out:
 
         aio_task_pool_free(aio);
     }
-    if (error_is_read && ret < 0) {
-        *error_is_read = call_state.error_is_read;
-    }
 
     return ret < 0 ? ret : found_dirty;
 }
 
 /*
- * block_copy
+ * block_copy_common
  *
  * Copy requested region, accordingly to dirty bitmap.
  * Collaborate with parallel block_copy requests: if they succeed it will help
@@ -646,16 +653,16 @@ out:
  * it means that some I/O operation failed in context of _this_ block_copy call,
  * not some parallel operation.
  */
-int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
-                            bool *error_is_read)
+static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
 {
     int ret;
 
     do {
-        ret = block_copy_dirty_clusters(s, offset, bytes, error_is_read);
+        ret = block_copy_dirty_clusters(call_state);
 
         if (ret == 0) {
-            ret = block_copy_wait_one(s, offset, bytes);
+            ret = block_copy_wait_one(call_state->s, call_state->offset,
+                                      call_state->bytes);
         }
 
         /*
@@ -672,6 +679,24 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
     return ret;
 }
 
+int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
+                            bool *error_is_read)
+{
+    BlockCopyCallState call_state = {
+        .s = s,
+        .offset = start,
+        .bytes = bytes,
+    };
+
+    int ret = block_copy_common(&call_state);
+
+    if (error_is_read && ret < 0) {
+        *error_is_read = call_state.error_is_read;
+    }
+
+    return ret;
+}
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
 {
     return s->copy_bitmap;
-- 
2.21.0


