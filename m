Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7686C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815D6206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 09:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vel/Kzk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815D6206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWGKt-0001vt-Mm
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 05:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJV-0007wJ-Di; Wed, 06 May 2020 05:26:01 -0400
Received: from mail-eopbgr20115.outbound.protection.outlook.com
 ([40.107.2.115]:7399 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWGJU-0006M8-KH; Wed, 06 May 2020 05:26:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kmkq3XLD5iZCUVTi/8h8HG7BF5mbR7lmtJPq137K5xvUYvBXheCabOJd2cHqaB++THVUu99F92D06HLafk2sGyZ8Jaua/7ApJQaLEOfB2Bk3rkt9H0Ag4WmZLreuehc2Vab9j/cuuwsvyUZdxEGS0R4RzLgyIZUkc3Z3qnl8mbbLNWEXFM7EfL4Z24j/Pti6Zai7vu5WCFLEMh3gw8IOI2HlF0XRmU81G6hpzlDwBHKksqMZ5w3VadJVPsNJ+r3u+M+6tRKvIBmDqZbpPbwrKcGSM85jypxKgWjeHCpC72PPb6mAWcsXubIzNNJeDahBg4qJxnZ5WN70HefF7oHSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd8IHOGIPLUQSjIyBtnjHX/hsBMDt6lUuP3Mm3kWzt4=;
 b=IEWGVcdDIesr7SlmGzdZ7N0uqXOs7W7l7nEOECDztma4FlNy/kp5MSs7tbOQZ9BMNW4cUoueRh8VofpKLDlSB2xL1HYBWQ1OzPuFhXUjP4la+ySzrUD7/RCaNmDS5nIlvytTzDchKC/DivOa+s4aGflcQ8+VGuCZnxBCkai1G3DpZwGih4O0SCIusNy/YqhTO9JTYC2+OXciskfzUPOE2fIGbEy9xXzv7lAcpuhkSEZhlgKbXqmIQAVjWbcyZu/wFgegyoxzF9JcHKnlKwFV+Zy9h8/kqS0jpGvDMDfQeMTLos8ycnrByzHk81J7El53zPCMI6CSuYr1K0w2PGgwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd8IHOGIPLUQSjIyBtnjHX/hsBMDt6lUuP3Mm3kWzt4=;
 b=vel/Kzk6YJWchVWIoT3Ku5OKrk4UsMG5brcuvmQX2GKtWBi81EgwgodVASQHpcbX1B5PhYEQPrLfo7nl10woBUb1JKw5zpuOpNQ8Ew9v8oEjXd4saDan8XybNMXAI/2rIgcsSI3zHigM81o6IL/6XtFJzUPO0H4nSAt77sffxoY=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5382.eurprd08.prod.outlook.com (2603:10a6:20b:108::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 09:25:52 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 09:25:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 5/8] block/file-posix: drop unallocated_blocks_are_zero
Date: Wed,  6 May 2020 12:25:10 +0300
Message-Id: <20200506092513.20904-6-vsementsov@virtuozzo.com>
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
 15.20.2979.26 via Frontend Transport; Wed, 6 May 2020 09:25:51 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f04c9ee-09c2-4e53-e5e7-08d7f19f786a
X-MS-TrafficTypeDiagnostic: AM7PR08MB5382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5382A50C2A519DA9DA525B81C1A40@AM7PR08MB5382.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:40;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHlc8O7JMFZsjsgWEHihyMxpAQVocmZq49pH+MCw46KejgDdFZftRZr6CK15frV/FDJTQDg/peSh8ZyTmlk/FnZoI/MnnLWE8NzWi4/rlW2y6t6C0GB9Xs7W6mcLOFrlQINj4IqDuCFe5xkNROc7TQSUjbvAn/WGDDLQac4D2m6iQQrMOlUHds1bK6B0gKabhNzt47hhFuhmVHQWv8MVfAC5hkVPR9T6uKb3yfC2mhOZRgqCNnMqVUWEYZcBfo7v6DFaqjWc8DqLyd+fBZPbZDjgghNdjqKTyUvH+ymvn4k4g09p58CMIvirALo0T5qdOOXsoxKqr6hMCYzpLg20PeAjTHxln42NrW0VFM1QbVkox8EGZI/uRzIYGEJsq97RLXT/e4MV/7b8laObyCMD9/OKEYL9dHqXTO/i1CNeq/K4Ot8iVyNCWTS1E1hJYeg0nKcjRy4cdHkOwb+SI2j4KntBfpkYlSmgUQFwN7XLRltYfHnM9khA8Rq0qHExACsqMeDk3NqBIIekX0rjjDYIZjYHiv0p5tsqDsw+yx0U3Qlm+9PcvqQ9UuWaEVvpGjsl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39840400004)(346002)(33430700001)(6486002)(6916009)(52116002)(956004)(2616005)(6666004)(8936002)(86362001)(26005)(107886003)(2906002)(6506007)(5660300002)(36756003)(478600001)(16526019)(7416002)(69590400007)(186003)(66946007)(66476007)(33440700001)(66556008)(4326008)(4744005)(316002)(1076003)(8676002)(6512007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: aYJumq/lTqh3G6Z1bw2hN7ONYkfRHXNfvNpqrxTssW5rra19ksCmLWTgsgNE5oWNaCf5JPDlxofjMzIlEcNNj17OR/AL5lARNp2+K9rdhf4oUEf2gn/QmP2CAHuEsdjcCgKSsIaEverefcqIm86qrb0UNLEnQUTEXWAA9htb70ttPUJ+Q2XA7puS/BO2WiWxCYK3+2ZNxRaO+kR2b1aCfgI6VtzrU4PAVVvOxoxsLyxa0Ene/X1VkoWW09lSD83dOIQ0LBWR2MDDZg0cNl9ps/Igk7mtB3KFGxQdEYT6QQ/LBN4Ag8CONxsQVTi3LczuSK299uN7bvqnbKQ34Xcn3z1mtAia6XAzl2IGQgbij4JmdVSR/PR7W9pI6iuyVzuhaSERDrsqS5AmdzRm76hQBbqXPNxB9vuZadURHU4tNltgLWXda1vB9cF65JVqUIsIwQNfTfVCERGS5vu1d7giCX6ZEZ00CyYAeQzZfrxYJ1DBssG9BuGrjsvxoUmUa8yV1Aa3WSebu77edVQTnlu4SX7ndYsJ4/XoqBOJ2+oCEadI7dugt0vjr6GkMZ4Qwgeg3LUnlCah2/meXBFNng0DXAcA8p9TAAVJa4WfjOrbUo/MIAh9n1cOat4XO4hGJNyzPABqTo9MdnhHANHWrc1h/MKfFhD8T6BD+1c0/E8vmUuBtYtWAZT1rbOuZxLtx9wNTJo+IoxYcEij6ZVXFhFfUJoeuvRYhIL0bE07FAimxiuVXJ7HsQREhzK4n0cgrmmf6VUYPXzdiJIwI60/1DlRWfUftqBhaB87ObfTbljxRV8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f04c9ee-09c2-4e53-e5e7-08d7f19f786a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 09:25:52.2960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXyYuuj5/kYuJ3CSulUPm6oX2QGLto8Ag4U2kDL1eZmZrCkI4FJ/VkzoL92MVzTsavAuP12O2R60X22RMe1j4pBumyDOhMAZOJ10e03GFl8=
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

raw_co_block_status() in block/file-posix.c never returns 0, so
unallocated_blocks_are_zero is useless. Drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
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


