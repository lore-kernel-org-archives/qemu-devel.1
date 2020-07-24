Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D2CC433EC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8B72070B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QrXC3rif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8B72070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytUg-0005NS-N3
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJJ-00024F-R9; Fri, 24 Jul 2020 04:44:09 -0400
Received: from mail-am6eur05on2134.outbound.protection.outlook.com
 ([40.107.22.134]:63329 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jytJI-0008OD-15; Fri, 24 Jul 2020 04:44:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPx8fCmSFj+FUTrjDC0gmjnzFlqV3hYU0xI/j3Kn/mJAsN7ck5xFCYO+Yts8OFM9arMiyiZ/JZ9+yyTh/i0dyEvjHGcV2m5Xc/Pcm4cZo/r63TwwOBUk/GtxI+CTt+cLPd4G4j0rDQ/GhKX8OzCNpn+Egb42R4gVrVVYPck33EgXkCwcqTLkxzkYJ5lT5Zz4EJmO8IT4ErvgibDu1tPnNDnv9P3gmsNqyKhvp7d/l59x4+Fmms//pLCj2oTlG02qKpsWa+BILWnMFvE2Est9S39bPd+P1RcUdE/1Ocq+nlDVG53xe83Mab8C2LPAbsVlhNnZTdOPNOSr43H7KbAd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phxw50qpVKCNupFSp+SUZm4+sy/Cji3YickqluvKk0o=;
 b=Zcl0HxwAYFPgIT1Tea18tGXVfHu9e5lqeFgPEM//RrJDr5exxG25gsMYxSP3HrAfKezxgazcLCY9w3a6+xpbqhosFc2Xrdt+x24+T0/xUcPIXpF7HjV+xcY4cfvIYqn1M691FFfZf7tf8esXyjxAIsOefS/GakyYAkLuM1XzKLQ8Zst1S36O96A+t2Rdtfk5jjy9Lc2SIqlZI6ElNnug+I7ODkI6FDmR/JEjc0zLMFmazc5eyx+meLKsSGf/tpBfgfV07w4FuuO60ckVIyZnncTW2lI2kpZyMatfnCFXvFVhqfOfMi5KSYwP0+cya9UHlWxNXLKHEYuFNU1oMq3fYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phxw50qpVKCNupFSp+SUZm4+sy/Cji3YickqluvKk0o=;
 b=QrXC3rifWsQmTXruGldy8WXMOJXwzglkEiP/am76EvKAsmHvHqrgQ5AJ8ibyjVelbvwfkoufhCXJYlm1UhUGv+yguvGjGR4oDJ+4wu9v4KMcuSURUudt/3bbKER7uHlQYeR81GwNHXE13FUDXvKMU2KNTNozEyM0QRRRSKOtuFU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4534.eurprd08.prod.outlook.com (2603:10a6:20b:ba::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 24 Jul
 2020 08:43:56 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 08:43:55 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 13/21] migration/block-dirty-bitmap: simplify
 dirty_bitmap_load_complete
Date: Fri, 24 Jul 2020 11:43:19 +0300
Message-Id: <20200724084327.15665-14-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200724084327.15665-1-vsementsov@virtuozzo.com>
References: <20200724084327.15665-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0160.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::29) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.156) by
 AM0PR01CA0160.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 08:43:54 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8c024bd-2ff7-40cb-ea6d-08d82fadb2eb
