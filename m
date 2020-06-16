Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C04C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E5A20767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="HgCYIjIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E5A20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl92s-0002PB-Af
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90O-0006r0-7E
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:48 -0400
Received: from mail-db8eur05on2113.outbound.protection.outlook.com
 ([40.107.20.113]:30304 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90M-0002xB-4G
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ih/DowvKsOf8HtNr4FnhC32IBHQemI0vMPq1yMDujpRJEgfGHdkzWAIPh8e697zUGJThvJb7xJ3EnK70+5xZWRMnaYUkxL6GlL58mxI57fGI4HbR79l/uGA6PtCGhzQoFgMNvZzrmW0xKVWb6ycFKd8hJz5axuxDKtIZ51+bTYEudn25BTdjB8rH+zJlUoF3L1vNyrD/cCgKwYZu9W1z2xeu3oZu9HmNNfvYO+LousitEh9D/m+tPfIDRVmEzk5RVM4BQkc48Hh3EMwTaX1wB7eqG5MrXb7sy1/DAT0fKZBevRL8wl4a61+d30wz2JuebuwAe5xaC64Z1XKQaGRj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVn1tLFduN7ywzh6RphziuXVIFJ38+1zV94eGPNP+2c=;
 b=Yu3d2h3dMaatUTA05CJ5RH8pXkLy4NCb3ifsgYvrLmdPUCe71RYx0I1KDVjysc9LQN1rVxGcTRVoPxrplFESUBUfmzsjKatnKIBaZA7RWUFGZJybFNkv/hkZInFo84CATfSfkd6YzaLprSxe2bcxVgzL3cC5ZqWk9otppK5XQ2BRhghzTBIXofsW5srpQPz/W0hVoN4StyDUqyI0pgNlihC++0DmwgEUmHod6UjHo0B+tF+sYTbX6Rx306MllnUXo7SXj0SbX27SI+/n+TnzDIqx41DD/dhNY4v9d6CEBJml4I/V9IwZMuH8IGuzd+p9g4sYCr08ms5cK0bhWtmaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVn1tLFduN7ywzh6RphziuXVIFJ38+1zV94eGPNP+2c=;
 b=HgCYIjIk/uKKtE9lBk0Z/4zlas6+QKUZPoqESkG89PMnP4jdqdYBfaWDWYp+dFwwUTqR4CTiQIi21sPJGVyB7hUh+hEaZxww3I1WwD+pkfetMHBr8H10yyZ9QUhB7Y93qIM+FYskOv17H+QboTOpoMjtqCDRJa3WeDj1+jYYhRE=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3960.eurprd03.prod.outlook.com (2603:10a6:20b:25::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 10:39:41 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:39:41 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/6] linux-user: Extend strace support to enable argument
 printing after syscall execution
Date: Tue, 16 Jun 2020 12:39:22 +0200
Message-Id: <20200616103927.20222-2-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616103927.20222-1-filip.bozuta@syrmia.com>
References: <20200616103927.20222-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::15) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0046.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 10:39:41 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1138bbe3-6cfe-4aea-69e6-08d811e19392
X-MS-TrafficTypeDiagnostic: AM6PR03MB3960:
X-Microsoft-Antispam-PRVS: <AM6PR03MB39602365793662970D7B37EBEB9D0@AM6PR03MB3960.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R00PCe2q3Q6lUfWYTc/nQ9GGkD/AKi0v8wA+ahs9KqEtwazwvmv17UKf07/dSY/veuxYrn/VDqPxrFdxKGq40v30m4P8Zp4LL8sRQkzPL4JjXjYcNysLYFGKEJSqX0s6ZRni/0hJ7mdjruDz8gvOGBI5Uu8ZjBQBzpEi2u1l9saZNhPIGY+FRz511p+uspotSruXPeePJnBeqRC2ihxli807g9f6fRxn804AnyiGHI0LspkRKH8NYSnB8A0k1u/yrzTom9R931KjeQpCkE0EDUHBhQHNM+/iAqRPob8vMX8QSDBfHSgN/UsVbaG9d5ID6y6dCEfc7bC+uzz7TccTIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(346002)(366004)(376002)(39830400003)(136003)(5660300002)(83380400001)(86362001)(508600001)(8936002)(316002)(6666004)(66476007)(6916009)(7696005)(36756003)(2616005)(52116002)(66946007)(66556008)(956004)(44832011)(26005)(1076003)(2906002)(4326008)(16526019)(6486002)(186003)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: T3hIl54rE506oOOHHKTR72StDPtc8G1F8eg/0EozcZfAMSq+kfSOHGZCrS+ug5SF0h75Rkzqpq+w7ZBdDj93ANrY4HbIpCnzlcy/CmebkhGL/LdubcT5ZvA0SUUg0hgCR41fX7lgtrbF9DYzwktkN97St0owpGEWaH6HjrcW6OjVAtXK/+p3Au5ARzEubaI96OmO218WmanEEiMyp8gyGBblpaG7xwLr+NLRoFdwM9w8dp/3+nyxYBpT3Dm/7PKPnYv77J4ujc0qUDvyvk7XrFd3Ir/xKTMOQF4cXFG95ASGCXghOy/YvzZwzRPfMH1XygtS0Royhv15IzRvp2df10igj+pPGe8qTdXm5L5Pttp7181HRqaE6DbDCAQUpnV4ZNqmXX4igLH/9Vp1+FKgb4A97Un2PhNr9b5L/63bwCB89zUN7HYIGlNAZNt0/1yXLU/RHy6T/7iYsZ1hL8CUnOiUmx+i0rSqEK+ONMJPVdU=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1138bbe3-6cfe-4aea-69e6-08d811e19392
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 10:39:41.5454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85uyXzE1pkN0LrkfI9HfqIKCVWfi0t9A3xf3oadunvwrOJk2xSE8rtFGsI0r9e1so+wP4LdPShjL4rLu2hUfVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3960
Received-SPF: pass client-ip=40.107.20.113;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 06:39:41
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

    Structure "struct syscallname" in file "strace.c" is used for "-strace"
    to print arguments and return values of syscalls. The last field of
    this structure "result" represents the calling function that prints the
    return values. This field was extended in this patch so that this function
    takes all syscalls arguments beside the return value. In this way, it enables
    "-strace" to print arguments of syscalls that have changed after the syscall
    execution. This extension will be useful as there are many syscalls that
    return values inside their arguments (i.e. listxattr() that returns the list
    of extended attributes inside the "list" argument).

