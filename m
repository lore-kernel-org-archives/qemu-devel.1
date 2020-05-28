Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B86C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:19:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D7D20776
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nCC127JM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D7D20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFdb-0005NZ-EO
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeFZO-0006e5-Gr; Thu, 28 May 2020 06:15:26 -0400
Received: from mail-eopbgr140112.outbound.protection.outlook.com
 ([40.107.14.112]:28150 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jeFZN-0005Od-Ll; Thu, 28 May 2020 06:15:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWPK6XUBIf60vgyMGO2o1mdPcaQpP9PuBwyi73qmm/JroRVjqweFNf/tsjo9oYZEZx9r6FQld4KkllhhJBXbN4a75+tCAuZV36Auu618sItK9oBEDPW2exqod+PVbHfM2A0wh4JiQtIYvcbgP7ybdaE6odxX8H26A2EniRV/Pb+wkKW9hvWscpypT6fr4VTPBCTQ4VCtQRFDb0kq5LCQl7pbFEbqou6pvpwj5ks0D8IVxVtBPXiLEzYaFfS15kEhiAt5Iy8vhwHsVgMNPSHr9Eu1gjP/LFhcX0rtM76jPQjCmgVRgrZM0bLmKt0pImBNLIw5CmCsk/gglhDa+3TFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBn5Y87eYZG1b4lfGg+rCj0FmIsVqybl4mdN+rrjqks=;
 b=h+zzDIU40g6ZaENrMlMsd025seCVcML7U7yEQ02THyeQQMs78BM90XxbuSmjxi1YEKaMMIQmSCKVY0PSeFuSrWDhJrk0whZmA1BJNXJcH8pbDoyOeXF1+0Yw0ivTfv87Y7YoXTZr+A6choxQZvUm5AFvpRWTelagS2NGAwGscLjn9jdWFLIb05hoX3VZvSkTJASoKTCKnL+iME2MbNwTk5UMxUjuB3dN1N/mHFSxpHKSO5uK6zOyVpxm6t0OddxtLNPncUyGEc0wVD/Iydm3v0NzyfpFUH6eUySlBtMLtcVsT+5Ekfk11ihrV7+ufbuA7q/EpuELMZfvx/nIQmmemw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBn5Y87eYZG1b4lfGg+rCj0FmIsVqybl4mdN+rrjqks=;
 b=nCC127JMiB0FPJTqZZcapMgKrlvsSE7tAOIBM4Bcv2QSVsveEyoUwID53VK8Gz3r3zNIWMFAv0i17Euz0BhUx3ivIvXbQwBeg+0JW9T3EZMVcHCg6dvGdsgSs3Edmt+xcGtbtUFWo6OsLbmlqksvUHYxPnXOGKU4g9mnO+FW81w=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5317.eurprd08.prod.outlook.com (2603:10a6:20b:101::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 10:15:17 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 10:15:17 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 3/5] block/io: bdrv_common_block_status_above: support bs
 == base
Date: Thu, 28 May 2020 13:15:05 +0300
Message-Id: <20200528101507.151161-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200528101507.151161-1-vsementsov@virtuozzo.com>
References: <20200528101507.151161-1-vsementsov@virtuozzo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::31) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.178) by
 AM0PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:208:ac::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.7 via Frontend Transport; Thu, 28 May 2020 10:15:16 +0000
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 933b8c27-08b3-4541-8ba9-08d802f004cd
X-MS-TrafficTypeDiagnostic: AM7PR08MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB53172FCA6D4D6720ADCBB31CC18E0@AM7PR08MB5317.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtCZvKLTiK/E/7Sc9HUlEsIY04cu799NPgilJOOPDe9z8b7c6YMlcoqLJs2B6qFmYIEwN5BO3ADVFfglhqoeC/SF9bgiNyK+nEnkXArm5fYGc2h0IyE9+LEHTMxgm9hzUTzHMLp8KSQSvJKqCO2ac1SRDiM31f3XaAjibEP8pBvC9/qFGRamkv+HNjlsoZvX983Fvb0GChfs9MQK6iNC9WiHlT9I0KnK0nAjzupOnb8m2/9SGTVr2O308quVzj5nMA6XD7HRngpXVc1cVgHuvJeGWFYa0WnO/9Yb9GqWQ9RnlVousXBSUgwctMgv4TG3BSOTGuTcoeHCpIixtUuwlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(396003)(366004)(376002)(136003)(346002)(1076003)(26005)(6486002)(5660300002)(8936002)(6916009)(52116002)(6506007)(478600001)(83380400001)(16526019)(4744005)(186003)(4326008)(2616005)(6666004)(66946007)(36756003)(107886003)(6512007)(8676002)(66476007)(956004)(316002)(66556008)(2906002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8qjl+UTp5Nang4S7QGshMIhoZNhZmMYrd9KS0gXs5BA+MEYVrXV4m4Uk9I3eG04M77x0aX/tMa3xJ1t78otngSyKHr8Wkc+hYkh1kY2GGMh4EvuGAKLDdNEY/npmtrL8p79I7ftyk/84DDK+a87dLTBDrXY0bTq1V4nPG1LoTArhjG81QF2bKAMkA4R0BgCR6mcWusHFLsO0XW/EqtYXEgFYJVM9Xr3s/YutSMe4Ivpvv5GE3BeWHRJi7NSsyH1B0hS/iuKHMuNQOk/7oHDBkxA3flpcfyrC7lEjmK6sGx4/bsVqO9bp+tTlZB6Y60JO/VutmKSLiQ0FJqJExjUltsnWb6wQT1i/v/jzbj+ZIgoaez4bFKZWXJhs566I/klMHau2mtz2Dv4ehgL8D+0Y/B4iMyMb4zRTQgiJx2tv2dOqm0RMQV6E0SMWBBJRGBxLbToT+lpRz8qbEx0OuRHJuZ2RYQpKW1be3qWm8M9SLi8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933b8c27-08b3-4541-8ba9-08d802f004cd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 10:15:17.0339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sKreslJZS3H9tQ89Nr71iFGLCZK9Lig8QZ8bRb3okEpHwrie23nl4NPNa4i5nbjSRA8MP+JHu7cDEKik0DE7uu9kuLIPQnEQZzxB3l904w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5317
Received-SPF: pass client-ip=40.107.14.112;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:15:22
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
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
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
index ae1c806720..6f90b322f4 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2458,7 +2458,11 @@ static int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
     int ret = 0;
     bool first = true;
 
-    assert(include_base || bs != base);
+    if (!include_base && bs == base) {
+        *pnum = bytes;
+        return 0;
+    }
+
     for (p = bs; include_base || p != base; p = backing_bs(p)) {
         ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
                                    file);
-- 
2.18.0


