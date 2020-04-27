Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5A5C5519A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3C720728
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nsMs29Gr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3C720728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSz9l-0007Jk-Ga
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3g-0002gj-I1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3f-0007mw-Vv
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:08 -0400
Received: from mail-eopbgr70127.outbound.protection.outlook.com
 ([40.107.7.127]:7750 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3e-0007bA-4J; Mon, 27 Apr 2020 04:24:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frQUCe+Y1KyKNDcBB+SDkjzVKEpil4H1xvIZEdFqZeqmw4RujGk0HtQH3HupY9JJKxYqCG6ldJvKP3LcgEkMEmQaHcAidwRJ9zIpc6tMqUMbjJnNCDyViAK5aJzNvwI61WmKOVJpZw3+5xRvgJifCOqnZrgOxycTZSRsI2J+7uFpYphSBjUeOeJ2n0AqGHk6x8DsjPfm9XegekVdxuxRaCzz2xja4G+o47REWyulozOAr81y6d2oll4XzOeCcfeWupWZ00qXJXsJDtxunL1MMadxNDV2LVL3RQsnkEktV2oRnDMSgrZ3C8aoQeQ0woOfGVAD+lI5hxBdzQhiUpnQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSaFXlXVOS57WSXhpAw7+W1J4mxVR+36A1Js9dtRxQE=;
 b=eD3HZhIFxxHCtmHGLvOdZc5clmpvufcy4Ncpy+PM3IRteoH7EjMJHsV09vosvGpQVqSa8pMRabqvhM9Xj137momCjV1B+1U0DwP7xGlIgUiMHw/YZreRFFMfsZwQ1rXukavMmcJifvt1Ckr9ynZJW7pleZs/iUFlggiVwzXZMsDagzMgxA9IMewerg7IPN9GCsw5U1z8oOxyIzrLMhGxoakZowPOSKER4JaaTYB9ttF147vAg4b9BUWgQyYIPa5Ibz8E23XAGCvRdlo0XqHVI5u1uOy4etHeG+hqi4VCQP2tHEoNYKYPzHirEX+ja/iyFjzoRml0NZ8NybYOI1DdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSaFXlXVOS57WSXhpAw7+W1J4mxVR+36A1Js9dtRxQE=;
 b=nsMs29Grh9zXp1Kq46z36A1vD7bu5UTNEKPrFIqyoBvaJziuGGgC+GfXiCEfubbTSBGHHrYzgNqW+q7RBmLeJmC80+xhO9GMopyx2nUfAmdcOU3+lymTCuR5Algf/ZsIeq3kYfL24lhSEDSDU3eHQkxHP2qxZZzdQDjfFbI5y8U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:24:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:24:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 09/17] block/io: support int64_t bytes in bdrv_co_p{read,
 write}v_part()
