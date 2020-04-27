Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1A0C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659A520661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 08:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="loHVBIrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659A520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSz4t-0004sS-8k
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 04:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3W-00029e-GZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jSz3V-0007YE-Ux
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 04:23:58 -0400
Received: from mail-eopbgr70114.outbound.protection.outlook.com
 ([40.107.7.114]:29366 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jSz3U-0007Ta-8e; Mon, 27 Apr 2020 04:23:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbzSySsHYxsuFRE3YE5Mb7sJd+N5kK4/i0aMr1uBpp9LgxyO6RapponiLo1awlyBSAa02EwvXfBR3of+s9joj+hw/1u4/reKoiCXLg881ulBg6LaJQx0cUzq9gWp2Zn72WTusizLTE3ot7H3uAZ3I+pHV6rVc/nULIgR1jQrS/2FvJqLr9n1V3XWZcIpL7m+UYuBS8lnAWqa2IUl7W6QxidicxmGDugRBys0gc+itws4X+0oj5gWPCNQ5oNxhHital67DTRf0/g7kUmMt98EPLLYgImcyvfPndHkSaKpYVE1pQLm8KvzwTHE56xfrj7ojiLWz2Xz91/VwrwG/1RUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bywV2kQhRAsO6mK2zK138swjP/Qw4WGsm8vFDGVzkxY=;
 b=UX9XBn6etyh8DGpLMpBwNmHHZp7OJ7jbbOvYduMdd43joHhFgi10NkI0+PCu2MLsCN3BZwTvoM/ZJq1rXBqBoFHJAbWn18LyqPcQ3oaX5keuu5XzeGw7IM5WHX5OAG4AuZlMxwU6cZDwhLt/8F8EiUOFPDkQAicvvmVJcRf8/tXYsOKalutDb8XjsXALm19kCURjKqlof6x0sILX0rXmCez0/kRNj+gklLsWIJcQ3MhwZJcSWgRDTxgb8H9cnmUuIwNXatcSAZnZvWkvFYInqp8MQvwq96ZlsCeaBZ9cNtARk651bj2oW5JpQK6M3qxmi3tUNsp0oBbUxHqwilHE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bywV2kQhRAsO6mK2zK138swjP/Qw4WGsm8vFDGVzkxY=;
 b=loHVBIrwM+Y6PgKubbu0TisV3Aj6gB52RLzQFVU/cB3p7EJ4A4WdDC+nlyLcA6URWAtvdw6Bb6u9anKlPqPdimTCwuKms5HqqRvvFd1u6FAbqW+wZqWNVSzp/Hmo1y07H7JDBOeyGQLnyKnncYjFJ3Z5Rk9oChrxucDk3HWY6g8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5463.eurprd08.prod.outlook.com (2603:10a6:20b:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 08:23:53 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 08:23:53 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 01/17] block/throttle-groups:
 throttle_group_co_io_limits_intercept(): 64bit bytes
Date: Mon, 27 Apr 2020 11:23:09 +0300
Message-Id: <20200427082325.10414-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200427082325.10414-1-vsementsov@virtuozzo.com>
References: <20200427082325.10414-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.182) by
 FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:23:51 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f3a1ff9-95f9-4115-0005-08d7ea845201
