Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0F6C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11DB24649
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11DB24649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcGt-0000PE-Qa
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBcE0-00047b-It
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:35:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBcDy-0008Pf-Lf
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:35:00 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39247)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBcDy-0008Np-C4; Tue, 10 Mar 2020 06:34:58 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M5fZ4-1jHfxO2dR4-007C8t; Tue, 10 Mar 2020 11:34:28 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/21] linux-user, x86_64,
 i386: cleanup TARGET_NR_arch_prctl
Date: Tue, 10 Mar 2020 11:33:55 +0100
Message-Id: <20200310103403.3284090-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310103403.3284090-1-laurent@vivier.eu>
References: <20200310103403.3284090-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JMfjy5/7c3qMzApFbqRpNeFq4CWoeV3+w2FEWoaXZ8qj0FXQylw
 i7I4G04Z6+mzGxbeAfGbAb8pphoyA5YINja2dDKp7fG43gmi0d8mTXjYcZ3dNFXfCHjCtSw
 jjVlRC4F2CRtKlADxo03Q7jlF4UVzNxHZjfmSA4XCITWIEOfbyoAIjI+eoU0m6JaVuQwhEH
 FFWOtaRNz5v7DEhANp+yA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mqwtP1i2yig=:ahBjceFpM/6SCV/MqdwOnM
 h2zE+p31SL5qcCnNAon/NXKNM0yzburLNCos96J2xihFfDxfMy4vcyeRF4QqY0hWIyNGc0MWc
 xH/eZBGQzS11FtRquPkqEF/xqmRBk1iUclISqX3pYAXaXlis5RmWVEKD7+vYnaSKim0DDHyPf
 L7u75hhREtXsPBklHsWMoKIIu85I9khPAI1rnBJPOYm1kDJlViyS1wYpXYx4KZvjtf2Byy7le
 sDgSIkMCxTHs9IS0wO4Lt4FsCdaqKm9CjsAUyO9VWphmybXf7MWnum2xsc2h/Wy4Iw76UMSww
 wwZeTgfXONhp/vDphAsp26DFWC8oqS8u8QhIAbs41KpuiO9AwM9ZffdD0YNYEDw7Z+UOe/jfG
 SaJNyLZYKDXyvP90p7FTwMrZQfk7EhkTPCUlJQdWAHB2u/T6V2NsmzPAKfBr9ggrYuP+wTjVL
 oDMcB6m9B0Yau1OcjygZluNhr0UeXVIC/pGxqEjJKd19DfLW55iKGgNg0zCYTx8W089+IAnGj
 o6Xlrvo5OzsXl81FkXptA6fJDpyusJ1eoizU5TakrLXTXbUXYPT4RzEfxU2dbluCT0OOnDct7
 dAjDbtVEqT0a4gMzKpsQnHj8wZA7eHu9MfeuGkenCaGlq5qZeKUkmzvcEkmhW/RUnkDbRf7ux
 9TDQHL/sTQz0yPEw596qPuw+f9b6iJRJiUkUIyEOux2SPmHuN1IqMgT+TcgL70S00rB4ND2ZV
 vYYt+D/25QsxS7RxalHbRs5eNpWGzNCtBbkg2V/AACjvD34imCswsJ9mThpnl0ruO3cIFB1nw
 eId4VIt+L3LpvuVELo2NwfKZN+JpqWxsdrXo92EoYD2qcNPNNWHsFAYMZY8dnWbkMcbjRFZ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Define do_arch_prctl() for i386 and x86_64, but return -TARGET_ENOSYS
for i386.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
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


