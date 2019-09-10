Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D2AC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51756208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51756208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7j9p-0006cx-V2
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j7p-0004Uf-Rn
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j7o-00020T-G4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:17 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59679)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j7o-0001zK-6b
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:16 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M6lUk-1i3sIc16fW-008Mwl; Tue, 10 Sep 2019 18:36:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:51 +0200
Message-Id: <20190910163600.19971-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ELE3NguVAMW9oC7+Roai81gb83Tae7RgDGcbFSQPSxhXLlnKWiF
 WJYSH1vNO7P7AD1L/ej5Jai0Znd3mJrGMUGHcRmI5EC+C6MnmFuf+I4u7Sa7iRkvu3Ql/vW
 ++AnuhJL9FCbNXpSg2SuxNTqmcVbirTbIGtdAd9493Q/mYTawHfBVxQK2pZhsefvaIPiTAP
 9OtOnl6sEZNxnPPmXJ5Ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I2jXH4wke7Q=:D+Mo61yGKXvn+FjM5shYRv
 uYp3Z7bmk4LU0+Yc6qDieIL4yEcMFBDdknmnheWENIbsOc+UKHEneZitCTs9w7j14mnGL1ua2
 hLIHnsbxdTMtBX8F/ssDbGll49i5jGVhYLmVtGtJqx/FiVdKwYsHsh4PzPT2edLx0LaXjTEFy
 o8ATeQQdMJRuzGpHrCDM5myCy6nuKkjIMWt9aOOKyWnBctExqGawWOajNSSvFr4IEn938r2gO
 PR1ghDv7idn0UBtKXggB/JZBkgIP+T9fWEl9UF95fqwbGLVkJ+pcbBCCv9VF3nA2UyppXYthJ
 0TjQq4KKm+qt/lujMI25WbXUGPzs6cha39vVkMMFNi1AA1ROHOvg0TNYO5obPvjz9/X9Q/ojx
 Z+f2srms0TUBAlXcrQB0t8SRwb7hoXquxmlwgzkBYT0u9LE7oc+wMba58bDX+w90dVX672zER
 IWU+ma+cPAdUHzyy9BNINDd6E7Qvlr6ekGbCGbvwY+SBbv0+SI2W9SQL6mVNIyxdaSzdnTc32
 Ytrg2JN+6jEg/Bi/pLgbEXiT6J01Ue1Z5LUFrZlDwdWnNUgsCa9qDzsN9nhHGH6GIhLdn//CO
 e/Xr5Gm5GDzgY31FI2YCLcTfMMB3Ut2uKHLx+W3uS0ZWKCM9BrRelDS4lgfFmhBP7cKvBs9NM
 Stuu2Sfts3LNH9PdRbkOhbvnsPvlogYzhUW/8P2LIP1RW4Ljn02ttYACGX6VmSTo5O2ZCJ5gE
 zp8bctkOJv6JQXna7zZEridIldTFZFQ7KP15KdAbP9p/NFqg0RW57xmIPdWjGhHn+ezo+BuU6
 NpQqFaSNFSZnFN+QwU1VMrntCmMs6GKsTHRvkIml8/5rgopJaY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
Subject: [Qemu-devel] [PULL 06/15] linux-user: Pass CPUState to
 MAX_RESERVED_VA
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Turn the scalar macro into a functional macro.  Move the creation
of the cpu up a bit within main() so that we can pass it to the
invocation of MAX_RESERVED_VA.  Delay the validation of the -R
parameter until MAX_RESERVED_VA is computed.

So far no changes to any of the MAX_RESERVED_VA macros to actually
use the cpu in any way, but ARM will need it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190822185929.16891-2-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/arm/target_cpu.h |  2 +-
 linux-user/main.c           | 43 +++++++++++++++++++++----------------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/linux-user/arm/target_cpu.h b/linux-user/arm/target_cpu.h