X-MS-TrafficTypeDiagnostic: AM7PR08MB5463:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB54636642B7C36526822B8A48C1AF0@AM7PR08MB5463.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39840400004)(2906002)(81156014)(6486002)(26005)(8676002)(8936002)(4326008)(6916009)(478600001)(66556008)(7416002)(66946007)(66476007)(6666004)(16526019)(316002)(2616005)(1076003)(186003)(5660300002)(52116002)(6506007)(956004)(36756003)(107886003)(6512007)(69590400007)(86362001);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ve2K1Nyr37xp4wNd14WnJXmI/xGHRNuPagvTxFMpYQSGl0qaHwNVyEygzd2J7gLh7OOIwpxX5Sq5RLvIyrpX2p8bnbwBYGECN1wdgiODvA9cgpWFc1llpXDVTgFioHLWE9pBs1lbYGjpQyDbs87IBk00iiT5hlC3HvUKerOu+K/BNcXDY+GccypU66znnzzsPDbDaod0ZHlbYcFNaK2+mAeYhDAKDu34gw4TmkROnEWIgAdbgvJGZjCoR1IRPrFo3JXoD8n6qMUfByjSw+47+GmPrSlhLJMT28xqsFTSBxsbrg4ewGMgKKjBZCWzBTrlVyrnAttNlUvh6SJrufAcz0BQQ8TtAkXPHJe4smHEEUN8hqlV7FE9MC2KJkcBGGFMpMJ/42TVqwFsOaIEDL5/fEp99k2Yw6G1voRSt5b7NeGF600T4NYl5xtovenLQHRL1i7P834F00YTVBkfQlbgaeTF66GM4J6Sn18Nj4VATSTBYfurSzITL6ByofEqcS9
X-MS-Exchange-AntiSpam-MessageData: MsTVWoFLRG5cJe7Ry+4anGCg4+tuvY0fwi8HJpFGgbV/KYDngKsaeMeO6n3JQHcid0CWdSnYjFbpncf5ZjRFwaLOaCE+IasY5jJh7pPGy80w21m/iKBffVQbalJO1W5pE6F++xYokjEqf5cPUgRJILofZmYsplrhGF0nQDGtQ1MXElXjX1Zc5uAUcucPP5qnWubQNOHNOmx4PuA5k8FkHPfz6QbqGmNPdbt4yIX6Em1Pbg6Zl3HYpc06xv9PMEMOdNtE6lviboqbu7GIkQxBsytDbwWkJKO/PyAM5chP3B9JecNYjxdeD3E030OHfSRFklYNMbar7u7rOhbUiGO/yR2WnQX2EBYFShBDZ4yGrzZR0fnObT6t0ZKBOVo7TYzSfP30EFVvgHvKNa9kpxRJXYVy4HtcwL+B0ulisl4IcQiMCNsBxFWMokQ1suno8dK2kqmKQ5jxo4j3kRmS8ioHKTdq9HQzautkYuCDiNpIWmXi/3RJQKX+veighA6aU+Y/MHnI01byB0mQbLHDa85dfE7a3mfIrEayUHhoL8VcsWAW8AUbK2w4ZNZim5W2DPEb10qVxLyzcHWmJlrb8BiIUzWl2RZo2k11TfOO/XFQ1zvC3dPoqhmZzyWaWSK74atyBQ/PuqLcCJe9xPhRPrnLSw4niBzqn2KsPH5YevOIypa1wGbW7AyZh9ZUBbYxSUYNJCLd8PPVcdA0IyyxYu+yfb1YaSEJR3p9tIunXmsZbuRKdUza2SJX/eF38y3xu8pCjy3gMSogXIB+zfyV+vwv/xFyuGu6jJgYrAjsNj7+Uyw=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3a1ff9-95f9-4115-0005-08d7ea845201
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:23:53.0515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70+polk/Ah2YIChvNjeyOUx2sofhzPx12xHFH3Oe6qDG3bGoUIltB4vTspn6QcvG5Ej360DRAcoPbOLTCliwISZgkey5LphEe2/5t19r6VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5463
Received-SPF: pass client-ip=40.107.7.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 04:23:52
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.7.114
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
Cc: kwolf@redhat.com, fam@euphon.net, integration@gluster.org, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, dillaman@redhat.com, qemu-devel@nongnu.org,
 pl@kamp.de, ronniesahlberg@gmail.com, mreitz@redhat.com, den@openvz.org,
 sheepdog@lists.wpkg.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 namei.unix@gmail.com, pbonzini@redhat.com, sw@weilnetz.de, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The function is called from 64bit io handlers, and bytes is just passed
to throttle_account() which is 64bit too (unsigned though). So, let's
convert intermediate argument to 64bit too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/throttle-groups.h | 2 +-
 block/throttle-groups.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
index 712a8e64b4..f921994b8a 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -76,7 +76,7 @@ void throttle_group_unregister_tgm(ThrottleGroupMember *tgm);
 void throttle_group_restart_tgm(ThrottleGroupMember *tgm);
 
 void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm,
-                                                        unsigned int bytes,
+                                                        int64_t bytes,
                                                         bool is_write);
 void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
                                        AioContext *new_context);
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 37695b0cd7..37d1b7a8b8 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -358,7 +358,7 @@ static void schedule_next_request(ThrottleGroupMember *tgm, bool is_write)
  * @is_write:  the type of operation (read/write)
  */
 void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm,
-                                                        unsigned int bytes,
+                                                        int64_t bytes,
                                                         bool is_write)
 {
     bool must_wait;
-- 
2.21.0


