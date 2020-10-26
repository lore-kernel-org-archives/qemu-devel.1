Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60692C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62F321D42
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Pkhsw0uf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62F321D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6NL-0001Ur-Ni
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68p-0007RI-D9; Mon, 26 Oct 2020 13:18:43 -0400
Received: from mail-eopbgr60108.outbound.protection.outlook.com
 ([40.107.6.108]:26030 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68m-0008Ma-Vg; Mon, 26 Oct 2020 13:18:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezzLgUSG4vBvP0L/mtLG0K0DX5lMqqtVj7p44sgUa2ff8Ts8nNI7ZEnWbHkcNNPyP1hZhWK2XQvtByKzD/q1efo3/Tq26X+XHYFtOTkQNL4LRMRFqQWbL+ywIvXV7zg65sMH3r7k8sJXNxcH8FVoPVM35c86D1cWPVU170IpanZZWWxfN0J0O3XADEdsHTjIR9pZXEOhqpSkiaFw8vvX/eTW5yWYS29b6M5mSh4wE2gJL/qTH6VuLWUsx/QJTc0QIwoOR6mdfQoMa6VnVU952IL6VppThaqxT/mqxvHE8C88nEhnDutQd/TYHpyKjA4+lPTyvbP8YaZCvUKs2mKUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpYxAJXMQcy3DpfbwLzmcNtDOhEpYjcfz+nUWm3o3xM=;
 b=MXtjiZWQpZcYy1YDsoJytStrp4gH218HT7BtS1ItKZVjmslsDbGrb8ELsgWvR2yX8yviNHujj5qD7vzmTG62D370huBvDYXlIa3Nm3GUI6wYUXMeN6Jx+OdBgCyWRfp+EgHrr9WxMoPpicdkpTl062w4qmE9Y2ZZbny5rc4m/34my7PNjvj/lj+RbfTX9XbsKwMk1AEjZTi0+JvzJuYPh+52Kjch5tCK/BijsswPrMPlNn8cptoSDvPT6i/fx1lO/9A96e2N88wCwiWJE7ox/fGgOlAgMhK7XigE+586sX+X++nYaeV7LRx/7KqJ2J3JG3VFgxy6ubZ92C6r1AYJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpYxAJXMQcy3DpfbwLzmcNtDOhEpYjcfz+nUWm3o3xM=;
 b=Pkhsw0ufA4EHAXVWDN4GI+Yt6dA5OZMfcbPQFdkU98CpMFdOXruRSNSH/GTz//2nuWdkYP+jORhqgixR1F08s0fZ8819oitW85D7+naQRFWTgOLZBA1hCK88UXnSgNJzt66amLPQDueclOSN/wAGx9FKJonOkDvcdT62J0aC92U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5031.eurprd08.prod.outlook.com (2603:10a6:20b:ed::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:32 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:32 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 03/25] block/block-copy: More explicit call_state
Date: Mon, 26 Oct 2020 20:17:53 +0300
Message-Id: <20201026171815.13233-4-vsementsov@virtuozzo.com>
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
 Transport; Mon, 26 Oct 2020 17:18:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24470c34-b60e-495e-27e2-08d879d32a0e
X-MS-TrafficTypeDiagnostic: AM6PR08MB5031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB50312AF80E7388D579E40888C1190@AM6PR08MB5031.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXEtJ38JcKn58Eo5IHRE6lYYdxCPCT1jxZn4iHdeADxBFqB3ujkZqjByll7Q8TOqlmQXU5FS5s8esqLjUyTayNr4xzJWcF3wn32wxBKLL5fPt0Wq0Qcq+XHPF747shRkKxmyKYDKczPziKxC6o+Lcc4YmpVrOtviGMrIev2X0Z0QdwVf6SKtR+MhS6/ZBVJ0oDvUy7nd1SMSEuI+jmB8rynb/bYgQ3lXRfpnQS9Cui4IhJVXRiTPCiRXkhFEyyoIhs9luiMsClzlDPOsf5D2IJ2JiojXnAwIUa7vbtTdY5aloXVVXyhFrkUtf8VLz21tntQVaV6FbsFlXJ07Hp6lBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39840400004)(346002)(376002)(396003)(83380400001)(5660300002)(1076003)(316002)(2616005)(478600001)(6506007)(4326008)(6666004)(66946007)(26005)(66556008)(956004)(36756003)(6486002)(6512007)(186003)(66476007)(8936002)(52116002)(2906002)(16526019)(107886003)(8676002)(6916009)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 13NGWWeUYSkw49EQoNJwP8jwFnOT0SuytZbv3Eo6Sig9YT2Js3QpdNm5I7NvN9oEKN++t3hz2bKjiB3HYaK3fgep/hCpV3zY3iQuAag5VDgPAEkumXW55AT/HzY40z7WOTRv1TTrIxv/ns+zFM7ZSaPrNpMpXwSL6XtGIhf8+0VwsF0V1LKbWyGD8Jgm6W2slZj5TvmNQhUqrmXUFr/U+cwWDU4qjR9ACjv6OvkCVohr2Cx1OMgAoSb9y7t26D5x5Fj9vMYKzZxpEqghhv3zLN48mXkH4ns2NnTZfedKvLu/jaGMxxHsMPSEfLuKlsQz+Vm5MQ5IkdfFFXYw/fsL6ON4e8KfznQUO/JenoHy3jTgwH1/ygH+OZF+3ynvz0akgxNHGx070zecGcH8XKCWAjOL63OOTRobNn7VUr+9MHbUHhLYdKFxPxXtMYQoRiGBetxe/hwZwQc/V79OCsY5BEj1ryz7jAtEUOCSnbkDxaUDaqiwlRY/P0OZ2NggcZGWuarnnBeI/+eviuG+K8L++T/czGyV3LUrJZq5+REBfNjl++YxcVAp68rOtM1J7OBpe5KJhrPxuQGXYiyaJ27c8a/OAiGz/QNE1lHOjp75IrXM303xQe1AClRRTldJsmzSi6ExP5Jx9NBUVqvihcmbfw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24470c34-b60e-495e-27e2-08d879d32a0e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:32.4731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkxuMOM4O4tsqtG8N2ahaSaDC50UgFbEmlh7x1O5OpyJMx/xmBpyWwMsq/SN9PQSgWQKKxVxf9ZNyZ9y9Pq0jc9ZN+B+XFzMMVvopkGv2qI=
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

Refactor common path to use BlockCopyCallState pointer as parameter, to
prepare it for use in asynchronous block-copy (at least, we'll need to
run block-copy in a coroutine, passing the whole parameters as one
pointer).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 51 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 63398a171c..6ea55f1f9a 100644
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
 
@@ -544,15 +552,17 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s,
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
@@ -568,7 +578,7 @@ static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
         BlockCopyTask *task;
         int64_t status_bytes;
 
-        task = block_copy_task_create(s, &call_state, offset, bytes);
+        task = block_copy_task_create(s, call_state, offset, bytes);
         if (!task) {
             /* No more dirty bits in the bitmap */
             trace_block_copy_skip_range(s, offset, bytes);
@@ -633,15 +643,12 @@ out:
 
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
@@ -649,16 +656,16 @@ out:
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
@@ -675,6 +682,24 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
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
2.21.3


