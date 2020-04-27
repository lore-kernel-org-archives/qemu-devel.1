Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36041C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:29:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFADE20728
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pksr0N9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFADE20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSz8k-0004vN-1k
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3p-000375-NS
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3o-0008GE-9p
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:17 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
 ([40.107.7.99]:65188 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3k-0007mE-EN; Mon, 27 Apr 2020 04:24:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boSBxMAEulyx1WT0tm/IQZSzO6f52BzSc3XAQQovBF2Pufln8LUARboh8g5AyGBsYAhrtN++BI2QHCDa0UjRnKR7MAs9IVCvZCft3jRuRfka9DX0ecwwsKhIuOnFRmwSQWVzXGgIc5xwpywsHc+MtGxg8qtPfNlLG68WtGCUIiw6O62LXj5XercUJVrvO6rYyAp9g8H0M3CVzLQM2cS24HOqr5DPsNHmX/HVSUCW2nz/1wmXLHiPruNhBZt8CEyfF9oikM5pKRbnrPkWgV6FbLrOhzRtQryzoyeDzsgTwjvUfpy3DxonxQRxSj2ogSWNgjl2hKxDWPWSflPs4eZ7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ+BFuGbzp9YXYnPzYlMFcVEE9PKdjmeX6MpHPdk5Qg=;
 b=hCAF/K8fjx3jgXptzH5FAuSjTKh8X/dccrqRCT0EY0mMk4U2QvLl40TuaT4YaiNeLFGtoyEBL7rlXpcbS8QNG+Qht4isiGt1FDQT6/iAOHNE4W3WfpOLxaGBOS6OBhqFOYFNiCNBfaNczdqTc97rxYyThCu8xas6KCvXy/VeXc+jv74eGZpIz8rbatbrD+bVdTlt/k0stcefIyXYnYiFD/iB5Umaoo9sK4hCXwg6ULNY0fvzcaRnf1M5VnAsk8AkYf0fgupZB7mHUNjhSy/r9qy7o0+wL+/+jkGDleEyDa85ie5972BB3PG5GRZNaQOmgvkc403QdiidM8kHZl9cSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ+BFuGbzp9YXYnPzYlMFcVEE9PKdjmeX6MpHPdk5Qg=;
 b=pksr0N9SPoXWDYUt+uYI+NYz7hEBMiLa6OzWP0u/R6c9vPvUKaIAndRy/VpiReUfnfFZA+AUPqb+oACrIKquj4nzHaUSuzjFadLgun4coHWZsSRxDwcTXJH19b+XMTh9Zw8Kfbmkedt44qiU0ryBq+2pYzXwN6W5aDjceRkTUDg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:24:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:24:09 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 13/17] block: use int64_t instead of uint64_t in driver
 read handlers
