Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE1FC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7A920728
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ElcJo5tM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7A920728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzDs-00071m-QZ
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz42-0003XP-Ai
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3z-0000io-9r
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:29 -0400
Received: from mail-eopbgr00096.outbound.protection.outlook.com
 ([40.107.0.96]:55939 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3q-00081B-6h; Mon, 27 Apr 2020 04:24:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM4+v6wZTGvhXw2uP0BKXGUX9jbjCCVDNasNAEpTje2n+Mnwa4UTmXGX0ipm3hnWeHWVK5d/lxxx3qDb0p3fzypHJ/z2fRkLp05hictszuMHi/1AFCxM75eOnMdOGvs0OJpdcDwWM10bdLjhlLj1L534v7jnurdDdf6w0vaPhJvjnwRJLMlFGlRhPGX+jbMM0AmKsBVAA/gBeTw0wf5CIriBDK37dMYyH0PmkXaMi75E1j6Up3nI8GffHT1/LF5HxAwblfyLCvojVny4wE/2yqALo4WYRhxUOYMXz4jz0kxFywsE0maA+Fog/z1Ru/NBlKYS/asti5eQqPTnFFUCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDetedrS9YdvUfmugU6bhlm8Pm95V+7h+jOtqe4bjlw=;
 b=I+sQd7OV3E3Eeilpylh30CSJa+GxEwEV1iBRqy8XT/TLxxUjhGr9HuQ9d4WSBWzZuS515O72+b6lx3ofPKvCOM1ea0DjVR7gJgJDrIWxu6ld+6J5GpJ99gbZwVG4dVpwjLs1pHpTk0FeOTfBNs2UljRx1lQ2b+sneCIwLim+mJKexEo+DZdMAChyojDMy4S6f1+nXGxM9wzTVHlMI9+JMfHGTk+30rSusns1apUCwYyXkuDfbk11ZOEqZ1GkzEA+GkazQipHjqMs7Oeqq9ZeI/zBJtiFIufROWMqW7wZ0xxaIHBECHi+DFbBkkn6z+5SIR4W8kLiZRksEGN3d8EQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDetedrS9YdvUfmugU6bhlm8Pm95V+7h+jOtqe4bjlw=;
 b=ElcJo5tMBUFSHuZfseSL0mHG9v4kz1n/jhwGRoeXtaRBVbN9saMzLirMLE3ly/+6K7q4qANmbNTLCL6cpYXjxJlM2cIuFIkXwBSKWDJwNh5ITm4gyhF9/p268N3prvtp7LH0UsQ/dVHOSJKF4h3kB8O/0tsUKf0rOopO2e5Vy80=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5400.eurprd08.prod.outlook.com (2603:10a6:20b:109::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 08:24:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:24:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 17/17] block: use int64_t instead of int in driver discard
 handlers
Date: Mon, 27 Apr 2020 11:23:25 +0300
Message-Id: <20200427082325.10414-18-vsementsov@virtuozzo.com>
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
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:24:14 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4bc4286-bd1d-458d-266b-08d7ea845f7c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB540065BBBAAD910D1B114E40C1AF0@AM7PR08MB5400.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(136003)(376002)(366004)(346002)(107886003)(36756003)(956004)(2616005)(2906002)(4326008)(26005)(6512007)(6916009)(6486002)(5660300002)(6506007)(186003)(69590400007)(1076003)(316002)(8676002)(66946007)(81156014)(52116002)(478600001)(30864003)(86362001)(7416002)(66556008)(6666004)(8936002)(66476007)(16526019);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydtd20h1R+uXFzpHuMS8aKCLXt93sbwgbfzhJiyaSeg6F2brbQ+IXl+/xHDDHNlRrRRcMqdonZG9VmYIeNwm8c4w1HP7GbK6NTXUNT/PzWIxr/yPATIwmmN89CH3RQgYiOFaa8GTlWy4TI46TsZ/B1MO5lxSybMjS28m+aK4bS64+AEfDExNEsImhU8n0Le5R6wkQWw2XcVazCV4CkxYPvpjWw8sp7uF9IfgRLTpsE4fJi3eUg6Slgw90dAi432PNlnRoE89PU6DXpY4A2GHKktKAPCs3XaQmKa7gs1W3j+pvnUg4MJAqZF2ikbrChmpkk+udS3RgFN3/uCe5FJB0jUcJMDLQaF2TwtJdIO98CQvEuvOifmtsgbGX73/PnDiGR3jrdP/Uvf5rI7Y1BpOsG5r7qpEVAB9JZuzYbfQIkGhkV8yN4dpOJ0uu3YHgxmcvIXu0rDhy8dfCY7ZCZEb0n/6L7ids9zKApN8Cxj9f/j+daFVfNPI2rGBuxAJdxQb
X-MS-Exchange-AntiSpam-MessageData: EeI/oFg6M4K4vZBVJxFdals25waB2UPsjbfbJhIzExE09I6kprn7GrPdSmQNIbEzGN/cUqvwdkrhA5Ykt8tS9sQ2c/uSK/3Plured32AoamLwhZMu09zNgmHBOsIoW7pRKSq7D6b/sSTPm493wbs3ItfLHh3TbiNz2HUjWhz682AHqs6GLn7WjvXJmCDp8bzwpvUNKgO9AOszoO1ocToUWwuXfGTnEtkL3eaGzE7HL/jMzPU8/LTXh9QIptOkYtD0hgazNs243bfkwq1ws1KEwWQ874o6InjHw7yx4sqeeks1rJMvPpNcHnJ7OVvrIlwvE0GcQeMqyOqu8XzfnKJ7oPJOn6qjb1W1enYODs/jqQNP5wTuyF6zhDjK+Y5p2uTie29vVBT52Lps/B/AghekHOaLCZVHtiHxnB9Jqcwzm8JptbheVEmH3c6SDE1H02rpYieZxxgMxpiYqiPz1EZd8fg7f1/1WnlTyXDe/h4mpvD15FfyH9/xfnx01n6hzkwgMhuQhht4nxHaMarXawqjJ/Morn/mDFHwZfWPKSJx63dsB+ndN52RN3/1Bo8CIa59q6JnvZzdMVd+p18D8+XZ5CJIJlJtEw0w1CN7wRMLhlTYVvwR4haDCuIA3tEBB95DOEWeTGETZ+c8Iam9ABWYGGNxSwFDFPQCZqmPXWjhcBD0+H23mzRG4lbyCjRUHp4CX2a2rzXwUrvTaMNZStBPYRSx01OHwL1rxdsXFY/XnEBfaM+EJKEsYlKSRODHNEgfhgLNuMexy9y/f02pzJJh8x4IEchjzPngSFQo6e/6mM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bc4286-bd1d-458d-266b-08d7ea845f7c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:24:15.6292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5jNJ2leIdKH2vDPk5zn8DwkdFTvE/ajLgoML9ls08wspflLIXZr2xEMgQlgPuD7/Z/cTAzMRZp7YVsSo8QW4PwIW0oXvtNL/jQxwY2uf2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5400
Received-SPF: pass client-ip=40.107.0.96;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:24:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.0.96
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
on all io paths. Convert driver discard handlers bytes parameter to
int64_t.

This patch just converts handlers where it is obvious that bytes
parameter is passed further to 64bit interfaces, and add simple
wrappers where it is not obvious.

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
index fe446f11eb..814837603d 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -246,7 +246,7 @@ struct BlockDriver {
     int coroutine_fn (*bdrv_co_pwrite_zeroes)(BlockDriverState *bs,
         int64_t offset, int64_t bytes, BdrvRequestFlags flags);
     int coroutine_fn (*bdrv_co_pdiscard)(BlockDriverState *bs,
-        int64_t offset, int bytes);
+        int64_t offset, int64_t bytes);
 
     /* Map [offset, offset + nbytes) range onto a child of @bs to copy from,
      * and invoke bdrv_co_copy_range_from(child, ...), or invoke
diff --git a/block/backup-top.c b/block/backup-top.c
index 20c943280f..7ff0b0aa7e 100644
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
index 521b7b1fe2..3c84cc3f84 100644
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
index ccfb1100e4..172afbf199 100644
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
index 74ea935593..f34ea6b249 100644
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
index 59272b5faa..c05553eba7 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -100,7 +100,7 @@ static int coroutine_fn cor_co_pwrite_zeroes(BlockDriverState *bs,
 
 
 static int coroutine_fn cor_co_pdiscard(BlockDriverState *bs,
-                                        int64_t offset, int bytes)
+                                        int64_t offset, int64_t bytes)
 {
     return bdrv_co_pdiscard(bs->file, offset, bytes);
 }
diff --git a/block/file-posix.c b/block/file-posix.c
index bfddfbb9b3..b938e1ee83 100644
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
index b22e57c5f2..646abad5b0 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -92,7 +92,7 @@ static int coroutine_fn compress_co_pwrite_zeroes(BlockDriverState *bs,
 
 
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
index 2d8fe6008a..d284b5296e 100644
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
index fc30514e10..50874351de 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1293,7 +1293,7 @@ static int nbd_client_co_flush(BlockDriverState *bs)
 }
 
 static int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset,
-                                  int bytes)
+                                  int64_t bytes)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     NBDRequest request = {
@@ -1302,6 +1302,8 @@ static int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset,
         .len = bytes,
     };
 
+    assert(bytes < INT_MAX);
+
     assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
     if (!(s->info.flags & NBD_FLAG_SEND_TRIM) || !bytes) {
         return 0;
diff --git a/block/nvme.c b/block/nvme.c
index ef27c7eb3c..939d5d36dd 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1165,9 +1165,9 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
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
@@ -1244,6 +1244,13 @@ out:
 
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
index 905d22e2c8..0f6458c1cf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3786,7 +3786,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
 }
 
 static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
-                                          int64_t offset, int bytes)
+                                          int64_t offset, int64_t bytes)
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
diff --git a/block/raw-format.c b/block/raw-format.c
index de2fef9edc..2f25bed301 100644
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
index c1503f133f..c0a8521dca 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -145,7 +145,7 @@ static int coroutine_fn throttle_co_pwrite_zeroes(BlockDriverState *bs,
 }
 
 static int coroutine_fn throttle_co_pdiscard(BlockDriverState *bs,
-                                             int64_t offset, int bytes)
+                                             int64_t offset, int64_t bytes)
 {
     ThrottleGroupMember *tgm = bs->opaque;
     throttle_group_co_io_limits_intercept(tgm, bytes, true);
-- 
2.21.0


