Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D9EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5097A204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ep8wnyx0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5097A204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97sw-0003SQ-FX
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97ll-0005Fi-Oy; Fri, 21 Aug 2020 10:11:49 -0400
Received: from mail-eopbgr50124.outbound.protection.outlook.com
 ([40.107.5.124]:48515 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k97li-00053q-TK; Fri, 21 Aug 2020 10:11:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxQK4tLnfOCigRW2rhGE55B7boDKVcpDKvEu5g3ohAL8Nxy9jozg77oZR9XIeTLy+gxJyTzSucj2LVQYUgL00sPjMWGCfkTP7tpAa0RfzDxWF0ibL46S76o40V4T4zNkGlYQEFgbqiUdqTrEvDzTKHlZiMSv68HeXvji78FjUyhiPhZNxHZwlEkRH1RrprHix/AWcfz4KcFvQCzWbXPhWLKIF/Tfo5CSz6n4q6soE8Ni2rx9qMrPq4jtYkZL/rkHHAPv5LqYkAVM/qhWKpLwPWY+c+lwcTidSO6YIE5HNKgAjeiDWMB3goYj8GsinUaDwGRiyn1eoH8s/Xg81XKGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOSs8tSaCsvqszeIfYHYua4c4UTbNH955appswRjkts=;
 b=iAMFfUFeFouo6ibstsv2Jvi6jsYh+5+Pthl6IE9izuSNWUHqTELD2iL1k+bcFC9aLuHA5KUosQwza5GAPEICap5hT4YPpsxc0CAnENoGiJBgM1OjvuVyi9v+mC/7U0t+JLjmzOsDHEUwmicTU7oVZJlDJ67ncPz3cGZV3RLflYLl+uUNQ2lH8SGYWg8gonvWeliwnzCdAJdM/Z5L4Tiw7c1WQ3OoQZr+CrHqkypZy1YCXg6dMk/+yQNoTh5f4o7tVcvLRrI/WL0EXjWEBYjSGIYWCByqgjZjhZ1mJZRqkkX9hWwpiE+7wfcsgq445/EH8g/H3cBxh7348IHjkTkkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOSs8tSaCsvqszeIfYHYua4c4UTbNH955appswRjkts=;
 b=ep8wnyx03272QWQn49h5BzmtTVZsCILOZDoHPzCWCjKEB2uHRGmBz8ZF55cUwCgv/exDybC6CWErMikZMRtWqbSxVe4BCzeBYDZFyFYRImjbtqmYq5zkgnmnXuHIRtPiLuabIHKkuCNmjo/79pzvvXEivc33KlHxnpOW6FxGrnk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5253.eurprd08.prod.outlook.com (2603:10a6:20b:ec::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 21 Aug
 2020 14:11:41 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 14:11:41 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v5 04/10] block/io: bdrv_wait_serialising_requests_locked:
 drop extra bs arg
Date: Fri, 21 Aug 2020 17:11:17 +0300
Message-Id: <20200821141123.28538-5-vsementsov@virtuozzo.com>
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
 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 14:11:40 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f31f7a1e-c906-43bb-541f-08d845dc2053
X-MS-TrafficTypeDiagnostic: AM6PR08MB5253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB52539E810CCB2EFD915924F9C15B0@AM6PR08MB5253.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kh7ANgNk1rJ5c6N5nJVEJyifQ3/wl+8wz6EAzkRyjyKBmag/m7gjTLxdcxKPRAVHU2unZyPcOnQkGSI3tIj3zRaFZYr4rEYoYJZCSpPnA26Ce2LypLeIwKtSJ1BmZL8qRIMno/O29eP3yT6T84I3exibrw7JxGYU3lFGbkuQH/mfGikSZZMji2kgfkP89HRSsdpa8szse2eiE0VI217ecKg4elhWw/XNGrCXhGU8vHdRN6nQBeEVo/C5GnoPDZuoRnZFs67GZE1G80E5TKa6xT51IQDF08KB6yt1yO0NOOqgAmfrl8DeoTSLYtQysvkuWrtDFyn2MmdjnxwPF+KADw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(346002)(136003)(5660300002)(2906002)(2616005)(186003)(1076003)(316002)(6666004)(26005)(956004)(16526019)(66476007)(6486002)(6512007)(66946007)(66556008)(8936002)(45080400002)(83380400001)(8676002)(6506007)(36756003)(52116002)(478600001)(4326008)(6916009)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qbw9PtrAnm5UW85VCpIkyT4pCmh8JYjbEQrp+B4Ucuo78xWQEP4PYXsXRUtowRer8kfLLqKFY0/AYR3MPhMVQjetxxzV14v2Q+Du3TxycGbqUdFeTMq6tMrRiogML+47zhDDeCFMnKkes4dQzdYpR7SyxdQibgtpibTt2pCNWaPyKQn705F35Byi/nFc//hWDa5Go9Nnil77A9AQwSmJ8uWpqV8FIggp/oLsdNXBFcL3bv2+OvuL0fJ8S01Ll6V+Iev4yXhSiWgWuY9cd0XMEa+IbnkKtyHmrsNgIMj7YU0+SxHvsBpUr9ip8LcciDmVLL7cqVftgB55BkfgZylkwb9FBpZ5wLIj8ycBEgf/2Bzru4g4oa5V9vgPhxxxy02APKpS/IJSEISDbvHE+Ea8SyXZFVB0wIlTtD8ara4trMx/HmhkJHZigNmIXGzm9vqXd6uXjcZgZNp7lF8ysFpsCqQpBf3v7A1GSwRubx9P8/lM9h+1C9jIM8lgGNETaWAocUlpBcFcKYABaY7B3e8XqtbPFGinMy2J0iUSAY7YG6dfzIZkbxnj93M4im3TXArvoL/kdNACt3q6kRKYbB9xHxNfRirqbnMse5diyL6Nd4mFsoPBIzdQkW1OBXK7PwQ40968TCKdbFA9ULdgGo03dQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31f7a1e-c906-43bb-541f-08d845dc2053
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 14:11:41.1912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pHbK8fk3QyBllTHk6VIHV3VC76Nv5+75EWZ18Ryea0xmFVOXdm+TmJgpu0lZ2d9ioiRthagJ4h/smFcvaDMAimQuIKI4ImJswBGF1pgkb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5253
Received-SPF: pass client-ip=40.107.5.124;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 10:11:37
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

bs is linked in req, so no needs to pass it separately. Most of
tracked-requests API doesn't have bs argument. Actually, after this
patch only tracked_request_begin has it, but it's for purpose.

While being here, also add a comment about what "_locked" is.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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


