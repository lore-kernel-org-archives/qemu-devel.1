Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BB1C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C047821741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uRu9ky22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C047821741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53717 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOEu-0001ba-Vs
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCL-0004xS-Gs
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1izOCK-0005IA-B2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:45 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55981)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1izOCK-0005D7-3n
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:10:44 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so3307455wmj.5
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 09:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/R8U5i4Qq/DO5WZK68fQeqQaCylMXAXeYfIPSaQJD1E=;
 b=uRu9ky227M7jFK3Q9wbPZQBCB6CIViRgFxGdOsHSOSdB6DufZcmDqL8EIF8jBsjqfZ
 p7z8TcXBaWLw+6FvJwdakqi7wMsGQflr5BxiY1+kj/aiAVA0/EaZFRQUW+4mJrzQzNMq
 12v3Kn2yRasUU93XEgXeT0wjFVvP/3f/RsCHQK3rIxAjwERKvCgJK469AQlzejUVVlFg
 D2RBFO+rJtDIJ9U8WyDnH3ZpV3NWLvcFJldUbJ9ZbfWfz2GXatWqQ8/Y84jx3bb99ij2
 JQl8Ll1gdm8nXbib3HB5u0CCusV7O4W8owPLSQi6xdeiWI4rnr7E3b0GDn3nbZ1xnyTY
 hnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/R8U5i4Qq/DO5WZK68fQeqQaCylMXAXeYfIPSaQJD1E=;
 b=ssOOEmqbJruvoqI2BBIIIhoZW1Q+cn6t0LvMtJ/IdSzWtVxcsjT4mC1vSejeDgH2ks
 GW8j1IvMr2zHoXn5fBhvE8tjVtwa4qhxhOh58q43OyFwo0tG9KYlRROFm63UJ9FCrJnO
 1MaDTuYjodZijLx6/QyKAXiowcjreJ25gvsVgryk97q/VwRdLGa6CFChlFCohqmr3Rc2
 jV3+il1IP78mN4jqhp42NVdNKlEXkSx2N84Z6Nfylq8uT8lUDKle9FzEq10QgVxYiE7Z
 j2o+MCxmrRaGWfnZ6OH0OMn8Yh3p3HFm0zXqcs22pO8Kv5qzhn8Hpj+Faqf2/e5ZgLjv
 4+tQ==
X-Gm-Message-State: APjAAAUUqqkW2thQ1YrsB/bdKDSwc9+0QGZ80UtjB0MxvGOHbIlq0V26
 6yqTxzQ6mTywbZAYxBrxu3LikA==
X-Google-Smtp-Source: APXvYqzUBuqRqAO7yCEfZCHajIKPx9cwBxR5iX9oj5B8CDMJjwchzn35KvbH8tKRID1Z8b/vWeUBxw==
X-Received: by 2002:a7b:c3c9:: with SMTP id t9mr6587356wmj.18.1580922642991;
 Wed, 05 Feb 2020 09:10:42 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g128sm206013wme.47.2020.02.05.09.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 09:10:39 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 472241FF98;
 Wed,  5 Feb 2020 17:10:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 08/22] target/i386: use gdb_get_reg helpers
Date: Wed,  5 Feb 2020 17:10:17 +0000
Message-Id: <20200205171031.22582-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200205171031.22582-1-alex.bennee@linaro.org>
References: <20200205171031.22582-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 Eduardo Habkost <ehabkost@redhat.com>, richard.henderson@linaro.org,
 alan.hayward@arm.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cleaner than poking memory directly and will make later
clean-ups easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/i386/gdbstub.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 572ead641ca..208b3de70da 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -95,29 +95,26 @@ int x86_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
             if (env->hflags & HF_CS64_MASK) {
                 return gdb_get_reg64(mem_buf, env->regs[gpr_map[n]]);
             } else if (n < CPU_NB_REGS32) {
+
                 return gdb_get_reg64(mem_buf,
                                      env->regs[gpr_map[n]] & 0xffffffffUL);
             } else {
-                memset(mem_buf, 0, sizeof(target_ulong));
-                return sizeof(target_ulong);
+                return gdb_get_regl(mem_buf, 0);
             }
         } else {
             return gdb_get_reg32(mem_buf, env->regs[gpr_map32[n]]);
         }
     } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
-#ifdef USE_X86LDOUBLE
-        /* FIXME: byteswap float values - after fixing fpregs layout. */
-        memcpy(mem_buf, &env->fpregs[n - IDX_FP_REGS], 10);
-#else
-        memset(mem_buf, 0, 10);
-#endif
+        guint8 *data = (guint8 *) &env->fpregs[n - IDX_FP_REGS];
+        memcpy(mem_buf, data, 10);
+        /* byte swap? this is at least correct of x86-on-x86 */
         return 10;
     } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -= IDX_XMM_REGS;
         if (n < CPU_NB_REGS32 || TARGET_LONG_BITS == 64) {
-            stq_p(mem_buf, env->xmm_regs[n].ZMM_Q(0));
-            stq_p(mem_buf + 8, env->xmm_regs[n].ZMM_Q(1));
-            return 16;
+            return gdb_get_reg128(mem_buf,
+                                  env->xmm_regs[n].ZMM_Q(0),
+                                  env->xmm_regs[n].ZMM_Q(1));
         }
     } else {
         switch (n) {
@@ -290,10 +287,7 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             return 4;
         }
     } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
-#ifdef USE_X86LDOUBLE
-        /* FIXME: byteswap float values - after fixing fpregs layout. */
         memcpy(&env->fpregs[n - IDX_FP_REGS], mem_buf, 10);
-#endif
         return 10;
     } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -= IDX_XMM_REGS;
-- 
2.20.1


