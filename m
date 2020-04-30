Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873EAC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 417502076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="HF7+P5I8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 417502076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7Ak-000160-DT
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78e-0007A1-5h
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU775-0005Hi-G6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:55 -0400
Received: from mail-eopbgr80117.outbound.protection.outlook.com
 ([40.107.8.117]:39403 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75y-0003Yq-B6; Thu, 30 Apr 2020 07:11:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xquaj7um6ut7fNliv91odYE7P2XF6AvuM7n3VIX5s7jaFYqN6FCIf2YqNuM0SjPfLaXmEwRmp29iwypFR4AL2eu3IiRUMEck2hKtbDiWxmdH+47QqswL9gK297t8iia03VttgpqdqREHPolegtJSbS1EWuq5WLD/rg7Si9eDloT2OZMc/Fser5Uy4TcyBk6kuKT0VneC4D0emEcnkVaCusfPibEhl0rmK4RnYB+cutYT2HqRlDe98+xQEJInKa13283S61/sESU0qtlaI0W5LRBHj82LEmqDdc8U4fF0Ur+KOgmI24x42jWoJBnY3MyrOudlmq8tTrqSPdyFYRycLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQVZEUmlJUyIxRKWgtZ4QqTL9rUQ5Ko92pUVd+FmBiI=;
 b=Z02WL5IvtaEFnYpp0HHFfiHmKS1g2D0RuWnQZmK3DEEXqi+DYZQl9+xRjkDvcjFXHqGVVYOpcPiKpG3Fa4lm34ijw4rwZYPW0hD31bmQHR0UGw7Et2dDuQbH7iu3T9FJ9eg5z9tiQWl4DIp1iXRvmZgNMghJQr6quTBsmGMwD3lg5JWh/oUZrkMD5Dn1UIpF5CWfC6Wf3LfXDt34MGqX3bT3H1yqPxI8x7Rmtk9BpaB6c5eDGZazk8/dcF8rIYfOWrkBZBM692vuy2ffhMtzVnNPwOQTWLioEwv3zwjlzC7cyWxL2LYwyhiPShWw5RXdJXCbDDnq7DJudnIbkdv8Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQVZEUmlJUyIxRKWgtZ4QqTL9rUQ5Ko92pUVd+FmBiI=;
 b=HF7+P5I808eWowbODT9AVICGxYzmhLivoHcSxsSbqv653prPXXfPdEkI2lg7HneiS9khJ3LAj2r9iWotWWq3HjmbRuK80eRZmaegv0zui4GpbF9t/SPJ7l6Ydxi6hVhGi5W+mboPjmslVmK/cM/nM0suQYoR7LPRMt00SojlEF8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 11:11:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:11:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 13/17] block: use int64_t instead of uint64_t in driver
 read handlers
