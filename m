Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B8C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90FA22242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="FvuD3d7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90FA22242
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6TS-0000IB-0e
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68s-0007WN-3r; Mon, 26 Oct 2020 13:18:46 -0400
Received: from mail-eopbgr60108.outbound.protection.outlook.com
 ([40.107.6.108]:26030 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68p-0008Ma-W3; Mon, 26 Oct 2020 13:18:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXwa0y4QPcyo8IAswtTKH+RYn+LyRdoZe9d+zPWxqCAVAHKTTld2i2tFO+vMCIAYTXzHlYHuLyDkuAdvwsxXsGa843doHVq+l9HaKDvmd3+0v2Qfd+9QUSPRllYEy2cyalbRiQn/JctwqNEXWB2RfmkQk8NtFow65fmUr5pBMkvRzBuw2mGY1eDMwmBMrOemI0NGzVcbhgyOCuIsq6zLadO++U1mjANEntO+doubmqRP6WIkXTiuqGUCR3rtfDWdG3epTpxHEnFT2CyxxIXiWsgApJWMkVt+R7cNX4C+sA0UghJUyzZnf3hVmRnNqSxbi7ex2qCr4J/p8GKzEpiesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAr7Nve6ddL6t2DWtKipHvOZSMXnELBA6nhnqL+MIKY=;
 b=KRqthOxrhG9y1qcNd8I/52UBrGRqJgTxA3VBzxBMDuqM/86NfF1jZVxZ35EF+6MUs9tbHBwAvGPNApJ1gXQZiv85+KM+ReMpU79eQ6tXrjmj8lmBNMzC7z3irBfr8i1A6SA3sTq0u979yrWxXcCxyLMZR5hyJrGhjISHZoiwmn/Z6Nv8BEvG4NAfJibwTfFumgGx+WEH4uX3F5npHrE1dQAM78ETtVGsep/CbWtqqpQLvYGgpAxRfXNMgVu+tcVXqmW26rgmUNWB9lRGtoy/vXLEmO/+j7uDkIpMmAbk2nYSrpPm2pVZbU+cnaLDiqCybEewuh0o5Nw/Gr/bUZn+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAr7Nve6ddL6t2DWtKipHvOZSMXnELBA6nhnqL+MIKY=;
 b=FvuD3d7bFJzxn8p4ArhRQotamaAnuYg6e0o/BeIXr1dmNiwGe88TtAzVLVxiJdSm+f46KJoFTSnrraJHKJYagT3/p34NSYzQA05OCp1ZokCoBEU4YnL9fjT6E4OscXF6z8PeH2w9nPKu9I67++TGYbv2mcb4UgEgc8Vbv/IV694=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5031.eurprd08.prod.outlook.com (2603:10a6:20b:ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 04/25] block/block-copy: implement block_copy_async
Date: Mon, 26 Oct 2020 20:17:54 +0300
Message-Id: <20201026171815.13233-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026171815.13233-1-vsementsov@virtuozzo.com>
References: <20201026171815.13233-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.99) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 17:18:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2efa9a13-b780-4a3b-e597-08d879d32a8f
X-MS-TrafficTypeDiagnostic: AM6PR08MB5031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5031E8B2F61A65A723827746C1190@AM6PR08MB5031.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:50;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XwmjUyQajTRmIbun3YHZsQyuNgBNzbT2RV4apoJM4SJzKZX3EikCW81ujeKyMK3ifRQOF7mjxSkIsvHb4WeoaEkSdJrc92ZZx3DjggMXndgsEC+YO60hFn6rEn9+jnRclx/HZ+kNGvmmtL5I7ncU3u0fm4TBH+zaKnj4f7kfbwnA6VkUyKswMyXC4HxEd3cmoWkwpLAH3eQYvUJJa2wUCEg+wNzmW2yJzxgpn2mpwAp+9YdZ460RBq1E2uoAUF+/N/nEGYlJ5vYhW+qGTk3g9kUXfhxLd9gqNhOFoYOm9xjXlcTiuAAtjD0OEm7ZzBwaU2aeYpQF2O38TU8rqGNNQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39840400004)(346002)(376002)(396003)(83380400001)(5660300002)(1076003)(316002)(2616005)(478600001)(6506007)(4326008)(6666004)(66946007)(26005)(66556008)(956004)(36756003)(6486002)(6512007)(186003)(66476007)(8936002)(52116002)(2906002)(16526019)(107886003)(8676002)(6916009)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aH2H+5vi1xuTa6nIhaVL2Ts90omd6ZwmmD/VWqePCHKKYGDyTw0p3vhTmSXKA/Sp833KjcnScR3rfL/hRVkTuDv4+IMhsvDpBH7WMTknVgKZSlyBZSkdGzH4GZ5magUJeeKgl8+pPyB2DMb43sBG5+ZKbrXAxjGdduDRJXt0fxoOJtqTyBG8keHyXLvTtfq9SX4xPjMl3gO61zPoMUVx4NsYlp3HtQtrjIrk8vr9IjkIFyrTcUgDazt8vvIzx956I2zzp23AhWI/DH7OScwWyjIrburCeXWPe6JgA8YeYUG6RXPV51GDoAWWQRv4H1pQA5yJYREoCB7y2EySYOw8QOnRoY3P6WjxaWgurreFkkh5og4vyu6PQOzOaPfGdOb7aF1JRx4A5pTREQbZiZawOqaMptEDSVSVoKxNnMXDmelY5XbBzHxWnSLfqvJHdcfoKxvdviJE23CdnW6f3XmPKyrSvgBnfgx6/8bXAPjExZgJqk7Yk5YhFuR3kTgASWWQ1gQjHKmrjflEiKNjgJx2+HL2cYO6g11zxPF7kUYtikmXWa/RhomlHVOS4qpFaMJee1WPmue0oLqxyzbckd636ciyJyhfsCwQS3uugiG3TbBtwSIHd4PzjMtBqk84zVUSBJa9KUY7xCMhO12AbBb2uw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efa9a13-b780-4a3b-e597-08d879d32a8f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:33.3432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPYYghx2s97FEovIhRQmvYU3hoCdVE0DsE5spe/sAxExhLiFUeJZ+FojuytiHEb4jkbPVoX1HQTrC8ZdkyMLLSjJEZ37gYWhQCcQaVebgqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5031
Received-SPF: pass client-ip=40.107.6.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:30
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We'll need async block-copy invocation to use in backup directly.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h | 26 ++++++++++++
 block/block-copy.c         | 81 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 6397505f30..3566827599 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -19,7 +19,9 @@
 #include "qemu/co-shared-resource.h"
 
 typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
