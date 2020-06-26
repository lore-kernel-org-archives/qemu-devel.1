Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CD2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1840208C7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="B15W5z+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1840208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jow6b-00089D-6R
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jow5S-0006mG-3K
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:40:42 -0400
Received: from mail-db8eur05on2124.outbound.protection.outlook.com
 ([40.107.20.124]:39136 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jow5Q-0004FJ-1s
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:40:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsvthOMAidyZxPd4G/1xPPET03BbgNsTwSlmKjqQByX9cHvYhuJ4bO19u8K2tAQvipOfTpUNHye6l362N3zNY/d05GAjshPERlPoMOSoraMFM99zvD0MJxLkiyvD/OiuO/yPbbfAo4BEcO4MKSPSCh3C/Ur3uF7nZYRGIpjs0qgs0CCBOvRXGcw/84MDNB2WqdjZRrEgLAsmefDKwhfrLj8rx+W2ic8JGhvcKa4Qno6JbPwrn2+M+pBYAx5QizdAKDChlR22VmmpROlwVsI/MJBwa+vbsZTSZzMoocET3gEldTxg6yoC4OC6ypsv36ZPPSupPDmStJ/7dmFczOZVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS6+bJznuhZnLeLbDo/lo5JjYfjmHeP3FECNDOcTNUA=;
 b=BHdUVCfDrxaNHaQA5gbKTWMNJa7WW0BdbvBhGfQAkQEKfWKAbYyk8AOe/Jb1U+DCQ5kYt53Rqyh4kvLX4c5v4yGxdsdUJ/LW0BbS6feKUxlVYzTSp1h99/F0fLSEcGfwP6D/I0NbrsSbChoS+ulw99j3raMoKjSKUB/OI4ZLwTbYH6SWzGBoO2sC91JOyAPhDDGbOB5uqeD7OjMMuTzB5YBn1ypEPZAxH/GoXvuEiO7v3hgxsKDNqgUlL5nLBBaeDpe5iauewhZeVq/uq9WooVzicr3SVhzL5jkw3JokIW9gcv9jEroy2Dkwp3Q6KozFWMTr/xBqpW7f5iBkY6dGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS6+bJznuhZnLeLbDo/lo5JjYfjmHeP3FECNDOcTNUA=;
 b=B15W5z+eaOUrMzWsEe8AvOAcsO8ZVdfTChLIxr7SyCw4w/BJiG6Pg6/2qq2Hi0pVh6Uoax/T2bxzTZD1xlbmTRmJCIwpJQBW/varopjqhv3pu8UKlcS+IJpEHufNWljl7vsLGlxIRS5tYGZlv88jPfqUxcXwbX5CXR9XYLda4h8=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB5234.eurprd03.prod.outlook.com (2603:10a6:20b:c3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Fri, 26 Jun
 2020 21:39:59 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3131.021; Fri, 26 Jun 2020
 21:39:59 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] linux-user: Add strace support for printing arguments of
 some clock and time functions
Date: Fri, 26 Jun 2020 23:39:37 +0200
Message-Id: <20200626213937.20333-4-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200626213937.20333-1-Filip.Bozuta@syrmia.com>
References: <20200626213937.20333-1-Filip.Bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0044.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::13) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (147.91.217.240) by
 ZR0P278CA0044.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 21:39:59 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [147.91.217.240]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcfa21a9-e82c-49a3-2130-08d81a197a01
X-MS-TrafficTypeDiagnostic: AM6PR03MB5234:
X-Microsoft-Antispam-PRVS: <AM6PR03MB52346295CD09E9ADED7F46A8EB930@AM6PR03MB5234.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BgAIybkNR9LavtnFMOEuSACavGViY52Mlwqknbset3KzqSOf/ntso+R/qFQe3EK/nuLcqqooFpXKZzI0KyMu4ggNGeHejbzmMUrx4waAT1Kx1Je+u8gaYxM6UOKAmyvnbt4HoDIyc5/FJoTz4f0frw7UWVaZ/ovFJkXKIrwL9g7afsTPtAFGaTw4OsmmLm4UfEIYozP731+ukOwSJ+SL8l+48Vf7TVA2jA4/G3+aJsYbhfx2lhn6VOcN+V0qJymcJgagRmcXXxPLQ0T7W2sZ1dugWRmytVxTOQogWfeNg4b/qtkTykpUGVgNSeCHUJqfP7P6+eLgKyiUkk77i8LKTSQKxKgKpIRrJobpoq4HO6NXfjy5/3TedjNIuIXSW7MtTsIhDypDTpc7u1rBNbj6hklTXlKKg8DiuA2UKxrBhXM95f/BkHUsA3nmRfbthL0p9SPG1tM4x8l4omukEPFhHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(346002)(396003)(136003)(366004)(4326008)(6666004)(6506007)(1076003)(508600001)(83380400001)(966005)(86362001)(6512007)(30864003)(16526019)(186003)(6486002)(52116002)(316002)(6916009)(36756003)(2906002)(66476007)(66946007)(69590400007)(66556008)(8936002)(26005)(5660300002)(8676002)(2616005)(956004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: pjSQ5w13IKhswtnYp7zmFe+2zTjTQ22cDeExvJR1E2eHOmj9QWkyG4Q1iwiALZJhiAXTrdgp3s62+AUVz4EpccCgRhRfJ4H0CRlyt+dsag3MJdWXVECPeqcmDJR88DtGNNFFd7jWWZrUlilcIuYW4xIvfJevcGYfPba1K0J3mVNeVvDtlomHPe4aDVcgcRzbfp9cwbOsxKxz9wmH2bZzNooAFOzUFr9NQx99wmJxmYahQwEICPRcg9EmwSSYVvzrnztqHk0V2iUpxXW2oaCwfE0ORbVc6hZLJ69Tju2VHcPPpmuC4tRgpsuf/EdAiVF03VShrBd5F9szYmXMQ9Tp+fXRCPSp6/n/00tJ081F64jU4wPAIe26NRfYcKHrfeLowX19LCoFA3J3f09FOBC/dWMd2sKYAWc2t7b1uLNE7TM7AMujo23YUNqHUQzuzw65FNKFrpCIUUTIA+RQPqXmcp7BpwbxsC8INC/imEVffJ8=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfa21a9-e82c-49a3-2130-08d81a197a01
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 21:39:59.8832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoNZeourPGBC0irvwCPxIhnuvdHEAgdIlTS2Xoj6BKPcfeYQV8fP6AsAlOVPRfWc3LijzlljVS8JH2C4xyH5gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB5234
Received-SPF: pass client-ip=40.107.20.124;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:40:33
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
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
    Also, the existing function "print_timeval()" was changed a little so
    that it prints the field names beside the values. Syscalls "clock_getres()"
    and "clocK_gettime()" have the same number and types of arguments and
    thus their print functions "print_clock_getres" and "print_clock_gettime"
    shate a common definition in file "strace.c".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/strace.c    | 186 ++++++++++++++++++++++++++++++++++++++++-
 linux-user/strace.list |  16 ++--
 2 files changed, 194 insertions(+), 8 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 1fc4404310..414748d0fa 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -64,7 +64,9 @@ UNUSED static void print_string(abi_long, int);
 UNUSED static void print_buf(abi_long addr, abi_long len, int last);
 UNUSED static void print_raw_param(const char *, abi_long, int);
 UNUSED static void print_timeval(abi_ulong, int);
+UNUSED static void print_timespec(abi_ulong, int);
 UNUSED static void print_timezone(abi_ulong, int);
+UNUSED static void print_itimerval(abi_ulong, int);
 UNUSED static void print_number(abi_long, int);
 UNUSED static void print_signal(abi_ulong, int);
 UNUSED static void print_sockaddr(abi_ulong, abi_long, int);
@@ -833,6 +835,65 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
 }
 #endif
 
