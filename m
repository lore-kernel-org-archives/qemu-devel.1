Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C43C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A76206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onqZQyuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A76206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izf0T-0000wI-6s
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoT-0003Eq-Vh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izeoS-0007ZN-7t
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:13 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38183)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izeoR-0007Rb-Uu
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:55:12 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so6580688wrh.5
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 02:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nejY7bX859Wnfryc93tarRnRLkI1By0EP/5x0G2hK7I=;
 b=onqZQyuJxPY+E/UvmtaFO2v8T4ec5XLgqQCJ2k8Tj//6gp/DVP/szqDshGlmIbWU/Q
 jz+spF8XC9b9Zk/tcxEUXityByoL6YsvT/UeVwM0cc1rHucZ1DizAmTV7VZL/bY0jEAk
 tbHkHUzRSOIvVjcTbIMfyi6OD6iRETupk/HuAg02JqyH/Jj5IHrsDsxX/ceUE7rDH0k7
 pziUAsAHn535Y4jOHI7VwVZBl5EvXn8Z5ZoTg05wYc9q5e9Tnny4DV7pb0J0HuuPVAGW
 dFB2PHR495uZcQhakfaTE0WwyDvwlSiAHYpMeGEYCAzqwNqqdX5n2NHVSiPtHgEBJaVl
 GBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nejY7bX859Wnfryc93tarRnRLkI1By0EP/5x0G2hK7I=;
 b=gmdTy/dBsnuNc+lz6foWLNA8Ut72IgWegDYEtImrUMxvYFaGeJ827pIXim8aGUW35+
 T5/iEz9MLtU/ggP51GDxRI23LlWd6fxn4NJ+fmHLYGQHjtD5z7jPWzzxDRko5a8h8HoO
 qFCutwT2MUo5/xaJ8yijmcBRtlOOGJAhqHC1V9tsKGQiiHYa+8HoC5rYoSQShgIEcmAp
 tEOjA8pSjT+FA5bLBtMTJaokbuLhuj8Ntw+yCtgmYK1rRcGPtDsqvxoduEscGhUmJcEZ
 tfg2r6OVbkOQs9Nn+bq0PUAspvpfX6mc4/CEvPg9LRANEWcziKWQ7sH0w5ejKCKzb3I/
 2hUg==
X-Gm-Message-State: APjAAAVFG7ogAHmSx22eQ0mP9Q9XJ7x6IwaSzoG0GnqlWFNHlpAit4ga
 q7KOVI2KvWhqUtdSTMxkVhTkZ5ST14Tx0Q==
X-Google-Smtp-Source: APXvYqyNi3u3IZIHvFC+rI3NjPxZ9VzNtFEtlstdQrZKrL8NpPXJdZfuU2QSVAdr1Dfxv2gD3W00wA==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr3100031wrq.137.1580986510012; 
 Thu, 06 Feb 2020 02:55:10 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3364995wmi.27.2020.02.06.02.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 02:55:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 24/41] target/arm: Update ctr_el0_access for EL2
Date: Thu,  6 Feb 2020 10:54:31 +0000
Message-Id: <20200206105448.4726-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206105448.4726-1-richard.henderson@linaro.org>
References: <20200206105448.4726-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update to include checks against HCR_EL2.TID2.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e41bece6b5..72b336e3b5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5264,11 +5264,27 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
 static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                      bool isread)
 {
-    /* Only accessible in EL0 if SCTLR.UCT is set (and only in AArch64,
-     * but the AArch32 CTR has its own reginfo struct)
-     */
-    if (arm_current_el(env) == 0 && !(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
-        return CP_ACCESS_TRAP;
+    int cur_el = arm_current_el(env);
+
+    if (cur_el < 2) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+
+        if (cur_el == 0) {
+            if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+                if (!(env->cp15.sctlr_el[2] & SCTLR_UCT)) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            } else {
+                if (!(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
+                    return CP_ACCESS_TRAP;
+                }
+                if (hcr & HCR_TID2) {
+                    return CP_ACCESS_TRAP_EL2;
+                }
+            }
+        } else if (hcr & HCR_TID2) {
+            return CP_ACCESS_TRAP_EL2;
+        }
     }
 
     if (arm_current_el(env) < 2 && arm_hcr_el2_eff(env) & HCR_TID2) {
-- 
2.20.1