+typedef void (*BlockCopyAsyncCallbackFunc)(void *opaque);
 typedef struct BlockCopyState BlockCopyState;
+typedef struct BlockCopyCallState BlockCopyCallState;
 
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                      int64_t cluster_size, bool use_copy_range,
@@ -41,6 +43,30 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
 int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
                             bool *error_is_read);
 
+/*
+ * Run block-copy in a coroutine, create corresponding BlockCopyCallState
+ * object and return pointer to it. Never returns NULL.
+ *
+ * Caller is responsible to call block_copy_call_free() to free
+ * BlockCopyCallState object.
+ */
+BlockCopyCallState *block_copy_async(BlockCopyState *s,
+                                     int64_t offset, int64_t bytes,
+                                     BlockCopyAsyncCallbackFunc cb,
+                                     void *cb_opaque);
+
+/*
+ * Free finished BlockCopyCallState. Trying to free running
+ * block-copy will crash.
+ */
+void block_copy_call_free(BlockCopyCallState *call_state);
+
+/* Note, that block-copy call is marked finished prior to calling the callback. */
+bool block_copy_call_finished(BlockCopyCallState *call_state);
+bool block_copy_call_succeeded(BlockCopyCallState *call_state);
+bool block_copy_call_failed(BlockCopyCallState *call_state);
+int block_copy_call_status(BlockCopyCallState *call_state, bool *error_is_read);
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
 void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
 
diff --git a/block/block-copy.c b/block/block-copy.c
index 6ea55f1f9a..74655b86f8 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -30,13 +30,19 @@
 static coroutine_fn int block_copy_task_entry(AioTask *task);
 
 typedef struct BlockCopyCallState {
-    /* IN parameters */
+    /* IN parameters. Initialized in block_copy_async() and never changed. */
     BlockCopyState *s;
     int64_t offset;
     int64_t bytes;
+    BlockCopyAsyncCallbackFunc cb;
+    void *cb_opaque;
+
+    /* Coroutine where async block-copy is running */
+    Coroutine *co;
 
     /* State */
-    bool failed;
+    int ret;
+    bool finished;
 
     /* OUT parameters */
     bool error_is_read;
@@ -428,8 +434,8 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
 
     ret = block_copy_do_copy(t->s, t->offset, t->bytes, t->zeroes,
                              &error_is_read);
-    if (ret < 0 && !t->call_state->failed) {
-        t->call_state->failed = true;
+    if (ret < 0 && !t->call_state->ret) {
+        t->call_state->ret = ret;
         t->call_state->error_is_read = error_is_read;
     } else {
         progress_work_done(t->s->progress, t->bytes);
@@ -679,6 +685,12 @@ static int coroutine_fn block_copy_common(BlockCopyCallState *call_state)
          */
     } while (ret > 0);
 
+    call_state->finished = true;
+
+    if (call_state->cb) {
+        call_state->cb(call_state->cb_opaque);
+    }
+
     return ret;
 }
 
@@ -700,6 +712,67 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
     return ret;
 }
 
+static void coroutine_fn block_copy_async_co_entry(void *opaque)
+{
+    block_copy_common(opaque);
+}
+
+BlockCopyCallState *block_copy_async(BlockCopyState *s,
+                                     int64_t offset, int64_t bytes,
+                                     BlockCopyAsyncCallbackFunc cb,
+                                     void *cb_opaque)
+{
+    BlockCopyCallState *call_state = g_new(BlockCopyCallState, 1);
+
+    *call_state = (BlockCopyCallState) {
+        .s = s,
+        .offset = offset,
+        .bytes = bytes,
+        .cb = cb,
+        .cb_opaque = cb_opaque,
+
+        .co = qemu_coroutine_create(block_copy_async_co_entry, call_state),
+    };
+
+    qemu_coroutine_enter(call_state->co);
+
+    return call_state;
+}
+
+void block_copy_call_free(BlockCopyCallState *call_state)
+{
+    if (!call_state) {
+        return;
+    }
+
+    assert(call_state->finished);
+    g_free(call_state);
+}
+
+bool block_copy_call_finished(BlockCopyCallState *call_state)
+{
+    return call_state->finished;
+}
+
+bool block_copy_call_succeeded(BlockCopyCallState *call_state)
+{
+    return call_state->finished && call_state->ret == 0;
+}
+
+bool block_copy_call_failed(BlockCopyCallState *call_state)
+{
+    return call_state->finished && call_state->ret < 0;
+}
+
+int block_copy_call_status(BlockCopyCallState *call_state, bool *error_is_read)
+{
+    assert(call_state->finished);
+    if (error_is_read) {
+        *error_is_read = call_state->error_is_read;
+    }
+    return call_state->ret;
+}
+
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
 {
     return s->copy_bitmap;
-- 
2.21.3


