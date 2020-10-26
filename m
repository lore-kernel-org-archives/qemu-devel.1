Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986BFC388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1801021D7B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="R0AbUTHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1801021D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6G6-0000f5-25
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68l-0007I8-5K; Mon, 26 Oct 2020 13:18:39 -0400
Received: from mail-eopbgr60093.outbound.protection.outlook.com
 ([40.107.6.93]:39555 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68i-0008NC-Vm; Mon, 26 Oct 2020 13:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMhxrdPvujfjiZaYdwbKkefekSKi/Ew1z9N4WqtYgEk7X1PVurcp28DJWrM3ze1MwEWr8HjZkZTOulEpQUBtrIkF6RsyDdODns5mD9QW9xzO2SEQV8oOmWi3kL4qlOQ0Wbnbgi/Ou2IVSLp9J1tdzzb/UG7nFBxSvS/Pp5caYzZNzkDwJc40fqo6clR6cD8BSCTV8ovP0IByAZZ5o9WfORvA/O5uzbeGhfZQbv92u1mghuvHawiFt4bbleTqV2JDQXd1B3mBtMp3CNdVQ/9f0nRbcq5qlz8HMAGxhtkCmaCh9bgqTn6Tpyh2JPRUSpuVz/h0meXBCTqPtRhmSVEQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0vSNibjRCeh5JNFCyq96MD/O+hOQ5PexFF/sHwk8Lg=;
 b=fCi9oVygzdKtPR+iUA7QxAHqngqQOE2odr780V9raoJphDSNOQufigaaJT3vV/I7R9nAWaPu4Q2F6upVpt1ecqU1OLT6/KCd23O+tAczO37Fkq2OItxAn5YxR5p9ezGoUO07hoMLO18TmcHA6R0rlbSWsqJnGxZnI1Tjh0mkTcHppRY/7keTTxLLiBb8vm/H1fUI73EqP1KY/6d3LiR12N1pMhwJk6cnZMiTaJYyFb6yNr6Jq1P/xsBcwYzpB8vgpGQLHy78aEBBhG2EAMmWCV2fFLiXcrg4kIIoxCpa8+jAW7xhW6/dYyJeimjAIoIB71AtNPTqBcSmpsPsrrNZoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0vSNibjRCeh5JNFCyq96MD/O+hOQ5PexFF/sHwk8Lg=;
 b=R0AbUTHKbjT4eqNU7q47+PbqvzrF4F3bMo1y61eolVQRAkdEz7T18cvDo3HeYywa/VorX/xI2mJTnQZ1AIzF8QlNYIbRgDpJRqUPFlzUGXwab2FJkgCBK9fcoZnNvBxHBc4A/6UOeX3qXM7W888qQUknNH50363XQ937soelpR4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:34 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:34 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 05/25] block/block-copy: add max_chunk and max_workers
 parameters
