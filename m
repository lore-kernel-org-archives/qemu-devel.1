Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C7DC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3AA62072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RciKEEpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3AA62072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bSN-0001rU-0K
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFn-0007jN-Jb; Mon, 17 Aug 2020 05:16:31 -0400
Received: from mail-eopbgr140107.outbound.protection.outlook.com
 ([40.107.14.107]:49892 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFb-00087Y-Mh; Mon, 17 Aug 2020 05:16:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTNSVknADI1SA7f/jG1oSA0fHnn5VOt0Zwfap5WGFoiOGRVFS5TpXHgxYsHle5l/G/+bZ+M9tNZUB5xTQFCZks8725FnCMu9B21lEbXArK9V5MB+mghb+0daitXdiL4xsSutGe6J2H5PNv9qvCyQ/AnS+Gb0fJsO2Gh809Bld54nYE5N8XGPzfgGe1d0WO8BLZbDJ3vPYDIEtHSqobZ6VY3D1bhcX8dJYgHJNw8LNq7uWPcJNX9UyRC4apMxBVEcFSXc/b+/92jBxTGXvWwx4XnP7gyUT35uyPiexeH36m3SgaJ8vPrrDjrJJIwmy8vF8EzMhBmVGKfBU3bhUNpz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUbozMxC2ZtImR2CWdhGJ9Kdgdp0GlDc6J/ZRw8K1PU=;
 b=lDYOeKeLdgDfqQi7eRYHrIgQ1xghHcDnzGF0x1wieGTM08bW4ekJU7sRZ2zrzcaki0KICTgLebdCH+z9TCA2bZurmskXFpj3elYj3ByGYG4+44/Gk8/yofCGrJUwLw/03O3BYSgWOWOCQxm4nNyVL4Ve4lc9KXJjw9s7p2+IZEDrzDgZozZqDlJONLiMNAuRc/AVqRZtYuTfPy6j4+W0Ibd0bryuvU262AlwHqIlhKu2mMJRcebC9AbZLpy/ieS65Vhi7RJmSEBH3o1k0fdV0Tza5oTVSs9Zsfl8h6bEhzodHPXgTpUax4p/NL5QX89NZgz1AGxexa2+hWeopdAr+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUbozMxC2ZtImR2CWdhGJ9Kdgdp0GlDc6J/ZRw8K1PU=;
 b=RciKEEpqBDVzxDkr9UrcqtNP1yA06Tt4+EiRELIqwJv5eK6YJDtednXLE7XqlmxZa/3lw1Q4OwdSvAHUWdRCh0rKVPWd6vjptJCj0vTjVCgNcN5bIA/mf2utLnvz1xxBcmVWPEd6Lhm5UFBOHMmCXoFz9/zETOp89QhK6xOx6KU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4852.eurprd08.prod.outlook.com (2603:10a6:20b:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 09:16:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:16:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 04/12] block/io: bdrv_wait_serialising_requests_locked:
 drop extra bs arg
Date: Mon, 17 Aug 2020 12:15:45 +0300
Message-Id: <20200817091553.283155-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200817091553.283155-1-vsementsov@virtuozzo.com>
References: <20200817091553.283155-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.174) by
 AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend
 Transport; Mon, 17 Aug 2020 09:16:05 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e15fc30a-5286-4535-6fdf-08d8428e2bc8
X-MS-TrafficTypeDiagnostic: AM6PR08MB4852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4852FCBB135B4EF5018F8E07C15F0@AM6PR08MB4852.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYIZnKFIEZik/ELNffhxfek9uovG27AgaFqejg8oxfNuRZdvGORQkmV+8s5FXps9HZsGLOBm1i5E90kmD+MMvylJqEsqy4sDOS6KjiAdLDoGeK/ODrCNDA+VYrTvkloCB/eR7RNPfQ6pjoMG8Yj1ctaUKTSnFmK5iVFJhjIu/ZZkBYC5An6sxT2lM0KsVTk1OLjeqq2tW+X/AZtrlQGDrkkYA9SQa0XRgYe6athEH2Co5vHTikQXS5LbWCb7YPIXEhGxmvYlQVu/kKdsTzY2IaxPVopCSqO/RcJj7fakWOWXCYmmxxG3K/zmN1qAKi7yWtVlB2PCjpKx6AJ3VHlTWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(52116002)(26005)(86362001)(16526019)(6506007)(186003)(6486002)(107886003)(8676002)(8936002)(478600001)(36756003)(4326008)(45080400002)(6916009)(316002)(2906002)(1076003)(6512007)(5660300002)(2616005)(66556008)(66476007)(6666004)(66946007)(956004)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: KpsOHNFJ7dOhoaAO5RyhwIr7zw4/XWjqwxlNgXkOl7vhFDSS+HiKeTbGlTh1o4kVWJ4+4aOt/uPqJtgWU7QwkN5rCeHzdhfH335Yvz/G21JZtN6Ys9XBEGkCVJYPkoPocoqmBekpyDhkCJ92miT/UhpIMQ5lmJHTDGf8WM3IQHrOT3ULBcqF4C/bohODucTNkpUimIiGvjjIZBnN/aejjYDHUEwQghz+gh9Qlk/4oYtOrR7POBfZBIeWRmIs0KN/bRk65oi636vnuDQjZ61wMUL11ZZQIMCqNOrmzD3k5PvFugaLU3/kOVwCyZs2MPI4YYPgWoUflaat/qlJry19+OF4f3RaS8unhcR8ht2vDmW76r19phBZKPFKzbMYuKwo0tXXkJj9Xw2FAx+tiGNblHZiGSZ0Qrw1zR9MrN9OsSeMuZ6Y8OPt3j1f6r61vegCBYtXwqqoPvSfrIBX7TitR0lMeOPWkLA5WYG1FUIRJUsEL1wlP6o/DJ0uPGukevvzbpzWevd8xQvpQDSMvdwV5aiAr7Ks1HDehepzAY+Q8QFh0nbMEPqbpig37PHLCSK9TaGU+YS73MyJgudx3/S2gRbgx2xmWS2ZWglY3niBtMsQtdWAgn30D6eghdRDEFugytLwNTLWSQk4nhUS42RB9w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15fc30a-5286-4535-6fdf-08d8428e2bc8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 09:16:06.1983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCNd+3e40qYPooBvghwIQGFPaQyEqp+HIRGDg1CFb+kCFXAfg7igXds3ExKiMTvP23LLOtu3Cp5ZQRwwxkXXCKuGnt5dn8cirVxUs4jQGNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4852
Received-SPF: pass client-ip=40.107.14.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:16:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
2.18.0


