Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D694C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:20:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081EF2073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IwMeVLPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081EF2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIvHK-0003wS-4n
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 10:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jIvFg-000267-7f
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jIvFc-0005UW-BR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:18:56 -0400
Received: from mail-eopbgr140102.outbound.protection.outlook.com
 ([40.107.14.102]:9390 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jIvFS-0005Ft-P4; Mon, 30 Mar 2020 10:18:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2T8F9mqcDrBrnc7C8zhYhQlCo8V28StBO9DZ4M5f+18BDeoKiIB0/u0r2MlH/cI6/Xm7g5kQLdthjjg0Ru+qi8S2PLdNbs2K/GpYJOR7f55/auqCbbrHDWLpWTUzVp66lYVeJy2Jtc/vFDTBkvbSnBcmPQ6I8LibKUsn8PVkJnmjnxEojHu26K6QgUJ2KvHmXWpQvhvqBioLvXC37RKBlrSdSZlBGc+od0nn9FKZRDhRLZRYFJkDuaw5rTLPHaWufBpR1dt4EZH5Y2nAsfN1HNV3n1RCDawzh5FRH6Qe5R94fP5l/W6TRkN0qvhkit85JQij4F/IRCOtIjZ6+vK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0ZSamk3J09320aOLYMJGgmnVDV8scsUySov0iDgDZw=;
 b=c3gq6kkM9jPHYap3E//o4M1qg1QqhicJkCfWW5kagrN1xHlzuxCBJ8hyb1/aZ9ToOc7jXUoUbBLo/AlZiPwTKPydXMsCCK0uowzGAW/De/kdlJquUmPErP/j22A0KG2qX3uDDBlplnlcHMxe8lifzteAHn+KW4ciMUcBNhA2wn+2Mt4JtyMFCdQVJOj7x00VjsIkkR+28uDw/tS5N13kPxQ+F7FugIOyA9fyKha1EMEKRvVxur65SjFQAqSOuss6LqxbYs81uFA46Fuoa9u/LMCqIMN4CD3C3teAGxPZHuTFyuMBvv3ubGrHho5PfiMNlAjANoXJLEgSbM4lXUEs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0ZSamk3J09320aOLYMJGgmnVDV8scsUySov0iDgDZw=;
 b=IwMeVLPwBBlBqrI4R9rpJQuaC5Uj5TSC/FOube/EMESxu4gCHyeGSsTVcql/4afkf6dppPHrO/byGoiqOrYBcQted2p7R73lEN4L/XquzVOcPlIoka5UX75t9Nwplv4KjT19ny06XEPxP0xOg5y+ZfsChb8LkL2a3cscp7OR7ag=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5382.eurprd08.prod.outlook.com (10.141.173.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 14:18:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%9]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 14:18:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/3] block: use int64_t instead of uint64_t in driver handlers
Date: Mon, 30 Mar 2020 17:18:18 +0300
Message-ID: <20200330141818.31294-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200330141818.31294-1-vsementsov@virtuozzo.com>
References: <20200330141818.31294-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0064.eurprd05.prod.outlook.com
 (2603:10a6:208:be::41) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.14) by
 AM0PR05CA0064.eurprd05.prod.outlook.com (2603:10a6:208:be::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 14:18:39 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.14]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9c5eee9-5287-4945-b410-08d7d4b53ea9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB538207C2E8B73477FE660E7AC1CB0@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(366004)(136003)(39840400004)(396003)(346002)(6506007)(52116002)(6486002)(5660300002)(107886003)(478600001)(6512007)(8676002)(16526019)(186003)(4326008)(26005)(66556008)(66476007)(6916009)(2616005)(956004)(1076003)(36756003)(81166006)(30864003)(86362001)(6666004)(316002)(2906002)(81156014)(8936002)(7416002)(66946007)(21314003)(579004);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyHit8EKGXrkuxkmDgfsEzyj7HfUfdLmI9SpJcn3XmeoKfUYnrr/hdNzI6I0jb0DO+cyJw3+YbkWBdOJ+Eu4QaZTs0mL6SMA4XolRSuQr9Dw82pwaNnZkTmuOMGcVq5anVNlZgO6BXwvvYtdAklsIAhIRC4o8aBYGUmpbzdtJCV285JdCVW+OlniUvx14fQ3TSLLC7bEq/YF7gOCVk3oG4u9/JeZ3l2r6+31SeY/6imgW4aJrd6kX5hFHwxOAJfkQqopPiUT/fb61NwJInYxRXTBgyB/kfAJQSNidRHV/nwHyBnjM1HcVfGKqSaPtNRjaoUuGIo5dTDyRwv038uyqURexDFI7RI6feRDkepSw4EWDtYwPIvIjkRqLDk86RjrV+iEqrURTmZavGjDAuy7FQPEg8pZzemJWUSNDjQk/RRPSBhZzaRRZAqAmQVIMPDKQQMtf0qPb5idnptBso5k8L12ETiMfSatUL3L4Xz1Lka0QH3znN3OISG3zm1WNz7N