Date: Mon, 27 Apr 2020 11:23:21 +0300
Message-Id: <20200427082325.10414-14-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427082325.10414-1-vsementsov@virtuozzo.com>
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:24:08 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ed33209-0ea7-4515-3b5c-08d7ea845c00
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB546395A3074F684E46334B48C1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:37;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(2906002)(81156014)(6486002)(26005)(8676002)(8936002)(4326008)(6916009)(478600001)(66556008)(7416002)(66946007)(66476007)(6666004)(16526019)(316002)(2616005)(1076003)(186003)(5660300002)(52116002)(6506007)(30864003)(956004)(36756003)(107886003)(6512007)(69590400007)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BmM0/qUkqCbaFLf6uZwvdfh9TaD5TY1NWrYNvfvv6OSoEtCQfWv8kcPNU5kJmR4HknrIE8FL0he4z4dePc/ZmWpDdutVL2ejRvDt60nzaFr8MVFd8xM5+tEY4I4oqls8/UU78QID+56dnkQDjYQ6EqIK8mA7NTOpnWi9K7vXxDkfog0rqfwABJFrLfi/qEI8vqrq/76j0HYeVo4KyNKMziuS2klM9Mb3GGwkl53vOlPvyIhUGD+2xM2yWwuwufZwNN2gbOoiuX8ihKJfVUyqSIRErtPVBw16XFyMMlfQWrVrvESAaL4LOgvtODs+CkUXFecniwym+He1UK31ESQVJdedQAxcmAd+NTe1yaInzQm31PokJe6YFV2py6GJDMkdMYRzQcEbTl2N5utN9VsRn/dAFo27DJi9NtUSgYvzaTt4MGsuNEKVWO52dS/3mlrpaRA0WJzZ4Qjan9Yvujlj6K56yl3UvOBRMLJwvObiwHas9mgrQDFiz/6ZPAttoQlb
X-MS-Exchange-AntiSpam-MessageData: hdXK2y0ybrB52rqrJYWWTiG9IPkXM90jAuOGfTqsR3qdEUeX+h6AUv4XOr01e6Alcg0Z+3F37JA/1JjXy/xlR5sEL6dQXIsspQOCeJ2EOegV6tRKw7vCmic2I5xTV8SFcBdfJd0QVODT1iwKwY6J+HkWVipLFWPP+qWOAkpMYVl3oZP9PdBkYlZHZ7Lf2RJyDOngrMhjRV6N0g0fbzi420FVUp4hDTsOuRscfMrgHF7LkSNl2XAFV+s1fHoxwrmQQWAJe34Az1T18X0/3gtWSjlafy8e+6c+WC7bPJb8eZ8xKDvU9Lisnmt9tLQvkl+uVhqFK4bDOEGGjie26e47tODogmEh/FjAZHD1w7LOFKXY1oTqCpOrLgp7G5A0OYEmvB54EHpC3zlWJvlHJXn7cDh0ANegW+Ff0fGc670gEKg2L5XjmsQCoJtIVql9ZNr/Em0V6zykY5YvETgZGqug9GzxMKA/dIdMD16d6rp5r3YqEUXBGXQ68ujKqz16uc32OEpn4b7AcOPLBgtb+3TxrtxusXPV+V1q3l4KXoq5KOS8Ubc1qU1i5nWmmr9i8kOHQBFg1KcTcdU9P8XLJ7kN3WhVx4Z6BdZjLT5mwcFY9mOJnYGWiaSMiBjsnBTli07MrkyHNWG1Um66zMvMwRfQu1tQ6yEC7U+hE8PAIIC9yPoSjfh8aPA2B6eddwNiQrmqyTQ7u6ZjOnwPBV3evp9EggDI8OqBBh/Q+NHac6uETkgCE1n6RIrk11k2ufO/MyjUQiLlu35lsYL8rcq29AtoOolOuCA3lWagmqrTHwmxwKY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed33209-0ea7-4515-3b5c-08d7ea845c00
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:24:09.8397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZT9MWGSU9Lqg9q6uHb6dRMDU7Bc5IUdvGvPmmO/P9cqnkV42Q+EPZujI0mZTYXV5myNuFOdB6kmpe7ok72bQXD4zkIFC1KHNtRXZ0dE/F4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.7.99;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:24:06
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.99
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
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are generally moving to int64_t for both offset and bytes parameters
on all io paths. Convert driver read handlers parameters which are
already 64bit to signed type.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  6 +++---
 block/backup-top.c        |  2 +-
 block/blkdebug.c          |  2 +-
 block/blklogwrites.c      |  2 +-
 block/blkreplay.c         |  2 +-
 block/blkverify.c         |  2 +-
 block/bochs.c             |  2 +-
 block/cloop.c             |  2 +-
 block/commit.c            |  2 +-
 block/copy-on-read.c      |  2 +-
 block/crypto.c            |  2 +-
 block/curl.c              |  2 +-
 block/dmg.c               |  2 +-
 block/file-posix.c        |  4 ++--
 block/filter-compress.c   |  2 +-
 block/mirror.c            |  2 +-
 block/nbd.c               |  4 ++--
 block/nfs.c               |  4 ++--
 block/null.c              |  4 ++--
 block/nvme.c              |  2 +-
 block/qcow.c              |  4 ++--
 block/qcow2.c             |  2 +-
 block/quorum.c            |  4 ++--
 block/raw-format.c        | 18 +++++++++---------
 block/rbd.c               |  2 +-
 block/throttle.c          |  2 +-
 block/vdi.c               |  2 +-
 block/vmdk.c              |  2 +-
 block/vpc.c               |  2 +-
 block/vvfat.c             |  2 +-
 tests/test-bdrv-drain.c   |  8 ++++----
 31 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 28aea2bcfd..1588df02c2 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -180,7 +180,7 @@ struct BlockDriver {
 
     /* aio */
     BlockAIOCB *(*bdrv_aio_preadv)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags,
         BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_pwritev)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
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
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov, int flags);
diff --git a/block/backup-top.c b/block/backup-top.c
index 3b50c06e2c..49fd8763cc 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -42,7 +42,7 @@ typedef struct BDRVBackupTopState {
 } BDRVBackupTopState;
 
 static coroutine_fn int backup_top_co_preadv(
-        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+        BlockDriverState *bs, int64_t offset, int64_t bytes,
         QEMUIOVector *qiov, int flags)
 {
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index af44aa973f..b61275f229 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -619,7 +619,7 @@ static int rule_check(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
 }
 
 static int coroutine_fn
-blkdebug_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+blkdebug_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                    QEMUIOVector *qiov, int flags)
 {
     int err;
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 04d8b33607..6e5bd09993 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -307,7 +307,7 @@ static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
 }
 
 static int coroutine_fn