Date: Thu, 30 Apr 2020 14:10:29 +0300
Message-Id: <20200430111033.29980-14-vsementsov@virtuozzo.com>
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
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:11:06 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9798f3e6-f560-4ffa-d192-08d7ecf72e58
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB544742D63DA8168C55CA96CBC1AA0@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:151;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(376002)(396003)(366004)(66556008)(6512007)(107886003)(316002)(6506007)(26005)(52116002)(186003)(478600001)(956004)(2616005)(16526019)(66476007)(2906002)(30864003)(86362001)(5660300002)(66946007)(6486002)(6916009)(7416002)(36756003)(8936002)(1076003)(6666004)(8676002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZCh/6ZQkpTFzFEI2HWG7P7syLisFuUrfwJMSXZrQ+kSVnoOqdHZgkGqbjezVGQARWCj79QNqNcI26fumTP+mgTfoYa4VW4Ws8DqKFyoypNWIqRqMoKeycJA3HEDaqHzQq35FsFmWJu6l7UCEedG1htF8X26lVnE6kfVFVxChiX0Zh5EUws5LR58+ouljacCP5OpuzClgawDlulibTK34hr9Fk642EtjpQ2xHZoBHF3ov6GAAaIeOab7zHeU+eZ8AzMxwzRpmJ84Ig2W6PhzMzSHaOVztsxu1L+kqiODyI6uIXtvRE6oY3RIxKXZfyWknQXN4W79TlmQTnZ4u2A1f8PZMzIg5WkbCrT4eTDRUbXREprLAMedh0zHPVlRRwnL8K8C8nc4IgX2FgYhg0gp8RYdU9hAZZfbk6juK6D89YWmhxHrzwVJnWYQIEyMooUA
X-MS-Exchange-AntiSpam-MessageData: 3uXGGUJdtY7NE4xt+2RDrWciJoa2WBWLZgn3idPmT+ToF7BLAkYHNE62gcPiV/4gWXNX/+UN5P33ZA9nCCRzAQcLG8uYSU8z5Q5jNCUe0taSXXDE6SMlhZdeutvV4V2dw4uN6gLQmYIUzF2SVYz53SabalGUkcioteMq46IhFP8aq2Kd8uhcqTXrss9+Jk71zp9bzv1Cyd/4Dhri/ochRrKfJh+L66V2WWz2HbuPWU8oA8zUvH4s85XslRyPzjEkYvLm6ncrpQ0MLXIUD6WIN/ymEFtTjKVWlFbP6alcgCSM1Mnbu/YAod/KQIVtX2xiTcJ2FhcJOsgsGN4pKZZPaqjw7sh8SGs0bA0zcF6FiWSBOvY3Aq7Oaoa1EvkEKmMyGdHB8RQJikth+r4AZSMIN+rEzZ8sk0lS2hIVkaGu1ScqlKDsUjGkbI7eslsYOrKmfZQG3J+3CSpVk+zu/kwp4jPiry2uRp4DiupKTUADM9q8TFAusn57Db3X8shq+w2Z3zuwb6GipWZ/Ff/donnYkp2f/uvy2jrpI8tLJnFcQaKo0JNEGJXfXwLFDaRfC4YjuGqo/8kL8dBJ1blsAze4hikQUkUEVwB8dYCZdcpo0h1Fq27/zFAhwpQsnvvKVX4LgcR2ZLJUyCygft3Q7ua0PNq3r4ZSWHj8aqHFgzlgZCh8UTK/AExYqePGueJ25Y/E+nfvp/vtgcutzfxZd7xhgDd6IM/oPaCQawm6lWT1dLJvgSZLfJcMtz2J6Mgce/ts9Yq4z3CB4d3DGOzcdGwsrfe2vg6UvmUeTCGFqA4ZGAs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9798f3e6-f560-4ffa-d192-08d7ecf72e58
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:11:07.7791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sX2PC6j/XjeLSGFxX958mLDV39rbP5jlSWSrUdgG2VFrAiVBW2lvhJpiRLXD8rOyrQ+DaMTWsErlfj0aHzNyCy8JPzmH4oiGY1idvgy1zCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
Received-SPF: pass client-ip=40.107.8.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 07:11:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.8.117
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

So, convert driver read handlers parameters which are already 64bit to
signed type.

While being here, convert also flags parameter to be BdrvRequestFlags.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h   | 11 ++++++-----
 block/backup-top.c          |  4 ++--
 block/blkdebug.c            |  4 ++--
 block/blklogwrites.c        |  4 ++--
 block/blkreplay.c           |  2 +-
 block/blkverify.c           |  4 ++--
 block/bochs.c               |  4 ++--
 block/cloop.c               |  4 ++--
 block/commit.c              |  2 +-
 block/copy-on-read.c        |  5 +++--
 block/crypto.c              |  4 ++--
 block/curl.c                |  3 ++-
 block/dmg.c                 |  4 ++--
 block/file-posix.c          |  6 +++---
 block/file-win32.c          |  4 ++--
 block/filter-compress.c     |  4 ++--
 block/mirror.c              |  2 +-
 block/nbd.c                 |  5 +++--
 block/nfs.c                 |  6 +++---
 block/null.c                |  9 +++++----
 block/nvme.c                |  5 +++--
 block/qcow.c                |  6 +++---
 block/qcow2.c               |  5 +++--
 block/quorum.c              |  4 ++--
 block/raw-format.c          | 20 ++++++++++----------
 block/rbd.c                 |  5 +++--
 block/throttle.c            |  5 +++--
 block/vdi.c                 |  4 ++--
 block/vmdk.c                |  4 ++--
 block/vpc.c                 |  4 ++--
 block/vvfat.c               |  4 ++--
 block/vxhs.c                |  4 ++--
 tests/test-bdrv-drain.c     | 16 +++++++++-------
 tests/test-block-iothread.c | 19 ++++++++++++++-----
 34 files changed, 108 insertions(+), 88 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 28aea2bcfd..7b5f936269 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -180,8 +180,8 @@ struct BlockDriver {
 
     /* aio */
     BlockAIOCB *(*bdrv_aio_preadv)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
-        BlockCompletionFunc *cb, void *opaque);
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov,
+        BdrvRequestFlags flags, BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_pwritev)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
         BlockCompletionFunc *cb, void *opaque);