X-MS-Exchange-AntiSpam-MessageData: X3OWvFjtbuPLldvYWu9iwuGkAiX9XgALIH2H53k3YGLQBcsG3SgK2E6u58HP64S9b6IFK0p7k5jgfPq/yoDpeS/b1V05KPzP6hDhK03gRIUTAJO2yHTGczVxUYpm8S61pbR0JwoWR3ji8kKYlrttOw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c5eee9-5287-4945-b410-08d7d4b53ea9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 14:18:40.3863 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ec2ynxNdMNXUKagxCOr/gQFECeG6jzA+WHThuzOPnwvyP+SF1kokOxiq2myQRE409ew+JnACYzlUrjdjweJb8QVTWmxxH/w5IK3xJqbiH3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.14.102
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
 berto@igalia.com, stefanha@redhat.com, pavel.dovgaluk@ispras.ru,
 sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com,
 jsnow@redhat.com, ronniesahlberg@gmail.com, den@openvz.org,
 pbonzini@redhat.com, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths. Convert driver handlers parameters which are already
64bit to signed type.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h | 28 ++++++++++++++--------------
 block/backup-top.c        |  5 ++---
 block/blkdebug.c          |  4 ++--
 block/blklogwrites.c      |  4 ++--
 block/blkreplay.c         |  4 ++--
 block/blkverify.c         |  4 ++--
 block/bochs.c             |  2 +-
 block/cloop.c             |  2 +-
 block/commit.c            |  2 +-
 block/copy-on-read.c      |  4 ++--
 block/crypto.c            |  4 ++--
 block/curl.c              |  2 +-
 block/dmg.c               |  2 +-
 block/file-posix.c        | 18 +++++++++---------
 block/filter-compress.c   |  6 +++---
 block/iscsi.c             | 12 ++++++------
 block/mirror.c            |  4 ++--
 block/nbd.c               |  8 ++++----
 block/nfs.c               |  8 ++++----
 block/null.c              |  8 ++++----
 block/nvme.c              |  4 ++--
 block/qcow.c              | 12 ++++++------
 block/qcow2.c             | 18 +++++++++---------
 block/quorum.c            |  8 ++++----
 block/raw-format.c        | 28 ++++++++++++++--------------
 block/rbd.c               |  4 ++--
 block/throttle.c          |  4 ++--
 block/vdi.c               |  4 ++--
 block/vmdk.c              |  8 ++++----
 block/vpc.c               |  4 ++--
 block/vvfat.c             |  6 +++---
 tests/test-bdrv-drain.c   |  8 ++++----
 block/trace-events        |  2 +-
 33 files changed, 120 insertions(+), 121 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 28aea2bcfd..ea8fca5e28 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -180,10 +180,10 @@ struct BlockDriver {
=20
     /* aio */
     BlockAIOCB *(*bdrv_aio_preadv)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags,
         BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_pwritev)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags,
         BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_flush)(BlockDriverState *bs,
         BlockCompletionFunc *cb, void *opaque);
@@ -210,9 +210,9 @@ struct BlockDriver {
      * The buffer in @qiov may point directly to guest memory.
      */
     int coroutine_fn (*bdrv_co_preadv)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags);
     int coroutine_fn (*bdrv_co_preadv_part)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes,
+        int64_t offset, int64_t bytes,
         QEMUIOVector *qiov, size_t qiov_offset, int flags);
     int coroutine_fn (*bdrv_co_writev)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov, int flags)=
;
@@ -232,9 +232,9 @@ struct BlockDriver {
      * The buffer in @qiov may point directly to guest memory.
      */
     int coroutine_fn (*bdrv_co_pwritev)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags);
     int coroutine_fn (*bdrv_co_pwritev_part)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes,
+        int64_t offset, int64_t bytes,
         QEMUIOVector *qiov, size_t qiov_offset, int flags);
