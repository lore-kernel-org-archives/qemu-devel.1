Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE07FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A742076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="lVwwZujl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A742076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5XT2-0007sE-Sg
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5XPr-0003vH-Au
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:46:24 -0400
Received: from mail-eopbgr50105.outbound.protection.outlook.com
 ([40.107.5.105]:15741 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1k5XPp-0002xQ-14
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:46:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaOqt1tD9uHg8AibmfM2yKZa4wkECrvgr2TaX8W0IKp3YbllcOjjZRXh6b1lTzUzxzwQXnRKgp7w7I+I0NXnVKHq3+VcyVvTWThNce9JfoFS2EDIq8vuJrDsUwMbo6gAX/Xgg1ZwaAbaw+ngdlGlwN8GlAqfsgSXDW9/UCrTOplztGnvxzzFsKgevVh3thbd9ULyk2cjjHpHmhXQmVdnbgnvI/DTfHwZQcor45UFCgPJEpD84GDA1pvvxhnmzvVUYOehoVOLCo2NeFOnR+ziivnLfIQviJPVO0xORZTEjfCh29ISD4nDPug/cTQjjsgsuSvbWnQLQjoCuTbGCfCkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjRC3S9Kmlf4JTMv2f9aEWiXVlcZppDcI/jFL8vqtJ4=;
 b=k8jdZxRT1+HGbNZBXcerMwVnTJvshmLP9oIKfP40FmU+7hyKutetiCHZuukj+BLZOAzWe1lIXFRoJohslu4kifMzZ23RKa/CCDkrIWr20h+xl4mim5GdPw8eBeiRqbkiyLFzScttAz5XayfhPUxd7w4mDaZ6Xyze3Lf0P5CJONs0nC/ZWF0O2M1so9v7bTbrmbMJnqZC8+i3tiPEdRZ9MSU8sZ1u+E6E2flXzFbVqjMjz1FGiXBYHBEKqEcmlZK8/VTSZdumd+iVZva/sl/4ep9CRbaPJTItLYXRy69D+5bmafXs8KTpWXjwc8IfopRJabR60hx6h8yYgzv4EwoHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjRC3S9Kmlf4JTMv2f9aEWiXVlcZppDcI/jFL8vqtJ4=;
 b=lVwwZujlH0wdmcsURghz5lhKxcQZMz7II8zXiPzUYB4fTjgSrak4UjZbJHv4HiFYKYneDxkq80AmcCQtUNT9IWS2cLdmLuC2O5sTVoEjpGa2HCt2Q5stnDmc/xT20mkG/7HYxL/jkpXRwm3nomZsD/CR66GJGAkUDMVwr3OhIxI=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com (2603:10a6:802:a1::22)
 by VI1PR03MB3662.eurprd03.prod.outlook.com (2603:10a6:803:3a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 16:46:11 +0000
Received: from VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362]) by VE1PR03MB5246.eurprd03.prod.outlook.com
 ([fe80::3568:5b4f:ab6b:e362%6]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 16:46:11 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/5] linux-user: Add strace support for printing arguments
 of some clock and time functions
Date: Tue, 11 Aug 2020 18:45:53 +0200
Message-Id: <20200811164553.27713-6-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811164553.27713-1-Filip.Bozuta@syrmia.com>
References: <20200811164553.27713-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::13) To VE1PR03MB5246.eurprd03.prod.outlook.com
 (2603:10a6:802:a1::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.235) by
 LO3P123CA0008.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ba::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Tue, 11 Aug 2020 16:46:10 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.235]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3301244b-9be1-4d61-92d7-08d83e160da2
