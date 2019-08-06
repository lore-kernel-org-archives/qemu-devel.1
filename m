Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8C6C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DC32147A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 00:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNC2n1Jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DC32147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1humzL-000602-Ve
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 20:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33678)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1humya-0003yK-CR
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1humyZ-0008GG-0Z
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:05:16 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1humyY-0008Fr-RE
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 20:05:14 -0400
Received: by mail-pf1-x441.google.com with SMTP id f17so36461998pfn.6
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 17:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7UQASDLrOuEF/hUHDxJjRqnvDqT4SknEM9H9useKOF0=;
 b=yNC2n1JwKlOEdhDUriaGW8KrTWfzkYCUOwpOHVwU2PqdBSqYs19X2N6xZXH4/INZn7
 fzIKYfCyisl1/LnI3/PxuHF/aG701rAFUku/VvAGnJttWMmivL0IKBvM8aDtEA+4h0Bq
 2tIjd5PlynA0qyNKwMNQWFbBtrMHFGRCAvkgbqqoR4+9+/wk7/kSL+iQtGGUb9itnJ5v
 dMeSuNKbkPLurNZmC+ZE24d2NJ/Qeur7Dfwn7OQZPDO4iyKEw4ZfTOh2lipzUVh5M7wa
 WkjAXQLrK0qK0BNId0JomCynIY3fFfgfVZCmvZ1pBjpR3VqVm38RRQL0iGWsJ0Annx1T
 xHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7UQASDLrOuEF/hUHDxJjRqnvDqT4SknEM9H9useKOF0=;
 b=VzgQQX8WBGFm9EA3PlFM69YDIA47k7n5BUvnf7ZtXywOFRsPW2tl4bML9zmr3iWg+3
 43hYLyOkluh8U99rtJEsOQvIA06oyu55eTFanBOUiHfVcKKuT3IKG8XNGHgW1QiM/Xwo
 UjSFUqKxIrWEehi1XCl0ioupncJjIeKs7ePysB9aF4AgLNQ6M6n+0qRnseJt+kj38KBi
 FMcD98x9fyLoC+EBOqXuEZUYrJD96pe9ji5eWZbdvAeVt4YwKeq0kVj5oDp/uEturz/P
 M1QPFqq26v0T6MiBPS76DwD/lBccZsD5+sXqykEvcbbA0jopTtjDFAM9VFwIzyFcDQre
 VRQA==
X-Gm-Message-State: APjAAAVLIyXx9fD3HOP+Mqpq8lpMEo+BSgAnoC1wcjCD1/v+NmzD7qWO
 AzKx4fyMfAZ7qZlgAHAVtVw51Ws5cRY=
X-Google-Smtp-Source: APXvYqxA6THu0LYqwsb3uKQiJQUnuFL3Z6q79+gRAGl6FWorHHJqr8g4fsWj4h3SeyekvoBRfXMv0w==
X-Received: by 2002:a17:90a:25c8:: with SMTP id
 k66mr276028pje.129.1565049913622; 
 Mon, 05 Aug 2019 17:05:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i3sm92149782pfo.138.2019.08.05.17.05.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 05 Aug 2019 17:05:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  5 Aug 2019 17:05:06 -0700
Message-Id: <20190806000506.10833-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806000506.10833-1-richard.henderson@linaro.org>
References: <20190806000506.10833-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v4 3/3] target/arm: Rely on hflags correct in
 cpu_get_tb_cpu_state
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the payoff.

From perf record -g data of ubuntu 18 boot and shutdown:

BEFORE:

-   23.02%     2.82%  qemu-system-aar  [.] helper_lookup_tb_ptr
   - 20.22% helper_lookup_tb_ptr
      + 10.05% tb_htable_lookup
      - 9.13% cpu_get_tb_cpu_state
           3.20% aa64_va_parameters_both
           0.55% fp_exception_el

-   11.66%     4.74%  qemu-system-aar  [.] cpu_get_tb_cpu_state
   - 6.96% cpu_get_tb_cpu_state
        3.63% aa64_va_parameters_both
        0.60% fp_exception_el
        0.53% sve_exception_el

AFTER:

-   16.40%     3.40%  qemu-system-aar  [.] helper_lookup_tb_ptr
   - 13.03% helper_lookup_tb_ptr
      + 11.19% tb_htable_lookup
        0.55% cpu_get_tb_cpu_state

     0.98%     0.71%  qemu-system-aar  [.] cpu_get_tb_cpu_state

     0.87%     0.24%  qemu-system-aar  [.] rebuild_hflags_a64

Before, helper_lookup_tb_ptr is the second hottest function in the
application, consuming almost a quarter of the runtime.  Within the
entire execution, cpu_get_tb_cpu_state consumes about 12%.

After, helper_lookup_tb_ptr has dropped to the fourth hottest function,
with consumption dropping to a sixth of the runtime.  Within the
entire execution, cpu_get_tb_cpu_state has dropped below 1%, and the
supporting function to rebuild hflags also consumes about 1%.

Assertions are retained for --enable-debug-tcg.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Retain asserts for future debugging.
---
 target/arm/helper.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9b07350cfe..abb8cc52dd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11155,19 +11155,29 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *env, uint32_t el)
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
-    int current_el = arm_current_el(env);
-    uint32_t flags;
+    uint32_t flags = env->hflags;
     uint32_t pstate_for_ss;
 
+#ifdef CONFIG_DEBUG_TCG
+    {
+        int el = arm_current_el(env);
+        uint32_t check_flags;
+        if (is_a64(env)) {
+            check_flags = rebuild_hflags_a64(env, el);
+        } else {
+            check_flags = rebuild_hflags_a32(env, el);
+        }
+        assert(flags == check_flags);
+    }
+#endif
+
     *cs_base = 0;
-    if (is_a64(env)) {
+    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
         *pc = env->pc;
-        flags = rebuild_hflags_a64(env, current_el);
         flags = FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
         pstate_for_ss = env->pstate;
     } else {
         *pc = env->regs[15];
-        flags = rebuild_hflags_a32(env, current_el);
         flags = FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);
         flags = FIELD_DP32(flags, TBFLAG_A32, CONDEXEC, env->condexec_bits);
         /* Note that XSCALE_CPAR shares bits with VECSTRIDE */
-- 
2.17.1


