Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4529DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A0EE2084C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0EE2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvFTS-0006Kb-A5
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 03:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFRA-0001bR-WC
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:13 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFR9-00024u-7d
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:12 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MyKYE-1knBOq1m4i-00yf6J; Tue, 14 Jul 2020 09:33:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 7/7] linux-user: fix print_syscall_err() when syscall returned
 value is negative
Date: Tue, 14 Jul 2020 09:32:59 +0200
Message-Id: <20200714073259.1464675-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714073259.1464675-1-laurent@vivier.eu>
References: <20200714073259.1464675-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:i7X6BYcI8VIr4p155mf8zFTNYZOhu3NW3k/vGE+dXaC7rxI4vpp
 mAjLw4lW74ZcE5WlGKJVcbtvSvQfOqyh8K93ZB9vFA0dChXUgHo0AHYAeqXuzdFYGC6/voT
 UcOFrShgQ9XZseA+MFgy6LX6gPd+t3ugnqM3GPa9uUU2g10mDPKvNk29wn7QFrsWnXifOLa
 SGYwErTd8q4WhLZcHInaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V4vScfLCSFk=:gFsqR0wAN2YCrssNas5Ok3
 /DGSbQhszeIYThncBLBbdm4RMVA3tECFDrufdyzsF2M0sesczx/WIGn4ozwG0bmeIlbcL2q0u
 M8+xk34A+1BdgJq08GTK/4GnhZZrcnVVFOh0DGQDzA7Hc4LPBRHbxPdNyHt5KunSwxBy8sqEH
 LXIoENAduY5Cl8itzDBm1PZA1HwMIKKFnEftBMhMIw2XPGdoPbJNyWtCU8wtlw97trSxleF75
 254GnRzCiWsJUCpOjdJxpqph+fmaG4U1VQGJfVdYBWK1VJzf0wWyddpNConfXmAZalEw/CgWT
 dx7xDjdQDdu/y5clmZpHd7RTan5Jg2iljWfwgE342hJcPhdXCJM21LeJf6idB/C5w4eIBZEdl
 UqweA7WLTeSMci9Odab/t9m8KMm8IhZw8haQakOgxauxaqrzjxkqPlsXwIwlpeQ3w2SWn6UTK
 PZo0mG20VmPd1fdAU47YvVIXXs+wn06WUbo4PmUsIojPwpBnJTFO+erHaGpR0Z09yZyDNHoQU
 QgRHoYN2sD30e160C2HJ2y8rdtx1bwkX38HGeud0VZSdX/Vv16DnQebEpDHOEY93ni9DzmtNa
 s0VtRsF7SbjnCyzjZlOHIFzPCcooVr+dpaTP/bj3u5NraawdEXJG7lqfDf7nD+ymhnR35jvG2
 IPN0cZjauKwzBb/hFDsDd3i+7N4RqP3ZQP3gqWNjmSEQPXOCZhq5g7wn18UFnb49pmT/bF+ic
 8iEkvxcCSTBPldJ3iXl312mUye1qfyfIdyGjZpuO0SdvASqWxjVH1CM6ixDGrhE/tRm1tWIf1
 O5MS4edFfobiIa/3HGLpYOcLm8UKyzpSp32WUr+7zo4vTIffOoKoVYUieRpHGE5DwnHGMvz
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip.Bozuta@syrmia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

print_syscall_err() relies on the sign of the returned value to know
if it is an errno value or not.

But in some cases the returned value can have the most signicant bit
set without being an errno.

This patch restores previous behaviour that was also checking if
we can decode the errno to validate it.

This patch fixes this kind of problem (qemu-m68k):

  root@sid:/# QEMU_STRACE= ls
  3 brk(NULL) = -1 errno=21473607683 uname(0x407fff8a) = 0

to become:

  root@sid:/# QEMU_STRACE= ls
  3 brk(NULL) = 0x8001e000
  3 uname(0xffffdf8a) = 0

