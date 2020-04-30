Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E58C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF992076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ugbMWO6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF992076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7Do-0005JN-JS
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78Y-00077X-9J
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU772-0005HB-MF
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:50 -0400
Received: from mail-eopbgr80117.outbound.protection.outlook.com
 ([40.107.8.117]:39403 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75x-0003Yq-AS; Thu, 30 Apr 2020 07:11:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T01TacMPMMQWLlZRLfeA21Y0fHa3qJGOemLzOtXOYm65LI3rkiEJKxiS/5nSZN0kZbataJiXw7UBB3oY0xPbo8cuXaPNBjg6BdA5m6OaJ/G5koRBxiwvPb/oO3szMFTGTnPuP+FbP6CcOGoOGTBLdLH4cJgVZeMiKmPmyjyLDWBtJl6qY96fVeYcDOtzxT/8xJLbXuJxYQ2vKhqFEe4r9roW42joVMPLKNgn9gvEwiAAQiAgAGGFaE958ukR2a6sak+QkB33244S/U0IZ0OTlMzIOZUuM0ZvkUFteGM10C5gmAs73vScKxLZ+YpNMNiVrSr1ahUuGUPn3GvSxMuNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p96Q8f6SVdBp4AN38/xYSuB/77eP/QtXR1B0Z8I3bD0=;
 b=PnbaKBnMtsTO8RL23j3506V1eEGhq6Uywl9cFnc1yYhoAJ3h3lPD0yQYtGwCD/5QFi/g1A4lMDE4isfDGmRVsl8gxQZq6uX5h8rhCnnYv0/Z0LPJIFrIQqlH1XkGBwevVSUGaPOnANHFujtkhs2V/eIDnARZwaCJLW+OT7DHTn88JOQXnMm9ttIRV60+WK90o1g7W037SlczDKbBP5SoA/tqRVfa6ohH1hxamS/xtvsMyk50t9Lk8cwR7GXGw7OoQP3rup3hzcOj1F0QZxT1cMWoHXUcnWnmZKA/JMy5xTENCHkU27fCwJTgZPxAJat57t8FE49ByGP48VRGfahjrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p96Q8f6SVdBp4AN38/xYSuB/77eP/QtXR1B0Z8I3bD0=;
 b=ugbMWO6sNOLBEdeGo89ZkwEEO/ldvMYwjPV/sLVheya17cHJlciVhZGnUwOQXyS1XtFWscvT7oOiK8mK0bukkC9L5am+pYnYB20W2Q6yLlUE9yr3Qs/V/2Y5cWYllxzhFf8MGsUWqfFJ0Kmg50Uhmm6N9O+PFiZsRvRTJ10pRQU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 11:11:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:11:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 12/17] block/block-backend: convert blk io path to use
 int64_t parameters