@@ -210,10 +210,11 @@ struct BlockDriver {
      * The buffer in @qiov may point directly to guest memory.
      */
     int coroutine_fn (*bdrv_co_preadv)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags);
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov,
+        BdrvRequestFlags flags);
     int coroutine_fn (*bdrv_co_preadv_part)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes,
-        QEMUIOVector *qiov, size_t qiov_offset, int flags);
+        int64_t offset, int64_t bytes,
+        QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
     int coroutine_fn (*bdrv_co_writev)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov, int flags);
     /**
diff --git a/block/backup-top.c b/block/backup-top.c
index 3b50c06e2c..289fee5a92 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -42,8 +42,8 @@ typedef struct BDRVBackupTopState {
 } BDRVBackupTopState;
 
 static coroutine_fn int backup_top_co_preadv(
-        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-        QEMUIOVector *qiov, int flags)
+        BlockDriverState *bs, int64_t offset, int64_t bytes,
+        QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
diff --git a/block/blkdebug.c b/block/blkdebug.c
index af44aa973f..7e02156c63 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -619,8 +619,8 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
 }
 
 static int coroutine_fn
-blkdebug_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                   QEMUIOVector *qiov, int flags)
+blkdebug_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                   QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     int err;
 
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 04d8b33607..db60b396bc 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -307,8 +307,8 @@ static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
 }
 
 static int coroutine_fn
-blk_log_writes_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                         QEMUIOVector *qiov, int flags)
+blk_log_writes_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                         QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
diff --git a/block/blkreplay.c b/block/blkreplay.c
index c96ac8f4bc..c8dd17bfff 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -73,7 +73,7 @@ static void block_request_create(uint64_t reqid, BlockDriverState *bs,
 }
 
 static int coroutine_fn blkreplay_co_preadv(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     uint64_t reqid = blkreplay_next_id();
     int ret = bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
diff --git a/block/blkverify.c b/block/blkverify.c
index 667e60d832..6bc2982a95 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -224,8 +224,8 @@ blkverify_co_prwv(BlockDriverState *bs, BlkverifyRequest *r, uint64_t offset,
 }
 
 static int coroutine_fn
-blkverify_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                    QEMUIOVector *qiov, int flags)
+blkverify_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                    QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     BlkverifyRequest r;
     QEMUIOVector raw_qiov;
diff --git a/block/bochs.c b/block/bochs.c
index 32bb83b268..7c8c181705 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -238,8 +238,8 @@ static int64_t seek_to_sector(BlockDriverState *bs, int64_t sector_num)
 }
 
 static int coroutine_fn
-bochs_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                QEMUIOVector *qiov, int flags)
+bochs_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     BDRVBochsState *s = bs->opaque;
     uint64_t sector_num = offset >> BDRV_SECTOR_BITS;
diff --git a/block/cloop.c b/block/cloop.c
index 4de94876d4..5322f720db 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -245,8 +245,8 @@ static inline int cloop_read_block(BlockDriverState *bs, int block_num)
 }
 
 static int coroutine_fn
-cloop_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                QEMUIOVector *qiov, int flags)
+cloop_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     BDRVCloopState *s = bs->opaque;
     uint64_t sector_num = offset >> BDRV_SECTOR_BITS;
diff --git a/block/commit.c b/block/commit.c
index 8e672799af..517f9aa7a0 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -211,7 +211,7 @@ static const BlockJobDriver commit_job_driver = {
 };
 
 static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 242d3ff055..c2a0916b66 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -74,8 +74,9 @@ static int64_t cor_getlength(BlockDriverState *bs)
 
 
 static int coroutine_fn cor_co_preadv(BlockDriverState *bs,
-                                      uint64_t offset, uint64_t bytes,
-                                      QEMUIOVector *qiov, int flags)
+                                      int64_t offset, int64_t bytes,
+                                      QEMUIOVector *qiov,
+                                      BdrvRequestFlags flags)
 {
     return bdrv_co_preadv(bs->file, offset, bytes, qiov,
                           flags | BDRV_REQ_COPY_ON_READ);
diff --git a/block/crypto.c b/block/crypto.c
index d577f89659..4df71b25f1 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -335,8 +335,8 @@ static int block_crypto_reopen_prepare(BDRVReopenState *state,
 #define BLOCK_CRYPTO_MAX_IO_SIZE (1024 * 1024)
 
 static coroutine_fn int
-block_crypto_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                       QEMUIOVector *qiov, int flags)
+block_crypto_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                       QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     BlockCrypto *crypto = bs->opaque;
     uint64_t cur_bytes; /* number of bytes in current iteration */