X-MS-TrafficTypeDiagnostic: VI1PR03MB3662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR03MB36625D1BC2026A2AC38A8E10EB450@VI1PR03MB3662.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1i2izDchf7VtdWJ8eFZHi0lkvTNoz3vgeNMKLwPZJ9qdDreWbMWcSMk0g0qFTAhv9ZfxrsfpIGeVPopNZAoV7L/EJZzl1dsdqgKg8H0CTs9ZJ15+FvB56/j0sm5j2d6cRSEav7OJfR34DhMvnmGvGZq9TqDIYq3vNA9nqVTUc5OHKr/fOCVfsyHTUjlabuBZizun+wCW/M3vgF02T+kPhURDilrGOWupGzrj1hOqQRQQQNnoEAh2a8oxfn5XmKhDa+L0vMa77Tg9XN8SVWvJWeNK3ReSMuQVJvXDHi4MdbYR08zR3d3B/CPlWHgL/qyfFNRkjrlJzwCgj+NC9eftCe5PKTpnry4f119i8kKmK64GR+wZz2q4s6UW7N16uljnWeV/A8lAbLO2a9uSXM+qHriC+hds8H5AZLs/7o41GNj+2lNDCK1xvFYMz5/bM2PJw3gECG+VxAlJmF0AF3nfckWnTgWvapqqkNiBOWJGGWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR03MB5246.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(376002)(396003)(366004)(39830400003)(136003)(956004)(2906002)(508600001)(6512007)(186003)(52116002)(16526019)(66556008)(66946007)(26005)(83380400001)(6666004)(1076003)(30864003)(66476007)(6506007)(86362001)(54906003)(8936002)(4326008)(107886003)(966005)(36756003)(316002)(6916009)(5660300002)(8676002)(6486002)(69590400007)(2616005)(21314003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WlEVifvdEmrI3Ae04wqBGnRPBrxuIxGh+kwy1qLJaOrgANpiQgOtG/dHVD9slAmZprEZTI7mJfATi2soMWlmkaGe7HSgCJspy0jOrZHHgiOdUgd8CnIuhjlB0okXW9P4FfFr2Nv7RgNkvOBsWS2DGy9yhda11sz/m2bAV2y9HitAnZo5lZjCd7IaCq2KJDXKgNeoIghGRV5bXxGJCnoMOLBWzW7Edff+KLEL0hxP1ThvB+zMzJPwxSBG82w7BTxkBsrx5xXU41ByBCZ2QxzFlcNRF1cCCR3MYqq9WDhv9nPEYPgEhXt8K8VYwo9U/vU4E0K7opt+M9xRtJqS6zF6Mx7c9S53iTuOsZdd9Dk4Wq7+SMXUsmi8QBSEsCtwurInTuQ0pfB9b2mPYOS4imB8xPqyoPUrhF6OXHn3JtcHYGon9OTo3kJsAboYIeF6eoTOK6kLg9ny5NK4aM/b9L0RQ5gP0loBem56K8DNnNwlHdHNFwYN8QGrrDKx6YczClKngjXt5diHxzoqJe7tc+qXPGmGCyCbAuOqeJxjIKKFGTpvK54eyJ1qJxoAjF94S/Pu4dIPCe3gwkyU3L3uPbwuAJApHRmBXvpnpiZgwpTIQtIKVjSXFBwyen+jqwtA44Y67j6jS/O9nxznGyHA2CUBpA==
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3301244b-9be1-4d61-92d7-08d83e160da2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR03MB5246.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 16:46:11.4874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZwq7bVe0vzwr1VNJZOyD/WyldrZ0Ia7igjgAJnj43AABVy5VpEPno93x/ENobcAYakz1ONl9lqW9FEgXE5N/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3662
Received-SPF: pass client-ip=40.107.5.105;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 12:46:08
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements strace argument printing functionality for following syscalls:

    * clock_getres, clock_gettime, clock_settime - clock and time functions

        int clock_getres(clockid_t clockid, struct timespec *res)
        int clock_gettime(clockid_t clockid, struct timespec *tp)
        int clock_settime(clockid_t clockid, const struct timespec *tp)
        man page: https://man7.org/linux/man-pages/man2/clock_getres.2.html

    * gettimeofday - get time

        int gettimeofday(struct timeval *tv, struct timezone *tz)
        man page: https://man7.org/linux/man-pages/man2/gettimeofday.2.html

    * getitimer, setitimer - get or set value of an interval timer

        int getitimer(int which, struct itimerval *curr_value)
        int setitimer(int which, const struct itimerval *new_value,
                      struct itimerval *old_value)
        man page: https://man7.org/linux/man-pages/man2/getitimer.2.html

Implementation notes:

    All of the syscalls have some structue types as argument types and thus
    a separate printing function was stated in file "strace.list" for each
    of them. All of these functions use existing functions for their
    appropriate structure types ("print_timeval()" and "print_timezone()").

    Functions "print_timespec()" and "print_itimerval()" were added in this
    patch so that they can be used to print types "struct timespec" and
    "struct itimerval" used by some of the syscalls. Function "print_itimerval()"
    uses the existing function "print_timeval()" to print fields of the
    structure "struct itimerval" that are of type "struct timeval".

    Function "print_enums()", which was introduced in the previous patch, is used
    to print the interval timer type which is the first argument of "getitimer()"
    and "setitimer()". Also, this function is used to print the clock id which
    is the first argument of "clock_getres()" and "clock_gettime()". For that
    reason, the existing function "print_clockid()" was removed in this patch.
    Existing function "print_clock_adjtime()" was also changed for this reason
    to use "print_enums()".

    The existing function "print_timeval()" was changed a little so that it
    prints the field names beside the values.

    Syscalls "clock_getres()" and "clock_gettime()" have the same number
    and types of arguments and thus their print functions "print_clock_getres"
    and "print_clock_gettime" share a common definition in file "strace.c".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/strace.c    | 287 +++++++++++++++++++++++++++++++----------
 linux-user/strace.list |  17 ++-
 2 files changed, 232 insertions(+), 72 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index def92c4d73..1a5c4c820a 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -78,7 +78,9 @@ UNUSED static void print_string(abi_long, int);
 UNUSED static void print_buf(abi_long addr, abi_long len, int last);
 UNUSED static void print_raw_param(const char *, abi_long, int);
 UNUSED static void print_timeval(abi_ulong, int);
+UNUSED static void print_timespec(abi_ulong, int);
 UNUSED static void print_timezone(abi_ulong, int);
+UNUSED static void print_itimerval(abi_ulong, int);
 UNUSED static void print_number(abi_long, int);
 UNUSED static void print_signal(abi_ulong, int);
 UNUSED static void print_sockaddr(abi_ulong, abi_long, int);
@@ -578,69 +580,6 @@ print_fdset(int n, abi_ulong target_fds_addr)
 }
 #endif
 
