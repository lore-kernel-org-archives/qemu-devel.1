Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EC9C8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8964F2072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="P+sYf/PN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8964F2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7I4-0004nw-KC
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78h-0007D8-4A
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78J-0005QR-Ue
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:58 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com
 ([40.107.7.120]:6058 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU760-0003ZE-GE; Thu, 30 Apr 2020 07:11:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3c9/q37nwZnwr7eKvVKJaXPHsIOoeuMm7S9riC+TRepQvW+x0gUwa7WG1wz+IaoT3rx6y0slOg5ox3oZcmC4SJTw/tFyBJYAVOlCA1FVVC9gKpMJ8H/4GWv7UI97IO5chlFulivpg2DGz1QUSMsMQKrvN8S32veDm7T/CzD2S3tyZSXl6G5SdifjHLleDekRiLPEPnF8a5rrfxxEeGjwvW82AN18E7srLaDqkBTtRdAjhai3ODtV5o04l7DiQEtU7ce6g29kJb0eh1zPIOG4DygQseJ4gfHfah9IeOdbPx301k9nbEEq1sGmQwFiU+/+vFJElv0EjMX66DEUGRaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qksOZE9f1ynvBKGDGT85EsWTMq+OvM4y1QlCZBx3Xo4=;
 b=gPNXrmz5bieiF/dUG1AKCLpppokxqA5By4Imuou0qnSezDjoF7zwcjVuOxSCsYVWszsC09fHIjSPM9kbeDxhOvJ3HrHDXTM+zWuNGv4srJmUzwePXilY+is0LPHnPJsR4DHAgpWd1TJVTw93Z8DKSIguYCtz67xQkCfaz72dXq9zdmLa/mnfGaedioZsfCkeawkb5zt65RNF/Iq06HVel82sWJ2AEyW4e9Jba9xQ/7NDD1/ZKIplUqvn+gYp6dhflk+HldnmZpoIF7aBzLgNTh75rT0HmlsJXoiauNoeM+sDrbD0peAiKkuBW5I8MhhqB2Ynyaw1VNk+P3eF3KiBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qksOZE9f1ynvBKGDGT85EsWTMq+OvM4y1QlCZBx3Xo4=;
 b=P+sYf/PN2B2kmJA43iA4iDzt7rL6Ao2VyqBtuOUreiYM6bab9LnvW6fGhqI7W5Ue8MKgBIyvLA4I+C5NwKY0M6KA8SRkHjq7Dxswr9l1i60irVoH4Hg//UH2g1XpB5RlpqTOYE0oDGL8d8xp53JG949p6QjwRpQ4f64w7kYkHWE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 11:11:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:11:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 14/17] block: use int64_t instead of uint64_t in driver
 write handlers
Date: Thu, 30 Apr 2020 14:10:30 +0300
Message-Id: <20200430111033.29980-15-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200430111033.29980-1-vsementsov@virtuozzo.com>
References: <20200430111033.29980-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.138) by
 AM0P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:11:07 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a00ad3a2-14f2-4822-08b8-08d7ecf72f47
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5399FEE6A103F2B04B3D2D21C1AA0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:128;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSscPrl4bbwOWTEtuMAeQnk/k8M3gNlSxdyv7hUAY/vyJLpksWYy9r5mpj5xfxD4N7OMiSqpNuoQdfcUG77nQrT4LV9fOKixVAvQJdz+YEhhVFgSnv57RTelBJk34KWjz3OX9VCNBbS1FOFp1Wbs40d6bRFX1C3+lWvoLlsej5aZnseQ4phVgv+WtthHK0J9wWBLIRS2pqTLd6S4HbbHLa74m7nQ8I/IfFXB1pVTKGV/s7SDLRyWgIvsSGQUh0XYFYKjfAKzjw+WhOZW2W7yOkinE5qGWP0fi7IjjxYjzHW7BN7kj4/WCE/wWJOq3npEBB056gDqJji4TwqgUWJjcQh8QstPxiblINB2gK9QIzyaGO/uH16c/Q3ySnkD4k1CpzrD7bscAYfvW7EC3sDAUmIoNCdoUq1POVBnjEA0sDvzbz0/kyd3oUhIVXEgxrAMjB5W3LiQ0YuV8Nf0kDiGbmJK78riqMVKmzTZ3j91iCz0uSWTzpy/r0GVLW7RyrLd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(366004)(346002)(136003)(376002)(1076003)(36756003)(478600001)(8936002)(26005)(6512007)(30864003)(7416002)(5660300002)(107886003)(6486002)(66476007)(66556008)(86362001)(6916009)(6506007)(6666004)(8676002)(316002)(2906002)(186003)(66946007)(16526019)(2616005)(956004)(4326008)(52116002)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sacdCMSe09G4E4qcxRRwDqDndDL3HaGfyGJ8Us99+tIET48Ze+Ax8ppo5E/F2yDwaH5YVBFFmhKYKSYqpBhIkEVQe7mwps3aTM2GZsqU0oqu0UILn5UUe5n5Ei0f1S9/FPs0KhczsBM5nc//dmvxpPvu2zzMLZjiQm2y9juoTbYXw7wMT3NKy9wmn1n6zvmXAiLPRVjNd6bfSBiQDwFxyc08PqDWv5K4Cm6rf+hYSyWbuiqRiwk60sGspVM1IXzOMtFtBezWKFk9xlgBmopNnIjhuE1moWVVtJHM7+kL1HtrOWKdlG2drY6LbD1Gcd9yqXfBvFQnieePjlUE6td6GV9FcfCRBspdqqaKbHtxOai1RLS2Thtxgi2cYSqN3E9x9wPeggzi9nJcWKEBwqUtkziU6Kr1wvVSvzSEwn0+hG22qA7FuPjXjbjGK3T5M1HoofoXluxsfo4cVPeTK3Y7Ocy8Qw+kcOIgoEv4kPvckqwJ78Jy5gGQ7tnwO5OJ2+715GcBj5zJojxUnlNlk2nmUo0k8vMD/RVXoApzrFoOxpqBefHOvZE9HAcuszmyCpClMazY95uRhEebvVHgW0Xr3kwHZWFz/grSvPeGLDEwiVcRCMzj09aloVERqAUIzuyodtfGqnGlH9Xp1TzmFTBtW+Q1Q2FDIP1Qje3f4yLvhCZ+9tWHMATiS8CoMOEir1ZEXue/xQgaWQ8kKos4M03stbF8ZTYMKzUbXQZdLYiNJ7l2VfWQ0Wc5rgDjBZqlG7CzhHlUz1dOBlqKmUeV0qwnuLnKCJBO5kVTjZe45326DpA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00ad3a2-14f2-4822-08b8-08d7ecf72f47
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:11:09.2875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7d4i50jI5aBNMGSW2hPNjfUCend4LsaquTK/Jsvs9zd0K8vfD1qZG2xYJ8ZioQB04HLX0o8Fwm4Rju14I/1IMB+kBp2Ww2lF9U/4QMLMNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5399
Received-SPF: pass client-ip=40.107.7.120;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 07:11:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.120
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 sw@weilnetz.de, pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com,
 den@openvz.org, sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com,
 stefanha@redhat.com, namei.unix@gmail.com, pbonzini@redhat.com,
 jsnow@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths.