Date: Thu, 30 Apr 2020 14:10:28 +0300
Message-Id: <20200430111033.29980-13-vsementsov@virtuozzo.com>
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
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:11:04 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c2773d0-d9d3-46ce-37f6-08d7ecf72d4c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54477A4D69526358A570297AC1AA0@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(376002)(396003)(366004)(66556008)(6512007)(107886003)(316002)(6506007)(26005)(52116002)(186003)(478600001)(956004)(2616005)(16526019)(66476007)(2906002)(30864003)(86362001)(5660300002)(66946007)(6486002)(6916009)(7416002)(36756003)(8936002)(1076003)(6666004)(8676002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kN+LSLZnZM07AKs4sOCVx+o8JFJQ6+WApPRcAAPHfvnUQeuAxCKi9KoHL71mrJJ3G3VKKH0LMfNoeUOejQ0PkoV4lj+gnigTab3oodaBWqAe4n0CKlenn5SHacpUhclvvJ+TGYdMGIwR6hT1iQ56ZvCJeyF6ztsXVdnt3jZZiGpjsp98bmFI4OjW6LB+P0e5/MEdrpL5qtsEq0b+H6MC3hCjWrfsef/AD6UpunHF8Zvgoev4tX2g5Hi/+VWh0B/t9wpuIrWv4rr/TeJsSI/Tf4YtP3VlA8TspAIIZKCEJaRAYuuKgkA/2Vi4einhK7qWjKbU9cGaYdPtRvLYSByHatLBuPQUL5rQ/Sr34icVJNDIZXJdhA8mhti+r6DcscNjhqheE+UxMNgWDCAU++5dJGkBXpQnM2JhokB/jsoYPhGj6wmQl1IrHd5di6nIjbfa
X-MS-Exchange-AntiSpam-MessageData: 9/zR1fMrB9hUDFXJwbmjwSU3KoA83beId+lvhrbfQ31It2eMvGhfiS7l1oERsRe8YVy97Hcyx7CCxVN8hwdJrpxWsktgRCnDrlOWUXiZpoPXf6VdgG2yy65P5S+VIjdb20YBd09QIpuDZHiiQ84uOvm+exQkny8kCbaTJA3Tvd3WOVSuNTkLzLGYp6O+5waTpE6tiAGfJgJS25MrLdOS2YaKbxhnIOBKCzvMMLsbJKUur7eawBAXXuf3d/S/I8FJf79P0paKAy9uSJK4z1rZQ3A8+xUbQnVvjglTba1jFSh1PvnmSygGKFPEt4ySo2XlliajYug/1Ior0aypvIQ6D+/1MQgyFoLNucW7N1TEECaIHrk5ySpozpgudpdNH+39fY7KnJ3LnwWMTWTFf5dTwIJkoa8GxR/IDfr0gnQXyE1ylLJjqFXrGQbk+PzCOH8oe5umxiE1eF3iXIShoI4vo+4U6lcreIZ4Dy57CXYFXvVahOo28ZphBUdF0cAfhJ0ya9We9o7+9OCloJBOk6PzR+y6Ru3/cPN8au1D476aA8gNCS8QjXzfu5q+1odXm3jme6A6ADUzWx85HtXAOqfDo9Zsd7U+E5a2Zvwgbn84KM0jm+qSz+klmhV8NY6NLCKIgqX6yG4f6Q4NrU11gOe3e5OaxORVk4RGqd0fSeXgnEqvmuJseIZvDsqd9FYarE4DgR2cVj2UqaOrL29NvjOv7IZm7AG73JWbRyvleMMLzNfCK0/+3zcOJAVqsNB1yw9OH0R4xQk89ed7Tm7AV+5m/PHjoKfaDcfsoFDhDlbfyGM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2773d0-d9d3-46ce-37f6-08d7ecf72d4c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:11:06.2010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wn93SmIyBeMoZxN7ya30FiHzGx/jSM9NJJqnIxQiQgEzycO7JyS9vvNi1g7NJyM+xkYKPs74dlSof4rMLZK1782v8AkqyLs/tbXBmn0zZpI=
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

Now bdrv layer is converted, convert blk layer too.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/sysemu/block-backend.h | 26 +++++++--------
 block/block-backend.c          | 60 ++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 9bbdbd63d7..0c1eee1778 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -119,14 +119,14 @@ BlockBackend *blk_by_dev(void *dev);
 BlockBackend *blk_by_qdev_id(const char *id, Error **errp);
 void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops, void *opaque);
 int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
-                               unsigned int bytes, QEMUIOVector *qiov,
+                               int64_t bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
 int coroutine_fn blk_co_pwritev_part(BlockBackend *blk, int64_t offset,
-                                     unsigned int bytes,
+                                     int64_t bytes,
                                      QEMUIOVector *qiov, size_t qiov_offset,
                                      BdrvRequestFlags flags);
 int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
-                               unsigned int bytes, QEMUIOVector *qiov,
+                               int64_t bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
 
 static inline int coroutine_fn blk_co_pread(BlockBackend *blk, int64_t offset,
@@ -148,13 +148,13 @@ static inline int coroutine_fn blk_co_pwrite(BlockBackend *blk, int64_t offset,
 }
 
 int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                      int bytes, BdrvRequestFlags flags);
+                      int64_t bytes, BdrvRequestFlags flags);
 BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                                  int bytes, BdrvRequestFlags flags,
+                                  int64_t bytes, BdrvRequestFlags flags,
                                   BlockCompletionFunc *cb, void *opaque);
 int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags);
-int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int bytes);
-int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int bytes,
+int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int64_t bytes);
+int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int64_t bytes,
                BdrvRequestFlags flags);
 int64_t blk_getlength(BlockBackend *blk);
 void blk_get_geometry(BlockBackend *blk, uint64_t *nb_sectors_ptr);
@@ -167,14 +167,14 @@ BlockAIOCB *blk_aio_pwritev(BlockBackend *blk, int64_t offset,
                             BlockCompletionFunc *cb, void *opaque);
 BlockAIOCB *blk_aio_flush(BlockBackend *blk,
                           BlockCompletionFunc *cb, void *opaque);
-BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t offset, int bytes,
+BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes,
                              BlockCompletionFunc *cb, void *opaque);
 void blk_aio_cancel(BlockAIOCB *acb);
 void blk_aio_cancel_async(BlockAIOCB *acb);
 int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
 BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
                           BlockCompletionFunc *cb, void *opaque);
