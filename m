Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2775CC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD7E2206B6
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD7E2206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrl0c-0007iO-4o
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzN-0005EX-Ly
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:05 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzK-0002OY-Jh
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:05 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MA7Om-1k3GWL0UJO-00BcSB; Sat, 04 Jul 2020 18:25:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/12] linux-user: Add strace support for printing argument of
 syscalls used for extended attributes
Date: Sat,  4 Jul 2020 18:25:39 +0200
Message-Id: <20200704162545.311133-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704162545.311133-1-laurent@vivier.eu>
References: <20200704162545.311133-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:82muBEwMrNmJCSZMC3XvJ8SAEMCgKosfzRESzkdgt0Vrub/Jcqo
 Ioxw6of/zCi9fo8YFCn4AnDn9jCvuaIkF5SwAEiTwRyW/6Inms73GUPX6X/rArHuz9FbWTw
 UFsR8vKg6EiZewY4Dy0lRE2Mh50tMdiXGSCrXE0uvVuluseqZMWLNxbrR1ZUko/D3HRibMh
 5GI2MWYX18LASqEFE0pIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F8DhPqyMl9k=:fTcAPaB8uKY1mbCPUH6Xtk
 FvQrdgDwpKygZRz2dDup6N1QxH13GpBoB/b8w3Nufy61JPfLF2VE+07leMrgcFVUJkjz9Zt6b
 hg/vbkE6EV4XQqKayqQKMpaOKsf/DlC1R/Ry4MJA6H7/xggK0A66VIzToIv3Ku8eyF5MmvcsZ
 rgAHVkMQQBVkuTQfyHKVMUCd9Icbh3Yv8cEZ1eWHflReHT2gj1LcLH63aD9M6pH2upQM6RByg
 +wvlG/gWueAz1sVQCRDc9Gqlf75d2PkB3XsIzI+5B+ejF7WFZdg1yBXpKBgA2no8tT6Eu7pPo
 5V8jjLMPQuAU+VdELdGE97besF2nJz657MqwKaRBOVcAT4LHtC+sk/CvVrD1Kdcs9RTV16Lez
 +2q3rePvS1FpDP+bBWCPNG+7YIm6yZfd1uDpiMqgOiDl/17xx4NJOoKAtGnpcDUu6bQ1o73HF
 CKmxUFabKM9wJBHJWQuaQeiDMZrC/S1VAPOZVCElC2ZJmnEfdkRGKQptmbS08fLgwuJRgn2kg
 QsLakQjl2kLCkKiVNMb9CLv2bud/eXOR7WzHtSw41pjWB1KZ6Nh22dYSDACCFLru3n6L63qMa
 11mi9Y1oxOh6jBz3yz+nvtEovhKozHKfAtiavZulMU7/AzP9Umzy8Qdj37QcP2RW+rI60FvL2
 kE9C+vyA1g/IJKsULr5Pg65jFySJg6uxYFJX6odIM2ez0bc3Mdby445unlKadWYBkYDkg464Z
 KoDxFp3GEclk7IQ+HVqRBWP7eqZGTXJlDcFM+fBg1wFswdK0HYRt0WyS4pG/GY0I91yzLwKAE
 Kv+9RKeo6eP+qhj4GIuL1MeqHuaeFF2KaWAO58SUoxkYDkAJDw=
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 12:26:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
Cc: Filip Bozuta <Filip.Bozuta@syrmia.com>, Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200619123331.17387-4-filip.bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 121 +++++++++++++++++++++++++++++++++++++++++
 linux-user/strace.list |  21 ++++---
 2 files changed, 133 insertions(+), 9 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 123e022c35bf..760020132b5a 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -826,6 +826,40 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
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
+            abi_long attr = arg1;
+            while (ret) {
+                if (attr != arg1) {
+                    qemu_log(",");
+                }
+                print_string(attr, 1);
+                ret -= target_strlen(attr) + 1;
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
@@ -1633,6 +1667,93 @@ print_fcntl(const struct syscallname *name,
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
index 8a887fc16dcc..d04ad507b0fb 100644
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
2.26.2


