Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C705C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:48:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49628208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Ne1jb0sY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49628208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeF9Q-0000Gc-FB
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5W-0008QK-6l; Thu, 28 May 2020 05:44:34 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:2978 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5V-0002k0-Bh; Thu, 28 May 2020 05:44:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ4UF7MnCnbIweq3zB4Z4NzNfMoj4goPDeJKagHN6pfQISNwRFImhhItMB51MLxq+p2Oi4v+MVxjt3lfn1jsos6NeGccjrzQPbpaaoFHrl2JR7jin/mFrMEJtd/PwdnAImdnJzZiggaoe0deAhCNTsdtRiUJns7mBNcR23nPJUS/r+Sf6nFAUekR1HiqPhtgrhO5Oif9auNJh5L7ASeGKQ8UB8OTUD76JYlMYWY1J8kEFujGfENSE36diuMRkvZQKQiaAsSfHNPG+CWPt0/eClI7DpZrabuDbpotri859SIR9GEOI4eoR0onAA6+xjERpvQLSkwQZgg2Y3wP/G9zSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+1x7EXNSbCuGOrfKL4P8zLdvIM/Rf8PKZbdc9UbQGA=;
 b=IwK6KYBL36nvRY6VhpWCPrCrbmi/+Wb1vDrCvrZuj9LdmNoeEX+cbyI7N1xvUbUmOaZnYUX1aa0kdTFMxsb2NTUAD8vhNBQDHXA1R/dywjHds8KGicJJPm8r+mJyhUMajt0tNMu3ksqQ/EXpdoure5FwUWh+ayGurk7u+XgAdXCsx1JYvsOQNw1JCYJbIz4GUMb41h74JTiJry0kpPtw3DZN7dezG0PG5lypMCHoU+y9+KQU2aGkkM2VXvLh+KlajR2PkcitFyuqZ6TGm2RlKjTE06awdSlAqX8kVeK48tK0lEaMryasZKUIhgg+bV7fx6LsIfH/Ki7wPqO/XvXyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+1x7EXNSbCuGOrfKL4P8zLdvIM/Rf8PKZbdc9UbQGA=;
 b=Ne1jb0sY1K5pGT+EgRvHrdSQ2L+Wg2Jthtnx5fQ+FyqfyF5sSNAUlTnaARzhB/aCR4N9zUhVRGV0/jl64UzuhUBLcPKPgaixGZDjGL4cElsT9dfv3+ROmLo3t6ifSP6gOFWLh0zED0AgFtx9blU2O8bJyLAzIzxq/YMxEexmsek=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 09:44:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 09:44:27 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 07/10] block/file-posix: drop unallocated_blocks_are_zero
Date: Thu, 28 May 2020 12:44:02 +0300
Message-Id: <20200528094405.145708-8-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200528094405.145708-1-vsementsov@virtuozzo.com>
References: <20200528094405.145708-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0089.eurprd05.prod.outlook.com
 (2603:10a6:207:1::15) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.localdomain (185.215.60.178) by
 AM3PR05CA0089.eurprd05.prod.outlook.com (2603:10a6:207:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 09:44:26 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64531379-329e-4536-659d-08d802ebb610
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5366280BED388B7377E238BEC18E0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXqbzKCz+o1n8HAot9vLWjk/m0P3rdeosP6NLLM3twKewLqEOPzkRisEaY0TGECWQo73RsypGKpFg+QzMa9ju0J17/PvCjPMCLhPS4MF2zDM+iQIU1Fqk4cn9ZDQEUZ/wqMN3QVPC5Db3hBdmm4O5ziOGd+iO1TcAKxflqcarnjxNRIyZvU/ahXPQvzLJdAwLpMbe6iKXCz09R6prnfOJmDH1JxP2dbMAsf9ByO/yZMk6Mb0rbvuJRFdLANVCVGwAZNtAh+v0HyTtL7D5DVFgpYVWitL9ktyS8a9D3d8FKEna2HftoSamZVIKW2Q6GhDD3TROUE/0BB2ixZx6OqwMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(2616005)(4744005)(86362001)(316002)(5660300002)(7416002)(956004)(1076003)(6916009)(66946007)(83380400001)(6666004)(66476007)(66556008)(8936002)(4326008)(6512007)(36756003)(478600001)(8676002)(26005)(186003)(16526019)(2906002)(52116002)(6486002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aRbezgcIiKW9Qa3ZjbhrbS7Y9piYeEQfVqbELUplCJRfIPuAE8Mbz3l7QmDWNjGr/cI+sFs/mIdXp9z7or63UjpbAOo3xwzrS4w7aXjlW8jnejxY5K1Y2aT5OVqFtJAivf5buJ/LIYtl9oW1MAxRXUbiMHbje5N5qAh9KgOd1Hkjm+ni7Y47YnuLcgRmWn/nQipUDVQSiCQBB8kH9iFKvHyzqAywJGLO6HoGGxk70JrKpRb6t5EIPhH4oSwFO0DYF96puSGqtkk1HfaGoU0rsdDYug3+yfEuaN8lkiJkGcalGGJQFTLVzWfQXRzTGa/l9sApIL22FB3EVdtGg3IrmwHz6H3r+ArBxgsa1ug4n5yNEF/L09udRNBj1WA2gXhfwk+pwuvcumF4X12090c7U9BGTTcClPo2usLSVskZK/Jh0VcF1taCT71VGEFb5k7U9uJyWsZVHL8omwbnpEMlVhQgVlpNSu8Pn5R/HQ9IGV0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64531379-329e-4536-659d-08d802ebb610
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:44:26.9705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7GHuNFJpX4wrm36BOniuvsmm76SA34xVS80fW7c8nkrzyjo4sDoGqpC/u1HUP6vuwTXUZJL2kOlCSL46vtJoqPSN5bGTLMUZdkzntWXHNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5366
Received-SPF: pass client-ip=40.107.8.134;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 05:44:18
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ronniesahlberg@gmail.com, codyprime@gmail.com, sw@weilnetz.de, pl@kamp.de,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

raw_co_block_status() in block/file-posix.c never returns 0, so
unallocated_blocks_are_zero is useless (it doesn't affect the only user
of the field: bdrv_co_block_status()). Drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/file-posix.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 3ab8f5a0fa..d86ea57769 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2878,9 +2878,6 @@ static int coroutine_fn raw_co_pwrite_zeroes(
 
 static int raw_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
-    BDRVRawState *s = bs->opaque;
-
-    bdi->unallocated_blocks_are_zero = s->discard_zeroes;
     return 0;
 }
 
-- 
2.18.0


