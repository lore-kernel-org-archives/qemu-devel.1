Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AE2C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDEB220656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="eJXHiNW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEB220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzHj-0004ip-UB
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3y-0003Rb-LO
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3s-00009e-LE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:26 -0400
Received: from mail-eopbgr130137.outbound.protection.outlook.com
 ([40.107.13.137]:50950 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3n-0007sD-3J; Mon, 27 Apr 2020 04:24:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFkJpT8ib+PXcDb80b8FAPa4Rlw/4FFA1xxB3vM2/CdOT1RfqQVg7Tc5LrfRq7XycP+ouz/GIms+eRFrcCVjND1si54kP8om8LmrQePFzuPynDC2+Kh2GPQpCNCovlVoZ6oqGAgRgGTpDPlD5+hQfzcem1jEurMMPRs6rTWuwHuKYHtFFqAp5X2qMop+2OsvREeoalBcwDxRXOBINp2S4VmdAl+AqYzCqppY7q1gzk98RO5q7OYq9bIjQqddPAUrTf42XZaiOcf1QJXDF9SXZDT4FDFHmomg/d4Ua1Tt6BOjXYbaxZxoTi5j/ti8s8/I+QrOTxIFdi5cP9c3jfewmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKJybAKx5fGg1Vrj9MKOjYm63lm8uHJBypGDTLWOa38=;
 b=L1STYVvlbYeOUi76Jv+NOh0cDpJL+6nUSX+a4gyVjeewG4BSJpdspZ8ZAfViAEopaPFvbm/59b4xVHljwBEZSv2r3CkqMDsFBRd1yAy5NjX9LRoii4axrAamfPr3EkuwAhN3Z2gsQWr5inVSWzkMyKj60vjfqA/aPS6hycaNpZSffB0QpkRvPxqEqNgP82tG9X5jXDsh+/SOSIEveCx7qRp0r5W1qPD5jGKiLIdXZ487rAU12Ameo0TgsxwtAv9on6LVt5lCDHNhQb3gBP824/xwjrrfvPnQhXz0xejVUdedCkx+W11llPcAzNFVSg3ntYv8BSWNPUpBbT3h5WiHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKJybAKx5fGg1Vrj9MKOjYm63lm8uHJBypGDTLWOa38=;
 b=eJXHiNW27p3sOEdlMveGQK4IaMjDxTJVuNT8arFDG04EXPRewJdxQ1Hk8WIn7ujVwydYLcCyzH0fZIBxXVUc8awHLCcevwyAeFK9kO6RzMucV0fo8PfH2icTSZUedG1qgHjBnUji9y7gPEmlZkoAcg3zelmXRk/j+kRsIRQLOI0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 08:24:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:24:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 14/17] block: use int64_t instead of uint64_t in driver
 write handlers