Main motivation is realization of 64-bit write_zeroes operation for
fast zeroing large disk chunks, up to the whole disk.

We chose signed type, to be consistent with off_t (which is signed) and
with possibility for signed return type (where negative value means
error).

So, convert driver write handlers parameters which are already 64bit to
signed type.

While being here, convert also flags parameter to be BdrvRequestFlags.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h   | 16 ++++++++--------
 block/backup-top.c          |  6 +++---
 block/blkdebug.c            |  4 ++--
 block/blklogwrites.c        |  4 ++--
 block/blkreplay.c           |  2 +-
 block/blkverify.c           |  4 ++--
 block/copy-on-read.c        |  5 +++--
 block/crypto.c              |  4 ++--
 block/file-posix.c          |  6 +++---
 block/file-win32.c          |  4 ++--
 block/filter-compress.c     |  7 ++++---
 block/io.c                  |  6 ++++--
 block/mirror.c              |  2 +-
 block/nbd.c                 |  5 +++--
 block/nfs.c                 |  6 +++---
 block/null.c                |  9 +++++----
 block/nvme.c                |  4 ++--
 block/qcow.c                | 10 +++++-----
 block/qcow2.c               |  6 +++---
 block/quorum.c              |  5 +++--
 block/raw-format.c          | 10 +++++-----
 block/rbd.c                 |  5 +++--
 block/throttle.c            |  5 +++--
 block/vdi.c                 |  4 ++--
 block/vmdk.c                |  8 ++++----
 block/vpc.c                 |  4 ++--
 block/vvfat.c               |  8 ++++----
 block/vxhs.c                |  4 ++--
 tests/test-block-iothread.c |  2 +-
 block/trace-events          |  2 +-
 30 files changed, 88 insertions(+), 79 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 7b5f936269..9e8819bc28 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -183,8 +183,8 @@ struct BlockDriver {
         int64_t offset, int64_t bytes, QEMUIOVector *qiov,
         BdrvRequestFlags flags, BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_pwritev)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
