Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BB1C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE48204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="jE2U/ZbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE48204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZPG-00036r-4L
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZNu-00010n-2G; Fri, 14 Aug 2020 09:04:38 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com
 ([40.107.2.139]:54037 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZNr-0006by-G8; Fri, 14 Aug 2020 09:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uee0q6RZB7ZH7maYJpFnI4oI4GQXJR6W/8/LiOaK0qerqUjQJoMGzsnhyEuQPAM83vbPm6QthfIp5zLrGBhzRl5sF8kWg0wDmQjxQVT8g4Lw1QwSsNsVEJSZcuWpIb7KRZ038PP8CbYPdHCM5pqd8ea2wkNZGVjwdc+00NgEj/Ow6ctUI6q+3S7Igrvh9C1opSY17hPKsWIQa4fqEzluaas3fY5m6oMIrGsXvbygQZu22NC2pQ1n09LQ+QP/KR6QzbJKqLsBWNPTSDwdvag0Oyd3w7+2sqE1FeBLK2LwAAFR+V/qTIZYEM5C3bcpmxThdeW/Wct/c0NvgyCyNJ2Xew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdP/EqKzuzIg9SGZYyN3O24rPXtDSLay6nPV5SwsRSY=;
 b=THpQZfX5DWo3fF1VUG2WbMutUBDIpQNJp0wRLuYeLv2yi4I6IUN7mAkfRV/2UxNIshh260JyHgd5kzJz2VgoY7HV07K6bnU/vMXdJexzBAT3RDUcsTfSLY1b8AEmZS7Zcl5JDpKN4AwB3Z6clnDmTKFiTtrnSWFtvvow1p+cuQ1uwtJO21uqPdiW07t6pHSIKNi8AZrqN3wRXvBGnPSGDOskbhOy4erFwoCY4zyO+w65BWG4+zK1ClEoenSlTdxuimZ1wMZdd7Jb1tQ/f1Q/xUdaJlHnPjRH8nxJavZ7TtlXOblG1n66A7ltvY0+XQW7Fimhn2adaA5x2maa02G0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdP/EqKzuzIg9SGZYyN3O24rPXtDSLay6nPV5SwsRSY=;
 b=jE2U/ZbNEbLiuzfTQ0PzqxFOdoNSkU1h3ACOaq1FDMQaF2Cucbxp5+VTx4N5JtnZUZe7f1IeN3t8afWjHz3FY92hRftT+xEn5xTIs9dLqgRZg0tFBmz+ChZPjkIjT1LRf4vrk7mUf00s8XKpKM6q0zN8ihuWgStteHgLAHqqBmw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2981.eurprd08.prod.outlook.com (2603:10a6:209:44::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Fri, 14 Aug
 2020 13:04:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 13:04:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/9] block/io: bdrv_wait_serialising_requests_locked: drop
 extra bs arg
Date: Fri, 14 Aug 2020 16:03:43 +0300
Message-Id: <20200814130348.20625-5-vsementsov@virtuozzo.com>
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
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 13:04:22 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09843c2b-26d8-4801-2fb7-08d8405290b0
X-MS-TrafficTypeDiagnostic: AM6PR08MB2981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB298164E56FFEE7ACCEC365F0C1400@AM6PR08MB2981.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Algk3QfeUYeF73hbaV/VU6rM0PT/srX2WyfXhnYmBOXdOv+yK3E3DJSNqu1AvGhl7sGm4NMpJ7Rlpd6fokskV24zkjX37VQdn8+7lO6xTgsmrayPlnIUD/vd415YZEU8DSPSJhcBOGhcasJ/xwPYtn8DutLotSbMubvvtCubH75xZWJoUN94S88zFaa7szQ06Org1mxDpjpYH6JGpJ1gYz0USxTjFWyappZOxXyTL5yXgYVdeEmz7r8VWP17yrNyKLZMqd53I9fFQg0ixRacjiMry3XZmIu9kn7KdHJ3EQgPYDXMCtAwaoZ3XMZbk/APS/nfPU0Ho9irPx1P+H7xqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(39840400004)(396003)(136003)(2616005)(956004)(86362001)(1076003)(6486002)(478600001)(8936002)(6512007)(45080400002)(6666004)(36756003)(83380400001)(5660300002)(8676002)(6506007)(16526019)(186003)(316002)(4326008)(66556008)(66476007)(66946007)(2906002)(107886003)(52116002)(6916009)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 7jE5IokPLtw1NXg53MgfxBFBwbidyuOtCm8EcYb3dAA1qjw2BFIK/7hUw7v5vNxUsRhhzCisyQ1jPjaCd5Gvnj/2FpPJkTVdsNfUw12nBrCvUSy/ikTg5uZE9Fdd2+euPbntIEYvgGJ3KsGRD+wcn2JOJMHRJ6k7zQzvwMqqWA7Mx3T8XahjjzlfTbqs+660l0y4L/FXSv8llHpmSTcF+taFVf0GXhieJpbAwdCBcljir/lTXLCUynjVZjhhqmca8WVyBbPTt2OmVaO5hnhZqhPvbm+UvyESZDRz4kKqeoT2VW+tqNXBK5A89Kk3gSD18oNgLsAcxlJyOGz1wjAEeUTBwVnQCQy6+9kg/ApG36WNJcWsHORi0tzT45zvG4W85e395eukcjC8Q1LJl/GBW1RgGOMglRNgbXXNwcAzMNRKJshk6RcyA1vxFz3AT6keqiNFzGXNxaAm/c9E4zxRrVTgHWYgs9k3WDL9S2UWRSoVPyjm6sKV140xL3uzmygfqJ2zADMe+0JA1u6NjH3clD6q7Hcsnopk3uRaSA7K+YlbG1tD+C6LaksxxE1xEWFVOdGnMqJwFQ5ZC7tTsi13325xkIJWTkwPGWTkrVh0Q0PVEueah948jiHdan6fQp7AXJHTS5hm4l0oCHx/drFjKQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09843c2b-26d8-4801-2fb7-08d8405290b0
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 13:04:23.3240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +4ScU6mK6tTuPpgMllGr7DpcUvjGfFmJ/WjDUEcv24k1dMmXYz1gazB96BZK4Bh5zf9M+Xl5e2zsfgIbbYbV1c11+e+U0X34xJZbJESZs9I=
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

bs is linked in req, so no needs to pass it separately. Most of
tracked-requests API doesn't have bs argument. Actually, after this
patch only tracked_request_begin has it, but it's for purpose.

While being here, also add a comment about what "_locked" is.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index 5b96715058..36bbe4b9b1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -761,16 +761,16 @@ bdrv_find_conflicting_request(BdrvTrackedRequest *self)
     return NULL;
 }
 
