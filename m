Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0CDC04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D811420815
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 02:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rVXpXX3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D811420815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40208 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRSvm-0004f4-5T
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 22:49:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSn8-0005yf-H0
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRSn2-0002Ip-VX
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:10 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:32787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRSmw-0002EU-Mf
	for qemu-devel@nongnu.org; Thu, 16 May 2019 22:40:04 -0400
Received: by mail-pf1-x442.google.com with SMTP id z28so2889662pfk.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 19:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=HYIlEI5x7dSKPn06Te85N+SIxFZI2TsRzdSqKh133IE=;
	b=rVXpXX3j2WMb8BKGaYvlHxU9rzhkP9HxQx6W+SKtDtYRq9OZ6PjlXy/Yw3SBks/2PA
	sO62ZkynKOVYJ1Oi971PtgPBbmxTwpCUCPVhX2EVu8dMiZcfwcwdV3jWb2Yo9+SFoKrU
	mY1X7cNtQl6Da12nUCr9zzjO+VODeTfCjo7XQqDbU/WZ4NksorgUGbJuTnkIJAqKkn53
	/41aW9DEGMa9zKB+x5dz52O+dYYmpmSiFKm3k30XOt38sHBd5G3WpYdM7MKfwh0LXsF2
	L7y+36IdzM6Gp3l5bU0fzjJbCZag3xmXuxeIjUEM3ipWDYPue/E4jmDN/NqBBE6ZSJoT
	CrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=HYIlEI5x7dSKPn06Te85N+SIxFZI2TsRzdSqKh133IE=;
	b=dQYPNUS9W1L/62QcA86ZTuQFdVeQBPD3qErDVfZXmYBh1z2k5hy7eua8zBeF11lN7P
	GY1sssXAhDCTxQrE8d43U5IkJJc/pJ8oJYKXPfXndZYyU9Tjono5tG9Mkgh2YqtozIU6
	jvjwYaJMs9JPA9o+adcQqhGtbpZNqL2/HnRSAF61ZuqrrRxLHstXyRP4rZ4YEnhU1oMO
	ZaXHkYLgYYuZseTpxGmpIdaiKLYPPC/NKtvc3GFix3zz+6hitBn+LYb7jE0UMOEhvejB
	k9TwlpD5FEi2OucFqljazyklaSNBGTfgEKeYXQ7Hb8Q0NyEApBBocQkZrw5QtlIaxSf/
	yQJA==
X-Gm-Message-State: APjAAAU5OFwLn/CyA4Yms0qWFug3hVwP8+/kT3YujwRPq1PsqCAAWy/A
	aI/LC8W+xZcKFiykAPtd2UEhvrM8wMw=
X-Google-Smtp-Source: APXvYqzlUqqzNEGZzj2jYnDCRs4uIoYXFfS9bjD+GFAlroPAtiHOVXMVKvpaOQj061mcuthy6hRWjQ==
X-Received: by 2002:a63:2cc9:: with SMTP id s192mr11701950pgs.24.1558060797110;
	Thu, 16 May 2019 19:39:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id w6sm6984152pge.30.2019.05.16.19.39.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 19:39:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 19:39:24 -0700
Message-Id: <20190517023924.1686-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517023924.1686-1-richard.henderson@linaro.org>
References: <20190517023924.1686-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v8 25/25] target/i386: Implement
 CPUID_EXT_RDRAND
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We now have an interface for guest visible random numbers.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/helper.h     |  2 ++
 target/i386/cpu.c        |  5 ++--
 target/i386/int_helper.c | 21 ++++++++++++++
 target/i386/translate.c  | 62 ++++++++++++++++++++++++++++++----------
 4 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index 6fb8fb9b74..8f9e1905c3 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -226,3 +226,5 @@ DEF_HELPER_3(rcrl, tl, env, tl, tl)
 DEF_HELPER_3(rclq, tl, env, tl, tl)
 DEF_HELPER_3(rcrq, tl, env, tl, tl)
 #endif
+
+DEF_HELPER_1(rdrand, tl, env)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 722c5514d4..1386814957 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -730,13 +730,14 @@ static void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_EXT_MONITOR | CPUID_EXT_SSSE3 | CPUID_EXT_CX16 | \
           CPUID_EXT_SSE41 | CPUID_EXT_SSE42 | CPUID_EXT_POPCNT | \
           CPUID_EXT_XSAVE | /* CPUID_EXT_OSXSAVE is dynamic */   \
-          CPUID_EXT_MOVBE | CPUID_EXT_AES | CPUID_EXT_HYPERVISOR)
+          CPUID_EXT_MOVBE | CPUID_EXT_AES | CPUID_EXT_HYPERVISOR | \
+          CPUID_EXT_RDRAND)
           /* missing:
           CPUID_EXT_DTES64, CPUID_EXT_DSCPL, CPUID_EXT_VMX, CPUID_EXT_SMX,
           CPUID_EXT_EST, CPUID_EXT_TM2, CPUID_EXT_CID, CPUID_EXT_FMA,
           CPUID_EXT_XTPR, CPUID_EXT_PDCM, CPUID_EXT_PCID, CPUID_EXT_DCA,
           CPUID_EXT_X2APIC, CPUID_EXT_TSC_DEADLINE_TIMER, CPUID_EXT_AVX,
-          CPUID_EXT_F16C, CPUID_EXT_RDRAND */
+          CPUID_EXT_F16C */
 
 #ifdef TARGET_X86_64
 #define TCG_EXT2_X86_64_FEATURES (CPUID_EXT2_SYSCALL | CPUID_EXT2_LM)