index 8a3764919ad9..279ea532d5b7 100644
--- a/linux-user/arm/target_cpu.h
+++ b/linux-user/arm/target_cpu.h
@@ -21,7 +21,7 @@
 
 /* We need to be able to map the commpage.
    See validate_guest_space in linux-user/elfload.c.  */
-#define MAX_RESERVED_VA  0xffff0000ul
+#define MAX_RESERVED_VA(CPU)  0xffff0000ul
 
 static inline void cpu_clone_regs(CPUARMState *env, target_ulong newsp)
 {
diff --git a/linux-user/main.c b/linux-user/main.c
index c257b063dbc1..24cb24f0bf8f 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -77,12 +77,12 @@ int have_guest_base;
       (TARGET_LONG_BITS == 32 || defined(TARGET_ABI32))
 /* There are a number of places where we assign reserved_va to a variable
    of type abi_ulong and expect it to fit.  Avoid the last page.  */
-#   define MAX_RESERVED_VA  (0xfffffffful & TARGET_PAGE_MASK)
+#   define MAX_RESERVED_VA(CPU)  (0xfffffffful & TARGET_PAGE_MASK)
 #  else
-#   define MAX_RESERVED_VA  (1ul << TARGET_VIRT_ADDR_SPACE_BITS)
+#   define MAX_RESERVED_VA(CPU)  (1ul << TARGET_VIRT_ADDR_SPACE_BITS)
 #  endif
 # else
-#  define MAX_RESERVED_VA  0
+#  define MAX_RESERVED_VA(CPU)  0
 # endif
 #endif
 
@@ -356,8 +356,7 @@ static void handle_arg_reserved_va(const char *arg)
         unsigned long unshifted = reserved_va;
         p++;
         reserved_va <<= shift;
-        if (reserved_va >> shift != unshifted
-            || (MAX_RESERVED_VA && reserved_va > MAX_RESERVED_VA)) {
+        if (reserved_va >> shift != unshifted) {
             fprintf(stderr, "Reserved virtual address too big\n");
             exit(EXIT_FAILURE);
         }
@@ -605,6 +604,7 @@ int main(int argc, char **argv, char **envp)
     int i;
     int ret;
     int execfd;
+    unsigned long max_reserved_va;
 
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
@@ -670,24 +670,31 @@ int main(int argc, char **argv, char **envp)
     /* init tcg before creating CPUs and to get qemu_host_page_size */
     tcg_exec_init(0);
 
-    /* Reserving *too* much vm space via mmap can run into problems
-       with rlimits, oom due to page table creation, etc.  We will still try it,
-       if directed by the command-line option, but not by default.  */
-    if (HOST_LONG_BITS == 64 &&
-        TARGET_VIRT_ADDR_SPACE_BITS <= 32 &&
-        reserved_va == 0) {
-        /* reserved_va must be aligned with the host page size
-         * as it is used with mmap()
-         */
-        reserved_va = MAX_RESERVED_VA & qemu_host_page_mask;
-    }
-
     cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
     cpu_reset(cpu);
-
     thread_cpu = cpu;
 
+    /*
+     * Reserving too much vm space via mmap can run into problems
+     * with rlimits, oom due to page table creation, etc.  We will
+     * still try it, if directed by the command-line option, but
+     * not by default.
+     */
+    max_reserved_va = MAX_RESERVED_VA(cpu);
+    if (reserved_va != 0) {
+        if (max_reserved_va && reserved_va > max_reserved_va) {
+            fprintf(stderr, "Reserved virtual address too big\n");
+            exit(EXIT_FAILURE);
+        }
+    } else if (HOST_LONG_BITS == 64 && TARGET_VIRT_ADDR_SPACE_BITS <= 32) {
+        /*
+         * reserved_va must be aligned with the host page size
+         * as it is used with mmap()
+         */
+        reserved_va = max_reserved_va & qemu_host_page_mask;
+    }
+
     if (getenv("QEMU_STRACE")) {
         do_strace = 1;
     }
-- 
2.21.0


