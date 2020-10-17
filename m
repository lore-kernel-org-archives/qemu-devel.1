Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100DDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6099E20704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suumtwTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6099E20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmyz-0000In-8M
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoM-00026W-Mn
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:50431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmoK-0003lC-Qo
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id 13so6155376wmf.0
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NCF5wa/3qOXXh6lH3vb50TSlF2Pm3DCj19abyPtcLXk=;
 b=suumtwTAQbeubki8d5Fe1JXlQKCnhl75w6nufIOL78DUyxW0/kkfnoeJEHkSaK/4V0
 SsNU1HvPXcnqhkSiPuKJvmGcEGj6FCMS5fhFM1Mq1jpsuV7ri11oDh4lsSklPNmzauwB
 q53xt8u8siGkKIKH8K0uhJIbRAUfyZEO9sxptf41l2UuSpNyrPq5RMitg7bhYxT4S85H
 9cyGsr1YFigKBPMfLxSaoU1CYLKHVwkCXpo1uOxbcLKrMh1E5MVT+jnj5vceC0VE0j6a
 FRT5zXuzhFlG0tVNbU24S3FKr4puadQvwgPnT1G0IqisorFfra+6uy3SgGbb8J1saV8I
 Ji/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NCF5wa/3qOXXh6lH3vb50TSlF2Pm3DCj19abyPtcLXk=;
 b=ejZKv61U3etyWZVUCP4TGFZ60ZgLYFGEi/b3JC1niK14iT9MA1mPiv84IFN9VxS7Em
 SZpD/u5N604XCDkgkZgm71KhkCBi7+EjjeKi1++W1KZ/Vtv0SWVj4kUdI9rM7RDA77hJ
 UUgGE2WXEmeIt0xhP+9+RnV5eZFufB//Uzme2lB9OoB1Q3wDfrv+kYjJdzzodrpxRded
 W8xH4jGEx5h7/2eD1cniTXJd6E43ktQajIHMdedXlvYz9qDy+oGvhlfwSBXflz6Jz7Wi
 jYLD3GhYjqcksoBvw37QULLlXitRZKU76/Cv9qZkhlofOCt//j8oT3pgwEwB99KV++rz
 dl7w==
X-Gm-Message-State: AOAM533rc4haPU+5AZl4RKUMP5+NH+PFOAcRBoBd+ab2sCzTdZezC1IJ
 PjM34wg9Xj1kSHDtmn1enrenJI7YtiE=
X-Google-Smtp-Source: ABdhPJzcmYUUe4a7IEoN+3u18Uyyy2HBRzuoh1SaEuYDLu8X86t3dC9rXyIjzmVEPiUJSm95oclDSw==
X-Received: by 2002:a1c:7c12:: with SMTP id x18mr8894969wmc.107.1602943431162; 
 Sat, 17 Oct 2020 07:03:51 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id g125sm2882531wme.33.2020.10.17.07.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:03:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/44] target/mips: Move cpu_mips_get_random() with CP0 helpers
Date: Sat, 17 Oct 2020 16:02:13 +0200
Message-Id: <20201017140243.1078718-15-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
 Luc Michel <luc@lmichel.fr>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The get_random() helper uses the CP0_Wired register, which is
unrelated to the CP0_Count register used as timer.
Commit e16fe40c872 ("Move the MIPS CPU timer in a separate file")
incorrectly moved this get_random() helper with timer specific
code. Move it back to generic CP0 helpers.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Luc Michel <luc@lmichel.fr>
Message-Id: <20201012095804.3335117-6-f4bug@amsat.org>
---
 target/mips/internal.h   |  2 +-
 target/mips/cp0_helper.c | 25 +++++++++++++++++++++++++
 target/mips/cp0_timer.c  | 25 -------------------------
 3 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index b811f547f38..dd8a7809b64 100644
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


