Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55210C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290D420724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290D420724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEEiu-0003P9-86
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jEEVr-0005dR-M0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jEEVp-0000NF-T5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:15 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:56069)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jEEVp-0000HX-Gn
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:52:13 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MGQax-1j4ZSx3NCH-00Gqmf; Tue, 17 Mar 2020 16:52:03 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 25/37] linux-user, x86_64, i386: cleanup TARGET_NR_arch_prctl
Date: Tue, 17 Mar 2020 16:51:04 +0100
Message-Id: <20200317155116.1227513-26-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317155116.1227513-1-laurent@vivier.eu>
References: <20200317155116.1227513-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UV2J3c9ONXZI+qhsoHYbmCHtAoqCls/b6WVyDXjEPxoh0Z7PVD/
 vktFyooV0NjAd6F8Ayu+bV3gOpo3XAHSlZiTV0P4yDzCrI/J0UcIzyXfkNAx0z/F039KbFB
 lzZGrdG7SBtzQqpoed4tnph6ur5bO/HRYFE3cWdJ/rAHpiL0sBcOwnCUAKahJyOJC+sxxdl
 tDxVP7y8nsVOEQTXYIzdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rb1qHjyTgBY=:7OUKMNFQIhJfzF7P1mwBIa
 FRNGQXgkpu6pKDoPMcXOT0B3pKHvLDBd9sy8QeL8BVjI2YOVBotGrYnzFl1w16B+zBZYha372
 fPxIlbRA8fJ0f9o3qOzPAUbZWI4JFXucW2lLsETZnWqHR/PhaRDoYqQvtYg5BctR3wghwOqDY
 Kn0Pr8TKaWFm3ph/ADB34rQT5q65pUvXPwq2sbqIwES16OWx7GQnM5WFciLmLlvlz3qs/7WJK
 BmnsCYnCUvSwH3/hLt1Eimx4SXKNJFPS0Clca8eMGe2qHSd1Au29eSkL56jL9wfb6jQnel10Y
 W9xcEZ5kh4aEhMw1DxbS2986N8oNSlaQbyTMeMWcKK2MVyMh50kms3ysbT+IX+d4sKJEKOEuD
 UJaH1tWW6ddHgWNp+ZIlHoN6cD3P+90B6a9lKi4uuvV445OlvG5lPZMSRjC5zF8gnPRjvtz50
 LUGpxwt2MVciLG5f4/lR12VqLvOUyBCkcV5LRapUuPr6sWVlwqzCJkbufhbNRadnxw8D46O43
 cYN+ab3Oa9/MUelR6Eyp983vXBY93hVzZg8214v6z6lxdV0fkLqG02dq9ITKipUE0Agth55IX
 KaW8WL6PSYARpktKEdt+H5EU9Ke9lbyZfmhgdDYV245oNWuY0N+fiqLunsOO4mAkCPmNSNfDu
 VprEPKE7e9lbrW0vv+a+EohFz8upOXlCPyc1hDmJa0ViBtEvcOljweFICc4oiAsPr5jeL1tm1
 Hfa54CjtC7oVcfwe3puP2ERVt+VOO3577Rr/bKTW11P0pIry1te0gS71rYb77i34r/7JbqKtX
 NTaeLhIxFvKYidFpVUcdRLnEIG2YAfUAELWZbxBf8FDdpwreABCAknZuQBHenXTx9kGuPt1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
index 82bd2439eed5..49395dcea978 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5564,6 +5564,10 @@ static bitmask_transtbl mmap_flags_tbl[] = {
     { 0, 0, 0, 0 }
 };
 
+/*
+ * NOTE: TARGET_ABI32 is defined for TARGET_I386 (but not for TARGET_X86_64)
+ *       TARGET_I386 is defined if TARGET_X86_64 is defined
+ */
 #if defined(TARGET_I386)
 
 /* NOTE: there is really one LDT for all the threads */
@@ -5703,7 +5707,7 @@ static abi_long do_modify_ldt(CPUX86State *env, int func, abi_ulong ptr,
     return ret;
 }
 
-#if defined(TARGET_I386) && defined(TARGET_ABI32)
+#if defined(TARGET_ABI32)
 abi_long do_set_thread_area(CPUX86State *env, abi_ulong ptr)
 {
     uint64_t *gdt_table = g2h(env->gdt.base);
@@ -5835,9 +5839,12 @@ static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
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
@@ -5870,7 +5877,7 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
     }
     return ret;
 }
-#endif
+#endif /* defined(TARGET_ABI32 */
 
 #endif /* defined(TARGET_I386) */
 
@@ -10356,11 +10363,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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


