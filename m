Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8F5C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237E420679
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DMGaTap2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237E420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQU7E-0007ua-Bi
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 06:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60496 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQU6K-000767-Mt
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:56:35 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQU6H-0002QU-Rv
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:56:32 -0400
Received: from mail-eopbgr140090.outbound.protection.outlook.com
 ([40.107.14.90]:11027 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQU69-0002Em-0D; Mon, 20 Apr 2020 06:56:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwrWUhpR+XTZysHMD01477rIoGww6NXM2aQSkEAbOG6EWfzQmsVq+iVNQd8EJBXNCr6mZAttpTfypPn4TeL051r2/hctT5sFLuJ3vaxJtEULhbWt9oBiLRzJ4OIl9lf8KNz67qJUQK/NjYuGK42VNtURtluEOHjpxtIy8HI+Jc4Zk8vI2FBWr+Lsbh2D+Srjwzf0P7jqbgKJ7XkM5xRv5uQjUHrkiWr5HukRMaUoq4fsfbJldRS8zninXwNdgyz4lk8rBWDIeh4jw4cCDahUb5BYYoBYdTqCIFpvb0nJ1LSBAyK6TEIHxUn8ZJcOaYsUCF3ON3kSfLFJ7Bo44N38Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsBQJqupiHYHBYERkjuH76d6M5CMwgw6lyqshFZfdwI=;
 b=I/aZjAxxfN+hkT8qZQ4xEeNGfO/e8sJmSa5Ub6LO/KGQBKRAuWpayA4nISeq8DOADuEgpzjoRmYh6ftLwGgfkvY2XUdigL/sLjPfET2SpI7Oz2YzySP6eQwDM+2aQOlwBClAwOYhzb0cwu817dATbe4AfXcYLYjNLAy4bprbllg1k4SiKFcr+wsLOl77bKfMY8v8zDvASIDFyYhoq6T1gJIF27e5sZWddYybhQdIK9exd7nyyxFeqEh2h3zQMoBMvS8twCirBFZm7zu8To65TsOzBfoO1C6NtpzQ1idCw1gREXYyypIdjJl8mENkbd1e99LzgU4uktTgDrjeoqii8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsBQJqupiHYHBYERkjuH76d6M5CMwgw6lyqshFZfdwI=;
 b=DMGaTap2l/OZQtJDjSs3hXredbRBa+4OUZb8TQBdQfqrLWPRW/S7M2EmCi3/scHWqD07REJ9pTEQ0GRK581B7764DFwaAQKiJJBge1xu+se6Nt0Lb5rxG2828x9ObRmqvBi4sNjgW9ndBpkbIWVeAoTFwYVF/d/JY7Efkpczsks=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5350.eurprd08.prod.outlook.com (2603:10a6:20b:101::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 10:56:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 10:56:15 +0000
Subject: Re: Avoid copying unallocated clusters during full backup
To: Leo Luan <leoluan@gmail.com>, John Snow <jsnow@redhat.com>
References: <CAD_3s9Jnd9BzkZAe6SEKz7unuxJHY502pNdUgxrC3MOQAFj9Hw@mail.gmail.com>
 <ba8ff0c2-2e56-c8d7-a13a-4af48372f172@redhat.com>
 <7c722a98-29ab-ba65-2f19-088628ce8f00@redhat.com>
 <CAD_3s9KuB7QaXCTygRfOsscXbrhm0kHbHRpUjb51EiwRpEM5MA@mail.gmail.com>
 <93052f9b-6539-0d4a-c922-fff7618c542d@redhat.com>
 <CAD_3s9+pSepV76-wp_AQTB-EQGwmga1FS+fT-Cb4n0Z48Zhxpg@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200420135613368
Message-ID: <3399bbd8-a85b-9e42-cd16-a40c4a963e9e@virtuozzo.com>
Date: Mon, 20 Apr 2020 13:56:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <CAD_3s9+pSepV76-wp_AQTB-EQGwmga1FS+fT-Cb4n0Z48Zhxpg@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------F7279DB740026883E8E91159"
Content-Language: en-US
X-ClientProxiedBy: AM3PR04CA0127.eurprd04.prod.outlook.com (2603:10a6:207::11)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.166) by
 AM3PR04CA0127.eurprd04.prod.outlook.com (2603:10a6:207::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 10:56:14 +0000
X-Tagtoolbar-Keys: D20200420135613368
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6cf7b83-67ba-4039-194c-08d7e519722b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5350203993B3424F75FEBA47C1D40@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(376002)(136003)(366004)(39840400004)(346002)(66616009)(5660300002)(4326008)(31696002)(66946007)(31686004)(66556008)(6486002)(478600001)(966005)(66476007)(2906002)(86362001)(316002)(36756003)(110136005)(235185007)(54906003)(186003)(956004)(2616005)(16526019)(16576012)(26005)(52116002)(8936002)(8676002)(81156014)(33964004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEH05fMSKb9wx2Jm58dvBzkCxaEh7eiV0De9EBvMT9D3AXyM9mwspaotMQBE/cAZxobk5MDYLA6Cjs6fMFAYyK6tQ8jtSuj7rsbeJGaZLjTtLgxcNkGLKvHAOQ5RfBa22GgIfcVpT6D0OTgzCHDT5tHlpNvVkQmQXhhq+Zd/mS0B5R+RdIKH1o3j1Fjdk/EjkjE+70o14OPF/FBS0p+Vg3sh3Ea7mtVa5yUxBeu3B3dTBO10REjg8kW1NE7jSyeADdpNu/lTurbJ5uJCRn5GiRGC5jKM0mpXWClY6u1noMNeGozc2+zJDN8GC27cyz62f26YtX7mqzuuwalpwDXjwLkHVe/oTVNoStKtQMbPSILzJe4dLRC2e+2gC9VvZY8VCDAJFX5PTLT883TkZHSjyl4yzxTvPJ+p4UbDFttSPVr6ggmvQgVUD+fHy2NW0s8BduHb89VHUyZCaW3149P8hy5ut6z6nrSaqzMvA9UI7SKkd5CURCLVKNyMknxnPim7sYyeefIl9APSjGMiM6E5Qg==
X-MS-Exchange-AntiSpam-MessageData: jpdRtegChIOXiyIeGsdIc1CnWMF+Gj+qwvO2QGOWQNXHAui42s4inrZ7FX1lqADhDB33+c9I5JHHna+ZkNOH9q8BI4qfZaWbLetxpcpna8yTfCE1AEZG0VuyTWiJz3PONu2t4PoEvr3dXshvnVV0+A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cf7b83-67ba-4039-194c-08d7e519722b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 10:56:15.2089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14m6OFbCGjrX7Ga6PZyujZl+nrwe44MBflbZJFu+bV/Y08yjkOYQpz54pSRmrexGJeBwKBcaza2CJH8nbFwknFQeIHISHOmT3f92f30LZxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
Received-SPF: pass client-ip=40.107.14.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 06:56:16
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.14.90
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
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--------------F7279DB740026883E8E91159
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all!

Yes, I have big work-in-progress around backup, and I'm posting it part-by-part,
current chunk is "[PATCH v2 0/6] block-copy: use aio-task-pool", at
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07671.html

The final target is backup job, which does only one block_copy() call.
It already works this way in Virtuozzo-8.0, and there is old outdated series,
which may give an idea of the full picture:
[RFC 00/24] backup performance: block_status + async
https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg02335.html

After it, next steps are to reuse block_copu() for other jobs and qemu-img convert.

===

About skipping zeroes for FULL-mode.

1. Honestly, we have this skipping hardcoded in our downstream for a long time,
I'll attache the patch from vz-8.0.

To upstream it, we still lack one thing: knowledge, is target is already zeroed.
(for downstream, we just sure, that in all our scenarios backup target is a new
qcow2 image, all-zeros of course).

I think, we already have an unspoken agreement, that a kind of target-is-zero
option is appropriate way to achieve it, and qemu-img already has it..

On the other hand, I think, the best way of being sure in target-is-zero is just
to zero it. But to do it effectively for our most interesting scenarios (qcow2, NBD),
we need the following steps:

1. 64bit commands in NBD
2. 64bit write-zeroes in Qemu generic block-layer
3. support 64bit write-zeroes in qcow2 and nbd driver in Qemu

For 1,2 I have sent series..

===

Hmm. So, what to do now?

1. You can use downstream patch, like we in Virtuozzo, if it is appropriate for you.

2. Implement feature upstream. Most simple way is to add a skip-zeroes
option for backup job, and than, in case of the option enabled, do something like
in my patch (or just port it). Do you want to make patches? If not, I can handle it myself.

-- 
Best regards,
Vladimir

--------------F7279DB740026883E8E91159
Content-Type: text/x-patch;
 name="0001-backup-skip-copying-unallocated-for-full-mode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-backup-skip-copying-unallocated-for-full-mode.patch"

From b96914dab04ee82d44cf4ebf712ba414fea36538 Mon Sep 17 00:00:00 2001
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 23 Jan 2020 21:01:01 +0300
Subject: [PATCH] backup: skip copying unallocated for full mode

This improves full backup of (partly) empty qcow2 disk.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block-copy.h     |   3 +-
 block/backup.c                 |  12 ++-
 block/block-copy.c             |  18 +++-
 tests/qemu-iotests/056         |   6 +-
 tests/qemu-iotests/1000001     |   1 +
 tests/qemu-iotests/1000001.out |   2 +-
 tests/qemu-iotests/185.out     |   2 +-
 tests/qemu-iotests/256.out     |   4 +-
 tests/qemu-iotests/257         |  10 +--
 tests/qemu-iotests/257.out     | 148 ++++++++++++++++-----------------
 10 files changed, 112 insertions(+), 94 deletions(-)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index fcbc06b977..c0bceb6f57 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -70,6 +70,7 @@ void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_state,
 void block_copy_cancel(BlockCopyCallState *call_state);
 
 BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
-void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
+void block_copy_set_options(BlockCopyState *s, bool skip_unallocated,
+                            bool top_mode);
 
 #endif /* BLOCK_COPY_H */
diff --git a/block/backup.c b/block/backup.c
index ae191cb276..53791983fd 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -202,12 +202,15 @@ static void backup_init_bcs_bitmap(BackupBlockJob *job)
                                                NULL, true);
         assert(ret);
     } else {
-        if (job->sync_mode == MIRROR_SYNC_MODE_TOP) {
+        if (job->sync_mode == MIRROR_SYNC_MODE_TOP ||
+            job->sync_mode == MIRROR_SYNC_MODE_FULL)
+        {
             /*
              * We can't hog the coroutine to initialize this thoroughly.
              * Set a flag and resume work when we are able to yield safely.
              */
-            block_copy_set_skip_unallocated(job->bcs, true);
+            block_copy_set_options(job->bcs, true,
+                                   job->sync_mode == MIRROR_SYNC_MODE_TOP);
         }
         bdrv_set_dirty_bitmap(job->bcs_bitmap, 0, job->len);
     }
@@ -223,7 +226,9 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
 
     backup_init_bcs_bitmap(s);
 
-    if (s->sync_mode == MIRROR_SYNC_MODE_TOP) {
+    if (s->sync_mode == MIRROR_SYNC_MODE_TOP ||
+        s->sync_mode == MIRROR_SYNC_MODE_FULL)
+    {
         int64_t offset = 0;
         int64_t count;
 
@@ -245,7 +250,6 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
 
             offset += count;
         }
-        block_copy_set_skip_unallocated(s->bcs, false);
     }
 
     if (s->sync_mode == MIRROR_SYNC_MODE_NONE) {
diff --git a/block/block-copy.c b/block/block-copy.c
index ed51e6c0a6..f7fe6631eb 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -96,6 +96,7 @@ typedef struct BlockCopyState {
      * block_copy_reset_unallocated() every time it does.
      */
     bool skip_unallocated;
+    bool top_mode;
 
     ProgressMeter *progress;
 
@@ -438,7 +439,7 @@ static int block_copy_block_status(BlockCopyState *s, int64_t offset,
     BlockDriverState *base;
     int ret;
 
-    if (s->skip_unallocated && s->source->bs->backing) {
+    if (s->top_mode && s->source->bs->backing) {
         base = s->source->bs->backing->bs;
     } else {
         base = NULL;
@@ -471,14 +472,21 @@ static int block_copy_is_cluster_allocated(BlockCopyState *s, int64_t offset,
                                            int64_t *pnum)
 {
     BlockDriverState *bs = s->source->bs;
+    BlockDriverState *base;
     int64_t count, total_count = 0;
     int64_t bytes = s->len - offset;
     int ret;
 
+    if (s->top_mode && s->source->bs->backing) {
+        base = s->source->bs->backing->bs;
+    } else {
+        base = NULL;
+    }
+
     assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
 
     while (true) {
-        ret = bdrv_is_allocated(bs, offset, bytes, &count);
+        ret = bdrv_is_allocated_above(bs, base, false, offset, bytes, &count);
         if (ret < 0) {
             return ret;
         }
@@ -759,9 +767,11 @@ BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
     return s->copy_bitmap;
 }
 
-void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip)
+void block_copy_set_options(BlockCopyState *s, bool skip_unallocated,
+                            bool top_mode)
 {
-    s->skip_unallocated = skip;
+    s->skip_unallocated = skip_unallocated;
+    s->top_mode = top_mode;
 }
 
 void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_state,
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index ead0c0773f..6bd4ab887e 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -102,9 +102,11 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):
         time.sleep(1)
         self.assertEqual(-1, qemu_io('-c', 'read -P0x41 0 512', target_img).find("verification failed"))
 
-class TestBeforeWriteNotifier(iotests.QMPTestCase):
+class TestCopyBeforeWrite(iotests.QMPTestCase):
     def setUp(self):
-        self.vm = iotests.VM().add_drive_raw("file=blkdebug::null-co://,id=drive0,align=65536,driver=blkdebug")
+        opts = "image.driver=null-co,image.read-zeroes=on," \
+            "id=drive0,align=65536,driver=blkdebug"
+        self.vm = iotests.VM().add_drive_raw(opts)
         self.vm.launch()
 
     def tearDown(self):
diff --git a/tests/qemu-iotests/1000001 b/tests/qemu-iotests/1000001
index d9e272f017..16b273cf91 100644
--- a/tests/qemu-iotests/1000001
+++ b/tests/qemu-iotests/1000001
@@ -22,6 +22,7 @@ import iotests
 from iotests import log, qemu_img, qemu_io, qemu_io_silent
 
 iotests.verify_platform(['linux'])
+iotests.verify_image_format(['qcow2'])
 
 patterns = [("0x5d", "0",         "64k"),
             ("0xd5", "1M",        "64k"),
diff --git a/tests/qemu-iotests/1000001.out b/tests/qemu-iotests/1000001.out
index a341220d07..5f5d456a4d 100644
--- a/tests/qemu-iotests/1000001.out
+++ b/tests/qemu-iotests/1000001.out
@@ -25,7 +25,7 @@ write -P0x1d 0x2008000 64k
 {"return": ""}
 write -P0xea 0x3fe0000 64k
 {"return": ""}
-{"data": {"device": "backup-job-2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup-job-2", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Cleanup ---
 
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index ddfbf3c765..f4c8c1c968 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -54,7 +54,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 l
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offset": 65536, "speed": 65536, "type": "backup"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset": 65536, "speed": 65536, "type": "backup"}}
 
 === Start streaming job and exit qemu ===
 
diff --git a/tests/qemu-iotests/256.out b/tests/qemu-iotests/256.out
index f18ecb0f91..4f7e39e32e 100644
--- a/tests/qemu-iotests/256.out
+++ b/tests/qemu-iotests/256.out
@@ -62,8 +62,8 @@
 {
   "return": {}
 }
-{"data": {"device": "j0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "j1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "j0", "len": 0, "offset": 0, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "j1", "len": 0, "offset": 0, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Create Targets & Incremental Backups ---
 
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 908d728bf1..e1474675a8 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -383,17 +383,17 @@ def test_bitmap_sync(bsync_mode, msync_mode='bitmap', failure=None):
 
         if bsync_mode == 'always' and failure == 'intermediate':
             # TOP treats anything allocated as dirty, expect to see:
-            if msync_mode == 'top':
+            if msync_mode in ('top', 'full'):
                 ebitmap.dirty_group(0)
 
             # We manage to copy one sector (one bit) before the error.
             ebitmap.clear_bit(ebitmap.first_bit)
 
             # Full returns all bits set except what was copied/skipped
-            if msync_mode == 'full':
-                fail_bit = ebitmap.first_bit
-                ebitmap.clear()
-                ebitmap.dirty_bits(range(fail_bit, SIZE // GRANULARITY))
+            #if msync_mode == 'full':
+                #fail_bit = ebitmap.first_bit
+                #ebitmap.clear()
+                #ebitmap.dirty_bits(range(fail_bit, SIZE // GRANULARITY))
 
         ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=bitmaps))
 
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index 6997b56567..47bf67e57b 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -32,7 +32,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -80,7 +80,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -207,7 +207,7 @@ expecting 15 dirty sectors; have 15. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -292,7 +292,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -340,7 +340,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 {"return": ""}
 
@@ -418,7 +418,7 @@ expecting 14 dirty sectors; have 14. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -503,7 +503,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -551,7 +551,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -678,7 +678,7 @@ expecting 15 dirty sectors; have 15. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -763,7 +763,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -811,7 +811,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -938,7 +938,7 @@ expecting 15 dirty sectors; have 15. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -1023,7 +1023,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -1071,7 +1071,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 {"return": ""}
 
@@ -1149,7 +1149,7 @@ expecting 14 dirty sectors; have 14. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -1234,7 +1234,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -1282,7 +1282,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -1409,7 +1409,7 @@ expecting 12 dirty sectors; have 12. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -1494,7 +1494,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -1542,7 +1542,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -1669,7 +1669,7 @@ expecting 12 dirty sectors; have 12. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -1754,7 +1754,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -1802,7 +1802,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 {"return": ""}
 
@@ -1880,7 +1880,7 @@ expecting 13 dirty sectors; have 13. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -1965,7 +1965,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -2013,7 +2013,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -2140,7 +2140,7 @@ expecting 12 dirty sectors; have 12. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -2225,7 +2225,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -2273,7 +2273,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -2339,7 +2339,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"execute": "job-cancel", "arguments": {"id": "backup_1"}}
 {"return": {}}
 {"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "drive0": [
@@ -2400,7 +2400,7 @@ expecting 15 dirty sectors; have 15. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -2485,7 +2485,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -2533,7 +2533,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 {"return": ""}
 
@@ -2550,7 +2550,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "full", "target": "backup_target_1", "x-max-workers": 1}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_1", "error": "Input/output error", "len": 67108864, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "error": "Input/output error", "len": 458752, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "drive0": [
@@ -2611,7 +2611,7 @@ expecting 14 dirty sectors; have 14. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -2696,7 +2696,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -2744,7 +2744,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -2810,7 +2810,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_1"}}
 {"return": {}}
 {"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "drive0": [
@@ -2871,7 +2871,7 @@ expecting 12 dirty sectors; have 12. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -2956,7 +2956,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -3004,7 +3004,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -3070,7 +3070,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"execute": "job-cancel", "arguments": {"id": "backup_1"}}
 {"return": {}}
 {"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "drive0": [
@@ -3131,7 +3131,7 @@ expecting 12 dirty sectors; have 12. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -3216,7 +3216,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -3264,7 +3264,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 {"return": ""}
 
@@ -3281,13 +3281,13 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-node-name": "backup-top", "job-id": "backup_1", "sync": "full", "target": "backup_target_1", "x-max-workers": 1}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_1", "error": "Input/output error", "len": 67108864, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "error": "Input/output error", "len": 458752, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "drive0": [
       {
         "busy": false,
-        "count": 66125824,
+        "count": 393216,
         "granularity": 65536,
         "name": "bitmap0",
         "persistent": false,
@@ -3299,7 +3299,7 @@ expecting 6 dirty sectors; have 6. OK!
 }
 
 = Checking Bitmap bitmap0 =
-expecting 1009 dirty sectors; have 1009. OK!
+expecting 6 dirty sectors; have 6. OK!
 
 --- Write #3 ---
 
@@ -3316,7 +3316,7 @@ write -P0xdd 0x3fc0000 0x10000
     "drive0": [
       {
         "busy": false,
-        "count": 66453504,
+        "count": 917504,
         "granularity": 65536,
         "name": "bitmap0",
         "persistent": false,
@@ -3328,7 +3328,7 @@ write -P0xdd 0x3fc0000 0x10000
 }
 
 = Checking Bitmap bitmap0 =
-expecting 1014 dirty sectors; have 1014. OK!
+expecting 14 dirty sectors; have 14. OK!
 
 --- Reference Backup #2 ---
 
@@ -3342,7 +3342,7 @@ expecting 1014 dirty sectors; have 1014. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -3359,7 +3359,7 @@ expecting 1014 dirty sectors; have 1014. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
 {"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_2", "len": 66453504, "offset": 66453504, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 917504, "offset": 917504, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "drive0": [
@@ -3427,7 +3427,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -3475,7 +3475,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -3541,7 +3541,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_1"}}
 {"return": {}}
 {"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "drive0": [
@@ -3602,7 +3602,7 @@ expecting 12 dirty sectors; have 12. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -3687,7 +3687,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -3735,7 +3735,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -3862,7 +3862,7 @@ expecting 15 dirty sectors; have 15. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -3947,7 +3947,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -3995,7 +3995,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 {"return": ""}
 
@@ -4073,7 +4073,7 @@ expecting 14 dirty sectors; have 14. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -4158,7 +4158,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -4206,7 +4206,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -4333,7 +4333,7 @@ expecting 12 dirty sectors; have 12. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -4418,7 +4418,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -4466,7 +4466,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -4593,7 +4593,7 @@ expecting 12 dirty sectors; have 12. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -4678,7 +4678,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -4726,7 +4726,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 {"return": ""}
 
@@ -4804,7 +4804,7 @@ expecting 14 dirty sectors; have 14. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
@@ -4889,7 +4889,7 @@ write -P0x76 0x3ff0000 0x10000
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_0", "sync": "full", "target": "ref_target_0", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_0", "len": 262144, "offset": 262144, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Add Bitmap ---
 
@@ -4937,7 +4937,7 @@ expecting 6 dirty sectors; have 6. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_1", "sync": "full", "target": "ref_target_1", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_1", "len": 458752, "offset": 458752, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #1 ---
 
@@ -5064,7 +5064,7 @@ expecting 12 dirty sectors; have 12. OK!
 {}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "filter-node-name": "backup-top", "job-id": "ref_backup_2", "sync": "full", "target": "ref_target_2", "x-max-workers": 1}}
 {"return": {}}
-{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_backup_2", "len": 983040, "offset": 983040, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 
 --- Test Backup #2 ---
 
-- 
2.21.0


--------------F7279DB740026883E8E91159--

