Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68B6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDE52073B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="co2Ut2up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDE52073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfoyK-0001tG-SR
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouW-0004ws-Bh; Mon, 01 Jun 2020 14:11:44 -0400
Received: from mail-eopbgr70093.outbound.protection.outlook.com
 ([40.107.7.93]:39047 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jfouV-00026c-C9; Mon, 01 Jun 2020 14:11:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsEqA4FZmwCbOz9Cq9bcRo1VZ4tlGjWPQ+6k9sRZ3VhUg54Mp6tIe/SWX9ySoaAdKKGo8JsW84OQg2+KnZumqp9RfRGIXjcopNvtIrTEmh+Qv9Vf776a3+vynMdCxMJ7DZkAjxExCanlkfO7j2rm2trYFI8nNbJ9xcHNIhRV40IAM2olT73S2KywePzfS3zzvm0N8hCOPu3eQaZpvPW90hzbuCIGPsxO+c/7WNkZhgEUQYfnt1lw/Fy79RU83LxYQty3PlHkpBXbD3DH4eK/ID+3SPEG/YXRFE/K8yLJvPNBxoyVSXxED91b+W9t6AHdLYnIrOD4+8awZku59nIR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7Eoq722JIj/34+zavBcv7aOy9uvQayxsFq2nYvNM6M=;
 b=moxEfACG2rwHgTNgcIUz073/Qf+mK4XVZZ/J8ujARy3u7c0R8/SHYfw54erj6HB8hPrQSt+Ot8V6ZT2lWk6SL6yqDNGBXlMuFoYW6U1f9GgRJE4AYZuLY5aqNIbjqJacATdcXX+VWKzR63QTfavqH84PTs8RpYvz39vnvNBTuo8qkA5xU06vi4kSmR2wIj+YM6oaMIbynKwhsklEP1fFjpnKSOA9+VToh/erMSlZ/svB29Lss8BL6dLb9II1XirJq1FooHJpB3gSiqnCVDCFnZDQxBg9MBor8k1DWQ9FqoP0rDKyPmZzh4ruR/OnDgiiXVqR8UMMvlCSrvJf3cI2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7Eoq722JIj/34+zavBcv7aOy9uvQayxsFq2nYvNM6M=;
 b=co2Ut2upqfwnsML7NApViB8b2dMQc0J7O1+Sg4nr47mQNJeOk20wxVSIvbVNWCAto0LjjFtgWT+bB1btG03yPH0T7g9Wzk8m7amUnECrN7f+Gx5hgcsZcL/Zx8rWIvc2b/G4DyoSpmCBghXjyb+hFZy8mK1ZLx1WktJQ0sgZRiA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Mon, 1 Jun
 2020 18:11:35 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 18:11:35 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 05/20] block/block-copy: implement block_copy_async
Date: Mon,  1 Jun 2020 21:11:03 +0300
Message-Id: <20200601181118.579-6-vsementsov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b7f00bb-0765-46d2-9a95-08d8065738a2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB531753293A3DC0F72999251FC18A0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O387vFOASovECo9qBGVW3epKQDBwLzFAIHjNNe7lYjtNwdCrgCgMyf1jvE4RHh2ALG8lii55Z6J5ZarEzMfIdlgNQQGYlPf/yDJuxEm5z1Ced7wtgi69nurD5iL/hUL7sDp5KNowse7WiRszp+SURMswMyqFhOYjpm0uQJ/CTV1dlNmkn1MdVdxjhO/+tkp8STrWO/6rpGrkkfvX7Sv0nUI106JzoSqmUFRlQt0uTSZWludgb1OrRry3fRoECCqKk4Ra9Jo+UFO1K4wNqZon7LzsI/OAX6KHeYElai/yBrnmUl8pCn0BN1NwbO1pNKXOQGEaBgMR3oPtocRJoXQJckySfncHMI+VjyRB4nHd+fIPUCzuhCWWAKdBQNBkSWGU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(16526019)(8936002)(2906002)(8676002)(26005)(107886003)(36756003)(316002)(6916009)(52116002)(2616005)(956004)(478600001)(4326008)(86362001)(6486002)(66946007)(66476007)(66556008)(6512007)(6666004)(1076003)(69590400007)(5660300002)(83380400001)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eGEfu+LIfNTyv0tlixfSGZ3I7x090VjfWe0ynaTHmMoo7FNDwU+mkEZjtXnobO3cjLqlQFkCDBk7KuY5xq9Qb1SZeR8QIhSGGe8nEpr9LbAxKmC6Oec4vWWkups3Xzqd4xCers1jBA3UgctC2ula3NYcU8Bp2hwsH4iHpuoH7BV0+Wqpxih3C2uKbM/YqBS7hK6kg03dWSkxlskoM1EH6CeB1I8ag46V7mUPDmqrm+R3uPWbDsX+ikly+3EG6069t7Q1Z871Q6ymvJuX0b+MuhD+e0Z5grHFFYyLYHfQqfX6wbHMy7p4oCwQIKbJgUl7ZuWI4EFnRxFzfAesguKCCrqHWlAo+hN5SCZL7PAEpwkGIT9PjdkJMiMjcnfEm7laNMaZdqAvGNMLROF0cZc9P9IUp+iEa8nuJzh+uiv2jaW8FMZJV1N7NhsRTL4IJ12vZ1O+IY2s8gy8d3ipbPpEwW8KSomkm7cx26sDjn2y21s=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7f00bb-0765-46d2-9a95-08d8065738a2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 18:11:35.6216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAlVUYrcQlCRkR4NGHIQg6UjimEfYhaZEACvGRtZSOzF/O7DOsR0Rg62eTo8RIrZdNVRfRDCwsM0wRaN8GxucsNqMLs1ISeznlGJLtFGfpw=
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

