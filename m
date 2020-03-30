Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F8C2D0E5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E462073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="tEEqZD13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E462073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIvHJ-0003uI-Hg
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 10:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jIvFX-0001wH-Ht
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jIvFV-0005Ji-2N
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 10:18:47 -0400
Received: from mail-eopbgr00093.outbound.protection.outlook.com
 ([40.107.0.93]:10996 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jIvFQ-0005Ce-2Z; Mon, 30 Mar 2020 10:18:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBTxQXK/kmH7EIsoQ2f+sDAfQbLSxmBichgvJj72YzWXlPmLNM/D3RnIl2sNBV26bZmYkUuhh/LUkOGR5UoPZOOZLPvtB/LREh51Dia84z1whExhE95FACHdrpIaEQn5OeibOmhxm16vy/oblRQ+iAec3Ezx06v+Td0QHB+uxzTdclf0xHZDtyA4dDM2ZcrMIOE82gr7u++zKo7DWJLrDLfZ/m5auL3MqDhonnW2jKl+cs5V3bGM3221U57WN7ArJBS7oCfOKzl0jbWtfCCuBG7BzJkQqxwmmNnvwY77ocJuuROZX8TwyevOhNrNMk5H3PbsX93oYbBHVQD0luzEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0+rpNvN4Wv2+2s8RQMqgsggenc75lXA8PNQkk5JJow=;
 b=IDr0PdM9TG5Fg1d5rYCbLnQCTkGyg4Q2NIa7PGeG9YaZtMDH1/wQSTbwTJfUqyO3F4uHre/Dnaxi3V/HK5bvFJMmlaAFfmCL2geB7gvSkMmgAg/zd0KphlrJrICQj4gbpmIf1gDDCpdYb06htk2YSIOSPoBcJj1+UgZkWxvT/+pjX2TbbSj0Ri3+EPHiML/Lsc8sL9D3sOCw01xa0IWqZ0l2c/jbva1B2TzPk6hITHy+fOMpv1QaVbAS4ll7bfsmn4jrbQPjjDFZy/YdS10/4EvltTRxwQKicaesIjbAEkyuIcOyC5Vv6utSPRq9Lb6zT1x0R7Es3ITTRlbZtQyHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0+rpNvN4Wv2+2s8RQMqgsggenc75lXA8PNQkk5JJow=;
 b=tEEqZD13qby9Mc+yZ+CghdtT/iYGHRzTfWqPeYaIabirHG2WF0kEQc4t+ocJS0AcDVF3xlRT8r+qky8zHZjhLW1oFnaOYFjYVllYuXfbdsnTZtwqLuGmMwl0BtPr8eqcO26WcyHLqnIOP1GOdRssqpK+GV3P7tmQJfZHh90ldNE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5319.eurprd08.prod.outlook.com (10.141.175.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 14:18:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::3944:477e:1562:cfcf%9]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 14:18:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/3] block/io: convert generic io path to use int64_t
 parameters
Date: Mon, 30 Mar 2020 17:18:17 +0300
Message-ID: <20200330141818.31294-3-vsementsov@virtuozzo.com>
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
 15.20.2856.20 via Frontend Transport; Mon, 30 Mar 2020 14:18:38 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.14]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66e09efc-b5b6-4a6c-f006-08d7d4b53df2
