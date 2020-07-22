Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289E0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B4020771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="rtI1y8BM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B4020771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCgR-0004HP-6Z
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyCef-0002xC-Qw
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:11:21 -0400
Received: from mail-eopbgr10110.outbound.protection.outlook.com
 ([40.107.1.110]:34565 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyCed-00066M-MT
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:11:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFr1pKo/UKExSy7oKIQeguUb/02oeRZEuc98Hyidt18l8T86MRw5Uw0DdAnCOINMDjO7udvBuvsSS3f1tpKCJEnwjMREUKJnFXIwAu8zifbjxopwtQJSaDKk5grQpz9fbr2bn3w4Et2+N0SXTUweSmBvAN+vrvHhrwknOPeWLkivmYkqsptuRFQCibPL/OMOuJjplLoSemToJzThKTgxeLjf6rGSt/dVux9g2h+W+duY7xnvKZeBEa/YfG/ER2toHA0QpaaOxQ2mVxD1/zXmeN0As7/1FHggZlbC83syHVF+HqrvOPVLcH7JlJ8X07wJQqTE3ivsKl/DFTNvZhTiaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYTRkZARy4w2XnJofofO2VM9GLznQxekD7hVrHbnob4=;
 b=HonQSo/iwEp4NNsfG5+Wshgxf+dcsOEERI7F/EU+6zwnbMj5vGnq330XzCqT2Kx5YeHrPIexMK1aArtiFjj+aB6EupnVSgPT3MS9gfh1b1769HJqa3jJkRBbyekvhlis6ayB1aJDgMaHScmbgfXaVn2mqMFGhU3gxmT4sLyUNLX77MCd53pgDZHLOH8i6K0+t7w+7aZUc4MONiAJidbBh9g41472yakTLZZbR5jqtdNLaMrmukDfdjmX58IWtNYDTkW+mZCHOVOHsc4KBUSjcPxaVu+Z2cCr3/0IuHm4naKimlBhDdJx+W1JDw2k0xw2MwFq7tqKwroEzVs1MPIxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYTRkZARy4w2XnJofofO2VM9GLznQxekD7hVrHbnob4=;
 b=rtI1y8BM4kmhn/Xj7P0pSJfvcOdCqpI2XCvpA3HoFkmRVzweMca80utTI4ut4KyUnvmeSOo0qAR2c+LapyilYb2hKFWY6ObGuqV75Uju1/OavXNSQ8lU8pd5fpeYxr6inraEc/rpjT5A67MJKV7p22goTjAxb0BBdQmkbFA1AXc=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4838.eurprd03.prod.outlook.com (2603:10a6:20b:81::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Wed, 22 Jul
 2020 11:10:41 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 11:10:41 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] linux-user: Add support for a group of 2038 safe syscalls
Date: Wed, 22 Jul 2020 13:10:24 +0200
Message-Id: <20200722111024.272553-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722111024.272553-1-Filip.Bozuta@syrmia.com>
References: <20200722111024.272553-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::23) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.239) by
 GV0P278CA0036.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:28::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Wed, 22 Jul 2020 11:10:40 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.239]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5ee32c5-491d-477d-5abf-08d82e2fded7
X-MS-TrafficTypeDiagnostic: AM6PR03MB4838:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB48384C9665938FF7A11CB043EB790@AM6PR03MB4838.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HfI6w+PYA6di+vHx/DWA0XJeUbrPFfC/TQefT+u9aCJO6ZvPfIKapy672TjwR6AsobPdrwo93LNUoJkfDaY4qXzweWVcOrjqJzqjRB44Pj6BDJfBWMQGvACrM5U4x4lIXkPDHBizU2MtkkGchWLchOiFIz8qCVqZYBIZ27W/C/yXOm0deppDai8p7IbzIW6ZtRAS6qIts7W/qZfxAEw2GU0xwd3ScFyALz8bgNOJmhmx98u7gVAJnj9AuYO5cjfSjf6d4WUOdDHTzeOQlJ7TujNneIdJcXekSzFcYP4uDrAV9niRmPYuDVRvSUKvZoV3Ft9OJHvwie7Q3B+uZHK/qlTiVcpjcfzUvBaQ9v4AqYjCCnIkK9ab+jY0ZUmic9b8O+q5FlD2tXXlj5pa9n9uo4kVJ7pHSSf56ILTIKd46n8ZgkRcuyQBNkIQRTKn53W1UkiYKJUQbjzGwShPFhuxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(136003)(346002)(396003)(366004)(107886003)(956004)(2616005)(6512007)(66476007)(66556008)(66946007)(1076003)(186003)(26005)(69590400007)(16526019)(966005)(52116002)(5660300002)(6666004)(54906003)(86362001)(508600001)(6506007)(83380400001)(316002)(6916009)(36756003)(6486002)(8676002)(4326008)(8936002)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: npBt9iYaqxbc7baq74OH6ya/FpBsMsgv1ZDb83SIJS+VnBNwPBLr4IEcEQClXDgmbc56Zov3jvP0RShXxcaF4maNs78clGxHc8RsP/244j5jMEAerV2AM+W+Ho+DNTFp8IHAUCS2oKwbs6kswonlLt2pI1BkXJbjDGLgFv2SjeRBSh86U34s4BV94w8lObk0rUt8/1mEAPa5vAn4xqI8icWsvpL1U5LFgc30bmd7FXYlh9fYvmVyCbjHTPrNMw8Synax+awIFZ4ScCxf1o4Xl4VEwnhNNEfW5Kj89CazqL9ys6isg0M3A0LAv6CD/kXCpknyWAXYnY0Bauhd60yD7Da4ha1UzVAhyDJP8Vapme8Wb+GjJKCtjV7iBJnWgm5O4Yys1BFSFbr91Lof0x2WbDLXvfwXJyobZR08j76GMonOrjZ22HUgImC7pijHB6uu2Y24sT2mritUdNK/vKJSyAp3cQFdOPRTtaS833e1rDQ=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ee32c5-491d-477d-5abf-08d82e2fded7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 11:10:41.2739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SN0NTrIP3wfLO/ES2M2BOD2GgbHmEjkIEfH8VeEPl7VZHcWecAAvhZe7/7t6uNbmmONz80v34dcWkApV3xemXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4838
Received-SPF: pass client-ip=40.107.1.110;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 07:11:15
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements functionality for following time64 syscalls:

