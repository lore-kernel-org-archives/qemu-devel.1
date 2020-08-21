Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E684C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:16:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2758D204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WalgxZzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2758D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97qA-0005rE-69
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97li-00057w-KL; Fri, 21 Aug 2020 10:11:46 -0400
Received: from mail-eopbgr10117.outbound.protection.outlook.com
 ([40.107.1.117]:9536 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97lg-00054o-Ry; Fri, 21 Aug 2020 10:11:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBrenY1rXGZ2MEfMSV6OKN462YBMhnakkCO8Ki/aR/6eDevVWhe9wiNoJFrldISHjaWgpBq4WQu9gL0ISKlaFrijedxprEDnI0+KRq/YgtNksNDycCFpLfYVTcCBJ/NeVzB+iL9bcHoVWZysQdY82I38HS5hmk5in8h/SAGRqG/hi+RGkwNLpb8PoZK4Whfa8+tAFjGIcTxy/9+lu3ZIvjIvqBgZPBKWKPYHbLS6bLSfdxiLMhf7oTxEIwnqxpZhIxFUfk127Lf+fnQRHRJRfjweuCDXpyIFjdD5zJr01PGdYl/SpjytQXNGKuSmjcHsRst113hLdrTZpJ7sMkeXJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF2PaB+w+zYUXs99bK9Q70bwF4UMXw1gH6C9i0YbYm8=;
 b=Vurzm3fzn3MJo/ZNSaies57JsD++lAhGrTWznhqPgRumZh7oqpSlGddcxaL+IMM9bHFK/qtBHC3wwGGYQSSMYUOSmRDE4OX5Y60jMWL7lKtXRoFoCH4fAFib97aAAs0EDopGy5VY5DkjBjYqema5XXSWuFbTvjWMSUjnBPCsJogH+kZTLUKi2G42GN8gRdqnYIJhAEodxE93soJO1JJZ6HNkfE2zaeefGqE8WyME7Ek0EuMC/6g9HBJtvj2nNqpBlcZdEEnvCJowNcOHw1wsWYS47Fmj8gGHA9nidlyeAMLiSVB1KUBftCifa/xU0wkGYtKgonXLgeCKuW3lynQvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF2PaB+w+zYUXs99bK9Q70bwF4UMXw1gH6C9i0YbYm8=;
 b=WalgxZzzurya8fIdfx3DvCuZcFkFukATf4Y7zeQiwTafUM5rMg/mEjA08CCpv6AqIZry+wUn/bCui8R3UVdZWitgWZmAvJcAZlzfLJON5eqNu0PS0wW9U+yLO8LL+jc6sqjsY7VtWqIBlQBAjA9RzeIUr07TPpDZsPVCsjDub+g=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 14:11:40 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 14:11:40 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 03/10] block/io: split out bdrv_find_conflicting_request
