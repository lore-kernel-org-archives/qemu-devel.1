Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8307C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611012080C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="aFM3M643"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611012080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzDD-0005t0-E6
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz4F-0004Em-Sp
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz4F-00025v-9u
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:24:43 -0400
Received: from mail-eopbgr00096.outbound.protection.outlook.com
 ([40.107.0.96]:55939 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3n-00081B-Ul; Mon, 27 Apr 2020 04:24:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWboXQTSYNvT3rTOJKg4g34XSysUjn+ppVDo8fZGmBZXOFfuRP3EdkQzkfSFBzWGH+ykdUNG9Q5AL6pTPOMTMyaAUN5p2OTP5BA4Veb4ckmx81W8L7ShNRN6rfDwWFZsA8PTngux03SlOebIyiKJqBVr71z1uFOnLMloHwhp6SjU1/kW1B+O03uTRC7k5RdU2xtV79d/+ejhwIbCGcZKgCXUPDj6T8Z87WBbHYSNJbMEI8rM72pU6tkuypjqqXtSBk4hYZgLdzrimXxsRIcNl2YtNjJYyuLyVhPdhTT2ALOGAPjwRCEubEASy7mBm8dMqxz7WW2htfRLkvOuoJI7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3dczDesqXlnvmLcNLNFaJcqNFnn15hJlFlTBgnchYM=;
 b=kmCHw0CijZAXdYZ+OhtzkEw92uHYYTKDsHi+FHU4Yyg75NSUAMjUroxyNH4VZ0uKmDOH5yUpTlqUCKY7UXT9FdKlS+ntHXUM88BLvyTzFe0p/wSXVcFQ6KIRjAIvz26mliL11A6GL2qwU6nEuqlmjuCzuwPrLxBQM68+HCM/1rUTuS1IZ4uGRWca96xwDoxtExOU24ed2t57SFT5A1ChbB0uzjPnx7T9X/civhVdi3StS01LJBYDzuvlgecF3zktVyefMe91s9wS3ux3/ljDHDOvxg7SNAXRkhoZ+I9B3OVdai5qkQsTHf736eIk8Grp/+cCc1YENEI3MUcflk8tSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3dczDesqXlnvmLcNLNFaJcqNFnn15hJlFlTBgnchYM=;
 b=aFM3M643v3CitmTCcvH361NFbsFu2truL2By4YqEy0ceBRTzvIGuybIPdDB1EPgnVxb4aTrxi6rtRk7is+NemEnQVcGKU/vd+l1HDhaCfRxkqAHi6C552D/Gl5olfKjJcxI4BMetZqiiEj16U+eCnTnywYmIdRFuTfKnwOkBG/Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5400.eurprd08.prod.outlook.com (2603:10a6:20b:109::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 08:24:12 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:24:12 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 15/17] block: use int64_t instead of uint64_t in copy_range
 driver handlers
Date: Mon, 27 Apr 2020 11:23:23 +0300
Message-Id: <20200427082325.10414-16-vsementsov@virtuozzo.com>
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
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:24:11 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4ddc97d-e2b5-45b7-fa66-08d7ea845dce
X-MS-TrafficTypeDiagnostic: AM7PR08MB5400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5400B796FC382D3D59A3E21FC1AF0@AM7PR08MB5400.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(107886003)(36756003)(956004)(2616005)(2906002)(4326008)(26005)(6512007)(6916009)(6486002)(5660300002)(6506007)(186003)(69590400007)(1076003)(8676002)(66946007)(498600001)(81156014)(52116002)(86362001)(7416002)(66556008)(6666004)(8936002)(66476007)(16526019);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OB9xwaMG4WRxqpLJGfZ1qtm5EZ4DuULkm+zsMSP3F2s6g/w81L8lGUTMBGFPqB1O0Vj5g0fo8ZEeEwCVJUOu5LSiaUdbLIy8jFuVdR++gxWt0msrgv/6RLyVLUfAdv7WDpA3Q3D+NL/Nitv/Bd4HHK92QsixhDEstGE+Qwi7s57bJGLZMYBuC6yZ9HeuMUoWbKix20zcMrq75mhVEPZH9WZa2qKMWr8grXlsdPuhedyMJ1pHcMIje+qWnmnnNSvODIJ5UiNFdmUYurIFqKUfm7x2UTeflYPkH0Fzw9E5xeyX7UvsDpu3EI/8MLYRdpPKjxepX8nNshXOG4dSjqPNf3LxAdcla5l44USGL6Pf50Dx08sw5/CiPCvqOrswRtqQgYaJ1HycCXHPKmzmLMd7wR5yQnJ9HzCxKt7Y3dVBWMm8XKCRa2lLAc7Z2IE5fQ578+7NXIDT9q0Sh1lpSBpYZ/ZION90E3gpLpLao0CwaXrAPrC7GfkSPtKqeTsZFT8p
X-MS-Exchange-AntiSpam-MessageData: eGLccI4yHPXty+eIkQOBDxYkVG+PbEtiW3+jcd4cR8RmgGCVdGDHLM1Z6pdZd9KHo4om5W59Sk0dByf4chgb9eWVPfmoUd2LJYsP/2ZXba8vPPn3htQRzzB5qEWzbRpwUtwE96AuU1LuXwTj7EwMMYfVxZGvoFOWHZDfyNhSi2uSFeqgk2gDCGRMnHVTw1hOnFKbjivPoQEOw0J1Opep5vC+l4hV9EEkWDYoBYg7+OxOpZvO3M3+Q4yRjUxI4VTmyzzK9/n9PVFJ/H7rZndMVCTy2iCJJcGgBIhmgof7M3MJCWf0TiGwMGuoUUnwzjZmGl3lUaK+wVIF16T1Kl2dTP1yGLTkpEBYeDOHWcOyyksXHFQ6aOd4Gm9f57gPeBhgCYe7AIkVnokZSnAKY+SRodEOrimwlVEjW2qUdIhxsY/kEbk/vcNbrDrWiE74EuXXPutlTacEAWTvzxAtFxOC3YTSdS/yFHH48l/noYFxycCxuW6aBHgeJudgk2rt7KDaGUM6XeQf+QFQsk3Cv4G8NWBwhEmoAz4qH1EZJ7OQU57+CMn8fg4rymTWOiC/rQtCsfA/pz+lb6jRWQz5ewJPCMRKVbRb+GmyfJkaiU/1ho/jv6EwtVymLrhyvNE7bOC+v9V6AUEm8i29uDAARFUqSf32jAQzzwe0QNJU65dUUYQMxucNNU3ErFOuMtUqsdwQKspvTKKT643WrtiXqQAdu5W9asZWMMmGwnMorM7yxosTZ/NdMpXBk0ggHCu3aW3ywyUqbBHq2+TrHshu7PyaguAodBTAItf0HBYTaFL7EWM=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ddc97d-e2b5-45b7-fa66-08d7ea845dce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:24:12.8385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dry1AWmb+nQeIR/hK6rNRS2nmtlYZckNdmNokgYnAlUPC47rH6dTAzxT77ymhjw2RP4tjJ1UR/UzFnYe7RapzV7vJcrmYFCyPgtUlNRsPgQ=
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
on all io paths. Convert driver copy_range handlers parameters which
are already 64bit to signed type.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h | 12 ++++++------
 block/file-posix.c        | 10 +++++-----
 block/iscsi.c             | 12 ++++++------
 block/qcow2.c             | 12 ++++++------
 block/raw-format.c        | 16 ++++++++--------
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 0da54cdf48..ea8fca5e28 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -257,10 +257,10 @@ struct BlockDriver {
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
 
@@ -274,10 +274,10 @@ struct BlockDriver {
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
index 688f2fa54c..76da620135 100644
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
index ed5e456b09..945554b25c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3809,9 +3809,9 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
 
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
@@ -3890,9 +3890,9 @@ out:
 
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
index d5ff7012b7..2537755f84 100644
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


