Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05603C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A78820639
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 12:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oUqF4USl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A78820639
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb16q-0005KT-3P
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 07:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb15E-0002z8-H5; Fri, 06 Nov 2020 07:43:17 -0500
Received: from mail-eopbgr130093.outbound.protection.outlook.com
 ([40.107.13.93]:31364 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kb15B-0001NI-Ku; Fri, 06 Nov 2020 07:43:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vtf/zc9Tw0s7tYoGokE8VXtFBCb4AiP7TfJltjYGE371UI0DKiJra097pYsTfECUU/noFEL59Uw+ieT1Qxx/rECpo1iAJdualabLxPVH19qxemtKlj9r3El4lqweIkzWU6e5EP0k6lmyQyZRef34d0xb/RZw9ybeGisY4st6fKIfvVzgUa+bbjYy9HKKGm/MUkbwvTJi7AaAECiq+EcMobGbfd4eVwvj7OT5gyvxKiswCHtmLAOTIn54y+h3RxcEgrk7l6h7Q1frgdqr+HHKdmzP3lTtsMmYR1MngDhANidloTVW6KwQAptfPBifwUK0D2OXbqSaZldQ7f8gfoKkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtZq/rIT9zsYRis78ufgxP4vGNeeF7dwoSYY8JWGvco=;
 b=Z6dPTHD4Kwp0m61twB1/gKpkAtI6oJhrhBuyL+nl1+/v5MD1NU6pTJBw5vJQ15ZSJ12kf+sEJu8RdNAQLQnDBYACne3j/JzW2T8UYBksZIcCWDJ6EswLF6xDE037WSuKjPgAgGVZH/puFRUGkgtrzCM3JijYHLWe4XMhd+PjijC/TiI6aGCpgb2Vu1WrdIY1esGszmhbcSbqD3rS2Llg2XLsHtsShpHfwUHYDhGRr4uRi/jG0BGkoj9mgIOIlA8T2Lum3hVRM6jk09VDextR/vSObTuf/AxAxJcHUs0Qcp5Gk3IPsgf4VmBO73ztgcN166Qjv1jipmBh2FmtCU+QJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtZq/rIT9zsYRis78ufgxP4vGNeeF7dwoSYY8JWGvco=;
 b=oUqF4USlpb6bx3BuOid7uB5x+aMmlWqIVfFSieZ7+PXoAKdqG9kXONyRXDogKipEPuUVkE2QhkD3yFf9OGL9K85YcYI0BAQVtytz6wX+IAPMefM2o9Eh6Yg2x4EyicGrd4isAcY3WCxI+ZZ1iK3QL8mDLQddWGTu3P6c6e03X38=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1841.eurprd08.prod.outlook.com (2603:10a6:203:2e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 6 Nov
 2020 12:42:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 12:42:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 2/7] block: add bdrv_replace_node_common()
Date: Fri,  6 Nov 2020 15:42:36 +0300
Message-Id: <20201106124241.16950-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201106124241.16950-1-vsementsov@virtuozzo.com>
References: <20201106124241.16950-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.66]
X-ClientProxiedBy: AM3PR07CA0104.eurprd07.prod.outlook.com
 (2603:10a6:207:7::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.66) by
 AM3PR07CA0104.eurprd07.prod.outlook.com (2603:10a6:207:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.13 via Frontend Transport; Fri, 6 Nov 2020 12:42:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d462529f-504c-4aa5-37c9-08d882517d4a
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1841:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1841D1DB886A75D996B09AABC1ED0@AM5PR0801MB1841.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLVHaia5UCpIycrr0oKiPvSfsuTpYh6N8/xgDHeZ+hFcJVxL2F7U96V3Na0aNbc9mKsWGN+3zVYfRzhdrKQg5G5KZrz031MyfUTbvQeBqc2U0nIYMYU2nNrZETf1XPiEcHTvwaArhKpgX4YfAzubxvqUIu8M1w3GFWd2U8SkLtp4Zr2uunVWLe3Sv2MG0MJmGB3N6PRsxP4RVXIhEc4q4c8hxDQNndapvu/nD1g+rTXfRuAuab828pc0FnPMXkyLTrW4kl9EGlylThwrVMNtL49ZHm9qdF80D04L6PGuDpmwLP8w7oktZ1YL1+o/taEdZuA7JDr/ExKhF0Ok4FMURQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(39840400004)(346002)(6916009)(86362001)(66476007)(66946007)(6666004)(2906002)(8936002)(8676002)(1076003)(66556008)(5660300002)(52116002)(83380400001)(4326008)(36756003)(6486002)(2616005)(316002)(16526019)(6506007)(26005)(186003)(6512007)(478600001)(107886003)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: a5oc+GQz1hMy2LsCH3EPOyb7UKjfjL51gYk4UxqC3K7Gp81l/Mozztm/OKmypE5Nnwo1wHTO18w3hos7y868QSeZgeB80d2BCRdif+zeZK/wkuebU1/7Uyp8c4l7iSOgNdHPnA5q0uTtHQn7japESOa7PedzUfoDYhy36w/ZUBom0lVYNTeBejPFD7vkg733EYY6yjCh1peG3f1/919EwlAT+ozYPceep2ZWrNWkMhZrxDTHeM7Fvq7Ul+fKfRNkfDDQpU+Ca0pyfAOIhOjse8VLF1p7ywM/ybStDnPaPVJtrJiazxoiIwhjaX2Sf9snLgggVj3n/WLoewrJri1Rur30rvSkFGzPU6jUMm9Vfp4aMxuU6mXSTUntOcS5nuNGY76RZD7ukPwNOohk0fdrbeNcgfiQU0GBonEBGXN71qz48jH4aZe0UYWqQzAE1VsfHClrQo+iBL+C+6x990n8mEePvaetOWD7JN0dWk3xQ/K0oWsKAz9YNB2zgB/EPfLeqan+Lp0wiTX72L/bqY6dlO5Bw7BPocJJLS28S1yMObhztMV+cBdBEZvhgpJwi5Jz13xNv1INee+cNmg84qQCwmYWehyL71CMK+fl/mF2EMm1GVopWeWiYpmuq5AiNBplE7vZAzaBMNIgVdvNNdARyg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d462529f-504c-4aa5-37c9-08d882517d4a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 12:42:58.0446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mSrlSzoLIh0TKWxT4UYQszEyJRsOmXmrRrJelNxTDOtT3frTP7WELfi3e/TRPeumQL7ZVadpBMdbvoyjxA+hUCuA3qyCAOQEgvEwPpZs/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1841
Received-SPF: pass client-ip=40.107.13.93;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:42:57
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new parameter to bdrv_replace_node(): auto_skip. With
auto_skip=false we'll have stricter behavior: update _all_ from
parents or fail. New behaviour will be used in the following commit in
block.c, so keep original function name as public interface.

Note: new error message is a bit funny in contrast with further
"Cannot" in case of frozen child, but we'd better keep some difference
to make it possible to distinguish one from another on failure. Still,
actually we'd better refactor should_update_child() call to distinguish
also different kinds of "should not". Let's do it later.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 19db7b7aeb..11c862d691 100644
--- a/block.c
+++ b/block.c
@@ -4563,8 +4563,16 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
     return ret;
 }
 
