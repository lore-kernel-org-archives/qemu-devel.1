Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440CEC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C9520776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 10:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7uTrGsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C9520776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRulm-0005a8-Kk
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 06:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRubm-00010X-Fn
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRubl-0002r0-1N
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:59:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id t9so18435558wrq.11
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WMmrjqbhyA78SVq9CMHVcgoa6LhwqY9bNf3V4TYAoRc=;
 b=s7uTrGsEDEcyfML7sJMr2MaJmwphstoP+G/q03Wf+oq5cLpicDpmN8Ni4GGWs7g98J
 5CmtF0cDdFaoG4aLfRcAl5vP75USAhjKqTU1xPFOQzM1b/f7VX8wR+9LQC6FUVpNMpzN
 Ey9niCOGTReosyIEwbXkKXO36wj8mdgjZ0JTYuJX1xoUHJ9c7Hes0K2+piJtby8O8FaJ
 GMZ4MDZXMy+hQyywBJOdSXdh8XyDTyZmso5YJcO0/O/oFlg/EITRXeyeFwBe4zuH2alF
 MdWjBbIGGI9OuQHfv4FiZ1fFzUa/c5vkmObeQmQsR0Tj+P/n+mH1Mf/mEYYVqNUcc4RI
 bLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WMmrjqbhyA78SVq9CMHVcgoa6LhwqY9bNf3V4TYAoRc=;
 b=ZbYs9DY5QXVOkfo8ZqIAlzl0ndgwagyG9jWCWfMqTqFxGcFVgkwWaRomnLVO8yZYiP
 AXJi6ChHn095KqapfTm7gXaIuq34c91pJVgzzEA6A/zto5nNl60X96Je53UEAVLQdu2D
 PM9UmUyh9T7Rez95lGI+It7jzXke6syl4f10ArkxHYokjI5QXFdwwB4Cntj7HOnnbgVw
 nuh43o6JU+bOKsLLgrUkA1rSDgi+8wl3b0eK/9CBcN5UcUMvATl0IlViKxt54OWG5toL
 sxwv5FcJl0io7PiYiNiNOkMERj8Hb3foyQwdACEDfG3lRAV5LZ8+UjnayR/lromx8gkk
 fFYA==
X-Gm-Message-State: AOAM530u6ZHzYdYLOyZnucBfTMkhskL7mLc4261rIwhe/u6whvzLKf89
 wD7W5PRKIaj9QvNuBO1RrqYNsxT+9FA=
X-Google-Smtp-Source: ABdhPJxNW73H0oOuOXL6LlO+tYIMk/Z9NE32Le9285U+9eofddRNeK4NSNWPqmr15r1TXaAeUuyRIw==
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr27126074wrl.124.1602496747289; 
 Mon, 12 Oct 2020 02:59:07 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x3sm14141947wmi.45.2020.10.12.02.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 02:59:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/21] target/mips/cpu: Introduce
 mips_cpu_create_with_clock() helper
Date: Mon, 12 Oct 2020 11:57:55 +0200
Message-Id: <20201012095804.3335117-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201012095804.3335117-1-f4bug@amsat.org>
References: <20201012095804.3335117-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce an helper to create a MIPS CPU and connect it to
a reference clock. This helper is not MIPS specific, but so
far only MIPS CPUs need it.

Suggested-by: Huacai Chen <zltjiangshi@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/cpu.h | 12 ++++++++++++
 target/mips/cpu.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 062a4ba6225..d41579d44ae 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1307,4 +1307,16 @@ static inline void cpu_get_tb_cpu_state(CPUMIPSState *env, target_ulong *pc,
                             MIPS_HFLAG_HWRENA_ULR);
 }
 
+/**
+ * mips_cpu_create_with_clock:
+ * @typename: a MIPS CPU type.
+ * @cpu_refclk: this cpu input clock (an output clock of another device)
+ *
+ * Instantiates a MIPS CPU, set the input clock of the CPU to @cpu_refclk,
+ * then realizes the CPU.
+ *
+ * Returns: A #CPUState or %NULL if an error occurred.
+ */
+MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk);
+
 #endif /* MIPS_CPU_H */
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 3deb0245e7c..23f7b4508a4 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -287,3 +287,15 @@ static void mips_cpu_register_types(void)
 }
 
 type_init(mips_cpu_register_types)
+
+/* Could be used by generic CPU object */
+MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
+{
+    DeviceState *cpu;
+
+    cpu = DEVICE(object_new(cpu_type));
+    qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
+    qdev_realize(cpu, NULL, &error_abort);
+
+    return MIPS_CPU(cpu);
+}
-- 
2.26.2