Date: Mon, 26 Oct 2020 20:17:55 +0300
Message-Id: <20201026171815.13233-6-vsementsov@virtuozzo.com>
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
 Transport; Mon, 26 Oct 2020 17:18:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a73cb93d-1238-40b6-9007-08d879d32b17
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032C2050EBE954C6E85AE30C1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VufAhORBK24usxJe0nHEkfai0cHaJ7Dq8BClCFNJRf4wmC8fvooe0IyhWMD7BW9OIQTBTLrKGdXsC0+tO0FsrLn2SO9QXlJwvsTPip6zNCMd6TQwEWCAbmSPr3SJwZT/un4PZ/yibwWj7ZS+PvItva9ZPvSi3ZUH/nQnW4M0mkY2T1JN4oF5KK59iYk9nTYokzKEbbVwn5Za4yPMyQCfdNhVa/Hn9GcS4i8RM50f2OzvhHvE13CLsCkRrXZG1HJ3yyl+OkGwM0zKO0YbEKz315JQJXZ2cb/DTXw2fMhA9du8Ek/QrtQOXeIlo3VQk61J/DUDgV3sewtQpQlzhofPmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sCEnxzpZKo2IcHjXB02aOzjQoCNBZYhmLGLQh19mtd4O0IS8jgX+IESjHB7xAQylOMersSZsy1zQEr3SAt/hQ1x3OKNXxw5B8h/Ny4swdG7btRxOEWfBTeuaQtLtmQWwTr42s+4e62m/0rpFd8zOhAw+k55iq7LvjaL2/EK652wMbAI1Ju8aV9F7mREjHwt3wKwpo6ONTYN9GUeaGH+Ma5okSpVOx45ovT6N1KBmxz2Mlp9qrt/05NZFSqf906unbpiLHjO9y6KXpU/B+i3hZZGyfO50YJtyDqeK6M8zN0Wj08PzUqcLq7YEx4qiGLNKDU4FeHMG9VJHo7+Pcp4S8/nKHnJymhLW8ZyBV5r9hUy/7kzEMbSBUV/F4NwTNqez4cPskLHyg4oVmEYqCQdZYw7MIRfYhzGsm/lHSLAC+t+FZskInkrpL1cDGe1XYR5lmMBxuJoG8hoeoUPJsYpVTCSzr4xOteWGhmJsnUY//FLypdZ4F89efI4jfCvkH/OB+xn+NCNPKMWNbsGpra2fjJIkIdPJFInylzIaHdOAVih1SSSZQ3l9xSTnLCk3GHOuXuSPL4fDLRRN0BSJoeoTF/kbqlCdERn90Ny+c6eBycWfaIUQ+ONhMLn+6AivMUB5t7VRq2t/pMxFkNQ8/meGtQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73cb93d-1238-40b6-9007-08d879d32b17
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:34.2204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIJG2nuwLm7pHYFzr9loFA3ak3rMQXJSQw1erVQCng6N1QbFNPB3TsKO4KM6h4raTWcFXy3EPhU8ud3ZJL/Ao6Z2zcN9d7Ir/D/DTu0LKLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.6.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:35
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

They will be used for backup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h |  6 ++++++
 block/block-copy.c         | 11 +++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 3566827599..57806e8a49 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -49,9 +49,15 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
  *
  * Caller is responsible to call block_copy_call_free() to free
  * BlockCopyCallState object.
+ *
+ * @max_workers means maximum of parallel coroutines to execute sub-requests,
+ * must be > 0.
+ *
+ * @max_chunk means maximum length for one IO operation. Zero means unlimited.
  */
 BlockCopyCallState *block_copy_async(BlockCopyState *s,
                                      int64_t offset, int64_t bytes,
+                                     int max_workers, int64_t max_chunk,
                                      BlockCopyAsyncCallbackFunc cb,
                                      void *cb_opaque);
 
diff --git a/block/block-copy.c b/block/block-copy.c
index 74655b86f8..35213bd832 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -34,6 +34,8 @@ typedef struct BlockCopyCallState {
     BlockCopyState *s;
     int64_t offset;
     int64_t bytes;
+    int max_workers;
+    int64_t max_chunk;
     BlockCopyAsyncCallbackFunc cb;
     void *cb_opaque;
 
@@ -148,10 +150,11 @@ static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
                                              int64_t offset, int64_t bytes)
 {
     BlockCopyTask *task;
+    int64_t max_chunk = MIN_NON_ZERO(s->copy_size, call_state->max_chunk);
 
     if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap,
                                            offset, offset + bytes,
-                                           s->copy_size, &offset, &bytes))
+                                           max_chunk, &offset, &bytes))
     {
         return NULL;
     }
@@ -623,7 +626,7 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
         bytes = end - offset;
 
         if (!aio && bytes) {
-            aio = aio_task_pool_new(BLOCK_COPY_MAX_WORKERS);
+            aio = aio_task_pool_new(call_state->max_workers);
         }
 
         ret = block_copy_task_run(aio, task);
@@ -701,6 +704,7 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
         .s = s,
         .offset = start,
         .bytes = bytes,
+        .max_workers = BLOCK_COPY_MAX_WORKERS,
     };
 
     int ret = block_copy_common(&call_state);
@@ -719,6 +723,7 @@ static void coroutine_fn block_copy_async_co_entry(void *opaque)
 
 BlockCopyCallState *block_copy_async(BlockCopyState *s,
                                      int64_t offset, int64_t bytes,
+                                     int max_workers, int64_t max_chunk,
                                      BlockCopyAsyncCallbackFunc cb,
                                      void *cb_opaque)
 {
@@ -728,6 +733,8 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
         .s = s,
         .offset = offset,
         .bytes = bytes,
+        .max_workers = max_workers,
+        .max_chunk = max_chunk,
         .cb = cb,
         .cb_opaque = cb_opaque,
 
-- 
2.21.3


