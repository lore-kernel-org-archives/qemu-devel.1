Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E14EC8300D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE20920774
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="gCvbNEDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE20920774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7Hm-0004Ic-46
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78k-0007GM-FD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78N-0005aL-1h
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:02 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com
 ([40.107.7.120]:6058 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU764-0003ZE-88; Thu, 30 Apr 2020 07:11:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7Q5A5JkCRkDww6YW0JJblLADkeDk43Y/vKuK2kZSDc8qdUgwWPYxXBmTAhMgyQSVj9cNq/XDm8JFTeIdzrCYNri+X3d+povovcuhF7D9kSCx2OWmdCYizDV0RqlQH+0T3MRQETcyuFDjxf9sobuGf9Y+yCOlDIf8HZsWp9PahCkk2JhrULY9HxDhrQTpDh7fpB101K0zXSFLzn2HIE4IM7RQAGRLR5WF3K+4b35aZsTWYHPMuzQkCm3NwI4SSoZF7GlZa56Sfea5bgVVDGFgjMG7wi8dCUtGNKz9wLCLlriHHXZ5nY2pmV/8xnOFX/kNzdT7eDAM9mZsioeA3hvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy8c4Wa2wkGpeKoSpZa0yVNK25XvV07VM5xdsjX0SLg=;
 b=DJF/dXFPb0XFkFvsJRQDEzAI3iKp5Rh1D2fGE70YeYbkOY0FekKmXjjWl4S130NsGeTpTZIsJTMym+VgAixtH3Q3lBwBq0223ZfhneT+fbpNdHWQLkRjRWx7UZVm0De+koc1TygiNF2RxTucglOSWxdfEZLJPxkIUFKGuhCpcTyStAbFwYnXsNeJppEvdzxMBIz8px86KQSSu+srtLGtLaW1OXFpobIR4veJSqDKr8BKMDtqWRwgpCuC9369UgJARajhXiBPvpkheRZXYGhq8ZAeGtB0JM7l5YD93/iQ0LkuJKfpNAqGJUPUH3JZ3PFPC8sxO9Hdjwrz/96hjJLI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uy8c4Wa2wkGpeKoSpZa0yVNK25XvV07VM5xdsjX0SLg=;
 b=gCvbNEDdrdT3GyYY/Kj52W6gr8MNafrr/fKjV35defIzSvhJAycu9muBaj/h19ndycMkmW50nDv/cbb2eNKaar5HzCKodUrLFuMEmAcc/nn1g8Ky85x4sv+nbdUEUuiCLCga0qPt+dqfPr2McAt+g71unQtHjUO6fUcNEWYDdOY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 11:11:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:11:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 17/17] block: use int64_t instead of int in driver discard
 handlers
Date: Thu, 30 Apr 2020 14:10:33 +0300
Message-Id: <20200430111033.29980-18-vsementsov@virtuozzo.com>
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
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:11:12 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df2a0719-9a12-4a84-38ee-08d7ecf73205
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53998957A2668D2EC6C48493C1AA0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:302;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8SFnwmKBLt9YzSxNdx3d2u4JA868cOmfH5rAvhdxCqp7BC2iroA99iR8DiCdPRw4QWY+IKbeCic7fjOV/+En/liUL7HWgkJ1z73jSCxLvnSr0mLHbG6xaX9Wjf27ww+sAyi9fioKfn1YAU0StLNV4Ru1CdzdPbFZi96q5e70Fbd/61w7UEyZfE/l5din8GNzllfIs/tSMJ9nKFCXxLMUUTAw0YWQD9/fcZxMhEMuuZ8Ucy/p3TG3ZERt6ofIAcawNNjXl+ADrrxiilm6XFfOCcrCzU6ImMPoDknBrRhzlPdFd5SG17q+MdpfpEbaOo0txrV5ry/J1wbMfBThnmCLg5sDNLW/JO5+Q2CiXFK5cuZxO9hCdvfIx1ss7e1wlARr97vtW7gxZt9rgTwIPYEVYJP7HwtQuMNJbtyoSzxKeHps4iBq82hof98zsuC5B6x3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(366004)(346002)(136003)(376002)(1076003)(36756003)(478600001)(8936002)(26005)(6512007)(30864003)(7416002)(5660300002)(107886003)(6486002)(66476007)(66556008)(86362001)(6916009)(6506007)(6666004)(8676002)(316002)(2906002)(186003)(66946007)(16526019)(2616005)(956004)(4326008)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 9VevqVdFbu91v5Ab/onrf3UPpTtuxP8i0wNUuwVgaVCjtlZAH0WCnubsEqtg85PUyF+N06X0f0bUIPk4p7iNLsC/i702bNnsu6TEfO87H6q3LQq1l1JMeczwLQeztQ4v1lEtR16iVlTmE+gILaLSYrjQgbIxagle9d9gRHWCPEFCXHNua384t5TDmWySLTao9Z28IRVbacrO9YLnKVV1M5MDCRcOVBZM6T/MAords2A107KLdx3psCEwupv47B7dHF5YaT1UnB/RJacz8mosRUGPBqmV5Mc4KPyMYUnB36TPQGBRrILdo3gl8ud7gcVBJzyKuC3DbpEVP6xxQ3QHd2Xjo7bLoe93ZQu3E2T6t32rhwl0/iBwTFBNrWX0Kt8cCiIthotr+GTHqP1+oGd2Pd8IxsFa3F5D6ONSM0pDPFuyxmTGWAwm9+nMLGziwbnm2NtQnjGPSAH61lgHnoBsIVToSo3QjsU4enDzZuErXSvqwstzHuBS0ZkBnUwefCQpTjliunXBP+QrwrwC/fL2wmF3D0opfZ3gx0I7/M41M0TmLFW5f85KnZdVclQXhzJktZ/9OH1EbYYbXIaKR0PF+DZqdh2SxZD5I4hEjYWHaM4pPUiBkBT75BZulGEzw40SoYJDcvo6+64AvI2mnqy/wTXhhRvzBJKtI59oXyENQryspZxz0NC7mXloUtlAdwxN6MihbZuq43rlBZ84uLIfJqfnwIqElPFlkOqhm4UgLdlNghmHi/T2rfdX7TUXiVqT/JGikZWJdjzFYTbxjEQ+xtgcUJVSwqyhdz3QLyAy18w=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df2a0719-9a12-4a84-38ee-08d7ecf73205
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:11:13.8366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94REndJPVjeFE76xBbr/ozfwT5f26SwCvt57nxpSfSbBomOW4j0wd1NkDLcP6pserOewCsc/gv4ypsOHPcaXnLU4fg8PhDOCRy1ORiKJxn0=
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