X-MS-TrafficTypeDiagnostic: AM7PR08MB5319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5319A6AA4C104857AAA65274C1CB0@AM7PR08MB5319.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:250;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(376002)(366004)(396003)(39840400004)(136003)(36756003)(30864003)(2906002)(8676002)(6666004)(1076003)(6486002)(6506007)(4326008)(107886003)(81166006)(81156014)(8936002)(6512007)(52116002)(6916009)(86362001)(316002)(7416002)(5660300002)(478600001)(26005)(66556008)(2616005)(16526019)(956004)(66946007)(186003)(66476007)(41533002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjNf+sGQCIvsEhSyCTb8z6KQVVHdRvFuCKFMoiDKfZg29RSnEgF1WqDIAHcRTYrDUkY2mDSiE2wN0Yc/OV5iKG1zsk/MSX3H75LTExVKANvQvfU1Oi+OOuBHzXAyR3ipo4EjdZrP+Co/gknqw+HXX0+9un04nIWK0RERpFEeXlyHc3EO7kuY9saKKrNXZNA085uFBUIxTOMLlRnCSeiYDYdnybbx1HeCxcrIahp3s+BC0iUprk4orKQQ87oa9GEYZn/cRfRz/Fm/sUpeCJV7H6YPg48I5ZKc8deUvcPm5R1FiM/QwlUPLECMrtQ6rjL/d8+S6kNa1EfwDVpa699M1d8usFqOGtvA1/GWNvw4OKaE6XUBhrjWRZQeGjDGRhzcEt3YMa1xb9mxWfd6eZWrrG7hA0Rbf8JDcrGNf02L8DrAh21NO496lCZPO1eW/iz2LzOJkW0c4OeZJAHrXcU26ISworK3NDniR54bRIyzsdrYZySzR3GaMbdFCdgim/dr
X-MS-Exchange-AntiSpam-MessageData: 3/CMFY1YMM/XAUDuMuyN2MAR7sdAOB19Tlf4/bTU6V1qJUnKUue58TOleItxz1WGZAn2IXcLYmlXJPpKMHE0xDx3TIvdfK6vtDsY7DZJ/cwJ7C0D23bDjeUxowLxs9teK2/Ce4zwgRQNyxyLxQ0jYQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e09efc-b5b6-4a6c-f006-08d7d4b53df2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 14:18:39.1487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtmQHvnz+7rByyE/zb9otjvnAypw7GFKNooZ238wLrIAPhv7+vp4qbu/f2xERr141Y0IV/RqK76H7sa3Ff99UAXbixwF6T4ALfuQuiOjYv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5319
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.0.93
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

We are generally moving to int64_t for both offset and bytes paramaters
on all io paths. Convert generic io path now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h     |  8 ++--
 include/block/block_int.h | 20 ++++-----
 block/blkverify.c         |  2 +-
 block/io.c                | 86 +++++++++++++++++++--------------------
 block/trace-events        | 12 +++---
 5 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index b05995fe9c..fa5c7285b6 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -333,7 +333,7 @@ int bdrv_pwrite_sync(BdrvChild *child, int64_t offset,
  * because it may allocate memory for the entire region.
  */
 int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                                       int bytes, BdrvRequestFlags flags);
+                                       int64_t bytes, BdrvRequestFlags fla=
gs);
 BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     const char *backing_file);
 void bdrv_refresh_filename(BlockDriverState *bs);
@@ -731,8 +731,8 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *ho=
st);
  *
  * Returns: 0 if succeeded; negative error code if failed.
  **/
-int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
-                                    BdrvChild *dst, uint64_t dst_offset,
-                                    uint64_t bytes, BdrvRequestFlags read_=
flags,
+int coroutine_fn bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
+                                    BdrvChild *dst, int64_t dst_offset,
+                                    int64_t bytes, BdrvRequestFlags read_f=
lags,
                                     BdrvRequestFlags write_flags);
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index c8daba608b..28aea2bcfd 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -972,16 +972,16 @@ extern BlockDriver bdrv_raw;
 extern BlockDriver bdrv_qcow2;
=20
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes,
+    int64_t offset, int64_t bytes,
     QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes,
+    int64_t offset, int64_t bytes,
     QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
=20
 static inline int coroutine_fn bdrv_co_pread(BdrvChild *child,
@@ -1315,14 +1315,14 @@ void bdrv_dec_in_flight(BlockDriverState *bs);
=20
 void blockdev_close_all_bdrv_states(void);
=20
-int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offs=
et,
-                                         BdrvChild *dst, uint64_t dst_offs=
et,
-                                         uint64_t bytes,
+int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, int64_t src_offse=
t,
+                                         BdrvChild *dst, int64_t dst_offse=
t,
+                                         int64_t bytes,
                                          BdrvRequestFlags read_flags,
                                          BdrvRequestFlags write_flags);