-        BlockCompletionFunc *cb, void *opaque);
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov,
+        BdrvRequestFlags flags, BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_flush)(BlockDriverState *bs,
         BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_pdiscard)(BlockDriverState *bs,
@@ -233,10 +233,11 @@ struct BlockDriver {
      * The buffer in @qiov may point directly to guest memory.
      */
     int coroutine_fn (*bdrv_co_pwritev)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov,
+        BdrvRequestFlags flags);
     int coroutine_fn (*bdrv_co_pwritev_part)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes,
-        QEMUIOVector *qiov, size_t qiov_offset, int flags);
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov, size_t qiov_offset,
+        BdrvRequestFlags flags);
 
     /*
      * Efficiently zero a region of the disk image.  Typically an image format
@@ -365,10 +366,9 @@ struct BlockDriver {
                                       Error **errp);
 
     int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov);
     int coroutine_fn (*bdrv_co_pwritev_compressed_part)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov,
-        size_t qiov_offset);
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov, size_t qiov_offset);
 
     int (*bdrv_snapshot_create)(BlockDriverState *bs,
                                 QEMUSnapshotInfo *sn_info);
diff --git a/block/backup-top.c b/block/backup-top.c
index 289fee5a92..519c7ea5ad 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -87,9 +87,9 @@ static int coroutine_fn backup_top_co_pwrite_zeroes(BlockDriverState *bs,
 }
 
 static coroutine_fn int backup_top_co_pwritev(BlockDriverState *bs,
-                                              uint64_t offset,
-                                              uint64_t bytes,
-                                              QEMUIOVector *qiov, int flags)
+                                              int64_t offset, int64_t bytes,
+                                              QEMUIOVector *qiov,
+                                              BdrvRequestFlags flags)
 {
     int ret = backup_top_cbw(bs, offset, bytes, flags);
     if (ret < 0) {
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 7e02156c63..e47a686628 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -640,8 +640,8 @@ blkdebug_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
 }
 
 static int coroutine_fn
-blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                    QEMUIOVector *qiov, int flags)
+blkdebug_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                    QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     int err;
 
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index db60b396bc..f9697aaa75 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -466,8 +466,8 @@ blk_log_writes_co_do_file_pdiscard(BlkLogWritesFileReq *fr)
 }
 
 static int coroutine_fn
-blk_log_writes_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                          QEMUIOVector *qiov, int flags)
+blk_log_writes_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                          QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     return blk_log_writes_co_log(bs, offset, bytes, qiov, flags,
                                  blk_log_writes_co_do_file_pwritev, 0, false);
diff --git a/block/blkreplay.c b/block/blkreplay.c
index c8dd17bfff..98b8dff860 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -84,7 +84,7 @@ static int coroutine_fn blkreplay_co_preadv(BlockDriverState *bs,
 }
 
 static int coroutine_fn blkreplay_co_pwritev(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     uint64_t reqid = blkreplay_next_id();
     int ret = bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
diff --git a/block/blkverify.c b/block/blkverify.c
index 6bc2982a95..796e100eda 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -253,8 +253,8 @@ blkverify_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
 }
 
 static int coroutine_fn
-blkverify_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                     QEMUIOVector *qiov, int flags)
+blkverify_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                     QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     BlkverifyRequest r;
     return blkverify_co_prwv(bs, &r, offset, bytes, qiov, qiov, flags, true);
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index c2a0916b66..174e711393 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -84,8 +84,9 @@ static int coroutine_fn cor_co_preadv(BlockDriverState *bs,
 
 
 static int coroutine_fn cor_co_pwritev(BlockDriverState *bs,
-                                       uint64_t offset, uint64_t bytes,
-                                       QEMUIOVector *qiov, int flags)
+                                       int64_t offset, int64_t bytes,
+                                       QEMUIOVector *qiov,
+                                       BdrvRequestFlags flags)
 {
 
     return bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
diff --git a/block/crypto.c b/block/crypto.c
index 4df71b25f1..c873f42f79 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -398,8 +398,8 @@ block_crypto_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
 
 
 static coroutine_fn int
-block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                        QEMUIOVector *qiov, int flags)
+block_crypto_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                        QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     BlockCrypto *crypto = bs->opaque;
     uint64_t cur_bytes; /* number of bytes in current iteration */
