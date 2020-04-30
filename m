Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA316C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55EDB20774
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hMrs/UrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EDB20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7KA-0000EI-Gb
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78j-0007FP-Bl
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78M-0005Vy-0d
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:01 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com
 ([40.107.7.120]:6058 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU762-0003ZE-UI; Thu, 30 Apr 2020 07:11:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P53jVKWzBw0UfO1DlkoqPcjCmliQ8tUBKsHuAOCeEt30Q3LIiN1k9tzUXInk+y+upfCHK2r2XvorxAED50AVhNXfiX2CiwabsU5VqICVZjnoiZFJngpPggxW1Cvnrg5G4WL+ud569A2kY1f9bI3/8+x8QxYBLZND01dsbP8C9q8hkW6WPDlWZL84UXJRJCNlWu4HTHPPVqUa4f5DHmnEgupNEYlxhz06L0hRiKvOiH2tDWNY3oG8/i1daIG3rlGhJBg/eEtk5HnDWAWD2OiUsyP8A/pxnMW6ogI24OJ8PiqKT86OM411OXlKP/OnKPCIUXHalJk7tfX8VWetx0yhVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/58aRH73IHGHhfUO6Z1+nmWkxa+Uq7D/NJoMhB5eTVw=;
 b=cusP4Tvqop9tkVSo5EAWWEKu6w4V5lEvgzHlzTMfmCzMthTiStNwYtHCs9f7eq5NaRQUcvISRbDsqhrvP9Nr2gDj//M5Kkzmj9ggtteFDi++3AfeIXccAPvaDiHQgWwApm2rEiLkzLR4vFJ8NOi83EmX0jGu5OmtNgAZ5RIsw/RfO/0d8pyKGSRrsTh/0nrE1wSY6FgffnsmLDn/ah5t6RpI4tM09dwl8a0TMO5kMNQ7n3ZIWSH2kb0E0nYNwQkj4AMoyY7tSEKHVbQiwWYwSOnsTg7wyeVWfBVNAtIwDikmpWK6IQCgXxRrGMUnJvV3HUWyC46IgvZnICxg7+TT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/58aRH73IHGHhfUO6Z1+nmWkxa+Uq7D/NJoMhB5eTVw=;
 b=hMrs/UrE079vMtc7nxaWCmAMfib4Daj19lSBEyKNGh4wZTkv9K6ssXWcwoyG7DDVzc2CUTi6RfvX0fWD6yVRIY/zHHdOERj3rNNLX8EuhYyiL4wsVSB6TgPJ8c+aULZqXI+06cCTwwDBwecLinGFzpcpaOeRbzHE4g7ixCFKZUg=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 11:11:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:11:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 16/17] block: use int64_t instead of int in driver
 write_zeroes handlers
Date: Thu, 30 Apr 2020 14:10:32 +0300
Message-Id: <20200430111033.29980-17-vsementsov@virtuozzo.com>
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
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:11:10 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c31fb43-9fe2-4f49-c0da-08d7ecf73112
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5399A04A8C69D062F2B8CB13C1AA0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZazNdtzCLZp1p9I1ZJNULw2tbbEQutiAeN8hBTZ1s7KTHtzwP6a/DB5UTgY+iu0LFkYkPuoqMWr7T3gJswwFH/AYTeywm6AuiM3DA0UyztXfn0gY37mvQjTsIMQartBcDkYNrMtd8QIpPkYezgo10arO7rKVqSFm3jo1ojg1HrJE5QL//WCuaSlTpX3O4aUr7Q5nzP57nzH0eABBXmTsIW/y9g+QQscW4k2ag6t7SD5kWN0hqKeiiiVHLpc5d72YshbKoxIk5M8eb+z13mQ2zL+lxlkaruBK1/bU+XaxKfXHx9EQczgtl2JwbJXCjlusoaZQHCXl2wBhUIS/AcoZcyEb93EXXxvzF1PsiMUNERgVtgrO9Hd/OM5Qa4OS2u4Jrf/c5PhFxsBGhnWHHHxUpPPAq2cDYlWDAx4iLix3TCKR4bVncZDxwn6u8aA+Luz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(366004)(346002)(136003)(376002)(1076003)(36756003)(478600001)(8936002)(26005)(6512007)(30864003)(7416002)(5660300002)(107886003)(6486002)(66476007)(66556008)(86362001)(6916009)(6506007)(6666004)(8676002)(316002)(2906002)(186003)(66946007)(16526019)(2616005)(956004)(4326008)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ks52jpCHXZYKhDK2poPwn9BC3hLKA5bhyQ+FLa7o2+yCx3B83ixATEPst8pVXfVdFKdaofewhTQtaUy+slRIlDj9oMAEfsNpisH+20LXop9FuMD6klJLgygD9VQrK256wxYymAa6GF0GRyBVhF3Fd1YM9ZS8e1HMMVOLMel447JV2cB0Cwm6BZqPJ/4Pfm9XatxW+gN0XdHb1t3lQL0ky3J6BuGmllULNA80DRjLc5ckI7y9CNB44I+HZyS7hCnqeZqloLAqH40dEDtqtBY46l5Frz64pYKzxeUIec7V5/wB/PWFFxI/OIBqrryDb4wlRfzmzbpe8/gzfkVqj+a0LFbgsvaFQhn62F+raACWDNSoyMWvJsnxgp1QVZ64lFfl8iSrKvd6KYTCQ3uhkwivu6MDgvfVB9PEmSvebmBiI2ozbs63MYMS8SggMCiGtpCW1TDQMz2SmYEppGHqlxh6oNcjwZmnIrXOantUgo2h+LBzX9z04b9SymIAR8uwr54ROSDOHKysHC9hxAAu7JnuJ2LNSBYFxTphAtuXwOvlGlQYeGfFsPYW5b2jwbNh2IpO4DWog0wN2WEm1ZdVWN2zJe6Tj2rMeb6GP0T6nVM2smlt4XGBYRe4Cl3amhuq4UmJiEEdA4q3NBNqhJseAxBZ5yY44JWRzsVahLK0IiAigs3UxItJ9r/i0tOkuR/gGwHcbn44wVzq/r5xSvCJUkpUn+uB0DiOtLIinIpnyacdnLzsCVEwg06kZ8reNzGxRtOlrldiwh93deP7KGFcthtYXbls50fiX32K5aaZktd2DhY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c31fb43-9fe2-4f49-c0da-08d7ecf73112
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:11:12.2914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/hYSPLvsS0cagsx1HUnPCAvndrSpNKXn8IyoGgatbm4KcIo6RvytlelsTVnzYY1mQlt+2KzrVQdkDziuJzAkFIJurJP8kgMa8lBQL+/bxI=
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

