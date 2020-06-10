Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AEBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:24:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12442072F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 18:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YYBHiLCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12442072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj5On-0003xv-Rv
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 14:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj5Nk-00020R-Le; Wed, 10 Jun 2020 14:23:24 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com
 ([40.107.3.109]:7846 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jj5Nj-0006OY-OM; Wed, 10 Jun 2020 14:23:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Btxr8illmAVMjlsRrUMZp++Bblid+SQ7sP/poR6ULong9EvwwfxpDsh//vFbfxZT7kh0FbeEyFPlEABHWr/syAb9+pXYt2pkOIDXW9phzBDEEs31oWk+0tFalwrpExbcsVanfvmBCmWyAQcmR/V7ZH3egyMGblMlJSkClp/NEKwpoi79hgIYZAeH4bWH4+c0jc1T+Y/FILzKDDRzwPyrVvGGgHho8bPelne3BKt7Pr4fXrU/mwHPZm+0wkHTjMQVqgygN49rN5FMJacVqqKV/3P/oA0lu2bVPoKoFJ3m+xK0KZ8Hkxm76T38KZD6IRlZcbT4b7+Q1a07uXivJTZokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0SO4DX7DNyh9nqVV/vSG+97GsZkC4/oklrCyDg0a4s=;
 b=hzxjn5tCaeVbDm/74XRCOuG6NTuZn7wz8jCGzKxTBq3c9LBya+o7bS/DHEzoDOayemZ/crhWngSq23fpm4KpOzr33xCT6ceqsoOKeUIAw+eOmNliEdQ2WQuYxPOhtq+JSUhXKmz6g3rMkv3mgtOLxdejJf6BuUTxYBZvCnwCjm9pVl+qxlCDdsZvnOg9zaYWVmny/vaiQ0a8BJgxw1rXS/9PquzAkxVxarQeWuQi3Zf70s2TPhQwijbG+BL9ZBPkJwMOH3xxtJkY+X3xHuQv7bmQ/t4sg56bIT21PY4taiXQv4IoXxNlgIPeMY3255UAtd6vtLCOPsLAP6cEvdGY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0SO4DX7DNyh9nqVV/vSG+97GsZkC4/oklrCyDg0a4s=;
 b=YYBHiLCCqjFoZDfFv3GgTCnF67sPWKmbxON/B3q//lQ6QAhBfWHtiwelmr6eadbkyNDh1tuGn4H/Rr52aXRhNP5StmQpb+BaZhBxnHrnhQNgEpdOD7TdvNGkq+uuOmIy3aryvjsv3tviU44FQtUg7addyaKxfB1r4F5ZchdUpf8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5350.eurprd08.prod.outlook.com (2603:10a6:20b:101::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 18:23:19 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 18:23:19 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 1/4] block: add max_pwrite_zeroes_fast to BlockLimits
Date: Wed, 10 Jun 2020 21:23:02 +0300
Message-Id: <20200610182305.3462-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200610182305.3462-1-vsementsov@virtuozzo.com>
References: <20200610182305.3462-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0138.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::43) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.166) by
 AM0PR06CA0138.eurprd06.prod.outlook.com (2603:10a6:208:ab::43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Wed, 10 Jun 2020 18:23:18 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bdbc228-d6dd-4f5e-e031-08d80d6b59a7
X-MS-TrafficTypeDiagnostic: AM7PR08MB5350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53509B822C2CDEDFA9DB30E8C1830@AM7PR08MB5350.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qwNgXpnC/RhnQJrE+8l5S7krQGcsdJcAnNcJVZdyvrwrsyxeCVit6G7PyCkoGBLwwSHzhf4FoWG8VCoOygY6xoEMA3YKHsIDpYNsEwPmvlaCl0YNQ1zLGDykN5CmDLNnNEaxrO3tcFT0IdSJRxYd82/YxxdK6jESONYc0qSz1GywIEeAcVbx7+7bkTEOPK+j/cWle8JFR6K3xbAbdX3eP8zzB8oivEjPT8gKZWrCttpka9iqH2VwJAtnrH4DYqfgklNWY8b1LEjkzIQb4vy9x2A7RBK2F3Ky/LbqcIEV1O/9yPV59BfKVFfYlE0Quy3m4BHdvWJYiRKfJPXODRDcgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(1076003)(956004)(8676002)(52116002)(8936002)(83380400001)(86362001)(4326008)(2616005)(478600001)(107886003)(6512007)(316002)(186003)(5660300002)(26005)(66946007)(2906002)(66556008)(16526019)(66476007)(6666004)(36756003)(6916009)(6506007)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: siwwPV3DRwqLwkHKSr3Afs/o9RC3sfem7uzbRYng8FrJWQpKEwHd03kPAly/EbgeuK1ubQlzwyFvUkrqx0DmjNMMWhOt1LPgE63Dr1S9TUu/r+pB2HB6qRRV1hFi1/SBoRIjC3XxI0CtMCgi/hrGh9O9tNz5iOeKldHGDngR0cdtbc4vmf2l6UZoifToDZdTrAZnrSfwKWOTewrVJv9HYfmUY0XC4lZ5VEUJplfV4pKw8ePRTrwWOERJ9BDJW7w5uDuaBnhZvY4d8B6cBlLZfPoG8xzJKEnmQHLiDzRjvgW8kk/6lWyleLOKLgRPzKbLX8Oi8PFhRxhpvgdrEuDoFsMh+aruEW5fKVOUsycNVxXo3MxG+MLirdn9J/KGsxRbavXE3o98n6Sma1Q+rE3Shj6rLue3his+ic5Yt4v7FBnayx6DGrFRmCqIPN55s4yUlMsbb4457khsgszGTd+QQ+jJwceVgaZKyOpDUMRiOtS9O1loNDLtuApwNvCL1chQ
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdbc228-d6dd-4f5e-e031-08d80d6b59a7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 18:23:19.1115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85KaiiQPXqv0KXiBC7f6SwQ4HKg5+y/35BhfyqG41qXmZ+5HGdAcwSiO0B3TrcjvMpcAQChAYQ26IcblSTJIfGTxTOeQu1pP9ADAFGD1neU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5350
Received-SPF: pass client-ip=40.107.3.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 14:23:19
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NBD spec was recently updated to clarify that max_block doesn't
relate to NBD_CMD_WRITE_ZEROES with NBD_CMD_FLAG_FAST_ZERO (which
mirrors Qemu flag BDRV_REQ_NO_FALLBACK). To drop the restriction we
need new max_pwrite_zeroes_fast.

Default value of new max_pwrite_zeroes_fast is zero and it means
use max_pwrite_zeroes. So this commit semantically changes nothing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/block_int.h |  8 ++++++++
 block/io.c                | 17 ++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 791de6a59c..277e32fe31 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -626,6 +626,14 @@ typedef struct BlockLimits {
      * pwrite_zeroes_alignment. May be 0 if no inherent 32-bit limit */
     int32_t max_pwrite_zeroes;
 
+    /*
+     * Maximum number of bytes that can zeroed at once if flag
+     * BDRV_REQ_NO_FALLBACK specified. Must be multiple of
+     * pwrite_zeroes_alignment.
+     * If 0, max_pwrite_zeroes is used for no-fallback case.
+     */
+    int64_t max_pwrite_zeroes_fast;
+
     /* Optimal alignment for write zeroes requests in bytes. A power
      * of 2 is best but not mandatory.  Must be a multiple of
      * bl.request_alignment, and must be less than max_pwrite_zeroes
diff --git a/block/io.c b/block/io.c
index df8f2a98d4..0af62a53fd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1774,12 +1774,13 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     bool need_flush = false;
     int head = 0;
     int tail = 0;
-
-    int max_write_zeroes = MIN_NON_ZERO(bs->bl.max_pwrite_zeroes, INT_MAX);
+    int max_write_zeroes;
     int alignment = MAX(bs->bl.pwrite_zeroes_alignment,
                         bs->bl.request_alignment);
     int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer, MAX_BOUNCE_BUFFER);
 
+    assert(alignment % bs->bl.request_alignment == 0);
+
     if (!drv) {
         return -ENOMEDIUM;
     }
@@ -1788,12 +1789,18 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
         return -ENOTSUP;
     }
 
-    assert(alignment % bs->bl.request_alignment == 0);
-    head = offset % alignment;
-    tail = (offset + bytes) % alignment;
+    if ((flags & BDRV_REQ_NO_FALLBACK) && bs->bl.max_pwrite_zeroes_fast) {
+        max_write_zeroes = bs->bl.max_pwrite_zeroes_fast;
+    } else {
+        max_write_zeroes = bs->bl.max_pwrite_zeroes;
+    }
+    max_write_zeroes = MIN_NON_ZERO(max_write_zeroes, INT_MAX);
     max_write_zeroes = QEMU_ALIGN_DOWN(max_write_zeroes, alignment);
     assert(max_write_zeroes >= bs->bl.request_alignment);
 
+    head = offset % alignment;
+    tail = (offset + bytes) % alignment;
+
     while (bytes > 0 && !ret) {
         int num = bytes;
 
-- 
2.21.0


