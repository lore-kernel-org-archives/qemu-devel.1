Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0D7C47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799DA2075E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="WM4YLBJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799DA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcEP-0003ky-Jf
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDF-0001xb-FF; Thu, 07 May 2020 04:49:01 -0400
Received: from mail-eopbgr80138.outbound.protection.outlook.com
 ([40.107.8.138]:13902 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDC-0006Er-4w; Thu, 07 May 2020 04:49:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXPgKKYOlXRtWUS/lXf4MIc8nNRUim9uNaz7orzj8RkaYQOO17YT+FqHoaxxj2QiUU6cLgFamXW2TKwTC4IvjowZyMY3TIMv9m2XW7nkTzAoEwr6WQcnX15DRiizFJ+6hh2k12iAhtRFu0PvBGmW5Z4PpJul6c9oNU7XVlNEOskzEfhxFOy4KimVrgABlTpi/kKQ62DhMQ2OJfPoKOYbQpN5oiavyIJyxmkuMktuUR+DsnXKvFCGHTy3cxeFLyPjIFn0Ssqn/K7mnFVwxujQs+tqyCC7obe67k4kCrKa52mjpTwOffYfPsEhvXySeqWLIKqkxmO14HoGVb9EGQUF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPSUYPd3IO6BcOKuN2decCqpqrULTee4ydrzWE+/T3Q=;
 b=Rj32mQoL9AfKe6Mxol21LhDzdLvCk9Nog3Z20+Czy5F6Z/ad1XSJT2lqucllJMdgD2jwXWqzv/Bc2qlJpIkZKAWIEIUZUKlqHmWp4ftJC4zj4Rh2mWH7XlUyQhYrcJihsSnEtGwDA1DVjjzaXOFwCSbdzeXySFPJop+sjm2VygY6rmrVQ3d0xmMGpSmxXsInjoa+KsPgnGXQ/XpB+YTcHDlEXJEWhASg1TSOSKlIwqswez+gSwbftudfcJLUQpu7/JL0CQ4naAY1poL1aiSkGCwHyOY3+i+GuRJX2QMZySt+vewbhJ2GV3zXCGtesNjeAmY9s6BZvosvlK9C45MTvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPSUYPd3IO6BcOKuN2decCqpqrULTee4ydrzWE+/T3Q=;
 b=WM4YLBJgXH3LcjWqZcmoDecroc3e53ain8vyJUydX8wgmRSUtLhu2eItQOPyMM1955PDX2X/noP+k5+cIHDvmyXOd1EPWhE6mNpn2A5qNb82/BqosQbX1ru9OyMIM2j/CCTrmMgyMMjX3VW1cAjH2yDWHkwQbx5vmRk2XvE9zLw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 08:48:39 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 08:48:39 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 4/9] block/vpc: return ZERO block-status when appropriate
