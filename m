Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E66EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BAC20773
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="LYJTR/Xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BAC20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvB9-0003Id-8z
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1juv7u-00083M-9o
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:51:58 -0400
Received: from mail-eopbgr20139.outbound.protection.outlook.com
 ([40.107.2.139]:39808 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1juv7s-0001Wn-0x
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:51:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYklDoOqX1aX9N7syJCDC8EoE6XkpQG5V/DgWQCmmhEAAU50r0pBtO/Z2vwlLZcwNcPHUBKLWyaQw3erV7X+GVqrmw3g2u1p+UF6iQJhwTGKlNN5K6JX/aeA02ael2KJEz0L/TTZ9L/ljJoQxR32AjW7c8by1KvHb0kMkX8fzy28GIj4L1HFXD34dS3AXhpY1aixFTS6tBs7aqQXwEkecX/9B5R4sMu36lUo72ZcP7ZpYi7g4+Ygo3aqwvCUb8glEr9wl0saXSOXQY7WKp9zk9fNVS1blnnRE+r7yvWaHYiaBqr4NGqX2y87a64v/PXAIkKUhvV1tlaC9Ums0P8NzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REcFeriCm2lVqUlqABZ2s6CJ2vpcacjXGleM/vZdp6U=;
 b=n/zWEfVlmYyVRmVLjbVjtSxZjHDbs+vzaXJFdf1ax3WYXf2iVhnhY07gbDX7SrZ6AxFLvuiQR2qRYybYSlkIOzz0w7r9uoitADXd4HFE+DteBpykVbOixkLGn1SRWhuMzwAcfduNQlgeIm6/xJ3CjXzRBL/7d8wopnpNmYOfpsl75rsllX7tWe9DybrzKdCqTikX+h/+RWz3N3uYPXeB+OjQugiPtgVORXBCLG5kfSVbjvQi8HMmQdX7/8yi6kOxhmDlYMHBIWxIkJkq3RGSYkza+grLXkMLcJ9bVIxIvDwLsGdyAqJGJu374eWtA/3G+odJWiSxrhoUi19qYYYgGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REcFeriCm2lVqUlqABZ2s6CJ2vpcacjXGleM/vZdp6U=;
 b=LYJTR/Xl0d5rjv8jGz/VsY/+m8pHTFiRh88ajtxl2Z4SQoY+cbLQ925XEri0MCKKuuHd913ad8axb/mOqpVTLswmVcgKHwBqX8BYtS1Q2RKNOVttUQhuf4sm5jjlQO3jMs/2qqTU7BQIUfCKH1nZAWtgEg27SoQxzogwaWwjwHs=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5234.eurprd03.prod.outlook.com (2603:10a6:20b:c3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 09:51:18 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 09:51:18 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] linux-user: Add strace support for printing arguments
 of some clock and time functions
Date: Mon, 13 Jul 2020 11:50:58 +0200
Message-Id: <20200713095058.106624-5-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713095058.106624-1-Filip.Bozuta@syrmia.com>
References: <20200713095058.106624-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0050.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::19) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.238) by
 GV0P278CA0050.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:29::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Mon, 13 Jul 2020 09:51:17 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [147.91.217.238]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42036507-80bd-4f34-bcd5-08d827124a0b