Date: Mon, 27 Apr 2020 11:23:22 +0300
Message-Id: <20200427082325.10414-15-vsementsov@virtuozzo.com>
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
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:24:09 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb085316-d9cd-4f47-cacb-08d7ea845cd2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB549529161984DBD85A9476C3C1AF0@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:75;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(136003)(376002)(366004)(39840400004)(1076003)(6666004)(66556008)(66476007)(2616005)(16526019)(6506007)(956004)(66946007)(26005)(2906002)(52116002)(5660300002)(186003)(30864003)(6512007)(7416002)(107886003)(86362001)(36756003)(316002)(4326008)(6916009)(6486002)(69590400007)(8676002)(81156014)(8936002)(478600001)(21314003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTizcy6F2LFxukXFQDTtDcwA7mYN6Xh3zL1FUPfBQ+a4CxlrAb4iCKVj6sCfyTpMOXybZ7t+oqkJYfw6oIM8pITOQQK2nCAY38p2Gr5mS3M0vDmAFanG0hG89+j7qOBZZLIgSenZ9LoYv3j7UIXXdi2faqWu/suOTmtWdIYE0PBS6F/DVBv0tNhm/J7ikaygZnbWICFKWvjAedpUIjLNre7Yz7rA9cUYdAqMVyySfbS9hjwqaqb/GgBZp8IiV5rBDmNaQE7W55VEtrgLmMUrBXBx0YbeHMNpDaNxpc18VYN7wPperRnQ33Nzs2BalNqEE/zUlrzSn7GXhWbq8BWaVUCTUxws0Kch01Z5tZggL3IG/JY58QvNe8wFbIUbDj4mxqvZukeTXHcTQBPeUHy1eyBHYkDVibOpD1yGguPLVs+9eto7xB8VVv09CkSFjAtr+2M6NNkHwv5TGKS5J3zCC2WFan8G+2ymuit+NiZNl0i5WYh8mH9PqFjp3F7dQrtFpJqlWPXAPDGOYruAPGvj5A==
X-MS-Exchange-AntiSpam-MessageData: cIDUeArlOAjj7swvGr/pSATY9RChWPwyd4H2BrlrbB+P1VoaL237GLdaocf0YUau+dFUNS8u2qXoAv0dt0RwgYgG/2ImBtTlSMRLeU+/y6+K3TNucHNZ0WJ3l0IKLur+OQnsHmpp4It8mGzFRxbr3qrEwA4lhr+vsjgpTE6GxSShjGt/oopX4zVHgC030FJVDYJwemNXyRs4+MBO03ea7uS86DZhM3dj86xxqTbzPUboI9SASa/Kdxc0MgLp/PaGCeJhJzOafM/jXEbapF92uTrt4IQpI+P9zZsu9zSw6SFGa9BnRTu0isPSRdYQ8suapjkfmDkuLNGZ/OpiogszKZe2IFuSRoHzNUZUMXatTrj1/2PDH18KtQfBUHu7EfyluOPT66liA+joBWMV69cR91WUKztKq51yoj3SEoVFL8CkEYjAYGvQDt0w2MgTd2g8JA4iZUdKA98GUGXsRYJYrDj24gwTM9OcU7AAodO5JRAS73eEU9/aVl4Lt472UrQrQfZ61nxrSO5q8ZDjoxxNNUyZ6q25043W2I3D7XB46mGdAitjo/U6CQtyay+snLWqz77lIwCaZx/KeSOvVkpnibDN0x7+uSzFVYkAQfMNZt3sNG3Co2iU2rEktPPhOAq6UfgU7WdlWkqZlKGalvseoZI9AGpN0994Pjd83JhKvBz3fRZUGln+NePXN6MQg3+ocriuHHpHpe3kLIYQRtRIr11imxjbSgBZB0QoxVcDf/NpUJyBi5ZGP/TbUiRFsLHElkljJR+Kdf2z/ul8ndnLQlS5WO908ssX1yYr8z5v1YA=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb085316-d9cd-4f47-cacb-08d7ea845cd2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:24:11.2365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lph/w/5VlZGDNv5/Tyzo8zMZBDn7a8ZucHGgKifun0FQlLbVYPVgoWQgXp7I2Nfp4bnQ++7sA3jzRXP+dkC68az/gBlPLjRBhXWL3ABm/VQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.13.137;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:24:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.13.137
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
on all io paths. Convert driver write handlers parameters which are
already 64bit to signed type.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h | 10 +++++-----
 block/backup-top.c        |  3 +--
 block/blkdebug.c          |  2 +-
 block/blklogwrites.c      |  2 +-
 block/blkreplay.c         |  2 +-
 block/blkverify.c         |  2 +-
 block/copy-on-read.c      |  2 +-
 block/crypto.c            |  2 +-
 block/file-posix.c        |  4 ++--
 block/filter-compress.c   |  4 ++--
 block/mirror.c            |  2 +-
 block/nbd.c               |  4 ++--
 block/nfs.c               |  4 ++--
 block/null.c              |  4 ++--
 block/nvme.c              |  2 +-
 block/qcow.c              |  8 ++++----
 block/qcow2.c             |  4 ++--
 block/quorum.c            |  4 ++--
 block/raw-format.c        |  8 ++++----
 block/rbd.c               |  2 +-
 block/throttle.c          |  2 +-
 block/vdi.c               |  2 +-
 block/vmdk.c              |  6 +++---
 block/vpc.c               |  2 +-
 block/vvfat.c             |  4 ++--
 block/trace-events        |  2 +-
 26 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1588df02c2..0da54cdf48 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -183,7 +183,7 @@ struct BlockDriver {
         int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags,
         BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_pwritev)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags,
         BlockCompletionFunc *cb, void *opaque);
     BlockAIOCB *(*bdrv_aio_flush)(BlockDriverState *bs,
         BlockCompletionFunc *cb, void *opaque);
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
 
     /*
@@ -364,9 +364,9 @@ struct BlockDriver {
                                       Error **errp);
 
     int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov);
     int coroutine_fn (*bdrv_co_pwritev_compressed_part)(BlockDriverState *bs,
-        uint64_t offset, uint64_t bytes, QEMUIOVector *qiov,
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov,
         size_t qiov_offset);
 
     int (*bdrv_snapshot_create)(BlockDriverState *bs,
diff --git a/block/backup-top.c b/block/backup-top.c
index 49fd8763cc..4190d465d6 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -87,8 +87,7 @@ static int coroutine_fn backup_top_co_pwrite_zeroes(BlockDriverState *bs,
 }
 
 static coroutine_fn int backup_top_co_pwritev(BlockDriverState *bs,
-                                              uint64_t offset,
-                                              uint64_t bytes,
+                                              int64_t offset, int64_t bytes,
                                               QEMUIOVector *qiov, int flags)
 {
     int ret = backup_top_cbw(bs, offset, bytes, flags);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index b61275f229..b4d0966982 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -640,7 +640,7 @@ blkdebug_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
 }
 
 static int coroutine_fn
-blkdebug_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+blkdebug_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                     QEMUIOVector *qiov, int flags)
 {
     int err;
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 6e5bd09993..890a61dfba 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -466,7 +466,7 @@ blk_log_writes_co_do_file_pdiscard(BlkLogWritesFileReq *fr)
 }
 
 static int coroutine_fn
-blk_log_writes_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+blk_log_writes_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                           QEMUIOVector *qiov, int flags)
 {
     return blk_log_writes_co_log(bs, offset, bytes, qiov, flags,
diff --git a/block/blkreplay.c b/block/blkreplay.c
index 70bc1158e1..d93383a88f 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -84,7 +84,7 @@ static int coroutine_fn blkreplay_co_preadv(BlockDriverState *bs,
 }
 
 static int coroutine_fn blkreplay_co_pwritev(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     uint64_t reqid = blkreplay_next_id();
     int ret = bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
diff --git a/block/blkverify.c b/block/blkverify.c
index f456c99814..a3c447fc68 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -253,7 +253,7 @@ blkverify_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
 }
 
 static int coroutine_fn
-blkverify_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+blkverify_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                      QEMUIOVector *qiov, int flags)
 {
     BlkverifyRequest r;
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 0f6b5398b1..fc3186bacb 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -83,7 +83,7 @@ static int coroutine_fn cor_co_preadv(BlockDriverState *bs,
 
 
 static int coroutine_fn cor_co_pwritev(BlockDriverState *bs,
-                                       uint64_t offset, uint64_t bytes,
+                                       int64_t offset, int64_t bytes,
                                        QEMUIOVector *qiov, int flags)
 {
 
diff --git a/block/crypto.c b/block/crypto.c
index 1117b1fafe..ecb5697a4b 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -398,7 +398,7 @@ block_crypto_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
 
 
 static coroutine_fn int
-block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+block_crypto_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                         QEMUIOVector *qiov, int flags)
 {
     BlockCrypto *crypto = bs->opaque;
diff --git a/block/file-posix.c b/block/file-posix.c
index 87415a0a3c..688f2fa54c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1948,8 +1948,8 @@ static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
     return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_READ);
 }
 
-static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                                       uint64_t bytes, QEMUIOVector *qiov,
+static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t offset,
+                                       int64_t bytes, QEMUIOVector *qiov,
                                        int flags)
 {
     assert(flags == 0);
diff --git a/block/filter-compress.c b/block/filter-compress.c
index 496bbd9e4b..f2400fea37 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -73,8 +73,8 @@ static int coroutine_fn compress_co_preadv_part(BlockDriverState *bs,
 
 
 static int coroutine_fn compress_co_pwritev_part(BlockDriverState *bs,
-                                                 uint64_t offset,
-                                                 uint64_t bytes,
+                                                 int64_t offset,
+                                                 int64_t bytes,
                                                  QEMUIOVector *qiov,
                                                  size_t qiov_offset, int flags)
 {
diff --git a/block/mirror.c b/block/mirror.c
index 51ff4ffd43..687a91e654 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1419,7 +1419,7 @@ out:
 }
 
 static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
-    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     MirrorBDSOpaque *s = bs->opaque;
     QEMUIOVector bounce_qiov;
diff --git a/block/nbd.c b/block/nbd.c
index d878caa7ad..54bce3911e 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1218,8 +1218,8 @@ static int nbd_client_co_preadv(BlockDriverState *bs, int64_t offset,
     return ret ? ret : request_ret;
 }
 
-static int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                                 uint64_t bytes, QEMUIOVector *qiov, int flags)
+static int nbd_client_co_pwritev(BlockDriverState *bs, int64_t offset,
+                                 int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = {
diff --git a/block/nfs.c b/block/nfs.c
index 7bcb068715..d59d8e7d32 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -298,8 +298,8 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
-static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                                       uint64_t bytes, QEMUIOVector *iov,
+static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, int64_t offset,
+                                       int64_t bytes, QEMUIOVector *iov,
                                        int flags)
 {
     NFSClient *client = bs->opaque;
diff --git a/block/null.c b/block/null.c
index 483e1eebb2..cac37e7ba6 100644
--- a/block/null.c
+++ b/block/null.c
@@ -129,7 +129,7 @@ static coroutine_fn int null_co_preadv(BlockDriverState *bs,
 }
 
 static coroutine_fn int null_co_pwritev(BlockDriverState *bs,
-                                        uint64_t offset, uint64_t bytes,
+                                        int64_t offset, int64_t bytes,
                                         QEMUIOVector *qiov, int flags)
 {
     return null_co_common(bs);
@@ -202,7 +202,7 @@ static BlockAIOCB *null_aio_preadv(BlockDriverState *bs,
 }
 
 static BlockAIOCB *null_aio_pwritev(BlockDriverState *bs,
-                                    uint64_t offset, uint64_t bytes,
+                                    int64_t offset, int64_t bytes,
                                     QEMUIOVector *qiov, int flags,
                                     BlockCompletionFunc *cb,
                                     void *opaque)
diff --git a/block/nvme.c b/block/nvme.c
index 254943672a..db7fffe94f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1069,7 +1069,7 @@ static coroutine_fn int nvme_co_preadv(BlockDriverState *bs,
 }
 
 static coroutine_fn int nvme_co_pwritev(BlockDriverState *bs,
-                                        uint64_t offset, uint64_t bytes,
+                                        int64_t offset, int64_t bytes,
                                         QEMUIOVector *qiov, int flags)
 {
     return nvme_co_prw(bs, offset, bytes, qiov, true, flags);
diff --git a/block/qcow.c b/block/qcow.c
index b3376465f4..9583e8e8b2 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -725,8 +725,8 @@ static coroutine_fn int qcow_co_preadv(BlockDriverState *bs, int64_t offset,
     return ret;
 }
 
-static coroutine_fn int qcow_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                                        uint64_t bytes, QEMUIOVector *qiov,
+static coroutine_fn int qcow_co_pwritev(BlockDriverState *bs, int64_t offset,
+                                        int64_t bytes, QEMUIOVector *qiov,
                                         int flags)
 {
     BDRVQcowState *s = bs->opaque;
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
index 45ed81304a..ed5e456b09 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2475,7 +2475,7 @@ static coroutine_fn int qcow2_co_pwritev_task_entry(AioTask *task)
 }
 
 static coroutine_fn int qcow2_co_pwritev_part(
-        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+        BlockDriverState *bs, int64_t offset, int64_t bytes,
         QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -4328,7 +4328,7 @@ static coroutine_fn int qcow2_co_pwritev_compressed_task_entry(AioTask *task)
  */
 static coroutine_fn int
 qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