X-MS-TrafficTypeDiagnostic: AM6PR08MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB45345C2AC5FD640E4028BA27C1770@AM6PR08MB4534.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VAEECXfsaudFW8RXiQLbORuBGpg2GZCGfAV1+TIzwdMejboc9cTYVyN7dJhhz77rAqa5DlIRMqwwsuf8uWpiEqkxczR1Kn5AvwDZRgBJV9AI+qMMMNxIBymALsSIo5J8KRq5YXQ5NdNtFlGGjPcrvQhlvN3PKvSjIqaZA7aXsjkPS+uCWy/DRYRcb5GGBvuo3j8F3TxdgwCZr5dkNErAyzRSfn5g0crNRMPr7WjDDoodlVfLI9ckVVqoe1mA2YADmJba4rL/Aao788PykBRODbZhoDxOufXohY+RPo6MbZkym03ydURK+eANmi6sq1DKM5MjnGG0ggh309iBnJAThATb2elGZQkZQtIag0jsUMzs8VnxYX55lH7cCQ38b5jSpIYU3c00oTXc1bNh2wmMLVnVGVKfFsx/G81CAkiQwps=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(6512007)(6916009)(66476007)(8676002)(66556008)(52116002)(66946007)(4326008)(83380400001)(6506007)(36756003)(6486002)(956004)(26005)(6666004)(2616005)(69590400007)(7416002)(186003)(5660300002)(478600001)(8936002)(2906002)(107886003)(16526019)(86362001)(316002)(1076003)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cw0OnldJ+lhhOjBxKWuuXG0uDW6DS5e21on90TyKI/nln8znqvlLnOgrfW+ohHUdpET9IczzJL0QDCn2Fp7DhBIMUO30KkSVNE7oW7w+lQctmhCZ6Tugt0rT6QpXTf6adpgRZMo92XRb1PsZh5urhURRvek5n+bQTwx7r5nIgvFuFyBPo/emXMnN2FuEvvD4JG4BxVbHYApLeKh/btS2ZELiOvt7RMUr967oGZLVH/QxBdsaeTxT5lvqZ1CN1RRt8w7vXtxmF8GJ0gjFNtLuWSmAnpjTEqS0WYs881pTWjHv0/Wi4isuZ2DQAPLO7bKVWl5cts3WcT4kS66BMD06geVCoU3uzh41riPITzT49HzYi6TrycjnbTxPB9kicgef3/C9TJ9gNc93zataAW9r8l1f5YYLfYPPTbyyqhbtmc/OvjVpyZ7jUkPz36/cjBIVHi6/WAeNrNksHaTUuuWP8P1viXZii7MLrbTBnR8zdoI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c024bd-2ff7-40cb-ea6d-08d82fadb2eb
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 08:43:55.1753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PH+ezineAACdw4QIpiBehXSQbSAzCcTgfeeT+q1uCPn1bceA1nPhhwiAhz9lOyfFUGE5HLJ1o6/2R7ffvIISHJmnsid0OKuXE1JcEYjqScM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4534
Received-SPF: pass client-ip=40.107.22.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 04:43:47
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_enable_dirty_bitmap_locked() call does nothing, as if we are in
postcopy, bitmap successor must be enabled, and reclaim operation will
enable the bitmap.

So, actually we need just call _reclaim_ in both if branches, and
making differences only to add an assertion seems not really good. The
logic becomes simple: on load complete we do reclaim and that's all.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 9194807b54..405a259296 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -603,6 +603,10 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
 
     qemu_mutex_lock(&s->lock);
 
+    if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
+        bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
+    }
+
     for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
         LoadBitmapState *b = item->data;
 
@@ -612,27 +616,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
         }
     }
 
-    if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
-        bdrv_dirty_bitmap_lock(s->bitmap);
-        if (s->enabled_bitmaps == NULL) {
-            /* in postcopy */
-            bdrv_reclaim_dirty_bitmap_locked(s->bitmap, &error_abort);
-            bdrv_enable_dirty_bitmap_locked(s->bitmap);
-        } else {
-            /* target not started, successor must be empty */
-            int64_t count = bdrv_get_dirty_count(s->bitmap);
-            BdrvDirtyBitmap *ret = bdrv_reclaim_dirty_bitmap_locked(s->bitmap,
-                                                                    NULL);
-            /* bdrv_reclaim_dirty_bitmap can fail only on no successor (it
-             * must be) or on merge fail, but merge can't fail when second
-             * bitmap is empty
-             */
-            assert(ret == s->bitmap &&
-                   count == bdrv_get_dirty_count(s->bitmap));
-        }
-        bdrv_dirty_bitmap_unlock(s->bitmap);
-    }
-
     qemu_mutex_unlock(&s->lock);
 }
 
-- 
2.21.0


