Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5A6C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D055320775
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KGaT3AdA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D055320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7G6-0001Id-WF
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU78X-000767-7s
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jU771-0005H0-Mx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:13:49 -0400
Received: from mail-eopbgr60129.outbound.protection.outlook.com
 ([40.107.6.129]:22328 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jU75u-0003Xs-6R; Thu, 30 Apr 2020 07:11:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQEK/B6v/AghkRJ11TLmn0gVi1p4reKEOO/DTqufBPMBethx4oxX43AmKYk+UQBAFOPSDqAWJ6xnlHUEHrbgpWWJEoiZ+BY7W2fIMvafjaTH613j3t0L3XeR5dWP/DY0JpDjWPPXkgeEGaicnGAD7CGm5k8aIvQ6lpp4rp9LxRKnearShiaOSETwc9lEerX7vgkdN2Cic9B/5r2DcxqFdyW+7bH16k4Y44iaheM/apQKYy6UPGAL3KtlxEIkTD1qDG99aMh/TjxmUiiTJS3TwUHJoVOGHh9r5wOBAIZg8R45bwB3mhnEGcTs/0odd/G0g6QJ4MKz1mOaZAinofmykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoKXATxQwNFhW5mgkUoT6ST4SlqHyD6XpHb/VQY54iA=;
 b=eKkRMgc/EPJV4KjUN9b7TFdOSfPKGbl7I49MkHCaZjL/wD4DrQeB/GPqFg9vSr44yeuVQIbcCV8nwJFmFKF9E7WT0v3lyuJ6WWfmoz/U9cywWOkRHZC1WSNOvTBInhFQtIqRW7OWfpFpphT8jU4pUpVAbEBza0mAZyZSh+uKDwdGTwp65nEsy0kgBaIJEONqL1FOgKQZ+t14tPxd6XgpESoxu5Sa2DE50pufWMgydwMfeb8CWgvLlZhTTs33oblueWoC8CuvoO6n9AxFxqAyThMveBX4IodG7iuhpZz2qDZ2fSYgR8EZO3UP9rAEtDlBd570rX/1Rjxrqt3dCqH0tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoKXATxQwNFhW5mgkUoT6ST4SlqHyD6XpHb/VQY54iA=;
 b=KGaT3AdAO4z6lAyVkxJsB5/FiFO2Xq8o2oYvjcKNto95Dvz745kVlrJdnsuFXEkmzxAlS7HlqzDy/Rxfd7N341LDkTxpyteO1deiOo2ZuYRvtmoYNeoXgY9lMQyw2cw2igtt6q0AAAZGacp5dzJp1x02Z4zmEHrKEmllGhDAeOA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5447.eurprd08.prod.outlook.com (2603:10a6:20b:10b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 11:11:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 11:11:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 11/17] block/io: use int64_t bytes in copy_range
Date: Thu, 30 Apr 2020 14:10:27 +0300
Message-Id: <20200430111033.29980-12-vsementsov@virtuozzo.com>
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
 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 11:11:03 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.138]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21acda43-be00-4e64-b6ec-08d7ecf72c6e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5447CE6CB848202393980DCBC1AA0@AM7PR08MB5447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(376002)(396003)(366004)(66556008)(6512007)(107886003)(316002)(6506007)(26005)(52116002)(186003)(478600001)(956004)(2616005)(16526019)(66476007)(2906002)(86362001)(5660300002)(66946007)(6486002)(6916009)(7416002)(36756003)(8936002)(1076003)(6666004)(8676002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Idy1yo5jNLCX5aNP7TWQBWqm1YWKEx8mKp+oiYmfLgB0/pHlBSc43BV8+WLeXzzSt5EMcf24heElxG60i+przIUnLoD2Jc/nFN1Lf3gKYzoUBvBeECGPyxX2Ab0rdjx0K6o89SZyyxhixrV/zT5FE7ZmSdBAEmWkQAjepsCm+CFgk7gSapg7sPTOmfc/ByQdJakVwvjct33XL+/iWmj+bBHEv/2jf0T7teBQBQb88xjmfuaXEPiYOonuqUTqElPkWaPc40aMi5gJxeoOXu/ghoEDi90vrVrSdzMF1Up6uxxQ1sY17nq7MgWqrJjELezcxRatrE2XSsFONLOJC+FTNGlx/JuNHbV5tNrLA5ySCrLqG+bLq6ASAeARp0L6HkItAOshzNHBlf3e7Rjxi88c93cT39q/7I8m3wJFbEUKXxt0evbN4AhDUjlqC7PDolsP
X-MS-Exchange-AntiSpam-MessageData: hB7S6t+nh/LpmvYky1X1MebJMPv9DoasJRzZj1nS7tTkAYvH2PX60KEzIws3zAyl4g03CQTkc2Obcx6dlxoq6ZLFOBSG+SHHL7cb7adgcpxX/77cMvDVrLLyE1ykg3TfLxePKQCJM9FAO3u592lLgqYz6XpXf1GEMAfncZlt+5c8hkEXpMW+b90zfpf+imAtMfYDGjZDwd2xoy9wq/dL0gFRplDe5ePfWJryfF1wymysWRKJfzxcu8sd2W9oo3jeNjqxRYwAIVkTe2w1wbYihr926QUBSIDE7SzpDBWg6JUwm2eas7lQ7AETrdyYlBShAnfAxOfNnV/LrMGhqctkStotfmPXReo5Tfgca8v1eeQmSgtU8p6NVjgQFb0igj+lex7m2uRmULuV+zGOUShOBXjogkLEYTKGS5kYKlS4JelqCbzdgamD983QOcaAmsQITJIFYBmrvarlXE/vcvdfJRiAGbrCSrNYWS/8ahAzAzZ2+kmR35eX4uFHk2VHQfp5u60biVRkJIWGME1vtgjl4IjCvM9VOTISyt/hDpC13TAUx7NDLrCOB7ZHOTDPsPrPYzql3YkozZuVOT1IPccdpYpvMjRhD8hu83V6sGe7/zCfZWKkAMochvRV+Zhpx5tP6FDVJQsibo+CISMq92lMiEGHsjEM5KpGfWlRgBI+5/YPvJJmn1x4xJIDmftTOsP5QQy0jWobUqLeoTRzzc52ntUyOxIwIqGwokdG2EmAVo63m0HzaUvsnSib/ZswlZCnd3nEVDMvOFGwpXO3oobrjYgnKnf+iQ9Vp6gyrPelido=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21acda43-be00-4e64-b6ec-08d7ecf72c6e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 11:11:04.4616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbgnJ+7lb31PhU4ZbwTL4VvsSB+FoReSgmVPPKXizmcTNafQf2TadmPKjFzThx9TzwjBJzBOrl0C5c04bkKMF2YUzRuZjEUrxTua66opX0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5447
Received-SPF: pass client-ip=40.107.6.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 07:11:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.6.129
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

So, convert now copy_range parameters which are already 64bit to signed
type.

Series: 64bit-block-status
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h     |  6 +++---
 include/block/block_int.h | 12 ++++++------
 block/io.c                | 22 +++++++++++-----------
 block/trace-events        |  4 ++--
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 1688e7fa55..4bc90c493e 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -732,8 +732,8 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host);
  *
  * Returns: 0 if succeeded; negative error code if failed.
  **/