=20
     /*
@@ -257,10 +257,10 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_copy_range_from)(BlockDriverState *bs,
                                                 BdrvChild *src,
-                                                uint64_t offset,
+                                                int64_t offset,
                                                 BdrvChild *dst,
-                                                uint64_t dst_offset,
-                                                uint64_t bytes,
+                                                int64_t dst_offset,
+                                                int64_t bytes,
                                                 BdrvRequestFlags read_flag=
s,
                                                 BdrvRequestFlags write_fla=
gs);
=20
@@ -274,10 +274,10 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_copy_range_to)(BlockDriverState *bs,
                                               BdrvChild *src,
-                                              uint64_t src_offset,
+                                              int64_t src_offset,
                                               BdrvChild *dst,
-                                              uint64_t dst_offset,
-                                              uint64_t bytes,
+                                              int64_t dst_offset,
+                                              int64_t bytes,
                                               BdrvRequestFlags read_flags,
                                               BdrvRequestFlags write_flags=
);
=20
@@ -364,9 +364,9 @@ struct BlockDriver {
                                       Error **errp);
=20
     int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov);
     int coroutine_fn (*bdrv_co_pwritev_compressed_part)(BlockDriverState *=
bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov,
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov,
         size_t qiov_offset);
=20
     int (*bdrv_snapshot_create)(BlockDriverState *bs,
diff --git a/block/backup-top.c b/block/backup-top.c
index 3b50c06e2c..4190d465d6 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -42,7 +42,7 @@ typedef struct BDRVBackupTopState {
 } BDRVBackupTopState;
=20
 static coroutine_fn int backup_top_co_preadv(
-        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+        BlockDriverState *bs, int64_t offset, int64_t bytes,
         QEMUIOVector *qiov, int flags)
 {
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
@@ -87,8 +87,7 @@ static int coroutine_fn backup_top_co_pwrite_zeroes(Block=
DriverState *bs,
 }
=20
 static coroutine_fn int backup_top_co_pwritev(BlockDriverState *bs,
-                                              uint64_t offset,
-                                              uint64_t bytes,
+                                              int64_t offset, int64_t byte=
s,
                                               QEMUIOVector *qiov, int flag=
s)
 {
     int ret =3D backup_top_cbw(bs, offset, bytes, flags);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index af44aa973f..b4d0966982 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -619,7 +619,7 @@ static int rule_check(BlockDriverState *bs, uint64_t of=
fset, uint64_t bytes,
 }
=20
 static int coroutine_fn
-blkdebug_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+blkdebug_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                    QEMUIOVector *qiov, int flags)
 {
     int err;
@@ -640,7 +640,7 @@ blkdebug_co_preadv(BlockDriverState *bs, uint64_t offse=
t, uint64_t bytes,
 }
=20
 static int coroutine_fn
-blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+blkdebug_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                     QEMUIOVector *qiov, int flags)
 {
     int err;
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 04d8b33607..890a61dfba 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -307,7 +307,7 @@ static void blk_log_writes_refresh_limits(BlockDriverSt=
ate *bs, Error **errp)
 }
=20
 static int coroutine_fn
-blk_log_writes_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t b=
ytes,
+blk_log_writes_co_preadv(BlockDriverState *bs, int64_t offset, int64_t byt=
es,
                          QEMUIOVector *qiov, int flags)
 {
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
@@ -466,7 +466,7 @@ blk_log_writes_co_do_file_pdiscard(BlkLogWritesFileReq =
*fr)
 }
=20
 static int coroutine_fn
-blk_log_writes_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t =
bytes,
+blk_log_writes_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t by=
tes,
                           QEMUIOVector *qiov, int flags)
 {
     return blk_log_writes_co_log(bs, offset, bytes, qiov, flags,
diff --git a/block/blkreplay.c b/block/blkreplay.c
index c96ac8f4bc..d93383a88f 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -73,7 +73,7 @@ static void block_request_create(uint64_t reqid, BlockDri=
verState *bs,
 }
=20
 static int coroutine_fn blkreplay_co_preadv(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     uint64_t reqid =3D blkreplay_next_id();
     int ret =3D bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
@@ -84,7 +84,7 @@ static int coroutine_fn blkreplay_co_preadv(BlockDriverSt=
ate *bs,
 }
=20
 static int coroutine_fn blkreplay_co_pwritev(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     uint64_t reqid =3D blkreplay_next_id();
     int ret =3D bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
diff --git a/block/blkverify.c b/block/blkverify.c
index 667e60d832..a3c447fc68 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -224,7 +224,7 @@ blkverify_co_prwv(BlockDriverState *bs, BlkverifyReques=
t *r, uint64_t offset,
 }
=20
 static int coroutine_fn
-blkverify_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+blkverify_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                     QEMUIOVector *qiov, int flags)
 {
     BlkverifyRequest r;
@@ -253,7 +253,7 @@ blkverify_co_preadv(BlockDriverState *bs, uint64_t offs=
et, uint64_t bytes,
 }
=20
 static int coroutine_fn
-blkverify_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes=
,
+blkverify_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                      QEMUIOVector *qiov, int flags)
 {
     BlkverifyRequest r;
diff --git a/block/bochs.c b/block/bochs.c
index 32bb83b268..08ae3793e4 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -238,7 +238,7 @@ static int64_t seek_to_sector(BlockDriverState *bs, int=
64_t sector_num)
 }
=20
 static int coroutine_fn
-bochs_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+bochs_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                 QEMUIOVector *qiov, int flags)
 {
     BDRVBochsState *s =3D bs->opaque;
diff --git a/block/cloop.c b/block/cloop.c
index 4de94876d4..a5db202678 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -245,7 +245,7 @@ static inline int cloop_read_block(BlockDriverState *bs=
, int block_num)
 }
=20
 static int coroutine_fn
-cloop_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+cloop_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                 QEMUIOVector *qiov, int flags)
 {
     BDRVCloopState *s =3D bs->opaque;
diff --git a/block/commit.c b/block/commit.c
index 8e672799af..951e4f623a 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -211,7 +211,7 @@ static const BlockJobDriver commit_job_driver =3D {
 };
=20
 static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 242d3ff055..fc3186bacb 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -74,7 +74,7 @@ static int64_t cor_getlength(BlockDriverState *bs)
=20
=20
 static int coroutine_fn cor_co_preadv(BlockDriverState *bs,
-                                      uint64_t offset, uint64_t bytes,
+                                      int64_t offset, int64_t bytes,
                                       QEMUIOVector *qiov, int flags)
 {
     return bdrv_co_preadv(bs->file, offset, bytes, qiov,
@@ -83,7 +83,7 @@ static int coroutine_fn cor_co_preadv(BlockDriverState *b=
s,
=20
=20
 static int coroutine_fn cor_co_pwritev(BlockDriverState *bs,
-                                       uint64_t offset, uint64_t bytes,
+                                       int64_t offset, int64_t bytes,
                                        QEMUIOVector *qiov, int flags)
 {
=20
diff --git a/block/crypto.c b/block/crypto.c
index d577f89659..ecb5697a4b 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -335,7 +335,7 @@ static int block_crypto_reopen_prepare(BDRVReopenState =
*state,
 #define BLOCK_CRYPTO_MAX_IO_SIZE (1024 * 1024)
=20
 static coroutine_fn int
-block_crypto_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t byt=
es,
+block_crypto_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes=
,
                        QEMUIOVector *qiov, int flags)
 {
     BlockCrypto *crypto =3D bs->opaque;
@@ -398,7 +398,7 @@ block_crypto_co_preadv(BlockDriverState *bs, uint64_t o=
ffset, uint64_t bytes,
=20
=20
 static coroutine_fn int
-block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t by=
tes,
+block_crypto_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t byte=
s,
                         QEMUIOVector *qiov, int flags)
 {
     BlockCrypto *crypto =3D bs->opaque;
diff --git a/block/curl.c b/block/curl.c
index 6e325901dc..305a7a5e95 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -922,7 +922,7 @@ out:
 }
=20
 static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     CURLAIOCB acb =3D {
         .co =3D qemu_coroutine_self(),
diff --git a/block/dmg.c b/block/dmg.c
index 4a045f2b3e..c378b4f555 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -689,7 +689,7 @@ static inline int dmg_read_chunk(BlockDriverState *bs, =
uint64_t sector_num)
 }
=20
 static int coroutine_fn
-dmg_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+dmg_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
               QEMUIOVector *qiov, int flags)
 {
     BDRVDMGState *s =3D bs->opaque;
diff --git a/block/file-posix.c b/block/file-posix.c
index 7e19bbff5f..76da620135 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1941,15 +1941,15 @@ static int coroutine_fn raw_co_prw(BlockDriverState=
 *bs, uint64_t offset,
     return raw_thread_pool_submit(bs, handle_aiocb_rw, &acb);
 }
=20
-static int coroutine_fn raw_co_preadv(BlockDriverState *bs, uint64_t offse=
t,
-                                      uint64_t bytes, QEMUIOVector *qiov,
+static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset=
,
+                                      int64_t bytes, QEMUIOVector *qiov,
                                       int flags)
 {
     return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_READ);
 }
=20
-static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offs=
et,
-                                       uint64_t bytes, QEMUIOVector *qiov,
+static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t offse=
t,
+                                       int64_t bytes, QEMUIOVector *qiov,
                                        int flags)
 {
     assert(flags =3D=3D 0);
@@ -3034,8 +3034,8 @@ static void raw_abort_perm_update(BlockDriverState *b=
s)
 }
=20
 static int coroutine_fn raw_co_copy_range_from(
-        BlockDriverState *bs, BdrvChild *src, uint64_t src_offset,
-        BdrvChild *dst, uint64_t dst_offset, uint64_t bytes,
+        BlockDriverState *bs, BdrvChild *src, int64_t src_offset,
+        BdrvChild *dst, int64_t dst_offset, int64_t bytes,
         BdrvRequestFlags read_flags, BdrvRequestFlags write_flags)
 {
     return bdrv_co_copy_range_to(src, src_offset, dst, dst_offset, bytes,
@@ -3044,10 +3044,10 @@ static int coroutine_fn raw_co_copy_range_from(
=20
 static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
                                              BdrvChild *src,
-                                             uint64_t src_offset,
+                                             int64_t src_offset,
                                              BdrvChild *dst,
-                                             uint64_t dst_offset,
-                                             uint64_t bytes,
+                                             int64_t dst_offset,
+                                             int64_t bytes,
                                              BdrvRequestFlags read_flags,
                                              BdrvRequestFlags write_flags)
 {
diff --git a/block/filter-compress.c b/block/filter-compress.c
index 82c315b298..f2400fea37 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -62,7 +62,7 @@ static int64_t compress_getlength(BlockDriverState *bs)
=20
=20
 static int coroutine_fn compress_co_preadv_part(BlockDriverState *bs,
-                                                uint64_t offset, uint64_t =
bytes,
+                                                int64_t offset, int64_t by=
tes,
                                                 QEMUIOVector *qiov,
                                                 size_t qiov_offset,
                                                 int flags)
@@ -73,8 +73,8 @@ static int coroutine_fn compress_co_preadv_part(BlockDriv=
erState *bs,
=20
=20
 static int coroutine_fn compress_co_pwritev_part(BlockDriverState *bs,
-                                                 uint64_t offset,
-                                                 uint64_t bytes,
+                                                 int64_t offset,
+                                                 int64_t bytes,
                                                  QEMUIOVector *qiov,
                                                  size_t qiov_offset, int f=
lags)
 {
diff --git a/block/iscsi.c b/block/iscsi.c
index 4e216bd8aa..b403e67be7 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2181,10 +2181,10 @@ static void coroutine_fn iscsi_co_invalidate_cache(=
BlockDriverState *bs,
=20
 static int coroutine_fn iscsi_co_copy_range_from(BlockDriverState *bs,
                                                  BdrvChild *src,
-                                                 uint64_t src_offset,
+                                                 int64_t src_offset,
                                                  BdrvChild *dst,
-                                                 uint64_t dst_offset,
-                                                 uint64_t bytes,
+                                                 int64_t dst_offset,
+                                                 int64_t bytes,
                                                  BdrvRequestFlags read_fla=
gs,
                                                  BdrvRequestFlags write_fl=
ags)
 {
@@ -2322,10 +2322,10 @@ static void iscsi_xcopy_data(struct iscsi_data *dat=
a,
=20
 static int coroutine_fn iscsi_co_copy_range_to(BlockDriverState *bs,
                                                BdrvChild *src,
-                                               uint64_t src_offset,
+                                               int64_t src_offset,
                                                BdrvChild *dst,
-                                               uint64_t dst_offset,
-                                               uint64_t bytes,
+                                               int64_t dst_offset,
+                                               int64_t bytes,
                                                BdrvRequestFlags read_flags=
,
                                                BdrvRequestFlags write_flag=
s)
 {
diff --git a/block/mirror.c b/block/mirror.c
index c26fd9260d..687a91e654 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1365,7 +1365,7 @@ static void coroutine_fn active_write_settle(MirrorOp=
 *op)
 }
=20
 static int coroutine_fn bdrv_mirror_top_preadv(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
@@ -1419,7 +1419,7 @@ out:
 }
=20
 static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     MirrorBDSOpaque *s =3D bs->opaque;
     QEMUIOVector bounce_qiov;
diff --git a/block/nbd.c b/block/nbd.c
index 2160859f64..54bce3911e 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1160,8 +1160,8 @@ static int nbd_co_request(BlockDriverState *bs, NBDRe=
quest *request,
     return ret ? ret : request_ret;
 }
=20
-static int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
-                                uint64_t bytes, QEMUIOVector *qiov, int fl=
ags)
+static int nbd_client_co_preadv(BlockDriverState *bs, int64_t offset,
+                                int64_t bytes, QEMUIOVector *qiov, int fla=
gs)
 {
     int ret, request_ret;
     Error *local_err =3D NULL;
@@ -1218,8 +1218,8 @@ static int nbd_client_co_preadv(BlockDriverState *bs,=
 uint64_t offset,
     return ret ? ret : request_ret;
 }
=20
-static int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                                 uint64_t bytes, QEMUIOVector *qiov, int f=
lags)
+static int nbd_client_co_pwritev(BlockDriverState *bs, int64_t offset,
+                                 int64_t bytes, QEMUIOVector *qiov, int fl=
ags)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
     NBDRequest request =3D {
diff --git a/block/nfs.c b/block/nfs.c
index cc2413d5ab..d59d8e7d32 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -263,8 +263,8 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, voi=
d *data,
                                      nfs_co_generic_bh_cb, task);
 }
=20
-static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offse=
t,
-                                      uint64_t bytes, QEMUIOVector *iov,
+static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset=
,
+                                      int64_t bytes, QEMUIOVector *iov,
                                       int flags)
 {
     NFSClient *client =3D bs->opaque;
@@ -298,8 +298,8 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState =
*bs, uint64_t offset,
     return 0;
 }
=20
-static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offs=
et,
-                                       uint64_t bytes, QEMUIOVector *iov,
+static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, int64_t offse=
t,
+                                       int64_t bytes, QEMUIOVector *iov,
                                        int flags)
 {
     NFSClient *client =3D bs->opaque;
diff --git a/block/null.c b/block/null.c
index 15e1d56746..cac37e7ba6 100644
--- a/block/null.c
+++ b/block/null.c
@@ -116,7 +116,7 @@ static coroutine_fn int null_co_common(BlockDriverState=
 *bs)
 }
=20
 static coroutine_fn int null_co_preadv(BlockDriverState *bs,
-                                       uint64_t offset, uint64_t bytes,
+                                       int64_t offset, int64_t bytes,
                                        QEMUIOVector *qiov, int flags)
 {
     BDRVNullState *s =3D bs->opaque;
@@ -129,7 +129,7 @@ static coroutine_fn int null_co_preadv(BlockDriverState=
 *bs,
 }
=20
 static coroutine_fn int null_co_pwritev(BlockDriverState *bs,
-                                        uint64_t offset, uint64_t bytes,
+                                        int64_t offset, int64_t bytes,
                                         QEMUIOVector *qiov, int flags)
 {
     return null_co_common(bs);
@@ -187,7 +187,7 @@ static inline BlockAIOCB *null_aio_common(BlockDriverSt=
ate *bs,
 }
=20
 static BlockAIOCB *null_aio_preadv(BlockDriverState *bs,
-                                   uint64_t offset, uint64_t bytes,
+                                   int64_t offset, int64_t bytes,
                                    QEMUIOVector *qiov, int flags,
                                    BlockCompletionFunc *cb,
                                    void *opaque)
@@ -202,7 +202,7 @@ static BlockAIOCB *null_aio_preadv(BlockDriverState *bs=
,
 }
=20
 static BlockAIOCB *null_aio_pwritev(BlockDriverState *bs,
-                                    uint64_t offset, uint64_t bytes,
+                                    int64_t offset, int64_t bytes,
                                     QEMUIOVector *qiov, int flags,
                                     BlockCompletionFunc *cb,
                                     void *opaque)
diff --git a/block/nvme.c b/block/nvme.c
index 7b7c0cc5d6..db7fffe94f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1062,14 +1062,14 @@ static int nvme_co_prw(BlockDriverState *bs, uint64=
_t offset, uint64_t bytes,
 }
=20
 static coroutine_fn int nvme_co_preadv(BlockDriverState *bs,
-                                       uint64_t offset, uint64_t bytes,
+                                       int64_t offset, int64_t bytes,
                                        QEMUIOVector *qiov, int flags)
 {
     return nvme_co_prw(bs, offset, bytes, qiov, false, flags);
 }
=20
 static coroutine_fn int nvme_co_pwritev(BlockDriverState *bs,
-                                        uint64_t offset, uint64_t bytes,
+                                        int64_t offset, int64_t bytes,
                                         QEMUIOVector *qiov, int flags)
 {
     return nvme_co_prw(bs, offset, bytes, qiov, true, flags);
diff --git a/block/qcow.c b/block/qcow.c
index 8973e4e565..9583e8e8b2 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -628,8 +628,8 @@ static void qcow_refresh_limits(BlockDriverState *bs, E=
rror **errp)
     bs->bl.request_alignment =3D BDRV_SECTOR_SIZE;
 }
=20
-static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, uint64_t offs=
et,
-                                       uint64_t bytes, QEMUIOVector *qiov,
+static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, int64_t offse=
t,
+                                       int64_t bytes, QEMUIOVector *qiov,
                                        int flags)
 {
     BDRVQcowState *s =3D bs->opaque;
@@ -725,8 +725,8 @@ static coroutine_fn int qcow_co_preadv(BlockDriverState=
 *bs, uint64_t offset,
     return ret;
 }
=20
-static coroutine_fn int qcow_co_pwritev(BlockDriverState *bs, uint64_t off=
set,
-                                        uint64_t bytes, QEMUIOVector *qiov=
,
+static coroutine_fn int qcow_co_pwritev(BlockDriverState *bs, int64_t offs=
et,
+                                        int64_t bytes, QEMUIOVector *qiov,
                                         int flags)
 {
     BDRVQcowState *s =3D bs->opaque;
@@ -1049,8 +1049,8 @@ static int qcow_make_empty(BlockDriverState *bs)
 /* XXX: put compressed sectors first, then all the cluster aligned
    tables to avoid losing bytes in alignment */
 static coroutine_fn int
