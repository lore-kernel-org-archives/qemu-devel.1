Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55208C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8F92073A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="IUOTh1QU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8F92073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGNd-000691-36
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJa-000892-8u; Wed, 06 May 2020 05:26:06 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com
 ([40.107.2.115]:7399 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJZ-0006M8-0b; Wed, 06 May 2020 05:26:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=de93ioL1iD7MtlIfJ7z0GBIfhXObPHEcimW5qh5MvUG9h0mTkJ6ciJ9rAG5KV1eExlGQhwqIxUN//mL7ZFi8ZgSPT34tapkfTtzaypb3luWWNhbhdXUy3KDfFNjoRUT+PaqnSVzQws2rJif/SWuLyevYJgWqCdokaF8cKehZ66S2gkOAVOko3gxxUNhg9valVpDQwSmZYGdYXKPHdE9QRM6e1ZV11FIanlfB+3lhaiY+MRZED1oosD1M5nOqA9cc/Mx+mg78hkegsOYknSctKN6Po5ScVsTJS1SBWWZ7tyGj1+ryTaqQIITl3ug2WhyduycOpO/2/SoCvBBGgGne8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CJ/zA8nPmGcJLhw0yj8M9+rqqBa0WbBpGW0h7FaeTk=;
 b=AryYtzo840xFzWrZgmH6f9NSHw84RbvShkyhGqDMLHf+lLke3FUcT7vva6msFvbjoJ12kbEA/3hVmGCju6oBBYCqxt2S+OhR4e/ECUCg3w9m40ODV0biQGyWjeC2TJM2xHaJq2qX36OZuf8QmAVkelSnp2z+28De9o1MUEMKLyeIjXwratg3z2GVGJOwQfiWeIMuE7L+U1Z4RJQLWvVxl86YYitLAeWGGdiRLFgGEHw6Pox3/oYFEurWFqiIkWYgcV/W/Rd1h1bGcE9ulelfjgsdbEMuVDDywwGv7/OvEFkzTWj1EYTMMT1uv7Y5aHJhmDYpr3DAemMaCEJKUOF+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CJ/zA8nPmGcJLhw0yj8M9+rqqBa0WbBpGW0h7FaeTk=;
 b=IUOTh1QU1soPPjqIaHsaRvSBJdQaBkjdcYxEyKcWPgSilpVsm0DhLkmMRfPjqodK0jOUrzOnDFFO0z+xVFQsTiOdYqC/HTzUzTNc8fSKcOY+l5nerJYUE9CqmNSNdYHyLsoTM64k6pYCZmW6msHgaNWBMTK5ZIPpatoXTHSExEs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 09:25:55 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 09:25:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 8/8] block: drop unallocated_blocks_are_zero
