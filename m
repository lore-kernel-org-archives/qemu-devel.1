Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CB7C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3976520663
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3976520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJaQ-00068G-DO
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jFJW0-000687-D3
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jFJVz-00082K-0c
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:52 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:39877)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jFJVy-00080Y-Mr
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:24:50 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MQeDw-1isiiX0QGE-00NjvY; Fri, 20 Mar 2020 16:24:47 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v4 20/32] linux-user, x86_64, i386: cleanup TARGET_NR_arch_prctl
Date: Fri, 20 Mar 2020 16:23:56 +0100
Message-Id: <20200320152408.182899-21-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320152408.182899-1-laurent@vivier.eu>
References: <20200320152408.182899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+C6uEqU2w1UdeG4fbJ7pme0Ur5x6y4qSIHoxtdkRzO3NVro3UnE
 9yq/TI37EBMu6K3zIfJxJYQgic+WOhH6YT4KQ01tr7rL8MZ9YEE/1SyjvcRV+erPI3nC4gM
 sdM1W7xPwxM0hC1S0he3kJuQxdcTPkhHSFNL+URLqJ/NrgT1024tsZH2XrwKqt0u/qVRlg0
 Wc8ovWsysc7kOBDhxcw5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bUOk0p1EwBE=:XNSUbTQRAJlEUEqkFESpc2
 bJS9RtZx30a39V5NaqbY5EQ/OkjNsF0HAYMRX4/gUoLM9Wf839tEfY6aoulVq8Y8iHFu1OVJj
 MG6fAdMSUhAYE858TPOnvH9bB7rfGsNZ4oG8Ytmkmaf5DST1LtrBTjxjoqXskol7SEhbLAGbh
 lyv1vigfzGbX+eLs+Xap6aLFfylG/QbRwYmOQTOByqnF3iCN7QCxe2UrJGUjsdY0As2rWH9aZ
 63KAPDIXVuLJgDMPCEMFKvYl5fFgkADGmG2M9+3zheqkBGV7lvKTxWEj+BLNFnUvYgniOrBKy
 I/ueuT1RCKFtYnxCFpItIo2ea8Gwa9iaTWE7WEtrVOJUnKiC2wL9Hkvylf2ySV0s83nkK7ES5
 MW1wIOn+9+k509lJuRMRsqkCcLB0RL3H445rWTswq7sE4pCbObRDmtQUYhiqwDAAIGw3sL1G2
 lyOo+mIMLukGhFLrOUVwchZi/nGePDLLD5UJX+GOT5K/3tEuq9YegxO3S6XJp7dfy/Il8ej8L
 VfTHuPA1YqYwF19ZeT3oMxsaioBcutFkFIx5XQ4u5RJ73NeMA1qLhN2PJt5pqt+Ay1rlFoImF
 9A4VFYCO16Vkf5CkQMjqgqsd3xYL1fbC9I+V156esUOIX/2DcRt8tfgYjHv6yCpOvtkUmaEsK
 NXqbAq7nKUizs10q1mTdnRAOlQLhcFEwocb8dvu34xPxsbpShvSTf7A3FJgPj7OlgdJUGXpym
 RHHTnnqizep6pxeCa8uvZsBumqlmDxQQ9Uiew6RNzfyT1JHmM2dM9+MH3rZiuJGIvtkBlm0vt
 fj4AwXzcrVwfp18Sb5I+hboNrqyynEm6H6U1+cvLdVmjr3QsmDG4gB6SxCkazq10diBCuz4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
index 61078342f750..35f414666243 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5545,6 +5545,10 @@ static bitmask_transtbl mmap_flags_tbl[] = {
     { 0, 0, 0, 0 }
 };
 
+/*
+ * NOTE: TARGET_ABI32 is defined for TARGET_I386 (but not for TARGET_X86_64)
+ *       TARGET_I386 is defined if TARGET_X86_64 is defined
+ */
 #if defined(TARGET_I386)
 
 /* NOTE: there is really one LDT for all the threads */
@@ -5684,7 +5688,7 @@ static abi_long do_modify_ldt(CPUX86State *env, int func, abi_ulong ptr,
     return ret;
 }
 
-#if defined(TARGET_I386) && defined(TARGET_ABI32)
+#if defined(TARGET_ABI32)
 abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr)
 {
     uint64_t *gdt_table = g2h(env->gdt.base);
@@ -5816,9 +5820,12 @@ static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
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
@@ -5851,7 +5858,7 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
     }
     return ret;
 }
-#endif
+#endif /* defined(TARGET_ABI32 */
 
 #endif /* defined(TARGET_I386) */
 
@@ -10321,11 +10328,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
2.25.1


