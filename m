Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89442C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E830B20BED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 17:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S921QOqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E830B20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQ2j-0007Rx-UB
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 13:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKPp0-0008CE-Uo
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:41:50 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKPom-0000J5-Pw
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:41:49 -0400
Received: by mail-pg1-x543.google.com with SMTP id y1so9666144pgk.8
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=avZ+rMB6lV+f9plLNYbILt3X5fXdFe2OIgJnsNYwFZg=;
 b=S921QOqLUyaL2A/lUKrPYYLUsvHyFPlowKVG2hf0LXU/GaEOYR6zyF2k0rhAWD1qxQ
 NvV1qURUWJ2Bn+1Wm8Lbh2TINzMBDMGweY7OX0/e7a53L3e7V+a1iIn5BxDqiiasmV0b
 ILpf5BWcxtxGS4cEa8URxs/ga+xDCXLK2jjSVMgu3axPLWGXDA4cUlaJLQuo/2yJc/yy
 gtnXnst3iVEszd6oU8nSDnLpIAfBjN2c89A/h9hl+4UfeqbDUhC+5awXmy7ecKkYbaZQ
 VaW3lzUiDxKr+6rd0eeThpMSCRechrfdToiYLewSEVD9JKnDPOAwAP+VU00pdaXvYjw7
 mm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=avZ+rMB6lV+f9plLNYbILt3X5fXdFe2OIgJnsNYwFZg=;
 b=ZgF18gIoGv8JO5S5Rmr+PT07z3y0eTacQpRSOiXuXCBYIOL3sivs7D39WreiSwUPXC
 CNwP9mjsKxyjmTftiA1cFiC4CO4FxZvC+yIMghhCfVNKId333sKt5pXchaLNKIdOJc4D
 MvixY56G6iUHgBgzAvW0NWAK+4bXQCKAi2fJ4iLbN1SzsEDGld8VtJd+Iu2D3I35y/iE
 Y9ODNW/SVRG3fJ57AsTevU2Go4lIE3LsenOZFLWCx7WaIzBCacE6DURNEvxsjBEbKHMW
 cqVC94yDqe5TRqYt0V5eT5fgybgM2M3M0LcH1YqbWcSvLfNSq1jC+xRANgl4Al1pCfx7
 /C8Q==
X-Gm-Message-State: AOAM532CxbrvsiZwRD2IWB8qoxuD4Cddc0r0u+rskcocAK4EO7qDGUJb
 +jt95otcPGrKhc+4RCwvP+W3CG4kis5twA==
X-Google-Smtp-Source: ABdhPJz2IS+BVU/J6hY0+o24VuknSkagfMNLzCcp0Tk8KpdJGEae5aKESulD+l6eRENsBf4ga2ZsuA==
X-Received: by 2002:a05:6a00:1b:b029:13e:d13d:a101 with SMTP id
 h27-20020a056a00001bb029013ed13da101mr770182pfk.29.1600710094500; 
 Mon, 21 Sep 2020 10:41:34 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x4sm12585379pfm.86.2020.09.21.10.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 10:41:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/11] disas: Enable capstone disassembly for s390x
Date: Mon, 21 Sep 2020 10:41:17 -0700
Message-Id: <20200921174118.39352-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921174118.39352-1-richard.henderson@linaro.org>
References: <20200921174118.39352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Enable s390x, aka SYSZ, in the git submodule build.
Set the capstone parameters for both s390x host and guest.

Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c            |  3 +++
 target/s390x/cpu.c |  4 ++++
 meson.build        | 11 +++++++++++
 3 files changed, 18 insertions(+)

diff --git a/disas.c b/disas.c
index e27dea2c19..c4cd305190 100644
--- a/disas.c
+++ b/disas.c
@@ -201,6 +201,9 @@ static void initialize_debug_host(CPUDebug *s)
     s->info.print_insn = print_insn_m68k;
 #elif defined(__s390__)
     s->info.print_insn = print_insn_s390;
+    s->info.cap_arch = CS_ARCH_SYSZ;
+    s->info.cap_insn_unit = 2;
+    s->info.cap_insn_split = 6;
 #elif defined(__hppa__)
     s->info.print_insn = print_insn_hppa;
 #endif
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 749cd548f0..2a96692691 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -44,6 +44,7 @@
 #include "sysemu/tcg.h"
 #endif
 #include "fpu/softfloat-helpers.h"
+#include "disas/capstone.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -182,6 +183,9 @@ static void s390_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_mach_s390_64;
     info->print_insn = print_insn_s390;
+    info->cap_arch = CS_ARCH_SYSZ;
+    info->cap_insn_unit = 2;
+    info->cap_insn_split = 6;
 }
 
 static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
diff --git a/meson.build b/meson.build
index f06e3a1b65..d9f021837b 100644
--- a/meson.build
+++ b/meson.build
@@ -670,6 +670,17 @@ if capstone_opt == 'internal'
     )
   endif
 
+  if 'CONFIG_S390_DIS' in config_all_disas
+    capstone_data.set('CAPSTONE_HAS_SYSZ', '1')
+    capstone_files += files(
+      'capstone/arch/SystemZ/SystemZDisassembler.c',
+      'capstone/arch/SystemZ/SystemZInstPrinter.c',
+      'capstone/arch/SystemZ/SystemZMapping.c',
+      'capstone/arch/SystemZ/SystemZModule.c',
+      'capstone/arch/SystemZ/SystemZMCTargetDesc.c'
+    )
+  endif
+
   if 'CONFIG_I386_DIS' in config_all_disas
     capstone_data.set('CAPSTONE_HAS_X86', 1)
     capstone_files += files(
-- 
2.25.1