-int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
-                                    BdrvChild *dst, uint64_t dst_offset,
-                                    uint64_t bytes, BdrvRequestFlags read_flags,
+int coroutine_fn bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
+                                    BdrvChild *dst, int64_t dst_offset,
+                                    int64_t bytes, BdrvRequestFlags read_flags,
                                     BdrvRequestFlags write_flags);
 #endif
diff --git a/include/block/block_int.h b/include/block/block_int.h
index b4b42d0cd6..28aea2bcfd 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1315,14 +1315,14 @@ void bdrv_dec_in_flight(BlockDriverState *bs);
 
 void blockdev_close_all_bdrv_states(void);
 
-int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
-                                         BdrvChild *dst, uint64_t dst_offset,
-                                         uint64_t bytes,
+int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, int64_t src_offset,
+                                         BdrvChild *dst, int64_t dst_offset,
+                                         int64_t bytes,
                                          BdrvRequestFlags read_flags,
                                          BdrvRequestFlags write_flags);
-int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
-                                       BdrvChild *dst, uint64_t dst_offset,
-                                       uint64_t bytes,
+int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, int64_t src_offset,
+                                       BdrvChild *dst, int64_t dst_offset,
+                                       int64_t bytes,
                                        BdrvRequestFlags read_flags,
                                        BdrvRequestFlags write_flags);
 
