Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353D6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12A62088E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="Myui79pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12A62088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowpp-0001De-9M
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jowJP-0005Fc-8d
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:55:07 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com
 ([40.107.7.117]:45314 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jowJM-0003Qp-KA
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:55:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMVkYMPvpAvqgvbIZ7mQ00Uec/aKbFhUXuruksJvH/CXjD3/O7UYw9WsFQw+spRNDiojW5DgG+KFscnZWkTyH6zAEFHe3D8rxrq8XZfYMNF7D1MmCwg2aPKHyEF9TKgdZtkOZfb0I20rt4xAHukqtGGOzjc5XPjiof1TDI1SpixW3/WEXibW5HnJ5No5s2AGLJbXDw0x3wRRrWRlCqXCOp/027DNx5r0Wq7D2a1zsDxPP03Ep3Mu9Rtvqmmhd1GHtDiTcrj0H7vxwvsnhrA8xvmd0Q2lKVbn/BzgxpI3Jwy5y3jWdCrR2+npY8ZLGl50loqzJrz+XaVhU97nlV5bOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeClS313fQX2xiMB+SSe1EDnN+prePPy513pqv7JGwg=;
 b=Ge7rz35Dx93DGdNQejKqun2o7XjKfo5Lxm8xfb+B3TeL11Qjily8OE9BeKl662cBBk763teLT9jWimA1oTX1KFtVuYaXdhpQ2GQFBvbuDaYPvXLBPET1spuEmNuY56TGfjcIzS214wiAEdCy69mSyOSFNt09zJkCfT7l2hynO8dm+KA1qTsOQL8/6qZDsIfy6IPnArCU0j1gBy8K/OrSxtGo7u2Mv1xt+HEtrdxR6GE3CC1AZEsTO316Oz22SKBVd3OkgveYvo6FjTaC4rvf+eo6w6nPQelxl5+VgzikT4GuKajuHPDjrpoRT6qYM8/5djzhPeYiH+mZgeS1WN+mbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeClS313fQX2xiMB+SSe1EDnN+prePPy513pqv7JGwg=;
 b=Myui79ptX6uM2INc0+Jr6GmEbE76b2BqzshOhz8gHiAbvorcbe0cGTYuQXwlxv2pHKOZdQOsyVvAwrhfBU95/ybzsBueLoBCpo8kq9lOIcTolTKrUDuDfWWlkAqjrIRlkPLKz+pC8Or/qttpxU8wehunfW8Nb3qy96O9lq4u+ms=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5234.eurprd03.prod.outlook.com (2603:10a6:20b:c3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Fri, 26 Jun
 2020 21:39:57 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3131.021; Fri, 26 Jun 2020
 21:39:57 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] Add strace support for printing arguments for a group of
 selected syscalls
Date: Fri, 26 Jun 2020 23:39:34 +0200
Message-Id: <20200626213937.20333-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0044.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::13) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.240) by
 ZR0P278CA0044.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 21:39:57 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [147.91.217.240]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d96bb8f-a0bf-4a99-a248-08d81a1978af
X-MS-TrafficTypeDiagnostic: AM6PR03MB5234:
X-Microsoft-Antispam-PRVS: <AM6PR03MB52347EA8EF5E6B5B13C83253EB930@AM6PR03MB5234.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XgkGxSQ3ywa/xAuuVtruflyCRKudM3leR7Ulgp/EZy0wNc8k4+l2J9MS+gGEYAJuo9DjCuBxNCPV6MDUTExpkKpvY7JCZaXpUi3JiO7YUaA+lV4ffc/oTi05wf09nOHa40E0hkRlsmI2uwaIAC36nHISLVsAC6b7z33hZkfJiiKOauISEN6MaPfXXCFQBWI8ly+keiYKEYzGkLQe7b746MhmN1g902aXkA2lAw3aQKPe4EdBE+VKepZNR1mXF2xpVp/byAsKj16bNI6sbjyyn53wryJOzCjA49Zr2rVVeGmCrowESuLiYkbR3re1X2TCnIf0k4wvlvuwzleJhCnOI5VS2X0zeAdZBr81Yvr8JJ68hcUFUkTA/dSuY4XKhSgn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(346002)(396003)(136003)(366004)(4326008)(6666004)(6506007)(1076003)(508600001)(83380400001)(4744005)(86362001)(6512007)(16526019)(186003)(6486002)(52116002)(316002)(6916009)(36756003)(2906002)(66476007)(66946007)(69590400007)(66556008)(8936002)(26005)(5660300002)(8676002)(2616005)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1/2FqEvWHoQI9VyJ5seZmDwNidBTOBnm+NsNO5W8Vv5/6z5NISfBKwrC+UnI7i1bwLWH0xmuRH/KReTjqs1lXibAR0k2rNoDsWfJQJlhDqSl4vS9edpwWhImAhHUG/ijHh8jUNXkJcdEXdroxP3EWF4IMY0NZjgffpgO3iBsDctIxpt6BRH14zY6lBMMCPWKPacrbEtbFlfoaiPi3wRtqp6wVdC3nvZ2Gb7xV/kB3ryyIU471ATvE6xuLFrQ3T1x8AZkDSobVEe5zcOFB4eVqSKU7Yt4UPZDzvChdUvsRgMewRxDUisEETnV8u11/GMXaD4Yb4zJIljOtT15L9gXm2NS2do/t6ujeraAtcJR1IwZqpXyl1ND0yxXfA4OQSvjyIfIDPsw9SHK0QJHQf7BWoQFY9+CwWnwz1rbEVtcZI/rPyAuwx1uzWEwGLO2G7OQjxm6rnTwr8Ye7glYtCFJfZMw7mFCmWzMnMw1txwTjm8=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d96bb8f-a0bf-4a99-a248-08d81a1978af
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 21:39:57.6294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 708NPcVM8+7Be7ZpY4UtCHdd6FXlSJhLxFnlHfJf8JnF9LrLKo2grctFCOySUfTJLyLOVgzmpihVvCsokbxYjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5234
Received-SPF: pass client-ip=40.107.7.117;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:55:02
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series covers strace support for following syscalls:

   *truncate()     *munlock()          *clock_gettimeofday()
   *ftruncate()    *munlockall()       *clock_getitimer()
   *getsid()       *clock_getres()     *clock_setitimer()
   *mlock()        *clock_gettime()
   *mlockall()     *clock_settime()


Filip Bozuta (3):
  linux-user: Add strace support for printing arguments of
    truncate()/ftruncate() and getsid()
  linux-user: Add strace support for printing arguments of syscalls used
    to lock and unlock memory
  linux-user: Add strace support for printing arguments of some clock
    and time functions

 linux-user/strace.c    | 221 ++++++++++++++++++++++++++++++++++++++++-
 linux-user/strace.list |  34 ++++---
 2 files changed, 238 insertions(+), 17 deletions(-)

-- 
2.17.1