-#ifdef TARGET_NR_clock_adjtime
-/* IDs of the various system clocks */
-#define TARGET_CLOCK_REALTIME              0
-#define TARGET_CLOCK_MONOTONIC             1
-#define TARGET_CLOCK_PROCESS_CPUTIME_ID    2
-#define TARGET_CLOCK_THREAD_CPUTIME_ID     3
-#define TARGET_CLOCK_MONOTONIC_RAW         4
-#define TARGET_CLOCK_REALTIME_COARSE       5
-#define TARGET_CLOCK_MONOTONIC_COARSE      6
-#define TARGET_CLOCK_BOOTTIME              7
-#define TARGET_CLOCK_REALTIME_ALARM        8
-#define TARGET_CLOCK_BOOTTIME_ALARM        9
-#define TARGET_CLOCK_SGI_CYCLE             10
-#define TARGET_CLOCK_TAI                   11
-
-static void
-print_clockid(int clockid, int last)
-{
-    switch (clockid) {
-    case TARGET_CLOCK_REALTIME:
-        qemu_log("CLOCK_REALTIME");
-        break;
-    case TARGET_CLOCK_MONOTONIC:
-        qemu_log("CLOCK_MONOTONIC");
-        break;
-    case TARGET_CLOCK_PROCESS_CPUTIME_ID:
-        qemu_log("CLOCK_PROCESS_CPUTIME_ID");
-        break;
-    case TARGET_CLOCK_THREAD_CPUTIME_ID:
-        qemu_log("CLOCK_THREAD_CPUTIME_ID");
-        break;
-    case TARGET_CLOCK_MONOTONIC_RAW:
-        qemu_log("CLOCK_MONOTONIC_RAW");
-        break;
-    case TARGET_CLOCK_REALTIME_COARSE:
-        qemu_log("CLOCK_REALTIME_COARSE");
-        break;
-    case TARGET_CLOCK_MONOTONIC_COARSE:
-        qemu_log("CLOCK_MONOTONIC_COARSE");
-        break;
-    case TARGET_CLOCK_BOOTTIME:
-        qemu_log("CLOCK_BOOTTIME");
-        break;
-    case TARGET_CLOCK_REALTIME_ALARM:
-        qemu_log("CLOCK_REALTIME_ALARM");
-        break;
-    case TARGET_CLOCK_BOOTTIME_ALARM:
-        qemu_log("CLOCK_BOOTTIME_ALARM");
-        break;
-    case TARGET_CLOCK_SGI_CYCLE:
-        qemu_log("CLOCK_SGI_CYCLE");
-        break;
-    case TARGET_CLOCK_TAI:
-        qemu_log("CLOCK_TAI");
-        break;
-    default:
-        qemu_log("%d", clockid);
-        break;
-    }
-    qemu_log("%s", get_comma(last));
-}
-#endif
-
 /*
  * Sysycall specific output functions
  */
