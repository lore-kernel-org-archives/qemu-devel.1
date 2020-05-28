Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642A6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6AF208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="YdhKv8bC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6AF208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeF8N-0005N9-Ad
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5U-0008Ls-Mp; Thu, 28 May 2020 05:44:32 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:2978 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5T-0002k0-9R; Thu, 28 May 2020 05:44:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzHdanKOvIoEfqCfVo/rZF9/GPaHYtOVSGt6/3lVsiXi1JFxyWUkcaTC0SKRiE2BxCY+CwvtyTzYkquENSd+Q9pXnEvrhcDE8seM2YxTxmpl4O/qvKDHaqf5i20R/eRILpaXP10kfiwoh+3Ll3jXxAuYTJ3RSfYm4JkjQIGs6GMD8jKfS6Jtt0teF666KY4TIOjbDYErl7hyNJrQG3ua6EdfaQfgkFz5hrGN+ry56Ol3f9DV4mULmooiUhVfUYkvK+w/MOB+GkIzEskf80FQAiebaC9k82HiiQKEPBiwh2TWjlW4pFfbH9LL6R9Eoulv2WLLt8/c/HSFkevzWVNMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHc5XfsGgm9Pnr0ydl/EGCvoHSU1aCHnH5d1IajVg+I=;
 b=IvhGFLEVwr6mvF561/nL6WWYYOs5uMfYRkD74aVEWxtOG+UkgDZQ2wAhB8IJCQSdH8MQUUCN6I8uk4O1Qkm6SBytCjhW6aySIgG1gez8AyWklG5LifkwZUr77AoSEFwYifKcCcs+6GAA6cWrE6McYuwrHYuuXq/R68oCa5RwE6Q3h0UVaL7DIXgfRm7/xLm3ZulodkbjZHYBruArc3/K9pAzBxo9LcEcQejybDZ94buhwQHZjp5y6mm1CHYt6SzhhSkUK6QsprHc7qRU5eD/u6J1GsBQHpwSFblSNKtt4HnJmjt4EOho6Y4/y2dKHWQt6HnVwq9HBMmhKT7AZiZsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHc5XfsGgm9Pnr0ydl/EGCvoHSU1aCHnH5d1IajVg+I=;
 b=YdhKv8bCrNeTqmPHNC+YsIurOnZNcuA4esQkflWRykHcXvps9QiBJsr+hPTO1cAlijx+8O+q68+5GvdJndEai6Ko6jCWy27IciE4S5j08pz5k1gN+58Doqlr3MgDnWTzgx4+B6WJ+od1bARcwpTxbz3wD70pVFnqQtJiJkXdazc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 09:44:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 09:44:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 06/10] block/iscsi: drop unallocated_blocks_are_zero
Date: Thu, 28 May 2020 12:44:01 +0300
Message-Id: <20200528094405.145708-7-vsementsov@virtuozzo.com>
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
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 09:44:24 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db9226ef-d621-415a-0786-08d802ebb565
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53660D83B578E94E7AABEF8FC18E0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:605;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mut6eXP7bTq2HUEjWdfA0isUjjeqw7QqnmSkmepTHzL/na8feVQ1UT7hN/XIhSUj8A90Aj4BUUvE4JthogvWLKTFf79aSaRkHPFhyjm0yd9q2IpEoCbHc1m+9rZYWoqHEzV5DgtFM66zABi3DADIh0bRD7YNNMUGa57lgKFbXtGhhhU9iM8AvaxXBN6G86Ag3JuCgOAvHH3ZDKLXFvKxr4NIXCzAohJ8XbuSRS6w1kwPDxPTIXQd4aZ/9Ldd1BRocZFqYTQTTzAfLwyMeaM+x6a0AlaCfZbMQZaBDlRzfb1b3GlWz3+aa1TZxuxOtRPEfhYgNXOJy4PRBO9mJRHWvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(2616005)(4744005)(86362001)(316002)(5660300002)(7416002)(956004)(1076003)(6916009)(66946007)(83380400001)(6666004)(66476007)(66556008)(8936002)(4326008)(6512007)(36756003)(478600001)(8676002)(26005)(186003)(16526019)(2906002)(52116002)(6486002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: C6D2z1ldNG5zXyHh7dvWGQYgphNaLmCqde5EFmHpOA/LpA2sV5nJ2DSuVfn5lxLtYjq9tlwqgeg9tVZpfD9AC6qafBKosOXdlUeVVhQJvv6ngUhSAurwKAZ6UH9+sGcrA+UoevXUhB740vH1XRaSXRkLi1NQXvM9p8y/k3NVWbjOCCAWUEwqIsTCAu6tk2tGITSrVdGxWz8bKxhYIKxcdWUDn+J9PEsqc/enDFYC2Iy/8Oq8JKeT9IoiidXqaqLev+3u3G4x1S3r5YEGgpRJjw35k4XhCf2y4qIJSLHZuUbmRiuaJ/xKaxmDEoaAtYdeXJwkMTiILsFvmvi2Y3Y+3bqkDgZdKORc07h53tvMs6IULZaesFRSYrK/U5cylb+q1nXesT6sa1qWIZxqPnQBgYa2dGczC16FGlFnDs7WVLLzSg52bDVA6ZnUvoOlgGXzFy62YxLqDCBfmAqEKisWIb6p5wTyR94KQQ9kiaH1fZ0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9226ef-d621-415a-0786-08d802ebb565
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:44:25.8709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGhz7qhzZLo2UF2QwrDcJZ5gJ4v9Iu5EE8RCbqot2T0f9rTs9aKdC7d3I/6ReHKluYGOT+QAif+yPfdEQ71tFZV8JUrqDWzOSJ0mbDYtoIk=
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

We set bdi->unallocated_blocks_are_zero = iscsilun->lbprz, but
iscsi_co_block_status doesn't return 0 in case of iscsilun->lbprz, it
returns ZERO when appropriate. So actually unallocated_blocks_are_zero
is useless (it doesn't affect the only user of the field:
bdrv_co_block_status()). Drop it now.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/iscsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index a8b76979d8..767e3e75fd 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2163,7 +2163,6 @@ static int coroutine_fn iscsi_co_truncate(BlockDriverState *bs, int64_t offset,
 static int iscsi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     IscsiLun *iscsilun = bs->opaque;
-    bdi->unallocated_blocks_are_zero = iscsilun->lbprz;
     bdi->cluster_size = iscsilun->cluster_size;
     return 0;
 }
-- 
2.18.0


