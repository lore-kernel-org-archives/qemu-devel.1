Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9282C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7373620789
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lew08UDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7373620789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ3qP-0000GD-42
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 20:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mS-0003xC-Md
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:36 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mQ-0006fk-Ri
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:36 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mm21so2151651pjb.4
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 16:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SKvqAs5Pc8xJl/wXmoS7uW6crsC2A5uj0Z02CZTb6j4=;
 b=lew08UDBi/ZTnefrK49cbOEQ9tgyvmsJ5HL4LWy9qf7kjKTXb4+j7psOmaXpNTOm5M
 FNZJyK/2Zshr8OutpwXmtuhTATBoyNdlg4ukZ08Wk6kxOvEIN0/qw+Kvu1BP0gFJe/5V
 vWoQaFIEkTM7dmCB3e3ORzcpKYkKbtgbMT7UGrKCZOax8JIaGOxQCyuOf/+v4HacnnsC
 BsuW/SNK3zzdYDvGMJHycDl58x8z+JSkFNbJpdelsw1ALkkF94AIoENvN3Sr0g/4+SII
 liGddFg0z+/KiVtHFM41c5X/YC2os+udspAJdAeOdVXnlq0I40oyXqdaARLV8zJcsyql
 iT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SKvqAs5Pc8xJl/wXmoS7uW6crsC2A5uj0Z02CZTb6j4=;
 b=anH0BxZDgsBgyOxoVi7B1C1nl6M5c33stWHexC2qzZkAFfyrHLxgeYq/2Con4PR1Ls
 xhrFWiODQAdvKbM0CMokrXncKk54wlUEXi5vZyPhfLX8JLGVS/qt7f0uE9a7EF5Hsa73
 sWHpc1KUXRlDwj3UQyxtP2sgix5JAX2Ae1bYzTlKsa4n4HYRnPv7jModYjlyBY6sy51Q
 Sxf6uMKVvNmMNAPLb2bjM/2rRVv/X6tQP47vxSzhgLQh3oAe/zn2sIwOyy2K2Re4Twg2
 5x2BtibAbqM7G11rseSycpSwcY+PKXJQZtJUKmBjZWykrBH6llzzhCBYx0M3DsLLN03T
 /8Lw==
X-Gm-Message-State: AOAM531KWgPCJQjNXzTPcrZ2ZT0xBB9gDNs42zWp9rRs7YkJHHZlrmD2
 CLuiQRw+myT9T3ez/gMSrLkIc8ryCGxQjw==
X-Google-Smtp-Source: ABdhPJzLDYmfhr8Amz3zEtMFPgLisPRuyEiM/qFlg4eyvwj5XZEpN6Azg6E82bUIabPUwidFEuezhA==
X-Received: by 2002:a17:902:b216:b029:d1:e5e7:be05 with SMTP id
 t22-20020a170902b216b02900d1e5e7be05mr13092874plr.56.1600387053072; 
 Thu, 17 Sep 2020 16:57:33 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m13sm772699pfk.103.2020.09.17.16.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 16:57:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/10] disas: Enable capstone disassembly for s390x
Date: Thu, 17 Sep 2020 16:57:19 -0700
Message-Id: <20200917235720.2685978-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917235720.2685978-1-richard.henderson@linaro.org>
References: <20200917235720.2685978-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: Thomas Huth <thuth@redhat.com>
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
index e16a2b051d..a2bff9d4ae 100644
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


