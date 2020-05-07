Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45368C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117B62075E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 08:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XeaNPUpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117B62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcGG-0007AO-67
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 04:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDI-00021z-II; Thu, 07 May 2020 04:49:04 -0400
Received: from mail-eopbgr40111.outbound.protection.outlook.com
 ([40.107.4.111]:2308 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWcDH-0006ET-DJ; Thu, 07 May 2020 04:49:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQYAZgbvcPaICd2r5JsdvgQWjJCzbmPFyeVe235STX/BU61e2FvOutJvvPN7dM7TzNytxBGI4/Yzh9OA1U3vCv0AfaFgZw1wJXRlTmUtsFfgo2QOqrFifoaC39jItUO9PfyNsfQ80m9FIzoVKgjIQJZ7L233qRSP+sl6kRmM+D6Q1AA0oiSvSx88Yx34U1Q/fYKUVXZWxcu1Ao2P8j5I8kpeestijuKQskABgK9ZVXCoQzw3ccLaW4YE9DZ3wFc8R/PywSHfZZxCaWeIyO3esDTGtHgU+J599LdLtk8mKLkO2xtutskRFAD63NOZ1I4NsKT6zWPuhkE2dlDPzFXsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELUvFv5R20eBBESfHssSDSiMo/Pt4r/eBrm8poHTVjA=;
 b=D9tQI7v+it9qbF2biV3MKk/QqcQrqffbYzJISOLY15bFPWpZTEfYJhWhQjMfE7YJkIijrZ95Mq4sZwH1QF2vqyNLw6+YlghncYuj8ij23b49hMC+4jlwDUJntSkiiku4VgSTCAwu9ZchZbEklRiEqNEnDiogEnoirFbj3SFOc7TQGVsGV2SNUveT76A+pR95EwPYuNjeCYQVT6r3wMJ1kuGtZIYqKb++nAnmoT5rUnXwa5bNDIC98Q+Hq3xvK5KOEzqw6wqz/VduoqhulcIP4PioORvBHwUp9WSZTaOVai7IAA7Ifp44BdliXrTCPMbAiJPBD9jif9dnojY4dwR6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELUvFv5R20eBBESfHssSDSiMo/Pt4r/eBrm8poHTVjA=;
 b=XeaNPUpGLaC0tgJR728awZh0S63aQgwdnP+IDJoH0RV1kmR/Bel4KDsWcNVdVi4wGQMqmG3biy7TLIin9+xJ399mXlRoZMe5KMW5QAl64sP+GmdTB2G2d+BxGTGmr+vkCEiedg36tFTAlIBDSZF7X7Htb1wIWFSqkqiupRLA9cE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5495.eurprd08.prod.outlook.com (2603:10a6:20b:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 08:48:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.034; Thu, 7 May 2020
 08:48:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 7/9] block/file-posix: drop unallocated_blocks_are_zero
Date: Thu,  7 May 2020 11:47:58 +0300
Message-Id: <20200507084800.20596-8-vsementsov@virtuozzo.com>
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
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 08:48:41 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 031abf18-5639-4035-df98-08d7f26371d6
X-MS-TrafficTypeDiagnostic: AM7PR08MB5495:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5495C4C0DABDE88B8DB3385BC1A50@AM7PR08MB5495.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Di8X6hBXqZPoSZx+dhBqhW3U4Cfx8WmSB3VQaK06UKvUDO1WLrpm44geqwAKJ4TWr/C4IDQJZMHIVnN4+YvHS6bRJ+XznivWiDso59/KdILP+it+TdcSrpZ7MvGxBs4D2Ro1NAy+KNIKFeaZ4KccJMGFPNPE1H9J3WxxRfCONTb4ARNEWfYXzS48sBhgVVSDOMznkDt0qDq/+VE+YhXpnQh6vYQ0oZsASmEGZanG+XPXaIOhShJAlQ3wHDVqjBsyRC7dB3DhMbgOn46zHHh06OR/DqCs3FM4iS7uqxIugkMnH93TYgI37dTk4gqDfs9IVCPgh43xDSUVbDUELvtzQan57xOsHXcVZ8JoJP2yzZLOCPYFcWSatQhYBfiFvIcMRajyWFuIkkgn8lAXVlZzB2A5mX6eWKD4DGWqCm7c5tXAxDFEO/3M9hvZug8EUMLhjxpjsK+Kg9u8EykagSKp+Jkua6FNRARiwYb0e6AJN88xKvANfHYgfJq0ApYTg4UgB1j+WDPr+Gkq8RusjdOMByZvm/Mvi8RfCtUXTFzj4OPy4D8H4yvitHtsewdCZoy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(33430700001)(4326008)(478600001)(66476007)(66946007)(66556008)(4744005)(5660300002)(69590400007)(2906002)(52116002)(7416002)(6486002)(1076003)(36756003)(86362001)(6512007)(83280400001)(6916009)(186003)(16526019)(83320400001)(956004)(26005)(33440700001)(8676002)(83300400001)(83290400001)(6666004)(2616005)(83310400001)(8936002)(6506007)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nBdx3cRSfA/Mt2QQOitHqz4GDcWodq1EnFXyrUdXBXwskgW/4dN2rabymgMml3xiYXQsZ3XOJikGYb/IW754ISHG87dBgGb0rNnw6myDBAo6I8lx7fPEsF0yoeuaxE7EuAL6NjqAJMKZuMcLzkAEQ7AT3LV/NmZYcejkYBjMpZbqaPnuXghUn10nq9aWs4n76XToKuOt4GiemuEORdGjCHqmkNigHZ1+2qYInPrTXDyZlQtNr6/MA8jAN2LxgPZXHm/jXi/zQCfW3oxgdcYT6XllCcBxcsr6Yrly+UrUtluhoMS+Dz0Ylwk5hLs7Y08N+IkxrNsGwknAr20UeLcJoqljrNYA/nx8HymMeZhVKskbjrov8To8CcCcsx7LecLLimXeeQt90txyYIAqYD5Wl9G2GrPcJjylUKvjBhcQQ34QvQajoAR5SW8jzbPEER5rp4IYI9oVUfdAMhCiJHocm3ediLaxR7/0BavqPN7ShZ/D3Ls+gbD4CUnWKywVAVdjdd8dooT6iIYR1dfz+oT6Zf/HyolqntghioKTyYvjrMEUvIMMTQv4jyCbM5x3Fh5oNf+pMxgjg2DZh9HEGXBZgOX2x/8AYBpFtAZNO4zGkzKk2TTCN8Y76eavGY8zWIaVXiXSFdhYckfwfcpo7HFj+WEUSI2yOfvcVqTJHNjp54fhZZ+yN7p2ReejhAFhfoAuWNv06mrYrb0RA/D00pTj8YqdqlBVIifqPkqpxLuZuIO9Rx3IMMeGMUN7kckfT1lir4W9STCP3KG8lqPaZ4C6Wagdp0ayJPEOf9eDQH/nPYU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031abf18-5639-4035-df98-08d7f26371d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 08:48:42.3837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufqNfO5AXy9bKbMCPxPJ4+HIYyDOU4kl84qeqTDv5ZVbNnWysRmL9n4fpCXU6UWsRc6LI53ElkZeiAjJBoZ1cqzMzFjkxiLJzdHW6PYemxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5495
Received-SPF: pass client-ip=40.107.4.111;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 04:48:35
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

raw_co_block_status() in block/file-posix.c never returns 0, so
unallocated_blocks_are_zero is useless (it doesn't affect the only user
of the field: bdrv_co_block_status()). Drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/file-posix.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 05e094be29..5c01735108 100644
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
2.21.0


