Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A3FC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCF8F207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlVRXuiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF8F207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLwQ-0000Oy-Tm
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiI-0000Y3-M6
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRLiG-0007SO-W6
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:43:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id n18so14170966wrs.5
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 13:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w+Ww+Tb9ux5DYpk7DL28NdlwI2XqYxB/b3zmX73nSUY=;
 b=FlVRXuizJUUcngPgMygPqNNIiMkDBJpEpBQUHUeDjynyhxd4hHIDqkCb+iQVpjclpH
 r4hCRKu+yNCoRfZOzoBw27jqvquM7g/rjzq8IV4iQ4HiKIgTnUkdlNXAMRL8cYkEFvqK
 u1WpcFKFitjva5l0KVxj8zUvSzQNimk/gdZbV8ejQNBDWZ26KnpLPdVD9Af+NNGFYLlx
 2bjbNa49Djy5qPHpsg4xLY/HtrL4GngrQVYqLQecJRsbvEpSHX3IyAONnDXL1qElKSqo
 SnAZJULWxYgJMsiznnmVj0rPfOY9nJp4z6KaTgleZLSbuSX9OV/hyGXv31qpC7DTylv5
 wt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=w+Ww+Tb9ux5DYpk7DL28NdlwI2XqYxB/b3zmX73nSUY=;
 b=PLSN7QLRW/wVyzM4MEoxi+ZrcXejZtbbZ2f+5sBHwI3jMY0mJ6bkFWY7dwzTcYiJfy
 YtCwfzrFFsOCFMeyh3QbIy+JWJQ2DyR5e0nwqDJaxhQ2vcQc5+PrGTp+wUsmwt5yU7QP
 geTgX0DrtHUXAtfhGRaLRDCdCXscuPfz3Sn+M/EJUzAxV8K7izJq4LIHmyFCXPycWvWl
 9e2ivIwIAfT5XROwSG3S5QxaeRNUdUZZ7E5Hh1OqH4f6Xlxfr+OPvcOUEBFO8JWN7M51
 qnnL0QwRevMSNt3n2imIpsUqa1M7oxh2JfvOZucy+Pg1Bt6gi9g1bDuEjER9OpKr2zSY
 dQpw==
X-Gm-Message-State: AOAM532TjTcPwD0FFucIMa6pxqkxZlwwCgrGAmRpb2fywSgBWCacmlZn
 qxe2TmVcaHhVP17yPDkxVm6YI2CiBIw=
X-Google-Smtp-Source: ABdhPJw8RcEG6mhL7apDRzkuwHDkHPjLk4pcpAAQA/cfcKZf7yFAQ6zKwvLreIHrZXbS20Nmb+bsqg==
X-Received: by 2002:adf:f50e:: with SMTP id q14mr15085634wro.56.1602362609037; 
 Sat, 10 Oct 2020 13:43:29 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 205sm2705471wme.38.2020.10.10.13.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 13:43:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/20] target/mips: Move cpu_mips_get_random() with CP0
 helpers
Date: Sat, 10 Oct 2020 22:43:04 +0200
Message-Id: <20201010204319.3119239-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201010204319.3119239-1-f4bug@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The get_random() helper uses the CP0_Wired register, which is
unrelated to the CP0_Count register use as timer.
Commit e16fe40c872 ("Move the MIPS CPU timer in a separate file")
incorrectly moved this get_random() helper with timer specific
code. Move it back to generic CP0 helpers.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/internal.h   |  2 +-
 target/mips/cp0_helper.c | 25 +++++++++++++++++++++++++
 target/mips/cp0_timer.c  | 25 -------------------------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 7f159a9230c..087cabaa6d4 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -144,6 +144,7 @@ void r4k_helper_tlbr(CPUMIPSState *env);
 void r4k_helper_tlbinv(CPUMIPSState *env);
 void r4k_helper_tlbinvf(CPUMIPSState *env);
 void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
+uint32_t cpu_mips_get_random(CPUMIPSState *env);
 
 void mips_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                     vaddr addr, unsigned size,
@@ -209,7 +210,6 @@ void cpu_state_reset(CPUMIPSState *s);
 void cpu_mips_realize_env(CPUMIPSState *env);
 
 /* cp0_timer.c */
-uint32_t cpu_mips_get_random(CPUMIPSState *env);
 uint32_t cpu_mips_get_count(CPUMIPSState *env);
 void cpu_mips_store_count(CPUMIPSState *env, uint32_t value);
 void cpu_mips_store_compare(CPUMIPSState *env, uint32_t value);
diff --git a/target/mips/cp0_helper.c b/target/mips/cp0_helper.c
index de64add038b..12143ac55b9 100644
--- a/target/mips/cp0_helper.c
+++ b/target/mips/cp0_helper.c
@@ -203,6 +203,31 @@ static void sync_c0_entryhi(CPUMIPSState *cpu, int tc)
     *tcst |= asid;
 }
 
+/* XXX: do not use a global */
+uint32_t cpu_mips_get_random(CPUMIPSState *env)
+{
+    static uint32_t seed = 1;
+    static uint32_t prev_idx;
+    uint32_t idx;
+    uint32_t nb_rand_tlb = env->tlb->nb_tlb - env->CP0_Wired;
+
+    if (nb_rand_tlb == 1) {
+        return env->tlb->nb_tlb - 1;
+    }
+
+    /* Don't return same value twice, so get another value */
+    do {
+        /*
+         * Use a simple algorithm of Linear Congruential Generator
+         * from ISO/IEC 9899 standard.
+         */
+        seed = 1103515245 * seed + 12345;
+        idx = (seed >> 16) % nb_rand_tlb + env->CP0_Wired;
+    } while (idx == prev_idx);
+    prev_idx = idx;
+    return idx;
+}
+
 /* CP0 helpers */
 target_ulong helper_mfc0_mvpcontrol(CPUMIPSState *env)
 {
diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
index bd7efb152dd..9c38e9da1c8 100644
--- a/target/mips/cp0_timer.c
+++ b/target/mips/cp0_timer.c
@@ -29,31 +29,6 @@
 
 #define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */
 
-/* XXX: do not use a global */
-uint32_t cpu_mips_get_random(CPUMIPSState *env)
-{
-    static uint32_t seed = 1;
-    static uint32_t prev_idx = 0;
-    uint32_t idx;
-    uint32_t nb_rand_tlb = env->tlb->nb_tlb - env->CP0_Wired;
-
-    if (nb_rand_tlb == 1) {
-        return env->tlb->nb_tlb - 1;
-    }
-
-    /* Don't return same value twice, so get another value */
-    do {
-        /*
-         * Use a simple algorithm of Linear Congruential Generator
-         * from ISO/IEC 9899 standard.
-         */
-        seed = 1103515245 * seed + 12345;
-        idx = (seed >> 16) % nb_rand_tlb + env->CP0_Wired;
-    } while (idx == prev_idx);
-    prev_idx = idx;
-    return idx;
-}
-
 /* MIPS R4K timer */
 static void cpu_mips_timer_update(CPUMIPSState *env)
 {
-- 
2.26.2