-blk_log_writes_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+blk_log_writes_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                          QEMUIOVector *qiov, int flags)
 {
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
diff --git a/block/blkreplay.c b/block/blkreplay.c
index c96ac8f4bc..70bc1158e1 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -73,7 +73,7 @@ static void block_request_create(uint64_t reqid, BlockDriverState *bs,
 }
 
 static int coroutine_fn blkreplay_co_preadv(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     uint64_t reqid = blkreplay_next_id();
     int ret = bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
diff --git a/block/blkverify.c b/block/blkverify.c
index 667e60d832..f456c99814 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -224,7 +224,7 @@ blkverify_co_prwv(BlockDriverState *bs, BlkverifyRequest *r, uint64_t offset,
 }
 
 static int coroutine_fn
-blkverify_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+blkverify_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                     QEMUIOVector *qiov, int flags)
 {
     BlkverifyRequest r;
diff --git a/block/bochs.c b/block/bochs.c
index 32bb83b268..08ae3793e4 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -238,7 +238,7 @@ static int64_t seek_to_sector(BlockDriverState *bs, int64_t sector_num)
 }
 
 static int coroutine_fn
-bochs_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+bochs_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                 QEMUIOVector *qiov, int flags)
 {
     BDRVBochsState *s = bs->opaque;
diff --git a/block/cloop.c b/block/cloop.c
index 4de94876d4..a5db202678 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -245,7 +245,7 @@ static inline int cloop_read_block(BlockDriverState *bs, int block_num)
 }
 
 static int coroutine_fn
