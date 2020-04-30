Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB470C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C012076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PX1Hz063"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C012076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7Ih-0006Fd-OP
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78h-0007Dx-S3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78K-0005Qb-GL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:59 -0400
Received: from mail-eopbgr70120.outbound.protection.outlook.com
 ([40.107.7.120]:6058 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU761-0003ZE-Pz; Thu, 30 Apr 2020 07:11:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czPzxvBdKVNSF3pRcvihWlkRjml01Ib/bMDpfcSeM8VAGzG2GrKQw/8RdwEhRcFi0uGlWuVX2A1VC+x0liKogieKVITeGfnQcnc+2rhQGFfyM6MfyumKrlkEJ3oj+yf3+uK8RUI1Wje8tZKsghIG2pYGaPaUigo4lAk+oGdVeMMXxDwjIfa+qwKoeJH0L/bAQ1c4ZyCMgzzg7rS5c+0bkdwDXXOkX8fr47I3W3lyUlXRRbjRBapjwAOYwIclZS7pivo7O80THahwgDXdNqdc/XKspHkuxk3gu1bdqNPlvUYvRQm7IfDIHv7gde1zqgEusXO24K7jOzeJWxq1NQ1b+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQgyQIl/97Xztt4TT3uchoaV2bXyusN1mPYn+I5K4ZY=;
 b=FYKoODsi8SHCnXIfzVnfvQJVV3wapC77W8Gv9GIJCLxs0bVy8zZT+r5qDHSGPs5Xm1/V/1hbFkt0qU39pc/Gb6M8n+32/afc6Qt7/sYUbMqMajpbXbb1Czz810o4CA1EJS54hpH4msKsZBirai1Q8pOkPvj73wVMRrZO0Q+KJbiDFPjCFmkkXaZ7ruquxKyq6gBHxP1crpR7zv5eGQuZGEvjEXYRes5KPqGaf9tzzu85bvcJQir5dkrl29Qtm13styeM8LR+LS8n29YgDkGkkogY/KosJ7AWAhnWCcg75Y+NpvTn+VNDyFwRRPpqnFinXBHLbEcUHh8QVoKo7pfTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQgyQIl/97Xztt4TT3uchoaV2bXyusN1mPYn+I5K4ZY=;
 b=PX1Hz063DVrmCv1WBfhiQ2WQ5t/leWVlkbu/9u33kNSC1ofy3pJ0G58NgBZfOyjPBbQbUltodWfbVuMgHJfR2sNguFzP3k86YZs7Bo1H4VYmET8tmfG/igc82lrRFU2hke/kkvTtZMHeZDlxPS9DLDiUHp/yJHrOn+AhN8w9wV4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5399.eurprd08.prod.outlook.com (2603:10a6:20b:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 11:11:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:11:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 15/17] block: use int64_t instead of uint64_t in copy_range
 driver handlers
Date: Thu, 30 Apr 2020 14:10:31 +0300
Message-Id: <20200430111033.29980-16-vsementsov@virtuozzo.com>
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
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:11:09 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6118a362-77ad-4b04-9d64-08d7ecf7302a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5399463847D001CA59CC86FBC1AA0@AM7PR08MB5399.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3BdQeDlTlzNHfb9Jfg01hcMU7qLveEO83NJTOlwUqU4NcW8sEQqq85XO0twAT+iE8tzfRbMClC69YSlubPoMtOnuDADYpYTYKZW54LldIdi+fLX9flmlLSKOUgcLCBRjGfBTWpg8i/9CjM/6yrCHvP5dPVzruY95qFbxYid7RaVdLtlVAmiP0XLbu2X52dlkaFECz1ylUVGrKcUVTstFJFKMgZ+7kCIU6x9o8XQBMzBMvUsAKgFwpsmS7nkC/B0sMB/28Qjg0m1WISxWQ2Zd6tV3ePHIqkkt2gnxNrw1TANQcTsW44OAqP0u1Y+0hQx9z4hvaEGuSHwSetYJTDBSitvv0CodueA8jT4pU3LAnsvCgQhI5czgbuFtWgc8CR5637iUa8SsSO3gFZ6OC7pOVQ3uIS+BU+xL7dFe5YsmqoTGuQumN4ySEA4VavOGc1/h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(396003)(366004)(346002)(136003)(376002)(1076003)(36756003)(478600001)(8936002)(26005)(6512007)(7416002)(5660300002)(107886003)(6486002)(66476007)(66556008)(86362001)(6916009)(6506007)(6666004)(8676002)(316002)(2906002)(186003)(66946007)(16526019)(2616005)(956004)(4326008)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dp+oxKhEuSOk+6C6/029g3l25ppK5x0YUxfbBygkbOB0EumECIuBbDgQq+bvI0KwTKf0R6nZiyUV4K022BrGGpcgQruid4CCFuJBpuxG4rlv/LFixFRsJu/8OmHVUEmIPdajpvR6QAKyBG3hRA5TrRWLHHDDjXimRS6PQdjpm+nOdn53BeNtwYsE26H6SXthT6pLAhaeBTRmdpxxb3MBtlvjQEOwGjtnZOAQDqe06TvCP2SCgsEC+Tu04gPi2XOUy0kQxjGhcs2AeWT804mW5Eu/DOCdnTxjBV6Rm5v/rHEgsXm1ieDJIDyLO0VR2H2TOTuT7rM/BcA7KNgBl/Le+eLVoSxBvX+iAVQrM9GFUsKIL4Xeua6FWcSFXhcfeeBF6CpcNzR/4JkOHp5tO3ckKhFVgaPDEjHwVcdX0dwVk7ZbSTo79FoCl8DSk5xXjV74+0sx4CrUFrQpNvY92OBwzJ8JNe9yhaZuj1XQLAY3HCJZjy+Ah7vlz+yHFEnwAZvFwfz9iao88TPou8K2gCL69/EpEfLu+YUYtO6xsR+kwVKu7QwxQ367rXHJtIk/+sP5AGADlqZ059nczNzOk4tS4krG5kTvLiVAlR+zZ/T19eYo9SRubPgGk5JqmSkVrzQ4KqibCAvGoj5MtRIWmbw23eYUdxUoFB1Uv0wmdYS4P+mmpeLxweDyzAdW2jTVprPdl4vjES+C5pzaa9XuvP3u3AUTUuawNP9RpTR8VL57Lq3ONIlerkMceWUCAWnCK8bAUIUjTMgnoMt0QyXx465Ykz4k0sVBtN/8TLismHC7z7g=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6118a362-77ad-4b04-9d64-08d7ecf7302a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:11:10.7700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wM/Ag49DemOmZuXlHOvktJODfSAykmmJwSi51l6b77VJwc9R40Lk4VSak5vc01mmByyX3YkV0ejsSUDsaA2lf3SaiqGpPA4Qsrshc13xJps=
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

So, convert driver copy_range handlers parameters which are already
64bit to signed type.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h | 12 ++++++------
 block/file-posix.c        | 10 +++++-----
 block/iscsi.c             | 12 ++++++------
 block/qcow2.c             | 12 ++++++------
 block/raw-format.c        | 16 ++++++++--------
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 9e8819bc28..3f08baeff0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -259,10 +259,10 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_copy_range_from)(BlockDriverState *bs,
                                                 BdrvChild *src,
-                                                uint64_t offset,
+                                                int64_t offset,
                                                 BdrvChild *dst,
-                                                uint64_t dst_offset,
-                                                uint64_t bytes,
+                                                int64_t dst_offset,
+                                                int64_t bytes,
                                                 BdrvRequestFlags read_flags,
                                                 BdrvRequestFlags write_flags);
 