-int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset=
,
-                                       BdrvChild *dst, uint64_t dst_offset=
,
-                                       uint64_t bytes,
+int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, int64_t src_offset,
+                                       BdrvChild *dst, int64_t dst_offset,
+                                       int64_t bytes,
                                        BdrvRequestFlags read_flags,
                                        BdrvRequestFlags write_flags);
=20
diff --git a/block/blkverify.c b/block/blkverify.c
index ba6b1853ae..667e60d832 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -31,7 +31,7 @@ typedef struct BlkverifyRequest {
     uint64_t bytes;
     int flags;
=20
-    int (*request_fn)(BdrvChild *, int64_t, unsigned int, QEMUIOVector *,
+    int (*request_fn)(BdrvChild *, int64_t, int64_t, QEMUIOVector *,
                       BdrvRequestFlags);
=20
     int ret;                    /* test image result */
diff --git a/block/io.c b/block/io.c
index 7cbb80bd24..79e3014489 100644
--- a/block/io.c
+++ b/block/io.c
@@ -42,7 +42,7 @@
=20
 static void bdrv_parent_cb_resize(BlockDriverState *bs);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags);
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags);
=20
 static void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ign=
ore,
                                       bool ignore_bds_parents)
@@ -875,9 +875,9 @@ static bool coroutine_fn bdrv_wait_serialising_requests=
(BdrvTrackedRequest *self
 }
=20
 static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
-                                   size_t size)
+                                   int64_t bytes)
 {
-    if (size > BDRV_REQUEST_MAX_BYTES) {
+    if (offset < 0 || bytes < 0 || bytes > BDRV_REQUEST_MAX_BYTES) {
         return -EIO;
     }
=20
@@ -885,10 +885,6 @@ static int bdrv_check_byte_request(BlockDriverState *b=
s, int64_t offset,
         return -ENOMEDIUM;
     }
=20
-    if (offset < 0) {
-        return -EIO;
-    }
-
     return 0;
 }
=20
@@ -1086,7 +1082,7 @@ static void bdrv_co_io_em_complete(void *opaque, int =
ret)
 }
=20
 static int coroutine_fn bdrv_driver_preadv(BlockDriverState *bs,
-                                           uint64_t offset, uint64_t bytes=
,
+                                           int64_t offset, int64_t bytes,
                                            QEMUIOVector *qiov,
                                            size_t qiov_offset, int flags)
 {
@@ -1155,7 +1151,7 @@ out:
 }
=20
 static int coroutine_fn bdrv_driver_pwritev(BlockDriverState *bs,
-                                            uint64_t offset, uint64_t byte=
s,
+                                            int64_t offset, int64_t bytes,
                                             QEMUIOVector *qiov,
                                             size_t qiov_offset, int flags)
 {
@@ -1235,8 +1231,8 @@ emulate_flags:
 }
=20
 static int coroutine_fn