+#if defined(TARGET_NR_clock_gettime) || defined(TARGET_NR_clock_getres)
+static void
+print_syscall_ret_clock_gettime(const struct syscallname *name, abi_long ret,
+                                abi_long arg0, abi_long arg1, abi_long arg2,
+                                abi_long arg3, abi_long arg4, abi_long arg5)
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
+print_syscall_ret_gettimeofday(const struct syscallname *name, abi_long ret,
+                               abi_long arg0, abi_long arg1, abi_long arg2,
+                               abi_long arg3, abi_long arg4, abi_long arg5)
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
+print_syscall_ret_getitimer(const struct syscallname *name, abi_long ret,
+                            abi_long arg0, abi_long arg1, abi_long arg2,
+                            abi_long arg3, abi_long arg4, abi_long arg5)
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
 #if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr) \
  || defined(TARGGET_NR_flistxattr)
 static void
@@ -1371,13 +1432,34 @@ print_timeval(abi_ulong tv_addr, int last)
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
@@ -1397,6 +1479,21 @@ print_timezone(abi_ulong tz_addr, int last)
     }
 }
 
+static void
+print_itimerval(abi_ulong it_addr, int last)
+{
+    if (it_addr) {
+        qemu_log("{it_interval=");
+        print_timeval(it_addr, 0);
+        qemu_log("it_value=");
+        print_timeval(it_addr +
+                      offsetof(struct target_itimerval, it_value), 1);
+        qemu_log("}%s", get_comma(last));
+    } else {
+        qemu_log("NULL%s", get_comma(last));
+    }
+}
+
 #undef UNUSED
 
 #ifdef TARGET_NR_accept
@@ -1839,6 +1936,19 @@ print_futimesat(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_gettimeofday
+static void
+print_gettimeofday(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
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
 print_settimeofday(const struct syscallname *name,
@@ -1852,6 +1962,78 @@ print_settimeofday(const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_clock_gettime) || defined(TARGET_NR_clock_getres)
+static void
+print_clock_gettime(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
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
+print_clock_settime(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
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
+print_getitimer(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    switch (arg0) {
+    case ITIMER_REAL:
+        qemu_log("ITIMER_REAL,"); break;
+    case ITIMER_VIRTUAL:
+        qemu_log("ITIMER_VIRTUAL,"); break;
+    case ITIMER_PROF:
+        qemu_log("ITIMER_PROF,"); break;
+    default:
+        print_raw_param("%#x", arg1, 0);
+    }
+    print_pointer(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_setitimer
+static void
+print_setitimer(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    switch (arg0) {
+    case ITIMER_REAL:
+        qemu_log("ITIMER_REAL,"); break;
+    case ITIMER_VIRTUAL:
+        qemu_log("ITIMER_VIRTUAL,"); break;
+    case ITIMER_PROF:
+        qemu_log("ITIMER_PROF,"); break;
+    default:
+        print_raw_param("%#x", arg1, 0);
+    }
+    print_itimerval(arg1, 0);
+    print_itimerval(arg2, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_link
 static void
 print_link(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 822b6be49c..6b5cef149f 100644
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
@@ -1290,7 +1294,7 @@
 { TARGET_NR_sethostname, "sethostname" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_setitimer
-{ TARGET_NR_setitimer, "setitimer" , NULL, NULL, NULL },
+{ TARGET_NR_setitimer, "setitimer" , NULL, print_setitimer, NULL },
 #endif
 #ifdef TARGET_NR_set_mempolicy
 { TARGET_NR_set_mempolicy, "set_mempolicy" , NULL, NULL, NULL },
-- 
2.17.1