diff --git a/block/curl.c b/block/curl.c
index 6e325901dc..39086e83c3 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -922,7 +922,8 @@ out:
 }
 
 static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov,
+        BdrvRequestFlags flags)
 {
     CURLAIOCB acb = {
         .co = qemu_coroutine_self(),
diff --git a/block/dmg.c b/block/dmg.c
index 4a045f2b3e..0e3ac05371 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -689,8 +689,8 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
 }
 
 static int coroutine_fn
-dmg_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-              QEMUIOVector *qiov, int flags)
+dmg_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+              QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     BDRVDMGState *s = bs->opaque;
     uint64_t sector_num = offset >> BDRV_SECTOR_BITS;
diff --git a/block/file-posix.c b/block/file-posix.c
index 7e19bbff5f..1026e6040b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1941,9 +1941,9 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
     return raw_thread_pool_submit(bs, handle_aiocb_rw, &acb);
 }
 
-static int coroutine_fn raw_co_preadv(BlockDriverState *bs, uint64_t offset,
-                                      uint64_t bytes, QEMUIOVector *qiov,
-                                      int flags)
+static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
+                                      int64_t bytes, QEMUIOVector *qiov,
+                                      BdrvRequestFlags flags)
 {
     return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_READ);
 }
diff --git a/block/file-win32.c b/block/file-win32.c
index 15859839a1..8a163837ab 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -415,8 +415,8 @@ fail:
 }
 
 static BlockAIOCB *raw_aio_preadv(BlockDriverState *bs,
-                                  uint64_t offset, uint64_t bytes,
-                                  QEMUIOVector *qiov, int flags,
+                                  int64_t offset, int64_t bytes,
+                                  QEMUIOVector *qiov, BdrvRequestFlags flags,
                                   BlockCompletionFunc *cb, void *opaque)
 {
     BDRVRawState *s = bs->opaque;
diff --git a/block/filter-compress.c b/block/filter-compress.c
index 82c315b298..e61de56b96 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -62,10 +62,10 @@ static int64_t compress_getlength(BlockDriverState *bs)
 
 
 static int coroutine_fn compress_co_preadv_part(BlockDriverState *bs,
-                                                uint64_t offset, uint64_t bytes,
+                                                int64_t offset, int64_t bytes,
                                                 QEMUIOVector *qiov,
                                                 size_t qiov_offset,
-                                                int flags)
+                                                BdrvRequestFlags flags)
 {
     return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
                                flags);
diff --git a/block/mirror.c b/block/mirror.c
index c26fd9260d..7cd720ac32 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1365,7 +1365,7 @@ static void coroutine_fn active_write_settle(MirrorOp *op)
 }
 
 static int coroutine_fn bdrv_mirror_top_preadv(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
diff --git a/block/nbd.c b/block/nbd.c
index 2160859f64..fedad8843f 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1160,8 +1160,9 @@ static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
     return ret ? ret : request_ret;
 }
 
-static int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
-                                uint64_t bytes, QEMUIOVector *qiov, int flags)
+static int nbd_client_co_preadv(BlockDriverState *bs, int64_t offset,
+                                int64_t bytes, QEMUIOVector *qiov,
+                                BdrvRequestFlags flags)
 {
     int ret, request_ret;
     Error *local_err = NULL;
diff --git a/block/nfs.c b/block/nfs.c
index cc2413d5ab..647250e4d8 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -263,9 +263,9 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
                                      nfs_co_generic_bh_cb, task);
 }
 
