Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE6FC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987962073A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="oLGG3S3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987962073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGOt-0007ax-RN
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJW-00080F-UR; Wed, 06 May 2020 05:26:02 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com
 ([40.107.2.115]:7399 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJW-0006M8-11; Wed, 06 May 2020 05:26:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULpASXb7FQTgwEdHUdW2IjunVgH3e2CP4u8qwEtJ/Xbs3/liasCaja6wyfnEeQG08WWlp93nEfL5Kou4G5/dNwSBhbHL8YH8ye7BrDVsXFj4vjcvBpiplXGCN/jlDKMwgGtnN+cWC0mmS2GZeKvi/y3jaI8HjrbQeahvkyYB5F7DeVNUvT7/vuD6dH/Cj4zFBfomRAZL+uiD1CAEyTq+Pm9UIeVrcAYUgSbrhOScElgIJb+hJeP4jSC4oncuNU3XlqJFvcP31MWwmJQzLgdYiyttX8WkOGA1J6+ftsX5HNOP5E2e3wPOQjAhyBUtDMuqdsQVc6YdVxLgr8bCU9KKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSXnq5YEH64tq5COWIKr4xJUGg7k87XezzJ1KazDrUU=;
 b=Bgl+5oClLqerNFO/2BKAtVFFsTYHpaKpgpwAoYbyiPqBng1FXXl4fu0W3r7MYZDsiwycAl3fQAWVb6Id1b66UlejaDUwl8TooZOCEPRirhSavsRIdV5vrhkQAAY+SFyuHJpzaV4BZ/5xW1ObKD87SFPmhlKfCsEKiDQ92GtM0i27S+LoIP0mc/qIBaKS/7dEibE4rsEdAzJ/ExkX6ttMxhQbT38pJdRKjQb0Vo8x5Au3KlYHeIjOPsUjnLBDE7cvcZZ8f//tECW4IhLkSOnCmyX74NZDp2QW0Wd+gtP5PBEnXMxc2gqKev8P8xnwo10hamx04amk11UmXd9Xck5NLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSXnq5YEH64tq5COWIKr4xJUGg7k87XezzJ1KazDrUU=;
 b=oLGG3S3X6ei7Qioj1/ZbWv9r4gkwDVuL9l+FHRljATfY0CySeKIzYdOGPkVffmMxQ4B/l8XzVsqTHjUEk7JZ7PVu7Zh0ucz9OnZSGQlBtxGpUMBoHVexT4yrHQJWGH703mUkDT+M/1XtdhFc/xN2OrA2OHGqor5xs4t1FsJOaW0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 09:25:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 09:25:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 6/8] block/vhdx: drop unallocated_blocks_are_zero
