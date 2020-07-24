Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CC9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B119F206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 18:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="ujNfL7yH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B119F206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz2Gc-0005Ak-Vq
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 14:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jz2Fr-0004iM-Rg
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:17:11 -0400
Received: from mail-eopbgr50136.outbound.protection.outlook.com
 ([40.107.5.136]:31873 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jz2Fp-00009x-Vr
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 14:17:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWsxgYyQJ6DViegg+/57+LODTtbFBC+8u+bTeYuyLJ2ZSXEFdOcEAG3PZXl1VEMqXwcfDNytWFheG2zxWQTOir0/I0R4VaFPqwI1Sn7XMPGvZM7pcIgVRQAtTGJnb4sFdhmXeqrdOkEvjDyVd0obx2WAArD5sBeWkJE0tbTYBE6GWwtWk0EzYMnWJfVyrkAi1rUQfmYfIOHb1h1U3/oZ6o3iTzZIJoo+GhXJj5a2+snpuiX8kR4wfcXZBExaAhehlIxC7q9Jv6WziUUuj8SqyhYFHa8TkTLYaYf5yyjErFV6EOj76UzzgC2M+hjh44ANpufvbNGFYZ5bACGLEaDihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdJ0bHbMz2rik7bcuWck4JjHSIolx0yn+uav9pmWm38=;
 b=E4iztSHGh94TZxSlZWcmcw9rBq0rY2nCcgO8CYVwXrbjnw/HUkKf44FBuOUyGlFbADhbhwRnRbzrxyTEzoovIkOZ+/lwT2s/kLCSjAoZa6N1FKJVCYpqAW/zmgew+XHL8LqEj1t6x2VIu73PLocBP/ZyNUgQrRx4asLXvhOHF/3uWskRLahfL1g7ATQqGONs2zqFzQPD965VY4DA/JPsERIYm6eL7zOUFa9XUj458YSydlUQ54O3ga0m7GjojoHISrNjZw/tcqfM3Ez3e9AMpJK6ylPbM4KNRNdG8uZUfSiLXxB7gxGOQNhbaOjQvgBvocpWbT6b2b7LpudffRmrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdJ0bHbMz2rik7bcuWck4JjHSIolx0yn+uav9pmWm38=;
 b=ujNfL7yH9SHjV72kInBeeLcrsqN8MpeagG+g0VtSx7FgSShmMgEOfy/f2K6O6VEW27OuJ3RdyY4EwOSeNhW/LIYOZ2yXLSgepLJDb/xKItwMJvYxdYGjkqCwsAndcKYvyAEchvS5WDtNs/vT1/63aL7HfrizaFrrvcTMr2mPmnk=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM5PR03MB2964.eurprd03.prod.outlook.com (2603:10a6:206:18::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Fri, 24 Jul
 2020 18:17:06 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Fri, 24 Jul 2020
 18:17:06 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Fix syscall rt_sigtimedwait() implementation
Date: Fri, 24 Jul 2020 20:16:51 +0200
Message-Id: <20200724181651.167819-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::20) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 GVAP278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:20::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Fri, 24 Jul 2020 18:17:05 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38e480b0-3091-4580-6250-08d82ffdc558
X-MS-TrafficTypeDiagnostic: AM5PR03MB2964:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR03MB29649BEC758C3F674161F0B3EB770@AM5PR03MB2964.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4QGkrHw6H1gA9UVm+0a72djo8IQ3HpX8TgonlnyDCe7YViPPgxIOiVmguCp/FyZEX4uCT3asGGGjuE2lcwT70p1sLFHeyxeH2RYm+jje6VIj65EW7dNG8ixQiIPnohRlLdGNxNgC3to2t22clXjkAjtR09ZQcb5p7pzDaw4/1Mr9RrCabAq0Nisv81qJGJAho0Brnb6+LNNgXkH9f1a9AqSjqNhCotP0psO+EtvCzVooUrDoZLiaMD8lqk1ALoZAzibQOby2RbnXQph0Cv//9oGvgpL0v1LMLpxH+bbJ31z/yzDoslM6obUPOBE661m3KSyXL40cv/0cRWf5hPqrbXpq+xIpiPNTp7lHFimNvfuNJOTAIgSsGwHuANr5vMEL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(396003)(136003)(346002)(376002)(366004)(4326008)(508600001)(8676002)(54906003)(16526019)(52116002)(66476007)(66556008)(6666004)(2906002)(316002)(6512007)(66946007)(36756003)(6506007)(6486002)(83380400001)(2616005)(86362001)(8936002)(6916009)(1076003)(956004)(69590400007)(5660300002)(186003)(107886003)(26005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3I3GwkQdsXM+bAsYnzl1J+5XbmfvJfKANopg98gMQvI9e+deZIwdkHikxYeVAUil7mbqh5vD2ko+EesYSCe0/Q2GsDP/IGiIC/la1Ff6PKra7vZLf0oPevPyQQqmPQVkTwXgRD81fRQ3q8kfa2LEPRkUqkFuV89nykSZ+XD4kQRfhfEjdsVfMMu6MtlJuGjU7MPrVoGuqkE3RgZy4lW4uzVmUcMyHNiQ3zLCJIIZpo98Q1x4xat1h2VxG5xqAFWvtCX4ATTtM7amvKJCz/oaGz/UATAT5Pp/kHu1nGirDgIQZ3ZeldAByWBEEgUTMekMg9GCZ1qtjH5fE7v25U7KxoWtcUgd27GOeIrEfFkhi6yoDqBCilMk06qAKKv75KAgveQChLXWmtQq8HuezYn/9j5ocDEko74vUqOkqdvF4daEjsrv+wH6eKRGKOIEDS/vJ7iD5SJ9b+RpCAlLmXkp/GoVuSfRQUhFMf4zgTOSSxE=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e480b0-3091-4580-6250-08d82ffdc558
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 18:17:05.8979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4fjf/9EUofpkJZ0ae+MKaMAMKQiaMBTkhjj+dGWuF/rTtUxL//mskdKaY1LeF5ykD3re+qadfLQut6TPdQm3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR03MB2964
Received-SPF: pass client-ip=40.107.5.136;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 14:17:07
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implementation of 'rt_sigtimedwait()' in 'syscall.c' uses the
function 'target_to_host_timespec()' to transfer the value of
'struct timespec' from target to host. However, the implementation
doesn't check whether this conversion succeeds and thus can cause
an unaproppriate error instead of the 'EFAULT (Bad address)' which
is supposed to be set if the conversion from target to host fails.

This was confirmed with the LTP test for rt_sigtimedwait:
"/testcases/kernel/syscalls/rt_sigtimedwait/rt_sigtimedwait01.c"
which causes an unapropriate error in test case "test_bad_adress3"
which is run with a bad adress for the 'struct timespec' argument:

FAIL: test_bad_address3 (349): Unexpected failure: EAGAIN/EWOULDBLOCK (11)

The test fails with an unexptected errno 'EAGAIN/EWOULDBLOCK' instead
of the expected EFAULT.

After the changes from this patch, the test case is executed successfully
along with the other LTP test cases for 'rt_sigtimedwait()':

PASS: test_bad_address3 (349): Test passed

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1211e759c2..72735682cb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8868,7 +8868,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             unlock_user(p, arg1, 0);
             if (arg3) {
                 puts = &uts;
-                target_to_host_timespec(puts, arg3);
+                if (target_to_host_timespec(puts, arg3)) {
+                    return -TARGET_EFAULT;
+                }
             } else {
                 puts = NULL;
             }
-- 
2.25.1


