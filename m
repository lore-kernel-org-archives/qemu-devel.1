Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DADC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595A32070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 18:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="k/5LIemH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595A32070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxaDK-0006g8-JP
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 14:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxaCR-0005Zi-Tt; Mon, 20 Jul 2020 14:07:39 -0400
Received: from mail-eopbgr30115.outbound.protection.outlook.com
 ([40.107.3.115]:44342 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxaCO-0001VM-T6; Mon, 20 Jul 2020 14:07:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7m/O/Tpd2R/e32poy8HU7RHn7V0lbF8x+gyRMc3qZLCVFEzyLu+wZZVuG9nO0Jc2ETs/u//cFsRj4qcazxlc9pLHawF96HaydUUGkWotIOsHpe67ei1hAdVno+zTeatxMkJZwwKihXdM+xGJuG/n8BfOhxsKBRdpYrcG9fWjslVFDCZNWIIyP8T6hTXCggV/Z7UqekzFUlR6A2CThEz/HiIdj2XUZUKeFY0OZKoFhCjjMD7zRJZCW7yIwXv+c7ztaes+JnVg/fP5eBAwQjfGBPrcJ1ruTC482f4Z2XeCEcUl5SNZVizX/AAWU57VHNCoZ3ZnYGioZx2K7XJVHuTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKy59x7S3TJmvWNqUfre3JEdHF1Yh/JeYzBXP6rsedo=;
 b=A350FttkZ+g/B/VvOau9W4SB2lXWKGcf4F8xc4YdXevqjFXfjKb5zIPDBoQoY4ntacbCSPTnpjFv1Goz9ysGY9wB75gy0ByoKS74xo4mKI8IrDymv74TXR8MuRbL0aNv6De+Ia+lYY89eJu8rDhAMgPvcwwl5SciaNqRRu9JB3NCebwZBq1ZKUl7nrpOxY7JcN7BjAN0uHQxXwOSCU4h0RlOLXFO9FoSZ79/pxKrhMfMa760lNhzVF9bXJT718ict7LbiV+E2HYU7gcXDbv5M85HnlpXXoqdRd5ezHaPRSGHi3/TsjExUW4M2h0TMcFbi59Zjc1oNTdEw/Y44AGrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKy59x7S3TJmvWNqUfre3JEdHF1Yh/JeYzBXP6rsedo=;
 b=k/5LIemH+Y+jks9au/GVx44B1l0eHZb7PFsZMtnFBCjrY7/kAqAs+IZqm2+blOUuQNe3+uoDJyu8gWMabVjdpFkTl3HqwHOya4smn86YZ0ONvtP2meaGghZ07XvL991EM0f2rmvwAkE3zZ90REKVHhfWIn7ztCA2xXbeXGu+7Xw=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4342.eurprd08.prod.outlook.com (2603:10a6:20b:b4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 18:07:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 18:07:33 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.1? 0/4] non-blocking connect
Date: Mon, 20 Jul 2020 21:07:11 +0300
Message-Id: <20200720180715.10521-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0130.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.171) by
 AM0PR06CA0130.eurprd06.prod.outlook.com (2603:10a6:208:ab::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 18:07:33 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16fbd2b0-a5a7-4378-c7f6-08d82cd7c6a5
X-MS-TrafficTypeDiagnostic: AM6PR08MB4342:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4342A07C81422BF4C9FC28F8C17B0@AM6PR08MB4342.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xvzgSEEoIglQNNmUJsNynF5hhU6lbBJ6weCFnXjD4Or25X7bBYTsEBLlTk2UoSpSerB8rjm7VP+2iF7SDdVv5O+LaPWr8hiTo6J1Z5dVhbt5CSJADftsj6arB0CE3EYTSWWUfGN/rKNbR3BhTY9I7bXwSj6AeHjSufKXTQIioQPLDNq4C5GCLPNwOEFwoXI46lQzxy4qZa/JX5oK6etbbAjDZ6bWiPvWU6VmHvbbxQqDPx76ArYsf7J7/tNKdXClfMVBmfRo7gFDeQxWD2ZCGa7yr/ekDyDXvg12Yf5I1CajkbQzyhDbqfv8EA/uqVnabjPK/xBaz8z/YchEj8mwf1dqsisEcdguXnSPnJWgXhKd4I6CKAfyJamXkezBjNub
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39840400004)(86362001)(4326008)(107886003)(316002)(16526019)(4744005)(83380400001)(6666004)(2616005)(956004)(6512007)(6916009)(6486002)(2906002)(66556008)(66476007)(66946007)(8676002)(478600001)(186003)(8936002)(52116002)(5660300002)(26005)(36756003)(6506007)(69590400007)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: XLLUlHONQ2fWb1w9FphgbNV4ETOenXY21MiXBF6m3PlQcs8gizOAZXPbl34gQInXTG6s+gyfwJjx9VGnO6LN8RWP9l11PCdijmaQbedosIvUY5F+5C6aoIeNRiZWIePn390FUIOahOc8bGLrB+OZQcAH97ukTsV9WwLkjW8FcUpMEWGgRw5htSyYK/iGnh7QtmI5T73IM+90TMcNWdO31Zk4NKJ3fmAQNLrdbeE5R6d8UyIZKrg9AxJgO60iZV5NAVys9QGNXYA7rOyh/vV2ajqx46BjsG4eChmx63GiovDtHdlyFTRYhdCfgq7JOXSonh5MBRW7zN6fQUI97+U89oXIPj4X2nS2kzSL1g6CT0OnnW9Pcko5XA5axy//5dE+W+UyfGP+xvt1+97xhlqQTMnavhB0y15LxoDdYg98kvrLN2NjBUtzCQ8ZGRIoCPE/wMH5is/A59xB8kosR+05+at9w3lYJLFnR3bobQ5Lb1azTmEAHSAS6pQgZL+ATwUV
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fbd2b0-a5a7-4378-c7f6-08d82cd7c6a5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 18:07:33.6971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kF+dv4ktCZ1SgnZW8u4P7fgFD2Q87JlJRXJVH+dMpflRTw/DqG+st5ngApx98jWacP7XhKDTP1j/0VTTWUvQ7jTjaHHF2YqveAsxcPo4fbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4342
Received-SPF: pass client-ip=40.107.3.115;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 14:07:34
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berrange@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, kraxel@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi! This fixes real problem (see 04). On the other hand it may be too
much for 5.1, and it's not a degradation. So, up to you.

It's based on "[PATCH for-5.1? 0/3] Fix nbd reconnect dead-locks", or
in other words
Based-on: <20200720090024.18186-1-vsementsov@virtuozzo.com>

Vladimir Sementsov-Ogievskiy (4):
  qemu-sockets: refactor inet_connect_addr
  qemu-sockets: implement non-blocking connect interface
  io/channel-socket: implement non-blocking connect
  block/nbd: use non-blocking connect: fix vm hang on connect()

 include/io/channel-socket.h | 14 +++++++
 include/qemu/sockets.h      |  6 +++
 block/nbd.c                 | 11 +++---
 io/channel-socket.c         | 74 ++++++++++++++++++++++++++++++++++++
 util/qemu-sockets.c         | 76 ++++++++++++++++++++++++++-----------
 5 files changed, 153 insertions(+), 28 deletions(-)

-- 
2.21.0