Date: Thu,  7 May 2020 11:47:55 +0300
Message-Id: <20200507084800.20596-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200507084800.20596-1-vsementsov@virtuozzo.com>
References: <20200507084800.20596-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.171) by
 FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 08:48:38 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69d75208-2fcd-43a3-0765-08d7f2636fd9
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495854D97C19AD0F6F629F7C1A50@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lj7yT6Evd7TVJgdnQbu01sTTU1HqZN3Rn49K5E7iG2l7B71jV6d99FbrV+XkZK6kUgUkYe1/gfhPup4bVmNzdLk7iqnLgBwGObuOApyMEQNcS+Lr+nCy8ibJN2I1Pm3myIr+GlkgPzYa1SvaddN7PfnEh4f825b9y0LoGR/e2Em1P/u5T5WJvM8VHUtRv68sUY8XiQjA5FoRWxVm2ogLATpF/WhyOuhtlZRka0QV4gxfvZUi6+HBIh4s6oYdF1Q/emensDJR3XiPYPQFDgDgBW0+4WEhgaR6FYHOPhQO9RmxdawVFAStAoCZ7YiB2gWJgAWCRYkhhknb3kwZ0yTGSEiPCrVzEj9t0ZioYZRTQNrF/3mfW/zUngByx26FXtdF+/fSLxyjnkbxr3yQbxTYfmk/ZRQQCPDa0RNMqseCR6ch9/ob6aIKYB0KOTS3aa8jcEnIlS32+NGjncmaKDX5D9xRTzaEnZA9gcb8knfyK97y+k142anuD7J0MiI3N7VUxXjdMhis+4eaTbwRaKXQ2woSWWZlISHKrySgMEAiIuN24lPIDNS/1C13S4Ei7CZs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(33430700001)(4326008)(478600001)(107886003)(66476007)(66946007)(66556008)(5660300002)(69590400007)(2906002)(52116002)(7416002)(6486002)(1076003)(36756003)(86362001)(6512007)(83280400001)(6916009)(186003)(16526019)(83320400001)(956004)(26005)(33440700001)(8676002)(83300400001)(83290400001)(6666004)(2616005)(83310400001)(8936002)(6506007)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: AHyG4rXsP5a1W99uHC1u4+Egv/NOAAnHc5x2Xlc3ygCjfe+GkRbhVAPeQwZFC1VMnyDi9m6zAMkF0xYDi0i3KRkWbsFtb4wPVD2LBFmav34N2sTO/OZ9OooGYoviO0tFauK7M+VLIA+XYV4JSfWJfnrLjk7Z3cZG1X/TtUDOC3eg90eECmYFsJxmWjiT4Op1u5MwfdUmcOQBuvmtG+J8mDbwXX6P5wYix8O34jr+x6P+CYCI2KrgEtOgJro4r6qNjqRmM7o7tpWXGCGJS3kxcEBCpcEP/5/8fcq/cYZ0crFsyfg8zN64Kuwb2MWd/Kxn4kS0Nwauh9yoY7KuZ6FJa+V9kBR9r4ZIg9gfndPodJwOcNIFobM1aSFfcgcGKVLvUO7pmAonApkoY0rOpkfEYUh+2ZH/ezcUoE3mm/MxZJY2lgYaUoSdwPaN1oM1a1LOk2rBOV+Uo3rRBLn0kiuGE2B02C0TXSpjGwkvh4zZ+Yzq6OImS3Pgu+yqN0jMBZwR5zo1vpd55g0sPklYSEGw44sSphhqk10Qdb3QnYzpy5Vx47Vx/W/LrswauL7Ti8uEZ1vdLzfTeVEpfsFSz35G4myTMP/j7rabPro/2U7iGy8xTnlHFjDbLluPVuURohTC56MS8K1QyTWGjKz3W4xxtM9v5rCoirNIVeA77NzMakQaJm7GC9VLfhREOPPRfc2NxT5FLuuzfTZ/oN1ho3/Z7yD+B8haV+c11zIOUjYu/8QmvQn0TBa6S2XNGVia7qFmqCivVXVjSp3kC/EzF8n5xKhKX+T2CMYiDbW24spG6fs=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d75208-2fcd-43a3-0765-08d7f2636fd9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 08:48:38.9896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jnl1lVPErGMuGITbyxGovTnvoIPj5O+hnm9publpycqhXzQOWtvn+V9N3BFljE8VEUUZ4r7bEd19ps9O9KOod7smMssbBku3GZDvqKTDaAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.8.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 04:48:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
 stefanha@redhat.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, ronniesahlberg@gmail.com,
 den@openvz.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case when get_image_offset() returns -1, we do zero out the
corresponding chunk of qiov. So, this should be reported as ZERO.

Note that this changes visible output of "qemu-img map --output=json"
and "qemu-io -c map" commands. For qemu-img map, the change is obvious:
we just mark as zero what is really zero. For qemu-io it's less
obvious: what was unallocated now is allocated.

There is an inconsistency in understanding of unallocated regions in
Qemu: backing-supporting format-drivers return 0 block-status to report
go-to-backing logic for this area. Some protocol-drivers (iscsi) return
0 to report fs-unallocated-non-zero status (i.e., don't occupy space on
disk, read result is undefined).

BDRV_BLOCK_ALLOCATED is defined as something more close to
go-to-backing logic. Still it is calculated as ZERO | DATA, so 0 from
iscsi is treated as unallocated. It doesn't influence backing-chain
behavior, as iscsi can't have backing file. But it does influence
"qemu-io -c map".

We should solve this inconsistency at some future point. Now, let's
just make backing-not-supporting format drivers (vdi in the previous
patch and vpc now) to behave more like backing-supporting drivers
and not report 0 block-status. More over, returning ZERO status is
absolutely valid thing, and again, corresponds to how the other
format-drivers (backing-supporting) work.

After block-status update, it never reports 0, so setting
unallocated_blocks_are_zero doesn't make sense (as the only user of it
is bdrv_co_block_status and it checks unallocated_blocks_are_zero only
for unallocated areas). Drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/vpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index 2d1eade146..555f9d8587 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -606,7 +606,6 @@ static int vpc_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
         bdi->cluster_size = s->block_size;
     }
 
-    bdi->unallocated_blocks_are_zero = true;
     return 0;
 }
 
@@ -745,7 +744,7 @@ static int coroutine_fn vpc_co_block_status(BlockDriverState *bs,
     image_offset = get_image_offset(bs, offset, false, NULL);
     allocated = (image_offset != -1);
     *pnum = 0;
-    ret = 0;
+    ret = BDRV_BLOCK_ZERO;
 
     do {
         /* All sectors in a block are contiguous (without using the bitmap) */
-- 
2.21.0


