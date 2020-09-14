Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAFAC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A998B206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 23:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOwaxnA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A998B206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHxVj-0002tX-Oi
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 19:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxUS-0001Ew-Ua
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:02:28 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHxUQ-0006cw-6R
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 19:02:28 -0400
Received: by mail-pf1-x442.google.com with SMTP id b124so760475pfg.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 16:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KuC/kv5eCu0e0HbeQ2KRbyXfJmTxRoX2ga8TfPiXbIY=;
 b=nOwaxnA9zzNKafeNrDowTb6Sm3VGUHGu5wm+ytHRLiIzGFGds6QGmNPiSNHaI1yg2L
 fnleHnxYiJDoQk3/b0XB+3YExklvm8i18gWIrzadkukuD/L2tbKtcM7+RwYD4h+ZRCtd
 kVvbfhVgnOBWH4l8PBtxeNCi4tnPmXcmQhD3zBSJmBLCSZiOvMz1Hje4ncfNy1o44vgU
 cbrgrw1qMJL2uYBcLPQNKSlgPZV+Lg2RDlfEbo9Abuxe4o5AWuz9vOdZDrKq8U3VF/Dv
 7oOrL/2xFPbFYhTx3uykQxo4qqhnfLcKmPqWghFb96ie9sCYKzZvifOrY8MVckq8ie08
 qtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KuC/kv5eCu0e0HbeQ2KRbyXfJmTxRoX2ga8TfPiXbIY=;
 b=hovRZBwI/et3ezM9s1BmHrTH8LR5wzKlFntadfP705eSTLQLbJ4bJTunv9kCO3OFkX
 33TR5WLYVbb8GN8gG2D9Bttd9RnwEnja+m+vmWcloOmTt6VMS9C7dZ2jyn141WYDmFAf
 xqM/7S9NNkeIRO38Jfu4wtAalKxVROhMWvivguvlwkxWQffR5n4LRJlRHL7xCnrBlPK0
 hXA9gMCRDEbUYiIR/lSFnaHbioqXU8ZhGaAII1mUZsf0rmLxsuvuynmnvZFQpvbogVak
 4EOzK2WfuqcqGvsJxmSRTlILbrkFgJ/0XUD7laZ4LTVedqDOk06dJyQscZUdlUCK7+ER
 t6AQ==
X-Gm-Message-State: AOAM531u+jfcXSLKD8EfKI6w+eoM9C1pq6r+8tiBb/nkhYqXDQ5NOZMV
 IFkzHX5fiwNznMJ2av50JS27Kn830WHe9g==
X-Google-Smtp-Source: ABdhPJxR+SyQPYDI+MKacRfaLxTQgkJUZzrk+czeKaxhK7wLMz8XzxxWbGUg3F96jSS+BSQRLn+qew==
X-Received: by 2002:a63:753:: with SMTP id 80mr5881649pgh.347.1600124544378;
 Mon, 14 Sep 2020 16:02:24 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l23sm9106076pgt.16.2020.09.14.16.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 16:02:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/10] disas: Enable capstone disassembly for s390x
Date: Mon, 14 Sep 2020 16:02:09 -0700
Message-Id: <20200914230210.2185860-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914230210.2185860-1-richard.henderson@linaro.org>
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: luoyonggang@gmail.com, alex.bennee@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Enable s390x, aka SYSZ, in the git submodule build.
Set the capstone parameters for both s390x host and guest.

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
index 2f3da5d8c6..448c87f645 100644
--- a/meson.build
+++ b/meson.build
@@ -674,6 +674,17 @@ if capstone_opt == 'internal'
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


