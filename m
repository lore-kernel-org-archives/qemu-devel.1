Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC1AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 14:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D31123BDC
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 14:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m+gx6qaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D31123BDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmedA-0004XV-K8
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 10:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmecI-0002OO-0C; Sat, 20 Jun 2020 10:37:10 -0400
Received: from mail-eopbgr50102.outbound.protection.outlook.com
 ([40.107.5.102]:35810 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmecF-0004UK-PL; Sat, 20 Jun 2020 10:37:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y55lQ0UgSGpO3wTgs26fcy+hfbmq7Yk/rMODwKCxsGMxx6+8tty1ehQoj0pOycS3PQBluc8FhUpaFpk091NYQ2Ym62B3vjtyD4vQENn4ZYa3DCPklxZMKSFkEoAXHbKAHjhOY0neMyXswto3iMRZcwoZ1QxYSSH/+l/phC/EvLKQMYyKiKowq2hEQaK7UTJY18yblJuG0dgWR23uR2fQrZD8da9S2vQc4dp5fIwivrdyXA4rGDWKI0RfrC8L9hPAtrGT19i/B9kCPVs9A721Twn6qV9Wxf1nbRisUwIAeZHVBuAODqrAhBODB3Hp2W+lo4mvp77m6W+HFi4sL/UO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR8zsYe66WSgb6b82kT6YRXSMo6yiJ8OZisrxVnh7sE=;
 b=YVy6FDhzEZKXzQwtdWYxBmVAUjfS80PMzMuvHIvzhe1M/dSzkqfd+uzQ/gPJ8cs0SdKrIvj+prwtnzLrI04M02NbgzTFlRpFyWUHy+ZJ8rUKrp5PNqWWP743UWjMcEgIOnWWISG5q2vUWa8wD0lCRMvM39NEkv03Qp0eNlguuw5Ngde1aTJD9VuKcdlRRlUkang+bJaozhWC9a5TI1VVVrTTKlcDWYQlu3t20IL1zQUOBeBKzWLrjLktS0LhmWz0CFoWvOp/AVIMt6aF2AOTRQ5x/NDGZdPq6/Xj6rdhAMQFi+Ak+/X1leK4ZqZGfdtpAAxKuH/tcJY+QX1H8sa4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR8zsYe66WSgb6b82kT6YRXSMo6yiJ8OZisrxVnh7sE=;
 b=m+gx6qaDDFZqbGLS8dTnTgevJb0FtGBQ2x2nUaScFreVPFbpoltihMLfo2FQN2NVbus1EupZ1+YRvLUNiV/V41zM5/270HkaAva57ySgim25M45VjNtIKhDIHPSlYmr0TES8iwOGu6p2YnxJwhrjqQnkUqeDvvbmBYady3sEEk0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Sat, 20 Jun
 2020 14:36:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 14:36:59 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/5] block/io: introduce bdrv_co_range_try_lock