So, convert driver discard handlers bytes parameter to int64_t.

This patch just converts handlers where it is obvious that bytes
parameter is passed further to 64bit interfaces, and add simple
wrappers where it is not obvious.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  2 +-
 block/backup-top.c        |  2 +-
 block/blkdebug.c          |  2 +-
 block/blklogwrites.c      |  4 ++--
 block/blkreplay.c         |  2 +-
 block/copy-on-read.c      |  2 +-
 block/file-posix.c        | 18 ++++++++++++++++--
 block/filter-compress.c   |  2 +-
 block/gluster.c           |  6 ++++--
 block/iscsi.c             | 10 +++++++++-
 block/mirror.c            |  2 +-
 block/nbd.c               |  4 +++-
 block/nvme.c              | 13 ++++++++++---
 block/qcow2.c             |  2 +-
 block/raw-format.c        |  2 +-
 block/sheepdog.c          | 11 +++++++++--
 block/throttle.c          |  2 +-
 17 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index c98d591a56..ff8860fee8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -248,7 +248,7 @@ struct BlockDriver {
     int coroutine_fn (*bdrv_co_pwrite_zeroes)(BlockDriverState *bs,
         int64_t offset, int64_t bytes, BdrvRequestFlags flags);
     int coroutine_fn (*bdrv_co_pdiscard)(BlockDriverState *bs,
-        int64_t offset, int bytes);
+        int64_t offset, int64_t bytes);
 
     /* Map [offset, offset + nbytes) range onto a child of @bs to copy from,
      * and invoke bdrv_co_copy_range_from(child, ...), or invoke
diff --git a/block/backup-top.c b/block/backup-top.c
index 2484293fb0..8c02fa3a58 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -65,7 +65,7 @@ static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t offset,
 }
 
 static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
-                                               int64_t offset, int bytes)
+                                               int64_t offset, int64_t bytes)
 {
     int ret = backup_top_cbw(bs, offset, bytes, 0);
     if (ret < 0) {
diff --git a/block/blkdebug.c b/block/blkdebug.c
index d593d6c85d..e1d91cf707 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -705,7 +705,7 @@ static int coroutine_fn blkdebug_co_pwrite_zeroes(BlockDriverState *bs,
 }
 
 static int coroutine_fn blkdebug_co_pdiscard(BlockDriverState *bs,
-                                             int64_t offset, int bytes)
+                                             int64_t offset, int64_t bytes)
 {
     uint32_t align = bs->bl.pdiscard_alignment;
     int err;
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 8ca41d09cd..f488864106 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -490,9 +490,9 @@ static int coroutine_fn blk_log_writes_co_flush_to_disk(BlockDriverState *bs)
 }
 
 static int coroutine_fn
-blk_log_writes_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
+blk_log_writes_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
-    return blk_log_writes_co_log(bs, offset, count, NULL, 0,
+    return blk_log_writes_co_log(bs, offset, bytes, NULL, 0,
                                  blk_log_writes_co_do_file_pdiscard,
                                  LOG_DISCARD_FLAG, false);
 }
diff --git a/block/blkreplay.c b/block/blkreplay.c
index 186d28cc6a..34a12ad5ac 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -106,7 +106,7 @@ static int coroutine_fn blkreplay_co_pwrite_zeroes(BlockDriverState *bs,
 }
 
 static int coroutine_fn blkreplay_co_pdiscard(BlockDriverState *bs,
-                                              int64_t offset, int bytes)
+                                              int64_t offset, int64_t bytes)
 {
     uint64_t reqid = blkreplay_next_id();
     int ret = bdrv_co_pdiscard(bs->file, offset, bytes);
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index d99e07e99f..5bf1fabee6 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -102,7 +102,7 @@ static int coroutine_fn cor_co_pwrite_zeroes(BlockDriverState *bs,
 
 
 static int coroutine_fn cor_co_pdiscard(BlockDriverState *bs,
-                                        int64_t offset, int bytes)
+                                        int64_t offset, int64_t bytes)
 {
     return bdrv_co_pdiscard(bs->file, offset, bytes);
 }
diff --git a/block/file-posix.c b/block/file-posix.c
index fa9ac5b13e..132001dba8 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2791,11 +2791,18 @@ raw_do_pdiscard(BlockDriverState *bs, int64_t offset, int bytes, bool blkdev)
 }
 
 static coroutine_fn int
-raw_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
+raw_co_pdiscard_old(BlockDriverState *bs, int64_t offset, int bytes)
 {
     return raw_do_pdiscard(bs, offset, bytes, false);
 }
 
+static coroutine_fn int
+raw_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
+{
+    assert(bytes <= INT_MAX);
+    return raw_co_pdiscard_old(bs, offset, bytes);
+}
+
 static int coroutine_fn
 raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
                      BdrvRequestFlags flags, bool blkdev)
@@ -3475,7 +3482,7 @@ static int fd_open(BlockDriverState *bs)
 }
 
 static coroutine_fn int
-hdev_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
+hdev_co_pdiscard_old(BlockDriverState *bs, int64_t offset, int bytes)
 {
     BDRVRawState *s = bs->opaque;
     int ret;
@@ -3488,6 +3495,13 @@ hdev_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
     return raw_do_pdiscard(bs, offset, bytes, true);
 }
 
+static coroutine_fn int
+hdev_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
+{
+    assert(bytes <= INT_MAX);
+    return hdev_co_pdiscard_old(bs, offset, bytes);
+}
+
 static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int64_t bytes, BdrvRequestFlags flags)
 {
diff --git a/block/filter-compress.c b/block/filter-compress.c
index 7cf47608b5..477dfaf959 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -93,7 +93,7 @@ static int coroutine_fn compress_co_pwrite_zeroes(BlockDriverState *bs,
 
 
 static int coroutine_fn compress_co_pdiscard(BlockDriverState *bs,
-                                             int64_t offset, int bytes)
+                                             int64_t offset, int64_t bytes)
 {
     return bdrv_co_pdiscard(bs->file, offset, bytes);
 }
diff --git a/block/gluster.c b/block/gluster.c
index 88130c3d2d..87cf69199d 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1312,18 +1312,20 @@ error:
 
 #ifdef CONFIG_GLUSTERFS_DISCARD
 static coroutine_fn int qemu_gluster_co_pdiscard(BlockDriverState *bs,
-                                                 int64_t offset, int size)
+                                                 int64_t offset, int64_t bytes)
 {
     int ret;
     GlusterAIOCB acb;
     BDRVGlusterState *s = bs->opaque;
 
+    assert(bytes <= INT_MAX);
+
     acb.size = 0;
     acb.ret = 0;
     acb.coroutine = qemu_coroutine_self();
     acb.aio_context = bdrv_get_aio_context(bs);
 
-    ret = glfs_discard_async(s->fd, offset, size, gluster_finish_aiocb, &acb);
+    ret = glfs_discard_async(s->fd, offset, bytes, gluster_finish_aiocb, &acb);
     if (ret < 0) {
         return -errno;
     }
diff --git a/block/iscsi.c b/block/iscsi.c
index c4183ef12f..c06521b74f 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1141,7 +1141,8 @@ iscsi_getlength(BlockDriverState *bs)
 }
 
 static int
-coroutine_fn iscsi_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
+coroutine_fn iscsi_co_pdiscard_old(BlockDriverState *bs, int64_t offset,
+                                   int bytes)
 {
     IscsiLun *iscsilun = bs->opaque;
     struct IscsiTask iTask;
@@ -1203,6 +1204,13 @@ out_unlock:
     return r;
 }
 
+static int
+coroutine_fn iscsi_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
+{
+    assert(bytes <= INT_MAX);
+    return iscsi_co_pdiscard_old(bs, offset, bytes);
+}
+
 static int
 coroutine_fn iscsi_co_pwrite_zeroes_old(BlockDriverState *bs, int64_t offset,
                                         int bytes, BdrvRequestFlags flags)
diff --git a/block/mirror.c b/block/mirror.c
index 7f4fdfb470..bd01c032fa 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1471,7 +1471,7 @@ static int coroutine_fn bdrv_mirror_top_pwrite_zeroes(BlockDriverState *bs,
 }
 
 static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
-    int64_t offset, int bytes)
+    int64_t offset, int64_t bytes)
 {
     return bdrv_mirror_top_do_write(bs, MIRROR_METHOD_DISCARD, offset, bytes,
                                     NULL, 0);
diff --git a/block/nbd.c b/block/nbd.c
index 0e52b76d72..93d0ced28c 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1295,7 +1295,7 @@ static int nbd_client_co_flush(BlockDriverState *bs)
 }
 
 static int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset,
-                                  int bytes)
+                                  int64_t bytes)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = {
@@ -1304,6 +1304,8 @@ static int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset,
         .len = bytes,
     };
 
+    assert(bytes < INT_MAX);
+
     assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
     if (!(s->info.flags & NBD_FLAG_SEND_TRIM) || !bytes) {
         return 0;
diff --git a/block/nvme.c b/block/nvme.c
index 724f894b00..adc19ee9e6 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1166,9 +1166,9 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     return nvme_co_pwrite_zeroes_old(bs, offset, bytes, flags);
 }
 
-static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
-                                         int64_t offset,
-                                         int bytes)
+static int coroutine_fn nvme_co_pdiscard_old(BlockDriverState *bs,
+                                             int64_t offset,
+                                             int bytes)
 {
     BDRVNVMeState *s = bs->opaque;
     NVMeQueuePair *ioq = s->queues[1];
@@ -1245,6 +1245,13 @@ out:
 
 }
 
+static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
+                                         int64_t offset,
+                                         int64_t bytes)
+{
+    assert(bytes <= INT_MAX);
+    return nvme_co_pdiscard_old(bs, offset, bytes);
+}
 
 static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
                                BlockReopenQueue *queue, Error **errp)
diff --git a/block/qcow2.c b/block/qcow2.c
index 0800d0378a..c85f5a8331 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3787,7 +3787,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
 }
 
 static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
-                                          int64_t offset, int bytes)
+                                          int64_t offset, int64_t bytes)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
diff --git a/block/raw-format.c b/block/raw-format.c
index 0996741056..f31bc4338f 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -292,7 +292,7 @@ static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
 }
 
 static int coroutine_fn raw_co_pdiscard(BlockDriverState *bs,
-                                        int64_t offset, int bytes)
+                                        int64_t offset, int64_t bytes)
 {
     int ret;
 
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 59f7ebb171..750bfae016 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -3091,8 +3091,8 @@ static int sd_load_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
 }
 
 
-static coroutine_fn int sd_co_pdiscard(BlockDriverState *bs, int64_t offset,
-                                      int bytes)
+static coroutine_fn int sd_co_pdiscard_old(BlockDriverState *bs, int64_t offset,
+                                           int bytes)
 {
     SheepdogAIOCB acb;
     BDRVSheepdogState *s = bs->opaque;
@@ -3121,6 +3121,13 @@ static coroutine_fn int sd_co_pdiscard(BlockDriverState *bs, int64_t offset,
     return acb.ret;
 }
 
+static coroutine_fn int sd_co_pdiscard(BlockDriverState *bs, int64_t offset,
+                                       int64_t bytes)
+{
+    assert(bytes <= INT_MAX);
+    return sd_co_pdiscard_old(bs, offset, bytes);
+}
+
 static coroutine_fn int
 sd_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
                    int64_t bytes, int64_t *pnum, int64_t *map,
diff --git a/block/throttle.c b/block/throttle.c
index c97da1d6a7..61f6c291e7 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -147,7 +147,7 @@ static int coroutine_fn throttle_co_pwrite_zeroes(BlockDriverState *bs,
 }
 
 static int coroutine_fn throttle_co_pdiscard(BlockDriverState *bs,
-                                             int64_t offset, int bytes)
+                                             int64_t offset, int64_t bytes)
 {
     ThrottleGroupMember *tgm = bs->opaque;
     throttle_group_co_io_limits_intercept(tgm, bytes, true);
-- 
2.21.0


