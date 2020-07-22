Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0367AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FDF52065D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="Pjb4OHkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDF52065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyGn4-0003SC-8o
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 11:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyGlX-00025X-OG
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:34:43 -0400
Received: from mail-eopbgr140099.outbound.protection.outlook.com
 ([40.107.14.99]:54099 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jyGlV-0004dy-II
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 11:34:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wyrh/+nhsbI7xzwlhjyUitBYu9VqjgnNUpg811GFJ7dioisC+K+M9BFPRFIXKmwPqWgiPdwSRf3DXxvHcYdY/7IozBosipERfWc5w9Eq6TTnRS0L5wtw++40MY9NJCb+c/+yggyCETKlYoS5q4RSX/dpvOAfoX6SzOQnqk5sI7il19hydZr0S4yB7hdfT0pj/fnyw/P/tBiYwbPHTTxoADYKgkhdgHGNk/f2qh9eXJzEapD0m3SSUlvbGI8/fZOajAjPHTRzBX8crD0rA1SocbCBz6UEDNkNA44Jp5wj9FORxWqus37gQr7sX6mi0o+ebWfjPOd0Iqo9jZSlEEYJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5+uTTsQWw5y8Z+qZ713y6ahf3/t5kBbMWdsEbJwD9w=;
 b=SA35OQwHeiYK+RNefd0uhdAB4HNQO5FRIRUJlirpcCR90oPPkc0deWFsVDFBGy6ORIVSAYjtp5kiTaq55R1zPv4owxTlr9TPxYBfkFi22eBieLN5Ccyc1Ki0ArUGRW8DKiiUESvm3QHH0hT68wBm0bYbhPBgRnP2RbRv3f6Bdd0cAz+pwi9IyzUWynzI42oXl2WAHYyyy2YvgxmJbpyyZSEDvEBddFomIgzRnARjPNMtKoAcuW8LLQY0pdyUR79p60rFXJqodsCZu2MG+GMGa+xHiS4WMrXQGmKWa4ua3Bic1i5V9KwF6kAfajM7tlc3B4YtXRDzCo61j/pqmWk/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5+uTTsQWw5y8Z+qZ713y6ahf3/t5kBbMWdsEbJwD9w=;
 b=Pjb4OHkEtewonnORCLXA8OA24wBQZ7W1A/sNVS6pHaynDeC2g3EM9QJnZgIieGbvJCkHEQ9E4yv07RuIKT9sD2X21UMYF4667K96qeH7BIsnoAnsfcVsSXgE5rw7uuROCyniwzvyk5G5CQNfr9pablwPHHxh77og4KL2Q/1YRjE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB4744.eurprd03.prod.outlook.com (2603:10a6:20b:b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 15:34:38 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 15:34:38 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] linux-user: Add support for a group of 2038 safe
 syscalls
Date: Wed, 22 Jul 2020 17:34:21 +0200
Message-Id: <20200722153421.295411-3-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722153421.295411-1-Filip.Bozuta@syrmia.com>
References: <20200722153421.295411-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::18) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 ZR0P278CA0008.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Wed, 22 Jul 2020 15:34:38 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3361fa4-789f-4688-dbab-08d82e54beb4
X-MS-TrafficTypeDiagnostic: AM6PR03MB4744:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB47449285C357E2B00F686E93EB790@AM6PR03MB4744.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKJfXJ2ggNnorwRhi/cvgghs0OMimZ1s3KotnwrsxuTg0vJAfTya92zQIi6+e1f3vVfiKPBFS1JJLYwJB6gzJTOBnI+SIqoraWj+3pm9b1pIvrjvq8rO3NEJn6NQOOM+9gIxLeJ6yJJoQzFsJndlj8IiztBA6YCjv+B551ypI+bfdtgaxL0lKgdN7QCeZwV4g8ecE++qQ1A6IUw7YHkj4nYe2AGb+BRsVhiZN0SPh6syJ6jG/2v5B1X4pIocde2BlX8OBIqOBBzLRhEQ5g8/cw5RWua2Aa8f/ENhQEJDNzIXkOuuX4f0vq1fAOMs/nJ3qc64v8MRyTcKJSzkFSmaa44oPv+bgSeNdTcUMEZSOGXQ14XtYIL5WgTXz05WFeJgGizw6nnLDSesEKuisVxlyf92Yv2Cg7ZjKPz/3YWJzXypsj3u7CW8iLNLDSEq9BJTnonFRrt01YNQIjaf5pMoDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(346002)(376002)(39830400003)(396003)(136003)(5660300002)(52116002)(8676002)(508600001)(69590400007)(8936002)(1076003)(186003)(36756003)(26005)(966005)(54906003)(6506007)(956004)(2616005)(107886003)(316002)(86362001)(6916009)(4326008)(2906002)(66556008)(66476007)(66946007)(6486002)(6512007)(83380400001)(6666004)(16526019);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: tPaUysbZlAX/y1hj1FINe+pt9fUvD8KqVsDl3QTc3ZGnXB2dA/jkPd4kKTwuHloZHLlDAy0yKq3nCWm8JguUxBUm7pibrHOCjkKYEruhdj5n3zyFsxwd3e/9Y3437MlnKffzLJgWkkxDStz/KagDM98Pp61KozP6SYnM93+lH176ap3PKonvICHHd2DyAdBI9dya1gMegX5eVSvnlFhLRJIxWiB4fAaGiDoRyJ1i85hcCIFFSzQvw0+tutubbgqKUMYwPMXLy+Vz7Ygyj3UXtr2UK6XDoIJ2m49bTSfUU9upqiEZNRyacvQ5cYf1Vsjk02h1zWie87rsaUFFnmGsccyzym8azbSoqP8blDJxSLVQt3EzyVgqpzu/uC1Rbvt4c4Wg26PScyVQtyF/2IyISi9bIqV9plMaL9bbozqbtVYWDoRjvKK8Jh1DcemO6hJUxA2rN5Sm5ajG9Z71P0YwAutjeWl76U6VMOxJ1StgjeQ=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3361fa4-789f-4688-dbab-08d82e54beb4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 15:34:38.6298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PKG9UysnfDVvMKOuqlO+52sej4UevwdOz7vw5aTrK4kKQm2S9iX6PvZX1Q8L4xUlTh95iGaq2sFrm8LjAYv0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4744
Received-SPF: pass client-ip=40.107.14.99;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 11:34:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, RCVD_IN_SBL_CSS=3.335,
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
 linux-user/syscall.c      | 139 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |   5 ++
 2 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b1baed346c..9040e794ec 100644
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
@@ -6808,6 +6810,24 @@ static inline abi_long target_to_host_itimerspec(struct itimerspec *host_its,
 }
 #endif
 