Date: Sat, 20 Jun 2020 17:36:46 +0300
Message-Id: <20200620143649.225852-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200620143649.225852-1-vsementsov@virtuozzo.com>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR03CA0055.eurprd03.prod.outlook.com
 (2603:10a6:207:5::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.122) by
 AM3PR03CA0055.eurprd03.prod.outlook.com (2603:10a6:207:5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Sat, 20 Jun 2020 14:36:58 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9a29a0f-02a8-4290-c40d-08d815276390
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54304F1C568AE56D41A5EFDCC1990@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZmjHVwDi3L+d2bQPp1Uc2oiykDaf8eRV0YiPgsErEF/4dFdsttizLii5FJu1cbYOwLQO0Bk/Kb9qlrAKICHHm1nHLIHmLgRiPgWayuwkeNWUdg/O38wOxphjpSm4rzJk+iRJzL04GTvoUUS1snADlDSIFydX61KbJWRm+gcRT/ptKrs/76Qee52uMsIrZ88y7Z2Yy0cW5cAnQ3OcrEw8J0Fak9sU1mCg/9Vht89LVnwkcnLUfX6v0oidtMMUMH5ny7ca8+Y1gfWMOrd+fVDf1NTyDjRrXp4pWiwzNZ1R9Q1e0+4I9OJVysxWvkexha0o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39840400004)(6666004)(26005)(186003)(16526019)(86362001)(2906002)(6916009)(6512007)(4326008)(83380400001)(52116002)(2616005)(6506007)(478600001)(956004)(36756003)(5660300002)(30864003)(6486002)(8676002)(316002)(66946007)(8936002)(66476007)(1076003)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: QztczFfhUyaerOWpIWwyNmo3NFQ5IJnTRpbaNARDCMij+YMzB9e4O5mp3ju9htTuGCLT6Y5PcfVxqYcGDavz8bMHZ/52CIayNrHH3bjnu9mWsijmtHb/7O2ax0rqdZ3jOlHqDfk5+cpg3MGpeo1wFhrfayXSX13aUD5HKMN/sPzB1RU/J85WaMS03/gRhXobMTzkNXqxrkDSVH+lMisteg7dbquJ3tTPv8dFc9hbENB9wAwlCKQfa9YfvcPaOnycF7gDyv7dcPEpIhlmO1L2/FggyXKq/Bi5O8MkKYBOnkKVT3H62kZPWY/Z9hu3oujCpYuCb+ptxZjoSwUIzlFaVKrpcIlwsBajI791QC2bdCQx/GfsIKpYhVJhDjr0XzdTc5GrXT5OyVDP9FXWhXNVK16pjVBDzJOZDtisI1AA+OSxLJM23mVCtxotv76cPdiElo1DpX+KyJwu+xkST/Y0MeOdHWCtszqYkwd+c0dvFtY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a29a0f-02a8-4290-c40d-08d815276390
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 14:36:59.2947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7BrrGZm8wc58+UkJjAiAyTSjLHSiWVfTKLXZDXE8VBBFPazwvREnvWU5ppZtOU3VpZrGMkvVBGMByc74hQwaovRzCusi6c/N7rbCIjrgAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.5.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 10:36:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce an interface to make a "critical section" on top of
serialising requests feature. This is needed to avoid intersecting with
other requests during a set of operations. Will be used in a next
commit to implement preallocate filter.

To keep assertions during intersecting requests handling, we need to
add _locked versions of read/write requests, to be used inside locked
section. The following commit will need only locked version of
write-zeroes, so add only it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h     |  9 ++++
 include/block/block_int.h | 16 ++++++++
 include/qemu/typedefs.h   |  1 +
 block/io.c                | 86 +++++++++++++++++++++++++++++++--------
 4 files changed, 95 insertions(+), 17 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 25e299605e..c4b2a493b4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -391,6 +391,15 @@ int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
  */
 int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
                                        int bytes, BdrvRequestFlags flags);