-int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
+int blk_co_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes);
 int blk_co_flush(BlockBackend *blk);
 int blk_flush(BlockBackend *blk);
 int blk_commit_all(void);
@@ -233,12 +233,12 @@ int blk_get_open_flags_from_root_state(BlockBackend *blk);
 void *blk_aio_get(const AIOCBInfo *aiocb_info, BlockBackend *blk,
                   BlockCompletionFunc *cb, void *opaque);
 int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                                      int bytes, BdrvRequestFlags flags);
+                                      int64_t bytes, BdrvRequestFlags flags);
 int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
-                          int bytes);
+                          int64_t bytes);
 int blk_truncate(BlockBackend *blk, int64_t offset, bool exact,
                  PreallocMode prealloc, Error **errp);
-int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
+int blk_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes);
 int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
                      int64_t pos, int size);
 int blk_load_vmstate(BlockBackend *blk, uint8_t *buf, int64_t pos, int size);
@@ -259,7 +259,7 @@ void blk_unregister_buf(BlockBackend *blk, void *host);
 
 int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                                    BlockBackend *blk_out, int64_t off_out,
-                                   int bytes, BdrvRequestFlags read_flags,
+                                   int64_t bytes, BdrvRequestFlags read_flags,
                                    BdrvRequestFlags write_flags);
 
 const BdrvChild *blk_root(BlockBackend *blk);
diff --git a/block/block-backend.c b/block/block-backend.c
index 38ae413826..b3f6edfc70 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1110,11 +1110,11 @@ void blk_set_disable_request_queuing(BlockBackend *blk, bool disable)
 }
 
 static int blk_check_byte_request(BlockBackend *blk, int64_t offset,
-                                  size_t size)
+                                  int64_t bytes)
 {
     int64_t len;
 
-    if (size > INT_MAX) {
+    if (bytes > INT_MAX) {
         return -EIO;
     }
 
@@ -1122,7 +1122,7 @@ static int blk_check_byte_request(BlockBackend *blk, int64_t offset,
         return -ENOMEDIUM;
     }
 
-    if (offset < 0) {
+    if (offset < 0 || bytes < 0) {
         return -EIO;
     }
 
@@ -1132,7 +1132,7 @@ static int blk_check_byte_request(BlockBackend *blk, int64_t offset,
             return len;
         }
 
-        if (offset > len || len - offset < size) {
+        if (offset > len || len - offset < bytes) {
             return -EIO;
         }
     }
@@ -1154,7 +1154,7 @@ static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
 
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static int coroutine_fn
-blk_do_preadv(BlockBackend *blk, int64_t offset, unsigned int bytes,
+blk_do_preadv(BlockBackend *blk, int64_t offset, int64_t bytes,
               QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     int ret;
@@ -1185,7 +1185,7 @@ blk_do_preadv(BlockBackend *blk, int64_t offset, unsigned int bytes,
 }
 
 int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
-                               unsigned int bytes, QEMUIOVector *qiov,
+                               int64_t bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags)
 {
     int ret;
@@ -1199,7 +1199,7 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
 
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static int coroutine_fn
-blk_do_pwritev_part(BlockBackend *blk, int64_t offset, unsigned int bytes,
+blk_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
                     QEMUIOVector *qiov, size_t qiov_offset,
                     BdrvRequestFlags flags)
 {
@@ -1235,7 +1235,7 @@ blk_do_pwritev_part(BlockBackend *blk, int64_t offset, unsigned int bytes,
 }
 
 int coroutine_fn blk_co_pwritev_part(BlockBackend *blk, int64_t offset,
-                                     unsigned int bytes,
+                                     int64_t bytes,
                                      QEMUIOVector *qiov, size_t qiov_offset,
                                      BdrvRequestFlags flags)
 {
@@ -1249,7 +1249,7 @@ int coroutine_fn blk_co_pwritev_part(BlockBackend *blk, int64_t offset,
 }
 
 int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
-                                unsigned int bytes, QEMUIOVector *qiov,
+                                int64_t bytes, QEMUIOVector *qiov,
                                 BdrvRequestFlags flags)
 {
     return blk_co_pwritev_part(blk, offset, bytes, qiov, 0, flags);
@@ -1311,7 +1311,7 @@ static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
 }
 
 int blk_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                      int bytes, BdrvRequestFlags flags)
+                      int64_t bytes, BdrvRequestFlags flags)
 {
     return blk_prw(blk, offset, NULL, bytes, blk_write_entry,
                    flags | BDRV_REQ_ZERO_WRITE);
@@ -1361,7 +1361,7 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
 typedef struct BlkAioEmAIOCB {
     BlockAIOCB common;
     BlkRwCo rwco;
-    int bytes;
+    int64_t bytes;
     bool has_returned;
 } BlkAioEmAIOCB;
 
@@ -1385,7 +1385,8 @@ static void blk_aio_complete_bh(void *opaque)
     blk_aio_complete(acb);
 }
 
-static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
+static BlockAIOCB *blk_aio_prwv(BlockBackend *blk,
+                                int64_t offset, int64_t bytes,
                                 void *iobuf, CoroutineEntry co_entry,
                                 BdrvRequestFlags flags,
                                 BlockCompletionFunc *cb, void *opaque)
@@ -1442,31 +1443,31 @@ static void blk_aio_write_entry(void *opaque)
 }
 
 BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                                  int count, BdrvRequestFlags flags,
+                                  int64_t bytes, BdrvRequestFlags flags,
                                   BlockCompletionFunc *cb, void *opaque)
 {
-    return blk_aio_prwv(blk, offset, count, NULL, blk_aio_write_entry,
+    return blk_aio_prwv(blk, offset, bytes, NULL, blk_aio_write_entry,
                         flags | BDRV_REQ_ZERO_WRITE, cb, opaque);
 }
 
-int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int count)
+int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int64_t bytes)
 {
-    int ret = blk_prw(blk, offset, buf, count, blk_read_entry, 0);
+    int ret = blk_prw(blk, offset, buf, bytes, blk_read_entry, 0);
     if (ret < 0) {
         return ret;
     }
-    return count;
+    return bytes;
 }
 
-int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int count,
-               BdrvRequestFlags flags)
+int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf,
+               int64_t bytes, BdrvRequestFlags flags)
 {
-    int ret = blk_prw(blk, offset, (void *) buf, count, blk_write_entry,
+    int ret = blk_prw(blk, offset, (void *) buf, bytes, blk_write_entry,
                       flags);
     if (ret < 0) {
         return ret;
     }
-    return count;
+    return bytes;
 }
 
 int64_t blk_getlength(BlockBackend *blk)
@@ -1567,7 +1568,7 @@ BlockAIOCB *blk_aio_ioctl(BlockBackend *blk, unsigned long int req, void *buf,
 
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static int coroutine_fn
-blk_do_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
+blk_do_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes)
 {
     int ret;
 
@@ -1591,14 +1592,15 @@ static void blk_aio_pdiscard_entry(void *opaque)
 }
 
 BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk,
-                             int64_t offset, int bytes,
+                             int64_t offset, int64_t bytes,
                              BlockCompletionFunc *cb, void *opaque)
 {
     return blk_aio_prwv(blk, offset, bytes, NULL, blk_aio_pdiscard_entry, 0,
                         cb, opaque);
 }
 