-static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offset,
-                                      uint64_t bytes, QEMUIOVector *iov,
-                                      int flags)
+static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
+                                      int64_t bytes, QEMUIOVector *iov,
+                                      BdrvRequestFlags flags)
 {
     NFSClient *client = bs->opaque;
     NFSRPC task;
diff --git a/block/null.c b/block/null.c
index 15e1d56746..e2a59caf46 100644
--- a/block/null.c
+++ b/block/null.c
@@ -116,8 +116,9 @@ static coroutine_fn int null_co_common(BlockDriverState *bs)
 }
 
 static coroutine_fn int null_co_preadv(BlockDriverState *bs,
-                                       uint64_t offset, uint64_t bytes,
-                                       QEMUIOVector *qiov, int flags)
+                                       int64_t offset, int64_t bytes,
+                                       QEMUIOVector *qiov,
+                                       BdrvRequestFlags flags)
 {
     BDRVNullState *s = bs->opaque;
 
@@ -187,8 +188,8 @@ static inline BlockAIOCB *null_aio_common(BlockDriverState *bs,
 }
 
 static BlockAIOCB *null_aio_preadv(BlockDriverState *bs,
-                                   uint64_t offset, uint64_t bytes,
-                                   QEMUIOVector *qiov, int flags,
+                                   int64_t offset, int64_t bytes,
+                                   QEMUIOVector *qiov, BdrvRequestFlags flags,
                                    BlockCompletionFunc *cb,
                                    void *opaque)
 {
diff --git a/block/nvme.c b/block/nvme.c
index 7b7c0cc5d6..c79e398bff 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1062,8 +1062,9 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
 }
 
 static coroutine_fn int nvme_co_preadv(BlockDriverState *bs,
-                                       uint64_t offset, uint64_t bytes,
-                                       QEMUIOVector *qiov, int flags)
+                                       int64_t offset, int64_t bytes,
+                                       QEMUIOVector *qiov,
+                                       BdrvRequestFlags flags)
 {
     return nvme_co_prw(bs, offset, bytes, qiov, false, flags);
 }
diff --git a/block/qcow.c b/block/qcow.c
index 8973e4e565..40fc5b96a4 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -628,9 +628,9 @@ static void qcow_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.request_alignment = BDRV_SECTOR_SIZE;
 }
 
-static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, uint64_t offset,
-                                       uint64_t bytes, QEMUIOVector *qiov,
-                                       int flags)
+static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, int64_t offset,
+                                       int64_t bytes, QEMUIOVector *qiov,
+                                       BdrvRequestFlags flags)
 {
     BDRVQcowState *s = bs->opaque;
     int offset_in_cluster;
diff --git a/block/qcow2.c b/block/qcow2.c
index b524b0c53f..817b0bfd2b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2202,9 +2202,10 @@ static coroutine_fn int qcow2_co_preadv_task_entry(AioTask *task)
 }
 
 static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
-                                             uint64_t offset, uint64_t bytes,
+                                             int64_t offset, int64_t bytes,
                                              QEMUIOVector *qiov,
-                                             size_t qiov_offset, int flags)
+                                             size_t qiov_offset,
+                                             BdrvRequestFlags flags)
 {
     BDRVQcow2State *s = bs->opaque;
     int ret = 0;
diff --git a/block/quorum.c b/block/quorum.c
index 6d7a56bd93..3c65c05d17 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -660,8 +660,8 @@ static int read_fifo_child(QuorumAIOCB *acb)
     return ret;
 }
 
-static int quorum_co_preadv(BlockDriverState *bs, uint64_t offset,
-                            uint64_t bytes, QEMUIOVector *qiov, int flags)
+static int quorum_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                            QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     BDRVQuorumState *s = bs->opaque;
     QuorumAIOCB *acb = quorum_aio_get(bs, qiov, offset, bytes, flags);
diff --git a/block/raw-format.c b/block/raw-format.c
index 93b25e1b6b..709b8aecdb 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -171,8 +171,8 @@ static void raw_reopen_abort(BDRVReopenState *state)
 }
 
 /* Check and adjust the offset, against 'offset' and 'size' options. */
-static inline int raw_adjust_offset(BlockDriverState *bs, uint64_t *offset,
-                                    uint64_t bytes, bool is_write)
+static inline int raw_adjust_offset(BlockDriverState *bs, int64_t *offset,
+                                    int64_t bytes, bool is_write)
 {
     BDRVRawState *s = bs->opaque;
 
@@ -191,9 +191,9 @@ static inline int raw_adjust_offset(BlockDriverState *bs, uint64_t *offset,
     return 0;
 }
 
-static int coroutine_fn raw_co_preadv(BlockDriverState *bs, uint64_t offset,
-                                      uint64_t bytes, QEMUIOVector *qiov,
-                                      int flags)
+static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
+                                      int64_t bytes, QEMUIOVector *qiov,
+                                      BdrvRequestFlags flags)
 {
     int ret;
 
@@ -249,7 +249,7 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
         qiov = &local_qiov;
     }
 