diff --git a/block/file-posix.c b/block/file-posix.c
index 1026e6040b..2c21f785b4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1948,9 +1948,9 @@ static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
     return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_READ);
 }
 
-static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                                       uint64_t bytes, QEMUIOVector *qiov,
-                                       int flags)
+static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t offset,
+                                       int64_t bytes, QEMUIOVector *qiov,
+                                       BdrvRequestFlags flags)
 {
     assert(flags == 0);
     return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_WRITE);
diff --git a/block/file-win32.c b/block/file-win32.c
index 8a163837ab..f4d2e7af3a 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -430,8 +430,8 @@ static BlockAIOCB *raw_aio_preadv(BlockDriverState *bs,
 }
 
 static BlockAIOCB *raw_aio_pwritev(BlockDriverState *bs,
-                                   uint64_t offset, uint64_t bytes,
-                                   QEMUIOVector *qiov, int flags,
+                                   int64_t offset, int64_t bytes,
+                                   QEMUIOVector *qiov, BdrvRequestFlags flags,
                                    BlockCompletionFunc *cb, void *opaque)
 {
     BDRVRawState *s = bs->opaque;
diff --git a/block/filter-compress.c b/block/filter-compress.c
index e61de56b96..09c0201c51 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -73,10 +73,11 @@ static int coroutine_fn compress_co_preadv_part(BlockDriverState *bs,
 
 
 static int coroutine_fn compress_co_pwritev_part(BlockDriverState *bs,
-                                                 uint64_t offset,
-                                                 uint64_t bytes,
+                                                 int64_t offset,
+                                                 int64_t bytes,
                                                  QEMUIOVector *qiov,
-                                                 size_t qiov_offset, int flags)
+                                                 size_t qiov_offset,
+                                                 BdrvRequestFlags flags)
 {
     return bdrv_co_pwritev_part(bs->file, offset, bytes, qiov, qiov_offset,
                                 flags | BDRV_REQ_WRITE_COMPRESSED);
diff --git a/block/io.c b/block/io.c
index db8b3b153d..bec5a3143f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -977,7 +977,8 @@ out:
 static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
                                             int64_t offset, int64_t bytes,
                                             QEMUIOVector *qiov,
-                                            size_t qiov_offset, int flags)
+                                            size_t qiov_offset,
+                                            BdrvRequestFlags flags)
 {
     BlockDriver *drv = bs->drv;
     int64_t sector_num;
@@ -1783,7 +1784,8 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
  */
 static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     BdrvTrackedRequest *req, int64_t offset, int64_t bytes,
-    int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
+    int64_t align, QEMUIOVector *qiov, size_t qiov_offset,
+    BdrvRequestFlags flags)
 {
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
diff --git a/block/mirror.c b/block/mirror.c
index 7cd720ac32..ac3d4bc8c5 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1419,7 +1419,7 @@ out:
 }
 
 static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     MirrorBDSOpaque *s = bs->opaque;
     QEMUIOVector bounce_qiov;