So, convert driver write_zeroes handlers bytes parameter to int64_t.

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
 block/file-posix.c        |  6 +++---
 block/filter-compress.c   |  2 +-
 block/gluster.c           |  8 +++++---
 block/iscsi.c             | 12 ++++++++++--
 block/mirror.c            |  2 +-
 block/nbd.c               |  4 +++-
 block/nvme.c              | 16 ++++++++++++----
 block/qcow2.c             |  9 ++++++++-
 block/qed.c               | 17 +++++++++++++----
 block/raw-format.c        |  2 +-
 block/throttle.c          |  2 +-
 block/vmdk.c              |  2 +-
 18 files changed, 66 insertions(+), 30 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3f08baeff0..c98d591a56 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -246,7 +246,7 @@ struct BlockDriver {
      * will be called instead.
      */
     int coroutine_fn (*bdrv_co_pwrite_zeroes)(BlockDriverState *bs,
-        int64_t offset, int bytes, BdrvRequestFlags flags);
+        int64_t offset, int64_t bytes, BdrvRequestFlags flags);
     int coroutine_fn (*bdrv_co_pdiscard)(BlockDriverState *bs,
         int64_t offset, int bytes);
 
diff --git a/block/backup-top.c b/block/backup-top.c
index 519c7ea5ad..2484293fb0 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -76,7 +76,7 @@ static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
 }
 
 static int coroutine_fn backup_top_co_pwrite_zeroes(BlockDriverState *bs,
-        int64_t offset, int bytes, BdrvRequestFlags flags)
+        int64_t offset, int64_t bytes, BdrvRequestFlags flags)
 {
     int ret = backup_top_cbw(bs, offset, bytes, flags);
     if (ret < 0) {
diff --git a/block/blkdebug.c b/block/blkdebug.c
index e47a686628..d593d6c85d 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -672,7 +672,7 @@ static int blkdebug_co_flush(BlockDriverState *bs)
 }
 
 static int coroutine_fn blkdebug_co_pwrite_zeroes(BlockDriverState *bs,
-                                                  int64_t offset, int bytes,
+                                                  int64_t offset, int64_t bytes,
                                                   BdrvRequestFlags flags)
 {
     uint32_t align = MAX(bs->bl.request_alignment,
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index f9697aaa75..8ca41d09cd 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -474,8 +474,8 @@ blk_log_writes_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
 }
 
 static int coroutine_fn
-blk_log_writes_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
-                                BdrvRequestFlags flags)
+blk_log_writes_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
+                                int64_t bytes, BdrvRequestFlags flags)
 {
     return blk_log_writes_co_log(bs, offset, bytes, NULL, flags,
                                  blk_log_writes_co_do_file_pwrite_zeroes, 0,
diff --git a/block/blkreplay.c b/block/blkreplay.c
index 98b8dff860..186d28cc6a 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -95,7 +95,7 @@ static int coroutine_fn blkreplay_co_pwritev(BlockDriverState *bs,
 }
 
 static int coroutine_fn blkreplay_co_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags)
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
 {
     uint64_t reqid = blkreplay_next_id();
     int ret = bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 174e711393..d99e07e99f 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -94,7 +94,7 @@ static int coroutine_fn cor_co_pwritev(BlockDriverState *bs,
 
 
 static int coroutine_fn cor_co_pwrite_zeroes(BlockDriverState *bs,
-                                             int64_t offset, int bytes,
+                                             int64_t offset, int64_t bytes,
                                              BdrvRequestFlags flags)
 {
     return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
diff --git a/block/file-posix.c b/block/file-posix.c
index 38c1398494..fa9ac5b13e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2797,7 +2797,7 @@ raw_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 }
 
 static int coroutine_fn
-raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
+raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
                      BdrvRequestFlags flags, bool blkdev)
 {
     BDRVRawState *s = bs->opaque;
@@ -2866,7 +2866,7 @@ raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
 
 static int coroutine_fn raw_co_pwrite_zeroes(
     BlockDriverState *bs, int64_t offset,
-    int bytes, BdrvRequestFlags flags)
+    int64_t bytes, BdrvRequestFlags flags)
 {
     return raw_do_pwrite_zeroes(bs, offset, bytes, flags, false);
 }
@@ -3489,7 +3489,7 @@ hdev_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
 }
 
 static coroutine_fn int hdev_co_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags)
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
 {
     int rc;
 
diff --git a/block/filter-compress.c b/block/filter-compress.c
index 09c0201c51..7cf47608b5 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -85,7 +85,7 @@ static int coroutine_fn compress_co_pwritev_part(BlockDriverState *bs,
 
 
 static int coroutine_fn compress_co_pwrite_zeroes(BlockDriverState *bs,
-                                                  int64_t offset, int bytes,
+                                                  int64_t offset, int64_t bytes,
                                                   BdrvRequestFlags flags)
 {
     return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
diff --git a/block/gluster.c b/block/gluster.c
index 0aa1f2cda4..88130c3d2d 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -1017,19 +1017,21 @@ static void qemu_gluster_reopen_abort(BDRVReopenState *state)
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
 static coroutine_fn int qemu_gluster_co_pwrite_zeroes(BlockDriverState *bs,
                                                       int64_t offset,
-                                                      int size,
+                                                      int64_t bytes,
                                                       BdrvRequestFlags flags)
 {
     int ret;
     GlusterAIOCB acb;
     BDRVGlusterState *s = bs->opaque;
 
-    acb.size = size;
+    assert(bytes < INT_MAX);
+
+    acb.size = bytes;
     acb.ret = 0;
     acb.coroutine = qemu_coroutine_self();
     acb.aio_context = bdrv_get_aio_context(bs);
 
-    ret = glfs_zerofill_async(s->fd, offset, size, gluster_finish_aiocb, &acb);
+    ret = glfs_zerofill_async(s->fd, offset, bytes, gluster_finish_aiocb, &acb);
     if (ret < 0) {
         return -errno;
     }
diff --git a/block/iscsi.c b/block/iscsi.c
index 861a70c823..c4183ef12f 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1204,8 +1204,8 @@ out_unlock:
 }
 
 static int
-coroutine_fn iscsi_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
-                                    int bytes, BdrvRequestFlags flags)
+coroutine_fn iscsi_co_pwrite_zeroes_old(BlockDriverState *bs, int64_t offset,
+                                        int bytes, BdrvRequestFlags flags)
 {
     IscsiLun *iscsilun = bs->opaque;
     struct IscsiTask iTask;
@@ -1308,6 +1308,14 @@ out_unlock:
     return r;
 }
 
+static int
+coroutine_fn iscsi_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
+                                    int64_t bytes, BdrvRequestFlags flags)
+{
+    assert(bytes < INT_MAX);
+    return iscsi_co_pwrite_zeroes_old(bs, offset, bytes, flags);
+}
+
 static void apply_chap(struct iscsi_context *iscsi, QemuOpts *opts,
                        Error **errp)
 {
diff --git a/block/mirror.c b/block/mirror.c
index ac3d4bc8c5..7f4fdfb470 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1464,7 +1464,7 @@ static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
 }
 
 static int coroutine_fn bdrv_mirror_top_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags)
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
 {
     return bdrv_mirror_top_do_write(bs, MIRROR_METHOD_ZERO, offset, bytes, NULL,
                                     flags);
diff --git a/block/nbd.c b/block/nbd.c
index 8cd417f018..0e52b76d72 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1245,7 +1245,7 @@ static int nbd_client_co_pwritev(BlockDriverState *bs, int64_t offset,
 }
 
 static int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
-                                       int bytes, BdrvRequestFlags flags)
+                                       int64_t bytes, BdrvRequestFlags flags)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = {
@@ -1254,6 +1254,8 @@ static int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
         .len = bytes,
     };
 