Implementation notes:

    Since there are already three existing "print_syscall_ret*" functions inside
    "strace.c" ("print_syscall_ret_addr()", "print_syscall_ret_adjtimex()",
    "print_syscall_ret_newselect()"), they were changed to have all syscall arguments
    beside the return value. This was done so that these functions don't cause build
    errors (even though syscall arguments are not used in these functions).
    There is code repetition in these functions for checking the return value
    and printing the approppriate error message (this code is also located in
    print_syscall_ret() at the end of "strace.c"). That is the reason why a
    function "syscall_print_err()" was added for this code and put inside these
    functions.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/qemu.h    |  4 ++-
 linux-user/strace.c  | 67 ++++++++++++++++++++++++++------------------
 linux-user/syscall.c |  2 +-
 3 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index ce902f5132..8f938b8105 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -383,7 +383,9 @@ int host_to_target_waitstatus(int status);
 void print_syscall(int num,
                    abi_long arg1, abi_long arg2, abi_long arg3,
                    abi_long arg4, abi_long arg5, abi_long arg6);
-void print_syscall_ret(int num, abi_long arg1);
+void print_syscall_ret(int num, abi_long ret,
+                       abi_long arg1, abi_long arg2, abi_long arg3,
+                       abi_long arg4, abi_long arg5, abi_long arg6);
 /**
  * print_taken_signal:
  * @target_signum: target signal being taken
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 0d9095c674..805fcb9fd1 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -19,7 +19,9 @@ struct syscallname {
     void (*call)(const struct syscallname *,
                  abi_long, abi_long, abi_long,
                  abi_long, abi_long, abi_long);
-    void (*result)(const struct syscallname *, abi_long);
+    void (*result)(const struct syscallname *, abi_long,
+                   abi_long, abi_long, abi_long,
+                   abi_long, abi_long, abi_long);
 };
 
 #ifdef __GNUC__
@@ -736,17 +738,29 @@ print_ipc(const struct syscallname *name,
  */
 
 static void
