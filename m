Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211A0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E609821744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="0lImNCDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E609821744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1aNp-0007gd-5G
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 15:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k1aMq-0006RV-BK
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:06:56 -0400
Received: from mail-db8eur05on2134.outbound.protection.outlook.com
 ([40.107.20.134]:48609 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k1aMo-0002MN-Kx
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:06:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLsGsaxF+FnDCmaBJ/TLO0Una9Ik4krbpc7qWyAMHKb0Gh9nTwvSudwgXxFdQ3Mda9GVksaKCux3BdJFcqzJ30IiFg8Qs812AxSMkbiML5TsMVQU8N0STNyL06VYL/9lRUw5ibypwCVpWORRNM2awYlL6LeOPYA0Dcx/7bQtNgW8tOtJML+nB769hMMt06lRihyioVjG6dBlMG2VSgx14lmiWnsYgOh8ItKfzTc79b2JBaYh8UGIjYZ/9FjMCedAzd74gWX2NRWCrDpeptHLgtJFXwgDjPdL9esfzikZauiILx1n8ds3njSEjLfiDLQmL/QaNE3VCOunvDzKeYjQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ET6qhZQYu14lxAG+u3m5mluVvy/x3Eq89CCz/ibB/8=;
 b=Ewkg+2mnTjzfXKJVe7o+MMDAxdIVezEynryrw8IxNrBAh5hr9jyDHRWSiFUZUjS+EEr7dHHONeTcx2TyeYeXmPPRCuEK1pYdzrN4BH8QIGpV5g6R6Ad8FOtMrwX5P3t0nV29lpAwCGqM27vVr8lGpOdFOITYC/9y2u/vdilOcrjbvddtjFTk6ysHZWpR5RvoKeHzlfq6yKUPLX18BxJfNYAQo7GWu5qqQ3c12WjTgXgLl5y0TL24UkpH05R7K+vCNlPZk5vR2Duj5aPKztJOqQDGskGI8k9lG8YiPu54GMOXNMU32J5UPXNjBxaXN8rJCIrUv9bA3/Sg8BwxwCWOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ET6qhZQYu14lxAG+u3m5mluVvy/x3Eq89CCz/ibB/8=;
 b=0lImNCDfZriEIkxsc2Ww1Hdhh3YG46afaZanft0jT7TljnFn0KkOp2S2RkI9YCrP/3mHNTYr0NZizjUenWB2j6fi81g52iU1Qlvk/7lHcCEc+lah2ra24bP3lFNXvMMbW+f8X2WQu0hL+vT5YGzc/4TCu9vvhXm7VbtT7lbf3eU=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM7PR03MB6150.eurprd03.prod.outlook.com (2603:10a6:20b:141::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 19:06:52 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 19:06:51 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] linux-user: Introducing support for 'recvmmsg_time64()'
Date: Fri, 31 Jul 2020 21:06:34 +0200
Message-Id: <20200731190637.66698-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::12) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 19:06:51 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d014ba4-6c71-4ef5-0076-08d83584e1f6
X-MS-TrafficTypeDiagnostic: AM7PR03MB6150:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR03MB6150180924A9014E9B525F70EB4E0@AM7PR03MB6150.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/iE7ybQF44AxeoFTJfzm7DkO3/sOqKbPrbbNUkSrMZFyb7vU3ut6y+0oPrwBVcYX+7HUGtvvomkPKZfYRm/A++WP2tvBrONn0I5U6JHRLVS06WoRv45y7ieYd4MNrCNW2AJ0ugtoS73PDN7SkZK3RjZ9wBVUz+FEnAmQZfHkLholae2QMMouUu+FKBQtgutova4ueXOJsXO3RBzTQzieN3XipFi2dauxm1ZSEUOdB5qwYG5SPRpFuI/Uoppg8wFRlb0VgzxFJJoMqJEP3+5xrjmfjhtRhmeh3JIvkf9lClt7RUu6/76M0M5iludx85H12IG/ROnFa9Fr0qYKdZ2Srh8+uERXkLb/nDLsHJp9r1ftCCvg1KqbSJP7J1zO69Iqy6llcjVrYLJFI2D2XIlXmXDj+MDltKhDopuQWM9a6ZIqB01w+6zeI25gJST6LwmTdI8b0Kbybb9KFmMfZLfmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(376002)(366004)(39830400003)(396003)(136003)(6512007)(5660300002)(86362001)(8936002)(6486002)(316002)(66946007)(8676002)(66556008)(66476007)(54906003)(186003)(16526019)(26005)(956004)(2616005)(6506007)(966005)(6916009)(1076003)(107886003)(6666004)(508600001)(4326008)(2906002)(36756003)(83380400001)(69590400007)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Qv5mSryf5FTsPXJlQVq48ktK98ge+XqQ0Tncp3cqfuXcSRb9nkoBQEs7enSeIQoDsXfIFt+yyZ1nBOF/sDTRKTFaKN5h0c+f9qvRxR1Deht8LUMiZSUKZCXeDIUY+InGMPo1756y5Rp157Q3N/qnNXnokCll+5Y3s7fplqu5SJA2k+eMntslCREkrjfm1pGo++I0H83IZ/L+umNV+DPTNgBEaNV+rtG2nB6QGSmUFtUD8ewHdTiLwkEZ7hp+8+XvlArU2d9nt6zx+IGZ4OJbgIm3hHWqlkwLcqTFLNP0yg9b0vipgMzIYAu6Tw7/vJGLsivGo+jG8Ztxc5ZmBWkJ6GRpFiKJ797CPv5JH+udB76JXKbz0kkqwQeiOwW5/3EAxVXWesudpaYiOL/tkwdD0XpNUS+F7LkNj2jKPrg4ckS+ndb9ZnkQy+AfvAnRKYLJ5Pj3KrmB+AWZt1LQjjLQDHsQsZ2MJyczBHA/iBLxMW3Llo+enfaBvumtvFEo/jJPiqK8P9zPQ2DWMgMWM4ksc3iFmksNsHMxD8LZ83VqLtJJ6qHVIAtzU7WtDVvAsSs9cwGFWEpfXL6hWye9CysTmUj4XOOXJDzexZ3AYDuvvwdl2RhFmzKD6+A8kqJYosGDM+l7tLE/SCWzqnKF/m9VIg==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d014ba4-6c71-4ef5-0076-08d83584e1f6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 19:06:51.7855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iduM3bATxodFuAL3fs+MhL/Yt8Qs/Mj0CKJbv2t+i6i8xoLW2XTNdF4KW+oQfoZpLOD6PA5s3aLCajyo5qZ0ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6150
Received-SPF: pass client-ip=40.107.20.134;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 15:06:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch introduces functionality for 'recvmmsg_time64()' which
is a year 2038 safe variant of 'recvmmsg()'. This new time64 syscall
is introduced in series of three patches rather than in one patch
because a little modification was needed before the syscall could
be introduced properly.

The first patch in the series introduces a little modification
for already existing implementations for 'recvmmsg()' and
'sendmmsg()' to use the host syscall result instead of using
a loop over 'recvmsg()' and 'sendmsg()'.

The second patch in the series introduces a little fix in
the implementation of 'recvmmsg()' that introduces the timeout
argument which is of type 'struct timespec' for which the
separate time64 variant is added.

The third patch in the series introduces the implementation
of 'recvmmsg_time64()' itself.

Testing method:

    The implementation was tested using a modified LTP test suite
    where a timeout test case was added for 'recvmmsg()'. This
    modified test suite can be found at:
    https://github.com/bozutaf/ltp

    (A patch with this fix will be sent to LTP mailing list soon)

Filip Bozuta (3):
  linux-user: Modify 'sendmmsg()' and 'recvmmsg()' implementation
  linux-user: Fix 'recvmmsg()' implementation
  linux-user: Add support for 'recvmmsg_time64()'

 linux-user/syscall.c | 274 +++++++++++++++++++++++++++++--------------
 1 file changed, 184 insertions(+), 90 deletions(-)

-- 
2.25.1


