Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7287DC55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A7320728
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="G0syHiWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A7320728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzBT-0002VR-5n
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3j-0002qB-IF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3i-0007qk-Rf
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:11 -0400
Received: from mail-eopbgr70099.outbound.protection.outlook.com
 ([40.107.7.99]:65188 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3g-0007mE-Ht; Mon, 27 Apr 2020 04:24:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNmaGsw3iGIgl/FgTgeJlRgnhBcIgYL1qX8kRN4Ug8l3ySuCYdoetS4nfZl8WrJJs6Dbjf5FI4FHc2FIPTJgVtYbCmlx5iOQEXSoL9pNWGiW9nArjRemr93yNH16ISdaUwx0VWRxsEZytPl8wx08j9n6bZ1caORfUvc8diibMNxfvgptIjAqDHI6uz3v5LNdSmX46SI0t91jjTLTthKANqfZZ89YGS3hdtkrsNixjzPKNF174zv0meaCs16x0dTk47mtPd39OAfe3Ju6Cl5LgWOQkRRPlatTZbj646XmC84j9YWZFyc15MLHoi7sVriMJT33tRG6BvYL+FKICwM9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6HNUBrgvYgkrNp2weZIznabRYz6CuqDJYQUZPlLN2w=;
 b=V/i7cVR4hD7lohPpaTjK0JN16opXsiv8+5l3W08bCg5q/iVAEwSLh3JKiYXu1vGN6CPpcJfGuovpIYwcj8uM+o2d82Jlkv1sLu6KPlISR7wy9UA3Tc2bW/9sLW7ydMpWpdedtDx15nHDHfRDqXi8hfmrAbw1uGAecYK4Td1NyrvU3Lnya+G8LP5Wi3C4QU+MhGnrmgzrCLkgK1Z37a9TBwfGBH+RyanfYvoeBMALiPGVJxHZ5uDXDc5iLrl3QYNo3+XfYIep41zb4plheSpku2DhpO5odDTYhcALZjwtQBu6m8vjf54W32cD37l4tuIjibM4w0vAZK8HPgo83t5jSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6HNUBrgvYgkrNp2weZIznabRYz6CuqDJYQUZPlLN2w=;
 b=G0syHiWSZyQudgBBEZpo2ERsKrfyvciaz62fN5iuRlN/f4LbT39RKWOjv1Zhy/ymvyA6ZjbbtQNj7LtU7mM3vGBbjSqhXSksu/TgSU7JG1jaQ4m+/hPFcHCVvnP+6afUqADAlSD8O1ex8w9VaSIWLvPApCMa6VCDgZX05Hw1Psk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:24:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:24:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 10/17] block/io: support int64_t bytes in read/write
 wrappers