+#if defined(TARGET_NR_timer_settime64) || \
+    (defined(TARGET_NR_timerfd_settime64) && defined(CONFIG_TIMERFD))
+static inline abi_long target_to_host_itimerspec64(struct itimerspec *host_its,
+                                                   abi_ulong target_addr)
+{
+    if (target_to_host_timespec64(&host_its->it_interval, target_addr +
+                                  offsetof(struct target__kernel_itimerspec,
+                                           it_interval)) ||
+        target_to_host_timespec64(&host_its->it_value, target_addr +
+                                  offsetof(struct target__kernel_itimerspec,
+                                           it_value))) {
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
@@ -6826,6 +6846,26 @@ static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
 }
 #endif
 
+#if ((defined(TARGET_NR_timerfd_gettime64) || \
+      defined(TARGET_NR_timerfd_settime64)) && defined(CONFIG_TIMERFD)) || \
+      defined(TARGET_NR_timer_gettime64) || defined(TARGET_NR_timer_settime64)
+static inline abi_long host_to_target_itimerspec64(abi_ulong target_addr,
+                                                   struct itimerspec *host_its)
+{
+    if (host_to_target_timespec64(target_addr +
+                                  offsetof(struct target__kernel_itimerspec,
+                                           it_interval),
+                                  &host_its->it_interval) ||
+        host_to_target_timespec64(target_addr +
+                                  offsetof(struct target__kernel_itimerspec,
+                                           it_value),
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
@@ -11816,6 +11856,17 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12411,6 +12462,32 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12434,6 +12511,29 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12487,6 +12587,20 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -12510,6 +12624,29 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 3c261cff0e..427a25f5bc 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -259,6 +259,11 @@ struct target_itimerspec {
     struct target_timespec it_value;
 };
 
+struct target__kernel_itimerspec {
+    struct target__kernel_timespec it_interval;
+    struct target__kernel_timespec it_value;
+};
+
 struct target_timex {
     abi_uint modes;              /* Mode selector */
     abi_long offset;             /* Time offset */
-- 
2.25.1


