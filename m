Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5CBC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D257D20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 17:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D257D20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDu0p-00008C-1m
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 13:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDsQ3-00082W-Ke
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDsQ2-0003k1-CR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:47 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44505)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jDsQ2-0003bX-3q
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 12:16:46 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYLqs-1irNRp2ajC-00VSyz; Mon, 16 Mar 2020 17:16:36 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 26/38] linux-user, x86_64, i386: cleanup TARGET_NR_arch_prctl
Date: Mon, 16 Mar 2020 17:15:38 +0100
Message-Id: <20200316161550.336150-27-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316161550.336150-1-laurent@vivier.eu>
References: <20200316161550.336150-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2e1LEU8NmWsxmrlJuB31fljc0K8RgFBoRFEgPwf+JkC9PioU/to
 ULEysUb0jjTHvqAgDPU3TtN6hlroO9LLXW+Mmwhu1WFxPBEchcbeXlXRoVUSXxWoY9T6il1
 d70mk5MwFQxMnDtLOl5N9/Ea2SI9FvrXaAuIfHjQp5izEWD1rS/sJkOS3MqN/BBOY//3mLS
 IQ9ZKdD1YOA6VfbPmysYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LD5JbMdsiT0=:hX2jHkTTsYmqSm+xuDgv7N
 exJYfWXwgUcUgKb+UKr0wvwuTTKX8soIk4ZbOX1Xk7O8jEhgihEPIpmCsuwYgFHcctcHBoRow
 BFn2GH8iBBPoMoZYqONGLuffFwx64nXENaVpzbFuGSRfTSsFlLVu3c5u0MU04L7FwQUnmtArC
 OYW0JQtTI/H8YUnoAWBufCYO+uH56fjnUyuMyHXsj2eF7bqJt1ixIV6qnnqIDJGt5ID/zChL7
 FRzT1JLXo3SUTtu/2xcYlEN7AiAUFI/RV2YY/k4/5acXnBYOfhajnMzA5sSz7qwGo0DJM1TfF
 xYN0J8ZJBlUjscvmgjZ4cGJDCd8Y+6hmBeW8A73uzX1O1EI3gqYYq0rAN/55l+A7t76kl8Ri1
 Zc/CJqVIWcIIfq6vBWUJVs2ScytiXOZPhmNOhACwn2h2rsnkgRLtDnJamz9gSkxRG6FO0WQyx
 t0IfrHehLgFb0KkLVyYXSYTGlRNhNMBhbX6191R407fO2Qoq7Nzc54EXbuWU9UADoiMr6JJnh
 UTbd1vOPrSlnNl/EKkLqfYPIhW2WM7GRZlXEtfl3mj1nc3tEAvatDgdpsxI8eYKnML1ziVMrm
 IV/o4SMAToiGn/tAvWeWa0dth91qI5JjtHhjpUtO2l9DgmMp0Q0gukJBJRIc/dvsH8FaoMe+R
 9oECzDsLwllPBBFH3rULHmMulgqF7v7LTic1nZSRw94GokcFyg9RhX4X+DLj9cCZbiLEAfLwd
 5l/n056R0QXquXATtgXM2jaqq48tX0xC1hWGlVpwtEUiK0KhMq8YJXwE2ipvGikzz0dtIU4/9
 /j5hbmxURhEqboTuUD3FPbDWge2Um1mIU/ATLqctR1wNdbVeeBYn/Q0c/ezEoePoIlKlXb7
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: Taylor Simpson <tsimpson@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Define do_arch_prctl() for i386 and x86_64, but return -TARGET_ENOSYS
for i386.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Message-Id: <20200310103403.3284090-14-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/i386/target_cpu.h |  4 ++--
 linux-user/syscall.c         | 19 +++++++++++--------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/linux-user/i386/target_cpu.h b/linux-user/i386/target_cpu.h
index 0b44530854c8..2207d24c2eb0 100644
--- a/linux-user/i386/target_cpu.h
+++ b/linux-user/i386/target_cpu.h
@@ -33,6 +33,8 @@ static inline void cpu_clone_regs_parent(CPUX86State *env, unsigned flags)
 {
 }
 
+abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr);
+
 #if defined(TARGET_ABI32)
 abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr);
 
@@ -42,8 +44,6 @@ static inline void cpu_set_tls(CPUX86State *env, target_ulong newtls)
     cpu_x86_load_seg(env, R_GS, env->segs[R_GS].selector);
 }
 #else
-abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr);
-
 static inline void cpu_set_tls(CPUX86State *env, target_ulong newtls)
 {
     do_arch_prctl(env, TARGET_ARCH_SET_FS, newtls);
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 36bb9dab0bf1..107958f7168d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5577,6 +5577,10 @@ static bitmask_transtbl mmap_flags_tbl[] = {
     { 0, 0, 0, 0 }
 };
 
+/*
+ * NOTE: TARGET_ABI32 is defined for TARGET_I386 (but not for TARGET_X86_64)
+ *       TARGET_I386 is defined if TARGET_X86_64 is defined
+ */
 #if defined(TARGET_I386)
 
 /* NOTE: there is really one LDT for all the threads */
@@ -5716,7 +5720,7 @@ static abi_long do_modify_ldt(CPUX86State *env, int func, abi_ulong ptr,
     return ret;
 }
 
-#if defined(TARGET_I386) && defined(TARGET_ABI32)
+#if defined(TARGET_ABI32)
 abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr)
 {
     uint64_t *gdt_table = g2h(env->gdt.base);
@@ -5848,9 +5852,12 @@ static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
     unlock_user_struct(target_ldt_info, ptr, 1);
     return 0;
 }
-#endif /* TARGET_I386 && TARGET_ABI32 */
 
-#ifndef TARGET_ABI32
+abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
+{
+    return -ENOSYS;
+}
+#else
 abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 {
     abi_long ret = 0;
@@ -5883,7 +5890,7 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
     }
     return ret;
 }
-#endif
+#endif /* defined(TARGET_ABI32 */
 
 #endif /* defined(TARGET_I386) */
 
@@ -10468,11 +10475,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         break;
 #ifdef TARGET_NR_arch_prctl
     case TARGET_NR_arch_prctl:
-#if defined(TARGET_I386) && !defined(TARGET_ABI32)
         return do_arch_prctl(cpu_env, arg1, arg2);
-#else
-#error unreachable
-#endif
 #endif
 #ifdef TARGET_NR_pread64
     case TARGET_NR_pread64:
-- 
2.24.1