@@ -276,10 +276,10 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_copy_range_to)(BlockDriverState *bs,
                                               BdrvChild *src,
-                                              uint64_t src_offset,
+                                              int64_t src_offset,
                                               BdrvChild *dst,
-                                              uint64_t dst_offset,
-                                              uint64_t bytes,
+                                              int64_t dst_offset,
+                                              int64_t bytes,
                                               BdrvRequestFlags read_flags,
                                               BdrvRequestFlags write_flags);
 
diff --git a/block/file-posix.c b/block/file-posix.c
index 2c21f785b4..38c1398494 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3034,8 +3034,8 @@ static void raw_abort_perm_update(BlockDriverState *bs)
 }
 
 static int coroutine_fn raw_co_copy_range_from(
-        BlockDriverState *bs, BdrvChild *src, uint64_t src_offset,
-        BdrvChild *dst, uint64_t dst_offset, uint64_t bytes,
+        BlockDriverState *bs, BdrvChild *src, int64_t src_offset,
+        BdrvChild *dst, int64_t dst_offset, int64_t bytes,
         BdrvRequestFlags read_flags, BdrvRequestFlags write_flags)
 {
     return bdrv_co_copy_range_to(src, src_offset, dst, dst_offset, bytes,
@@ -3044,10 +3044,10 @@ static int coroutine_fn raw_co_copy_range_from(
 
 static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
                                              BdrvChild *src,
-                                             uint64_t src_offset,
+                                             int64_t src_offset,
                                              BdrvChild *dst,
-                                             uint64_t dst_offset,
-                                             uint64_t bytes,
+                                             int64_t dst_offset,
+                                             int64_t bytes,
                                              BdrvRequestFlags read_flags,
                                              BdrvRequestFlags write_flags)
 {
diff --git a/block/iscsi.c b/block/iscsi.c
index 0b4b7210df..861a70c823 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2180,10 +2180,10 @@ static void coroutine_fn iscsi_co_invalidate_cache(BlockDriverState *bs,
 
 static int coroutine_fn iscsi_co_copy_range_from(BlockDriverState *bs,
                                                  BdrvChild *src,
-                                                 uint64_t src_offset,
+                                                 int64_t src_offset,
                                                  BdrvChild *dst,
-                                                 uint64_t dst_offset,
-                                                 uint64_t bytes,
+                                                 int64_t dst_offset,
+                                                 int64_t bytes,
                                                  BdrvRequestFlags read_flags,
                                                  BdrvRequestFlags write_flags)
 {
@@ -2321,10 +2321,10 @@ static void iscsi_xcopy_data(struct iscsi_data *data,
 
 static int coroutine_fn iscsi_co_copy_range_to(BlockDriverState *bs,
                                                BdrvChild *src,
-                                               uint64_t src_offset,
+                                               int64_t src_offset,
                                                BdrvChild *dst,
-                                               uint64_t dst_offset,
-                                               uint64_t bytes,
+                                               int64_t dst_offset,
+                                               int64_t bytes,
                                                BdrvRequestFlags read_flags,
                                                BdrvRequestFlags write_flags)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index ce1c123cb7..15a6d3c6ef 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3810,9 +3810,9 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
 
 static int coroutine_fn
 qcow2_co_copy_range_from(BlockDriverState *bs,
-                         BdrvChild *src, uint64_t src_offset,
-                         BdrvChild *dst, uint64_t dst_offset,
-                         uint64_t bytes, BdrvRequestFlags read_flags,
+                         BdrvChild *src, int64_t src_offset,
+                         BdrvChild *dst, int64_t dst_offset,
+                         int64_t bytes, BdrvRequestFlags read_flags,
                          BdrvRequestFlags write_flags)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -3891,9 +3891,9 @@ out:
 
 static int coroutine_fn
 qcow2_co_copy_range_to(BlockDriverState *bs,
-                       BdrvChild *src, uint64_t src_offset,
-                       BdrvChild *dst, uint64_t dst_offset,
-                       uint64_t bytes, BdrvRequestFlags read_flags,
+                       BdrvChild *src, int64_t src_offset,
+                       BdrvChild *dst, int64_t dst_offset,
+                       int64_t bytes, BdrvRequestFlags read_flags,
                        BdrvRequestFlags write_flags)
 {
     BDRVQcow2State *s = bs->opaque;
diff --git a/block/raw-format.c b/block/raw-format.c
index 3a393a31c7..fdf024705b 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -507,16 +507,16 @@ static int raw_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
 
 static int coroutine_fn raw_co_copy_range_from(BlockDriverState *bs,
                                                BdrvChild *src,
-                                               uint64_t src_offset,
+                                               int64_t src_offset,
                                                BdrvChild *dst,
-                                               uint64_t dst_offset,
-                                               uint64_t bytes,
+                                               int64_t dst_offset,
+                                               int64_t bytes,
                                                BdrvRequestFlags read_flags,
                                                BdrvRequestFlags write_flags)
 {
     int ret;
 
-    ret = raw_adjust_offset(bs, (int64_t *)&src_offset, bytes, false);
+    ret = raw_adjust_offset(bs, &src_offset, bytes, false);
     if (ret) {
         return ret;
     }
@@ -526,16 +526,16 @@ static int coroutine_fn raw_co_copy_range_from(BlockDriverState *bs,
 
 static int coroutine_fn raw_co_copy_range_to(BlockDriverState *bs,
                                              BdrvChild *src,
-                                             uint64_t src_offset,
+                                             int64_t src_offset,
                                              BdrvChild *dst,
-                                             uint64_t dst_offset,
-                                             uint64_t bytes,
+                                             int64_t dst_offset,
+                                             int64_t bytes,
                                              BdrvRequestFlags read_flags,
                                              BdrvRequestFlags write_flags)
 {
     int ret;
 
-    ret = raw_adjust_offset(bs, (int64_t *)&dst_offset, bytes, true);
+    ret = raw_adjust_offset(bs, &dst_offset, bytes, true);
     if (ret) {
         return ret;
     }
-- 
2.21.0