*clock_getres_time64

     This a year 2038 safe variant of syscall:

     int clock_getres(clockid_t clockid, struct timespec *res)
     --finding the resoultion of a specified clock--
     man page: https://man7.org/linux/man-pages/man2/clock_getres.2.html

*timer_gettime64
*timer_settime64

     These are year 2038 safe variants of syscalls:

     int timer_settime(timer_t timerid, int flags,
                       const struct itimerspec *new_value,
                       struct itimerspec *old_value)
     int timer_gettime(timer_t timerid, struct itimerspec *curr_value)
     --arming/dissarming and fetching state of POSIX per-process timer--
     man page: https://man7.org/linux/man-pages/man2/timer_settime.2.html

*timerfd_gettime64
*timerfd_settime64

     These are year 2038 safe variants of syscalls:

     int timerfd_settime(int fd, int flags,
                         const struct itimerspec *new_value,
                         struct itimerspec *old_value)
     int timerfd_gettime(int fd, struct itimerspec *curr_value)
     --timers that notify via file descriptor--
     man page: https://man7.org/linux/man-pages/man2/timerfd_settime.2.html

Implementation notes:

     Syscall 'clock_getres_time64' was implemented similarly to 'clock_getres()'.
     The only difference was that for the conversion of 'struct timespec' from
     host to target, function 'host_to_target_timespec64()' was used instead of
     'host_to_target_timespec()'.

     For other syscalls, new functions 'host_to_target_itimerspec64()' and
     'target_to_host_itimerspec64()' were added to convert the value of the
     'struct itimerspec' from host to target and vice versa. A new type
     'struct target__kernel_itimerspec' was added in 'syscall_defs.h'. This
     type was defined with fields which are of the already defined type
     'struct target_timespec'. This new 'struct target__kernel_itimerspec'
     type is used in these new converting functions. These new functions were
     defined similarly to 'host_to_target_itimerspec()' and 'target_to_host_itimerspec()'
     the only difference being that 'target_to_host_timespec64()' and
     'host_to_target_timespec64()' were used.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/syscall.c | 132 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 131 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 17e09c3cd3..9084a0bd3f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1254,7 +1254,9 @@ static inline abi_long target_to_host_timespec(struct timespec *host_ts,
 }
 #endif
 
-#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64)
+#if defined(TARGET_NR_clock_settime64) || defined(TARGET_NR_futex_time64) || \
+    defined(TARGET_NR_timer_settime64) || \
+    (defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD))
 static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
                                                  abi_ulong target_addr)
 {
@@ -6805,6 +6807,21 @@ static inline abi_long target_to_host_itimerspec(struct itimerspec *host_its,
 }
 #endif
 
+#if defined(TARGET_NR_timer_settime64) || \
+    (defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD))
+static inline abi_long target_to_host_itimerspec64(struct itimerspec *host_its,
+                                                   abi_ulong target_addr)
+{
+    if (target_to_host_timespec64(&host_its->it_interval, target_addr) ||
+        target_to_host_timespec64(&host_its->it_value, target_addr +
+                                  sizeof(struct target__kernel_timespec))) {
+        return -TARGET_EFAULT;
+    }
+
+    return 0;
+}
+#endif
+
 #if ((defined(TARGET_NR_timerfd_gettime) || \
       defined(TARGET_NR_timerfd_settime)) && defined(CONFIG_TIMERFD)) || \
       defined(TARGET_NR_timer_gettime) || defined(TARGET_NR_timer_settime)
@@ -6820,6 +6837,22 @@ static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
 }
 #endif
 