diff --git a/target/i386/int_helper.c b/target/i386/int_helper.c
index 4dc5c65991..334469ca8c 100644
--- a/target/i386/int_helper.c
+++ b/target/i386/int_helper.c
@@ -22,6 +22,8 @@
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
+#include "qapi/error.h"
+#include "qemu/guest-random.h"
 
 //#define DEBUG_MULDIV
 
@@ -470,3 +472,22 @@ void helper_cr4_testbit(CPUX86State *env, uint32_t bit)
         raise_exception_ra(env, EXCP06_ILLOP, GETPC());
     }
 }
+
+target_ulong HELPER(rdrand)(CPUX86State *env)
+{
+    Error *err = NULL;
+    target_ulong ret;
+
+    if (qemu_guest_getrandom(&ret, sizeof(ret), &err) < 0) {
+        qemu_log_mask(LOG_UNIMP, "rdrand: Crypto failure: %s",
+                      error_get_pretty(err));
+        error_free(err);
+        /* Failure clears CF and all other flags, and returns 0.  */
+        env->cc_src = 0;
+        return 0;
+    }
+
+    /* Success sets CF and clears all others.  */
+    env->cc_src = CC_C;
+    return ret;
+}
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 77d6b73e42..03150a86e2 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5332,31 +5332,63 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1c7: /* cmpxchg8b */
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
-        if ((mod == 3) || ((modrm & 0x38) != 0x8))
-            goto illegal_op;
-#ifdef TARGET_X86_64
-        if (dflag == MO_64) {
-            if (!(s->cpuid_ext_features & CPUID_EXT_CX16))
+        switch ((modrm >> 3) & 7) {
+        case 1: /* CMPXCHG8, CMPXCHG16 */
+            if (mod == 3) {
                 goto illegal_op;
-            gen_lea_modrm(env, s, modrm);
-            if ((s->prefix & PREFIX_LOCK) && (tb_cflags(s->base.tb) & CF_PARALLEL)) {
-                gen_helper_cmpxchg16b(cpu_env, s->A0);
-            } else {
-                gen_helper_cmpxchg16b_unlocked(cpu_env, s->A0);
             }
-        } else
+#ifdef TARGET_X86_64
+            if (dflag == MO_64) {
+                if (!(s->cpuid_ext_features & CPUID_EXT_CX16)) {
+                    goto illegal_op;
+                }
+                gen_lea_modrm(env, s, modrm);
+                if ((s->prefix & PREFIX_LOCK) &&
+                    (tb_cflags(s->base.tb) & CF_PARALLEL)) {
+                    gen_helper_cmpxchg16b(cpu_env, s->A0);
+                } else {
+                    gen_helper_cmpxchg16b_unlocked(cpu_env, s->A0);
+                }
+                set_cc_op(s, CC_OP_EFLAGS);
+                break;
+            }
 #endif        
-        {
-            if (!(s->cpuid_features & CPUID_CX8))
+            if (!(s->cpuid_features & CPUID_CX8)) {
                 goto illegal_op;
+            }
             gen_lea_modrm(env, s, modrm);
-            if ((s->prefix & PREFIX_LOCK) && (tb_cflags(s->base.tb) & CF_PARALLEL)) {
+            if ((s->prefix & PREFIX_LOCK) &&
+                (tb_cflags(s->base.tb) & CF_PARALLEL)) {
                 gen_helper_cmpxchg8b(cpu_env, s->A0);
             } else {
                 gen_helper_cmpxchg8b_unlocked(cpu_env, s->A0);
             }
+            set_cc_op(s, CC_OP_EFLAGS);
+            break;
+
+        case 7: /* RDSEED */
+        case 6: /* RDRAND */
+            if (mod != 3 ||
+                (s->prefix & (PREFIX_LOCK | PREFIX_REPZ | PREFIX_REPNZ)) ||
+                !(s->cpuid_ext_features & CPUID_EXT_RDRAND)) {
+                goto illegal_op;
+            }
+            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+                gen_io_start();
+            }
+            gen_helper_rdrand(s->T0, cpu_env);
+            rm = (modrm & 7) | REX_B(s);
+            gen_op_mov_reg_v(s, dflag, rm, s->T0);
+            set_cc_op(s, CC_OP_EFLAGS);
+            if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
+                gen_io_end();
+                gen_jmp(s, s->pc - s->cs_base);
+            }
+            break;
+
+        default:
+            goto illegal_op;
         }
-        set_cc_op(s, CC_OP_EFLAGS);
         break;
 
         /**************************/
-- 
2.17.1


