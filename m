Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CD2C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A9A21D24
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="dbitehDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A9A21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWXZ-0003Hk-JF
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIWQd-0004ii-Dn; Wed, 16 Sep 2020 08:20:52 -0400
Received: from mail-eopbgr40130.outbound.protection.outlook.com
 ([40.107.4.130]:3150 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kIWQZ-0004Gb-Co; Wed, 16 Sep 2020 08:20:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g28Ze0l9FastYGLK0cfSlEma3WVlaLbXDR8H16LkuyIEW1Oxm2SqBLB44n0nIt1ruGWRpFmJbMMaTz9g4DjVizhbyJ87Kx8gisf2tCoLTcaS573e4l2yO/Onr3WfXNPOANDE6p4aQs1rwhVaTNRnuVwuDRB3wqI+pKMHHaT1/4SKR8agqGoIVrXu1/XIayNvBOeePQYBM+DAD4Ti2uRmFTp29dl3YuxNqbhTFsQMSZ4koG4M/2Hzfto8ngiV7y2bLt1zliXtM/HTJzzTQ5J7KRwX/yW/eMmuM0LRNPwuqzCtIrc99/z2GSCOC49OLyZpgCtp6IrYzjqdM931LspB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk6mX2hGgoIVZs4ZKciVH8v7c8cE9zkajaY2lLjmRk0=;
 b=IXjZ/2fUpgnMZf/UUsqJVHCyUjrXUR17OMo7HmrmnPliwkpW49xrq3vXOIyw5U+sZTg/IFCxSPHUIrD6WuxpoCouUjA0Sx7uJSSlKf9uPMxxywF3vTdNkeKYxyZ2MOtgw4toJNqW4A19Hri59Q/8LPciHokVvIAFVgnyJ23NCbVBgK0NXy1t+q15OBJ0Rceou0OZNx5X6L/oI7Q3LiiUDoo06KzpEAqZdzjnmmX8G3YDtdVRBqPrYPvRXG3+0t41hsS5RhfSRCJATSdi0OusABaU6uc3mOMlCJ0xDitOFCO7BFFJuurdSo3YWQmiCTgqOkTFREs0x5kfL2Mj711ERQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk6mX2hGgoIVZs4ZKciVH8v7c8cE9zkajaY2lLjmRk0=;
 b=dbitehDw9JZ3ioj9T3TJCh4wVh2hWCLyFkCnl5mvObpDnMTKYpV6l587vq8eLR2GW1a/0seieluCzutlZSH4wa9ojcG422nMRLsOUPslDlg7CfZaU2SuTIcB0S5vK4QnCS5tcV2Pxr+zsKeSwMOwV1I5Ktq1GKc3ncMpHzZ9SGs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5077.eurprd08.prod.outlook.com (2603:10a6:20b:e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 12:20:25 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 12:20:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
Subject: [PATCH v6 3/5] block/io: bdrv_common_block_status_above: support bs
 == base
Date: Wed, 16 Sep 2020 15:20:06 +0300
Message-Id: <20200916122008.20303-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200916122008.20303-1-vsementsov@virtuozzo.com>
References: <20200916122008.20303-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0018.eurprd04.prod.outlook.com
 (2603:10a6:208:122::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.75) by
 AM0PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:208:122::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 12:20:24 +0000
X-Mailer: git-send-email 2.21.3
X-Originating-IP: [185.215.60.75]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6d9865c-1ef5-484c-9f89-08d85a3ae407
X-MS-TrafficTypeDiagnostic: AM6PR08MB5077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB50775C00D5EECC8D1B012F29C1210@AM6PR08MB5077.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MBYcV+cbDPOGU+Q7o2zKXPpW3cRd8sldzJZUjiAvOzeHFn/0fHR4lqn6npNWXMUIbZ5R9rEot24azUOAWW5VZtIhZYw3sWc/aaGqMa8NDM5bBUGd75GJCs0JZEjK3cMrvpBhjAHizfcHrH8fIRKAKuIXL9JTkQ0M+XSMr1O7e0apMZV8jQFrWadRR/4iInFNy0dCf2YWM2Qm247xjscabJwLBSaOcJQzQaaJvFqSlGVye87Q515K1EMC1fV8HcuFQA88u3c0NiaMIzyoNTwjc+bPVt46r5mH83WX7+ojYIJ8UkPv2freQVztW6BG899gRxqd/VDPDucR+k0px6OSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39830400003)(366004)(396003)(26005)(16526019)(6486002)(316002)(478600001)(6506007)(186003)(5660300002)(6512007)(2616005)(956004)(1076003)(36756003)(6916009)(2906002)(8676002)(66556008)(66476007)(86362001)(52116002)(107886003)(4326008)(66946007)(83380400001)(6666004)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Py9um2yHlQh6nYQ0ouCUBYN9kKbP5q8HXlfTQmw77gZuBKAZHXLMwYd5pdtsuo7UvBcxvYOEFEuN6g2oFmh4vjnoDjsiH7wKWfpv7drxtGyrutBbpsWdUdX2mjH42mRSz6Uka8TxjNLjmFtlw7OzRC8ZOPid/nYBX2q/QsThCAglo/74V/auFMqeQfqy4GntnIvxLtuCj5Z1BJCNH0eQ/HcrXsnDB8VB+TkalZ73Az38/+jh2IzckZOIQw+l5egtO7w7+c568w9TjKcY5Mc0lropUEYYlHZB83Ps4Ajz3KV01qCog+BSXkIhCTdN5FkN4xc3KuZJx/Z0clxilig5DEsvgMJP61bU7Y30Bgu79uPoEqjC5Y/XJ9PDW33KVYJqHtQ5by278K3/e14nn2eRFxJTav1lvFTnjLVQu+5FhanDw8q0ME9tWyqsyVwz2uUfe+N/SeJXNKBEzzimCVs79nbFvbHMjIuZzCcAJIKPIz6px29xoA3JhQlqchqX6u1UEdI2qz6f0fiAOTfnKyw/1xoMn4UQ6k+m0nvEzjizAj56uY1I9ZozwWSbjyaWroOwzBKfixvIzVh3WVtrKrgKR+q2akXdgkvxuRWqAbvkHithl0VOmlHRkExmCKff5HSY0zjig42ZVA7i4KgAtDst0w==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d9865c-1ef5-484c-9f89-08d85a3ae407
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 12:20:25.6020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VH6EUWBrCr0l/Cmm0yslBOjcY1/in7/Y4Hq9L6wPme3eQ3j8Svh+M7PO1Ov1wn2QWwq5i0VCxbSUU2hNw+TNM08ALZ4cf3qYK7d5utt7hTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5077
Received-SPF: pass client-ip=40.107.4.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 08:20:24
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to reuse bdrv_common_block_status_above in
bdrv_is_allocated_above. bdrv_is_allocated_above may be called with
include_base == false and still bs == base (for ex. from img_rebase()).

So, support this corner case.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/io.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 0cc2dd7a3e..d864d035ac 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2371,9 +2371,13 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     BlockDriverState *p;
     int64_t eof = 0;
 
-    assert(include_base || bs != base);
     assert(!include_base || base); /* Can't include NULL base */
 
+    if (!include_base && bs == base) {
+        *pnum = bytes;
+        return 0;
+    }
+
     ret = bdrv_co_block_status(bs, want_zero, offset, bytes, pnum, map, file);
     if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED || bs == base) {
         return ret;
-- 
2.21.3


