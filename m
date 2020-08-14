Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE3DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D66204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JIs07ixf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D66204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZPJ-0003FK-KL
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZNq-0000xQ-RY; Fri, 14 Aug 2020 09:04:34 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com
 ([40.107.2.139]:54037 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZNp-0006by-8r; Fri, 14 Aug 2020 09:04:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jx0ocQ+plNSdIMOMu0xiuH9NSYD/WWJYxIHQap2s4jghuU5JVXrgndtpFuu7fxhAV+Rweb+eZxqd2QQWLicVQUUkbgW6Ozi/7th8BoR36uYEF07A9r5GP+1So428GCMPo2t8xdBnCS5jVO5lUeNyz82S1KVAWG8kS2McjHLEvar+xFqOrevZ/GNDWDJU/k02XsVw9Y1kE+LQPudeFy8jgP2VJT4ozMh5lOcARHw/L5VWEXUXVxmPlvQDDY7VJs3y6UjPO50PU1T+tQh9eItbmyGxSvpWJ7gkCgFUhcnh9/fMiP4OM5OTZ5rPLyIprDLn6D6RiYEEzCFJMHdK/PmGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt6BKgkearNoA7A2Lu8N2WLeZpeT4qOhZFDsJpPCm7U=;
 b=bpxbfwhtiJjcbbx3e30+1zPXgeI6JHJTpk4Hq09khLVJvGRO4/osdVFBPzd3a4F7c4Hw8MgfPLQUjFluIwIezsVPyxYecVk2cjZXZ5+Tq2+fnFRCyx6I3/rr3KzVB0U8JSn8Tyxu6Z/xnNYDSK9QykzwgEYdpD/UyPn03p5RqE4YdmKPAL6zgGEz449o6lXfM9G7VE/dlZ0XN4GQk3LJriJF1K46T6Wg9g3lgaiVseyh4BCW0+J+tfdwpyZDiyX7TMfiHlLlNaxxZ5WW7E58jpBeTt7S8hQhlU2h5S3tpw9qeKKKSkLHZqImT5wqfGZJYt4g+qhtSg+jh9o3Sd2zCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt6BKgkearNoA7A2Lu8N2WLeZpeT4qOhZFDsJpPCm7U=;
 b=JIs07ixfyDdslF6euPRONr60fTO6bfuwVRxZQnEaua3fzX1WiQU+myE+wWDE6HlkAuya6kTz3LbIypM+vOHKmwlkhdVQ73LpXSQVnl9iksIf8W7nRcpJQG09MvFCTj8xvLzcUUUZqNPXtyLaA9CbLW6V7N9msstkJqIGKvDtFHE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Fri, 14 Aug
 2020 13:04:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 13:04:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/9] block/io: split out bdrv_find_conflicting_request
Date: Fri, 14 Aug 2020 16:03:42 +0300
Message-Id: <20200814130348.20625-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814130348.20625-1-vsementsov@virtuozzo.com>
References: <20200814130348.20625-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.177) by
 AM0PR10CA0075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 13:04:21 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e8842d7-74a8-4e60-f952-08d84052901c
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2981965A3B97FBE3642EA088C1400@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fokP7NHS3Of4vsUkUPCxs+T+mj2NUSk106gz/pIj21PlM1oJ0V1W5BcT/hufUOuVooDBHQv8UlE5ZcKUmBKrpOemljavhJ/9U5TCsT3OUjpCHzVkkePPAIHu1uRX9sRD72D8iAKmDpj0TrJSsf5X4cKrG7UmLkRh+i8Ph5hFCa4Cq6/Lyj+JvkGlpwYRkJoJwXnhtQhvpw4ndWNUkzKcWgxWbff5lg6j8QjSDSs1/CnzE7okSUKzNYzQAqrO3EYB8GxSjX4gVjKwUR7a5fD/QaJKBQYThgnhn3HdIS8wWjvXlWJA88Vxe3vNfrn6/AWmE4X1qKjevfzXZdaPYnOjcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39840400004)(396003)(136003)(2616005)(956004)(86362001)(1076003)(6486002)(478600001)(8936002)(6512007)(6666004)(36756003)(83380400001)(5660300002)(8676002)(6506007)(16526019)(186003)(316002)(4326008)(66556008)(66476007)(66946007)(2906002)(107886003)(52116002)(6916009)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: evXrFl27hKRy/otG9sVySQB7Tt0YNojNOp6iHYZibdTLvUN5o/fA4LcJBtnMbq1oCPo+aO4KFa4z2FqJOY0OZMmkwGz4dGWhOBC/ctcObbMQvlO8lwY5pveP/mvmr0IPqGKzdgvGKVSPkhQVFjdGudOO1BgL78JueyxDC0sQ8P+sm2napVQ+T4xtvJSK/MqzDtPnoA+0MFh/XptF3Z5G5taw3t7Sa3q6xfh5iNJHRxA5PzGTOgJQ9T+4xCFsHZqXE2MMzbxlrrg6HVaLP9Yn6jShrY4nZ6K34Z1iZ0J+GjSUrjz8jSFb+0L5Sl3OyfEl1kesW7213RfON5dOgKRHCPhnasCCW/lYhWRAoqjq6nsqB4lQRAGoupcZUkKp8DDLrF+stnaY9UEwGRHHBe/8iOq9YU9Qi6l3xTSZ+fj0/pFT3jTevbYJz1mctEFW5wLbxc6WzAYInaw0HV/fi5bMpoykruOujd+SPAfMFnMKtEdvZTJ4GhTT+XDEVxXln2hKjS50cZb+wKa8fGhyOiZsUuQqr/9Ccom3mg4nlfgWPx+gnAPMhv8ek4fei9nO9GPBCNMsuvZP8OijMLWyguwKk726zn2YdeJ6P57aTCqnVW8F6E7FSlljcnvZ5GxfoxuTL1QiJP4Cl2W2Hh0sBFF9yQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8842d7-74a8-4e60-f952-08d84052901c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 13:04:22.4957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yR1fco8RN6oA0UrV+0paBt8TRLlcc44WYkKMYKfz7FtSvP6pdbwslxXulFv/xy4l7J7G7Nz7P/X5ZIXjLFXQ/YQ2vBQ+BcuoRd3Ao/Cuwz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2981
Received-SPF: pass client-ip=40.107.2.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 09:04:28
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
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be reused in separate.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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


