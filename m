Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB97C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CDD20738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 19:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="t+SduMhp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CDD20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAIJ0-0005AT-4E
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 15:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAIII-0004Li-Da
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:38:14 -0400
Received: from mail-eopbgr10113.outbound.protection.outlook.com
 ([40.107.1.113]:60643 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1kAIIG-0000YT-6i
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 15:38:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThSjU5WgaG3vhH0OWGuj2uF7H251SsHQ6k5UhnS4TQfiu8hFyKeTFLancAsCwFEYM23GN/b1wgCYmaEWBqHyGr0Yc/WDVcwXLCbhSOCA/M6i5T/JR+cLDPyq+wD/9ioBZcUC+ibxMXTQITKvnq0/9lczv5OZXEhaPjkMm3YnKGIYBNTBrsEfmIzX51DVC6eVYxFSZMFLM49gMVDarcubQQ1DD9lYKWj3z0DLo0dkWj8kppaZfaIOYJz0yXHWoq+wmM6B0TBYBg7u6k+64oaPaq6/A/wIT9exdpqvPzGdYqXQe6NryxKSXDFM/how6woRm8ExCZzUFXkuUZy2m14VzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L73sbuiC7bnu+oJjs8tKLD0o+bknCPalISJpmNd5ujw=;
 b=af+ppQ9ufixWyoo4DP0jpzNHWeRPGG67u3V/GxYnE35lwJiCeP90ABo0IT/MMSFa0TWmbRCoogYBtlPhoSYdSjLw7VSCLSL+BhZpSu6LFGAvVjVAuqber9y3SFxN8zY6Lxtww0MzNoqgkQhcK39srqBhIfU4HRFVTCWJH5Aez3YMKojyiNZnJr7rybXNZe+aiOBoUxIbIRVLMgAOgUj9CBmN3rK0e2kmI+PM4NjibMSxPV/lFQV0EJsA4h2x6tn1RFqzTrhg8wDVV/wEZCgGLck0yD0NHWj0onJL0x8/8mUWg9lFtj24Sd9Whked1y4tlOg30W/QsQJ1haB+XUDf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L73sbuiC7bnu+oJjs8tKLD0o+bknCPalISJpmNd5ujw=;
 b=t+SduMhpiCG9UsotgKHECE1XpOz1n2xGv5gEmcck+CYCOpw++sLr0fR7bZ89bQyR4c4ZN5/5jHXcKipP1h4KUSgA+eep3tRnNBJJU72VamcSZFGYFlrper+SWDXXCzrnuFQxOiMlOoEIFcHIda12Bia17pYIewCkuq6ebuoen9Y=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VE1PR03MB6047.eurprd03.prod.outlook.com (2603:10a6:803:114::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 19:38:06 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.026; Mon, 24 Aug 2020
 19:38:06 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] linux-user: Fix 'mq_timedsend()' and
 'mq_timedreceive()'
Date: Mon, 24 Aug 2020 21:37:51 +0200
Message-Id: <20200824193752.67950-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824193752.67950-1-Filip.Bozuta@syrmia.com>
References: <20200824193752.67950-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0251.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::23) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.242) by
 LO2P265CA0251.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 19:38:05 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbe02542-c594-4eeb-4304-08d84865395f