diff --git a/block/nbd.c b/block/nbd.c
index fedad8843f..8cd417f018 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1219,8 +1219,9 @@ static int nbd_client_co_preadv(BlockDriverState *bs, int64_t offset,
     return ret ? ret : request_ret;
 }
 
-static int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                                 uint64_t bytes, QEMUIOVector *qiov, int flags)
+static int nbd_client_co_pwritev(BlockDriverState *bs, int64_t offset,
+                                 int64_t bytes, QEMUIOVector *qiov,
+                                 BdrvRequestFlags flags)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = {
diff --git a/block/nfs.c b/block/nfs.c
index 647250e4d8..9f049e8c2e 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -298,9 +298,9 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
-static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                                       uint64_t bytes, QEMUIOVector *iov,
-                                       int flags)
+static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, int64_t offset,
+                                       int64_t bytes, QEMUIOVector *iov,
+                                       BdrvRequestFlags flags)
 {
     NFSClient *client = bs->opaque;
     NFSRPC task;
diff --git a/block/null.c b/block/null.c
index e2a59caf46..30d9f5c6b7 100644
--- a/block/null.c
+++ b/block/null.c
@@ -130,8 +130,9 @@ static coroutine_fn int null_co_preadv(BlockDriverState *bs,
 }
 
 static coroutine_fn int null_co_pwritev(BlockDriverState *bs,
-                                        uint64_t offset, uint64_t bytes,
-                                        QEMUIOVector *qiov, int flags)
+                                        int64_t offset, int64_t bytes,
+                                        QEMUIOVector *qiov,
+                                        BdrvRequestFlags flags)
 {
     return null_co_common(bs);
 }
@@ -203,8 +204,8 @@ static BlockAIOCB *null_aio_preadv(BlockDriverState *bs,
 }
 
 static BlockAIOCB *null_aio_pwritev(BlockDriverState *bs,
-                                    uint64_t offset, uint64_t bytes,
-                                    QEMUIOVector *qiov, int flags,
+                                    int64_t offset, int64_t bytes,
+                                    QEMUIOVector *qiov, BdrvRequestFlags flags,
                                     BlockCompletionFunc *cb,
                                     void *opaque)
 {
diff --git a/block/nvme.c b/block/nvme.c
index c79e398bff..d91bbe60bf 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1070,8 +1070,8 @@ static coroutine_fn int nvme_co_preadv(BlockDriverState *bs,
 }
 
 static coroutine_fn int nvme_co_pwritev(BlockDriverState *bs,
-                                        uint64_t offset, uint64_t bytes,
-                                        QEMUIOVector *qiov, int flags)
+                                        int64_t offset, int64_t bytes,
+                                        QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     return nvme_co_prw(bs, offset, bytes, qiov, true, flags);
 }
diff --git a/block/qcow.c b/block/qcow.c
index 40fc5b96a4..b7c01415e3 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -725,9 +725,9 @@ static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, int64_t offset,
     return ret;
 }
 
-static coroutine_fn int qcow_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                                        uint64_t bytes, QEMUIOVector *qiov,
-                                        int flags)
+static coroutine_fn int qcow_co_pwritev(BlockDriverState *bs, int64_t offset,
+                                        int64_t bytes, QEMUIOVector *qiov,
+                                        BdrvRequestFlags flags)
 {
     BDRVQcowState *s = bs->opaque;
     int offset_in_cluster;
@@ -1049,8 +1049,8 @@ static int qcow_make_empty(BlockDriverState *bs)
 /* XXX: put compressed sectors first, then all the cluster aligned
    tables to avoid losing bytes in alignment */
 static coroutine_fn int
-qcow_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
-                           uint64_t bytes, QEMUIOVector *qiov)
+qcow_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                           QEMUIOVector *qiov)
 {
     BDRVQcowState *s = bs->opaque;
     z_stream strm;
diff --git a/block/qcow2.c b/block/qcow2.c
index 817b0bfd2b..ce1c123cb7 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2476,8 +2476,8 @@ static coroutine_fn int qcow2_co_pwritev_task_entry(AioTask *task)
 }
 
 static coroutine_fn int qcow2_co_pwritev_part(
-        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-        QEMUIOVector *qiov, size_t qiov_offset, int flags)
+        BlockDriverState *bs, int64_t offset, int64_t bytes,
+        QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags)
 {
     BDRVQcow2State *s = bs->opaque;
     int offset_in_cluster;
@@ -4329,7 +4329,7 @@ static coroutine_fn int qcow2_co_pwritev_compressed_task_entry(AioTask *task)
  */
 static coroutine_fn int
 qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
-                                 uint64_t offset, uint64_t bytes,
+                                 int64_t offset, int64_t bytes,
                                  QEMUIOVector *qiov, size_t qiov_offset)
 {
     BDRVQcow2State *s = bs->opaque;
diff --git a/block/quorum.c b/block/quorum.c
index 3c65c05d17..2c515659c6 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -706,8 +706,9 @@ static void write_quorum_entry(void *opaque)
     }
 }
 