-cloop_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+cloop_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                 QEMUIOVector *qiov, int flags)
 {
     BDRVCloopState *s = bs->opaque;
diff --git a/block/commit.c b/block/commit.c
index 8e672799af..951e4f623a 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -211,7 +211,7 @@ static const BlockJobDriver commit_job_driver = {
 };
 
 static int coroutine_fn bdrv_commit_top_preadv(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 242d3ff055..0f6b5398b1 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -74,7 +74,7 @@ static int64_t cor_getlength(BlockDriverState *bs)
 
 
 static int coroutine_fn cor_co_preadv(BlockDriverState *bs,
-                                      uint64_t offset, uint64_t bytes,
+                                      int64_t offset, int64_t bytes,
                                       QEMUIOVector *qiov, int flags)
 {
     return bdrv_co_preadv(bs->file, offset, bytes, qiov,
diff --git a/block/crypto.c b/block/crypto.c
index d577f89659..1117b1fafe 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -335,7 +335,7 @@ static int block_crypto_reopen_prepare(BDRVReopenState *state,
 #define BLOCK_CRYPTO_MAX_IO_SIZE (1024 * 1024)
 
 static coroutine_fn int
-block_crypto_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+block_crypto_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                        QEMUIOVector *qiov, int flags)
 {
     BlockCrypto *crypto = bs->opaque;
diff --git a/block/curl.c b/block/curl.c
index 6e325901dc..305a7a5e95 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -922,7 +922,7 @@ out:
 }
 
 static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     CURLAIOCB acb = {
         .co = qemu_coroutine_self(),
diff --git a/block/dmg.c b/block/dmg.c
index 4a045f2b3e..c378b4f555 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -689,7 +689,7 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
 }
 
 static int coroutine_fn
-dmg_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+dmg_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
               QEMUIOVector *qiov, int flags)
 {
     BDRVDMGState *s = bs->opaque;
diff --git a/block/file-posix.c b/block/file-posix.c
index 7e19bbff5f..87415a0a3c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1941,8 +1941,8 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
     return raw_thread_pool_submit(bs, handle_aiocb_rw, &acb);
 }
 
-static int coroutine_fn raw_co_preadv(BlockDriverState *bs, uint64_t offset,
-                                      uint64_t bytes, QEMUIOVector *qiov,
+static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
+                                      int64_t bytes, QEMUIOVector *qiov,
                                       int flags)
 {
     return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_READ);
diff --git a/block/filter-compress.c b/block/filter-compress.c
index 82c315b298..496bbd9e4b 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -62,7 +62,7 @@ static int64_t compress_getlength(BlockDriverState *bs)
 
 
 static int coroutine_fn compress_co_preadv_part(BlockDriverState *bs,
-                                                uint64_t offset, uint64_t bytes,
+                                                int64_t offset, int64_t bytes,
                                                 QEMUIOVector *qiov,
                                                 size_t qiov_offset,
                                                 int flags)
diff --git a/block/mirror.c b/block/mirror.c
index c26fd9260d..51ff4ffd43 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1365,7 +1365,7 @@ static void coroutine_fn active_write_settle(MirrorOp *op)
 }
 
 static int coroutine_fn bdrv_mirror_top_preadv(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
diff --git a/block/nbd.c b/block/nbd.c
index 2160859f64..d878caa7ad 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1160,8 +1160,8 @@ static int nbd_co_request(BlockDriverState *bs, NBDRequest *request,
     return ret ? ret : request_ret;
 }
 
-static int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
-                                uint64_t bytes, QEMUIOVector *qiov, int flags)
+static int nbd_client_co_preadv(BlockDriverState *bs, int64_t offset,
+                                int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     int ret, request_ret;
     Error *local_err = NULL;
diff --git a/block/nfs.c b/block/nfs.c
index cc2413d5ab..7bcb068715 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -263,8 +263,8 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
                                      nfs_co_generic_bh_cb, task);
 }
 
-static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offset,
-                                      uint64_t bytes, QEMUIOVector *iov,
+static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
+                                      int64_t bytes, QEMUIOVector *iov,
                                       int flags)
 {
     NFSClient *client = bs->opaque;
diff --git a/block/null.c b/block/null.c
index 15e1d56746..483e1eebb2 100644
--- a/block/null.c
+++ b/block/null.c
@@ -116,7 +116,7 @@ static coroutine_fn int null_co_common(BlockDriverState *bs)
 }
 
 static coroutine_fn int null_co_preadv(BlockDriverState *bs,
-                                       uint64_t offset, uint64_t bytes,
+                                       int64_t offset, int64_t bytes,
                                        QEMUIOVector *qiov, int flags)
 {
     BDRVNullState *s = bs->opaque;
@@ -187,7 +187,7 @@ static inline BlockAIOCB *null_aio_common(BlockDriverState *bs,
 }
 
 static BlockAIOCB *null_aio_preadv(BlockDriverState *bs,
-                                   uint64_t offset, uint64_t bytes,
+                                   int64_t offset, int64_t bytes,
                                    QEMUIOVector *qiov, int flags,
                                    BlockCompletionFunc *cb,
                                    void *opaque)
diff --git a/block/nvme.c b/block/nvme.c
index 7b7c0cc5d6..254943672a 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1062,7 +1062,7 @@ static int nvme_co_prw(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
 }
 
 static coroutine_fn int nvme_co_preadv(BlockDriverState *bs,
-                                       uint64_t offset, uint64_t bytes,
+                                       int64_t offset, int64_t bytes,
                                        QEMUIOVector *qiov, int flags)
 {
     return nvme_co_prw(bs, offset, bytes, qiov, false, flags);
diff --git a/block/qcow.c b/block/qcow.c
index 8973e4e565..b3376465f4 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -628,8 +628,8 @@ static void qcow_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.request_alignment = BDRV_SECTOR_SIZE;
 }
 
-static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, uint64_t offset,
-                                       uint64_t bytes, QEMUIOVector *qiov,
+static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, int64_t offset,
+                                       int64_t bytes, QEMUIOVector *qiov,
                                        int flags)
 {
     BDRVQcowState *s = bs->opaque;
diff --git a/block/qcow2.c b/block/qcow2.c
index b524b0c53f..45ed81304a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2202,7 +2202,7 @@ static coroutine_fn int qcow2_co_preadv_task_entry(AioTask *task)
 }
 
 static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
-                                             uint64_t offset, uint64_t bytes,
+                                             int64_t offset, int64_t bytes,
                                              QEMUIOVector *qiov,
                                              size_t qiov_offset, int flags)
 {
diff --git a/block/quorum.c b/block/quorum.c
index 6d7a56bd93..b51d6bdc41 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -660,8 +660,8 @@ static int read_fifo_child(QuorumAIOCB *acb)
     return ret;
 }
 