X-MS-TrafficTypeDiagnostic: VE1PR03MB6047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR03MB60476A147AE16521824AB669EB560@VE1PR03MB6047.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JOwhk+2U+D8BI5sWbzC4JjpVRRq/H69VLi+jNzBGTpzzIQZ5HWe0jq3Fb8YfhYdmz4S2RVwbnXZFej3wEwrYTthgQAK2LKz0br+ywoiqnfeoy+Rsdly7eHQh0zKJ3B1dMt5OwV9B6ZLccbkpDc/5H4vmbaOJanIUWMH82VXmoIzC0y4jSdY8OQ/fQCMgajVIaMrd4YnPfquae8cbLHjwIl79XNKsMf7npXtVIL4bwO8wBy3fsasPcGuPQvqhmA0Zss7AEkklvwW5Lvzmfo/5uy4f5+Z+wTONJcHkselWIzWj1Yt/J9SngieoxwFaxlEj6eKqAEcFVNzX5Jwn1b0ZPTSjdkS4/DDEvL+Vov+tJDN0NDY68OeqJV5yqxTHkPNecV1bv1YeOzbZGEw+dhB4uJtBYxRk4fHCwoHhFYA3fDQP4MnW/18mIvx1lL9FtL46e9NGBmsg+vuB9LwCsQ9OwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(136003)(366004)(39830400003)(376002)(396003)(16526019)(8936002)(66556008)(83380400001)(26005)(107886003)(2616005)(956004)(6916009)(86362001)(66476007)(5660300002)(1076003)(6512007)(186003)(6666004)(316002)(966005)(6506007)(66946007)(6486002)(8676002)(36756003)(69590400007)(4326008)(52116002)(2906002)(478600001)(54906003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 4a+tmOJlh8BiviDpZvET0u/q3cAwwkD9iNqhJrLJhoD7IJesxaoIIH+YUGtawqE0Yjlxj9YufAZXMvxU7X++bwS1Fm0jTE5X34SwCDRhnYscLKnJdgha/dEB4V1iyKCJQNSZ0LITA5GdkeXqTuYqAioRJJYZypZmLUcfCo7nBNMePOmdyBpMG+YiflEQ/1Qf/BM6ZpasQoGsWBdB+tsfEallqi7DwzjrpyctZZOkHDWljKHDawKPXKQQBLhG3CmYlCcD7CPjG6YId/1Km/jKmIV8WewXQGaN80nHB7SO2VjlE0Ya3MKNitUMmE4UnzpfjM7A5412c4aosLMOa5r9L67BKZ1HgAl2JOe9NIoDXo5Z+2oTNKYC6ronV3oZFJQuTNQqoiz7+4d/aCl5gGss42j+niNZ/dgLh3nighomFWvJFHi4kxyE5doubLvdtPIDQi1x0WmZV3n9gPC7AiTaaEJ9dGHOFlK2ijHAEqZfCogEZReMuilEAcprJiH/ufTpCHY8Xpp8gEbyZjaBFYiJl3RVNz2V9cccrMsB/Xye8juuRFN9gGfn4JQPPM5CZlnpxOpTKALd/rScb1TAAUykNCsyTnowVuhnB3KIgT8I6Rw8REphXjBbiYyqsCzJOG8/DU2nLozPd7x5J0L0tMP64A==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe02542-c594-4eeb-4304-08d84865395f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 19:38:06.5885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MNljHT2C6s6BHXOryG+33g6e59c4X8ibiAbr5FqGA01P54JUd6L6lD0KEMsdBeQa4xkg0Ac0Dqr1hR9esdRQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB6047
Received-SPF: pass client-ip=40.107.1.113;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 15:38:08
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implementations of syscalls 'mq_timedsend()' and 'mq_timedreceive()'
in 'syscall.c' use functions 'target_to_host_timespec()' and
'host_to_target_timespec()' to transfer the value of 'struct timespec'
between target and host. However, the implementations don't check whether
this conversion succeeds and thus can cause an unaproppriate error instead
of the 'EFAULT (Bad address)' which is supposed to be set if the conversion
from target to host fails. This was confirmed with the modified LTP
test suite where test cases with a bad adress for 'timespec' were
added. This modified test suite can be found at:
https://github.com/bozutaf/ltp

Without the changes from this patch the bad adress testcase for 'mq_timedsend()'
succeds unexpectedly, while the test returns errno 'ETIMEOUT' for
'mq_timedreceive()':

mq_timedsend01.c:190: FAIL: mq_timedsend() returned 0, expected -1: SUCCESS (0)
mq_timedreceive01.c:178: FAIL: mq_timedreceive() failed unexpectedly,
expected EFAULT: ETIMEDOUT (110)

After the changes from this patch, testcases for both syscalls fail with EFAULT
as expected, which is the same test result that is received with native execution:

mq_timedsend01.c:187: PASS: mq_timedsend() failed expectedly: EFAULT (14)
mq_timedreceive01.c:180: PASS: mq_timedreceive() failed expectedly: EFAULT (14)

(Patch with this new test case will be sent to LTP mailing list soon)

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..4ee1de6e65 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11817,9 +11817,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             p = lock_user (VERIFY_READ, arg2, arg3, 1);
             if (arg5 != 0) {
-                target_to_host_timespec(&ts, arg5);
+                if (target_to_host_timespec(&ts, arg5)) {
+                    return -TARGET_EFAULT;
+                }
                 ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, &ts));
-                host_to_target_timespec(arg5, &ts);
+                if (!is_error(ret) && host_to_target_timespec(arg5, &ts)) {
+                    return -TARGET_EFAULT;
+                }
             } else {
                 ret = get_errno(safe_mq_timedsend(arg1, p, arg3, arg4, NULL));
             }
@@ -11836,10 +11840,14 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 
             p = lock_user (VERIFY_READ, arg2, arg3, 1);
             if (arg5 != 0) {
-                target_to_host_timespec(&ts, arg5);
+                if (target_to_host_timespec(&ts, arg5)) {
+                    return -TARGET_EFAULT;
+                }
                 ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
                                                      &prio, &ts));
-                host_to_target_timespec(arg5, &ts);
+                if (!is_error(ret) && host_to_target_timespec(arg5, &ts)) {
+                    return -TARGET_EFAULT;
+                }
             } else {
                 ret = get_errno(safe_mq_timedreceive(arg1, p, arg3,
                                                      &prio, NULL));
-- 
2.25.1


