Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3485C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC23206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="q3vBSUML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC23206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8pVQ-0002JU-Qe
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pU7-0000jR-Ta; Thu, 20 Aug 2020 14:40:23 -0400
Received: from mail-eopbgr00104.outbound.protection.outlook.com
 ([40.107.0.104]:1630 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pU5-0003CQ-Ky; Thu, 20 Aug 2020 14:40:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXitKQyUrNjzWc16g+KLqwHNCCjTe+5M4loxsAQ+PdaIUWkmzpeljy6vXHP2+hb2uMyPiyScqjv8ido+WLc4xJycq6k8u0zP7Ndt/IWFvvFl2zurs/8jSY50AJKPbvwygB4wc4vx9oWm55jtZyNvw5kYWzgwFL/cM1wyJLGDHTnxE75Ecbi8VX3VWmCqOOvYhrqh/EOAnxsedrO+QMZjGNab5M1+6yRjnNkXgrllljA0T9XADJ0Q3kiKUltNFl2Xm1xiCPgyj8k/2sIdkou7+TWhKiq/Csrsy2OJDfXQTgCESxgcaSFWw+9NRlvJVFX0MxvxU3gKJRr5JwgJ7DiAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF2PaB+w+zYUXs99bK9Q70bwF4UMXw1gH6C9i0YbYm8=;
 b=SZRCYul1GOl3CqF3PaX7O4b3f6OT7HCTA0GwoueTZpJQ8SG5rI0kE9AJn4he1SHBv27k00iIzMyWAmwTei9NFS7XROrjXS4vFShi9wqH/8K/tIkI5yIa3J5O6BxRErTVTOKLIrPFXNcWM9vQGExP/a6Dy3kTCiZPjXYE/3DWk9g82mqwK46e16T8PLlBfxtf9hiq6t4AkuX3zpYHS9ju6W7mshd2twU8Wy8XWEIkAKdVwVvIIvDy8pWOHQL0G+bnR8GKP8gBPYnW77owP9fY0o/uKWm9feU4AF3Yk84WpUDVm0QpaROZibEj78W3GENg6RAcyuejsADrQ3zefWmj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aF2PaB+w+zYUXs99bK9Q70bwF4UMXw1gH6C9i0YbYm8=;
 b=q3vBSUMLITrEB5DROT1JvYF+ejRBdeEpJZ9yDbeYVN5aKoeiL0cBXUg9wma9wGoOTBKuurqNU5Kkjs+fFDtPnk4BZHNZCVuF5gdjAaCaSSG8WwunVcbMXpN3oknwf1LNvOCAAhGBCriFC7Hre/A//4dVoZxlYV1aXyyHLktCxMc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:40:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 18:40:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 03/10] block/io: split out bdrv_find_conflicting_request
Date: Thu, 20 Aug 2020 21:39:43 +0300
Message-Id: <20200820183950.13109-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200820183950.13109-1-vsementsov@virtuozzo.com>
References: <20200820183950.13109-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:200:89::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.171) by
 AM4PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:200:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 18:40:06 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89201796-fd8c-4480-ea49-08d84538758b
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032645D84153C17076A3580C15A0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVZryucyoszKam8UxEEkJ8xJbCz/sge75jK03F1uo2UwD/iT8PSFSGwepDM2+MKaCkllgmaegPLKeWCuIjA4P7NGz6V0nbccx8YZ7Ln/YqYU5jDbGPhyxlYKLfF4CtXw7zkvV7hwZC3ntpSCiA2VPtNquADWvJhhk9vftZSkMbfiyN0uulOEeuuIu983r3H03WqnoU9CZuPg7bh7LcaXWNSiJ9BRKTUpHBkxD0wSGLhQ1DZUvl9UHx9yBtDs9JfobG3isudjYGX2QuhTnCN/RVgpYbZtZJsJXr7wBHaonDD2nfdq3Of96ZeObOK261+N0mS3fZ9f86yiEjStwCx7Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(4326008)(6666004)(8676002)(16526019)(186003)(26005)(316002)(107886003)(6486002)(83380400001)(36756003)(86362001)(2906002)(478600001)(6916009)(5660300002)(8936002)(66946007)(66476007)(66556008)(6506007)(1076003)(6512007)(956004)(2616005)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 0fv7/ZirdL7KMbrpreZ7TNfGZ1zehwXZCh0ZWLTxudC2ffm+APts0JnL5RQqyd5Nj4MV3zyDrpCO2MFsNZA+4lvDERb3LPvgy7gQgh+WY+6mpR3+XL6ZJNtG95RdZjRP2Fp57T9HYMqNdBj1p3nDMArgnJ4qUvz1+wDz58lk7HhK2PV1pajmXNMtyHoYA9JHPfAvBV4zwKSw6lyLckTzGV6fA2MZ3eaJQPDRhp69PF+52acS0p1tvNp617FYkZ6HNs6peCt5g4eLCYGDY4JRx9pwFEQrCL/SRbylvLnoYCGrdKlWOMgYK1usLyrB6/ej+P2naewok6dcCkxA1E090mihsORAR3wOBHEcGaLR2XC/s5fUtcskJlfufpQ8FORFn6uT6HYyAfKkbqoxEqgag+9kDIw9wZGxIvFGA3KT+rtl0dzFZZ3ye/pXGS/1lE4cWKyv3r6rPsd5x5RXKtyqf4A66SN+SDQR8M2DGfcmciqqBZ1C1ykXvEremZHh829phzPci0tI7pFehvXreOmr4aR0LsPxcuCpfc5UGkcd/UOQGubXlbQCuI0g+vKuUk0HM2xXH1Mfn9RKHrHYq+AImW5HjUXN3tVhqqz+p4P5sUyKqbjXBeGw2tbNiSdaQKMkPfjk9N++msx7AYH/oepH0A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89201796-fd8c-4480-ea49-08d84538758b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:40:06.6848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7phw0/8TgYffKO+7jIBz+6AIghEYu2oWzbd5i6xLlUCFoAZ0CcgGhULcMRnFZIBicpM7jaFEcYCPtnIbOfWP1+CmWH1AXEuyVajAe8j2cuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.0.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 14:40:13
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
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


