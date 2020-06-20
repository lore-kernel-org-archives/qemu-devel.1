Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC17C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 14:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268A023BDB
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 14:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n+oFodgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268A023BDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmed7-0004Kl-CA
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 10:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmecF-0002Gd-5Z; Sat, 20 Jun 2020 10:37:07 -0400
Received: from mail-eopbgr50102.outbound.protection.outlook.com
 ([40.107.5.102]:35810 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jmecD-0004UK-G2; Sat, 20 Jun 2020 10:37:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWq+q7/k1hJ3d1MxNAjeQNAIA5tvgQlsrxGaRJiH503csC96C2sfRcVXgHSdCGB6qKhQxB7WnvxsLQJC7Gsb60ybxjhrJd928Z3RWiGTZ1XsRjaz5h7FywmtU61YDdXzDhdNpylQrnVk8cTNfd9M1WwqpNHyN8/W655vfW3OMZgcIF4etxMTXMGmUB39rlUc7Lv9izbU4H7D2Blrgps9zuHh9/We2hfad5dkIGF1Z/WXelA5uD1w9qvPq46/0/wDDQGpba57N4k9qAOWSSDnSLQts+KSrwmZf/+V4IUAALcGqtzi8F+PptdJikFhpD6Z2G66dU7QHIeO6A/OwetlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPcty3K0u8kAjPxsNmusUaw2qSIiqRdWRRt7a+bfmt8=;
 b=FYM1qOtEcTqmBs5dHigF9rBtr2u4AbKKW9nQwxGBiz2/sWyzHGwktxen7YxieEnH2w42FA+4B6uTnTqzyeB3egCdEGdhNGy1Pkl4EdtNIGIoTXysmAuystxWLmHZc1+y8ni+3dUPU3LAM13dDEdHICXTbzFlq7+ltFmcMNhmy5VOtAVnsdKH1NmiJcBaSeG4lhRXnIBq2SdevlJWh3Yys8VZoKGZDCupRA00QQ624+fHco+3CZZjz3SGXuu9S908JTE3fJlZauFT1KacBoM/PI5nfcO4PENxvxAwk8I4+YAGCNmmaa5vKdXxHpLckcC0tr+/mKwOrcrnpMbmud7z8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPcty3K0u8kAjPxsNmusUaw2qSIiqRdWRRt7a+bfmt8=;
 b=n+oFodgk8CU2Aw//VmuVcfAeMk/KXAsofT9eC6p/V0w7zUXpaFT3Fn3SXDn4yWv34zobg1Gmn9iU2IMNmCIj8PUuGhpZmcFQ8OpbLwm35N+X5QiQvDSvt9rTVZPoB+7AReQZKbcYHtYJNGnEPuHr87CEXsM9eGqyy1wPO3KKA3U=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5430.eurprd08.prod.outlook.com (2603:10a6:20b:106::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Sat, 20 Jun
 2020 14:36:58 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 14:36:58 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/5] block/io: introduce bdrv_try_mark_request_serialising
Date: Sat, 20 Jun 2020 17:36:45 +0300
Message-Id: <20200620143649.225852-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200620143649.225852-1-vsementsov@virtuozzo.com>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR03CA0055.eurprd03.prod.outlook.com
 (2603:10a6:207:5::13) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.122) by
 AM3PR03CA0055.eurprd03.prod.outlook.com (2603:10a6:207:5::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Sat, 20 Jun 2020 14:36:57 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.122]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e6ad624-68c9-49c9-d4ff-08d8152762ff