diff --git a/block/io.c b/block/io.c
index 7564153dbe..db8b3b153d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3451,8 +3451,8 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host)
 }
 
 static int coroutine_fn bdrv_co_copy_range_internal(
-        BdrvChild *src, uint64_t src_offset, BdrvChild *dst,
-        uint64_t dst_offset, uint64_t bytes,
+        BdrvChild *src, int64_t src_offset, BdrvChild *dst,
+        int64_t dst_offset, int64_t bytes,
         BdrvRequestFlags read_flags, BdrvRequestFlags write_flags,
         bool recurse_src)
 {
@@ -3530,9 +3530,9 @@ static int coroutine_fn bdrv_co_copy_range_internal(
  *
  * See the comment of bdrv_co_copy_range for the parameter and return value
  * semantics. */
-int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
-                                         BdrvChild *dst, uint64_t dst_offset,
-                                         uint64_t bytes,
+int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, int64_t src_offset,
+                                         BdrvChild *dst, int64_t dst_offset,
+                                         int64_t bytes,
                                          BdrvRequestFlags read_flags,
                                          BdrvRequestFlags write_flags)
 {
@@ -3546,9 +3546,9 @@ int coroutine_fn bdrv_co_copy_range_from(BdrvChild *src, uint64_t src_offset,
  *
  * See the comment of bdrv_co_copy_range for the parameter and return value
  * semantics. */
-int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
-                                       BdrvChild *dst, uint64_t dst_offset,
-                                       uint64_t bytes,
+int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, int64_t src_offset,
+                                       BdrvChild *dst, int64_t dst_offset,
+                                       int64_t bytes,
                                        BdrvRequestFlags read_flags,
                                        BdrvRequestFlags write_flags)
 {
@@ -3558,9 +3558,9 @@ int coroutine_fn bdrv_co_copy_range_to(BdrvChild *src, uint64_t src_offset,
                                        bytes, read_flags, write_flags, false);
 }
 
-int coroutine_fn bdrv_co_copy_range(BdrvChild *src, uint64_t src_offset,
-                                    BdrvChild *dst, uint64_t dst_offset,
-                                    uint64_t bytes, BdrvRequestFlags read_flags,
+int coroutine_fn bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
+                                    BdrvChild *dst, int64_t dst_offset,
+                                    int64_t bytes, BdrvRequestFlags read_flags,
                                     BdrvRequestFlags write_flags)
 {
     return bdrv_co_copy_range_from(src, src_offset,
diff --git a/block/trace-events b/block/trace-events
index 13ad9af0d8..e4d68438af 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -15,8 +15,8 @@ bdrv_co_preadv_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p o
 bdrv_co_pwritev_part(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
 bdrv_co_pwrite_zeroes(void *bs, int64_t offset, int64_t bytes, int flags) "bs %p offset %" PRId64 " bytes %" PRId64 " flags 0x%x"
 bdrv_co_do_copy_on_readv(void *bs, int64_t offset, int64_t bytes, int64_t cluster_offset, int64_t cluster_bytes) "bs %p offset %" PRId64 " bytes %" PRId64 " cluster_offset %" PRId64 " cluster_bytes %" PRId64
-bdrv_co_copy_range_from(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
-bdrv_co_copy_range_to(void *src, uint64_t src_offset, void *dst, uint64_t dst_offset, uint64_t bytes, int read_flags, int write_flags) "src %p offset %"PRIu64" dst %p offset %"PRIu64" bytes %"PRIu64" rw flags 0x%x 0x%x"
+bdrv_co_copy_range_from(void *src, int64_t src_offset, void *dst, int64_t dst_offset, int64_t bytes, int read_flags, int write_flags) "src %p offset %" PRId64 " dst %p offset %" PRId64 " bytes %" PRId64 " rw flags 0x%x 0x%x"
+bdrv_co_copy_range_to(void *src, int64_t src_offset, void *dst, int64_t dst_offset, int64_t bytes, int read_flags, int write_flags) "src %p offset %" PRId64 " dst %p offset %" PRId64 " bytes %" PRId64 " rw flags 0x%x 0x%x"
 
 # stream.c
 stream_one_iteration(void *s, int64_t offset, uint64_t bytes, int is_allocated) "s %p offset %" PRId64 " bytes %" PRIu64 " is_allocated %d"
-- 
2.21.0


