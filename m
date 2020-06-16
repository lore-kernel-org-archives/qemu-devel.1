Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4050C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B9D20767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="uTWFtr7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B9D20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl91S-0008T1-TX
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90Q-0006sv-Gu
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:50 -0400
Received: from mail-db8eur05on2113.outbound.protection.outlook.com
 ([40.107.20.113]:30304 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jl90O-0002xB-FT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:39:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WevISPDYCYYgtnVMGGyskzSo4ZA71RK9+BD7MtrUNiXbUPyl0bN6tVanSadPKN+pdoiWwrE8i/dm/sfdrw/l0Lcc7AuYPSD3Lm5ONxTWdDY3jcVRqPYx+IhXRnpLWEOO1SjBEO8Rn6H7Q5bJz3nmbq7eK1LRglcg1GAu8Dc9BjI3kM1GkB8uNnlZ3wGwqiGOb1XsHp4oJ2kMyXRvwKr/SYl+6z085pRd1+9ePF76mv1Z3f/MOU/WfnqpAR5/UZcdH+UwoGG6lNmxuUo7iKXRnRd0uhbS37e9ntPGJ6jNc3NRu3DfF2TUXGoay6fdxsrIzTTVZl8Tt/9/RGAUm7nm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPSdFXYJawze262J22eUdv5iOsyYwSDNBoSHgHQQfY4=;
 b=X0gpAsGPZFP2HHO0kFawH+NG3wgmG6x73TTXjgHv6GM22lSOyv7fRvFAahhc2L4LdvwuJsw6iARXhdNCd7nwUrJyiPcb8TrYC3dBaVsbE9z8EPjjt+cnwoRLnvik5cLi3ZzCBD2VIFedqfUGZM/KADDXJBTce0X2r0sRRJxO94OeVQcVMoXpJrfK79Ai5OkiXz9tX7NJUYLSiu94/Tt6fHk6dh0ZuNm1G2K5ZO+gPgp4vR3h6jP65jUIR0SMXbh93Z4ROSnStZLZnJQ2dnciq/pX4fEHokRiUbbXEuhEk2c2dLsFdtG/SSAkWwP+h2rSqWfQzANs4KiTxxMWTmtxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPSdFXYJawze262J22eUdv5iOsyYwSDNBoSHgHQQfY4=;
 b=uTWFtr7QL/+oLmMqAJscGo2YIB6Gw8oGtcBZ6Q4rXN/J1EVpQZT8w98cWKTUEpm+T1zSDJY4g+Zt76Rkymf7t52UBPs6Gwt4LKPQ1ooiQLQ/zdgSnBFIohJgt/bCaVVvAu84eVFoaaoeAYjCqeZ1LM6hWp36fsWTUmor8BlqjQQ=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB3960.eurprd03.prod.outlook.com (2603:10a6:20b:25::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Tue, 16 Jun
 2020 10:39:42 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 10:39:42 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/6] linux-user: Add strace support for printing argument
 of syscalls used for extended attributes
Date: Tue, 16 Jun 2020 12:39:24 +0200
Message-Id: <20200616103927.20222-4-filip.bozuta@syrmia.com>
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
 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 10:39:42 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54c2633a-8de9-42bf-247b-08d811e1941a
X-MS-TrafficTypeDiagnostic: AM6PR03MB3960:
X-Microsoft-Antispam-PRVS: <AM6PR03MB3960565A700FC54E9D32EB43EB9D0@AM6PR03MB3960.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVsXblJbPtm/KDr5N552Q/u82Qt+J5AEDItQsdLhWss55GIgiuwMFJQWvte0ko9qaf9CzCm61Kh20itLobHP2l3O2ZyS9yiXuzEySYTmDtiASEvxP1WKVBvgxhBYhd+fjFdkcS6jz3vMNUSnDZp4PKSkEf3jRTkCVURreekQrHiwZMzhMOaygYHpJcrvwIHwBRiU0V6YbT1Twg3OL7l8KqRYowDLxoxpIjOwW6jSFegpyCCeT/0FN/sPVsNEMi6Y/RibB7DX1aNdFNkbvF8XZiDS7a5SAlXDSrkj3F3ltgRKkHrtbd8Wpnz2yb9hTsuUamQDCLZ6N/qLpE8EHhcaOGO2EdrJ3han3HLQgPuSgnP7R3XKAyp7z43pBd+B2G0+X51bvUz6/nAc/E/NzU2EbHzA3/DIrbX3eNelS3UIrJ16Ux0TXzigmMf1OqYBI32xMPwBuJKUOawqK+AQW8WeuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(346002)(366004)(376002)(39830400003)(136003)(966005)(5660300002)(83380400001)(86362001)(508600001)(8936002)(316002)(6666004)(66476007)(6916009)(7696005)(36756003)(2616005)(52116002)(66946007)(66556008)(956004)(44832011)(26005)(1076003)(2906002)(4326008)(16526019)(6486002)(186003)(8676002)(334744003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: syla03kK0gcyMMy2k4m04HNPJ5yVV4r6BrZt7jL6UjJxXuLz3Mv8kyAoTuUyQIC0RjOKK9IM4y+xapi+TT+x3cVtsVyfn/EGL4Mw6Ox+dTUamAGj+glbH/xwKy3I6cNAazk/yNvQD2tbtjOBTUe+hsoRVsyMs3PxYpIPtfBqtJ37qm4JKhcxbO+jwiKmUU9YJHXDDT1IM1NsfGmG33/mFaThrL5CtatYq3vxMylNUUJy35ySi/J1T+z9g0dccHRmrUHNkrX0Zggsr3W/EafaglVQ/OPk6oUJulFcKxFy+OauHWW1Kgbl3tE+xQqAH64skj1c+G7NMAMJ7vxzq6w8ketNb8ZDFu2FqnffMjzyQJcC/zEZQ9z82I8QYjjUDonx3F+meBO2fP+17BdwGPFUNuy+uUnFuDCCHn3nWD1oS+DgyCgKHnwhX4IIL2HK1LMK5FPVCKDpAjyhPNZ8KbKG5n5zpTW1Osb+JdpktuLzvj4=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c2633a-8de9-42bf-247b-08d811e1941a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 10:39:42.4419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YmKb1KdEL+mBkQFePh+RUNfyZRgIjqgcRW37c2r0G3hPLfheBwipyL+ef7O4WHvWycxfa3u5Q+ch23pJ9sYJQ==
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
    of extended attributes for syscalls "print_listxattr(), print_llistxattr() and
    print_flistxattr()".

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 linux-user/strace.c    | 122 +++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  21 ++++---
 2 files changed, 134 insertions(+), 9 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 6d7accaa4c..f76bbbc1ff 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -833,6 +833,41 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
 }
 #endif
 
+#if defined(TARGET_NR_listxattr) || defined(TARGET_NR_llistxattr) \
+ || defined(TARGGET_NR_flistxattr)
+static void
+print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
+                            abi_long arg0, abi_long arg1, abi_long arg2,
+                            abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_err(ret);
+
+    if (ret >= 0) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+        qemu_log(" (list = ");
+        if (arg1 != 0) {
+            abi_long bts_printed = 0;
+            abi_long attr = arg1;
+            while (bts_printed < ret) {
+                if (attr != arg1) {
+                    qemu_log(",");
+                }
+                print_string(attr, 1);
+                bts_printed += target_strlen(attr) + 1;
+                attr += target_strlen(attr) + 1;
+            }
+        } else {
+            qemu_log("NULL");
+        }
+        qemu_log(")");
+    }
+
+    qemu_log("\n");
+}
+#define print_syscall_ret_llistxattr     print_syscall_ret_listxattr
+#define print_syscall_ret_flistxattr     print_syscall_ret_listxattr
+#endif
+
 UNUSED static struct flags access_flags[] = {
     FLAG_GENERIC(F_OK),
     FLAG_GENERIC(R_OK),
@@ -1640,6 +1675,93 @@ print_fcntl(const struct syscallname *name,
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
index fb9799e7e6..af12b23276 100644
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
+                        print_syscall_ret_flistxattr},
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
+                        print_syscall_ret_llistxattr},
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