+    assert(bytes < INT_MAX);
+
     assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
     if (!(s->info.flags & NBD_FLAG_SEND_WRITE_ZEROES)) {
         return -ENOTSUP;
diff --git a/block/nvme.c b/block/nvme.c
index d91bbe60bf..724f894b00 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1104,10 +1104,10 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
 }
 
 
-static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
-                                              int64_t offset,
-                                              int bytes,
-                                              BdrvRequestFlags flags)
+static coroutine_fn int nvme_co_pwrite_zeroes_old(BlockDriverState *bs,
+                                                  int64_t offset,
+                                                  int bytes,
+                                                  BdrvRequestFlags flags)
 {
     BDRVNVMeState *s = bs->opaque;
     NVMeQueuePair *ioq = s->queues[1];
@@ -1157,6 +1157,14 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     return data.ret;
 }
 
+static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
+                                              int64_t offset,
+                                              int64_t bytes,
+                                              BdrvRequestFlags flags)
+{
+    assert(bytes <= INT_MAX);
+    return nvme_co_pwrite_zeroes_old(bs, offset, bytes, flags);
+}
 
 static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
                                          int64_t offset,
diff --git a/block/qcow2.c b/block/qcow2.c
index 15a6d3c6ef..0800d0378a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3727,7 +3727,7 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
     return res >= 0 && (res & BDRV_BLOCK_ZERO) && nr == bytes;
 }
 