-    ret = raw_adjust_offset(bs, &offset, bytes, true);
+    ret = raw_adjust_offset(bs, (int64_t *)&offset, bytes, true);
     if (ret) {
         goto fail;
     }
@@ -284,7 +284,7 @@ static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
 {
     int ret;
 
-    ret = raw_adjust_offset(bs, (uint64_t *)&offset, bytes, true);
+    ret = raw_adjust_offset(bs, (int64_t *)&offset, bytes, true);
     if (ret) {
         return ret;
     }
@@ -296,7 +296,7 @@ static int coroutine_fn raw_co_pdiscard(BlockDriverState *bs,
 {
     int ret;
 
-    ret = raw_adjust_offset(bs, (uint64_t *)&offset, bytes, true);
+    ret = raw_adjust_offset(bs, &offset, bytes, true);
     if (ret) {
         return ret;
     }
@@ -516,7 +516,7 @@ static int coroutine_fn raw_co_copy_range_from(BlockDriverState *bs,
 {
     int ret;
 
-    ret = raw_adjust_offset(bs, &src_offset, bytes, false);
+    ret = raw_adjust_offset(bs, (int64_t *)&src_offset, bytes, false);
     if (ret) {
         return ret;
     }
@@ -535,7 +535,7 @@ static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
 {
     int ret;
 
-    ret = raw_adjust_offset(bs, &dst_offset, bytes, true);
+    ret = raw_adjust_offset(bs, (int64_t *)&dst_offset, bytes, true);
     if (ret) {
         return ret;
     }
diff --git a/block/rbd.c b/block/rbd.c
index e637639a07..b7edd685f6 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1034,8 +1034,9 @@ failed:
 }
 
 static BlockAIOCB *qemu_rbd_aio_preadv(BlockDriverState *bs,
-                                       uint64_t offset, uint64_t bytes,
-                                       QEMUIOVector *qiov, int flags,
+                                       int64_t offset, int64_t bytes,
+                                       QEMUIOVector *qiov,
+                                       BdrvRequestFlags flags,
                                        BlockCompletionFunc *cb,
                                        void *opaque)
 {
diff --git a/block/throttle.c b/block/throttle.c
index 71f4bb0ad1..63d1956074 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -114,8 +114,9 @@ static int64_t throttle_getlength(BlockDriverState *bs)
 }
 
 static int coroutine_fn throttle_co_preadv(BlockDriverState *bs,
-                                           uint64_t offset, uint64_t bytes,
-                                           QEMUIOVector *qiov, int flags)
+                                           int64_t offset, int64_t bytes,
+                                           QEMUIOVector *qiov,
+                                           BdrvRequestFlags flags)
 {
 
     ThrottleGroupMember *tgm = bs->opaque;
diff --git a/block/vdi.c b/block/vdi.c
index e1a11f2aa0..1b5365f34c 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -547,8 +547,8 @@ static int coroutine_fn vdi_co_block_status(BlockDriverState *bs,
 }
 
 static int coroutine_fn
-vdi_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-              QEMUIOVector *qiov, int flags)
+vdi_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+              QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     BDRVVdiState *s = bs->opaque;
     QEMUIOVector local_qiov;
diff --git a/block/vmdk.c b/block/vmdk.c
index 218d9c9800..a1a0a77fe9 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1868,8 +1868,8 @@ static int vmdk_read_extent(VmdkExtent *extent, int64_t cluster_offset,
 }
 
 static int coroutine_fn
-vmdk_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-               QEMUIOVector *qiov, int flags)
+vmdk_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+               QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     BDRVVmdkState *s = bs->opaque;
     int ret;
diff --git a/block/vpc.c b/block/vpc.c
index d8141b52da..45c254c3f7 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -611,8 +611,8 @@ static int vpc_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 }
 
 static int coroutine_fn
-vpc_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-              QEMUIOVector *qiov, int flags)
+vpc_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+              QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     BDRVVPCState *s = bs->opaque;
     int ret;
diff --git a/block/vvfat.c b/block/vvfat.c
index ab800c4887..80d488f556 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1538,8 +1538,8 @@ static int vvfat_read(BlockDriverState *bs, int64_t sector_num,
 }
 
 static int coroutine_fn
-vvfat_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
-                QEMUIOVector *qiov, int flags)
+vvfat_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     int ret;
     BDRVVVFATState *s = bs->opaque;