-                                 uint64_t offset, uint64_t bytes,
+                                 int64_t offset, int64_t bytes,
                                  QEMUIOVector *qiov, size_t qiov_offset)
 {
     BDRVQcow2State *s = bs->opaque;
diff --git a/block/quorum.c b/block/quorum.c
index b51d6bdc41..4164c3fbf8 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -706,8 +706,8 @@ static void write_quorum_entry(void *opaque)
     }
 }
 
-static int quorum_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                             uint64_t bytes, QEMUIOVector *qiov, int flags)
+static int quorum_co_pwritev(BlockDriverState *bs, int64_t offset,
+                             int64_t bytes, QEMUIOVector *qiov, int flags)
 {
     BDRVQuorumState *s = bs->opaque;
     QuorumAIOCB *acb = quorum_aio_get(bs, qiov, offset, bytes, flags);
diff --git a/block/raw-format.c b/block/raw-format.c
index edce5f66c5..d5ff7012b7 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -206,8 +206,8 @@ static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
 
-static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, uint64_t offset,
-                                       uint64_t bytes, QEMUIOVector *qiov,
+static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t offset,
+                                       int64_t bytes, QEMUIOVector *qiov,
                                        int flags)
 {
     void *buf = NULL;
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
index bc96e69fe9..412df8cdb7 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1044,7 +1044,7 @@ static BlockAIOCB *qemu_rbd_aio_preadv(BlockDriverState *bs,
 }
 
 static BlockAIOCB *qemu_rbd_aio_pwritev(BlockDriverState *bs,
-                                        uint64_t offset, uint64_t bytes,
+                                        int64_t offset, int64_t bytes,
                                         QEMUIOVector *qiov, int flags,
                                         BlockCompletionFunc *cb,
                                         void *opaque)
diff --git a/block/throttle.c b/block/throttle.c
index 81ff98ac30..28e73073e7 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -125,7 +125,7 @@ static int coroutine_fn throttle_co_preadv(BlockDriverState *bs,
 }
 
 static int coroutine_fn throttle_co_pwritev(BlockDriverState *bs,
-                                            uint64_t offset, uint64_t bytes,
+                                            int64_t offset, int64_t bytes,
                                             QEMUIOVector *qiov, int flags)
 {
     ThrottleGroupMember *tgm = bs->opaque;
diff --git a/block/vdi.c b/block/vdi.c
index 0b395dc3cc..07ad195239 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -603,7 +603,7 @@ vdi_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
 }
 
 static int coroutine_fn
-vdi_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vdi_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                QEMUIOVector *qiov, int flags)
 {
     BDRVVdiState *s = bs->opaque;
diff --git a/block/vmdk.c b/block/vmdk.c
index acad4118e4..a88e9c9ba4 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2048,7 +2048,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
 }
 
 static int coroutine_fn
-vmdk_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vmdk_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                 QEMUIOVector *qiov, int flags)
 {
     int ret;
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
index cc9c9b2297..90a402eb41 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -662,7 +662,7 @@ fail:
 }
 
 static int coroutine_fn
-vpc_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vpc_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                QEMUIOVector *qiov, int flags)
 {
     BDRVVPCState *s = bs->opaque;
diff --git a/block/vvfat.c b/block/vvfat.c
index b177ee7672..97e6b0e2a5 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3073,7 +3073,7 @@ DLOG(checkpoint());
 }
 
 static int coroutine_fn
-vvfat_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+vvfat_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                  QEMUIOVector *qiov, int flags)
 {
     int ret;
@@ -3111,7 +3111,7 @@ static int coroutine_fn vvfat_co_block_status(BlockDriverState *bs,
 }
 
 static int coroutine_fn
-write_target_commit(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
+write_target_commit(BlockDriverState *bs, int64_t offset, int64_t bytes,
                     QEMUIOVector *qiov, int flags)
 {
     int ret;
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