+/* Called with self->bs->reqs_lock held */
 static bool coroutine_fn
-bdrv_wait_serialising_requests_locked(BlockDriverState *bs,
-                                      BdrvTrackedRequest *self)
+bdrv_wait_serialising_requests_locked(BdrvTrackedRequest *self)
 {
     BdrvTrackedRequest *req;
     bool waited = false;
 
     while ((req = bdrv_find_conflicting_request(self))) {
         self->waiting_for = req;
-        qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
+        qemu_co_queue_wait(&req->wait_queue, &self->bs->reqs_lock);
         self->waiting_for = NULL;
         waited = true;
     }
@@ -794,7 +794,7 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 
     req->overlap_offset = MIN(req->overlap_offset, overlap_offset);
     req->overlap_bytes = MAX(req->overlap_bytes, overlap_bytes);
-    waited = bdrv_wait_serialising_requests_locked(bs, req);
+    waited = bdrv_wait_serialising_requests_locked(req);
     qemu_co_mutex_unlock(&bs->reqs_lock);
     return waited;
 }
@@ -876,7 +876,7 @@ static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self
     }
 
     qemu_co_mutex_lock(&bs->reqs_lock);
-    waited = bdrv_wait_serialising_requests_locked(bs, self);
+    waited = bdrv_wait_serialising_requests_locked(self);
     qemu_co_mutex_unlock(&bs->reqs_lock);
 
     return waited;
-- 
2.21.3