-int coroutine_fn blk_co_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
+int coroutine_fn blk_co_pdiscard(BlockBackend *blk, int64_t offset,
+                                 int64_t bytes)
 {
     int ret;
 
@@ -1618,7 +1620,7 @@ static void blk_pdiscard_entry(void *opaque)
     aio_wait_kick();
 }
 
-int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
+int blk_pdiscard(BlockBackend *blk, int64_t offset, int64_t bytes)
 {
     return blk_prw(blk, offset, NULL, bytes, blk_pdiscard_entry, 0);
 }
@@ -2123,16 +2125,16 @@ void *blk_aio_get(const AIOCBInfo *aiocb_info, BlockBackend *blk,
 }
 
 int coroutine_fn blk_co_pwrite_zeroes(BlockBackend *blk, int64_t offset,
-                                      int bytes, BdrvRequestFlags flags)
+                                      int64_t bytes, BdrvRequestFlags flags)
 {
     return blk_co_pwritev(blk, offset, bytes, NULL,
                           flags | BDRV_REQ_ZERO_WRITE);
 }
 
 int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
-                          int count)
+                          int64_t bytes)
 {
-    return blk_prw(blk, offset, (void *) buf, count, blk_write_entry,
+    return blk_prw(blk, offset, (void *) buf, bytes, blk_write_entry,
                    BDRV_REQ_WRITE_COMPRESSED);
 }
 
@@ -2358,7 +2360,7 @@ void blk_unregister_buf(BlockBackend *blk, void *host)
 
 int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                                    BlockBackend *blk_out, int64_t off_out,
-                                   int bytes, BdrvRequestFlags read_flags,
+                                   int64_t bytes, BdrvRequestFlags read_flags,
                                    BdrvRequestFlags write_flags)
 {
     int r;
-- 
2.21.0


