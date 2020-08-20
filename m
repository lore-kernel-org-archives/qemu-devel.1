Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F344C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5294206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 18:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Tdi3S7hV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5294206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8pYi-0007Nu-5J
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 14:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pU5-0000gx-QY; Thu, 20 Aug 2020 14:40:21 -0400
Received: from mail-eopbgr00105.outbound.protection.outlook.com
 ([40.107.0.105]:40648 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8pU2-0003Bm-BK; Thu, 20 Aug 2020 14:40:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGeHF3kvw+HTEehCTUCkPtJFhRSu4O/qsD+0UBSMWh1D6PnV72hxN7g3yEEcOGmwYI/oEcWyZwbnggWx7SbdNT8y7+Jk5xVyDDDC4tB/RPy4dg/x53EAgSzzbZKG3w9+9S5t94fbn1x8jJTzTygj/4Z0JI7gWHxULSStXWEIAe5VRAmQgH4glkUJtpx7qI1l7Y4CrhUezFEELlj3LEstH4X9EsYtH1zo8Xk+73VjcD6G0RcuJcS0SWU4U85XwYxOYc9a4CzG8WToqJppgu8NPFzD3cx1ddAMTYSHmJbNsVkfVeMf6qO7AHAIG5AInQkqJUY/iZ2G6O+NAn5dYBGsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0386wauxXmSK63FI+OC2yIics9gF/T4FfYX7cSlvOt0=;
 b=KErhmB8Wvh9zmzSn0Kh6lhjATEZPbl2kEDVnSQMp3o1ptrMmVqQy/nl4LeA1sZGe5UOOphuGUGTEKFvI8mnJxbWwSmBpwo8K2MW9IIoILpM1DDokHXG9zweD2jZm4mtr3J2oNjTqqvrcNuBdf/J2shV4q5vxA07aEy9i6ZGDQBublXJ8AslNVmLPgc5LK9cVWWrmdG9Jow52r/faEwQ7C6xu28wRSKJfciYVYjCMgRQR612u+ntwsbPI5+/1lH7y9hMQGjIEVTity9W/OHVCKtiHtxsczG24hwgMb2SdLQSLZh9gdx3NuplcyhjsvABaPMvGDwFVETZk+O1Fx+7xIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0386wauxXmSK63FI+OC2yIics9gF/T4FfYX7cSlvOt0=;
 b=Tdi3S7hVyuXLkDaXsiCZbPGdgSjw39r2O8h5AEPcl8YRNtHeRZzopXIpxylTb5fOTpAbB4sS/Bv3vpTWbe1zGKzGJxqJMK9ahBnjXObeqniPsOyb/KgrPktIAlAVVy8/HbKZZDYOUR0KAAVNk6N6rEH1kjk12UPxh7boAfhhWjQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 18:40:05 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 18:40:05 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 02/10] block/io.c: drop assertion on double waiting for
 request serialisation