Date: Mon, 27 Apr 2020 11:23:17 +0300
Message-Id: <20200427082325.10414-10-vsementsov@virtuozzo.com>
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
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:24:03 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f54d2e11-eb71-4c6a-3ecb-08d7ea8458ba
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5463A50DA3308D3AFAE1507DC1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:409;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(2906002)(81156014)(6486002)(26005)(8676002)(8936002)(4326008)(6916009)(478600001)(66556008)(7416002)(66946007)(66476007)(6666004)(16526019)(316002)(2616005)(1076003)(186003)(5660300002)(52116002)(6506007)(956004)(36756003)(107886003)(6512007)(69590400007)(86362001)(142933001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5prQGRIIeCzR8kTrG5+FuPDh6YVUlZdusfb8VdvONLmEB1yJlMgt7PxZihisy0i5qYEdFdl/ETNh00yz/WN+Jmvg7omQNFOe9C7d3SETicpnSAy2hNLTOl10lUm/BGy27UtBt3Q95trZqc68vWeqDD+o/h/Wt1kHRAfLk9w2GNPdsTG+aHw71osLMKIygpCM8zHvd0FjYjJm9rmIFH7pTDbFx5AOJACFVTMnr5YX8YI1AnWBd9b0ZeSjyEoabI4Qk/YTNFLk+qbOB70dW8cOkveHqBgZ8HCWZs+M+BNfyKSKz9m1V7iZ0LIMmj54LL0ksp6T8/YTyVWhWwTZzDnNWYcc3VryT0qMwOfJmLC2RCiFTU3F0vRfhGSx84d2HQDOslb3lcQc6U2UxnTwt+j7i80/48c/ZMMapzMKa9CuljmuCpYh6QuUfY7tx62twoFQovsKA8LxM7PEpCIcK72bpmRV6BsP43DXV/e6NZmlhijZeWyvbF4ydHCeYFvn9umGwres6JbwbB1mEHTFRWfKQ==
X-MS-Exchange-AntiSpam-MessageData: K8nhk/rwzmMQYsvrDDXs4nF+gyhNTJeWQOMo9jrDOrdMS6zn+bpEZsoEHF9c7tEIBrgc2vL2VQJ9hy1jZX0ywi6/32Bnf5XaPfaYkbDmZadnwpUOQpExI7PtUqcvPDb2rXVj0nDxrzEo9Ta8Z2l44TohKFLa2gD8OFdqGKaGPWVZxlPvvQxZhtenDAu3iCWgXVfyUJqPYKkzmbYMlJAxwYkhYWpB0d73ndw1WZOLFOVaJXzkpF/qGMTuKP0BKi3WIu45m7/l34/5ZgGwfbnDA8V5oFCV+0AystWU/hzJKlLzAShJtW0X/iZI2U7B1x8wliGiqemhL69fzIh89xohbnVUO4WLZnKLrULgoUeGOs5SQRgVQcyTuoAr1dahFOjXdr+Qv0WkOBYCt9T2NspVAdd0A7XO1ywRFClIomOHuH8NH5c6H8c/tYWqs6sI/KBJolSd+kh+gwH24lhk3iZN30JoMk/UAU5+Dj/aDrixdLHr+D/Y/5TdYmCTIb8QBiDXrazReiKXs/7no51zmpa3H0oFZdaT7OJqed9W+53cBDAeNiBhTybOW0cv/JGliRDxcc1TLwx4lWEF5SUYKozaz47CzopNnkij3stWtrAbx0FZEurVSU5zDgaNiM2X7gCU50AexZggMOx7VTAG9hyhtujOyqsco4Y1GFi/JzwyHv3ZsHAkOmeyQFVmL2Hefz3iepwYC/0//XBpdVy5UvVhz85AxbG4D/4YL0Gdx15HKbqq7PnHnLP7f41MF68c4YpocStQEq7xl53dcJy5dLVCuEYvD61rbqp6VY55bZZzjss=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54d2e11-eb71-4c6a-3ecb-08d7ea8458ba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:24:04.3110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdkxiQXv2ZAzSQaE78cEThkBmaAJllRkOJBUzAppHt5r7b2gPohteaKdqlokUUTH5rtrQjrI6vRUD9Kf0o4eUx5PrUUO/qrWYIJy6rwaQcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.7.127;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:24:00
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.127
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
on all io paths. Prepare bdrv_co_preadv_part() and
bdrv_co_pwritev_part() and their remaining dependencies now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  4 ++--
 block/io.c                | 12 ++++++------
 block/trace-events        |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index c8daba608b..3c2a1d741a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -975,13 +975,13 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes,
+    int64_t offset, int64_t bytes,
     QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
 int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes,
+    int64_t offset, int64_t bytes,
     QEMUIOVector *qiov, size_t qiov_offset, BdrvRequestFlags flags);
 
 static inline int coroutine_fn bdrv_co_pread(BdrvChild *child,
diff --git a/block/io.c b/block/io.c
index 70b51dbd0f..784eaf02f2 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1668,7 +1668,7 @@ static void bdrv_padding_destroy(BdrvRequestPadding *pad)
  */
 static bool bdrv_pad_request(BlockDriverState *bs,
                              QEMUIOVector **qiov, size_t *qiov_offset,
-                             int64_t *offset, unsigned int *bytes,
+                             int64_t *offset, int64_t *bytes,
                              BdrvRequestPadding *pad)
 {
     if (!bdrv_init_padding(bs, *offset, *bytes, pad)) {
@@ -1694,7 +1694,7 @@ int coroutine_fn bdrv_co_preadv(BdrvChild *child,
 }
 
 int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes,
+    int64_t offset, int64_t bytes,
     QEMUIOVector *qiov, size_t qiov_offset,
     BdrvRequestFlags flags)
 {
@@ -1703,7 +1703,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
     BdrvRequestPadding pad;
     int ret;
 
-    trace_bdrv_co_preadv(bs, offset, bytes, flags);
+    trace_bdrv_co_preadv_part(bs, offset, bytes, flags);
 
     ret = bdrv_check_byte_request(bs, offset, bytes);
     if (ret < 0) {
@@ -2033,7 +2033,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
 
 static int coroutine_fn bdrv_co_do_zero_pwritev(BdrvChild *child,
                                                 int64_t offset,
-                                                unsigned int bytes,
+                                                int64_t bytes,
                                                 BdrvRequestFlags flags,
                                                 BdrvTrackedRequest *req)
 {
@@ -2107,7 +2107,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
 }
 
 int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
-    int64_t offset, unsigned int bytes, QEMUIOVector *qiov, size_t qiov_offset,
+    int64_t offset, int64_t bytes, QEMUIOVector *qiov, size_t qiov_offset,
     BdrvRequestFlags flags)
 {
     BlockDriverState *bs = child->bs;
@@ -2116,7 +2116,7 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
     BdrvRequestPadding pad;
     int ret;
 
-    trace_bdrv_co_pwritev(child->bs, offset, bytes, flags);
+    trace_bdrv_co_pwritev_part(child->bs, offset, bytes, flags);
 
     if (!bs->drv) {
         return -ENOMEDIUM;
diff --git a/block/trace-events b/block/trace-events
index 179b47bf63..dd367a9b19 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -11,8 +11,8 @@ blk_root_attach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 blk_root_detach(void *child, void *blk, void *bs) "child %p blk %p bs %p"
 
 # io.c
-bdrv_co_preadv(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
-bdrv_co_pwritev(void *bs, int64_t offset, int64_t nbytes, unsigned int flags) "bs %p offset %"PRId64" nbytes %"PRId64" flags 0x%x"
+bdrv_co_preadv_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
+bdrv_co_pwritev_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int count, int flags) "bs %p offset %"PRId64" count %d flags 0x%x"
 bdrv_co_do_copy_on_readv(void *bs, int64_t offset, int64_t bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %" PRId64 " bytes %" PRId64 " cluster_offset %" PRId64 " cluster_bytes %" PRId64
 bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
-- 
2.21.0