Date: Mon, 27 Apr 2020 11:23:18 +0300
Message-Id: <20200427082325.10414-11-vsementsov@virtuozzo.com>
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
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:24:04 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d683d0b-06ff-4b8c-5fed-08d7ea84598a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5463DF58CE1D0F894C87A8D3C1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(2906002)(81156014)(6486002)(26005)(8676002)(8936002)(4326008)(6916009)(478600001)(66556008)(7416002)(66946007)(66476007)(6666004)(16526019)(316002)(2616005)(1076003)(186003)(5660300002)(52116002)(6506007)(956004)(36756003)(107886003)(6512007)(69590400007)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THnEhTeGtSBUVtyAOcVXlVZ66Crl3X3d5jnBVcFIeVUbDqZUdqzoYQmi7UdEJtHTLnpaFT5MsVhAEFSaXmWSIlvz6AxY4I5dnCfQvKQCTOk/XkvpTEK1oCQjIvAu98BLcIQlHdqjB2uC8qHUoYG5osGsqP1TwNJig1L1ErUhx6DJA2Ada6Lz5JmN/qxJZ4HzlMtZPeqLDhIujFtbIA53ZlzViOz8HVw3bW/V0ZkGR9xnPxcQ7yOSpol0uoG8gDFKRoryzjeQynVNIguICxVcAs+is/iEpBukpTSRFm2ypIkG6bUpGCtZGga2cU+pqxy6ZOvel/F9YSulOaeZcEdxaoRAvnHtPFIFiaiNPy2kjtcnqaKLWe4kg15xRcdNxiwMLES+ZnlsHt7rhmaRFTrGwNH94XKlrWFw2pBmPPtGtEHJ50YusiHqk0DPgoMZGDixkhNCMhKbs6I4b664kzF6xOwOzFoEydJ31QrACg86dbQST3xPwQeBOyJ0ZK0ONrM6
X-MS-Exchange-AntiSpam-MessageData: wyVQ87ufh269diAFFnguDq7vFr4jk5VR0dSjHVT0DjTnPD8prEP1kGtRI5Ud0DsufvQZEAVYZvxluCMazsxfE/Zu5O8ijR3L8W5RHEJ/wZJt/IAouL+xaO6/4pgtQElTH6zPflLONs2nfYYWyWJ83sIj5ufrwLHEw2bKzVYY57X3O5G6+98m59w9NiUv/x2h0IJY4GGdM0WRQzm6lB0HjOPXItYrzfFcmR51hcpcJ642tlzApvsRtNRfT+duaRigbBsgGY1LzdnYs0ZT/XUZHjhJduaK+FMEuMjteoLYtBOS5L3fmGzZl+HZQIfMH9YOFQj/Z3GenmJa86Pu4eHEyHie1yR/c4xbGf8Ownw0GYlQCTuMjYcqvtm1oEiGSSTnPX3TnrnwkPmhZujPQZobsW+WMmWd8vDqM5lfu0nRGnMwDX21gHaujrkeYuDJGg9kSBZXgrFQCUMPRJXE8zOvhhkPy9tIwMv4CTxuYwfztQHBugaCBfknENF905nnDthsp1SIBM3qJmCPStKl4v6zgwLMja1RmNCBeLHpHxzvlv1whQZgC2lWPTr1xVEichYB0PRPGtS2wR1ijcfT2o89RLU27uq5WBPbWvk5T9yON8VDGKeSWeC5oWykRD2akjW6dBeBUS6tPdMu14jm7Nf/9WUNV9kkBhEBZ/CwewZ4z1Jfhz3YDi486O0s9MMGf/rVBHn33QH290mKKktpRFhhmwh59g3bCdLobVua/0oAgIhvd4ON/JmlwkrSLu1b/x0Ez2FVeoy2xlL6cRHXQZjQ3FbDe3UlnKPjP8KrZEjsYaE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d683d0b-06ff-4b8c-5fed-08d7ea84598a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:24:05.6710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0exf4BRlyFvATY8lO9iVavB50cLKPROZ3XTsLKulDZLzkMNJBOgxaZjYcUjNWdS1Rj2X87NVUWfBnZqNZ1axMbx1JmXNMZOfYUUc9jSiuJY=
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

Now, when bdrv_co_preadv_part() and bdrv_co_pwritev_part() updated,
update all their wrappers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h     | 10 +++++-----
 include/block/block_int.h |  4 ++--
 block/blkverify.c         |  2 +-
 block/io.c                | 17 +++++++++--------
 block/trace-events        |  2 +-
 5 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index b05995fe9c..03abf30d1d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -318,14 +318,14 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
 void bdrv_reopen_commit(BDRVReopenState *reopen_state);
 void bdrv_reopen_abort(BDRVReopenState *reopen_state);
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                       int bytes, BdrvRequestFlags flags);
+                       int64_t bytes, BdrvRequestFlags flags);
 int bdrv_make_zero(BdrvChild *child, BdrvRequestFlags flags);
-int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes);
+int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int64_t bytes);
 int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov);
-int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes);
+int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int64_t bytes);
 int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov);
 int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
