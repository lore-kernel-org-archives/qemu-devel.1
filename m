Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01B4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2705208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hynXYIb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2705208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeF9L-00004r-Pr
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5P-00087v-KR; Thu, 28 May 2020 05:44:27 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:2978 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5O-0002k0-O7; Thu, 28 May 2020 05:44:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3GK4HVAOjqHb2vnltIeU/SMwsFY6nEqlKMqZjYuUHT6Gshnzxm7EL8Yxov5MrIOWvYmSzBJWfQCnj10Chphi8QoGeYZMWUf2SmIFcDLbYjpVG+igz/W1glXY9a0fv5H8lX7WCT6+dffzWm/zvD71oYm/6mC02NG8kDF9Pw1bNwuw8/DBMFUdPY860StQ0WTOYYj8JP7S8tPjGe7Ya0VxYfOX+1HiQUS84cCHI9JYXLHzfTEf0YTmOOdpsIcbnUcR9HnV4rEHFQmaaQJtTrcm5u5Q34Yd5TA7uCFmSbgMWrUFR+VvjxS1e4vSGLPpPo6vSX7xMRW20dWs/68duyKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0AmImOQ33k5aSJq+SXqWhrtj3a5yCp8P+hPQlOK8ZU=;
 b=OJ5lc/2G0DhvowTAvCi6V/JDVcOjSH5brnPzFpY6Gfz5I605B7vv9lDs3nyE+pQ28hPfXD2nN7nCK9adob6K3/Vw0zYG/u6mM1x+isT1kA2Vyz7QXcJIx78nsHOK6XpGVlaeTrJNjPfLREPxYIgljamO5WPFsjjKwSoJTxDWJwuQ2K+2by77mPs9RIPlWqSqj4mb6WNbMbNTWLa2qYrSR4D4LY9jo3hilraGU7ZLui1rwlmc23oLFHMDMoLMgahgSsd87+GP9xWvjiR3sMHyI6Yg3CBwrsOnilld/KFdgmv4zP0XrmxPWaapYZkF45c8ZU4kUZYIU30Nb5FzkFockQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0AmImOQ33k5aSJq+SXqWhrtj3a5yCp8P+hPQlOK8ZU=;
 b=hynXYIb2IZ4QBH2yq+WY5KL/LeSW4vohFdYEXKyrtQMXnEIq8g0FDL2nrrgriErlY+14Ep5vSuoL8m5s+7TOovDVzKp4BpjU6SkhEJiX4Buf7rww5rnaoRl9ymNzjfYCUT8hltVz3+RnR17BrwRgOgcCIVw9ekiJYy3X3A8VaXY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 09:44:22 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 09:44:22 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 03/10] block/vdi: return ZERO block-status when appropriate
Date: Thu, 28 May 2020 12:43:58 +0300
Message-Id: <20200528094405.145708-4-vsementsov@virtuozzo.com>
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
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 09:44:21 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2383c79-ded5-46bd-f45b-08d802ebb372
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53664E8B201259F5CFCB398BC18E0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UWHnLL7tw+ky6OmCkU/PR2R2wR87Exvu2Aa/ozP4moYlbcnsfb+iCat+M1FNwvb+OynpG97oIZZW886AndjlDk//elBojLqBQCU9Ih6f3fw0WKE51/N08cZg/kFFsXw1LtrVbORbXn4nAedWLW3u9XHUPo/OZ2DqNscuNcVixeLbt5zf/u6tCXZueJ9A6F9QELphT0dz+3sqRqFw/HU9LUaFgk4znWpAv4hcmn6J9n49dD8n7/kYIEbRF4uHHaheHUNVbLs0XB+c3WGjUBCl8VoD6mU+sNggBU0al4+it7Asiat+7dRuJilITtMtXxz3LP4HY8FsZ/yKSubQ8ad2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(2616005)(86362001)(316002)(5660300002)(7416002)(956004)(1076003)(6916009)(66946007)(83380400001)(6666004)(66476007)(66556008)(8936002)(4326008)(6512007)(36756003)(478600001)(8676002)(26005)(186003)(16526019)(2906002)(52116002)(6486002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Sbo3uTzkvk2TE++lgl/ID1O1syqE4ZU+bsUFhsuxuZ9GBF4eDSLXZeQlow/PfIIN0sL1N/UDvXNePu3rjlNnwBBj3Zg+PNff2x7BtAAF2yDk5nADlox13Af+PV9xeqHaPE8Ur0cYVOyH8ADyB12A09CGC+46rvJUsT/pESCRLX90f+wCgV0AOyzyr+W9uzryrFIc9cTnlvuH8BUeV6rBoOuCf6uvy4l1F9Hq0orxO5aCvqOHOw1ofMqDSyyudY0asJ/uo0kEZWZ4/nk9tiHleiEA9n0a47X7Ft1X4dWK+rOksy3UpmQbKdUHI/xOPmipu9i2JzwuQ4QKN9LF7Bxk9C4ZIt/D0S/wDaroOGwYQC4p6q5durtF/qHOSnRUjIv30P7J3QtXQcUYUJifdW68wKIqlAgWL4Ey3nmxQ6cxrnOinAnlIz+MxcxwSn+ixk349yYuXArra0EIRSrf2CIRCICR0eOQ1KrKPwU+BEjVv/s=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2383c79-ded5-46bd-f45b-08d802ebb372
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:44:22.6460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvvOMcuPK7aB6jBZqitKsjaAUl4ouAS3XcZfROtfCK4nBK/Pi17v7100s532eoyACzo+O3lQZ+CunHyKfIq6HbMSDuHUI2Tz9DeE6CcvPCY=
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

In case of !VDI_IS_ALLOCATED[], we do zero out the corresponding chunk
of qiov. So, this should be reported as ZERO.

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
just make backing-not-supporting format drivers (vdi at this patch and
vpc with the following) to behave more like backing-supporting drivers
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
 block/vdi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 2f506a01ba..c4527a9d8c 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -334,7 +334,6 @@ static int vdi_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     logout("\n");
     bdi->cluster_size = s->block_size;
     bdi->vm_state_offset = 0;
-    bdi->unallocated_blocks_are_zero = true;
     return 0;
 }
 
@@ -536,7 +535,7 @@ static int coroutine_fn vdi_co_block_status(BlockDriverState *bs,
     *pnum = MIN(s->block_size - index_in_block, bytes);
     result = VDI_IS_ALLOCATED(bmap_entry);
     if (!result) {
-        return 0;
+        return BDRV_BLOCK_ZERO;
     }
 
     *map = s->header.offset_data + (uint64_t)bmap_entry * s->block_size +
-- 
2.18.0