-qcow_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
-                           uint64_t bytes, QEMUIOVector *qiov)
+qcow_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t b=
ytes,
+                           QEMUIOVector *qiov)
 {
     BDRVQcowState *s =3D bs->opaque;
     z_stream strm;
diff --git a/block/qcow2.c b/block/qcow2.c
index 2bb536b014..4d4f972187 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2202,7 +2202,7 @@ static coroutine_fn int qcow2_co_preadv_task_entry(Ai=
oTask *task)
 }
=20
 static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
-                                             uint64_t offset, uint64_t byt=
es,
+                                             int64_t offset, int64_t bytes=
,
                                              QEMUIOVector *qiov,
                                              size_t qiov_offset, int flags=
)
 {
@@ -2475,7 +2475,7 @@ static coroutine_fn int qcow2_co_pwritev_task_entry(A=
ioTask *task)
 }
=20
 static coroutine_fn int qcow2_co_pwritev_part(
-        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+        BlockDriverState *bs, int64_t offset, int64_t bytes,
         QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BDRVQcow2State *s =3D bs->opaque;
@@ -3803,9 +3803,9 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriver=
State *bs,
=20
 static int coroutine_fn
 qcow2_co_copy_range_from(BlockDriverState *bs,
-                         BdrvChild *src, uint64_t src_offset,
-                         BdrvChild *dst, uint64_t dst_offset,
-                         uint64_t bytes, BdrvRequestFlags read_flags,
+                         BdrvChild *src, int64_t src_offset,
+                         BdrvChild *dst, int64_t dst_offset,
+                         int64_t bytes, BdrvRequestFlags read_flags,
                          BdrvRequestFlags write_flags)
 {
     BDRVQcow2State *s =3D bs->opaque;
@@ -3884,9 +3884,9 @@ out:
=20
 static int coroutine_fn
 qcow2_co_copy_range_to(BlockDriverState *bs,
-                       BdrvChild *src, uint64_t src_offset,
-                       BdrvChild *dst, uint64_t dst_offset,
-                       uint64_t bytes, BdrvRequestFlags read_flags,
+                       BdrvChild *src, int64_t src_offset,
+                       BdrvChild *dst, int64_t dst_offset,
+                       int64_t bytes, BdrvRequestFlags read_flags,
                        BdrvRequestFlags write_flags)
 {
     BDRVQcow2State *s =3D bs->opaque;
@@ -4322,7 +4322,7 @@ static coroutine_fn int qcow2_co_pwritev_compressed_t=
ask_entry(AioTask *task)
  */
 static coroutine_fn int
 qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
-                                 uint64_t offset, uint64_t bytes,
+                                 int64_t offset, int64_t bytes,
                                  QEMUIOVector *qiov, size_t qiov_offset)
 {
     BDRVQcow2State *s =3D bs->opaque;
diff --git a/block/quorum.c b/block/quorum.c
index 6d7a56bd93..4164c3fbf8 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -660,8 +660,8 @@ static int read_fifo_child(QuorumAIOCB *acb)
     return ret;
 }
=20
-static int quorum_co_preadv(BlockDriverState *bs, uint64_t offset,
-                            uint64_t bytes, QEMUIOVector *qiov, int flags)
+static int quorum_co_preadv(BlockDriverState *bs, int64_t offset, int64_t =
bytes,
+                            QEMUIOVector *qiov, int flags)
 {
     BDRVQuorumState *s =3D bs->opaque;
     QuorumAIOCB *acb =3D quorum_aio_get(bs, qiov, offset, bytes, flags);
@@ -706,8 +706,8 @@ static void write_quorum_entry(void *opaque)
     }
 }
=20
-static int quorum_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                             uint64_t bytes, QEMUIOVector *qiov, int flags=
)
+static int quorum_co_pwritev(BlockDriverState *bs, int64_t offset,
+                             int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     BDRVQuorumState *s =3D bs->opaque;
     QuorumAIOCB *acb =3D quorum_aio_get(bs, qiov, offset, bytes, flags);
diff --git a/block/raw-format.c b/block/raw-format.c
index 93b25e1b6b..2537755f84 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -171,8 +171,8 @@ static void raw_reopen_abort(BDRVReopenState *state)
 }
