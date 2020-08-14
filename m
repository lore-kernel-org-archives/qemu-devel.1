Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23C2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973DF20B1F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 13:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ELcayAKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973DF20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ZP5-0002h0-MH
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 09:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZNn-0000vL-Sf; Fri, 14 Aug 2020 09:04:31 -0400
Received: from mail-eopbgr80129.outbound.protection.outlook.com
 ([40.107.8.129]:44769 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k6ZNk-0006bp-Jd; Fri, 14 Aug 2020 09:04:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6wUS4IwQxsrtmJ/4ta3pH+OPLym+Hlj5Y6UutUDv3hTnAQnIwb3LNvSCz/TQBhP6RG9U5/UpRWvWIIH1rctjb2HL8Bckfixv3/g1q8CcjAEQV/g8xx/y4kQenbF49p7iq16fGSlL7OoyRts/g+bOQmndMPGLrosnWSIU7d1rWc4w1TSSuC3eb0aH2DOfHl48ymTLo44tYuOZkVVKpxSbhxSpU0P89ygwB6ze3OEVztXGKV5K9XMeGMJ6Lf+a9QbowCqE2JlTVM6RYjTaTUUPL0QR041X/HS6stNh4mWqB+xFsrkkiUq/X/6n3vuvLknQX+jKb2/v9zITQznIyIaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H80UglqObXKnQlcaClJt4BPJoXYsU9fxtWr1yMUlV5Q=;
 b=knGNf3fp30uVE1F21b+lmYSuC2I4Fq7+zHztaQk03gEnuggY0GIc3dk2TCHZYxDBibu2lQZ8NqfYAG6hjY6c06n9kJFkZQ3liLHmRZSa4sCCfzeauK9Zp6SyHp26CNT+whdQIqlPLHXOlzhPoUDHjSkDP0SNdXXUcBLENpR7u9xvh3f6daDJcpdRM4DXBbrUMPsyc9lePdWoIKlhwiMGhsp7twhfm9EVNjjTWTN6H+i+bJQlLgUJ4Xju5dU0t44lFchD6qveKC2eBMmgqPiHS624pM0kQPj0X78KB9rfwCoQzO/PHoOWdx3+qck2Qseps70rWUft/WHVF1aOKKGNOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H80UglqObXKnQlcaClJt4BPJoXYsU9fxtWr1yMUlV5Q=;
 b=ELcayAKOfji2hSkzvVa3Utr/hq/GGn2klfLLPFu0ZcY4/gMgZIPj3ni1BhqO/AkpoqLVVeN7lspTubMQ4UTeB+6AVK4IZ4rluapZkV/p1/Vw7EXxPYjZdIVSX/415nlNq/MlD4aL1T008Wkoz4e0b3At/8QQ4robzOJynpe90IA=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB2984.eurprd08.prod.outlook.com (2603:10a6:209:4e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Fri, 14 Aug
 2020 13:04:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 13:04:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/9] block/io.c: drop assertion on double waiting for
 request serialisation
Date: Fri, 14 Aug 2020 16:03:41 +0300
Message-Id: <20200814130348.20625-3-vsementsov@virtuozzo.com>
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
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 13:04:20 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79cdc639-ddf0-49ba-54a0-08d840528f87
X-MS-TrafficTypeDiagnostic: AM6PR08MB2984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB2984C8788222465BA71B7E91C1400@AM6PR08MB2984.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9+xrzZal1kCB5RJY5lqooZ2dP6CQxeyPQC/7Dqg5mMXzwNaKQJHY9FQCRrFsclRrcV+OMoGGFylP/9GTYeEcy19yYfKJp6iWdYCs/i4frIQ9/ozbXT9VrylXISSmIgS6h9xstwuIFEFgyfTrw7EPTWo/6bcZjR2kgYF9cL01jGxCA8yqx+Yww5tBWkhc/TscsbUbmiTrtIbOAPO052NRGMLwFKi8uH2qKykhjj34hKXOHdLGJLmZfZQqX/3Iroq2RhhexYO1jntdDGRBWEbFWzbar4UofFL+nge7ozYHBF5kh4OGYysbjFLg4ug8USsEUXaC/wZObuY8RQxHmrA+2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39840400004)(346002)(376002)(316002)(36756003)(478600001)(66556008)(66476007)(4326008)(8936002)(1076003)(26005)(52116002)(8676002)(6512007)(6506007)(16526019)(186003)(86362001)(6486002)(956004)(2616005)(5660300002)(2906002)(66946007)(6666004)(83380400001)(6916009);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: yuwehSs52CsfCkJI8TqB9e/gs2mCq+7qbISSPejdoBJXcBgnwwKfe/bWaXnP7EIgf2phWRt3knN2cqVcb3CY6CzuHFKeu/4Y9nssPSP+TukiXGHRuJ48ryXznK44HeJXYjeanBLElttKCxCU/n934zOXa9hXvG96shBVWYYcfgDfUnK7i77UtCiidHRiW4tJVH7uUrCQFNtptpuCh8U731HXrgemXfawNCvxTuPcQB3lsDOP3UVnJPO1++aZkJKorDCNKBUbS0+Y9Ev/BV545scjxMGeAe6o5XAzep+HHBwZfFPQf3y35LfAvjrcJF37ShkgvUg28ko6v8L+Cbcqn4CrocN4J7GgqyQ89ZOisbrOTibCS9epe9nLoLwr8k8IcZZWyQZ7jWTZp77qvmWL586w8WQO/jhwL96gLWw7mnerj+i7Ks7dqd0WfUyZhWzsc2W3BgJV0/D+NPt/DbwdLotFPxSH3J9FimDFQ3E0WWrM0jAa7umvhF86ShfvLjqU67wRrmCuCQiH1ARIKtGjKdK5R0XFG/d3CYzPslbi6SUQqcI/ImoNEAneAHGeKsPLcbs1QzFFZfOJcw2Q/yqfoD7tCpu2C3dW05VerSwzCKnOrBekfhaaVKkAEqoxuRZey1e17KcM2cg2nrhSmO700w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cdc639-ddf0-49ba-54a0-08d840528f87
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 13:04:21.5219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwtEj6Ig7Qx/2hNyw6vIr1AJsOTQWrJJEcyuVw6MAccLni8O8BkdB+G7paX9SGFgpI6kJjoxKxVO3wnr1bs4bXIhneOlXwDoK4IzL9OvsRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2984
Received-SPF: pass client-ip=40.107.8.129;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 09:04:26
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
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org
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
Cc: pbonzini@redhat.com

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