Date: Wed,  6 May 2020 12:25:13 +0300
Message-Id: <20200506092513.20904-9-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200506092513.20904-1-vsementsov@virtuozzo.com>
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.178) by
 FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 09:25:54 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 375643b8-3fa7-4da2-bb4b-08d7f19f7a7b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5382194C9A4D971364C2741AC1A40@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EHawf3pCvv8ui+5n0JWH9kXHeb6E3fLv68K2Iyf4bmRryqBKyCaNwECOsY/mU1wFIb1fssKNpU9dUisgFZOKladUq6vd10LnHac/o3Z9lzK0+MKpVRBWxqwBfGmlgSJzNjRGx9NwQSLmctcLeqomDbt+vRKof9NBrnEjBthAwaLj8u9uYhLYLAJn+QIWlqhqYeS/kAE26OHz7miZcAunzYd+M7iy6Hopx3Ifo2q7yDGyO0uS+jPJy7sxI1zZRJtlISJa1hWF7pLqDq1peKH5K90o6xBpk8tdqS+piP0egPQl1G/yJDjZc7FyzlxDQbEVg1eeCy04duKS2/I5ZgSwrht7oRtVoZl6HHD1zvajiWOae3XrAlz9c28WPuueyBZbMfbPnhDsoDKk51S9fd+4CHb+Q1DalcZ3WAeGgsREiuM6RM841MEbG1bWqhOdTbX5HgiKO1BsUP5tNzRkbA5VuNIXaPzz6cmTZqD4wJkIEzKwmqmEmZEZSO3tsQVtXiWsYizmrXPO5+S/zQw1OaEJvUjaNo4C4vpC3NNg3XDRS3NavnQxleCqi2tNuntzwjsI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39840400004)(346002)(33430700001)(6486002)(6916009)(52116002)(956004)(2616005)(6666004)(8936002)(86362001)(26005)(107886003)(2906002)(6506007)(5660300002)(36756003)(478600001)(16526019)(7416002)(69590400007)(186003)(66946007)(66476007)(33440700001)(66556008)(4326008)(316002)(1076003)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yD3H28PmdEGsg8UmJmHNcsUSJ/vSvCBTxhD5oecqTws4MQrN7K0Ylp696XaTuYQ+Wc6gFJpJk3Z899H6UiJvvy5xGwFLYXfCsbctVhRThrnsHMNm3d0wzWPZrrsWvnG5rV7MkLUCBGy8ifaJhHxyHuECMyrjJYSbeq2uSlzmHfjQntiLSxxbk5MKTV+gGuJEi9h0eE90XuOK7797SEyQL6JcL1GaLrNxFcNsIA3XU3EMycAm46AL1xa963vp1IVKAybajbfQFkzUC6sSt8SOB+yVXy1V9WmMfXLPxrut22sdJH6EHNEjp7L8wh72r7n2Bdo3Ai0BGsO+TUz/LWdDJP6s0+Bz7V0W9PVlBa4LnMnbsQjQJ1dWJdHo7p5D5wKxL8ubEABxlXkfUX/Z1Isp8FKAJcZK0wObPWoPqNArH0JEGFb1lMmubyUYcVyBa2l4opB1xtOORjlNKnrh8xetD73QCTCHOUZdzofuUQWgk1TwHyGm0XV32oTUVkF/umVwjIqsilUAVqAkIHGF/qdH1G/vV0zHwjeaiGmAfR6+/K+FQSDPaTveK1rtssXZso72LELBKMjZRX72f0WtOAybwYbv4M/JU9uOFjErpzcdLCt55/M8AhwADf1+L2oWOsNjDpR2SF0+1L/Phc00lxZ7tFnga2gMPSyA4EV6ppHWZzRMqA58HsYNbGehR+xfmr+3U/PlG+DT6vCODNFpGi/A50bt3mQEu6/S5d7rGeGB6IuOfGJY+XMTxNZs8bYlnbE8qlb3iD14bOoeW13a2TIUX94XKYTGMEMYaVdNyW1wAi8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375643b8-3fa7-4da2-bb4b-08d7f19f7a7b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 09:25:55.4293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7erHHS9DVNUZnOrIb162gkF0LLE4XkDdwFDjQfBYLJetXYbrxY4nI/9gIjM04+ybPrmpIsIQEBwCsMwxdJbB8QjwBhq3iSXQHr3fsXAmbAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
Received-SPF: pass client-ip=40.107.2.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:25:49
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 stefanha@redhat.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, ronniesahlberg@gmail.com,
 den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently this field only set by qed and qcow2. But in fact, all
backing-supporting formats (parallels, qcow, qcow2, qed, vmdk) share
this semantics: on unallocated blocks, if there is no backing file they
just memset the buffer with zeroes.