=20
 /* Check and adjust the offset, against 'offset' and 'size' options. */
-static inline int raw_adjust_offset(BlockDriverState *bs, uint64_t *offset=
,
-                                    uint64_t bytes, bool is_write)
+static inline int raw_adjust_offset(BlockDriverState *bs, int64_t *offset,
+                                    int64_t bytes, bool is_write)
 {
     BDRVRawState *s =3D bs->opaque;
=20
@@ -191,8 +191,8 @@ static inline int raw_adjust_offset(BlockDriverState *b=
s, uint64_t *offset,
     return 0;
 }
=20
-static int coroutine_fn raw_co_preadv(BlockDriverState *bs, uint64_t offse=
t,
-                                      uint64_t bytes, QEMUIOVector *qiov,
+static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset=
,
+                                      int64_t bytes, QEMUIOVector *qiov,
                                       int flags)
 {
     int ret;
@@ -206,8 +206,8 @@ static int coroutine_fn raw_co_preadv(BlockDriverState =
*bs, uint64_t offset,
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
=20
-static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offs=
et,
-                                       uint64_t bytes, QEMUIOVector *qiov,
+static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t offse=
t,
+                                       int64_t bytes, QEMUIOVector *qiov,
                                        int flags)
 {
     void *buf =3D NULL;
@@ -284,7 +284,7 @@ static int coroutine_fn raw_co_pwrite_zeroes(BlockDrive=
rState *bs,
 {
     int ret;
=20
-    ret =3D raw_adjust_offset(bs, (uint64_t *)&offset, bytes, true);
+    ret =3D raw_adjust_offset(bs, &offset, bytes, true);
     if (ret) {
         return ret;
     }
@@ -296,7 +296,7 @@ static int coroutine_fn raw_co_pdiscard(BlockDriverStat=
e *bs,
 {
     int ret;
=20
-    ret =3D raw_adjust_offset(bs, (uint64_t *)&offset, bytes, true);
+    ret =3D raw_adjust_offset(bs, &offset, bytes, true);
     if (ret) {
         return ret;
     }
@@ -507,10 +507,10 @@ static int raw_probe_geometry(BlockDriverState *bs, H=
DGeometry *geo)
=20
 static int coroutine_fn raw_co_copy_range_from(BlockDriverState *bs,
                                                BdrvChild *src,
-                                               uint64_t src_offset,
+                                               int64_t src_offset,
                                                BdrvChild *dst,
-                                               uint64_t dst_offset,
-                                               uint64_t bytes,
+                                               int64_t dst_offset,
+                                               int64_t bytes,
                                                BdrvRequestFlags read_flags=
,
                                                BdrvRequestFlags write_flag=
s)
 {
@@ -526,10 +526,10 @@ static int coroutine_fn raw_co_copy_range_from(BlockD=
riverState *bs,
=20
 static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
                                              BdrvChild *src,
-                                             uint64_t src_offset,
+                                             int64_t src_offset,
                                              BdrvChild *dst,
-                                             uint64_t dst_offset,
-                                             uint64_t bytes,
+                                             int64_t dst_offset,
+                                             int64_t bytes,
                                              BdrvRequestFlags read_flags,
                                              BdrvRequestFlags write_flags)
 {
diff --git a/block/rbd.c b/block/rbd.c
index e637639a07..412df8cdb7 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1034,7 +1034,7 @@ failed:
 }
=20
 static BlockAIOCB *qemu_rbd_aio_preadv(BlockDriverState *bs,
-                                       uint64_t offset, uint64_t bytes,
+                                       int64_t offset, int64_t bytes,
                                        QEMUIOVector *qiov, int flags,
                                        BlockCompletionFunc *cb,
                                        void *opaque)
@@ -1044,7 +1044,7 @@ static BlockAIOCB *qemu_rbd_aio_preadv(BlockDriverSta=
te *bs,
 }
=20
 static BlockAIOCB *qemu_rbd_aio_pwritev(BlockDriverState *bs,
-                                        uint64_t offset, uint64_t bytes,
+                                        int64_t offset, int64_t bytes,
                                         QEMUIOVector *qiov, int flags,
                                         BlockCompletionFunc *cb,
                                         void *opaque)
diff --git a/block/throttle.c b/block/throttle.c
index 71f4bb0ad1..28e73073e7 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -114,7 +114,7 @@ static int64_t throttle_getlength(BlockDriverState *bs)
 }
=20
 static int coroutine_fn throttle_co_preadv(BlockDriverState *bs,
-                                           uint64_t offset, uint64_t bytes=
,
+                                           int64_t offset, int64_t bytes,
                                            QEMUIOVector *qiov, int flags)
 {
=20
@@ -125,7 +125,7 @@ static int coroutine_fn throttle_co_preadv(BlockDriverS=
tate *bs,
 }
=20
 static int coroutine_fn throttle_co_pwritev(BlockDriverState *bs,
-                                            uint64_t offset, uint64_t byte=
s,
+                                            int64_t offset, int64_t bytes,
                                             QEMUIOVector *qiov, int flags)
 {
     ThrottleGroupMember *tgm =3D bs->opaque;
diff --git a/block/vdi.c b/block/vdi.c
index e1a11f2aa0..07ad195239 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -547,7 +547,7 @@ static int coroutine_fn vdi_co_block_status(BlockDriver=
State *bs,
 }
=20
 static int coroutine_fn
-vdi_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vdi_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
               QEMUIOVector *qiov, int flags)
 {
     BDRVVdiState *s =3D bs->opaque;
@@ -603,7 +603,7 @@ vdi_co_preadv(BlockDriverState *bs, uint64_t offset, ui=
nt64_t bytes,
 }
=20
 static int coroutine_fn
-vdi_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vdi_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                QEMUIOVector *qiov, int flags)
 {
     BDRVVdiState *s =3D bs->opaque;
diff --git a/block/vmdk.c b/block/vmdk.c
index 218d9c9800..a88e9c9ba4 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1868,7 +1868,7 @@ static int vmdk_read_extent(VmdkExtent *extent, int64=
_t cluster_offset,
 }
=20
 static int coroutine_fn
-vmdk_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vmdk_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                QEMUIOVector *qiov, int flags)
 {
     BDRVVmdkState *s =3D bs->opaque;
@@ -2048,7 +2048,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_=
t offset,
 }
=20
 static int coroutine_fn
-vmdk_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vmdk_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                 QEMUIOVector *qiov, int flags)
 {
     int ret;
@@ -2060,8 +2060,8 @@ vmdk_co_pwritev(BlockDriverState *bs, uint64_t offset=
, uint64_t bytes,
 }
=20
 static int coroutine_fn
-vmdk_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
-                           uint64_t bytes, QEMUIOVector *qiov)
+vmdk_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t b=
ytes,
+                           QEMUIOVector *qiov)
 {
     if (bytes =3D=3D 0) {
         /* The caller will write bytes 0 to signal EOF.
diff --git a/block/vpc.c b/block/vpc.c
index 6df75e22dc..960c198afc 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -611,7 +611,7 @@ static int vpc_get_info(BlockDriverState *bs, BlockDriv=
erInfo *bdi)
 }
=20
 static int coroutine_fn
-vpc_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vpc_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
               QEMUIOVector *qiov, int flags)
 {
     BDRVVPCState *s =3D bs->opaque;
@@ -662,7 +662,7 @@ fail:
 }
=20
 static int coroutine_fn
-vpc_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vpc_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                QEMUIOVector *qiov, int flags)
 {
     BDRVVPCState *s =3D bs->opaque;
diff --git a/block/vvfat.c b/block/vvfat.c
index ab800c4887..97e6b0e2a5 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1538,7 +1538,7 @@ static int vvfat_read(BlockDriverState *bs, int64_t s=
ector_num,
 }
=20
 static int coroutine_fn
-vvfat_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vvfat_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                 QEMUIOVector *qiov, int flags)
 {
     int ret;
@@ -3073,7 +3073,7 @@ DLOG(checkpoint());
 }
=20
 static int coroutine_fn
-vvfat_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vvfat_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                  QEMUIOVector *qiov, int flags)
 {
     int ret;
@@ -3111,7 +3111,7 @@ static int coroutine_fn vvfat_co_block_status(BlockDr=
iverState *bs,
 }
=20
 static int coroutine_fn
-write_target_commit(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+write_target_commit(BlockDriverState *bs, int64_t offset, int64_t bytes,
                     QEMUIOVector *qiov, int flags)
 {
     int ret;
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index fa0e6a648b..c03b021777 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -65,7 +65,7 @@ static void co_reenter_bh(void *opaque)
 }
=20
 static int coroutine_fn bdrv_test_co_preadv(BlockDriverState *bs,
-                                            uint64_t offset, uint64_t byte=
s,
+                                            int64_t offset, int64_t bytes,
                                             QEMUIOVector *qiov, int flags)
 {
     BDRVTestState *s =3D bs->opaque;
@@ -1120,7 +1120,7 @@ static void bdrv_test_top_close(BlockDriverState *bs)
 }
=20
 static int coroutine_fn bdrv_test_top_co_preadv(BlockDriverState *bs,
-                                                uint64_t offset, uint64_t =
bytes,
+                                                int64_t offset, int64_t by=
tes,
                                                 QEMUIOVector *qiov, int fl=
ags)
 {
     BDRVTestTopState *tts =3D bs->opaque;
@@ -1862,8 +1862,8 @@ static void bdrv_replace_test_close(BlockDriverState =
*bs)
  *   Set .has_read to true and return success.
  */
 static int coroutine_fn bdrv_replace_test_co_preadv(BlockDriverState *bs,
-                                                    uint64_t offset,
-                                                    uint64_t bytes,
+                                                    int64_t offset,
+                                                    int64_t bytes,
                                                     QEMUIOVector *qiov,
                                                     int flags)
 {
diff --git a/block/trace-events b/block/trace-events
index e4d68438af..b7fc837015 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -78,7 +78,7 @@ luring_resubmit_short_read(void *s, void *luringcb, int n=
read) "LuringState %p l
=20
 # qcow2.c
 qcow2_add_task(void *co, void *bs, void *pool, const char *action, int clu=
ster_type, uint64_t file_cluster_offset, uint64_t offset, uint64_t bytes, v=
oid *qiov, size_t qiov_offset) "co %p bs %p pool %p: %s: cluster_type %d fi=
le_cluster_offset %" PRIu64 " offset %" PRIu64 " bytes %" PRIu64 " qiov %p =
qiov_offset %zu"
-qcow2_writev_start_req(void *co, int64_t offset, int bytes) "co %p offset =
0x%" PRIx64 " bytes %d"
+qcow2_writev_start_req(void *co, int64_t offset, int64_t bytes) "co %p off=
set 0x%" PRIx64 " bytes %" PRId64
 qcow2_writev_done_req(void *co, int ret) "co %p ret %d"
 qcow2_writev_start_part(void *co) "co %p"
 qcow2_writev_done_part(void *co, int cur_bytes) "co %p cur_bytes %d"
--=20
2.21.0