-static int quorum_co_preadv(BlockDriverState *bs, uint64_t offset,
-                            uint64_t bytes, QEMUIOVector *qiov, int flags)
+static int quorum_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                            QEMUIOVector *qiov, int flags)
 {
     BDRVQuorumState *s = bs->opaque;
     QuorumAIOCB *acb = quorum_aio_get(bs, qiov, offset, bytes, flags);
diff --git a/block/raw-format.c b/block/raw-format.c
index 93b25e1b6b..edce5f66c5 100644
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
 
@@ -191,8 +191,8 @@ static inline int raw_adjust_offset(BlockDriverState *bs, uint64_t *offset,
     return 0;
 }
 
-static int coroutine_fn raw_co_preadv(BlockDriverState *bs, uint64_t offset,
-                                      uint64_t bytes, QEMUIOVector *qiov,
+static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
+                                      int64_t bytes, QEMUIOVector *qiov,
                                       int flags)
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
index e637639a07..bc96e69fe9 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1034,7 +1034,7 @@ failed:
 }
 
 static BlockAIOCB *qemu_rbd_aio_preadv(BlockDriverState *bs,
-                                       uint64_t offset, uint64_t bytes,
+                                       int64_t offset, int64_t bytes,
                                        QEMUIOVector *qiov, int flags,
                                        BlockCompletionFunc *cb,
                                        void *opaque)
diff --git a/block/throttle.c b/block/throttle.c
index 71f4bb0ad1..81ff98ac30 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -114,7 +114,7 @@ static int64_t throttle_getlength(BlockDriverState *bs)
 }
 
 static int coroutine_fn throttle_co_preadv(BlockDriverState *bs,
-                                           uint64_t offset, uint64_t bytes,
+                                           int64_t offset, int64_t bytes,
                                            QEMUIOVector *qiov, int flags)
 {
 
diff --git a/block/vdi.c b/block/vdi.c
index e1a11f2aa0..0b395dc3cc 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -547,7 +547,7 @@ static int coroutine_fn vdi_co_block_status(BlockDriverState *bs,
 }
 
 static int coroutine_fn
-vdi_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vdi_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
               QEMUIOVector *qiov, int flags)
 {
     BDRVVdiState *s = bs->opaque;
diff --git a/block/vmdk.c b/block/vmdk.c
index 218d9c9800..acad4118e4 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1868,7 +1868,7 @@ static int vmdk_read_extent(VmdkExtent *extent, int64_t cluster_offset,
 }
 
 static int coroutine_fn
-vmdk_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vmdk_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                QEMUIOVector *qiov, int flags)
 {
     BDRVVmdkState *s = bs->opaque;
diff --git a/block/vpc.c b/block/vpc.c
index d8141b52da..cc9c9b2297 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -611,7 +611,7 @@ static int vpc_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 }
 
 static int coroutine_fn
-vpc_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vpc_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
               QEMUIOVector *qiov, int flags)
 {
     BDRVVPCState *s = bs->opaque;
diff --git a/block/vvfat.c b/block/vvfat.c
index ab800c4887..b177ee7672 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1538,7 +1538,7 @@ static int vvfat_read(BlockDriverState *bs, int64_t sector_num,
 }
 
 static int coroutine_fn
-vvfat_co_preadv(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vvfat_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                 QEMUIOVector *qiov, int flags)
 {
     int ret;
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index fa0e6a648b..c03b021777 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -65,7 +65,7 @@ static void co_reenter_bh(void *opaque)
 }
 
 static int coroutine_fn bdrv_test_co_preadv(BlockDriverState *bs,
-                                            uint64_t offset, uint64_t bytes,
+                                            int64_t offset, int64_t bytes,
                                             QEMUIOVector *qiov, int flags)
 {
     BDRVTestState *s = bs->opaque;
@@ -1120,7 +1120,7 @@ static void bdrv_test_top_close(BlockDriverState *bs)
 }
 
 static int coroutine_fn bdrv_test_top_co_preadv(BlockDriverState *bs,
-                                                uint64_t offset, uint64_t bytes,
+                                                int64_t offset, int64_t bytes,
                                                 QEMUIOVector *qiov, int flags)
 {
     BDRVTestTopState *tts = bs->opaque;
@@ -1862,8 +1862,8 @@ static void bdrv_replace_test_close(BlockDriverState *bs)
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
-- 
2.21.0