-void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
-                       Error **errp)
+/*
+ * With auto_skip=true bdrv_replace_node_common skips updating from parents
+ * if it creates a parent-child relation loop or if parent is block-job.
+ *
+ * With auto_skip=false the error is returned if from has a parent which should
+ * not be updated.
+ */
+static void bdrv_replace_node_common(BlockDriverState *from,
+                                     BlockDriverState *to,
+                                     bool auto_skip, Error **errp)
 {
     BdrvChild *c, *next;
     GSList *list = NULL, *p;
@@ -4583,7 +4591,12 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
     QLIST_FOREACH_SAFE(c, &from->parents, next_parent, next) {
         assert(c->bs == from);
         if (!should_update_child(c, to)) {
-            continue;
+            if (auto_skip) {
+                continue;
+            }
+            error_setg(errp, "Should not change '%s' link to '%s'",
+                       c->name, from->node_name);
+            goto out;
         }
         if (c->frozen) {
             error_setg(errp, "Cannot change '%s' link to '%s'",
@@ -4623,6 +4636,12 @@ out:
     bdrv_unref(from);
 }
 
+void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
+                       Error **errp)
+{
+    return bdrv_replace_node_common(from, to, true, errp);
+}
+
 /*
  * Add new bs contents at the top of an image chain while the chain is
  * live, while keeping required fields on the top layer.
-- 
2.21.3


