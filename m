Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9233DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3D3208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="a4L5hbuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3D3208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeF6m-0001vZ-Gj
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5S-0008GC-Jy; Thu, 28 May 2020 05:44:30 -0400
Received: from mail-eopbgr80134.outbound.protection.outlook.com
 ([40.107.8.134]:2978 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeF5R-0002k0-OM; Thu, 28 May 2020 05:44:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcUT1B8LUL//t+GGlt2ahbY3Ce2bSSJqluYWgUNRxrwloui+TEIN/GEa8jgap7MFGR3aWuF+kODN/X6HgZRubwbmelxlLAEZkpMHoGxpE/gT5ww4p3L09PnUzC6aDW0b9XVgYS+AdX3lmKkIw+8wcptQ42P6pooANaWyyqXdnwqQpPD0JXtpxo66pcKcJFgP17FvODJjGPJa5RspeJqHn3g7CkxLZGRGG4cRsk1O5I4LWV610Qe+qHfibbpfgZH/ccg7mU4wUclKBys8UsJeUbqiZGiSbvG4Z8AOcCdDTH1nni/FIZen5mv2/GiCNQbeVJPZD6T/RtBE9m8Z87UeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4eMlGU5HpuoV1iJqDRRgDlmqQEuUDPVBpSQ44ZQuiw=;
 b=WeYNcabdE0N8zOCG2AVWQx4hUOLsSo84i1CNhCPagMuR+4OaTI3iyP8uOOAMWvGajs6Ar0udxCyb6RD5ajgzP5lSFttYEoOsbyK3yObuIdxvoPD919qyiZ/+aLv3ob2+z7wlFr7hoAZbTqQRAVHw6PJdn+MLQlvbjReVbB93+e2jMNNwRENmY2S/DD63rta1pfefJ8DfdrhIvkn2VDcKUnyu800Dxn6h1XddpwPd0irpTeiRjQBgxf7qGgzaE7wPQE+SzDY6+WfCa2lA6L/8pilMO+HbUiiEd394BMAIcfoTvEV/7nTMw32Ll6E87zz1yCG6c8tHOnNtV244UCPB7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4eMlGU5HpuoV1iJqDRRgDlmqQEuUDPVBpSQ44ZQuiw=;
 b=a4L5hbuKhK8wQ7cD74FbMMbINbgUENO0HwCOGcvYwsgGxjcPXX7VldEMlrv2QTCyAmUj0LgqNSUpV3AtHCNt85No1vVBac4NbJ6IzG4arUYvnsvoje/aGhwj8qwjgcQvDuqTg+mKmNRkQ0fMmV4aKCiT05uVtvhFktQ1vVciPIE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5366.eurprd08.prod.outlook.com (2603:10a6:20b:10b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 09:44:24 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 09:44:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 05/10] block/crypto: drop unallocated_blocks_are_zero
Date: Thu, 28 May 2020 12:44:00 +0300
Message-Id: <20200528094405.145708-6-vsementsov@virtuozzo.com>
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
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 09:44:23 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5967e176-1dfa-4fb4-ca22-08d802ebb4c1
X-MS-TrafficTypeDiagnostic: AM7PR08MB5366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5366D43475EAFCED0F32DB2CC18E0@AM7PR08MB5366.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjYxe+APaQjRC31LVl1jUy/ACKmFScoLPp2i3WIjqP33wYlTdA1cDh+hpS0NhEw+u5b2oYgjSIG7a3fbF5tmOEDPrn7HOqQ3imwdEr7jUcIBf2nJ9kY7aZ4LW8xdFsuGCMZ1wExrCvfTxJ6rfv+ePrxeq28vGW4QdyYvq4Q2s0zLXbubjxjBMsY/FWCI90hPXpgg57f8OXkdQNvX0L28m/ATgwEO9C9NVEQ/U6m4DEfQ50RHZq0L7ob4IfSzfKdhWvi/6F/MDkqdu72UWFNIWh4urrmisNP1xBARZXdZ2XGgtNcNI6DCw163fJwgAgKaXdnsby/mJZox1cx97qV8eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(136003)(346002)(376002)(396003)(2616005)(4744005)(86362001)(316002)(5660300002)(7416002)(956004)(1076003)(6916009)(66946007)(83380400001)(6666004)(66476007)(66556008)(8936002)(4326008)(6512007)(36756003)(478600001)(8676002)(26005)(186003)(16526019)(2906002)(52116002)(6486002)(6506007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: gsaGgaEW9RukO+bFQ5PclCnwL1Hqgi9RSm7h4yYLPQyqDsm+xv+jvrnY6NcXBkX8cEr9QsK/15BwjDuecGM7pxCzmBtVpxglXb+qtG8af7vn8+SpGzs9VedkZh2EsUsc8BeV39CxDftDMZJXeGoXS5mzPu+VaPCjjNoyVhWg1u5oSND4ryJwPBgZgghauB29KFjKfl2WBBQ51i5TI8DCA11dDcGKvcuyxr9icjxtW3w1QvbRDH1ivHvIyECuQiRguq3mYJTMoVNVm39Cnu2o2R7y2Qshq92rB3/2XTSWK5J/5Vb39dFesuGN9zIpdTJuRMmEclhFE8ijQG/YRhVmBS6oUQhusWzyhcLW2My525Ieo93uHcHsKRGY/oRdmeenmXpBhxXdK1kB6PPOqBpdSG6JUa5GwRtXQdSB4I9SRHm7S5Re8zvPjRhFF7Vn/fR9zzIJOU+xsfmboEO+eLq9vqCDZU3lNDbB2WVo/0mO7kw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5967e176-1dfa-4fb4-ca22-08d802ebb4c1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:44:24.7871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhKSC8prvqDVEHOrUg5obyPWad+yf+NCoHvgZmNAP2++O3dCuNHDxnwcofXsO++45lhz6aDK9/waaXCSvN98Nc2hy4FIaRaIhZnhECKXUY0=
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

It's false by default, no needs to set it. We are going to drop this
variable at all, so drop it now here, it doesn't hurt.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/crypto.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index b216e12c31..6d930e2d54 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -710,7 +710,6 @@ static int block_crypto_get_info_luks(BlockDriverState *bs,
         return ret;
     }
 
-    bdi->unallocated_blocks_are_zero = false;
     bdi->cluster_size = subbdi.cluster_size;
 
     return 0;
-- 
2.18.0