Fixes: c84be71f6854 ("linux-user: Extend strace support to enable argument printing after syscall execution")
Cc: Filip.Bozuta@syrmia.com
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200708152435.706070-3-laurent@vivier.eu>
---
 linux-user/strace.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 7769f53bd5ed..13981341b327 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -724,19 +724,20 @@ print_ipc(const struct syscallname *name,
  * Variants for the return value output function
  */
 
-static void
+static bool
 print_syscall_err(abi_long ret)
 {
-    const char *errstr = NULL;
+    const char *errstr;
 
     qemu_log(" = ");
     if (ret < 0) {
-        qemu_log("-1 errno=%d", (int)-ret);
         errstr = target_strerror(-ret);
         if (errstr) {
-            qemu_log(" (%s)", errstr);
+            qemu_log("-1 errno=%d (%s)", (int)-ret, errstr);
+            return true;
         }
     }
+    return false;
 }
 
 static void
@@ -744,11 +745,10 @@ print_syscall_ret_addr(const struct syscallname *name, abi_long ret,
                        abi_long arg0, abi_long arg1, abi_long arg2,
                        abi_long arg3, abi_long arg4, abi_long arg5)
 {
-    print_syscall_err(ret);
-
-    if (ret >= 0) {
-        qemu_log("0x" TARGET_ABI_FMT_lx "\n", ret);
+    if (!print_syscall_err(ret)) {
+        qemu_log("0x" TARGET_ABI_FMT_lx, ret);
     }
+    qemu_log("\n");
 }
 
 #if 0 /* currently unused */
@@ -765,9 +765,7 @@ print_syscall_ret_newselect(const struct syscallname *name, abi_long ret,
                             abi_long arg0, abi_long arg1, abi_long arg2,
                             abi_long arg3, abi_long arg4, abi_long arg5)
 {
-    print_syscall_err(ret);
-
-    if (ret >= 0) {
+    if (!print_syscall_err(ret)) {
         qemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
         print_fdset(arg0, arg1);
         qemu_log(",");
@@ -796,9 +794,7 @@ print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret,
                            abi_long arg0, abi_long arg1, abi_long arg2,
                            abi_long arg3, abi_long arg4, abi_long arg5)
 {
-    print_syscall_err(ret);
-
-    if (ret >= 0) {
+    if (!print_syscall_err(ret)) {
         qemu_log(TARGET_ABI_FMT_ld, ret);
         switch (ret) {
         case TARGET_TIME_OK:
@@ -833,9 +829,7 @@ print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
                             abi_long arg0, abi_long arg1, abi_long arg2,
                             abi_long arg3, abi_long arg4, abi_long arg5)
 {
-    print_syscall_err(ret);
-
-    if (ret >= 0) {
+    if (!print_syscall_err(ret)) {
         qemu_log(TARGET_ABI_FMT_ld, ret);
         qemu_log(" (list = ");
         if (arg1 != 0) {
@@ -866,9 +860,7 @@ print_syscall_ret_ioctl(const struct syscallname *name, abi_long ret,
                         abi_long arg0, abi_long arg1, abi_long arg2,
                         abi_long arg3, abi_long arg4, abi_long arg5)
 {
-    print_syscall_err(ret);
-
-    if (ret >= 0) {
+    if (!print_syscall_err(ret)) {
         qemu_log(TARGET_ABI_FMT_ld, ret);
 
         const IOCTLEntry *ie;
@@ -3197,9 +3189,7 @@ print_syscall_ret(int num, abi_long ret,
                                   arg1, arg2, arg3,
                                   arg4, arg5, arg6);
             } else {
-                print_syscall_err(ret);
-
-                if (ret >= 0) {
+                if (!print_syscall_err(ret)) {
                     qemu_log(TARGET_ABI_FMT_ld, ret);
                 }
                 qemu_log("\n");
-- 
2.26.2


