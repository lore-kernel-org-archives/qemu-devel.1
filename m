Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C029BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:50:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2A620678
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOcDO187"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2A620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTC4O-0005A9-UG
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 18:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTC2S-00036F-PQ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:48:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTC2R-0003K5-7P
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:48:00 -0400
Received: by mail-wr1-x443.google.com with SMTP id t9so396611wrq.11
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hI/5y4MeSKHx09W0hvgXkHn2lpXMMKn63dsyc85sJAk=;
 b=OOcDO187Kywse0gJ47gEc3Ulm/0TkXthkUXSoA0/H0E64Q7GFotZFSBeZksl9i8Aq/
 BblEge7g0KvNCeVMG6JGE2XuKJyXgO79uQiJfVGRJbflZLXktQ7mShDqFfvwXiqvLvpS
 MKzpTX8grO9Ui52gJmZXDa2LFu4oZ3O7aoRMAGCOMZVkbhlhCdrmXNKrXwIy6iTpoQW1
 VFVdGt/qzXiVHHcvGwInO9XlmKjbfDri68RRJfZIlIwLHOc3IImQqhR0vE9lT5LCyKQq
 HsStF/7E7pl3Qn7DXCzNcpu33rVQB+md/CPmTqPapoEQ6uPMll1vDUPYle7Pq1aIebc4
 ixCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hI/5y4MeSKHx09W0hvgXkHn2lpXMMKn63dsyc85sJAk=;
 b=gecwQLjA7Hwykt+TSVDaLbX1uoPZu0X8z/UgOjaFeHrCgDTLjg/6sYkKnlZYZRLVIQ
 uiiKcU2zBnIODq+jKUhIOZ3+yCxIcV1Ecl3gIS1BBHPVOS/FdrKig20REHvXbnZEamgm
 MjFmzC073AUvyR9SXpEPptBLV8/QvVghXCIYJvEK1R+AP3FXJg3Qr/vLcJCK4BS1Wv5r
 5Vsd5AbU3p4BlXTy5xsA80L/8Y6U9GgMM23dnkNJ6ot6hmxTYjUX6iLOXJEzbLhjZg4i
 R2dD6TNzp64RherU+03mQGMNzVFJzvt5Pc9n63Z4ytIhuY/BJAtiZHvyMI3GK1XSHaKI
 s8xQ==
X-Gm-Message-State: AOAM53104xSJenYAKp6GDI7THIVWRCt5i/BYGdAs/XpoOmoTiP5K5hSt
 2i3xCQ/1ovfSG5UXfanijNEtDu1WiPM=
X-Google-Smtp-Source: ABdhPJyD9FSYzToFbTDw6huJMQ2u8zji949WW91+A8e3B/7jp1WUu0KbrmO3ua5gCrBgsPh2Bu9FLQ==
X-Received: by 2002:a5d:5548:: with SMTP id g8mr498499wrw.364.1602802077481;
 Thu, 15 Oct 2020 15:47:57 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j134sm619347wmj.7.2020.10.15.15.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 15:47:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Victor Kamensky <kamensky@cisco.com>
Subject: [RFC PATCH v2 2/4] target/mips: Store number of TLB entries in
 CPUMIPSState
Date: Fri, 16 Oct 2020 00:47:44 +0200
Message-Id: <20201015224746.540027-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015224746.540027-1-f4bug@amsat.org>
References: <20201015224746.540027-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Khem Raj <raj.khem@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we want to make the number of TLB entries configurable,
store it in CPUMIPSState. Introduce the init_tlb_entries()
helper which initializes it from the CP0C1_MMU config content.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.h                |  1 +
 target/mips/translate.c          | 13 ++++++++++++-
 target/mips/translate_init.c.inc |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7cf7f5239f7..b84e9a8fcae 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1140,6 +1140,7 @@ struct CPUMIPSState {
 #endif
 
     const mips_def_t *cpu_model;
+    uint8_t tlb_entries;
     void *irq[8];
     QEMUTimer *timer; /* Internal timer */
     struct MIPSITUState *itu;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 4c9b6216321..698bcee8915 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -31316,8 +31316,18 @@ void mips_tcg_init(void)
 
 #include "translate_init.c.inc"
 
+static bool init_tlb_entries(CPUMIPSState *env, Error **errp)
+{
+    env->tlb_entries = 1 + extract32(env->cpu_model->CP0_Config1, CP0C1_MMU, 6);
+
+    return true;
+}
+
 bool cpu_mips_realize_env(CPUMIPSState *env, Error **errp)
 {
+    if (!init_tlb_entries(env, errp)) {
+        return false;
+    }
     env->exception_base = (int32_t)0xBFC00000;
 
 #ifndef CONFIG_USER_ONLY
@@ -31357,7 +31367,8 @@ void cpu_state_reset(CPUMIPSState *env)
 #ifdef TARGET_WORDS_BIGENDIAN
     env->CP0_Config0 |= (1 << CP0C0_BE);
 #endif
-    env->CP0_Config1 = env->cpu_model->CP0_Config1;
+    env->CP0_Config1 = deposit32(env->cpu_model->CP0_Config1, CP0C1_MMU, 6,
+                                 env->tlb_entries - 1);
     env->CP0_Config2 = env->cpu_model->CP0_Config2;
     env->CP0_Config3 = env->cpu_model->CP0_Config3;
     env->CP0_Config4 = env->cpu_model->CP0_Config4;
diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
index 637caccd890..a426463c434 100644
--- a/target/mips/translate_init.c.inc
+++ b/target/mips/translate_init.c.inc
@@ -946,7 +946,7 @@ static void fixed_mmu_init (CPUMIPSState *env, const mips_def_t *def)
 
 static void r4k_mmu_init (CPUMIPSState *env, const mips_def_t *def)
 {
-    env->tlb->nb_tlb = 1 + ((def->CP0_Config1 >> CP0C1_MMU) & 63);
+    env->tlb->nb_tlb = env->tlb_entries;
     env->tlb->map_address = &r4k_map_address;
     env->tlb->helper_tlbwi = r4k_helper_tlbwi;
     env->tlb->helper_tlbwr = r4k_helper_tlbwr;
-- 
2.26.2


