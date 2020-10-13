Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBB5C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE0A23138
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwvgVy0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE0A23138
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKM7-00014q-36
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSKJI-0007FP-QW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:25:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSKJE-0000pN-Pt
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 09:25:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id b8so10825948wrn.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=orbtnIXME7eI8Z8OOzrxbeZteV0enZumXvxzAJ1ns40=;
 b=DwvgVy0Dcq4RzoKe5jWzYGaHt1u8AlfHniI7udTUBR4eMvNAWZMd/7f9Hwp7jM/Rx3
 EmacVZ20Jcgz0oGt2Gll7A0kiR0bgX8IhpTYilHPwp8I8dHBaxkfkzXbFc53tpPG/mBT
 jBh0W/m5woPSSUIgmNIxGlwReQofS2MXTQjJoW1TQhLLgZwnIg49iHrUYlk42EPmtnZ4
 /WHQOTiWFc1AqwC6AddPuL6gV4bymWvr0OwBpsh7irezEO2xTbyiKP/V29GreahSx1sB
 +WhzYBM9S4uLbPNkRfFMeCuaGi0RPCJhbWpN67Kji+o/BMwUpqdLbUG/s9z7IpMVeRSp
 jWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=orbtnIXME7eI8Z8OOzrxbeZteV0enZumXvxzAJ1ns40=;
 b=ua3wsLkYkj7m2dpWeWMTmnTmQzeH0L9+MIuPweGBpzRBE1Geg1mNzxES3WC9YzDw2A
 cZ7h/uUOPPDq/xXOQoenCt0tCl8FEoKq81nCKmW4pfwH0tBeczWolBWqLVPNZ3q/1TMh
 60QfBpz7Pf2tE7Eb1Bp06PjEWaLtJ99P9dfuzUwbiMd4hvssUAzLgAkliPoMVal4blIx
 ShNNPIYBVBCKokj+64OQbIpkbmW25RQTessd9xelj71Uf+upDkvBCULcy5Xq+Pjda+E3
 l7KNt29f5JGwpDH9em2m3JExZEhA6taBBd5DXt05F6ZSKe5YcqY0Kd5RvrRyGR6izoQx
 hZzQ==
X-Gm-Message-State: AOAM530GW9NvSEZ5H7Etq6VheUZXh6+VDJJcDi8Lx5J9GHneBMxSCSO3
 nbFd3XTLDG/iPqyN1xLPpr5N0EvlQnw=
X-Google-Smtp-Source: ABdhPJxuPuytI/LrtTAqkTfYc8qzhnN8MkXMX9zxPUFdbLbLS9QNjGRB3giEPLNDBRBh3owhT5kGSg==
X-Received: by 2002:adf:f1c1:: with SMTP id z1mr11761614wro.331.1602595542614; 
 Tue, 13 Oct 2020 06:25:42 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id g139sm28521298wme.2.2020.10.13.06.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 06:25:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Victor Kamensky <kamensky@cisco.com>
Subject: [RFC PATCH 1/3] target/mips: Make cpu_mips_realize_env() propagate
 Error
Date: Tue, 13 Oct 2020 15:25:33 +0200
Message-Id: <20201013132535.3599453-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013132535.3599453-1-f4bug@amsat.org>
References: <20201013132535.3599453-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Khem Raj <raj.khem@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be able to propagate error to our caller, make
cpu_mips_realize_env() take an Error argument and
return a boolean value indicating an error is set or
not, following the example documented since commit
e3fe3988d7 ("error: Document Error API usage rules").

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/internal.h  | 10 +++++++++-
 target/mips/cpu.c       |  4 +++-
 target/mips/translate.c |  4 +++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 7f159a9230c..c2b2e79c515 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -206,7 +206,15 @@ void mips_tcg_init(void);
 
 /* TODO QOM'ify CPU reset and remove */
 void cpu_state_reset(CPUMIPSState *s);
-void cpu_mips_realize_env(CPUMIPSState *env);
+
+/**
+ * cpu_mips_realize_env: Realize CPUMIPSState
+ * @env: CPUMIPSState object
+ * @errp: pointer to error object
+ * On success, return %true.
+ * On failure, store an error through @errp and return %false.
+ */
+bool cpu_mips_realize_env(CPUMIPSState *env, Error **errp);
 
 /* cp0_timer.c */
 uint32_t cpu_mips_get_random(CPUMIPSState *env);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e86cd065483..117c748345e 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -147,7 +147,9 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    cpu_mips_realize_env(&cpu->env);
+    if (!cpu_mips_realize_env(&cpu->env, errp)) {
+        return;
+    }
 
     cpu_reset(cs);
     qemu_init_vcpu(cs);
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 398edf72898..4c9b6216321 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -31316,7 +31316,7 @@ void mips_tcg_init(void)
 
 #include "translate_init.c.inc"
 
-void cpu_mips_realize_env(CPUMIPSState *env)
+bool cpu_mips_realize_env(CPUMIPSState *env, Error **errp)
 {
     env->exception_base = (int32_t)0xBFC00000;
 
@@ -31325,6 +31325,8 @@ void cpu_mips_realize_env(CPUMIPSState *env)
 #endif
     fpu_init(env, env->cpu_model);
     mvp_init(env, env->cpu_model);
+
+    return true;
 }
 
 bool cpu_supports_cps_smp(const char *cpu_type)
-- 
2.26.2