So, document this behavior for .supports_backing and drop
.unallocated_blocks_are_zero

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block.h     |  6 ------
 include/block/block_int.h | 13 ++++++++++++-
 block.c                   | 15 ---------------
 block/io.c                |  8 ++++----
 block/qcow2.c             |  1 -
 block/qed.c               |  1 -
 6 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 8b62429aa4..db1cb503ec 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -21,11 +21,6 @@ typedef struct BlockDriverInfo {
     /* offset at which the VM state can be saved (0 if not possible) */
     int64_t vm_state_offset;
     bool is_dirty;
-    /*
-     * True if unallocated blocks read back as zeroes. This is equivalent
-     * to the LBPRZ flag in the SCSI logical block provisioning page.
-     */
-    bool unallocated_blocks_are_zero;
     /*
      * True if this block driver only supports compressed writes
      */
@@ -431,7 +426,6 @@ int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
 int bdrv_has_zero_init_truncate(BlockDriverState *bs);
-bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
 int bdrv_block_status(BlockDriverState *bs, int64_t offset,
                       int64_t bytes, int64_t *pnum, int64_t *map,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 92335f33c7..c156b22c6b 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -115,7 +115,18 @@ struct BlockDriver {
      */
     bool bdrv_needs_filename;
 
-    /* Set if a driver can support backing files */
+    /*
+     * Set if a driver can support backing files. This also implies the
+     * following semantics:
+     *
+     *  - Return status 0 of .bdrv_co_block_status means that corresponding
+     *    blocks are not allocated in this layer of backing-chain
+     *  - For such (unallocated) blocks, read will:
+     *    - read from backing file if there is one and big enough
+     *    - fill buffer with zeroes if there is no backing file
+     *    - space after EOF of the backing file considered as zero
+     *      (corresponding part of read-buffer must be zeroed by driver)
+     */
     bool supports_backing;
 
     /* For handling image reopen for split or non-split files */
diff --git a/block.c b/block.c
index cf5c19b1db..0283fdecbc 100644
--- a/block.c
+++ b/block.c
@@ -5305,21 +5305,6 @@ int bdrv_has_zero_init_truncate(BlockDriverState *bs)
     return 0;
 }
 
-bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs)
-{
-    BlockDriverInfo bdi;
-
-    if (bs->backing) {
-        return false;
-    }
-
-    if (bdrv_get_info(bs, &bdi) == 0) {
-        return bdi.unallocated_blocks_are_zero;
-    }
-
-    return false;
-}
-
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs)
 {
     if (!(bs->open_flags & BDRV_O_UNMAP)) {
diff --git a/block/io.c b/block/io.c
index a4f9714230..484adec5a1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2385,16 +2385,16 @@ static int coroutine_fn bdrv_co_block_status(BlockDriverState *bs,
 
     if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
         ret |= BDRV_BLOCK_ALLOCATED;
-    } else if (want_zero) {
-        if (bdrv_unallocated_blocks_are_zero(bs)) {
-            ret |= BDRV_BLOCK_ZERO;
-        } else if (bs->backing) {
+    } else if (want_zero && bs->drv->supports_backing) {
+        if (bs->backing) {
             BlockDriverState *bs2 = bs->backing->bs;
             int64_t size2 = bdrv_getlength(bs2);
 
             if (size2 >= 0 && offset >= size2) {
                 ret |= BDRV_BLOCK_ZERO;
             }
+        } else {
+            ret |= BDRV_BLOCK_ZERO;
         }
     }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 2ba0b17c39..dc3c0aac2b 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4858,7 +4858,6 @@ err:
 static int qcow2_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVQcow2State *s = bs->opaque;
-    bdi->unallocated_blocks_are_zero = true;
     bdi->cluster_size = s->cluster_size;
     bdi->vm_state_offset = qcow2_vm_state_offset(s);
     return 0;
diff --git a/block/qed.c b/block/qed.c
index b0fdb8f565..fb7833dc8b 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1514,7 +1514,6 @@ static int bdrv_qed_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     memset(bdi, 0, sizeof(*bdi));
     bdi->cluster_size = s->header.cluster_size;
     bdi->is_dirty = s->header.features & QED_F_NEED_CHECK;
-    bdi->unallocated_blocks_are_zero = true;
     return 0;
 }
 
-- 
2.21.0


