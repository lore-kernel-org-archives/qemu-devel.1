Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE362C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B678121744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="eQ509e+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B678121744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1aOA-0008Fe-U3
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 15:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k1aN4-0006ce-DS
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:07:10 -0400
Received: from mail-am6eur05on2132.outbound.protection.outlook.com
 ([40.107.22.132]:59583 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k1aN2-0002Mw-Eq
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:07:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzTUlgm5kx7KGCXxeb0BFfN5keInzekYiAnSde7HYa3MaXSg1CDWCrhl8lqQjZWjd8DIQPiiBfjsUkczqQ2XY37EM++3LWofNCKMnY1vYsiY7YWWSTi71uSeuGFY8Cl70OoOHil0FxNC0g06M05Rk0LbC5VfaC72TSyZLzyrZ7MaKgwmEUD3HYhX2aivO5cE8RL7hN8r+gPBhHpEUxeOheIf1GNj3dGrMd+NUdiP8Z2OU5ULVL3U9J4qswNRIO4fcwkWtDm0uVT+uueHoIg7H6HMFyUx5YYTgr+gXYpVWK+iFtw4fIGHBloSMQ8L8p33BNtqzVWZ33/UmLoGJNmCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=177K06JJ8UNK8z3ttRiYU5Je3f6CgV2TrN/7b9EUlNE=;
 b=kW9zVBCM795H1Zqi7Bfzv0TLf+/w0lShpH+zGp/Hy9JK+KRf5TXoEiLxslEcL27muJi15Tsz//QsMw4WFm3iZycuexppf9/uFb/E8zNN/LphFB/tNdYnB9IkwpESymRmTWexK2EL771eWiy48mxgkfwrIFxfwfLSwp8hvSCQSIWXDAq3F3RKDsnDiendf/ZAkd5A5RrE0E9O7Ylc5R9xOa/oGZCQc54FGLGPmSzrENRTwwJk7TTHl4iTlBybGIHq8egIPez342P0YEidDNuErDnz1R8qx/eQBUgQa+aflXahkfcU/6PZcIdKHtyvWZe8xKbJVz4cLJgjnvfc1X6Sqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=177K06JJ8UNK8z3ttRiYU5Je3f6CgV2TrN/7b9EUlNE=;
 b=eQ509e+bw2hw/BOd6JBT/H6g3wKuNcWcHCYUMI3euPD6Q3FT03gJe4gHwNk0GAvJ3YJ8RSKBlkR5kuucXukYT52RHQmySrK2QkdnvEso8JDwSIpHKKvy/tKinhDxZB3FVYTDmm3iKUrk3nLN3Tb5e1rRXBVNiuSkoFz7m+JwPA4=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM5PR03MB2884.eurprd03.prod.outlook.com (2603:10a6:206:1a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Fri, 31 Jul
 2020 19:06:54 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 19:06:54 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] linux-user: Add support for 'recvmmsg_time64()'
Date: Fri, 31 Jul 2020 21:06:37 +0200
Message-Id: <20200731190637.66698-4-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731190637.66698-1-Filip.Bozuta@syrmia.com>
References: <20200731190637.66698-1-Filip.Bozuta@syrmia.com>
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
 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 19:06:53 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fcbea771-363b-47c3-200e-08d83584e363
X-MS-TrafficTypeDiagnostic: AM5PR03MB2884:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR03MB2884A5C1E3AFC8468E9325F2EB4E0@AM5PR03MB2884.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxXksW3uBRCWPTUO4REWCNQ/x71tryo/Q3JO7tmH9Ya3qiX4zMCSTrf+6pR9n4if0luPiSnJXu2yjNjho6mXJ97JdPr0CtTOOXGoJiRrN76EE4TsaaTgw6zBSXSM5kioekgZtvbtz7uiID4W3fQ8hfafgpba3a3dJfGkaOZRDflP4yev2jxE+tnJuENQp3m8RAUbJ6fnZgOeYJti/UN//flrk180sWekUsRWTzj4ITnK4Xii/XkYCVPO9r7+CEBOcNW7A5hdvnN8LAZ7rYPERlG+XtJdjWCwVkFJllQEMGHfQbJh6cFyjOr1aQCAosYpkf8M+jPkwXpnSKaqWNGPqb7VPvjtYDfSC/ZBa22R+2h8EkMjwrtzr3UWigU5SzULmGx9d8NKzdivWR3QsVFhwzDTkrLYWnjtFcECE0/Q/HZPr+Oq8mxEB+OhvgAljtTBiVxDKHomcrN8+w2UEbpO4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(39830400003)(376002)(346002)(366004)(136003)(6506007)(26005)(66556008)(186003)(6486002)(107886003)(66946007)(69590400007)(2616005)(66476007)(54906003)(6512007)(8676002)(2906002)(36756003)(4326008)(16526019)(5660300002)(52116002)(316002)(6666004)(83380400001)(966005)(86362001)(508600001)(956004)(6916009)(8936002)(1076003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 5ESTF8lQRsTTaMrUKQCUNVC7tkEHRBvGbkgTq/TwCPytzFhS9WLaGnvMcI/2ublvG7ftXGtvXgCHAWPuecD1xWDDcb53AdLkW5J41JWGDWT2C6FzEWdLsrqviYMJQTcW3dmYqqLLxGraulW0EhTd1n0dSmWhxctgPugF5iQBPPnYUfeHfJsCbBlZZtsVHXks12H9gqpBT/XLdfmbWYpMqvRmmzBmJ2gXIhWN3WE3nKQw5cESXjHltPjjgEwy4Ar/SibjFBQI3kpiphq/OnrVvJl5toA/vnkpi51PhwF7Tt5xZzCU9oZg1qbwggyTSyOmq8WlzChh64nvDHQeHzmYb7g/FYD0sgCzCZAXq3tiuWh8cW+bZqQMQjSSofExmRbJLXbvQj+dKpoUM6hBsqHUwFKXQXgHVXD33pLzTyE0pocvi/5VlHcq27TBnlyYdlfKtMVF/iK1uGcA4a/4rraDslyu0FZFuLv5mR21VBoKGYM=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbea771-363b-47c3-200e-08d83584e363
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 19:06:54.1833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Fr3gpMjvXHsqnE6wEKw0HRUGCqugEG3XeF9IXBblErJWTUd3FGwbmSV0nrRWLxVEJoWwxWfISS9ydWmaEsIDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR03MB2884
Received-SPF: pass client-ip=40.107.22.132;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 15:06:59
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch introduces functionality for syscall:

*recvmmsg_time64

    This syscall is a 2038 safe variant for syscall:

    int recvmmsg(int sockfd, struct mmsghdr *msgvec, unsigned int vlen,
                 int flags, struct timespec *timeout)
    --receive multiple messages on a socket--
    man page: https://man7.org/linux/man-pages/man2/recvmmsg.2.html

Implementation notes:

    Function 'do_sendrecvmmsg()' in 'syscall.c' was changed with the
    addition of a new argument 'time64' which represents a flag by
    which the function knows what kind of 'struct timespec' converting
    function to call ('target_to_host_timespec() or
    'target_to_host_timespec64()'). It is 0 in case of 'TARGET_NR_recvmmsg'
    and 1 in case of 'TARGET_NR_recvmmsg_time64'.

    In 'do_socketcall()', the 'TARGET_ABI_BITS' was checked to know
    what value for 'time64' argument to pass (0 if 'TARGET_ABI_BITS == 32'
    and 1 otherwise).

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 420d7e7334..ed9c2cb7ab 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3217,7 +3217,7 @@ static abi_long do_sendrecvmsg(int fd, abi_ulong target_msg,
 
 static abi_long do_sendrecvmmsg(int fd, abi_ulong target_msgvec_addr,
                                 unsigned int vlen, unsigned int flags,
-                                abi_long timeout, int send)
+                                abi_long timeout, int time64, int send)
 {
     struct mmsghdr *host_msgvec;
     struct target_mmsghdr *target_msgvec;
@@ -3277,7 +3277,10 @@ static abi_long do_sendrecvmmsg(int fd, abi_ulong target_msgvec_addr,
             ret = get_errno(safe_sendmmsg(fd, host_msgvec, i, flags));
         } else {
             if (timeout) {
-                if (target_to_host_timespec(&ts, timeout)) {
+                if (!time64 && target_to_host_timespec(&ts, timeout)) {
+                    return -TARGET_EFAULT;
+                }
+                if (time64 && target_to_host_timespec64(&ts, timeout)) {
                     return -TARGET_EFAULT;
                 }
                 ret = get_errno(safe_recvmmsg(fd, host_msgvec, i, flags, &ts));
@@ -3619,10 +3622,14 @@ static abi_long do_socketcall(int num, abi_ulong vptr)
         return do_sendrecvmsg(a[0], a[1], a[2], 0);
     case TARGET_SYS_ACCEPT4: /* sockfd, addr, addrlen, flags */
         return do_accept4(a[0], a[1], a[2], a[3]);
-    case TARGET_SYS_RECVMMSG: /* sockfd, msgvec, vlen, timeout, flags */
-        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], a[4], 0);
+    case TARGET_SYS_RECVMMSG: /* sockfd, msgvec, vlen, flags, timeout, */
+#if TARGET_ABI_BITS == 32
+        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], a[4], 0, 0);
+#else
+        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], a[4], 1, 0);
+#endif
     case TARGET_SYS_SENDMMSG: /* sockfd, msgvec, vlen, flags */
-        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 0, 1);
+        return do_sendrecvmmsg(a[0], a[1], a[2], a[3], 0, 0, 1);
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported socketcall: %d\n", num);
         return -TARGET_EINVAL;
@@ -9426,11 +9433,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #endif
 #ifdef TARGET_NR_sendmmsg
     case TARGET_NR_sendmmsg:
-        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0, 1);
+        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0, 0, 1);
 #endif
 #ifdef TARGET_NR_recvmmsg
     case TARGET_NR_recvmmsg:
-        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, arg5, 0);
+        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, arg5, 0, 0);
+#endif
+#ifdef TARGET_NR_recvmmsg_time64
+    case TARGET_NR_recvmmsg_time64:
+        return do_sendrecvmmsg(arg1, arg2, arg3, arg4, arg5, 1, 0);
 #endif
 #ifdef TARGET_NR_sendto
     case TARGET_NR_sendto:
-- 
2.25.1