diff --git a/block/vxhs.c b/block/vxhs.c
index d79fc97df6..a1e437b2cb 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -480,8 +480,8 @@ errout:
 }
 
 static BlockAIOCB *vxhs_aio_preadv(BlockDriverState *bs,
-                                   uint64_t offset, uint64_t bytes,
-                                   QEMUIOVector *qiov, int flags,
+                                   int64_t offset, int64_t bytes,
+                                   QEMUIOVector *qiov, BdrvRequestFlags flags,
                                    BlockCompletionFunc *cb, void *opaque)
 {
     return vxhs_aio_rw(bs, offset, qiov, bytes, cb, opaque, VDISK_AIO_READ);
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index fa0e6a648b..f384e0eb32 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -65,8 +65,9 @@ static void co_reenter_bh(void *opaque)
 }
 
 static int coroutine_fn bdrv_test_co_preadv(BlockDriverState *bs,
-                                            uint64_t offset, uint64_t bytes,
-                                            QEMUIOVector *qiov, int flags)
+                                            int64_t offset, int64_t bytes,
+                                            QEMUIOVector *qiov,
+                                            BdrvRequestFlags flags)
 {
     BDRVTestState *s = bs->opaque;
 
@@ -1120,8 +1121,9 @@ static void bdrv_test_top_close(BlockDriverState *bs)
 }
 
 static int coroutine_fn bdrv_test_top_co_preadv(BlockDriverState *bs,
-                                                uint64_t offset, uint64_t bytes,
-                                                QEMUIOVector *qiov, int flags)
+                                                int64_t offset, int64_t bytes,
+                                                QEMUIOVector *qiov,
+                                                BdrvRequestFlags flags)
 {
     BDRVTestTopState *tts = bs->opaque;
     return bdrv_co_preadv(tts->wait_child, offset, bytes, qiov, flags);
@@ -1862,10 +1864,10 @@ static void bdrv_replace_test_close(BlockDriverState *bs)
  *   Set .has_read to true and return success.
  */
 static int coroutine_fn bdrv_replace_test_co_preadv(BlockDriverState *bs,
-                                                    uint64_t offset,
-                                                    uint64_t bytes,
+                                                    int64_t offset,
+                                                    int64_t bytes,
                                                     QEMUIOVector *qiov,
-                                                    int flags)
+                                                    BdrvRequestFlags flags)
 {
     BDRVReplaceTestState *s = bs->opaque;
 
diff --git a/tests/test-block-iothread.c b/tests/test-block-iothread.c
index 0c861809f0..9567617c50 100644
--- a/tests/test-block-iothread.c
+++ b/tests/test-block-iothread.c
@@ -31,9 +31,18 @@
 #include "qemu/main-loop.h"
 #include "iothread.h"
 
-static int coroutine_fn bdrv_test_co_prwv(BlockDriverState *bs,
-                                          uint64_t offset, uint64_t bytes,
-                                          QEMUIOVector *qiov, int flags)
+static int coroutine_fn bdrv_test_co_preadv(BlockDriverState *bs,
+                                            int64_t offset, int64_t bytes,
+                                            QEMUIOVector *qiov,
+                                            BdrvRequestFlags flags)
+{
+    return 0;
+}
+
+static int coroutine_fn bdrv_test_co_pwritev(BlockDriverState *bs,
+                                             uint64_t offset, uint64_t bytes,
+                                             QEMUIOVector *qiov,
+                                             BdrvRequestFlags flags)
 {
     return 0;
 }
@@ -65,8 +74,8 @@ static BlockDriver bdrv_test = {
     .format_name            = "test",
     .instance_size          = 1,
 
-    .bdrv_co_preadv         = bdrv_test_co_prwv,
-    .bdrv_co_pwritev        = bdrv_test_co_prwv,
+    .bdrv_co_preadv         = bdrv_test_co_preadv,
+    .bdrv_co_pwritev        = bdrv_test_co_pwritev,
     .bdrv_co_pdiscard       = bdrv_test_co_pdiscard,
     .bdrv_co_truncate       = bdrv_test_co_truncate,
     .bdrv_co_block_status   = bdrv_test_co_block_status,
-- 
2.21.0