-static int quorum_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                             uint64_t bytes, QEMUIOVector *qiov, int flags)
+static int quorum_co_pwritev(BlockDriverState *bs, int64_t offset,
+                             int64_t bytes, QEMUIOVector *qiov,
+                             BdrvRequestFlags flags)
 {
     BDRVQuorumState *s = bs->opaque;
     QuorumAIOCB *acb = quorum_aio_get(bs, qiov, offset, bytes, flags);
diff --git a/block/raw-format.c b/block/raw-format.c
index 709b8aecdb..3a393a31c7 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -206,9 +206,9 @@ static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
 
-static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                                       uint64_t bytes, QEMUIOVector *qiov,
-                                       int flags)
+static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t offset,
+                                       int64_t bytes, QEMUIOVector *qiov,
+                                       BdrvRequestFlags flags)
 {
     void *buf = NULL;
     BlockDriver *drv;
@@ -249,7 +249,7 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
         qiov = &local_qiov;
     }
 
-    ret = raw_adjust_offset(bs, (int64_t *)&offset, bytes, true);
+    ret = raw_adjust_offset(bs, &offset, bytes, true);
     if (ret) {
         goto fail;
     }
@@ -284,7 +284,7 @@ static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
 {
     int ret;
 
-    ret = raw_adjust_offset(bs, (int64_t *)&offset, bytes, true);
+    ret = raw_adjust_offset(bs, &offset, bytes, true);
     if (ret) {
         return ret;
     }
diff --git a/block/rbd.c b/block/rbd.c
index b7edd685f6..705c8d8ff4 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1045,8 +1045,9 @@ static BlockAIOCB *qemu_rbd_aio_preadv(BlockDriverState *bs,
 }
 
 static BlockAIOCB *qemu_rbd_aio_pwritev(BlockDriverState *bs,
-                                        uint64_t offset, uint64_t bytes,
-                                        QEMUIOVector *qiov, int flags,
+                                        int64_t offset, int64_t bytes,
+                                        QEMUIOVector *qiov,
+                                        BdrvRequestFlags flags,
                                         BlockCompletionFunc *cb,
                                         void *opaque)
 {
diff --git a/block/throttle.c b/block/throttle.c
index 63d1956074..af8cc3b2dd 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -126,8 +126,9 @@ static int coroutine_fn throttle_co_preadv(BlockDriverState *bs,
 }
 
 static int coroutine_fn throttle_co_pwritev(BlockDriverState *bs,
-                                            uint64_t offset, uint64_t bytes,
-                                            QEMUIOVector *qiov, int flags)
+                                            int64_t offset, int64_t bytes,
+                                            QEMUIOVector *qiov,
+                                            BdrvRequestFlags flags)
 {
     ThrottleGroupMember *tgm = bs->opaque;
     throttle_group_co_io_limits_intercept(tgm, bytes, true);
diff --git a/block/vdi.c b/block/vdi.c
index 1b5365f34c..8b00f29544 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -603,8 +603,8 @@ vdi_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
 }
 
 static int coroutine_fn
-vdi_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-               QEMUIOVector *qiov, int flags)
+vdi_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
+               QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     BDRVVdiState *s = bs->opaque;
     QEMUIOVector local_qiov;