-print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
+print_syscall_err(abi_long ret)
 {
     const char *errstr = NULL;
 
+    qemu_log(" = ");
     if (ret < 0) {
+        qemu_log("-1 errno=%d", errno);
         errstr = target_strerror(-ret);
+        if (errstr) {
+            qemu_log(" (%s)", errstr);
+        }
     }
-    if (errstr) {
-        qemu_log(" = -1 errno=%d (%s)\n", (int)-ret, errstr);
-    } else {
-        qemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
+}
+
+static void
+print_syscall_ret_addr(const struct syscallname *name, abi_long ret,
+                       abi_long arg0, abi_long arg1, abi_long arg2,
+                       abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_err(ret);
+
+    if (ret >= 0) {
+        qemu_log("0x" TARGET_ABI_FMT_lx "\n", ret);
     }
 }
 
@@ -760,7 +774,9 @@ print_syscall_ret_raw(struct syscallname *name, abi_long ret)
 
 #ifdef TARGET_NR__newselect
 static void
-print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
+print_syscall_ret_newselect(const struct syscallname *name, abi_long ret,
+                            abi_long arg0, abi_long arg1, abi_long arg2,
+                            abi_long arg3, abi_long arg4, abi_long arg5)
 {
     qemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
     print_fdset(newselect_arg1,newselect_arg2);
@@ -783,18 +799,13 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
 #define TARGET_TIME_ERROR    5   /* clock not synchronized */
 #ifdef TARGET_NR_adjtimex
 static void
-print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret)
+print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
+                           abi_long arg0, abi_long arg1, abi_long arg2,
+                           abi_long arg3, abi_long arg4, abi_long arg5)
 {
-    const char *errstr = NULL;
+    print_syscall_err(ret);
 
-    qemu_log(" = ");
-    if (ret < 0) {
-        qemu_log("-1 errno=%d", errno);
-        errstr = target_strerror(-ret);
-        if (errstr) {
-            qemu_log(" (%s)", errstr);
-        }
-    } else {
+    if (ret >= 0) {
         qemu_log(TARGET_ABI_FMT_ld, ret);
         switch (ret) {
         case TARGET_TIME_OK:
@@ -2847,25 +2858,25 @@ print_syscall(int num,
 
 
 void
-print_syscall_ret(int num, abi_long ret)
+print_syscall_ret(int num, abi_long ret,
+                  abi_long arg1, abi_long arg2, abi_long arg3,
+                  abi_long arg4, abi_long arg5, abi_long arg6)
 {
     int i;
-    const char *errstr = NULL;
 
     for(i=0;i<nsyscalls;i++)
         if( scnames[i].nr == num ) {
             if( scnames[i].result != NULL ) {
-                scnames[i].result(&scnames[i], ret);
+                scnames[i].result(&scnames[i], ret,
+                                  arg1, arg2, arg3,
+                                  arg4, arg5, arg6);
             } else {
-                if (ret < 0) {
-                    errstr = target_strerror(-ret);
-                }
-                if (errstr) {
-                    qemu_log(" = -1 errno=" TARGET_ABI_FMT_ld " (%s)\n",
-                             -ret, errstr);
-                } else {
-                    qemu_log(" = " TARGET_ABI_FMT_ld "\n", ret);
+                print_syscall_err(ret);
+
+                if (ret >= 0) {
+                    qemu_log(TARGET_ABI_FMT_ld, ret);
                 }
+                qemu_log("\n");
             }
             break;
         }
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..009bb67422 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12441,7 +12441,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                       arg5, arg6, arg7, arg8);
 
     if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
-        print_syscall_ret(num, ret);
+        print_syscall_ret(num, ret, arg1, arg2, arg3, arg4, arg5, arg6);
     }
 
     record_syscall_return(cpu, num, ret);
-- 
2.17.1


