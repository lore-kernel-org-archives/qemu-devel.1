Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A66C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F61E206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="w4PXkvJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F61E206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPVb-0005uh-Ov
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 11:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPUP-0004WW-3q
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:51:37 -0400
Received: from mail-eopbgr60103.outbound.protection.outlook.com
 ([40.107.6.103]:37760 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jjPUL-0005xt-Rm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:51:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOd1z1mxykVk1NmozrTX88B4KrHpAdR0HQ3oRudQkCKqFvXp80BB3mRhSs0nhXXzh2tJBGTwRbEpHRiF6ENllvycv5DAWJXlQde0j+GHSQe9q28SUussGp3qQeeO9kywmi8A7nuWoD4Pa2kEdsghk1YPjYzWTm9Iar0b8RyLFtCVRlMOr+qKPz1TSDTplTSOwjQZKPAZYJWiGBRWZSz62e0dScurWSmEFxsll/tNqUfQ+YQ7X2EfXh73p7jj7g0lOCfINL2ZoYEJDiFmvcscB51Am6UUbfnJusMPmI2+zEeVHhXrtrWlA3FuIPxx9do6mp/gCerddVu64PS8hjAQLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+un8hhiFpIgar7A2Cao7PdGEtRafIILDYCD1LiPvL0=;
 b=gVLG1ic2wm75fvMN2basRq9GdWthbyMnEhhYSgLn54EK1AJf1hgc4qhd/yGSEKZmvdQdtjiDf/DszZOmWSXJ0/tCIVF89JXtznIFWTRhJ3WJGcS/ttDuUr5oBhXL4dd/28/lHzqoBaa/62McCZBotTsY3IvhlSwakDQ7DBLC46y/3AHFjRJno9+nOhca8oFaWSWDNhY0rPcKnpyfSgbofYziCXI+zthXhKpEpBFZa0FdvGfBkjQoOGnuwtGH0eHUGrNokAtjnlIsJPnHNPlWZD7L/UZ9Z7jZ/vCJrVfVX5QUcZq3J2y3cqNYoguDidYQb1opEDHUHoJVTLYSlgV0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+un8hhiFpIgar7A2Cao7PdGEtRafIILDYCD1LiPvL0=;
 b=w4PXkvJwp50N7d0Ai+z4fciSrotq+9p+HGpPiuHZIw4qwmgzUuQqsqx3hc1VSKDVDRgOWCH4vXUmdn7/twTOyxgbdyd51Gzv1tWsrWgkuaSrYzkfxN0fYyHtycZX04OKEhGF/avQxKow9DH/hcQoORXKXdmZXVDCAD5z+wfhW30=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR03MB6008.eurprd03.prod.outlook.com (2603:10a6:20b:ed::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Thu, 11 Jun
 2020 15:51:24 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 15:51:24 +0000
From: Filip Bozuta <filip.bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/6] linux-user: Add strace support for printing argument
 of syscalls used for extended attributes
Date: Thu, 11 Jun 2020 17:51:06 +0200
Message-Id: <20200611155109.3648-4-filip.bozuta@syrmia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611155109.3648-1-filip.bozuta@syrmia.com>
References: <20200611155109.3648-1-filip.bozuta@syrmia.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::18) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bozuta-ubuntu-18.syrmia.com (46.240.135.226) by
 ZR0P278CA0031.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.21 via Frontend Transport; Thu, 11 Jun 2020 15:51:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [46.240.135.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c3a458e-e980-42f8-4681-08d80e1f4b07
X-MS-TrafficTypeDiagnostic: AM6PR03MB6008:
X-Microsoft-Antispam-PRVS: <AM6PR03MB600815390BE44019F1F5AF72EB800@AM6PR03MB6008.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 0431F981D8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwTRdjGuSm4xzO8P35aOIe+jQb4Je8JpWOPXsEEUMpA/PTQ0h7qUuYQhAwRbPp8vjZZ4C0Ew7tmnACt4XE2rrHFTcjw/eOhY2lcoXydCKSeo4uo+30fXaiEY+XmV9RO7me6QuX8xVPhcYw16Khd+HCRcL9sH//J5DCssyYzHkh7ZGDyf8ubbfHVzj+KQtr9Iv2OjOTA2jek57mCKUymXn0Rcge6QqgeDGgZx2nL5gNHjOm17jOSVEjO82upibaXwhRdiMyDXDABoCfH48453INc//gfar/bkXLWmVV3AoMJ+OnIcdlHT7JFTo9Nzg4Hyjzo3XCqgdo/ltghj1faBBM0m0I1i8N4oATQ9Yd50b/E7Ye8casGkZ7+KONFmks+oF3oafPdSpvIfUcNZ2RTvtUehMpP/YSxMzXTqnobD1B7hbgRVShsky9TcLG8FWAUS78deJopo8nJ4ZlgqQPBQJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(366004)(376002)(346002)(136003)(39830400003)(396003)(508600001)(7696005)(966005)(52116002)(316002)(83380400001)(8936002)(8676002)(956004)(2906002)(6916009)(6486002)(2616005)(4326008)(36756003)(186003)(44832011)(6666004)(16526019)(5660300002)(1076003)(86362001)(66556008)(66476007)(66946007)(26005)(334744003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: WY+77hDnLNy17psNW4HAX9tJhMPLvERfRkPv5IqStWFIfZU5RCc8J7E8qrwZp7Qd8i1V24z2i0LlHWm1eb/dvQz8yZK4T+sSvAPOuwpy921XXvGOlJQnMUogZF5lzINzX7LDgURimd6eeJMJxVqFqAxXgPdGfpasQVbRLNvP9rkYMbSCFAhZ8ttzrwuVCUFAoz+l1MrPQKdOymyZd8jkj4VUcY1HQBG0oWYm3lruzY1mtviyFSuiVZYErG1OCxrx+aHZXpb/FXANjbGWyC43BpwPU1qNBdT3gfRHSayJJ6Pk335DaF76Xl1HoMnstzQ1WB0rZhAO+Pto1uMuo8/WPCJqfuBVvtPYHghauvFpLEC5wRs6+QeGFikzq05EAzCJz6Efv5f0Qkigkq95MgP37S39QPU8pr6lSydUKOurBsz3HLMl3QFoVPKTLeCOSXjR6guEvjHf4OmOIx6X8Izw73ZB6YRfaUckr9RvNExEMzc=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3a458e-e980-42f8-4681-08d80e1f4b07
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2020 15:51:24.0197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oi1Vx880sPRvxluoIF/Us1+U7/RijebFTFXfzMxu0/5RObrRVna8fWoBId2CnMABknBbsayGm2p9y60S/f8TOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB6008
Received-SPF: pass client-ip=40.107.6.103;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 11:51:27
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
 linux-user/strace.c    | 95 ++++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list | 15 ++++---
 2 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 4f85606c19..a7c3ea8df3 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -834,6 +834,41 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
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
+    SYSCALL_RET_ERR(ret, errstr);
+
+    if (ret >= 0) {
+        qemu_log(TARGET_ABI_FMT_ld, ret);
+        qemu_log(" (list = ");
+        if (arg1 != 0) {
+            abi_long attr = arg1;
+            while (target_strlen(attr) != 0) {
+                if (attr != arg1) {
+                    qemu_log(",");
+                }
+                print_string(attr, 1);
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
@@ -1641,6 +1676,66 @@ print_fcntl(const struct syscallname *name,
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
 #ifdef TARGET_NR_futimesat
 static void
 print_futimesat(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index fb9799e7e6..35c66e9fc8 100644
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
-- 
2.17.1