@@ -839,6 +778,81 @@ print_syscall_ret_adjtimex(void *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_clock_gettime) || defined(TARGET_NR_clock_getres)
+static void
+print_syscall_ret_clock_gettime(void *cpu_env, const struct syscallname *name,
+                                abi_long ret, abi_long arg0, abi_long arg1,
+                                abi_long arg2, abi_long arg3, abi_long arg4,
+                                abi_long arg5)
+{
+    if (!print_syscall_err(ret)) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+        qemu_log(" (");
+        print_timespec(arg1, 1);
+        qemu_log(")");
+    }
+
+    qemu_log("\n");
+}
+#define print_syscall_ret_clock_getres     print_syscall_ret_clock_gettime
+#endif
+
+#ifdef TARGET_NR_gettimeofday
+static void
+print_syscall_ret_gettimeofday(void *cpu_env, const struct syscallname *name,
+                               abi_long ret, abi_long arg0, abi_long arg1,
+                               abi_long arg2, abi_long arg3, abi_long arg4,
+                               abi_long arg5)
+{
+    if (!print_syscall_err(ret)) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+        qemu_log(" (");
+        print_timeval(arg0, 0);
+        print_timezone(arg1, 1);
+        qemu_log(")");
+    }
+
+    qemu_log("\n");
+}
+#endif
+
+#ifdef TARGET_NR_getitimer
+static void
+print_syscall_ret_getitimer(void *cpu_env, const struct syscallname *name,
+                            abi_long ret, abi_long arg0, abi_long arg1,
+                            abi_long arg2, abi_long arg3, abi_long arg4,
+                            abi_long arg5)
+{
+    if (!print_syscall_err(ret)) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+        qemu_log(" (");
+        print_itimerval(arg1, 1);
+        qemu_log(")");
+    }
+
+    qemu_log("\n");
+}
+#endif
+
+
+#ifdef TARGET_NR_getitimer
+static void
+print_syscall_ret_setitimer(void *cpu_env, const struct syscallname *name,
+                            abi_long ret, abi_long arg0, abi_long arg1,
+                            abi_long arg2, abi_long arg3, abi_long arg4,
+                            abi_long arg5)
+{
+    if (!print_syscall_err(ret)) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+        qemu_log(" (old_value = ");
+        print_itimerval(arg2, 1);
+        qemu_log(")");
+    }
+
+    qemu_log("\n");
+}
+#endif
+
 #if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr) \
  || defined(TARGGET_NR_flistxattr)
 static void
@@ -1217,6 +1231,43 @@ UNUSED static struct flags mlockall_flags[] = {
     FLAG_END,
 };
 
