Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBDBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE1D208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JufD2Eda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE1D208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeF8A-0004p8-6H
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5R-0008CU-7D; Thu, 28 May 2020 05:44:29 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:2978 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5Q-0002k0-8s; Thu, 28 May 2020 05:44:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYTw5/p6XbJB5v0Dczk9GKtGm4pV98mrBRBtEtGdcCIlIvHRkErnqackuOktqdR1tuxXk6GfKXpVhgJGKQdyR5bB0Dk7h8eD/Si9fbFGO7Y4sb1jDRi/qhPB8iZ7epsFQ1f+OL7DdKqQeOqUC+8HP0AsUeeuBJ0kNtEsSs65JUsZnpGULbs+MzWBZm7S2N5+fh4OqX/g3QWuAJBVhQsDm5ulf6yVQ7oi+24MmgupG/p1faKnfKSJP9RVFTZ2KJpbn0naTdJ215tG6Oo44EJcHSUTeNt/SLoj/Ikhd5qvg5WP+mxVXUaFOnc24Lnt0FfhbIyRl+3jeaPZZceg9KzH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsB+UkadptRccwjBM947JyuvJ/x1MOKbaYcyytHuDI0=;
 b=kcpaze/zTk9w/DxEbxJi5gEKECplhg+VN1+XYe2vFlYVSyI73c5oBSkP9lvaPiCpMZgl2u2LLg3E0Ox13lUp3Z4XjUFx8g8Mpp43oJQnz4f21Sz5n4TjE5KfTFhdICPqVg014dKxS3x4ejZLIexeI5TybklEYsIWSDf9/t32XOiu3z6SH0x4Fy43RFwFAgkAJ8pW+MZyqh6eTytiydekx9Ewx5dHanygf7bQIn+E+sorrgY0kGp15HVcL1x8xIz5Dr6nD3ddKNlx/NOeTekUfmyGO9M/JaJxbROxNEaFwuyjojUWBJ/2Uvlcc+rJLH9yMSfH0tH6Qu3GGqZT37Vd4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsB+UkadptRccwjBM947JyuvJ/x1MOKbaYcyytHuDI0=;
 b=JufD2EdaJrxVHu7RU5OjH5cL76FEL+b0fVH+emfTkMOXEUPAqpfkPgpb1iyTDnBqdnF5voDu3Z/m/BvuWrajGOCy4IFbRVUA3YYYXc5GhP+aZ/ywFD3cVHdUtX3pP0sSGWjirXnok+Y79hCeFDyB5VDU58CE9TYi6Gq+odC+W2o=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 09:44:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 09:44:23 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 04/10] block/vpc: return ZERO block-status when appropriate
Date: Thu, 28 May 2020 12:43:59 +0300
Message-Id: <20200528094405.145708-5-vsementsov@virtuozzo.com>
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
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 09:44:22 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e26ce506-6d1e-4a75-58dc-08d802ebb41c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB536639B54F235CE070511708C18E0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQW5GJo2BMK6Cfq0S+3goacyxojkXtduQs2w6vUKp95CzHNMgabNNuLgYjD2SS/svjPiT1Io4NwlOEdPA2ZmNpkM3gfFpPaRQn5G7JtZG4fpRjugKLqnXIviZg9WetF3wluyB/XiBut1dvDQYehGk1zBUpt3wp1FjLitbrvStV62N1uI0k6HDZeCVBxURmC8Tvszf7lLHITtDvnmqRhh6cvPQhqXzjQEQ5DeCIS3xZ1ScqPa2n3kAE9B02yJtCT4JAh3Db0olSvU+LhBjynShFtjynthKVa4o9pZNuEN7SLl8x20F/Xaegl2KSHgY0aJrr1K20uc4OAKB1GWgowbCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(2616005)(86362001)(316002)(5660300002)(7416002)(956004)(1076003)(6916009)(66946007)(83380400001)(6666004)(66476007)(66556008)(8936002)(4326008)(6512007)(36756003)(478600001)(8676002)(26005)(186003)(16526019)(2906002)(52116002)(6486002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: werFPaNItnWbczyAxlQvU+3zux/eaw1BKZi9vBpkK+pJqbGlJ0XyhKqpyBsE1t7kyjpbdBzFbPkBzHkm+/uNGgRuBcM15ccO4Bj+eXyaGt0Lvs8sACSMdCdDlG7cmsnrHO8Es9zQTgG6G8RtiUkgOt8gtoa1GxCyIZFjoA+iJJbEyK1FwUJgMf0iKsbgSCyBTQjBfv1X5TVudAvbn4k5DUIfZgcDz36ZAISDFPPXO89lWYZQlGLtPJWR0SWBLVCg28ILhajFkFDGxwdEyGblg94TQkZ/od1qIc2xuvkOaMfSvAdbPzV5M3HMNMCl9lCKbO+TjiVcWlv9Hi7hTHfeSfPuJQ662lCFM6B9MCrMu7o18GSBdks6fPg3qHZFZSc6uEH1te/BUE8SKdnpTy6RyR2xv0OLwRbvHnxzg0etgGF/Gsmn26PIQ/12iiyHR4bAF8CXIteogrsjkfcWvCrMwMdqKUafsPmiO9Xtk4ChufI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26ce506-6d1e-4a75-58dc-08d802ebb41c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:44:23.7377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GSFlnVt3VxmR1tGwUoUHjlTFBBR5aglJMAVUJ4UewX27Ofk5zTJpK9E8Kdd+ZkRQM8HaTYWrqdlY4dUcmtDXGVjl//DlxLXSV4CTMlAjec=
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/vpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index c055591641..01fcd37e3c 100644
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
2.18.0