We'll need async block-copy invocation to use in backup directly.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h | 13 +++++++++++++
 block/block-copy.c         | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 6397505f30..ada0d99566 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -19,7 +19,10 @@
 #include "qemu/co-shared-resource.h"
 
 typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
+typedef void (*BlockCopyAsyncCallbackFunc)(int ret, bool error_is_read,
+                                           void *opaque);
 typedef struct BlockCopyState BlockCopyState;
+typedef struct BlockCopyCallState BlockCopyCallState;
 
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      int64_t cluster_size, bool use_copy_range,
@@ -41,6 +44,16 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
 int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
                             bool *error_is_read);
 
+/*
+ * Run block-copy in a coroutine, return state pointer. If finished early
+ * returns NULL (@cb is called anyway).
+ */
+BlockCopyCallState *block_copy_async(BlockCopyState *s,
+                                     int64_t offset, int64_t bytes,
+                                     bool ratelimit, int max_workers,
+                                     int64_t max_chunk,
+                                     BlockCopyAsyncCallbackFunc cb);
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
 void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
 
diff --git a/block/block-copy.c b/block/block-copy.c
index 75882a094c..a0477d90f3 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -34,9 +34,11 @@ typedef struct BlockCopyCallState {
     BlockCopyState *s;
     int64_t offset;
     int64_t bytes;
+    BlockCopyAsyncCallbackFunc cb;
 
     /* State */
     bool failed;
+    bool finished;
 
     /* OUT parameters */
     bool error_is_read;
@@ -676,6 +678,13 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
          */
     } while (ret > 0);
 
+    if (call_state->cb) {
+        call_state->cb(ret, call_state->error_is_read,
+                       call_state->s->progress_opaque);
+    }
+
+    call_state->finished = true;
+
     return ret;
 }
 
@@ -697,6 +706,37 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
     return ret;
 }
 
+static void coroutine_fn block_copy_async_co_entry(void *opaque)
+{
+    block_copy_common(opaque);
+}
+
+BlockCopyCallState *block_copy_async(BlockCopyState *s,
+                                     int64_t offset, int64_t bytes,
+                                     bool ratelimit, int max_workers,
+                                     int64_t max_chunk,
+                                     BlockCopyAsyncCallbackFunc cb)
+{
+    BlockCopyCallState *call_state = g_new(BlockCopyCallState, 1);
+    Coroutine *co = qemu_coroutine_create(block_copy_async_co_entry,
+                                          call_state);
+
+    *call_state = (BlockCopyCallState) {
+        .s = s,
+        .offset = offset,
+        .bytes = bytes,
+        .cb = cb,
+    };
+
+    qemu_coroutine_enter(co);
+
+    if (call_state->finished) {
+        g_free(call_state);
+        return NULL;
+    }
+
+    return call_state;
+}
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
 {
     return s->copy_bitmap;
-- 
2.21.0