-static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
+static coroutine_fn int qcow2_co_pwrite_zeroes_old(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
     int ret;
@@ -3779,6 +3779,13 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
     return ret;
 }
 
+static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
+{
+    assert(bytes < INT_MAX);
+    return qcow2_co_pwrite_zeroes_old(bs, offset, bytes, flags);
+}
+
 static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
                                           int64_t offset, int bytes)
 {
diff --git a/block/qed.c b/block/qed.c
index 1af9b3cb1d..fe00dbbff5 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1439,10 +1439,10 @@ static int coroutine_fn bdrv_qed_co_writev(BlockDriverState *bs,
     return qed_co_request(bs, sector_num, qiov, nb_sectors, QED_AIOCB_WRITE);
 }
 
-static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
-                                                  int64_t offset,
-                                                  int bytes,
-                                                  BdrvRequestFlags flags)
+static int coroutine_fn bdrv_qed_co_pwrite_zeroes_old(BlockDriverState *bs,
+                                                      int64_t offset,
+                                                      int bytes,
+                                                      BdrvRequestFlags flags)
 {
     BDRVQEDState *s = bs->opaque;
 
@@ -1463,6 +1463,15 @@ static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
                           QED_AIOCB_WRITE | QED_AIOCB_ZERO);
 }
 
+static int coroutine_fn bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs,
+                                                  int64_t offset,
+                                                  int64_t bytes,
+                                                  BdrvRequestFlags flags)
+{
+    assert(bytes <= INT_MAX);
+    return bdrv_qed_co_pwrite_zeroes_old(bs, offset, bytes, flags);
+}
+
 static int coroutine_fn bdrv_qed_co_truncate(BlockDriverState *bs,
                                              int64_t offset,
                                              bool exact,
diff --git a/block/raw-format.c b/block/raw-format.c
index fdf024705b..0996741056 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -279,7 +279,7 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
 }
 
 static int coroutine_fn raw_co_pwrite_zeroes(BlockDriverState *bs,
-                                             int64_t offset, int bytes,
+                                             int64_t offset, int64_t bytes,
                                              BdrvRequestFlags flags)
 {
     int ret;
diff --git a/block/throttle.c b/block/throttle.c
index af8cc3b2dd..c97da1d6a7 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -137,7 +137,7 @@ static int coroutine_fn throttle_co_pwritev(BlockDriverState *bs,
 }
 
 static int coroutine_fn throttle_co_pwrite_zeroes(BlockDriverState *bs,
-                                                  int64_t offset, int bytes,
+                                                  int64_t offset, int64_t bytes,
                                                   BdrvRequestFlags flags)
 {
     ThrottleGroupMember *tgm = bs->opaque;
diff --git a/block/vmdk.c b/block/vmdk.c
index 61b409ebc7..9611bb191e 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2089,7 +2089,7 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
 
 static int coroutine_fn vmdk_co_pwrite_zeroes(BlockDriverState *bs,
                                               int64_t offset,
-                                              int bytes,
+                                              int64_t bytes,
                                               BdrvRequestFlags flags)
 {
     int ret;
-- 
2.21.0


