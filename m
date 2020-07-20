Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E04C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76382080D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ButKFmzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76382080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxRgy-0000Ia-3e
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxRfF-0007Jq-2X; Mon, 20 Jul 2020 05:00:49 -0400
Received: from mail-eopbgr80094.outbound.protection.outlook.com
 ([40.107.8.94]:22905 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxRfB-00076G-Rk; Mon, 20 Jul 2020 05:00:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAY43eSB22uEz+7horJoX5QpwfBU5n8d3gr3H5dWTk2ltUSoa9O+dPuQAqtFhzi1F5RxhqiImIEzfOiwxigUmP++7qudBJKaVopTO5+t3BZ/jN+/c7Q02K+0W3KZ7uB09eLFBHkWUfJlhSwqCd6Qx0DlB5j7VeOdJIlcgjKYUDZE5dMNbgVKzxhwcuDyuSIrF+yGmfm7J7tqdsYCoZqsNIi5E4YcJFi/qjcvfKPNbX5MebkyuiTud7XYCtyZPh5jDmeDWwcL5MmFpovvgEa57J/S6hu1OB+bOhataDZxD/0leO4z6dC4GdIdGdQGLXxC401C2LCiKf3RJccZV5VuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzM5USOpcKgCozlLSOWPVxfsYocGdqGKlxZraaYKsqM=;
 b=Pflyi3RY9wtda3IfOKb9BSma/BMNYQ/itaZwuMZkQ2Htr3PJFofCr1zi/V7JDqHxZgHeD5byr2DLfR7QSWOjlXzGUpF8IRS4u9BfPQV0oSGJl+Yf8QdzchDUH/4XF6gvDQKoAIOBhdtw5RJ6aVN0EID8d/Kqi36GSq1PSZBfc7P48XulI2a4gxOAJupGzFLy71nCQfAHAAvIE9c0O7kC5LaFihomMFR3De3A7O+82Y8wpXHAjexTSUzCQ4c6q64SkBIeSp59EY/ITIGb4Rg3QmJXQSKDcRMEhIsX6eVrh5MGRb7cBsa6VQDVkB6+fAHAgkZCo2GN0LfxRZMGiE57Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzM5USOpcKgCozlLSOWPVxfsYocGdqGKlxZraaYKsqM=;
 b=ButKFmzI09v7rHnGpZQ9xMl6fGoDiZSCFQ90iAEfGHfNdouElPCkuXQmhLIUzA6SjPXCgP3QwiCFzteNXFIyj4NPmJVlbIIdXzPTjiKovQBO2CyYnszf1vd6BfNdf3aZMGj3u0oJlLZ5FVoVEJ57e6lExZL0zQRdg9YBmlq84d8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3767.eurprd08.prod.outlook.com (2603:10a6:20b:84::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 09:00:42 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:00:42 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.1? 0/3] Fix nbd reconnect dead-locks
Date: Mon, 20 Jul 2020 12:00:21 +0300
Message-Id: <20200720090024.18186-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0097.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.179) by
 AM0PR10CA0097.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 09:00:41 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.179]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cd6011d-0f94-464a-2276-08d82c8b6155
X-MS-TrafficTypeDiagnostic: AM6PR08MB3767:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB376777E42650C2BA3309A42DC17B0@AM6PR08MB3767.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alOi8hj1+VzQ3Lr9bCXrv7fs/O0beWhb4LiRnVC6UwEISAhw7De+JY8E3e/+sdUuGlXW0h7VM2cVQB9isc3SAjIep2ZTWAKBGJvS+xKN3OiUPvcMGIo1RHqwiMih5DPLbJfd6cJrmEFgTKnPuOtzZgrq9GCwOGl6lnibr9AQHPxo+TxvrKXvguVRnpJfxcdgI5dk1a1MBFN9S3yKfelDN882SIWLNB7lBIF1dlyzh7N/A7z8nSvXMECSoBeVxI6aATewIwHJf1ZY4G6H4CfvcWEgLxxKVmJV7wTgx/Xd7g2az6ZJ1l6usymexByhBNBT7pIJbaYOIsQ5rN/8QgGBT5+x2Oca//g+KJmof0+/0FODr5m1702P5rlhMCR+kVSb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39830400003)(366004)(376002)(346002)(396003)(136003)(316002)(52116002)(107886003)(83380400001)(186003)(16526019)(4326008)(956004)(2616005)(4744005)(1076003)(69590400007)(8676002)(66946007)(66476007)(66556008)(6486002)(26005)(6916009)(36756003)(478600001)(2906002)(8936002)(6666004)(6512007)(86362001)(6506007)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dnV5DvEY8jSDdw3QFS/E6KHgwFF2q88Hs715ONB79Zqvw6jEgq3VoUGa0ve0V53A6eYZDnzzCXdTz5nB4rALYsREFzmozFGIYlkZiJR/+VJhh4PXxWpOTsJcMlQsJerUr6R/3nG0YTyHmyOMKlz56Bral+cw6F3LyoA8BrtYYkZcpr1KHqHljXIlPyDoh6zEwyayyApB2O9FGgP7Z4QkT8b+sw7B76kOtjhQrHidUbIn+SriOsomXeYkPqlUq66dfUxN0WXMdPiDBoeJFwAfJUbpRJ52xZr+rA8bc2IoemvRiUHylvONXh2Mjh91UAmCDLYXOsH2YbylDxHhYydE2lVCvNbt3B+RhsoMOpWJU2NpRz3l/ozgfeXgFpckTRVodDrLV+IZUHHXy80HeGyjtf15apvyvAioPGAqYfqfM8li2WeJ6QmX5VnNWW22F4emG4y3g1U4nxwAt1ChCvJ5efEEqteWmq4heS1A4IpfG5h/376jyc1kUEH8z/slBZOS
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cd6011d-0f94-464a-2276-08d82c8b6155
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 09:00:41.9394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfZUS7HgaPRMZzy4ogAfSnD4qN644eAPy1WCV9GQoUjaGi3yqn7r1QTAMYAJrx2V8t7qNJ7EA+ZZMy2X+BIwHe1MZYDAKtMzW3WnkAPeQSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3767
Received-SPF: pass client-ip=40.107.8.94;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 05:00:42
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all!

I've found some dead-locks, which can be easily triggered on master
branch with default nbd configuration (reconnect-delay is 0),
here are fixes.

01-02 fix real dead-locks 
03 - hm. I'm not sure that the problem is reachable on master, I've
faced it in my development branch where I move initial connect into
coroutine and introduce non-blocking connect. So consider it as an
intuitive fix. It just makes code a bit better.

Vladimir Sementsov-Ogievskiy (3):
  block/nbd: allow drain during reconnect attempt
  block/nbd: on shutdown terminate connection attempt
  block/nbd: nbd_co_reconnect_loop(): don't sleep if drained

 block/nbd.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

-- 
2.21.0