+#if ((defined(TARGET_NR_timerfd_gettime64) || \
+      defined(TARGET_NR_timerfd_settime64)) && defined(CONFIG_TIMERFD)) || \
+      defined(TARGET_NR_timer_gettime64) || defined(TARGET_NR_timer_settime64)
+static inline abi_long host_to_target_itimerspec64(abi_ulong target_addr,
+                                                   struct itimerspec *host_its)
+{
+    if (host_to_target_timespec64(target_addr, &host_its->it_interval) ||
+        host_to_target_timespec64(target_addr +
+                                  sizeof(struct target__kernel_timespec),
+                                  &host_its->it_value)) {
+        return -TARGET_EFAULT;
+    }
+    return 0;
+}
+#endif
+
 #if defined(TARGET_NR_adjtimex) || \
     (defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME))
 static inline abi_long target_to_host_timex(struct timex *host_tx,
@@ -11810,6 +11843,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
     }
 #endif
+#ifdef TARGET_NR_clock_getres_time64
+    case TARGET_NR_clock_getres_time64:
+    {
+        struct timespec ts;
+        ret = get_errno(clock_getres(arg1, &ts));
+        if (!is_error(ret)) {
+            host_to_target_timespec64(arg2, &ts);
+        }
+        return ret;
+    }
+#endif
 #ifdef TARGET_NR_clock_nanosleep
     case TARGET_NR_clock_nanosleep:
     {
@@ -12405,6 +12449,32 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     }
 #endif
 
+#ifdef TARGET_NR_timer_settime64
+    case TARGET_NR_timer_settime64:
+    {
+        target_timer_t timerid = get_timer_id(arg1);
+
+        if (timerid < 0) {
+            ret = timerid;
+        } else if (arg3 == 0) {
+            ret = -TARGET_EINVAL;
+        } else {
+            timer_t htimer = g_posix_timers[timerid];
+            struct itimerspec hspec_new = {{0},}, hspec_old = {{0},};
+
+            if (target_to_host_itimerspec64(&hspec_new, arg3)) {
+                return -TARGET_EFAULT;
+            }
+            ret = get_errno(
+                          timer_settime(htimer, arg2, &hspec_new, &hspec_old));
+            if (arg4 && host_to_target_itimerspec64(arg4, &hspec_old)) {
+                return -TARGET_EFAULT;
+            }
+        }
+        return ret;
+    }
+#endif
+
 #ifdef TARGET_NR_timer_gettime
     case TARGET_NR_timer_gettime:
     {
@@ -12428,6 +12498,29 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     }
 #endif
 
+#ifdef TARGET_NR_timer_gettime64
+    case TARGET_NR_timer_gettime64:
+    {
+        /* args: timer_t timerid, struct itimerspec64 *curr_value */
+        target_timer_t timerid = get_timer_id(arg1);
+
+        if (timerid < 0) {
+            ret = timerid;
+        } else if (!arg2) {
+            ret = -TARGET_EFAULT;
+        } else {
+            timer_t htimer = g_posix_timers[timerid];
+            struct itimerspec hspec;
+            ret = get_errno(timer_gettime(htimer, &hspec));
+
+            if (host_to_target_itimerspec64(arg2, &hspec)) {
+                ret = -TARGET_EFAULT;
+            }
+        }
+        return ret;
+    }
+#endif
+
 #ifdef TARGET_NR_timer_getoverrun
     case TARGET_NR_timer_getoverrun:
     {
@@ -12481,6 +12574,20 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
 #endif
 
+#if defined(TARGET_NR_timerfd_gettime64) && defined(CONFIG_TIMERFD)
+    case TARGET_NR_timerfd_gettime64:
+        {
+            struct itimerspec its_curr;
+
+            ret = get_errno(timerfd_gettime(arg1, &its_curr));
+
+            if (arg2 && host_to_target_itimerspec64(arg2, &its_curr)) {
+                return -TARGET_EFAULT;
+            }
+        }
+        return ret;
+#endif
+
 #if defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD)
     case TARGET_NR_timerfd_settime:
         {
@@ -12504,6 +12611,29 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         return ret;
 #endif
 
+#if defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD)
+    case TARGET_NR_timerfd_settime64:
+        {
+            struct itimerspec its_new, its_old, *p_new;
+
+            if (arg3) {
+                if (target_to_host_itimerspec64(&its_new, arg3)) {
+                    return -TARGET_EFAULT;
+                }
+                p_new = &its_new;
+            } else {
+                p_new = NULL;
+            }
+
+            ret = get_errno(timerfd_settime(arg1, arg2, p_new, &its_old));
+
+            if (arg4 && host_to_target_itimerspec64(arg4, &its_old)) {
+                return -TARGET_EFAULT;
+            }
+        }
+        return ret;
+#endif
+
 #if defined(TARGET_NR_ioprio_get) && defined(__NR_ioprio_get)
     case TARGET_NR_ioprio_get:
         return get_errno(ioprio_get(arg1, arg2));
-- 
2.25.1


