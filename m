Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07461C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:19:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC8AB21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8AB21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a7J-0007X6-Ug
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j6Z8s-0002aZ-Qa
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:16:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j6Z8r-0001Qv-Km
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:16:50 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:54471)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j6Z8p-0001Ns-1k; Tue, 25 Feb 2020 07:16:47 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N4NHS-1jWf6i1Idq-011SeO; Tue, 25 Feb 2020 13:16:18 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/21] linux-user, x86_64,
 i386: cleanup TARGET_NR_arch_prctl
Date: Tue, 25 Feb 2020 13:15:45 +0100
Message-Id: <20200225121553.2191597-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200225121553.2191597-1-laurent@vivier.eu>
References: <20200225121553.2191597-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wOips7kY7EZ7PgM1CRpaIqyHcIAK6XwRW4wtjLVS/jR6VBgMfXS
 WqaN1eH8pYLP1BbVAvekS4anCagnnhKYzY+gTxpYQZGiWX0Q5ONeuwk+LQBe3Qi41+1etD9
 LGhHXUyH6dp6rU2XRECpm76LSl9DAN8J49ys0QTcDEkC0JInyo6jVS10cksTFUSPhg1q+6x
 4e4oBX5jSwu2S745WQMeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uRUZFT+RYgU=:VO4AD96E/6pHYJUX4b0dAL
 bigfSkt2pl63fPM0zMl47ArSvOOWFvMCKvhoAGEgk/mblhL46L2+E3e3wmwYbyvV8u6MP7vIV
 wwGHMW2QI0FSZ/8k/O9cibs3keEV+RmOgOhXisX9yflBg177Vpp3lRjK6o9hGmsRj0LhiCWd9
 zZvcEiCUy6r8TY24Z+wXVWArBWeReXpqau/9wCbZ0Gb7On1Ev29mwZUsY6Yu69ER/2BBg9aBt
 plCvSnlyb0RYWiyYKBcSpPPkpAESOZ6mhqhd7l84LMF8RQREXz+k0J/TiwwUN/8q9P4k3Uusp
 AswkcgHOVqxLxxbILetFnEdFHd6bQAJn5Ze4S67f8sgorm2F8+2cbHqgebK/uN7qp3/JdMUCj
 YMLUeOfII4oCKpzkNsHHzfbrNqriGAeKLsP4lWI/aY4uqrhklij5KENaa+lKZlST5KCIAZsFq
 KARcIJjXb1zgb3syxvbWb1SLVRiLoHpk1ie85u8ItO9R/qYqgY1+5LSPn9lD6tYWyRbI0HAL6
 fOMuXBgAc0VRk1aePVrYAQ1QZuL9m+4SzvD1E0lmAVq4MFfwrvAlS35sEce2PGpmPp2U2Dt8S
 VLRhXgd004tPODOo+NJC2j2qCiUqa3V9fkzCZ6qLQke4cAfJ32U9medGFc5PCCCrnaVX6cjUP
 ACUf/a4EAO85ykpYGtAkA0OKQ8ynsFObCfSasbmaaSdvrAe6x4F7n6AYHR81oUI1Wpd2PHdPC
 9E3SUGHtYLQfCnQJxDEXRFjn0sgnBkfAx4ra2wpiIuPkZOeMbcuNy2PkHl93Fi+OfMLXB2yLG
 W0joUdD66DG5pF1pXivncFg1fqKq2FBDreSkrAd54b/UAmZTrSEmZZdmZNcS33kB6LuNQ4W
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Cornelia Huck <cohuck@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Define do_arch_prctl() for i386 and x86_64, but return -TARGET_ENOSYS
for i386.

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
index f50a16070815..0eede7620664 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5498,6 +5498,10 @@ static bitmask_transtbl mmap_flags_tbl[] = {
     { 0, 0, 0, 0 }
 };
 
+/*
+ * NOTE: TARGET_ABI32 is defined for TARGET_I386 (but not for TARGET_X86_64)
+ *       TARGET_I386 is defined if TARGET_X86_64 is defined
+ */
 #if defined(TARGET_I386)
 
 /* NOTE: there is really one LDT for all the threads */
@@ -5637,7 +5641,7 @@ static abi_long do_modify_ldt(CPUX86State *env, int func, abi_ulong ptr,
     return ret;
 }
 
-#if defined(TARGET_I386) && defined(TARGET_ABI32)
+#if defined(TARGET_ABI32)
 abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr)
 {
     uint64_t *gdt_table = g2h(env->gdt.base);
@@ -5769,9 +5773,12 @@ static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
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
@@ -5804,7 +5811,7 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
     }
     return ret;
 }
-#endif
+#endif /* defined(TARGET_ABI32 */
 
 #endif /* defined(TARGET_I386) */
 
@@ -10247,11 +10254,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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


