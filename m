Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6334AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D3B2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="RCcW1M/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D3B2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKze-0003SS-5u
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiKsu-0003NA-1q
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:44:28 -0400
Received: from mail-eopbgr80091.outbound.protection.outlook.com
 ([40.107.8.91]:62103 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jiKss-0007Fd-RF
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:44:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsdOPjGBCpXwPNdO15j93UfhDyd48uEsam6KKfxTUvPB3ZA/Rmxw6ndGowktTVew6V6/lbOPgbjA+oXWSOq2L/HwJB2KKAtRsP/QNrV5pB0ycndKO8BV4bn8zo2yfFemiY3uPTzvTMwSB0uqJSbeIGxdmsdMsMdviD5vGei0KnaEYpQMGMhuSPGNKThMzpij1rGi7Y1yK6yc1tGhiVpMrRQkq9DLngcAo8ZwetMJ9CB519wfUs+9p8Efu1Uxr0sJqufGC93A8UAIgFMZoaCRBF1VwuJAcO8QkppGb3zdJ1te+ut6lygGE4DFvapqPays536TxSpkO8bqcqHYqcbq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzvfXbuOhXoutjs1cs10nTaCxD/4PwVFgOsgUfQSZK4=;
 b=VyfSOAdMaRl8/dL2+tvvH/7p8g6dJ0l/gBPYJvPD8AsRKxfhY8+k38Y6qk6AZrkh0kehUo7r4zOcxU1DvMctEToKXlzbKmWLwGS4Rrr/AwY/h1nTrA/nX5BlyvyrRG4cgmGiC2PggX9NOee5LnSodxtuuJlvJm6ZmSuTSiOhTWz0dbiE/u2/rFf2STSu4jm1afm8iEAIMkWQg+qc1GlWfxPM2KplYWSzbLXxesoNP5yyPfSX9ShPwyWYtOCOfThIcNZxt0QjCQ9wySa8XenFGZC2XG4Yngi2ipduV5gDhC4MUi9MMrLQJoFgdFmdkgAUwaxJK1NX0qtZgJ9mKQFKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzvfXbuOhXoutjs1cs10nTaCxD/4PwVFgOsgUfQSZK4=;
 b=RCcW1M/ZZW+hqQeLHUuvDRQBVgyEdgdo1SC+OYdEc65X6gEd3HmHUJPTrnBP9WjmkRwSgRAF1f7jv1EstKrjUDdImpYxHy+wMLN/9XWylYSDOu0CabJBdkyINBboO1HXQx21Kbhwv4a33zx03NRvk884XSBNOoVxUBMbDEwgp7w=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3798.eurprd03.prod.outlook.com (2603:10a6:20b:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Mon, 8 Jun
 2020 16:44:12 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 16:44:12 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] linux-user: Add strace support for printing argument
 of syscalls used for extended attributes
Date: Mon,  8 Jun 2020 18:43:54 +0200
Message-Id: <20200608164357.25065-4-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608164357.25065-1-filip.bozuta@syrmia.com>
References: <20200608164357.25065-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::26) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0016.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 16:44:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed87baee-cf27-4fae-85a4-08d80bcb2c08
X-MS-TrafficTypeDiagnostic: AM6PR03MB3798:
X-Microsoft-Antispam-PRVS: <AM6PR03MB3798838F79314D190E3D9AA0EB850@AM6PR03MB3798.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59/ApjDJiqOh2ZJ7PMg4Vopuf5J0zhIZ0dV+jaBvbTFDCH9fcewSbjQXCKuSptFTtScM+lwZfCrHOwwjcTKZoB37xnJRSiqZ2wzpnn/hKQ+P5oAuoY6PEcRSWQhljLvoLftow606xevusbCmEV9SRgo6p3sMG2hI5IhwRmj78rs92L+ifE2SiuNcKlOUNMOWwCN232NAjvvfdpbZrpcJs0OxZ9esx0fYzwIwHF+Xp7l8vULYE902ftYeDM7cQ+iWpZEq/8LyEm4Tah23EuqxoD0NWInMk4NTGXnwAi3TIA9iPlUvSJ6VWUu7T0bEOAi4zVkmyvVj5IBCpVHUvTPHVdyl8+2FX3birzaUWj1yKJW4bWnoS7ZkYT3FZWWFOVb/5G36LmrLLVzpMwFZAB/rH+L6EMhdQw4zQV+jGCKQNRKwYHb22odkIWA/0X6N9h78B6BiBn/yEg0VRMUuvA61lQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(376002)(396003)(346002)(136003)(366004)(508600001)(4326008)(8676002)(8936002)(966005)(1076003)(66556008)(6916009)(66476007)(5660300002)(66946007)(86362001)(316002)(36756003)(16526019)(26005)(2906002)(52116002)(83380400001)(2616005)(956004)(44832011)(6486002)(7696005)(186003)(6666004)(334744003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: VqD6mPWShB25mdBqg++N+FZMeq2AQmzN/soc7e6BuB+8gm6kHy60K2XKvIZJhe3jTQbdQgyo0G7tKCC55kdOSgsIo/FA4hhbtRR/2CYeF3zmdkM5z+ivJyYGo7DepGKnHHUDOV6Xd009cFl2iM2c0BnjP1xUwV3ATCofQLBbDjYqp0BY9ewv2Ay15EW+Dd27PSIYLPCOrVu4wGGybOdvFBEpqbdScZ8rUcIre3uM8NDfNPFnvXs2RYhfsw88kVCk5CdeEiaLa+7pvxACQoct63AZQ+dCe5Jm0DBJ08DN6pGOM4WIF5GtBhlvQmkGBvAeJfdrzpTwBYhUD1y3cBlMvy4etYNCu2z+GtifZRiTgFo4+39wNq2DH21/2s+5fpzmOs0kNyX3gAIkGKhWXOGM8T3aIMFpM8uil4gwixkAhvE7tqUNEydoJbn5f7mqSa2Rt37tmE1H97krKt2sMAiGs2rcM4Vn7fAg24JOPQl7FOA=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed87baee-cf27-4fae-85a4-08d80bcb2c08
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 16:44:11.9986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgUI69IGsYkTWyteu9K1O1mmKNx3jxBvsNkeAhDFAc1/7CvXaoLVnpWUrku2taJXOQLcqHyQdpzuWXWcSslOMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3798
Received-SPF: pass client-ip=40.107.8.91; envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 12:44:17
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

This patch implements strace argument printing functionality for following syscalls:

    *getxattr, lgetxattr, fgetxattr - retrieve an extended attribute value

        ssize_t getxattr(const char *path, const char *name, void *value, size_t size)
        ssize_t lgetxattr(const char *path, const char *name, void *value, size_t size)
        ssize_t fgetxattr(int fd, const char *name, void *value, size_t size)
        man page: https://www.man7.org/linux/man-pages/man2/getxattr.2.html

    *listxattr, llistxattr, flistxattr - list extended attribute names

        ssize_t listxattr(const char *path, char *list, size_t size)
        ssize_t llistxattr(const char *path, char *list, size_t size)
        ssize_t flistxattr(int fd, char *list, size_t size)
        man page: https://www.man7.org/linux/man-pages/man2/listxattr.2.html

    *removexattr, lremovexattr, fremovexattr - remove an extended attribute

         int removexattr(const char *path, const char *name)
         int lremovexattr(const char *path, const char *name)
         int fremovexattr(int fd, const char *name)
         man page: https://www.man7.org/linux/man-pages/man2/removexattr.2.html

Implementation notes:

    All of the syscalls have strings as argument types and thus a separate
    printing function was stated in file "strace.list" for every one of them.
    All of these printing functions were defined in "strace.c" using existing
    printing functions for appropriate argument types:
       "print_string()" - for (const char*) type
       "print_pointer()" - for (char*) and (void *) type
       "print_raw_param()" for (int) and (size_t) type
    Syscalls "getxattr()" and "lgetxattr()" have the same number and type of
    arguments and thus their print functions ("print_getxattr", "print_lgetxattr")
    share a same definition. The same statement applies to syscalls "listxattr()"
    and "llistxattr()".
    Function "print_syscall_ret_listxattr()" was added to print the returned list
    of extended attributes for syscalls and was listed as a "result" function in file
    "strace.list" for syscalls: "listxattr(), llistxattr(), flistxattr()".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/strace.c    | 126 +++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  21 ++++---
 2 files changed, 138 insertions(+), 9 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index f980451e3f..59fdb0a05f 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -830,6 +830,45 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
 }
 #endif
 