Date: Wed,  6 May 2020 12:25:11 +0300
Message-Id: <20200506092513.20904-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200506092513.20904-1-vsementsov@virtuozzo.com>
References: <20200506092513.20904-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.178) by
 FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 09:25:52 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 473f1a49-1d98-4505-4466-08d7f19f792e
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53820228302B01EAC3FA657BC1A40@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:47;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssURfNn61NawZ3UpHafDnDWto4ShKQsWF1iSR3Uincf8hSJeSTvAbJuE6uKjCq1AZEr/XM/v2HfgoDsXVViiUv4lNweaaI2Wj4vb3ScEF2isIUP1MrARaULZNbcm70EWWvkfkISDqYGInUTRdTZ222UFnrUanEAAbI9nvQPrDlVkqqx4PtBMkVOiXyT/VNI0CyVoTNqltFi8AjNowMoZRF4Q1XsS0XpHn/5c/Rhi4U4S/cgbl83s1V8EFSBhyJNKwYi6dCc5OwksaH5g+g0yUm8KjLZsqD8NQh9UaEkDsKHTPlQt4uhOd6KsC8J0lGX5NzMwJ9M+b/i00rpMvQjQEJ+xQX6y3ZYzEdB8tlqjasgMv9SyGo+nqPqxwIFCDFK5tvogSg/oe98R9zo1+ObvsdRamaxUJtdWW6yf0E2GRblw/kHr7+UI7Ob7qZtdoAMTRMddraMmMa6OxyByGrLnCzdUYlgGbrT4+DWrCCnjflr3yjRYKoqqOLx1b2bxt8+QWrtBz7YJlVkuhT7KGBBrZMGaYCJF20CHZDUePDZXMpTXcJM1zuFNo5m9Lt0Q+tHl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39840400004)(346002)(33430700001)(6486002)(6916009)(52116002)(956004)(2616005)(6666004)(8936002)(86362001)(26005)(107886003)(2906002)(6506007)(5660300002)(36756003)(478600001)(16526019)(7416002)(69590400007)(186003)(66946007)(66476007)(33440700001)(66556008)(4326008)(4744005)(316002)(1076003)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UCdlRn8ED1bwklAa99lhcqLId33jJPQ27DSo/HR8HjV/G8CqWuAy3Qx5cnk8u1zJ2wcAI6Mlovbyhjvq/M8nlR5GQPyBtdGYjUc6lontGnj9eNtxus8uitQLZke9gZXAX0lMB+ZwfXswVWckrfKShWeQI3o58GLlGfVvqA5FnszKFl3y3dDKFmJ8LPcOc8gSwnX9jSBnKssyFZvKrhWFJBC5bA8tFjemfDtnVLw8RUy44n70etWni1NTsTau/7rHtlValxHHCWth4/U4S2qgGlrcP2l0y9yjDP18wxXfoRtq5Emuxs0jcboC1/w1B0k4DlQHNQMkkdlM9TyDqjGb1NEFBmbW8dNz3IjnoJsavEoAHrd9tww9/pwyovTwc9qKQUFmO4wJuxcggFtqrMYzJZBKgNwJcks5Pr88Jk1+5u3g0ku/C4EbOuUeGFg+MwiyEheqBY2vx0tbTRTkAKrda5Cti/Lc6AsjEyfSkV3b1yTS3lJwqZmBztkFfCGPcxK4Nutoz+0KKTrpI13qwatAe7i0bB5CbsTM/hK6FmsK+Iy8cDtdBEMPJKPGOjgzfi3kf+IBjDXf+7aOSFi9TidEk//+ec+NzNpPozeYpz/6di9fZNfTJ91nEkPsUB6hXoElGTJMd5d3QC4D5LXNG7lXNA7+uDtySzyerjtR43yikeQuaCDTIA86P0BpoUqnbVkrxiREeqIkTlboKjrx1nmwDDMyCT3SUZLxDx4TPukSprSc48vtGQa0s9CbggpL3CDYOR0gLImmtTqJ6wp8wfEk7WzXDoLlSIJD5cXmN7dXCYE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473f1a49-1d98-4505-4466-08d7f19f792e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 09:25:53.4510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmiAZpQDu5Iv6y+4xwD859u8BIFUtpb9/L6NeMNEWH7p3k2oikRd1hptxfArO/URg/cQRXzvztm3nNewrJAFe/l9u7ao95YiDqb/RYDRiEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5382
Received-SPF: pass client-ip=40.107.2.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:25:49
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

vhdx doesn't have .bdrv_co_block_status handler, so DATA|ALLOCATED is
always assumed for it. unallocated_blocks_are_zero is useless, drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/vhdx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/vhdx.c b/block/vhdx.c
index aedd782604..45963a3166 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1164,9 +1164,6 @@ static int vhdx_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 
     bdi->cluster_size = s->block_size;
 
-    bdi->unallocated_blocks_are_zero =
-        (s->params.data_bits & VHDX_PARAMS_HAS_PARENT) == 0;
-
     return 0;
 }
 
-- 
2.21.0