+/* IDs of the various system clocks */
+#define TARGET_CLOCK_REALTIME              0
+#define TARGET_CLOCK_MONOTONIC             1
+#define TARGET_CLOCK_PROCESS_CPUTIME_ID    2
+#define TARGET_CLOCK_THREAD_CPUTIME_ID     3
+#define TARGET_CLOCK_MONOTONIC_RAW         4
+#define TARGET_CLOCK_REALTIME_COARSE       5
+#define TARGET_CLOCK_MONOTONIC_COARSE      6
+#define TARGET_CLOCK_BOOTTIME              7
+#define TARGET_CLOCK_REALTIME_ALARM        8
+#define TARGET_CLOCK_BOOTTIME_ALARM        9
+#define TARGET_CLOCK_SGI_CYCLE             10
+#define TARGET_CLOCK_TAI                   11
+
+UNUSED static struct enums clockids[] = {
+    ENUM_TARGET(CLOCK_REALTIME),
+    ENUM_TARGET(CLOCK_MONOTONIC),
+    ENUM_TARGET(CLOCK_PROCESS_CPUTIME_ID),
+    ENUM_TARGET(CLOCK_THREAD_CPUTIME_ID),
+    ENUM_TARGET(CLOCK_MONOTONIC_RAW),
+    ENUM_TARGET(CLOCK_REALTIME_COARSE),
+    ENUM_TARGET(CLOCK_MONOTONIC_COARSE),
+    ENUM_TARGET(CLOCK_BOOTTIME),
+    ENUM_TARGET(CLOCK_REALTIME_ALARM),
+    ENUM_TARGET(CLOCK_BOOTTIME_ALARM),
+    ENUM_TARGET(CLOCK_SGI_CYCLE),
+    ENUM_TARGET(CLOCK_TAI),
+    ENUM_END,
+};
+
+UNUSED static struct enums itimer_types[] = {
+    ENUM_GENERIC(ITIMER_REAL),
+    ENUM_GENERIC(ITIMER_VIRTUAL),
+    ENUM_GENERIC(ITIMER_PROF),
+    ENUM_END,
+};
+
 /*
  * print_xxx utility functions.  These are used to print syscall
  * parameters in certain format.  All of these have parameter
@@ -1435,13 +1486,34 @@ print_timeval(abi_ulong tv_addr, int last)
             print_pointer(tv_addr, last);
             return;
         }
-        qemu_log("{" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "}%s",
-            tswapal(tv->tv_sec), tswapal(tv->tv_usec), get_comma(last));
+        qemu_log("{tv_sec = " TARGET_ABI_FMT_ld
+                 ",tv_usec = " TARGET_ABI_FMT_ld "}%s",
+                 tswapal(tv->tv_sec), tswapal(tv->tv_usec), get_comma(last));
         unlock_user(tv, tv_addr, 0);
     } else
         qemu_log("NULL%s", get_comma(last));
 }
 
+static void
+print_timespec(abi_ulong ts_addr, int last)
+{
+    if (ts_addr) {
+        struct target_timespec *ts;
+
+        ts = lock_user(VERIFY_READ, ts_addr, sizeof(*ts), 1);
+        if (!ts) {
+            print_pointer(ts_addr, last);
+            return;
+        }
+        qemu_log("{tv_sec = " TARGET_ABI_FMT_ld
+                 ",tv_nsec = " TARGET_ABI_FMT_ld "}%s",
+                 tswapal(ts->tv_sec), tswapal(ts->tv_nsec), get_comma(last));
+        unlock_user(ts, ts_addr, 0);
+    } else {
+        qemu_log("NULL%s", get_comma(last));
+    }
+}
+
 static void
 print_timezone(abi_ulong tz_addr, int last)
 {
@@ -1461,6 +1533,22 @@ print_timezone(abi_ulong tz_addr, int last)
     }
 }
 
+static void
+print_itimerval(abi_ulong it_addr, int last)
+{
+    if (it_addr) {
+        qemu_log("{it_interval=");
+        print_timeval(it_addr +
+                      offsetof(struct target_itimerval, it_interval), 0);
+        qemu_log("it_value=");
+        print_timeval(it_addr +
+                      offsetof(struct target_itimerval, it_value), 0);
+        qemu_log("}%s", get_comma(last));
+    } else {
+        qemu_log("NULL%s", get_comma(last));
+    }
+}
+
 #undef UNUSED
 
 #ifdef TARGET_NR_accept
@@ -1573,7 +1661,7 @@ print_clock_adjtime(void *cpu_env, const struct syscallname *name,
                     abi_long arg3, abi_long arg4, abi_long arg5)
 {
     print_syscall_prologue(name);
-    print_clockid(arg0, 0);
+    print_enums(clockids, arg0, 0);
     print_pointer(arg1, 1);
     print_syscall_epilogue(name);
 }
@@ -1903,6 +1991,19 @@ print_futimesat(void *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_gettimeofday
+static void
+print_gettimeofday(void *cpu_env, const struct syscallname *name,
+                   abi_long arg0, abi_long arg1, abi_long arg2,
+                   abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_pointer(arg0, 0);
+    print_pointer(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_settimeofday
 static void
 print_settimeofday(void *cpu_env, const struct syscallname *name,
@@ -1916,6 +2017,60 @@ print_settimeofday(void *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_clock_gettime) || defined(TARGET_NR_clock_getres)
+static void
+print_clock_gettime(void *cpu_env, const struct syscallname *name,
+                    abi_long arg0, abi_long arg1, abi_long arg2,
+                    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_enums(clockids, arg0, 0);
+    print_pointer(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#define print_clock_getres     print_clock_gettime
+#endif
+
+#ifdef TARGET_NR_clock_settime
+static void
+print_clock_settime(void *cpu_env, const struct syscallname *name,
+                    abi_long arg0, abi_long arg1, abi_long arg2,
+                    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_enums(clockids, arg0, 0);
+    print_timespec(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_getitimer
+static void
+print_getitimer(void *cpu_env, const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_enums(itimer_types, arg0, 0);
+    print_pointer(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_setitimer
+static void
+print_setitimer(void *cpu_env, const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_enums(itimer_types, arg0, 0);
+    print_itimerval(arg1, 0);
+    print_pointer(arg2, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_link
 static void
 print_link(void *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index d0ea7f3464..084048ab96 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -83,16 +83,18 @@
 { TARGET_NR_clock_adjtime, "clock_adjtime" , NULL, print_clock_adjtime, NULL },
 #endif
 #ifdef TARGET_NR_clock_getres
-{ TARGET_NR_clock_getres, "clock_getres" , NULL, NULL, NULL },
+{ TARGET_NR_clock_getres, "clock_getres" , NULL, print_clock_getres,
+                          print_syscall_ret_clock_getres },
 #endif
 #ifdef TARGET_NR_clock_gettime
-{ TARGET_NR_clock_gettime, "clock_gettime" , NULL, NULL, NULL },
+{ TARGET_NR_clock_gettime, "clock_gettime" , NULL, print_clock_gettime,
+                           print_syscall_ret_clock_gettime },
 #endif
 #ifdef TARGET_NR_clock_nanosleep
 { TARGET_NR_clock_nanosleep, "clock_nanosleep" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_clock_settime
-{ TARGET_NR_clock_settime, "clock_settime" , NULL, NULL, NULL },
+{ TARGET_NR_clock_settime, "clock_settime" , NULL, print_clock_settime, NULL },
 #endif
 #ifdef TARGET_NR_clone
 { TARGET_NR_clone, "clone" , NULL, print_clone, NULL },
@@ -315,7 +317,8 @@
 { TARGET_NR_gethostname, "gethostname" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getitimer
-{ TARGET_NR_getitimer, "getitimer" , NULL, NULL, NULL },
+{ TARGET_NR_getitimer, "getitimer" , NULL, print_getitimer,
+                       print_syscall_ret_getitimer },
 #endif
 #ifdef TARGET_NR_get_kernel_syms
 { TARGET_NR_get_kernel_syms, "get_kernel_syms" , NULL, NULL, NULL },
@@ -388,7 +391,8 @@
 { TARGET_NR_gettid, "gettid" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_gettimeofday
-{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, NULL, NULL },
+{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, print_gettimeofday,
+                          print_syscall_ret_gettimeofday },
 #endif
 #ifdef TARGET_NR_getuid
 { TARGET_NR_getuid, "getuid" , "%s()", NULL, NULL },
@@ -1291,7 +1295,8 @@
 { TARGET_NR_sethostname, "sethostname" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_setitimer
-{ TARGET_NR_setitimer, "setitimer" , NULL, NULL, NULL },
+{ TARGET_NR_setitimer, "setitimer" , NULL, print_setitimer,
+                       print_syscall_ret_setitimer },
 #endif
 #ifdef TARGET_NR_set_mempolicy
 { TARGET_NR_set_mempolicy, "set_mempolicy" , NULL, NULL, NULL },
-- 
2.25.1