X-MS-TrafficTypeDiagnostic: AM6PR03MB5234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR03MB5234DD608666CBDACD8EA10CEB600@AM6PR03MB5234.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzoGRNWJipoPb+wjsXyJyHkS2OcWAU4Q94IXZL2zEBTYV/WiBg7uAYhUacMyc9c+1tNNa5H2bJuJpD8nVc71zkOTkGrDGE5IxT4i4MTH3zuqALV8PWNgbmNi35jQg6NQ84trajzxBscumkvxcYmsiR8U8o3/pCtE8RWvdMoh9X7uqnIeKvjCsi3jnvgM18PU7ySj17GEqgMknWV2PnMp22yPNWyRNdxLw+iAMkuaq06QyhoXhZGdS6KUGO4xqDPcqH7i9rLaUJE1QlL5o9k5turYKwZvHfwtd3P2cJD6eM3wf2gZkeur79aMnVlOrFWP9VnE8ggCSLqynz80vg3WbjwEXGFhI+IrTnRkfZNEVD04ogN805GmUD5/USldg8bxiEAlidf7+2OLTh7EmsSmJiSKTdxOXiMxHlJ9lNv+yoRl7paDlgETE8H0cu41AIY5Ay2+xUsyVHKE8Umrma8pFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(346002)(366004)(136003)(396003)(39830400003)(54906003)(86362001)(6916009)(16526019)(8676002)(69590400007)(6486002)(2616005)(26005)(8936002)(316002)(186003)(956004)(508600001)(83380400001)(4326008)(966005)(107886003)(66556008)(30864003)(66946007)(66476007)(52116002)(6506007)(1076003)(5660300002)(6512007)(6666004)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Xn2CSvKdORmLKa8tijlJKJ4PWT2c7/EUn8P1k2ZnXWoYWCgHqyTb9mYNbhuvcKjGA1aYaZRJmWvNBiXNhOBdcUwpEO5a5KUlMLfrlWUwWrsA5d5X4tpR7+EdT1iU20gZqcF6DXAb5wH4ekBRUClQnfj/xxbiALGKXwtlnM64Wc0i9ckNMF06ZWb9H0P/kMXCaXwC+QLRc0QAK+nKipWjQdQ6rHmhy60IE79Lnh3wy20oobuTd3bv+iSUC6VuSc0Fc1P0CZwKbcvNPZ4ApzgiVE4qAOzyjvvfDIs9Emhlr7JV7tNesr39lMBVf56jXTWphmZpS0UXd+4iA8mo+bih2XjodHn/QvXFNKEfB4PXhMJfygN/5uhflQaLK5mc25aQ7u9jicsZjywOWk4F+ffQRcUykCkCAkcG39j4sD1ZQs1j3IvGLDSbbAyHSxMU5IPa/vbYGIZ0Y4CHHJFS38Z5RupK2y+4R6+/kLCewAbxFrk=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42036507-80bd-4f34-bcd5-08d827124a0b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 09:51:18.0751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSH8HUuaJblk/Q1ZGFHRpck2evtiovnobv9fPGV4zQU/6JpEtGF8Adt4RD4kmdXANPPOBvYvNshU14iWZbFF4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5234
Received-SPF: pass client-ip=40.107.2.139;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR02-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 05:51:48
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
    Function "print_itimer_type()" was added to print the type of the interval
    typer which is the firt argument of "getitimer()" and "setitimer()".
    Also, the existing function "print_timeval()" was changed a little so
    that it prints the field names beside the values. Syscalls "clock_getres()"
    and "clocK_gettime()" have the same number and types of arguments and
    thus their print functions "print_clock_getres" and "print_clock_gettime"
    shate a common definition in file "strace.c".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/strace.c    | 208 ++++++++++++++++++++++++++++++++++++++++-
 linux-user/strace.list |  17 ++--
 2 files changed, 217 insertions(+), 8 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 0d95cc6089..9bdee3b495 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -64,7 +64,10 @@ UNUSED static void print_string(abi_long, int);
 UNUSED static void print_buf(abi_long addr, abi_long len, int last);
 UNUSED static void print_raw_param(const char *, abi_long, int);
 UNUSED static void print_timeval(abi_ulong, int);
+UNUSED static void print_timespec(abi_ulong, int);
 UNUSED static void print_timezone(abi_ulong, int);
+UNUSED static void print_itimer_type(abi_ulong, int);
+UNUSED static void print_itimerval(abi_ulong, int);
 UNUSED static void print_number(abi_long, int);
 UNUSED static void print_signal(abi_ulong, int);
 UNUSED static void print_sockaddr(abi_ulong, abi_long, int);
@@ -829,6 +832,89 @@ print_syscall_ret_adjtimex(void *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_clock_gettime) || defined(TARGET_NR_clock_getres)
+static void
+print_syscall_ret_clock_gettime(void *cpu_env, const struct syscallname *name,
+                                abi_long ret, abi_long arg0, abi_long arg1,
+                                abi_long arg2, abi_long arg3, abi_long arg4,
+                                abi_long arg5)
+{
+    print_syscall_err(ret);
+
+    if (ret >= 0) {
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
+    print_syscall_err(ret);
+
+    if (ret >= 0) {
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
+    print_syscall_err(ret);
+
+    if (ret >= 0) {
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
+    print_syscall_err(ret);
+
+    if (ret >= 0) {
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
@@ -1408,13 +1494,34 @@ print_timeval(abi_ulong tv_addr, int last)
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
@@ -1434,6 +1541,36 @@ print_timezone(abi_ulong tz_addr, int last)
     }
 }
 
+static void
+print_itimer_type(abi_ulong itimer, int last)
+{
+    switch (itimer) {
+    case ITIMER_REAL:
+        qemu_log("ITIMER_REAL,"); break;
+    case ITIMER_VIRTUAL:
+        qemu_log("ITIMER_VIRTUAL,"); break;
+    case ITIMER_PROF:
+        qemu_log("ITIMER_PROF,"); break;
+    default:
+        print_raw_param("%#x", itimer, 0);
+    }
+    qemu_log("%s", get_comma(last));
+}
+
+static void
+print_itimerval(abi_ulong it_addr, int last)
+{
+    if (it_addr) {
+        qemu_log("{it_interval=");
+        print_timeval(it_addr, 0);
+        qemu_log("it_value=");
+        print_timeval(it_addr + sizeof(struct target_timeval), 1);
+        qemu_log("}%s", get_comma(last));
+    } else {
+        qemu_log("NULL%s", get_comma(last));
+    }
+}
+
 #undef UNUSED
 
 #ifdef TARGET_NR_accept
@@ -1876,6 +2013,19 @@ print_futimesat(void *cpu_env, const struct syscallname *name,
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
@@ -1889,6 +2039,60 @@ print_settimeofday(void *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_clock_gettime) || defined(TARGET_NR_clock_getres)
+static void
+print_clock_gettime(void *cpu_env, const struct syscallname *name,
+                    abi_long arg0, abi_long arg1, abi_long arg2,
+                    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_clockid(arg0, 0);
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
+    print_clockid(arg0, 0);
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
+    print_itimer_type(arg0, 0);
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
+    print_itimer_type(arg0, 0);
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