-bdrv_driver_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
-                               uint64_t bytes, QEMUIOVector *qiov,
+bdrv_driver_pwritev_compressed(BlockDriverState *bs, int64_t offset,
+                               int64_t bytes, QEMUIOVector *qiov,
                                size_t qiov_offset)
 {
     BlockDriver *drv =3D bs->drv;
@@ -1268,7 +1264,7 @@ bdrv_driver_pwritev_compressed(BlockDriverState *bs, =
uint64_t offset,
 }
=20
 static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
-        int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+        int64_t offset, int64_t bytes, QEMUIOVector *qiov,
         size_t qiov_offset, int flags)
 {
     BlockDriverState *bs =3D child->bs;
@@ -1430,16 +1426,17 @@ err:
  * reads; any other features must be implemented by the caller.
  */
 static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
-    BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
+    BdrvTrackedRequest *req, int64_t offset, int64_t bytes,
     int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BlockDriverState *bs =3D child->bs;
     int64_t total_bytes, max_bytes;
     int ret =3D 0;
-    uint64_t bytes_remaining =3D bytes;
+    int64_t bytes_remaining =3D bytes;
     int max_transfer;
=20
     assert(is_power_of_2(align));
+    assert(offset >=3D 0 && bytes >=3D 0);
     assert((offset & (align - 1)) =3D=3D 0);
     assert((bytes & (align - 1)) =3D=3D 0);
     assert((bs->open_flags & BDRV_O_NO_IO) =3D=3D 0);
@@ -1590,13 +1587,13 @@ static int bdrv_padding_rmw_read(BdrvChild *child,
 {
     QEMUIOVector local_qiov;
     BlockDriverState *bs =3D child->bs;
-    uint64_t align =3D bs->bl.request_alignment;
+    int64_t align =3D bs->bl.request_alignment;
     int ret;
=20
     assert(req->serialising && pad->buf);
=20
     if (pad->head || pad->merge_reads) {
-        uint64_t bytes =3D pad->merge_reads ? pad->buf_len : align;
+        int64_t bytes =3D pad->merge_reads ? pad->buf_len : align;
=20
         qemu_iovec_init_buf(&local_qiov, pad->buf, bytes);
=20
@@ -1667,7 +1664,7 @@ static void bdrv_padding_destroy(BdrvRequestPadding *=
pad)
  */
 static bool bdrv_pad_request(BlockDriverState *bs,
                              QEMUIOVector **qiov, size_t *qiov_offset,
-                             int64_t *offset, unsigned int *bytes,
+                             int64_t *offset, int64_t *bytes,
                              BdrvRequestPadding *pad)
 {
     if (!bdrv_init_padding(bs, *offset, *bytes, pad)) {
@@ -1686,14 +1683,14 @@ static bool bdrv_pad_request(BlockDriverState *bs,
 }
=20
 int coroutine_fn bdrv_co_preadv(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags)
 {
     return bdrv_co_preadv_part(child, offset, bytes, qiov, 0, flags);
 }
=20
 int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes,
+    int64_t offset, int64_t bytes,
     QEMUIOVector *qiov, size_t qiov_offset,
     BdrvRequestFlags flags)
 {
@@ -1702,7 +1699,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child=
,
     BdrvRequestPadding pad;
     int ret;
=20
-    trace_bdrv_co_preadv(bs, offset, bytes, flags);
+    trace_bdrv_co_preadv_part(bs, offset, bytes, flags);
=20
     ret =3D bdrv_check_byte_request(bs, offset, bytes);
     if (ret < 0) {
@@ -1743,7 +1740,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child=
,
 }
=20
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
-    int64_t offset, int bytes, BdrvRequestFlags flags)
+    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
 {
     BlockDriver *drv =3D bs->drv;
     QEMUIOVector qiov;
@@ -1773,7 +1770,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bloc=
kDriverState *bs,
     assert(max_write_zeroes >=3D bs->bl.request_alignment);
=20
     while (bytes > 0 && !ret) {
-        int num =3D bytes;
+        int64_t num =3D bytes;
=20
         /* Align request.  Block drivers can expect the "bulk" of the requ=
est
          * to be aligned, and that unaligned requests do not cross cluster
@@ -1799,6 +1796,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bloc=
kDriverState *bs,
         ret =3D -ENOTSUP;
         /* First try the efficient write zeroes operation */
         if (drv->bdrv_co_pwrite_zeroes) {
+            assert(num <=3D INT_MAX);
             ret =3D drv->bdrv_co_pwrite_zeroes(bs, offset, num,
                                              flags & bs->supported_zero_fl=
ags);
             if (ret !=3D -ENOTSUP && (flags & BDRV_REQ_FUA) &&
@@ -1854,7 +1852,7 @@ fail:
 }
=20
 static inline int coroutine_fn
-bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes=
,
+bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, int64_t bytes,
                           BdrvTrackedRequest *req, int flags)
 {
     BlockDriverState *bs =3D child->bs;
@@ -1906,7 +1904,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t o=
ffset, uint64_t bytes,
 }
=20
 static inline void coroutine_fn
-bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, uint64_t bytes,
+bdrv_co_write_req_finish(BdrvChild *child, int64_t offset, int64_t bytes,
                          BdrvTrackedRequest *req, int ret)
 {
     int64_t end_sector =3D DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
@@ -1948,14 +1946,14 @@ bdrv_co_write_req_finish(BdrvChild *child, int64_t =
offset, uint64_t bytes,
  * after possibly fragmenting it.
  */
 static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
-    BdrvTrackedRequest *req, int64_t offset, unsigned int bytes,
+    BdrvTrackedRequest *req, int64_t offset, int64_t bytes,
     int64_t align, QEMUIOVector *qiov, size_t qiov_offset, int flags)
 {
     BlockDriverState *bs =3D child->bs;
     BlockDriver *drv =3D bs->drv;
     int ret;
=20
-    uint64_t bytes_remaining =3D bytes;
+    int64_t bytes_remaining =3D bytes;
     int max_transfer;
=20
     if (!drv) {
@@ -1967,6 +1965,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChil=
d *child,
     }
=20
     assert(is_power_of_2(align));
+    assert(offset >=3D 0);
+    assert(bytes >=3D 0);
     assert((offset & (align - 1)) =3D=3D 0);
     assert((bytes & (align - 1)) =3D=3D 0);
     assert(!qiov || qiov_offset + bytes <=3D qiov->size);
@@ -2030,7 +2030,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChil=
d *child,
=20
 static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
                                                 int64_t offset,
-                                                unsigned int bytes,
+                                                int64_t bytes,
                                                 BdrvRequestFlags flags,
                                                 BdrvTrackedRequest *req)
 {
@@ -2067,7 +2067,7 @@ static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvC=
hild *child,
     assert(!bytes || (offset & (align - 1)) =3D=3D 0);
     if (bytes >=3D align) {
         /* Write the aligned part in the middle. */
-        uint64_t aligned_bytes =3D bytes & ~(align - 1);
+        int64_t aligned_bytes =3D bytes & ~(align - 1);
         ret =3D bdrv_aligned_pwritev(child, req, offset, aligned_bytes, al=
ign,
                                    NULL, 0, flags);
         if (ret < 0) {
@@ -2097,14 +2097,14 @@ out:
  * Handle a write request in coroutine context
  */
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags)
 {
     return bdrv_co_pwritev_part(child, offset, bytes, qiov, 0, flags);
 }
=20
 int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_of=
fset,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, size_t qiov_offset,
     BdrvRequestFlags flags)
 {
     BlockDriverState *bs =3D child->bs;
@@ -2113,7 +2113,7 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *chil=
d,
     BdrvRequestPadding pad;
     int ret;
=20
-    trace_bdrv_co_pwritev(child->bs, offset, bytes, flags);
+    trace_bdrv_co_pwritev_part(child->bs, offset, bytes, flags);
=20
     if (!bs->drv) {
         return -ENOMEDIUM;
@@ -2174,7 +2174,7 @@ out:
 }
=20
 int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
-                                       int bytes, BdrvRequestFlags flags)
+                                       int64_t bytes, BdrvRequestFlags fla=
gs)
 {
     trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
=20
@@ -3205,8 +3205,8 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *=
host)
 }
=20
 static int coroutine_fn bdrv_co_copy_range_internal(
-        BdrvChild *src, uint64_t src_offset, BdrvChild *dst,
-        uint64_t dst_offset, uint64_t bytes,
+        BdrvChild *src, int64_t src_offset, BdrvChild *dst,
+        int64_t dst_offset, int64_t bytes,
         BdrvRequestFlags read_flags, BdrvRequestFlags write_flags,
         bool recurse_src)
 {
@@ -3284,9 +3284,9 @@ static int coroutine_fn bdrv_co_copy_range_internal(
  *
  * See the comment of bdrv_co_copy_range for the parameter and return valu=
e
  * semantics. */
-int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offs=
et,
-                                         BdrvChild *dst, uint64_t dst_offs=
et,
-                                         uint64_t bytes,
+int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, int64_t src_offse=
t,
+                                         BdrvChild *dst, int64_t dst_offse=
t,
+                                         int64_t bytes,
                                          BdrvRequestFlags read_flags,
                                          BdrvRequestFlags write_flags)
 {
@@ -3300,9 +3300,9 @@ int coroutine_fn bdrv_co_copy_range_from(BdrvChild *s=
rc, uint64_t src_offset,
  *
  * See the comment of bdrv_co_copy_range for the parameter and return valu=
e
  * semantics. */
-int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset=
,
-                                       BdrvChild *dst, uint64_t dst_offset=
,
-                                       uint64_t bytes,
+int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, int64_t src_offset,
+                                       BdrvChild *dst, int64_t dst_offset,
+                                       int64_t bytes,
                                        BdrvRequestFlags read_flags,
                                        BdrvRequestFlags write_flags)
 {
@@ -3312,9 +3312,9 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src=
, uint64_t src_offset,
                                        bytes, read_flags, write_flags, fal=
se);
 }
=20
-int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
-                                    BdrvChild *dst, uint64_t dst_offset,
-                                    uint64_t bytes, BdrvRequestFlags read_=
flags,
+int coroutine_fn bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
+                                    BdrvChild *dst, int64_t dst_offset,
+                                    int64_t bytes, BdrvRequestFlags read_f=
lags,
                                     BdrvRequestFlags write_flags)
 {
     return bdrv_co_copy_range_from(src, src_offset,
diff --git a/block/trace-events b/block/trace-events
index 29dff8881c..e4d68438af 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -11,12 +11,12 @@ blk_root_attach(void *child, void *blk, void *bs) "chil=
d %p blk %p bs %p"
 blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
=20
 # io.c
-bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flag=
s) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
-bdrv_co_pwritev(void *bs, int64_t offset, int64_t nbytes, unsigned int fla=
gs) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
-bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs =
%p offset %"PRId64" count %d flags 0x%x"
-bdrv_co_do_copy_on_readv(void *bs, int64_t offset, unsigned int bytes, int=
64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %"PRId64" bytes %=
u cluster_offset %"PRId64" cluster_bytes %"PRId64
-bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_=
t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offs=
et %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
-bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t =
dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset=
 %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
+bdrv_co_preadv_part(void *bs, int64_t offset, int64_t bytes, int flags) "b=
s %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
+bdrv_co_pwritev_part(void *bs, int64_t offset, int64_t bytes, int flags) "=
bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
+bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int64_t bytes, int flags) =
"bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
+bdrv_co_do_copy_on_readv(void *bs, int64_t offset, int64_t bytes, int64_t =
cluster_offset, int64_t cluster_bytes) "bs %p offset %" PRId64 " bytes %" P=
RId64 " cluster_offset %" PRId64 " cluster_bytes %" PRId64
+bdrv_co_copy_range_from(void *src, int64_t src_offset, void *dst, int64_t =
dst_offset, int64_t bytes, int read_flags, int write_flags) "src %p offset =
%" PRId64 " dst %p offset %" PRId64 " bytes %" PRId64 " rw flags 0x%x 0x%x"
+bdrv_co_copy_range_to(void *src, int64_t src_offset, void *dst, int64_t ds=
t_offset, int64_t bytes, int read_flags, int write_flags) "src %p offset %"=
 PRId64 " dst %p offset %" PRId64 " bytes %" PRId64 " rw flags 0x%x 0x%x"
=20
 # stream.c
 stream_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_alloc=
ated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
--=20
2.21.0


