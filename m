Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED14C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEEAB20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 15:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LjBk6EFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEAB20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVFhm-0004wd-OF
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 11:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaF-0005eK-Jx; Wed, 21 Oct 2020 10:59:23 -0400
Received: from mail-eopbgr70109.outbound.protection.outlook.com
 ([40.107.7.109]:36743 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVFaD-00085a-S6; Wed, 21 Oct 2020 10:59:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qtc/Hhg3uG/nbWJDtesaN/Hea54DbU+0J4+5E4AfPyhQ11mx1CuGhuWQRbq/YBQNwtY4SFzbMHZJjG4wk189TfC2jWNWb+HRtylmxfOF3tLz9ooa0cH/G+ZVpgFbSSzHVsVA/jBWKlSD7INuyYM/kWawVgC/PE/KEfQcv3hlh1OXDJQKRXEy2E7j1ZNXVJtq3bN2D+9fk5ECCxKIxIAWDv7f/Hg+GTQRDVMXiwxxM5WH9R9O1G2kpTAtcE5WKARgjybMpLaeqjTaWJjNfTGWl0I6CWmXZckGTx9/LUmymaaA7dHEi3MUsRMRAbgp5T7NAtdgBU/bsP85Z8NBlO//xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zf/LmbYuMhBReqWOOKVX8Uhmh/n39p9Hx7Rhe29Odqw=;
 b=YhtUzq1kUDzQJAS4PidcjYMYCF0mrE9pOWco7sDlafejw9F1ODjxVDl5rEIa0M9PVeT6oJqDMh7xpC9pwuWkTu0S0dAQwDFQcr7QSQqRCthElLrTJWQdmMDtRXbhsEvy2w9YFLyn5FC5WK9FJZWBV+TSeCtIfUg8bRibSOriMdVINTmUFnfer8pnkfOyEeQ6dMVBDp6O1PlkA2/zhWiMwbqleBwIRLrvTzRniT5JPcca3zu+fIq0ZhQT5IA/1hjb1zv8bQvX+iG/5ZGYOfFGwZW2gmboQCX9AQ4hqY3gZ9OxgCNESUWQOo/4Vb9vKFhBPNE+dGVVhm3TgTgXAOvcyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zf/LmbYuMhBReqWOOKVX8Uhmh/n39p9Hx7Rhe29Odqw=;
 b=LjBk6EFNtGAIqt6Tb/OtdJmunVtITMyCBWFSmsvxEGPyJsWwY003M8AjJngW9Z9MV9HosbMP1L4tMgCfRYUXnJuHc+1MJAzDMzGzj4K03OO8kzIPkleQ9KFoP+wdfSE47TJxxihd78iX1ZiBYHO4WD8UPQf0nmpSOIYKTlxT9oY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4472.eurprd08.prod.outlook.com (2603:10a6:20b:bf::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:59:16 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:59:16 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
Subject: [PATCH v7 04/21] block/io: bdrv_wait_serialising_requests_locked:
 drop extra bs arg
Date: Wed, 21 Oct 2020 17:58:42 +0300
Message-Id: <20201021145859.11201-5-vsementsov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3aa26421-6589-450a-0a7a-08d875d1e17b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4472689ECC48A1B97D36A50FC11C0@AM6PR08MB4472.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+nHUfyEjdY88aB6cp6fRXBlc8pMzzGflyguwfczgDJUy74odQ72mqhL+5iXW+EXR+NZNaojrwup6vNYqK96pmTwxelX/mXuiT8UKkkDuiUQGfPY7/j7J95uiqXuvoYyvla8L5XoDls51AHB/s23bOKRx96T2rh0cMs1rk8YIRqs4i+S41k0OnZtVtE2TL4m/edhsGH8/Mlm15D0Rl2D60Jf6v1wWCKBjk50LLIZKNeXa7uZy1J05IsYZdwr7HmTa5HR3yBrpzJu9aeSVz1dAvpiIypJ0Q0di6w50zg/6l6IBq13q+qsPFdejrfiQsM2N1euqSxVlckg8lNdrbmrRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39840400004)(66556008)(16526019)(66476007)(83380400001)(6512007)(26005)(45080400002)(478600001)(66946007)(186003)(6506007)(6916009)(86362001)(1076003)(6486002)(8936002)(2906002)(5660300002)(52116002)(8676002)(2616005)(6666004)(316002)(956004)(107886003)(4326008)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4JWjo33z4pJ7uPDVX6lSs46wAFZGaRkcowfq7HukvIJS52YT/iJC23QS9RImDnZgpA6LJ9wPB38q+tP8LrQsJHZyZcUqmCmOIkih9N9iPQaZDJ0UAmzyqgHkX369CN6KnEbiJ/7Ziv8WuX86NvPFI8EGvU9YMAZFSxiCU7sHzdutmC+lKwTJcT0JjcVCHIPRf8l3PWfzdje2/YgPNI+7pb1GIg4p57QiPjDi/s1sCuFW5+wVSk3a95owxY64X22saPivYmXms3zz61FaYQIXfZ8RDYRZBIaW9TGJlh0pACUc+FnbZ2Ihs1cj0eULsK4dNH1kvT/lBlOjQH8N7RjqGXGQhe+MDl3aLrdULT4N31AjffXDEXPLkuWmiRiDH1UVgNK6WspHGT7Jiu9E61gJvYaMbbGj/nHwe5kcjf1J6CBJ4hf432H7WL0COzLfbUlgC7o4U5E42AHcovB9c0IPw33kiqm/k16wS/63oG3SjnplxAPnc/WVKBrEbK678pmDB8JZjsvrjT1IGaFAY3RJgF/YiMMRePhrTtcbtVwnmD/QH4o/wKD1g+l+o8n3DFEVFic3mWzkDlpqX0N7ZpTyWdyqlqAByu2DhU1l0HyQCKlDlCYPsp5kv6+cph37tO+FOphGf/XMw6rS90Be6f4SWg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa26421-6589-450a-0a7a-08d875d1e17b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:59:16.5701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLsnSxQd0RQlNei/ktWOpI5CrmTxTsxilBO2Nm4GhW6r8EvQhD+PqZ8l2/IkKbAYwrtvDVQqbxGnzGR/msfmq+XasyLzpnPXWbmpVBQKIQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4472
Received-SPF: pass client-ip=40.107.7.109;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:59:15
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
index c2d9b1f849..5c1a1b388b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -762,16 +762,16 @@ bdrv_find_conflicting_request(BdrvTrackedRequest *self)
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
@@ -795,7 +795,7 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align)
 
     req->overlap_offset = MIN(req->overlap_offset, overlap_offset);
     req->overlap_bytes = MAX(req->overlap_bytes, overlap_bytes);
-    waited = bdrv_wait_serialising_requests_locked(bs, req);
+    waited = bdrv_wait_serialising_requests_locked(req);
     qemu_co_mutex_unlock(&bs->reqs_lock);
     return waited;
 }
@@ -877,7 +877,7 @@ static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self
     }
 
     qemu_co_mutex_lock(&bs->reqs_lock);
-    waited = bdrv_wait_serialising_requests_locked(bs, self);
+    waited = bdrv_wait_serialising_requests_locked(self);
     qemu_co_mutex_unlock(&bs->reqs_lock);
 
     return waited;
-- 
2.21.3


