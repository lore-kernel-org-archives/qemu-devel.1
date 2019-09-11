Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2255DECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:05:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93BD222BF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93BD222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7whM-0005bl-Id
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7wRh-00064k-BS
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7wRf-0004OM-V1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:41 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58283)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7wRf-0004NS-LU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:39 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWRi7-1hbqgV2OPT-00XrjM; Wed, 11 Sep 2019 08:49:28 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 08:49:11 +0200
Message-Id: <20190911064920.1718-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911064920.1718-1-laurent@vivier.eu>
References: <20190911064920.1718-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lfv5mfUSpaYqspHFKcdASL7d5yzUy8SzbylCwkjxEMMQX0pt1dN
 WQW6rI2nCkDkFAiWvSAPysNHfX2PU7Qe45U9dcp47ivUYgEMkwinEnwH99BvjT+2FN6x5kJ
 HaKMksge0wZnCFb+vZSykuR1OZY6z5CuLtFggw1Ke6bMb6qpOTIhyxz5W2PPC3yJIM708ma
 VYO0f0UNibC2KBd6NNcVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6e6TxgXutMw=:kbGnVGt81wm7jYxVXxAjbh
 7zacYdDUQwMER/eSkAFZ7VNjWIMmi+wGzqcje5pVnhK2rj8gUuZbAhoPttcvXgkEOo+J8sJE1
 WdgKjXPq1RKCbLiZVg96TuWPa7eMCOZvjwbuEmKEVF8e+OhgQrfkUbeCLr4G2qaYGRVCEqFel
 LEh2aNkZ29T5TZN7Hub7v9Fccc7ULVpsTQzJfQ+xyUf7qpQ2ZN7/VVeFbSZrLNt6mrbTP4JkC
 yoE6BIWIiiGhzV3cBEl0K220Pusr8G4t8YF7/KGrNA8vhwFRfp7YxrXB4yG6Y63yMZtdBmtoU
 5wmLHH4z1cctgqc6Y5WzGQwFtuKksqXFQDMTap0vxjejt5jz1bpSpUQfBZqccx7sqRVAhT733
 ti/jwr0kBlH8r+Dc6KmVBBHEXly5tnawsq1qCvDPDOsQjx3Mg0eJThzuqfcj5nzzW9dzJjo1X
 J3ATpSbz077Ar5Ei4O6uPp41DgCd0BLZHSEogvxlJGiVp7+cZu3z/j2hx25zbEOZnLxemXXFs
 RTVqXDXNmMy/KuJWXxpv7Amlru0+yw8iwLHNvjK2qf6GB3ywkVHs5uYFhzL4sPbEuBgz5WeW1
 IyYFbxqoyEBor0G9ifZwrzpNqiyD2qvGFI+lVDXfXBk7o37d/rIm2deRMwWhCJLdCRffkSKwT
 lc3Ah5xDpopr2uurllzxPgEeyOznIEjuAAebtMg1SGTF8R4I/VcBnIZFVwQ8yLQvK5Ypz3j2l
 q4p/D2Uw2t4tfyCSc7ICKxdvE7Q9C6EuLPl6i+73HRLph6nnhZsFQp2sIL7HWYRNcRypNHVre
 i2VCQ2+JH7GTn4ec9/E6R9Bf1CUS9tghIMCopx3IF+Lrf8IxtE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL v2 06/15] linux-user: Pass CPUState to
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