Date: Fri, 21 Aug 2020 17:11:16 +0300
Message-Id: <20200821141123.28538-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200821141123.28538-1-vsementsov@virtuozzo.com>
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0139.eurprd05.prod.outlook.com
 (2603:10a6:207:3::17) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM3PR05CA0139.eurprd05.prod.outlook.com (2603:10a6:207:3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 14:11:39 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bb97938-68a3-410d-85cd-08d845dc1fc4
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB549559289AC4D21ECB137274C15B0@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eeTpQcwuVvTclXKzCrcGQUBYGGRfNcHMZqWWIs3Pu3mI6v2e7ZNsxKg5nBHWWZ5k1Du5KOr5hTHIGcueYla6SLRmLD82TzT60Sf4lufuTxaQI00WppWEMp7V8RceuK0uoRCpmQ1msLfsvYjwBHTtkIHCxy+tVep2CLrC/AAISvgARMcy4WL0PySXnYcVaD7/V1BA1CCHYH4EDHTt6MWgiMcuNq0n39d5UJWwW1i3AhNLtGJWGICyIcE29vN+VQ30Qi4yZ4u+pmRwLS/2mJQsEizHUY1BER1DCz/q/CTLmHaLPVvXvHwDn5lasikZHMiL8e2u4Ck3tyiQ0s5vlfjcWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39840400004)(136003)(346002)(376002)(366004)(6666004)(66946007)(8936002)(66556008)(186003)(6512007)(16526019)(1076003)(6506007)(86362001)(2906002)(956004)(2616005)(6486002)(52116002)(8676002)(66476007)(316002)(5660300002)(26005)(83380400001)(6916009)(478600001)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 658i5Zc3i3QAjs94p6CqjDQzZZ13N5AaYcq4ylfMn/arZ2AmYbJiPcs7Ipb1XXJ+sA3vcikxw4xvNn2PzXfoCbLn3pV3mCZZgItM3Zcfh0LqqRHdhOzRFRUTPmCgT42E1suayw7ein7/jrWtwhM0OYB//ZwRO1bJOHfJXjL1fS7tIPmFQ1MlUhGAyBoMXEC8d9g+Th6oOhiyv7Xx22/Ht9SyCyR95MJhmzsmZopXvwkJU9I/OEFssGD/pdty4bI6DHpFj2/db/4h6pQLdMdR+8BTk5AAyq2A5paWNmzupL+bE1MqeWBjyTtGhU9FK6/z+2LAc1ZlnYuSDzMgmYLGQEc3u3dJZ5p0nxj2Z81vLfeYXUHTuIIInX4+EL4j7E4f54S5c+1mAyNkBpOrsIkAZHjCFIQV253eJNYgRYmVqwqUzdBX+PXb4FGDtfsf8jEFsBLRyvb2dvZ0hK48cxZmQ0ogctEdj3vX2Fu1T0o5wCxqKTFVkOvFJR/w+hzIab+V9XEKDM36b7Izuaz56LhcXdOY4c9c35CVpKBXzuTv+Q9mWizBEj+Eq5xxSQ/FuAJDrY+o30OzKP+FdAxjEsGARQJUjUnqMOQl424zwTWpjjwAvKRnICGXfSjxQPmDgDwvXolpgVwxZhTXzsm++VnW2g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb97938-68a3-410d-85cd-08d845dc1fc4
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 14:11:40.2573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyTO1F9Dxc2u3tuSqC5kchlYyu1kuzd3nMNGIBjh0o7W5DspKWcx6Y1HYJY9yTf7yTy559aY+E3CNAuOXQ9IB/OrHa7t76dcGP3VTyCt+sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.1.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 10:11:39
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be reused in separate.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 71 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/block/io.c b/block/io.c
index b18680a842..5b96715058 100644
--- a/block/io.c
+++ b/block/io.c
@@ -727,43 +727,54 @@ static bool tracked_request_overlaps(BdrvTrackedRequest *req,
     return true;
 }
 
+/* Called with self->bs->reqs_lock held */
+static BdrvTrackedRequest *
+bdrv_find_conflicting_request(BdrvTrackedRequest *self)
+{
+    BdrvTrackedRequest *req;
+
+    QLIST_FOREACH(req, &self->bs->tracked_requests, list) {
+        if (req == self || (!req->serialising && !self->serialising)) {
+            continue;
+        }
+        if (tracked_request_overlaps(req, self->overlap_offset,
+                                     self->overlap_bytes))
+        {
+            /*
+             * Hitting this means there was a reentrant request, for
+             * example, a block driver issuing nested requests.  This must
+             * never happen since it means deadlock.
+             */
+            assert(qemu_coroutine_self() != req->co);
+
+            /*
+             * If the request is already (indirectly) waiting for us, or
+             * will wait for us as soon as it wakes up, then just go on
+             * (instead of producing a deadlock in the former case).
+             */
+            if (!req->waiting_for) {
+                return req;
+            }
+        }
+    }
+
+    return NULL;
+}
+
 static bool coroutine_fn
 bdrv_wait_serialising_requests_locked(BlockDriverState *bs,
                                       BdrvTrackedRequest *self)
 {
     BdrvTrackedRequest *req;
-    bool retry;
     bool waited = false;
 
-    do {
-        retry = false;
-        QLIST_FOREACH(req, &bs->tracked_requests, list) {
-            if (req == self || (!req->serialising && !self->serialising)) {
-                continue;
-            }
-            if (tracked_request_overlaps(req, self->overlap_offset,
-                                         self->overlap_bytes))
-            {
-                /* Hitting this means there was a reentrant request, for
-                 * example, a block driver issuing nested requests.  This must
-                 * never happen since it means deadlock.
-                 */
-                assert(qemu_coroutine_self() != req->co);
-
-                /* If the request is already (indirectly) waiting for us, or
-                 * will wait for us as soon as it wakes up, then just go on
-                 * (instead of producing a deadlock in the former case). */
-                if (!req->waiting_for) {
-                    self->waiting_for = req;
-                    qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
-                    self->waiting_for = NULL;
-                    retry = true;
-                    waited = true;
-                    break;
-                }
-            }
-        }
-    } while (retry);
+    while ((req = bdrv_find_conflicting_request(self))) {
+        self->waiting_for = req;
+        qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
+        self->waiting_for = NULL;
+        waited = true;
+    }
+
     return waited;
 }
 
-- 
2.21.3


