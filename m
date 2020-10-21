Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACEAC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F97620727
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TNgaf5dm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F97620727
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFiN-0005QJ-Kk
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaG-0005ht-RI; Wed, 21 Oct 2020 10:59:24 -0400
Received: from mail-db8eur05on2117.outbound.protection.outlook.com
 ([40.107.20.117]:60672 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaE-00086M-P5; Wed, 21 Oct 2020 10:59:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8rPuJlOKG8dyI9iVQ9l96pqqJ0MW4eva/e6CZd8HZ3PlJ9kZ4d0xfYOFxFO+auHoaCUoFvZhDBlsaKyXy8IeuqspTrqY8xPi5zICWqADlx8oTsEZ43GRRBkeZ1Y1oCkgLEgrczhDQgaehMqVMex1oOFeObEBigLKvKHmELREGkL3om9rh2pwNKl7iMS7aAxVhViNSVkhoAKQNV2fNq11ivc/6RkkN/54BRhaN9v7MdBkeklhAeEU4wXvUlp42elBBo2nDOFrE4ZvfyM/vSw90Nd2wSJEF8CSxgUfEIxMnGF43R/OS/mvRvJXwkKrM/WdrHqxfMUX1ApdO+MU+hmoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcwjL2naG5md/UpCH2nH39vXfGJyfFAGa2NvQWAG5V4=;
 b=XdB/vrol/oRPfKRtpcsvR1Be0oJkPFSntc7pBht+lXdojeJsd4EylWZcrF6QkNHbEyXlCaxCAk0shD12udGQ3u2ylMdss/5BIDqwpBw8bA1efKG/ChAaLCLyymfEsS8SWE7C1Q6WvcyV6raF9XsNo/PeEjifMYEU7pjC0fpeL3UVfpV00E0zbIa1chjBlBzTvZPbtsPs246zOGxCu4zh+1dKON6WvaJ5azCz1I5WPrY8NbIjbi+6/vTa6/mdegVSafrE6dWAcxR+Uj03Ww4Kw2DfhwFJKmtmCCyyBdd8JnLmeB/kiza5a5W+KeJDxtmE98fzINarwgE9S1Q4cplZ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcwjL2naG5md/UpCH2nH39vXfGJyfFAGa2NvQWAG5V4=;
 b=TNgaf5dmOjvGBzHKz3ah27EuoM0Wsu7kyglNNz7PsmEHaKvNzN9cc+pT1b6WtnVXU2DHx+mSGGC6C5ZD9VN/zw8O7BtuKhLiMlCuEODpKoZQo90buJhlTJHW1Gc78AQpGHcamwiwTyLyCRPk5c8k6DFpBVfjFOkf9zMH7WHuDUc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:15 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 03/21] block/io: split out bdrv_find_conflicting_request
Date: Wed, 21 Oct 2020 17:58:41 +0300
Message-Id: <20201021145859.11201-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201021145859.11201-1-vsementsov@virtuozzo.com>
References: <20201021145859.11201-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR03CA0091.eurprd03.prod.outlook.com (2603:10a6:208:69::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:59:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e13ea53-ac80-4265-297d-08d875d1e0fe
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB447208FE0C05C6B6E26B3450C11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exPYuWq9dDUtrjfVEWiWaST3vIDS4x4+vkSj6kGLWnrvk5fe/ECYMP9MlHLMofEUT19OqGfOt/7fHQuimHBwYiuRVcmbLq7Np6wKkCH1ciPdHVsPrgTFmOfKbD+meHVb7+ql0MGkmAB4dqvQZ+S0dqovaLWWLy9B74h+GiYC+NzetmHl/x7Mw0KO2TCOUk4Iy4NwHyzaIpB9C7/Yqf87qXsAHnFmesIkyJOB+f85I9OR7pUv0jPwJ7M/6l1qE2fofud6yoqr5GhPDhKwQz6aQWHGno4ScYZow5Del1ipA0vryvdHG0XMldZItWUrPSYTCVrI/PyOMI+rJ9cB2OFzLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39840400004)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dGYoZJkSroLGEidPRZ00GzBfyBel1u6+7r5hU77VDCSEBKA5BV3rY/Ow2IERAApyxlFbxzzQsr3N4dEYlGH6rZhV6yhV/Cho52OM/crmYwHRcsKcgdowBYWqdebJTTL2o7SwCSIiuPn8zQVB2z1VFjD3UPeDephpA6vOo+H/6bbOF4M7iTlPx8+++MHm5c/qcNlhmP+M0nLT86M0tcjB+xTyfKMJCRFQwWmK/TEuz4PmAR8ojTP+idcuitIMuPHNTyw+5aw7uZ8HmgoicHL3Nx2inxdEIiNzGIw5CHACTBKKuTXkhm6Tu7oA/wQX4hDomZ5LyhZdcvBP49KCvsgzwJvIkbh4Cyu2Wd+rh5KfSyaNWJ9wIm/nNOY+BJ1niw0Srpu2Oof34JBFeb95IiW4nWo9NeyaaBVMBnnTRCwASYmBy2U81JsYdRNnIzGchOJdpz5U9nIIoZ6LdcPiSB6xGh6IiSZp5zHqmZgD2iBN2r2Mdbf7gKIg1ZekBwxvywDXsgAOosO/Yo9qWio4hLxS+GZQqBSdZkB1am2D+VkUpnVxrBkYFAblxz5r72m8q504UAlJmfB2Zn0OC71AJgWy6+NiA9UiGjqnl2af6aECC0nn2QZxdPgRd7h7PuCZgQC8XzD7307RqXIBYmzywhcSfA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e13ea53-ac80-4265-297d-08d875d1e0fe
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:15.8065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeB/DMVBWnnYwys0HiVwZvY+fj57RdF/yQz6Dru5QM1Oe1d9zdLO1wryvqEIy3ewZqS3omPDNZscTMDL+q7uHY+M9ASlBxHltweKpH474A0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Received-SPF: pass client-ip=40.107.20.117;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:20
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To be reused in separate.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 71 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/block/io.c b/block/io.c
index bf6d4d5e77..c2d9b1f849 100644
--- a/block/io.c
+++ b/block/io.c
@@ -728,43 +728,54 @@ static bool tracked_request_overlaps(BdrvTrackedRequest *req,
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


