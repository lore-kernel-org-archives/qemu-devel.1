Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64739C47423
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:17:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1097A207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/eW2j5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1097A207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwmH-0005sw-Rn
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkg-0004B3-Uy
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kMwkc-0006LQ-No
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:15:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id e11so4829726wme.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cadHRUlJVGDHYwrx6BROjvQUTmmG7r+sEP8we7ujSMo=;
 b=Q/eW2j5QZCg2uK3jegk7FCFRm3wZiiYIqlXSzxknZOm3R+ZDIKSus01X8zz4qP9Mt9
 onhcn4UbePY+I9CxEp74HZViEhImTUuuw1TJy/NEfNyCmHYf0pUzrxu9n0LKqKDe0FN7
 xw8n7ABLhVgSm9NxMizLu1azdjj5t5KWBn6qnFbP9OQlBjqkMl3YGIxTkZfblZCdnGfk
 XPfF4OGeW4FASKIyb5PTtOqAco1epvHaS9m4swVAmBW1cKXqJhv4bPXvjHApckNhNzxO
 qUnDwS578QMz0nP8X65feHa2HWKYCnZSoAeFZnw//awJ5u8dfujAjqMZmUAwhprdlyX0
 Xh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cadHRUlJVGDHYwrx6BROjvQUTmmG7r+sEP8we7ujSMo=;
 b=Fkp72ZZa/D7EpM9laDm2IMEBiyMK2K6n5fQcvWxfAbTLWlbPzBxH1wj5hVLot0UMJ5
 kElzcHhW8KY9bksKT3fx65X/kdyh18iRLop/NJm5rU3TVr6wH8BuABmpxBjUxUx17+Db
 YFi2BBsraWSYOVhWygIJvYRj54eaVY/Hm5Hqb9daB1KPbglXiiA+PaEna8ofQ0D0h4O0
 o/+Atz51beIIRc/QGvcfwz6zIAdSlKxb2uQ/knYK6/+OKeYZhEKGoJz5uiHyzC/sGIyB
 3MlTvPKg57e2odMlKFEJHyr0rsENKwc6fychkIp8x1/cuSAqoHbs7d+ZLaWIeF/tCud+
 LTzA==
X-Gm-Message-State: AOAM531qJeyqtwAOzuTdzwtLnEt/UgHjEtamn/NLDa6GbG8517lJr35o
 tDFemQNsohyawAdNEgsxBm+NCIAryx8=
X-Google-Smtp-Source: ABdhPJwq1k7VA7Frm1YSsaIupUzH1L9BCyAOLlQ/4LP9+Sh8gMdSeAMqXhljRW7acRgQ1n1DmtlDSg==
X-Received: by 2002:a1c:2d94:: with SMTP id t142mr225524wmt.74.1601313344826; 
 Mon, 28 Sep 2020 10:15:44 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z67sm464787wme.41.2020.09.28.10.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:15:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/16] target/mips: Move cpu_mips_get_random() with CP0 helpers
Date: Mon, 28 Sep 2020 19:15:25 +0200
Message-Id: <20200928171539.788309-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928171539.788309-1-f4bug@amsat.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199,
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The get_random() helper uses the CP0_Wired register, which is
unrelated to the CP0_Count register use as timer.
Commit e16fe40c872 ("Move the MIPS CPU timer in a separate file")
incorrectly moved this get_random() helper with timer specific
code. Move it back to generic CP0 helpers.

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


