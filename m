Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCCAC388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6FC24656
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 19:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CEUq567C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6FC24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfvN-0000Gv-1b
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 15:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVfle-0000i1-0Q; Thu, 22 Oct 2020 14:56:54 -0400
Received: from mail-am6eur05on2108.outbound.protection.outlook.com
 ([40.107.22.108]:5089 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVflb-0007Y8-LM; Thu, 22 Oct 2020 14:56:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZo2ttoFkW6twu4w27AMPzVsH48ZukwjWiUc9gB3fwj3l/pCYa/REc10XVpSLW3sGbVh3J9/INLFfiY+8FFThsp7YotlZ4h60w66OnvevdREpaAsfswsy9gZ8lQFMXQQh5GS4QGYt1NkIViINK315+3YLdWu/x6ROfvKi8ZgrxesQzyxIuwFIH87Fc4UIxcL5prJYkEpHVf2HEAjGwtAlGbPLB/fzwOlK/RFbcO3fUNCAGTT4fSLtLn4JgkFxUYx1m3hjaJI7Taj4wogv6bWNWeh/DPssLZpoKexGp7ST5R/fs3kBv2Otf+HFnfIa4tCDacgrjFZYsp3ve6SUoBoMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK3huYjH3XulxxGeye8OOZ/Mu/dOhtcqE34zuKtN02w=;
 b=SJ1qSt311ZI4+VwTVc0OZZFBzou6Jil7YcDFhZEEnj+8fEzt5fDh2L6KG1k1FAoYYNTI6fC4R7qKjHpb+lVJYWuJ7kDoWZ3PoN6H0kdx55xfZZJERrLPv2QI83ywyD/q2OD4fzG9lFz+JpicSYeDLdNwiGAFHhVE4r1hk0rR4UpbClqcCoiK84sfr4MVpcWCa4WZYZ4UkMQNCVGkO8EwPiWA5bnFAR+3n6THTqinNzUU4Dm2+US8gPmVS+zRX7t/MtvUwaUqlK1j+H3/0o6BW4kKsm9LofcK5eUqrWpV5mAREofPc03NV255Dg/NKtcAaZKZbUyUJzizvlzoj1s1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK3huYjH3XulxxGeye8OOZ/Mu/dOhtcqE34zuKtN02w=;
 b=CEUq567ClyhvoXvV6kQ9hSqnt1OTHIj2JJZ3AbDJU1/ieNE2gfERXPeQ9Oys/7b4iELN1rW/3r0JKi2Ks0nDAi1ja8vlUmTLwj7y/L27PdAzOlEOJeVBwOYwQ2ivnZsEikXHjMfKYp5jH9ccFoHYJHD7BiURb1xvjH54vZlRGaw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB6309.eurprd08.prod.outlook.com (2603:10a6:20b:29f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Thu, 22 Oct
 2020 18:56:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Thu, 22 Oct 2020
 18:56:43 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, kwolf@redhat.com,
 vsementsov@virtuozzo.com, den@openvz.org, eblake@redhat.com,
 jsnow@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83=C2=A9?= <philmd@redhat.com>
Subject: [PATCH v5 04/12] iotests/283: make executable
Date: Thu, 22 Oct 2020 21:56:19 +0300
Message-Id: <20201022185627.16987-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201022185627.16987-1-vsementsov@virtuozzo.com>
References: <20201022185627.16987-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.82) by
 AM0PR01CA0089.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Thu, 22 Oct 2020 18:56:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f419afc-13d2-4584-16d4-08d876bc37ad
X-MS-TrafficTypeDiagnostic: AS8PR08MB6309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB6309442E5425AACD1F991191C11D0@AS8PR08MB6309.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rvtj5gjk3Ps86MWiCG0kyV11dOSQkC01wSI7MxV/oIlxFM6CIeQkhERhlUFXoPYy1XFyLjrcgYjM66gdVICPzuggUpSmPZyfQ2+zkzWNNK5kNttIVndkdhM6O4JG8QZ2qPwq0Yiwj8PYcDiYse+v7lXiJ/yrioOXlOsuCzQWUjLU5uFtetH+vsdq6066uxLRoiT1UL8bFU0Nj1jMiD/wFpwOYamYeDG7vG0vslBdc13/DSH8ntUuxT393OSfSW7OywuYgj9SBiSLw0nk/mK/+ZqaeYQxwYE5wCQQnSDyMTYuTMTMrfjFjec/B+FMmBoZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(366004)(346002)(396003)(136003)(376002)(478600001)(6512007)(36756003)(2906002)(52116002)(4326008)(5660300002)(4744005)(26005)(16526019)(2616005)(956004)(186003)(6916009)(6666004)(8936002)(66476007)(83380400001)(316002)(66946007)(1076003)(6506007)(8676002)(86362001)(66556008)(6486002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Mp3gYObSj18cMP0sJDk3Qf1btBtRsjYhmPSZ5+DwCmv1QAj3BJJfz9hHNAVZu3HN73Y6rlwu/2yJ7CaJslcHw50GtJq7l/UQ4cyrMlRM6ifwB4kqH78QFUtasd8lVn1ZIfYA+r0riy2EuZwYS9fzWU0LlVEKlJF4RDGO8In39SJEE8C+S5lHRWg0IMY9Y5bi178792LmBi9TPrVDwM/+KxL2f/9jf/01Et0VHLgq1C6fk8nflizkOqE8K2+sfT8WcXKcyciBIL51DlIZJ6PI7Ms/1mnCJi1yxNp6TiJs7XfU9FhwbC0gJ5HioOnAVkCG2OtYPrH/5yEYAB4+5sTR8MwNi+yLqWeN924CsA2rGy2WtWKzCZM/et+okLw4eEpnVkwa/WYgwFtsqWFHyH32c1AdnJ6vldX9jo80eZvn9o4enIUMgWVqI+GUQUieYrX73HcPckIf3qWha1hdS2WKRaXSU/DYvbM504rhXogSOAPogo/GB5FSBPyUc81oau37MxXX7oVz1RqY4RVHM3lBzQaIYQfsBX5zqeTbPLzNquAIE16Yp/2d64ojp6n3gTrWeM+O2yLUIJY7GWd7PsXCb+2N+przIhy9RGsbaSzBSEKGMXnxxG9QSooLJltalTR8vQ3anNwKl+P9E0hK43/Atw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f419afc-13d2-4584-16d4-08d876bc37ad
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 18:56:43.4279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZ6g1srYOdJYWQVtm++KgtUI+ieyDymag7gQiDJEhHK9+cE0wfnMFjYUj/GRTcvD54X9N+8QjSn1arzSRP4ZqGRjWArtWS+xTooDSiRFYXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6309
Received-SPF: pass client-ip=40.107.22.108;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:56:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.21.3


