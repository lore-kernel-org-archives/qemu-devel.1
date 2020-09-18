Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED0CC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D67221D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="j61CWJPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D67221D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJL5g-0004Gm-VN
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJKzg-0007K3-AJ; Fri, 18 Sep 2020 14:20:30 -0400
Received: from mail-eopbgr40094.outbound.protection.outlook.com
 ([40.107.4.94]:32391 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kJKzY-0004dZ-Os; Fri, 18 Sep 2020 14:20:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFT2vGbxcX46G3TV7sMBfbITe3Y8V4rtuBq7dR6db5vrBNVamkrR1zPO+9chHem4E1Z4rIeg6mCP83NG2ikfEhFCZbbb5L/sUN5isSe0mz2TUrsjLTJmDy3QjwJanTsUq7MIbSGzwmJ12RXcuuAWJ9POu1nzLxNgxG4QYDdSQwdDnOkcw/D2+FjwUPt4hHH0QD3VKqG2pC99pO2OPAF3N/nixYU2FtioHj0VoRtnG7cQ5/NatyUexcdfAjvFTUhotY/oIRbVRpJvSaGJqk6XXZcKzEcae0+COehLNIS1/9aLGGVfCPohUWaEtwnpUpR8CTDrixIpBakhoa7eyYDhXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXZdwrj/9t/abLl6GSP7mG0tJiXgJv0q7ngCCct0T7o=;
 b=VBUnFT7AyaSp+7AV7E2O8Nr0e1z9EuKvWzmCait6vSthiFRO/lLu0KffursysfUN6F9K/C5DVY1wQJDklL38+E/d4MHqbK0izRZUdQdEviRqRc9MZu1kDprhz521CrDmaCHqbagi9wWTm/ntyhSoJ+lw65SV7wH7yT+/Oc+hlQdlgBvjRGyKRPDv5gt2Ats7pOhva971U2wA1a/xnNcSPXch3Hjx3xcSWfjhcA6ZVxfM0U0wPuT2p9xB8LaWPWpKQdRu0Ct2A/opR4i/Ed/IB/AoSWDdcf4BsTlow/YyC+ONjSDqrmUJ/OvNQ3CtAf3I3O5V/tixWj3x76krnvCl3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXZdwrj/9t/abLl6GSP7mG0tJiXgJv0q7ngCCct0T7o=;
 b=j61CWJPYubHWN1mTxK7XCLJBo5WqwMzuFSUcm5mDyzSnSoUhugBAUkgwAefUKHJEf4Yo8twzB+c9BzpSg2Rit9+yyRjiHGq5QnKczcF7LbhoOKt4Pc67o7fuc/h6N39dbboBzND4VfM7ALKFraaDlzbT1VMrek43Fn6L3aFXo5o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1905.eurprd08.prod.outlook.com (2603:10a6:203:43::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 18:20:07 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 18:20:07 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com,
 eblake@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Subject: [PATCH v6 03/15] block/io: split out bdrv_find_conflicting_request
Date: Fri, 18 Sep 2020 21:19:39 +0300
Message-Id: <20200918181951.21752-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200918181951.21752-1-vsementsov@virtuozzo.com>
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.106) by
 AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 18:20:06 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94b77a62-3989-4f67-5e50-08d85bff7874
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1905:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1905F041B618A26B4F6F5E29C13F0@AM5PR0801MB1905.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6atG4BOncKW/pK+56G0dMOtJa8RlaJA9/yGO3FgqQZerjlbkU887RnGnauiaXrMSxOlkgw5Q1xIyNQ/+VdMaUUw8/g76QIOZOAGMH2AV3tWkzf25b6RQBhXMv5sb+RQlh+pqV5MTRDSkkqW9gm0Hv88aXgl4LMnpvXcugVOE9IfyxEVNZlxLCpc/nz0eILGoQ20RfCJEQCOM1JIGeoxgSz08cdALPy7CNHgu7W3SeOY46gSe2bs75ruajEle6YhxzI0vPNrVjZpQ1wuTbd3fp80QEYGZTuIDAtV+1aSAjbdJB/exzdbVBvEPWow26MDEHZ+WJ+x8l2s6PHHwOqDS42SyAQCwUwqKWcIt2Obd4Sbohi/tspQDWp8Hs/C/QJx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(376002)(366004)(136003)(346002)(66556008)(8936002)(66946007)(66476007)(107886003)(6506007)(2616005)(5660300002)(2906002)(83380400001)(6486002)(956004)(6666004)(1076003)(186003)(8676002)(52116002)(4326008)(316002)(86362001)(6916009)(478600001)(26005)(36756003)(16526019)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cA6w96w309KadQL3mWa42lvogCxrlhUxJBFxODExJp1ymwJ6aE8sXNz2OAkAfag/rjlTCIW/XcfW64u/HwUK+UNxzECknYeTlPkfHkq7bHsZJ0eq+h7782DagQlJRweltaqi/2P3UgDjl1itYr0FFsruf1QyQ06RlIc8lKmsoOx7iHsRkHw2Vm4TGGdQshoVcmUwBnr+Qy9Gskowvj9nofJmnQeQw6Eb4yQC6uah8jqENYg/jIU0okRocRBJ2zTcx4LPO1D98iZWXrdefBWrUKzWWaUnJ+Q9a9y65XfaiYcaUwSw7QdDtP1zfs2tZahfyv+rIE7G/HXhlIFNgFqL/pXpu4C2WWVNm6il0jtpSy/bU8Vwd0GpLoM7/CbwqOuVXxBdNXGEQfjAoszUixqhSr+9q7WRUSRPQXH28Wtl82sCB4Yl1ECBkMUdUwUbFpsDePi6oEjMYZO54IXCObuRpUMK9Vg3yQROHDP3JJFMw2yMxMU3fE6yVEIZryv9L6sHIgOnDJYN9RkNSBvhZ54fPgqU6O24QCRcYDsuUo1tPozM98TTRlMUa7qfdxmLqBU0l56NrLz6mMzMGbP7QFEQq3nHmUHY20w89JQfbykztrevSxt9PcNiVdS1DxqwtGj4pAWBJQRAaktQ8fpw9hLgyA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b77a62-3989-4f67-5e50-08d85bff7874
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 18:20:07.0825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyUrki1cF+CGPAsoP7WV14rAbkbOpZfCklaCEZQbFQ8SnwAPadN6Fxjgsd9eu+my8ajuxQ2bkWKxxNP4EQE1zgGSrdBcepOB87pH6j1el3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1905
Received-SPF: pass client-ip=40.107.4.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 14:20:14
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
index 67617bb9b2..c58fd36091 100644
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