+#if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr) \
+ || defined(TARGGET_NR_flistxattr)
+static void
+print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
+                            abi_long arg0, abi_long arg1, abi_long arg2,
+                            abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    const char *errstr = NULL;
+
+    qemu_log(" = ");
+    if (ret < 0) {
+        qemu_log("-1 errno=%d", errno);
+        errstr = target_strerror(-ret);
+        if (errstr) {
+            qemu_log(" (%s)", errstr);
+        }
+    } else {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+        qemu_log(" (list = ");
+        if (arg1 != 0) {
+            abi_long attr = arg1;
+            for (;;) {
+                print_string(attr, 1);
+                attr += target_strlen(attr) + 1;
+                if (target_strlen(attr) == 0) {
+                    break;
+                }
+                qemu_log(",");
+            }
+        } else {
+            qemu_log("NULL");
+        }
+        qemu_log(")");
+    }
+
+    qemu_log("\n");
+}
+#endif
+
 UNUSED static struct flags access_flags[] = {
     FLAG_GENERIC(F_OK),
     FLAG_GENERIC(R_OK),
@@ -1637,6 +1676,93 @@ print_fcntl(const struct syscallname *name,
 #define print_fcntl64   print_fcntl
 #endif
 
+#ifdef TARGET_NR_fgetxattr
+static void
+print_fgetxattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_string(arg1, 0);
+    print_pointer(arg2, 0);
+    print_raw_param(TARGET_FMT_lu, arg3, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#ifdef TARGET_NR_flistxattr
+static void
+print_flistxattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_pointer(arg1, 0);
+    print_raw_param(TARGET_FMT_lu, arg2, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#if defined(TARGET_NR_getxattr) || defined(TARGET_NR_lgetxattr)
+static void
+print_getxattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_string(arg1, 0);
+    print_pointer(arg2, 0);
+    print_raw_param(TARGET_FMT_lu, arg3, 1);
+    print_syscall_epilogue(name);
+}
+#define print_lgetxattr     print_getxattr
+#endif
+
+#if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr)
+static void
+print_listxattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_pointer(arg1, 0);
+    print_raw_param(TARGET_FMT_lu, arg2, 1);
+    print_syscall_epilogue(name);
+}
+#define print_llistxattr     print_listxattr
+#endif
+
+#if defined(TARGET_NR_fremovexattr)
+static void
+print_fremovexattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_string(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
+#if defined(TARGET_NR_removexattr) || defined(TARGET_NR_lremovexattr)
+static void
+print_removexattr(const struct syscallname *name,
+    abi_long arg0, abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_string(arg0, 0);
+    print_string(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#define print_lremovexattr     print_removexattr
+#endif
+
 #ifdef TARGET_NR_futimesat
 static void
 print_futimesat(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index fb9799e7e6..05a72370c1 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -218,13 +218,14 @@
 { TARGET_NR_fdatasync, "fdatasync" , "%s(%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_fgetxattr
-{ TARGET_NR_fgetxattr, "fgetxattr" , NULL, NULL, NULL },
+{ TARGET_NR_fgetxattr, "fgetxattr" , NULL, print_fgetxattr, NULL },
 #endif
 #ifdef TARGET_NR_finit_module
 { TARGET_NR_finit_module, "finit_module" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_flistxattr
-{ TARGET_NR_flistxattr, "flistxattr" , NULL, NULL, NULL },
+{ TARGET_NR_flistxattr, "flistxattr" , NULL, print_flistxattr,
+                        print_syscall_ret_listxattr},
 #endif
 #ifdef TARGET_NR_flock
 { TARGET_NR_flock, "flock" , NULL, NULL, NULL },
@@ -233,7 +234,7 @@
 { TARGET_NR_fork, "fork" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_fremovexattr
-{ TARGET_NR_fremovexattr, "fremovexattr" , NULL, NULL, NULL },
+{ TARGET_NR_fremovexattr, "fremovexattr" , NULL, print_fremovexattr, NULL },
 #endif
 #ifdef TARGET_NR_fsetxattr
 { TARGET_NR_fsetxattr, "fsetxattr" , NULL, NULL, NULL },
@@ -396,7 +397,7 @@
 { TARGET_NR_getuid32, "getuid32" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getxattr
-{ TARGET_NR_getxattr, "getxattr" , NULL, NULL, NULL },
+{ TARGET_NR_getxattr, "getxattr" , NULL, print_getxattr, NULL },
 #endif
 #ifdef TARGET_NR_getxgid
 { TARGET_NR_getxgid, "getxgid" , NULL, NULL, NULL },
@@ -480,7 +481,7 @@
 { TARGET_NR_lchown32, "lchown32" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_lgetxattr
-{ TARGET_NR_lgetxattr, "lgetxattr" , NULL, NULL, NULL },
+{ TARGET_NR_lgetxattr, "lgetxattr" , NULL, print_lgetxattr, NULL },
 #endif
 #ifdef TARGET_NR_link
 { TARGET_NR_link, "link" , NULL, print_link, NULL },
@@ -495,10 +496,12 @@
 { TARGET_NR_listen, "listen" , "%s(%d,%d)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_listxattr
-{ TARGET_NR_listxattr, "listxattr" , NULL, NULL, NULL },
+{ TARGET_NR_listxattr, "listxattr" , NULL, print_listxattr,
+                       print_syscall_ret_listxattr},
 #endif
 #ifdef TARGET_NR_llistxattr
-{ TARGET_NR_llistxattr, "llistxattr" , NULL, NULL, NULL },
+{ TARGET_NR_llistxattr, "llistxattr" , NULL, print_llistxattr,
+                        print_syscall_ret_listxattr},
 #endif
 #ifdef TARGET_NR__llseek
 { TARGET_NR__llseek, "_llseek" , NULL, print__llseek, NULL },
@@ -510,7 +513,7 @@
 { TARGET_NR_lookup_dcookie, "lookup_dcookie" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_lremovexattr
-{ TARGET_NR_lremovexattr, "lremovexattr" , NULL, NULL, NULL },
+{ TARGET_NR_lremovexattr, "lremovexattr" , NULL, print_lremovexattr, NULL },
 #endif
 #ifdef TARGET_NR_lseek
 { TARGET_NR_lseek, "lseek" , NULL, NULL, NULL },
@@ -1116,7 +1119,7 @@
 { TARGET_NR_remap_file_pages, "remap_file_pages" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_removexattr
-{ TARGET_NR_removexattr, "removexattr" , NULL, NULL, NULL },
+{ TARGET_NR_removexattr, "removexattr" , NULL, print_removexattr, NULL },
 #endif
 #ifdef TARGET_NR_rename
 { TARGET_NR_rename, "rename" , NULL, print_rename, NULL },
-- 
2.17.1


