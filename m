Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B91C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669EE20706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qkqfW5DW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669EE20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqQx-0002gO-MT
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4g-0003KZ-Gl
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:30 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:46453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4e-0006jp-Kc
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:30 -0400
Received: by mail-wr1-x42c.google.com with SMTP id r12so9805957wrj.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0oVfTOhMQ6Tde7hKNa/ourLtYXrK2B3QeNm/nMxWem8=;
 b=qkqfW5DWWVce1lt2gMkWTq63P2U/IlsJCEsJ+9vfWvJqhzA712wi57+DXM0ky4yZmF
 k7Rmwj8ojD2TeI0FKBIZJHmroIvyTEJ26BZjETbVSaG8rOFDJltxjbmFQmBeX7cZFG0g
 LSPUxyrCWag8gN6JqmRjSJEGOep+XQypwyUigkYYuJ9BVryveQHmgnz69Z7lK+Y5bEqn
 TM69nYosX1he6vXjnp5oH6QRFhcKcmGNqG67gk62nuOBinrWWX+rOUi4g/ToeoD/v7Na
 pGktQgXe94INIKwcnrWPU8iXmCHe0R0EHIfPwx2YZEU19etkhU0LeZkwTx1JHQlDr4lC
 fRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0oVfTOhMQ6Tde7hKNa/ourLtYXrK2B3QeNm/nMxWem8=;
 b=gRhRB8YxqcJXdB61h64QMwahGkD68YCCkoXfUNBdVgoJkynoUAO7JmCX50S09SUJ8L
 D2BZ7Utgt2TVj+aRnyDXwDGkP27YlWYp9TY5YetbgAL4I0RIMCmTRZKJ16tR8ltR+qi3
 4hbtVQqs2arJ/1/nOSzHWWlnKKK3uwtEiuOLBJGUIQBIos4BfIz+AvkTbmgo4j4fqHlr
 vsF27Qfyxa+tLD0v4xbjx4FTITX3aAaTOSlSr7DvJCwfpBvFwgipyhvwt7Qp5eaqpLbJ
 TmgAzhUWvzKXlHO480Lt4j4jVwNpJ+WoJmrhpJvvmUzWFECxDeoEBeYQZlqOry+nGIJ1
 afYQ==
X-Gm-Message-State: AOAM532NXToViRbBmbFIn6ZHBv02cQMdRE2wn3SOFSVpnYvh5pTSkqlG
 u8/OTbRR9DIrZENke1w7VsLRPfoOF9J8Yg==
X-Google-Smtp-Source: ABdhPJy7U7eIeuCTerVABvOSikTiIMfjD1e/o9NWRGOfceLWauuzsNrozOzyVNCTTq7/26scAircHw==
X-Received: by 2002:adf:de01:: with SMTP id b1mr4163979wrm.305.1593184526971; 
 Fri, 26 Jun 2020 08:15:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/57] target/arm: Complete TBI clearing for user-only for SVE
Date: Fri, 26 Jun 2020 16:14:17 +0100
Message-Id: <20200626151424.30117-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

From: Richard Henderson <richard.henderson@linaro.org>

There are a number of paths by which the TBI is still intact
for user-only in the SVE helpers.

Because we currently always set TBI for user-only, we do not
need to pass down the actual TBI setting from above, and we
can remove the top byte in the inner-most primitives, so that
none are forgotten.  Moreover, this keeps the "dirty" pointer
around at the higher levels, where we need it for any MTE checking.

Since the normal case, especially for user-only, goes through
RAM, this clearing merely adds two insns per page lookup, which
will be completely in the noise.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-39-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c           |  3 +++
 target/arm/sve_helper.c    | 19 +++++++++++++++++--
 target/arm/translate-a64.c |  5 +++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d9876337c05..afe81e9b6c0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -203,6 +203,9 @@ static void arm_cpu_reset(DeviceState *dev)
          * Enable TBI0 and TBI1.  While the real kernel only enables TBI0,
          * turning on both here will produce smaller code and otherwise
          * make no difference to the user-level emulation.
+         *
+         * In sve_probe_page, we assume that this is set.
+         * Do not modify this without other changes.
          */
         env->cp15.tcr_el[1].raw_tcr = (3ULL << 37);
 #else
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index ad974c2cc57..382fa82bc8a 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3966,14 +3966,16 @@ static void sve_##NAME##_host(void *vd, intptr_t reg_off, void *host)  \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
                              target_ulong addr, uintptr_t ra)               \
 {                                                                           \
-    *(TYPEE *)(vd + H(reg_off)) = (TYPEM)TLB(env, addr, ra);                \
+    *(TYPEE *)(vd + H(reg_off)) =                                           \
+        (TYPEM)TLB(env, useronly_clean_ptr(addr), ra);                      \
 }
 
 #define DO_ST_TLB(NAME, H, TYPEE, TYPEM, TLB) \
 static void sve_##NAME##_tlb(CPUARMState *env, void *vd, intptr_t reg_off,  \
                              target_ulong addr, uintptr_t ra)               \
 {                                                                           \
-    TLB(env, addr, (TYPEM)*(TYPEE *)(vd + H(reg_off)), ra);                 \
+    TLB(env, useronly_clean_ptr(addr),                                      \
+        (TYPEM)*(TYPEE *)(vd + H(reg_off)), ra);                            \
 }
 
 #define DO_LD_PRIM_1(NAME, H, TE, TM)                   \
@@ -4091,6 +4093,19 @@ static bool sve_probe_page(SVEHostPage *info, bool nofault,
     int flags;
 
     addr += mem_off;
+
+    /*
+     * User-only currently always issues with TBI.  See the comment
+     * above useronly_clean_ptr.  Usually we clean this top byte away
+     * during translation, but we can't do that for e.g. vector + imm
+     * addressing modes.
+     *
+     * We currently always enable TBI for user-only, and do not provide
+     * a way to turn it off.  So clean the pointer unconditionally here,
+     * rather than look it up here, or pass it down from above.
+     */
+    addr = useronly_clean_ptr(addr);
+
     flags = probe_access_flags(env, addr, access_type, mmu_idx, nofault,
                                &info->host, retaddr);
     info->flags = flags;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e46c4a49e00..c20af6ee9d0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -14634,6 +14634,11 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->features = env->features;
     dc->dcz_blocksize = arm_cpu->dcz_blocksize;
 
+#ifdef CONFIG_USER_ONLY
+    /* In sve_probe_page, we assume TBI is enabled. */
+    tcg_debug_assert(dc->tbid & 1);
+#endif
+
     /* Single step state. The code-generation logic here is:
      *  SS_ACTIVE == 0:
      *   generate code with no special handling for single-stepping (except
-- 
2.20.1