-                     const void *buf, int count);
+                     const void *buf, int64_t bytes);
 /*
  * Efficiently zero a region of the disk image.  Note that this is a regular
  * I/O request like read or write and should have a reasonable size.  This
@@ -333,7 +333,7 @@ int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
  * because it may allocate memory for the entire region.
  */
 int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                                       int bytes, BdrvRequestFlags flags);
+                                       int64_t bytes, BdrvRequestFlags flags);
 BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     const char *backing_file);
 void bdrv_refresh_filename(BlockDriverState *bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 3c2a1d741a..b4b42d0cd6 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -972,13 +972,13 @@ extern BlockDriver bdrv_raw;
 extern BlockDriver bdrv_qcow2;
 
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
     int64_t offset, int64_t bytes,
     QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
     int64_t offset, int64_t bytes,
diff --git a/block/blkverify.c b/block/blkverify.c
index ba6b1853ae..667e60d832 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -31,7 +31,7 @@ typedef struct BlkverifyRequest {
     uint64_t bytes;
     int flags;
 
-    int (*request_fn)(BdrvChild *, int64_t, unsigned int, QEMUIOVector *,
+    int (*request_fn)(BdrvChild *, int64_t, int64_t, QEMUIOVector *,
                       BdrvRequestFlags);
 
     int ret;                    /* test image result */
diff --git a/block/io.c b/block/io.c
index 784eaf02f2..02632eaf59 100644
--- a/block/io.c
+++ b/block/io.c
@@ -946,7 +946,7 @@ static int bdrv_prwv_co(BdrvChild *child, int64_t offset,
 }
 
 int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                       int bytes, BdrvRequestFlags flags)
+                       int64_t bytes, BdrvRequestFlags flags)
 {
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, bytes);
 
@@ -1008,7 +1008,7 @@ int bdrv_preadv(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
 }
 
 /* See bdrv_pwrite() for the return codes */
-int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int bytes)
+int bdrv_pread(BdrvChild *child, int64_t offset, void *buf, int64_t bytes)
 {
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
@@ -1037,7 +1037,8 @@ int bdrv_pwritev(BdrvChild *child, int64_t offset, QEMUIOVector *qiov)
   -EINVAL      Invalid offset or number of bytes
   -EACCES      Trying to write a read-only device
 */
-int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes)
+int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf,
+                int64_t bytes)
 {
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
@@ -1055,11 +1056,11 @@ int bdrv_pwrite(BdrvChild *child, int64_t offset, const void *buf, int bytes)
  * Returns 0 on success, -errno in error cases.
  */
 int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
-                     const void *buf, int count)
+                     const void *buf, int64_t bytes)
 {
     int ret;
 
-    ret = bdrv_pwrite(child, offset, buf, count);
+    ret = bdrv_pwrite(child, offset, buf, bytes);
     if (ret < 0) {
         return ret;
     }
@@ -1687,7 +1688,7 @@ static bool bdrv_pad_request(BlockDriverState *bs,
 }
 
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags)
 {
     return bdrv_co_preadv_part(child, offset, bytes, qiov, 0, flags);
@@ -2100,7 +2101,7 @@ out:
  * Handle a write request in coroutine context
  */
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags)
 {
     return bdrv_co_pwritev_part(child, offset, bytes, qiov, 0, flags);
@@ -2177,7 +2178,7 @@ out:
 }
 
 int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                                       int bytes, BdrvRequestFlags flags)
+                                       int64_t bytes, BdrvRequestFlags flags)
 {
     trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
 
diff --git a/block/trace-events b/block/trace-events
index dd367a9b19..13ad9af0d8 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -13,7 +13,7 @@ blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 # io.c
 bdrv_co_preadv_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
 bdrv_co_pwritev_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
-bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags 0x%x"
+bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
 bdrv_co_do_copy_on_readv(void *bs, int64_t offset, int64_t bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %" PRId64 " bytes %" PRId64 " cluster_offset %" PRId64 " cluster_bytes %" PRId64
 bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
 bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
-- 
2.21.0