X-MS-TrafficTypeDiagnostic: AM7PR08MB5430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54302F36664436FA9B7F4DEFC1990@AM7PR08MB5430.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPIY2ZLB3gbQHRd9A/zuLuGmvTDmqByLCWLNxTxQxi+o+BCmQND3w6Ij8bN8hT28Li5yoikfddUU3QlOeIsKZCZ7UBNgheX053QOBSxifBFTfVyx9sgY6FPhc1c/YFZyQeYP2cSQwbCW7FMXTkbOX7/zdu0hIGLnBId/gjBF2SZjYk8tymIeDoAd83H3oN5CjMnqVWr/ZjKMYI6rMwEYOiOkKjVl6o47hyLz8R8QBMMp8tLpzuoEJOzxC1AjD+aDLoUAxEDBdSSl6x5qYnCF+8ucfXKxGtJ5KkOfSFwioXOd0hjHUBT8AUi0/p2P3z279syzBeTCgeePdKm08Q/VpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39840400004)(6666004)(26005)(186003)(16526019)(86362001)(2906002)(6916009)(6512007)(4326008)(83380400001)(52116002)(2616005)(6506007)(478600001)(956004)(36756003)(5660300002)(6486002)(8676002)(316002)(66946007)(8936002)(66476007)(1076003)(66556008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: z1vjSwixaE3yGb3HAY157LaSq9/R2+wO9zJdcd3eSlU+hSw/FpSgYnksg78xu4Q/Hk8lQNo9ZcZzp7N5ywt8ZcJRBpPfHW1tBjURFLUS3y7qsVbON2I8y6uml4zRCEuIDIIZ+tEnkprPygF+AF/v4kBM1aPtO04KzuBnImZjcif6afUYeFlsXnq1Ayzv3G+iC8Q73F8zhrp6v05OXMnOIpb2kzk3EJ/UUGr5prnwiRWrEKJxTFUw2J1pWDNGfbjYh52PoH2LX/p6v9kKEfzkh5n10HPkmHh2O1N6CLX4prbwJotgkbzsJp4pwnz1DEu8lIHKVgSKrb1MgeBSG9vmoOYtkJIRidM/8lf7Q3CbeShPf9U+fExOjlWKU2tiK20e7YzcfK+8GqFZDC4MHUbGTaM+bMxyHDFcqV1eJ6efI9qjifaUQ9b4MsRnn2RRQRhdFNJfvTXub5hHtu/GY63DhgGVVvyTWjNsN9kgxso5BwQ=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6ad624-68c9-49c9-d4ff-08d8152762ff
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 14:36:58.3439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSJ3rB2IfNx+DpYIpR0W9P9GocT+kZdTTxzLVZO7erCY+lX/AJJ6OTRIMmMgAW54i9R8k3PtlFEWVHcnqG+xRqNwiVnyssmq7hp7DPpw9Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5430
Received-SPF: pass client-ip=40.107.5.102;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 10:36:59
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a function to mark the request serialising only if there are
no conflicting request to wait for.

The function is static, so mark it unused. The attribute is to be
dropped in the next commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/block/io.c b/block/io.c
index df8f2a98d4..60cee1d759 100644
--- a/block/io.c
+++ b/block/io.c
@@ -727,10 +727,11 @@ static bool tracked_request_overlaps(BdrvTrackedRequest *req,
     return true;
 }
 
-static bool coroutine_fn
-bdrv_wait_serialising_requests_locked(BlockDriverState *bs,
-                                      BdrvTrackedRequest *self)
+/* Called with self->bs->reqs_lock locked */
+static bool coroutine_fn wait_or_find_conflicts(BdrvTrackedRequest *self,
+                                                bool wait)
 {
+    BlockDriverState *bs = self->bs;
     BdrvTrackedRequest *req;
     bool retry;
     bool waited = false;
@@ -754,6 +755,9 @@ bdrv_wait_serialising_requests_locked(BlockDriverState *bs,
                  * will wait for us as soon as it wakes up, then just go on
                  * (instead of producing a deadlock in the former case). */
                 if (!req->waiting_for) {
+                    if (!wait) {
+                        return true;
+                    }
                     self->waiting_for = req;
                     qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
                     self->waiting_for = NULL;
@@ -767,13 +771,18 @@ bdrv_wait_serialising_requests_locked(BlockDriverState *bs,
     return waited;
 }
 
-bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
+/* Return true on success, false on fail. Always success with blocking = true */
+static bool bdrv_do_mark_request_serialising(BdrvTrackedRequest *req,
+        uint64_t align, bool blocking, bool *waited)
 {
     BlockDriverState *bs = req->bs;
     int64_t overlap_offset = req->offset & ~(align - 1);
     uint64_t overlap_bytes = ROUND_UP(req->offset + req->bytes, align)
                                - overlap_offset;
-    bool waited;
+    int64_t old_overlap_offset = req->overlap_offset;
+    uint64_t old_overlap_bytes = req->overlap_bytes;
+    bool old_serializing = req->serialising;
+    bool found;
 
     qemu_co_mutex_lock(&bs->reqs_lock);
     if (!req->serialising) {
@@ -783,11 +792,46 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 
     req->overlap_offset = MIN(req->overlap_offset, overlap_offset);
     req->overlap_bytes = MAX(req->overlap_bytes, overlap_bytes);
-    waited = bdrv_wait_serialising_requests_locked(bs, req);
+    found = wait_or_find_conflicts(req, blocking);
+
+    if (!blocking && found) {
+        req->overlap_offset = old_overlap_offset;
+        req->overlap_bytes = old_overlap_bytes;
+        if (!old_serializing) {
+            atomic_dec(&req->bs->serialising_in_flight);
+            req->serialising = false;
+        }
+    }
+
+    *waited = found && blocking;
+
     qemu_co_mutex_unlock(&bs->reqs_lock);
+
+    return blocking || !found;
+}
+
+/* Return true if had to wait for conflicts */
+bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
+{
+    bool waited;
+    bool success = bdrv_do_mark_request_serialising(req, align, true, &waited);
+
+    assert(success);
     return waited;
 }
 
+/* Return true on success, false if there are some conflicts */
+__attribute__ ((unused))
+static bool bdrv_try_mark_request_serialising(BdrvTrackedRequest *req,
+                                              uint64_t align)
+{
+    bool waited;
+    bool success = bdrv_do_mark_request_serialising(req, align, false, &waited);
+
+    assert(!waited);
+    return success;
+}
+
 /**
  * Return the tracked request on @bs for the current coroutine, or
  * NULL if there is none.
@@ -865,7 +909,7 @@ static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self
     }
 
     qemu_co_mutex_lock(&bs->reqs_lock);
-    waited = bdrv_wait_serialising_requests_locked(bs, self);
+    waited = wait_or_find_conflicts(self, true);
     qemu_co_mutex_unlock(&bs->reqs_lock);
 
     return waited;
-- 
2.18.0