Date: Thu, 20 Aug 2020 21:39:42 +0300
Message-Id: <20200820183950.13109-3-vsementsov@virtuozzo.com>
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
 Transport; Thu, 20 Aug 2020 18:40:05 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e34673f-3f3c-425e-50a8-08d8453874f9
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB30323A77DA0E0E5C29CE4144C15A0@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H22EwgTuQUNi7hdu14FGy9+7RD1CRKltrB8w7h3Wb+6JciMFIini2rXibTpjaG9JJ2bS952x2olvCYz6xRNcyJKQpaDBNVjOZ7ryqu9RTlyOlRIY7YVMvQCQiUhhSbudgblNDGlIRbcpsF6BYSUh0ir8RfELslhYJZn23/3mCtKGzDlzCjSPQG7bDp9QArEMbLsOILw2Z9tG25lnExXNbAYBxNdzAvRWyX42YDyWlX7Hu+d2J/GGdf40YXaD6ADalKsjwZGWZhbP5jPUikNhTQWCBCHzbJh3KAzHJfMya+mpM0untRIaKJDpmOcXZoObgEjOFWVfYp63o3RKWsfCPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(396003)(136003)(4326008)(6666004)(8676002)(16526019)(186003)(26005)(316002)(6486002)(83380400001)(36756003)(86362001)(2906002)(478600001)(6916009)(5660300002)(8936002)(66946007)(66476007)(66556008)(6506007)(1076003)(6512007)(956004)(2616005)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: KSfhn5nAAh5+a7b1heexq1Y/jS1HH1BUg1DEZZDkSYKgfDeyvvFProl30RUoful3K/Ndd9jXqFJQQa/IARme8sS0TAm8udav/ggYfYECUGDKJcyBuu0OApmdTrgNaGS/jB3Wh/urZ6YjZv4iklqsnv2QS4dd5t39gCEQnxMJg3D7r0WZRlFRmuo35YnSZLZ+fxbc92X35vUkEqrX2Hh9M1xy5I1t1DJ4NX4vL2YdAerGLdbI/eCD0A+Dsl28ya1ZtpJ+crQCSPzTJqpoPY4kTYv+Oi4Licd7r9E4Mn2+pRccFA2/SXM4L7HFpjtLlHw+RzcsZ3eJFK/BCc+lAVMgbX8EfD6kEYNKmIrp9AH19YnCNGHg9L0FUwVwtFLiSP2GY3NZklPAs0QBqWhhT3O8r3nHdvHVhgtw41jshlWvvFnDOjpMLq4oUlu1RJ5MkJDt4hxGvwGkJTLz4LtM87r6tgP7E48UPsycV0tDcC2N5Fjacr/0nHisMTi1KzEqVZf50pJl9snONoiLvwUhPIIj8S1h38reiXEYGMf2SSjNob13kU1cNCIDayiRCfKYEPDwMzRdOQcagPAEXY5f1zO+cxDny3sr7bfUh16u+cmM/jKmVEowdS2oLS4k/JEWfRhxYdYZd0qx+aNBZN2Ml4Vb9g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e34673f-3f3c-425e-50a8-08d8453874f9
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:40:05.8305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4k4PWSpm3qvHMds9GsEQTLyjEjwaUMzpZokZkfbfiaIfdQ8UUQBHpdqynd+qOy/hsvd+sAF6YdlC1qR2KM0DNlkhz75bH/BHfPgOY9iOfDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.0.105;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 14:40:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The comments states, that on misaligned request we should have already
been waiting. But for bdrv_padding_rmw_read, we called
bdrv_mark_request_serialising with align = request_alignment, and now
we serialise with align = cluster_size. So we may have to wait again
with larger alignment.

Note, that the only user of BDRV_REQ_SERIALISING is backup which issues
cluster-aligned requests, so seems the assertion should not fire for
now. But it's wrong anyway.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/block/io.c b/block/io.c
index ad3a51ed53..b18680a842 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1881,7 +1881,6 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
                           BdrvTrackedRequest *req, int flags)
 {
     BlockDriverState *bs = child->bs;
-    bool waited;
     int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
 
     if (bs->read_only) {
@@ -1893,15 +1892,7 @@ bdrv_co_write_req_prepare(BdrvChild *child, int64_t offset, uint64_t bytes,
     assert(!(flags & ~BDRV_REQ_MASK));
 
     if (flags & BDRV_REQ_SERIALISING) {
-        waited = bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
-        /*
-         * For a misaligned request we should have already waited earlier,
-         * because we come after bdrv_padding_rmw_read which must be called
-         * with the request already marked as serialising.
-         */
-        assert(!waited ||
-               (req->offset == req->overlap_offset &&
-                req->bytes == req->overlap_bytes));
+        bdrv_mark_request_serialising(req, bdrv_get_cluster_size(bs));
     } else {
         bdrv_wait_serialising_requests(req);
     }
-- 
2.21.3


