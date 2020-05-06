Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DB2C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9686120714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Bqw/q8OZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9686120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGKT-00017L-NU
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJR-0007kX-5L; Wed, 06 May 2020 05:25:57 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com
 ([40.107.2.115]:7399 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJQ-0006M8-7K; Wed, 06 May 2020 05:25:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECIvf7GR3UqA+XpMTN/cLis7GDTmC44g3mp1z3CpImOYxrIKWzxLBU84JExCaz8FYwV9+PqeuqoAC9uNn0acWi/qzX3Pbz0Ri7P4v5Q3nj1mETPsgVf1fT67rkC6o493nHAFHGj66XNNltVKe0e0PITbF7JbnBxlC2JELsF+jEG7FF00U8j4tEZgRkz/wocp/iAHISPIGALmnnI/ZH7WFMvq6paG053xHCn42Zna10LELM0RRlYv9xjfMXL2NIobn4TdcAvSi6PXLnyWFE2QcaOjitpov/Z9HsG/OV8gDHDtDVv3cSbQDuhrybp9rRl6w5cwbLsCVqK7XoNqtPWqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EpN70uMkgp/rhYbPjxKOA+xhVvYDR7cUp0ikthvy/0=;
 b=S0WE0RF4uNOX4MBlQQYqmi2fcTYo4q5JjdVFNPOP0bkHlJ3Jmjy04SLQAEXB8dgn9mI400tItFFqnir8zrlbQy2Lwd57HUxSy3AvJ7tgx/8Th+fORxakg6CCXqi+klP4RJNjq1FCNVB0dGpFUoM7H7ehxW7eGweJe2ULKnqq+kqCW3fek+dC5+l2SpcdJGbBvnHGVPlJyZNK+5qR2DB8DGUc1+8CjVT8LJTezYNCo74P9KmsoR5CtZt7R5xgMa3oAmC0RqrvKI31qJI2ZVTm2DqZNanWeA1M3AfZpxFK5D8cnb3Kc6RsQ3k3+gDecO7F71Gpr8ox0sUVF2Br4B8Ztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EpN70uMkgp/rhYbPjxKOA+xhVvYDR7cUp0ikthvy/0=;
 b=Bqw/q8OZSUjVOubeeEiwDGO4V6fzx98REFCbL+HtPOHdKoqj4drlwV36+EofabRzGdaQJGEJLE2uHIBIKa9Yq0YqLAt4dXNVRwbbVLrnQcbpnBCqaqpj2xP+jv0ux3mEkfGRmT5behCz+6/MZnur5VmVgLrl9JI4Xz5WbQcG75g=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 09:25:49 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 09:25:49 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/8] block/vpc: return ZERO block-status when appropriate
Date: Wed,  6 May 2020 12:25:07 +0300
Message-Id: <20200506092513.20904-3-vsementsov@virtuozzo.com>
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
 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 09:25:47 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2428ceca-b341-46dc-890c-08d7f19f766b
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5382A1CCB3EFFCD8C863CA9AC1A40@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fc6nJm9agt8tDwe2lLHZru7oBUkOdyVBWhI6bwbSRkTy+LpoNvAY2J8AL6eqkHyO2ALDBmZZ0tNMMLxFHKPnHbxbWFz4S61xe0Ap1Zp9hDYQJJ4wPzap9JaGnl8L4DPYQwyVNHJU5owMgLO5V+e/3Ohmr8lDPmf6G+ZoJcjdpccClIT5GUVkWIh789S6vrkytq20w323HUnffq5IOtSdwVMTGrrCfGoSjczL+6TUpH4JNo9X2FF27yhF6oTxs75sZ2FEgpRIVL0ZfJKl17ilY35NqYZYKBE/J8Ol0Af/oJRxam5ELXAyjfqqHe091X6xb2afM5fzNrD4O4KhMhsOYmXfXVqUFXgx9gAzH5VxH8l73O7kRV7OmGxQhs69P8xRvsqw9WHErEpgYJQl9h9A1pNXVB3VV3Gyg5f2XIxfng5OGKlsNQwgjGxy9iyvWyC6RL+2oxfJJ1Wr6F3J3ZAO6zSJRT9x0epmVyElAHikOA5qvzrIDRiXtrf0UihvuJt65Nz8ZrpcCuL+pqpGVi8/UFxgdXHrZkFyVwii0dN5FMzxboKqjDdlicW3lT0Ve+S4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39840400004)(346002)(33430700001)(6486002)(6916009)(52116002)(956004)(2616005)(6666004)(8936002)(86362001)(26005)(107886003)(2906002)(6506007)(5660300002)(36756003)(478600001)(16526019)(7416002)(69590400007)(186003)(66946007)(66476007)(33440700001)(66556008)(4326008)(4744005)(316002)(1076003)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ZDF+M/GSjfP3C6PLf4CYDNMOPWaeIpelYr+jP2gSmjSq5KfifYOE+7N/mH3LpVj+tkAb0zLpwKNBaNIzY1iYCT9ZhYw5fQQKuzPazqwwL2t0BOM7WdGo4NhrGY2GYuOcrL/DhaS8+w9dLzhM4loUxnBYCuBaJOWtISKKTdyyu80K1sIA+CdIF71a2hO/D//ScKcc+AsvuSc/79PVo2b2Q8uHcfwy2qEMd5O3D4tpXuW9EmVJT11qiMghLoVswuLlJjCvgZ+PrRmqHuM6MiaMKNKwU3wahOQPLburpffSvITjeBeux8zt2JXBq2rqZER7R59gFh/Hf1qhPn+WdlwlvjUK9dpKGfyLUB2TsGqY0XPVsW0gD9DWDZBY3z5oTacCWiTf1G2EyuxDKBOjA+8FvGSqTin3p7n3LIBFWnZFHljIaRv1cKB/9f+KyvkstqcQ5l9GPJ6jVJ4aOARdHexi18aIMrlWIMSV697vwVsEGgkTpzF/UNvXodL2ld5opTyiDimEn9HpaP04GF6+9uAe0s1CKccpNmCJvbIBFkiA/6ZrCP8lF+W7aiA2avQJw6KyPhs2r4nCNiKpa5G6EcR269eecXoywhgOP7GPT8q189l4WlyNk/0EeaZLhnFDLMJOE/LBAUbFoanQAlqTJJAd4+LHbqRgBi0wzfrmKihv46lZR4Rjp1GHE3HKrBjMEpDOnyrqHzSJSmOwRfnzO52vQyAQkhBohBN6SWyTJProU+P3dSMtDF06ps1xbBvmirlLurMyYEfqJsWV/bhzu2ZZ1NIZTUlvEOnCp55b1X3LgNo=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2428ceca-b341-46dc-890c-08d7f19f766b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 09:25:48.6132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7YfbiYLjMKOdlGkS0OesNHJpjIb3tZy4toNUkYUZnLwKLhPM4E4QIgSB4E6moquCU1EmDHiUAObaWcP5SqU8EumB3iFgmqqsP/lXJIqRck=
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

In case when get_image_offset() returns -1, we do zero out the
corresponding chunk of qiov. So, this should be reported as ZERO.

After block-status update, it never reports 0, so setting
unallocated_blocks_are_zero doesn't make sense. Drop it.

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