diff --git a/block/vmdk.c b/block/vmdk.c
index a1a0a77fe9..61b409ebc7 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2048,8 +2048,8 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
 }
 
 static int coroutine_fn
-vmdk_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                QEMUIOVector *qiov, int flags)
+vmdk_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     int ret;
     BDRVVmdkState *s = bs->opaque;
@@ -2060,8 +2060,8 @@ vmdk_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
 }
 
 static int coroutine_fn
-vmdk_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
-                           uint64_t bytes, QEMUIOVector *qiov)
+vmdk_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                           QEMUIOVector *qiov)
 {
     if (bytes == 0) {
         /* The caller will write bytes 0 to signal EOF.
diff --git a/block/vpc.c b/block/vpc.c
index 45c254c3f7..1babc21462 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -662,8 +662,8 @@ fail:
 }
 
 static int coroutine_fn
-vpc_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-               QEMUIOVector *qiov, int flags)
+vpc_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
+               QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     BDRVVPCState *s = bs->opaque;
     int64_t image_offset;
diff --git a/block/vvfat.c b/block/vvfat.c
index 80d488f556..81c86c9243 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3073,8 +3073,8 @@ DLOG(checkpoint());
 }
 
 static int coroutine_fn
-vvfat_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                 QEMUIOVector *qiov, int flags)
+vvfat_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                 QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     int ret;
     BDRVVVFATState *s = bs->opaque;
@@ -3111,8 +3111,8 @@ static int coroutine_fn vvfat_co_block_status(BlockDriverState *bs,
 }
 
 static int coroutine_fn
-write_target_commit(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                    QEMUIOVector *qiov, int flags)
+write_target_commit(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                    QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     int ret;
 
diff --git a/block/vxhs.c b/block/vxhs.c
index a1e437b2cb..e9abef1819 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -488,8 +488,8 @@ static BlockAIOCB *vxhs_aio_preadv(BlockDriverState *bs,
 }
 
 static BlockAIOCB *vxhs_aio_pwritev(BlockDriverState *bs,
-                                    uint64_t offset, uint64_t bytes,
-                                    QEMUIOVector *qiov, int flags,
+                                    int64_t offset, int64_t bytes,
+                                    QEMUIOVector *qiov, BdrvRequestFlags flags,
                                     BlockCompletionFunc *cb, void *opaque)
 {
     return vxhs_aio_rw(bs, offset, qiov, bytes, cb, opaque, VDISK_AIO_WRITE);
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 9567617c50..f5eb80d21b 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -40,7 +40,7 @@ static int coroutine_fn bdrv_test_co_preadv(BlockDriverState *bs,
 }
 
 static int coroutine_fn bdrv_test_co_pwritev(BlockDriverState *bs,
-                                             uint64_t offset, uint64_t bytes,
+                                             int64_t offset, int64_t bytes,
                                              QEMUIOVector *qiov,
                                              BdrvRequestFlags flags)
 {
diff --git a/block/trace-events b/block/trace-events
index e4d68438af..b7fc837015 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -78,7 +78,7 @@ luring_resubmit_short_read(void *s, void *luringcb, int nread) "LuringState %p l
 
 # qcow2.c
 qcow2_add_task(void *co, void *bs, void *pool, const char *action, int cluster_type, uint64_t file_cluster_offset, uint64_t offset, uint64_t bytes, void *qiov, size_t qiov_offset) "co %p bs %p pool %p: %s: cluster_type %d file_cluster_offset %" PRIu64 " offset %" PRIu64 " bytes %" PRIu64 " qiov %p qiov_offset %zu"
-qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset 0x%" PRIx64 " bytes %d"
+qcow2_writev_start_req(void *co, int64_t offset, int64_t bytes) "co %p offset 0x%" PRIx64 " bytes %" PRId64
 qcow2_writev_done_req(void *co, int ret) "co %p ret %d"
 qcow2_writev_start_part(void *co) "co %p"
 qcow2_writev_done_part(void *co, int cur_bytes) "co %p cur_bytes %d"
-- 
2.21.0


