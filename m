Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64DFC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7009F2064B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1NgWtew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7009F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJUc-0002Iw-Jc
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJFB-0004zQ-2M
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF9-0007eJ-Sl
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:04 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiJF9-0007ZI-AQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:03 -0500
Received: by mail-wm1-x336.google.com with SMTP id f129so9434498wmf.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2N9BzGwQFOYr5kHxYpTN+kd6izVO1fNFifpaACJFB1U=;
 b=j1NgWtewVyE+Q88aXnorv9zlUssDLuYOEx13FW5XRb12iH+PR+4RGNB6Hpcx04icXp
 ZCVKRbVVB7MYrRE8+j3+f4uXthmRQfDAp30aL2eaXiUr/xjJCpkVWfGvWVvcXDmdEswV
 TyKu7jiQyMsUCrxYF6freFrA3EAWlzLXAexV/Ma2gM/zy+8Joii4+5h+rABHP7fKXjJc
 W5VufREj1zP7ClDQXw87IPIfisYf/HbRU68muF2URAe01Ym7FqQJRQsrC6Wfx1vBCF2m
 neSaSYJBtiv12L3gPMRbAXTuHNhcFPG/YCgZTL0Y5Vvg+L3meZQFjgPxdXFykkoUbAK+
 Ly5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2N9BzGwQFOYr5kHxYpTN+kd6izVO1fNFifpaACJFB1U=;
 b=EuZQflqO1UKpvIPKsJvyXFFYGK34YqHDsUkiFm25U61CPAOHoc7VVCoDIMlNy7y+lz
 5P06LHpst0Lj4mpOcZLF4pc/PTKW1MRIHK5VVOeCY9ora58Wow4Jf2Oq2WpmS9gVFUKX
 kLUnJSVVGm5V37+K3578P8woARt6JU5zF3V0uvsnUpTsooCuxCnwm8NGtTT6NvK3U9ey
 a04Ktsz9h49IdR3dm2KnMtZSOWZXlhaTbnoJhS9JTvJ2FxKEeXjxJEsbS44FuEuMIxad
 vR61IPwipQ9D2igqWVmx3A5SJEY1R+SzBXdMN9fWdSprYTjIVfWWfZcq7OybtkpxfHOA
 tnJA==
X-Gm-Message-State: APjAAAWBidODtwDY6N9j/eA8Jznj3A67VqcW1uGGVe4yWqwHBXp4sCzX
 AUg7GbV1m9GhbzHYt18OpPZtRnQAfaB3jg==
X-Google-Smtp-Source: APXvYqzfdsioNL1SwOi9p4cBKoMlX7H3R9eyYqDCyVxK1eOnA3VakBEOAsJEZcd+7TEtXNWF0lOuXw==
X-Received: by 2002:a1c:638a:: with SMTP id x132mr17978957wmb.43.1576852021797; 
 Fri, 20 Dec 2019 06:27:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t5sm9741814wrr.35.2019.12.20.06.27.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:27:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] target/arm: Display helpful message when hflags mismatch
Date: Fri, 20 Dec 2019 14:26:43 +0000
Message-Id: <20191220142644.31076-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142644.31076-1-peter.maydell@linaro.org>
References: <20191220142644.31076-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Instead of crashing in a confuse way, give some hint to the user
about why we aborted. He might report the issue without having
to use a debugger.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20191209134552.27733-1-philmd@redhat.com
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1d9af2d8b28..b6bec42f48e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11512,6 +11512,20 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *env, int el)
     env->hflags = rebuild_hflags_a64(env, el, fp_el, mmu_idx);
 }
 
+static inline void assert_hflags_rebuild_correctly(CPUARMState *env)
+{
+#ifdef CONFIG_DEBUG_TCG
+    uint32_t env_flags_current = env->hflags;
+    uint32_t env_flags_rebuilt = rebuild_hflags_internal(env);
+
+    if (unlikely(env_flags_current != env_flags_rebuilt)) {
+        fprintf(stderr, "TCG hflags mismatch (current:0x%08x rebuilt:0x%08x)\n",
+                env_flags_current, env_flags_rebuilt);
+        abort();
+    }
+#endif
+}
+
 void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
                           target_ulong *cs_base, uint32_t *pflags)
 {
@@ -11519,9 +11533,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
     uint32_t pstate_for_ss;
 
     *cs_base = 0;
-#ifdef CONFIG_DEBUG_TCG
-    assert(flags == rebuild_hflags_internal(env));
-#endif
+    assert_hflags_rebuild_correctly(env);
 
     if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
         *pc = env->pc;
-- 
2.20.1


