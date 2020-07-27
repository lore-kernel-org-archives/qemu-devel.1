Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A338CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6540B20729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="zh1jR/0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6540B20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09Vw-0006qw-Nh
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k09VK-0006Qb-4B
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:13:46 -0400
Received: from mail-eopbgr30095.outbound.protection.outlook.com
 ([40.107.3.95]:31319 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k09VI-0007yz-7Q
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:13:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2+KPGJzHYznfY+P8m6VIXcz5uiNYHoZvAnT45ChtApq78ypppHNDqJvxLQd8SHwLY9CRUhSsHAS+ub+fZY2OaZ+DzEYX5NUS2hJzinuTQZ+tMsMZJl4aYcddRLMN3jSgv+iZ7eX4A+UT0a9H9QmEWv1aAjJNCH5k01KuTT4A1KqKmTAU31bE0dsuA+tjBMTjoFTAcvODhIj9VJZPKZVEiDPEkB8YvzClyTcrgsM8Qf7xgA9Ud4HlinTJqKSb8F7uLWY/XPW+rT9rRnlVUbAjnJkV55hxM34OQaZjzVhK7cEcGOnc1Ah8ALkpH7YlVcmKUlrz3DkjTAlBqrr/eWtGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWIossPqprj7tkV9Ad3miOlwzJFCl/hivAYP/nu2ISg=;
 b=RONSVQWMJeIIN6VhwO/8A6kXNQBtSUIOZVgKVmMJYY6hSDpbAzvX54x2uNXBL5JUYh7lzjZpsnpre5bCpXxO/yXfahPQsli+qQ6UKNkLQH0PWnPTFBAqe2uuZAqnzvGgnD+QaoNmbn3lnA3LEILXtSnKsakzewyusQxZZgBmEeXI9v1dVb4VfLdJeCQuuK1WBZsF/fuPpjnEfOQSuWV99tTXogmHboPj4mrH9uoQfwkTkN9HZJSex6XjAt6v9v9hx03YNWNzXsDuLB8D487tgglsyHGOVM9IUiXR1jUf1s2OaJjpfNBX1E0cnn+eXk+V3NelGRYLc6AFsN4sHY3l8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWIossPqprj7tkV9Ad3miOlwzJFCl/hivAYP/nu2ISg=;
 b=zh1jR/0GH+xgdiyUF37N1BODEcNrNRUmrPceOZv5LCxFvF/5XbWnJuLb29uxgjFHkgZTWnQ6lfKYVjuBzRGoDG/9sC4gdvIIo5gf2Ji8qi34xCdvGIWQoCIII+lPU9iX7v6IcqAXuFZc2a3sH7+N6gZXtXs6mntHgSNSsNKzvjs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM7PR03MB6263.eurprd03.prod.outlook.com (2603:10a6:20b:133::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 20:13:39 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 20:13:39 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Fix 'clock_nanosleep()' implementation
Date: Mon, 27 Jul 2020 22:13:26 +0200
Message-Id: <20200727201326.401519-1-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0018.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::28) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 GV0P278CA0018.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 20:13:39 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 353496b0-5624-442d-52ec-08d832698d3e
X-MS-TrafficTypeDiagnostic: AM7PR03MB6263:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR03MB6263C0D3A9648FA9EC79ACDBEB720@AM7PR03MB6263.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rI80vZOy6mnIlByje09FfueGBM5pCN2gAYQG2W2SfZFvMmmQZa4oEo8ejl8NAiDO90sPDclvXV/uOqVWiYu0+5EAWETiec3qcSq7kZjmCHj46JWFw8IXFHbCrmnO1oNPDgLJOCa+7CzBx1OPPoHOeWH/10Agk1p60Xlb2Fd+GJARZAH/AuHj1hmQkwXGjUcj7GX9y8ZbdfgjfaXHll39TyYq65bbRfrQmOKJyGdXrJwz1Lsddo/NUj88iHe095NN49nol9qfD6ppg0bhmusblJcYf4IXmIhd0ufz4bX843ZTDtAve9dJjLie5mqqRE2huBsNMbv/LJrhHFX/eKmOVSkhczWaAPgOnqA03mXnNvU7gRadfQvx9FqikjMRBQSEbiv7QqCahETRWZ+2bb4QkYlR2zkp3spZWojc2086nrY8xaMp+PA285u0jO2lei9y78XK7rewwrNPDrJjLxI7fA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(376002)(39830400003)(396003)(366004)(136003)(8676002)(966005)(6666004)(4326008)(5660300002)(316002)(956004)(36756003)(16526019)(107886003)(2616005)(186003)(54906003)(83380400001)(52116002)(1076003)(6916009)(69590400007)(6512007)(8936002)(6486002)(6506007)(508600001)(66946007)(86362001)(26005)(66476007)(66556008)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: IKMs2yA5VhKNGTi8MTrZVV2BTqmB2DlufTLcUBWcuaoIPZh4Ogrn2m1QkB0uV8FW6nTh99kFDJ0dWgJvL5pYeWtDfx3ZHpqrlAewhWhn1sE2aJROdsFZA7b9lHd/hxmIv2MWKBwV1AWPB0c+TL1eLOVAARngS/Rtr4aXbVg2tIIXYSqnx8bB0SD1PPSjneLwAfaDPtztk898xW1BS5wpyHYwJyTjQv1YafR+cyZqT6JamaRHC8Ppr7UTCRAvFkaeCvObw+4IKhfHHk6J1DrWySdzi2pWtscCPZDpwHT7NUj8kmK2ZbNbfuyJBGU9Jm/vGDoIE7AWgZ8TAw0ivznrC3CLq4fsPB+W6Nhyd8QB+seboNDK1o+JPoecmAoeZfcld0O2CU9vgXiwziS1Ohuix2TkTEme5JTL3fC25Jj223tOK+8iNKop8EItWeFz3cvIZFUrW9+EB8bImhN5nrbxK5MdLSf/KvmurlCtrHuu4xU=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353496b0-5624-442d-52ec-08d832698d3e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 20:13:39.8110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0H/tB+q9qFnbcvw3fuQetgQS52YxBe8g94m7HEV4+mBAKyYBbiqPQUwwwQOszPA7UE5ZzI6dzAsmmbN1OGap1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6263
Received-SPF: pass client-ip=40.107.3.95; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 16:13:42
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

Implementation of syscall 'clock_nanosleep()' in 'syscall.c' uses
functions 'target_to_host_timespec()' and 'host_to_target_timespec()'
to transfer the value of 'struct timespec' between target and host.
However, the implementation doesn't check whether this conversion
succeeds and thus can return an unaproppriate error instead of 'EFAULT'
that is expected. This was confirmed with the modified LTP test suite
where testcases with bad 'struct timespec' adress for 'clock_nanosleep()'
were added. This modified LTP suite can be found at:
https://github.com/bozutaf/ltp

(Patch with this new test case will be sent to LTP mailing list soon)

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index f5c4f6b95d..9f06dde947 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11828,7 +11828,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_clock_nanosleep:
     {
         struct timespec ts;
-        target_to_host_timespec(&ts, arg3);
+        if (target_to_host_timespec(&ts, arg3)) {
+            return -TARGET_EFAULT;
+        }
         ret = get_errno(safe_clock_nanosleep(arg1, arg2,
                                              &ts, arg4 ? &ts : NULL));
         /*
@@ -11836,8 +11838,9 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
          * with error -TARGET_EINTR and if arg4 is not NULL and arg2 is not
          * TIMER_ABSTIME, it returns the remaining unslept time in arg4.
          */
-        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME) {
-            host_to_target_timespec(arg4, &ts);
+        if (ret == -TARGET_EINTR && arg4 && arg2 != TIMER_ABSTIME &&
+            host_to_target_timespec(arg4, &ts)) {
+              return -TARGET_EFAULT;
         }
 
         return ret;
-- 
2.25.1


