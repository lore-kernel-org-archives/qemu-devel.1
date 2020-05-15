Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F25C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994B4206D4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 21:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JiQokFgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994B4206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhkx-00086D-Jj
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 17:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhg6-0001ke-O2; Fri, 15 May 2020 17:15:35 -0400
Received: from mail-db8eur05on2132.outbound.protection.outlook.com
 ([40.107.20.132]:46772 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jZhg2-0005cY-9G; Fri, 15 May 2020 17:15:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQbz/FzJvE0xHzHImPeko/Rk2yAfyBc3NBpGuyuhw0Pyu0bda4ldLMDKdbtTGj8THDqaUwWImtbWbYl9AVacI2ed/3LHLpwmxv7ejfQe+tombVvco2liSQhZhPEcCTTjZ4EWrO2P4jRsDqr6Ifi+zO+WF9qIS2WtSjIGA/KO958zRysqC5BFfFAFnaJqzdcdZdcgHOG6yHbJYb3DtPkizW2WrA2WzFeeL5FlMyEA0JJActuGCxwY9+rUEDPT4ZcJp57KpZX/8aPZVh0ldL2y/t3hgyCDHxoWXkHY+erT3KnsU2gJRhX8kLb8gA1x/ZE90oK3YbHQJsKfh3DqD/iEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dvUMMxDYvMi0MHeRaE/mSLPfI9Q5CIgSHluhixfpRU=;
 b=TdfOTV6Apwg91EeHiN1Cr4h1o1w2nkbxYzYwyWob6qBvHbA0aePz1zY+EI6X5SgoBZih7mSuiCByhEaWsygTOjqJ1F/Y6tdGhggdHSQMqimTptg4jXzC8Vv1iLxMBxPbknOsmFIaIo3GGbZuJtFAIErdxLMpdGVPHRMG9tq9wlo+yNqH3SJvBlIc2C1rzJvqcRU7Ezp9XG7SFT/3oBWfUysyQ+pbAFyJ+miE87nq6nL6VmM54FhFK7Fw4g4O2jaDHX3h4rpzv4Ghktsggpz96q15OCpPSCknW7xdt3SxtJx/w4W6D9BjtZ888Bp8azVkBsNexcuoI4axmPMEQQAVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dvUMMxDYvMi0MHeRaE/mSLPfI9Q5CIgSHluhixfpRU=;
 b=JiQokFgB9TkHPhtIcrqS7d7v4539bRuS1on681nZgM3FqcBvkQga1prxNTlu4QXnC+XP+W0qKtEcGS7siNw41uGov/ByQWbrkNSxcCjLlZMczTwMMOw8hsPFjMGPn11aJJ89PKjJ7F4M2IZ4Xa6PYFvgTkOS9TJXS+MKubskehw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5478.eurprd08.prod.outlook.com (2603:10a6:20b:107::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 21:15:21 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 21:15:21 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 3/9] iotests/283: make executable
Date: Sat, 16 May 2020 00:14:59 +0300
Message-Id: <20200515211505.3042-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200515211505.3042-1-vsementsov@virtuozzo.com>
References: <20200515211505.3042-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.184) by
 AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 21:15:20 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.184]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 004b997d-febe-4238-4a8c-08d7f915137f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54786C2E75E1738BC37DDC8DC1BD0@AM7PR08MB5478.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SasZSnjiNAE/TB3y9p+rVp0h+SnhLEx50XFp3QiCBCI7qCvoxr2BIkgf42c3nqNQtPQrmP8Mt93LmjEaBiED67zoxjPH5SP4YVSd91EQcCu2Sgy+F6kURK9EVCtNbHHvMzFpQyadUI/AiZQ+5tCq8HQqkqFzGtGneort7qgXCZa4yBidxckwMH0MK7VpQ0j6Cr45hASJAxJlym/Pm9VhAOIY/IPtRrZAfsa7IVc0oCJVKFMktHhsPVkxY+gKe9WENH2Mqknis13YVtoOAPw4+iQ6Uu1FOW59vF+y6dtmegbNXHA6r5e7fhx6v6d9aY5wOBIe44F2De4ItSkqIJmbUUViLT+Ydz0DGIs7Iua/BN1Ie+jDQHlOtKRRSHg+g2m+ClYg+wqyQYRItU3XMFHSV/g2pVcv3vGQuD4F8nhDA/xw67B+Wr9RPkFJxWV2vmbx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(346002)(376002)(366004)(396003)(26005)(86362001)(6486002)(4744005)(2906002)(6916009)(36756003)(8936002)(316002)(8676002)(66476007)(66946007)(1076003)(66556008)(956004)(52116002)(4326008)(186003)(16526019)(478600001)(6506007)(6666004)(6512007)(2616005)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: o+womzPUf0QB4RkaKXDxD7cBGOXTGmjUeJrHJTegmhgQt0rNwgT8fyxFgsw+ITBnPTV2wQB+uXP3ghjK6wpUFS8yrJ8V4n+2Al+s9glSfTQMmi5wZsrNKHYG1C1IYpppu5FykqR/h4wgJGJS4wjhLTZeCcqmvh27v+yDdAlOsb/CoehckknRAOe4VdavGA+OL3Rl7osVkfEIaJfJSn5rNpIZdYt29QFcpIxyg06b8TBrxb+1164aTGPhA4cZ6DZoEgcJqFOij3rG+Xa/tIai8C0SQ7eeciPdXlE92jzePQfE+UZ4KsX+xT3CQRAmIVEw8fUjJBUxqVE9PedL/seHb2kQm5pAHbBApHl1k/kXJalBvYmjr3I7xG2Myl5XBjyzEvY5jJdyC/MviAQDCw6FbaG4xZ/JG8beteDTpQF3ngE+LbFg5u0i/S25i2++FdzPxwv429bw41f8aOAqG1vtuFT6xwRsYEiebRM1wMRgNQW2qvdsiAfrfNtoPZyvvGCq
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004b997d-febe-4238-4a8c-08d7f915137f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 21:15:21.5372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9AbHTgbrOomTCaVu8UHe78BF0Nkce9+JwvKWrkFnRAy6cJ8CO2ug//0vd/hm7Om0RJVU7U6oLovPpHEvOQrGhQjUe0frm8AevyoxwOyip8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5478
Received-SPF: pass client-ip=40.107.20.132;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 17:15:28
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83=C2=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All other test files are executable, except for this one. Fix that.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
---
 tests/qemu-iotests/283 | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/qemu-iotests/283

diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
old mode 100644
new mode 100755
-- 
2.21.0