+
+/*
+ * Version of bdrv_co_pwrite_zeroes to be used inside bdrv_co_range_try_lock()
+ * .. bdrv_co_range_unlock() pair.
+ */
+int coroutine_fn bdrv_co_pwrite_zeroes_locked(BdrvChild *child,
+    int64_t offset, int bytes, BdrvRequestFlags flags,
+    BdrvTrackedRequest *lock);
+
 BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     const char *backing_file);
 void bdrv_refresh_filename(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 791de6a59c..9ec56f1825 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -66,6 +66,7 @@ enum BdrvTrackedRequestType {
     BDRV_TRACKED_WRITE,
     BDRV_TRACKED_DISCARD,
     BDRV_TRACKED_TRUNCATE,
+    BDRV_TRACKED_LOCK,
 };
 
 typedef struct BdrvTrackedRequest {
@@ -83,6 +84,12 @@ typedef struct BdrvTrackedRequest {
     CoQueue wait_queue; /* coroutines blocked on this request */
 
     struct BdrvTrackedRequest *waiting_for;
+
+    /*
+     * If non-zero, the request is under lock, so it's allowed to intersect
+     * (actully it must be inside) the @lock request.
+     */
+    struct BdrvTrackedRequest *lock;
 } BdrvTrackedRequest;
 
 struct BlockDriver {
@@ -994,6 +1001,15 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
     int64_t offset, unsigned int bytes,
     QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
 
+/*
+ * Creates serializing BDRV_TRACKED_LOCK request if no conflicts, on success
+ * return pointer to it, to be used in bdrv_co_range_unlock().
+ */
+BdrvTrackedRequest *coroutine_fn bdrv_co_range_try_lock(BlockDriverState *bs,
+                                                        int64_t offset,
+                                                        int64_t bytes);
+void coroutine_fn bdrv_co_range_unlock(BdrvTrackedRequest *req);
+
 static inline int coroutine_fn bdrv_co_pread(BdrvChild *child,
     int64_t offset, unsigned int bytes, void *buf, BdrvRequestFlags flags)
 {
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index ecf3cde26c..e2bbe3af96 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -28,6 +28,7 @@ typedef struct Aml Aml;
 typedef struct AnnounceTimer AnnounceTimer;
 typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
 typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
+typedef struct BdrvTrackedRequest BdrvTrackedRequest;
 typedef struct BlockBackend BlockBackend;
 typedef struct BlockBackendRootState BlockBackendRootState;
 typedef struct BlockDriverState BlockDriverState;
diff --git a/block/io.c b/block/io.c
index 60cee1d759..0de72cdb4c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -691,7 +691,8 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
                                   BlockDriverState *bs,
                                   int64_t offset,
                                   uint64_t bytes,
-                                  enum BdrvTrackedRequestType type)
+                                  enum BdrvTrackedRequestType type,
+                                  BdrvTrackedRequest *lock)
 {
     assert(bytes <= INT64_MAX && offset <= INT64_MAX - bytes);
 
@@ -704,6 +705,7 @@ static void tracked_request_begin(BdrvTrackedRequest *req,
         .serialising    = false,
         .overlap_offset = offset,
         .overlap_bytes  = bytes,
+        .lock           = lock,
     };
 
     qemu_co_queue_init(&req->wait_queue);
@@ -745,15 +747,26 @@ static bool coroutine_fn wait_or_find_conflicts(BdrvTrackedRequest *self,
             if (tracked_request_overlaps(req, self->overlap_offset,
                                          self->overlap_bytes))
             {
-                /* Hitting this means there was a reentrant request, for
-                 * example, a block driver issuing nested requests.  This must
-                 * never happen since it means deadlock.
+                if (self->lock == req) {
+                    /* This is atomic request under range_lock */
+                    assert(req->type == BDRV_TRACKED_LOCK);
+                    assert(self->offset >= req->offset);
+                    assert(self->bytes <= req->bytes);
+                    continue;
+                }
+                /*
+                 * Hitting this means there was a reentrant request (except for
+                 * range_lock, handled above), for example, a block driver
+                 * issuing nested requests.  This must never happen since it
+                 * means deadlock.
                  */
                 assert(qemu_coroutine_self() != req->co);
 
-                /* If the request is already (indirectly) waiting for us, or
+                /*
+                 * If the request is already (indirectly) waiting for us, or
                  * will wait for us as soon as it wakes up, then just go on
-                 * (instead of producing a deadlock in the former case). */
+                 * (instead of producing a deadlock in the former case).
+                 */
                 if (!req->waiting_for) {
                     if (!wait) {
                         return true;
@@ -821,7 +834,6 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 }
 
 /* Return true on success, false if there are some conflicts */
-__attribute__ ((unused))
 static bool bdrv_try_mark_request_serialising(BdrvTrackedRequest *req,
                                               uint64_t align)
 {
@@ -1796,7 +1808,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
 
     bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad);
 
-    tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_READ);
+    tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_READ, NULL);
     ret = bdrv_aligned_preadv(child, &req, offset, bytes,
                               bs->bl.request_alignment,
                               qiov, qiov_offset, flags);
@@ -2169,9 +2181,9 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     return bdrv_co_pwritev_part(child, offset, bytes, qiov, 0, flags);
 }
 
-int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
+static int coroutine_fn bdrv_co_pwritev_part_locked(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_offset,
-    BdrvRequestFlags flags)
+    BdrvRequestFlags flags, BdrvTrackedRequest *lock)
 {
     BlockDriverState *bs = child->bs;
     BdrvTrackedRequest req;
@@ -2215,7 +2227,7 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
      * Pad qiov with the read parts and be sure to have a tracked request not
      * only for bdrv_aligned_pwritev, but also for the reads of the RMW cycle.
      */
-    tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_WRITE);
+    tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_WRITE, lock);
 
     if (flags & BDRV_REQ_ZERO_WRITE) {
         ret = bdrv_co_do_zero_pwritev(child, offset, bytes, flags, &req);
@@ -2239,8 +2251,23 @@ out:
     return ret;
 }
 
