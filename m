Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAE3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:24:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B461C2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="BgHtauMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B461C2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bNx-0000x3-Ui
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFc-0007Yw-7Y; Mon, 17 Aug 2020 05:16:20 -0400
Received: from mail-eopbgr00134.outbound.protection.outlook.com
 ([40.107.0.134]:17743 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k7bFY-00086n-Rc; Mon, 17 Aug 2020 05:16:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK40/xz2tj3JnEkwg3C7b87Ozclb3xuKwW6Qe96XBm3s4wRPdYlGoiucx/e/QLpLCmQvCbAj4C2X7Qw1aCG4uY0tI76KsP737eZUFuK1ENWvSbPbZxs5wfw2gP8+QvwR9A+nFAxvx2u83cFQqxXY+y8d/A4iA5UrX2/hJWXZufqVycJyW24NG7OgjfkPr9HjqeCvaBijxn1l27UIN+YHGTEKPFbptZtiiJi7rl4UuNQ6ZMmfKAxg392kFwV3x2cPSnrxB14gUvhZhwF8Bd7Lwo82qFAq5N44Pu3x96gUWeKIQNSJo2Ws7E/1Fi20XZQdgRbD8/2xgccVckxFzCAEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zz3PNqV/8x7xs9tFUITxLc+oyViWGfRWLvj/N16jTtw=;
 b=BM1JQzvFpVOYMDXh7c0Gd36A0YGgG2PsRqqfiHTNxXgq3AjjaHg7ZwtOEAAttOe98Zdc+uKETnaT7Ikw/sfPG+e+SQ0HtLMosE2oIWLEcyfoicSpfBq0pShxBoNpt4YmXsPchmVNPe5Cg8BBejxdykx82/OpEnNpQgeknVT1ICenCxFlSWJVU098O42UoxTx6O7y9nFRxVQxAz48kdbu6wSMrTTz8SKCwn5O7U9JgLhe7WLGTh8gHJlW/ptaRRPExs2Kayo+Vsd+2OMqNsi+DqYSYY0tufDqkwdMGAns6quHSHqB4dgcrNq7Q6lKMmuyZF5rJ5YzDDdZD8gpVJx5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zz3PNqV/8x7xs9tFUITxLc+oyViWGfRWLvj/N16jTtw=;
 b=BgHtauMnNisOQKJB1cAe1dmZ7v1Z+vBCUKl7Td5QYRYAr4WdQDbBsJ8MbSWBRLC32n5oNcamjRWvhWlybqJUMbCFgUe3Xk0fXLUeYIhwokEMOKFMXGLXKkuhwJyYL0iqceIFR4ScLDNQF1t+3F0qN1QQzf1aYl934sbVboeFO6Q=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4852.eurprd08.prod.outlook.com (2603:10a6:20b:cc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Mon, 17 Aug
 2020 09:16:04 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:16:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 02/12] block/io.c: drop assertion on double waiting for
 request serialisation
Date: Mon, 17 Aug 2020 12:15:43 +0300
Message-Id: <20200817091553.283155-3-vsementsov@virtuozzo.com>
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
 Transport; Mon, 17 Aug 2020 09:16:03 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.174]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 664b7d9d-6606-450c-d7c4-08d8428e2ac7
X-MS-TrafficTypeDiagnostic: AM6PR08MB4852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4852DA60EC474DFC48C8EEF5C15F0@AM6PR08MB4852.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNl9UXz8snqf/XzLhLselE+DLVsddtj318JW37/CQyMvG3yRBOa6gyGEvPLJAb0CWgo4UXZUqWhnHnoOduwZTBGYZMsSks9fmMryxJ/KeSE3r3mxRJgZMOB2VLApFcO4rn9+xkRMHSwhGczOv95C1cYutID2/Xj+XoGO1TWKOV+0JwfoSRpHJSMZfFwPo9YvkB8S/l3TPsRntqr1uZxWkSNBZxGP8Q/XYfZzPJop/s33iwqpcWgxVhsdoYAUKARYTdmF/KPmxl8zFQ4y7p6jJjrRwzZtVCMewEGOBJqG/vyiny3WIN1IH7BXSy6nCVrnYLzDhR3ouzhaQDtcXj4SJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39840400004)(396003)(52116002)(26005)(86362001)(16526019)(6506007)(186003)(6486002)(107886003)(8676002)(8936002)(478600001)(36756003)(4326008)(6916009)(316002)(2906002)(1076003)(6512007)(5660300002)(2616005)(66556008)(66476007)(6666004)(66946007)(956004)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XEuwD2EsrIkVOZrPPvgxOBZgvYrvtwnYm7F3mFrypUbD3NVD9szIdBN+DF3UYTo/471XYFaCCq6PVW8jvSsiGhmvXJ480nDBml6+uZMlONoY3spCT+Ci55Qn4Pm9g1qhkwV0NVSoaHl6xzZ7X0SuKjVuyULrqa1k+6Qy+ZxoVTQs7luTx+RTvAeKd1jz8XomF+2WfVC2MlFtKDWwd02RHypX/toZxiTstyNHxTfDWTqak4jhdKPboQiWUCJYjMfZWJBIz5J24yMBl4J4e43mW5xwsEcMyeTbfLq9jbsnh1IgRgFUU/EKw5GJqMTW8qgYuchTj5vusfbIOsvqGyM/BTZ5u7aVSwkXs61uRcbe1LsyA/+eQq+3yAp6Xeg70kLhpHMYc5dhAEFrpVX06I5/kmCkPiEPqj79ZXFIrvbzO8qka/ODX5CEEvIAEZ5ROsN8uEByik3DwTApUZyQ77VNEZyTYz/p36D0u4iza6KRrgJAGTHBqWLcCr7lTBOksq9gKk9rhjuRfiPycnCLj2v9/rS9xNgdUtyl1mBQR9woxxc6fg4KPKN+uriOPgIqGAkz+T/hOeIFoRD6s8FbPHeu/yR4rVWFVwTZP+kKwWnipvs3nTlAgM0bpnVMyktlOyihK1+FBLdxaDhnIW/JC1nVAQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664b7d9d-6606-450c-d7c4-08d8428e2ac7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 09:16:04.5067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nc2qAHr8IY1P23drsAzYzYupKlv9SkSnXvVLZ4devrLvkz4ZbVa5B0eriyswQe9P6PpgUM/EyeDEuGN6+K1lZTEXlro++Wc58Cc7av41fPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4852
Received-SPF: pass client-ip=40.107.0.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:16:04
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

The comments states, that on misaligned request we should have already
been waiting. But for bdrv_padding_rmw_read, we called
bdrv_mark_request_serialising with align = request_alignment, and now
we serialise with align = cluster_size. So we may have to wait again
with larger alignment.

Note, that the only user of BDRV_REQ_SERIALISING is backup which issues
cluster-aligned requests, so seems the assertion should not fire for
now. But it's wrong anyway.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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
2.18.0