+int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
+    int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_offset,
+    BdrvRequestFlags flags)
+{
+    return bdrv_co_pwritev_part_locked(child, offset, bytes, qiov, qiov_offset,
+                                       flags, NULL);
+}
+
 int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
                                        int bytes, BdrvRequestFlags flags)
+{
+    return bdrv_co_pwrite_zeroes_locked(child, offset, bytes, flags, NULL);
+}
+
+int coroutine_fn bdrv_co_pwrite_zeroes_locked(BdrvChild *child, int64_t offset,
+                                              int bytes, BdrvRequestFlags flags,
+                                              BdrvTrackedRequest *lock)
 {
     trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
 
@@ -2248,8 +2275,8 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
         flags &= ~BDRV_REQ_MAY_UNMAP;
     }
 
-    return bdrv_co_pwritev(child, offset, bytes, NULL,
-                           BDRV_REQ_ZERO_WRITE | flags);
+    return bdrv_co_pwritev_part_locked(child, offset, bytes, NULL, 0,
+                                       BDRV_REQ_ZERO_WRITE | flags, lock);
 }
 
 /*
@@ -2980,7 +3007,7 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
     tail = (offset + bytes) % align;
 
     bdrv_inc_in_flight(bs);
-    tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_DISCARD);
+    tracked_request_begin(&req, bs, offset, bytes, BDRV_TRACKED_DISCARD, NULL);
 
     ret = bdrv_co_write_req_prepare(child, offset, bytes, &req, 0);
     if (ret < 0) {
@@ -3252,7 +3279,7 @@ static int coroutine_fn bdrv_co_copy_range_internal(
     if (recurse_src) {
         bdrv_inc_in_flight(src->bs);
         tracked_request_begin(&req, src->bs, src_offset, bytes,
-                              BDRV_TRACKED_READ);
+                              BDRV_TRACKED_READ, NULL);
 
         /* BDRV_REQ_SERIALISING is only for write operation */
         assert(!(read_flags & BDRV_REQ_SERIALISING));
@@ -3269,7 +3296,7 @@ static int coroutine_fn bdrv_co_copy_range_internal(
     } else {
         bdrv_inc_in_flight(dst->bs);
         tracked_request_begin(&req, dst->bs, dst_offset, bytes,
-                              BDRV_TRACKED_WRITE);
+                              BDRV_TRACKED_WRITE, NULL);
         ret = bdrv_co_write_req_prepare(dst, dst_offset, bytes, &req,
                                         write_flags);
         if (!ret) {
@@ -3381,7 +3408,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
 
     bdrv_inc_in_flight(bs);
     tracked_request_begin(&req, bs, offset - new_bytes, new_bytes,
-                          BDRV_TRACKED_TRUNCATE);
+                          BDRV_TRACKED_TRUNCATE, NULL);
 
     /* If we are growing the image and potentially using preallocation for the
      * new area, we need to make sure that no write requests are made to it
@@ -3494,3 +3521,28 @@ int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
 
     return bdrv_run_co(child->bs, bdrv_truncate_co_entry, &tco);
 }
+
+BdrvTrackedRequest *coroutine_fn bdrv_co_range_try_lock(BlockDriverState *bs,
+                                                        int64_t offset,
+                                                        int64_t bytes)
+{
+    BdrvTrackedRequest *req = g_new(BdrvTrackedRequest, 1);
+    bool success;
+
+    tracked_request_begin(req, bs, offset, bytes, BDRV_TRACKED_LOCK, NULL);
+    success = bdrv_try_mark_request_serialising(req, bdrv_get_cluster_size(bs));
+    if (!success) {
+        g_free(req);
+        req = NULL;
+    }
+
+    return req;
+}
+
+void coroutine_fn bdrv_co_range_unlock(BdrvTrackedRequest *req)
+{
+    assert(req->type == BDRV_TRACKED_LOCK);
+
+    tracked_request_end(req);
+    g_free(req);
+}
-- 
2.18.0


