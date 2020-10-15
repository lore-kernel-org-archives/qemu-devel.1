Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F1EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6117E20678
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vp/qTnCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6117E20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTC3n-0004Se-9S
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 18:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTC2X-0003A0-JF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:48:05 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:40930)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTC2W-0003KL-5J
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:48:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id h5so425128wrv.7
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 15:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+UQ9QwYZAZfFcUZzRWl5ACf+Ossl/CGfr/vwWIb0pg0=;
 b=Vp/qTnCZf/9tvX54YkovcJ44R4EW3FcFyvOE7lVEcxOpxXm2xi4GSfisQiUkmzUcP1
 Kmzpn81Il7+tDrxgR4D6rjMoqjS/FPXKuihjnE6JpHLY+MgTLZ6sOUOYU2amQGUV4lF9
 XEpgMCsZ9NWiqoN+eA1N/hrSY5oqVvxi952OH0mDLnIDHxBnDkDBUJzL6GNzHm4tOl/5
 FS6hXWXOX1kMQshUzhXyf/arUsSL1yceK1er796NfuNWVrhVPKTuYn+mw2xW2siEppt+
 EZVmG2UPjmFPQdc4h93vCadbMIxegzkH5ygoOnLUXqqkgUC2oY2Kt0999g9f0w9lJaRo
 35WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+UQ9QwYZAZfFcUZzRWl5ACf+Ossl/CGfr/vwWIb0pg0=;
 b=MYlXswkk0VxzKCDoMsvJt3HdGvfGyjbcMqVdHLfpTVNLHa6tgOApRId8fclu/giaiA
 porJxPtIgN0sRBV1eWglLvKHP7UdayL9Q2QbKrJcSFZNGX3fE83+wTWFn7mcKyxdII/o
 VW+nX5VZIcbdpuN3j1ndfuRh1BK8IBHiB6yQLpZlppqey79sklz6lXEswu7hBA30T49v
 XgQL2ASlbDFySR7AuRkZ4LQSonXgMf/hV29EDxTA//5tfSJE4SmpMJw3VFNThecrOuZX
 ELluDbzu0+eO7jpaXMx7wSJZIr+i3SWJCyxQqzRcxVe3hMxSMSOlwwp9WVruNQuNApmI
 jeyw==
X-Gm-Message-State: AOAM5311BPFj29/T690xM3yq9YkbpB4ANNrTJN9TSde0xk1t4dmhF/HI
 Sw9//iRWpjYsgyxK41N9FSeKvkVD8EU=
X-Google-Smtp-Source: ABdhPJwDVulSWTHWtsmlSAZnT4SsXYcGttmFdVZYlUn1HnOkJSJU9zS2OG9mo7nvnjUC+E2a566iBA==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr506557wrw.310.1602802082567; 
 Thu, 15 Oct 2020 15:48:02 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u63sm622327wmb.13.2020.10.15.15.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 15:48:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Victor Kamensky <kamensky@cisco.com>
Subject: [RFC PATCH v2 3/4] target/mips: Make the number of TLB entries a CPU
 property
Date: Fri, 16 Oct 2020 00:47:45 +0200
Message-Id: <20201015224746.540027-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015224746.540027-1-f4bug@amsat.org>
References: <20201015224746.540027-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x436.google.com
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

Allow selecting the number of TLB entries from a preset array.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/internal.h  |  1 +
 target/mips/cpu.c       |  8 +++++++-
 target/mips/translate.c | 26 ++++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index c2b2e79c515..34f82c6e842 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -29,6 +29,7 @@ struct mips_def_t {
     int32_t CP0_PRid;
     int32_t CP0_Config0;
     int32_t CP0_Config1;
+    const unsigned *CP0_Config1_MMU_preset;
     int32_t CP0_Config2;
     int32_t CP0_Config3;
     int32_t CP0_Config4;
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 117c748345e..da31831368b 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -26,7 +26,7 @@
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
 #include "exec/exec-all.h"
-
+#include "hw/qdev-properties.h"
 
 static void mips_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -183,6 +183,11 @@ static ObjectClass *mips_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
+static Property mips_cpu_properties[] = {
+    DEFINE_PROP_UINT8("tlb-entries", MIPSCPU, env.tlb_entries, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void mips_cpu_class_init(ObjectClass *c, void *data)
 {
     MIPSCPUClass *mcc = MIPS_CPU_CLASS(c);
@@ -192,6 +197,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_parent_realize(dc, mips_cpu_realizefn,
                                     &mcc->parent_realize);
     device_class_set_parent_reset(dc, mips_cpu_reset, &mcc->parent_reset);
+    device_class_set_props(dc, mips_cpu_properties);
 
     cc->class_by_name = mips_cpu_class_by_name;
     cc->has_work = mips_cpu_has_work;
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 698bcee8915..f5815160fb6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -39,6 +39,7 @@
 #include "exec/translator.h"
 #include "exec/log.h"
 #include "qemu/qemu-print.h"
+#include "qapi/error.h"
 
 #define MIPS_DEBUG_DISAS 0
 
@@ -31318,9 +31319,30 @@ void mips_tcg_init(void)
 
 static bool init_tlb_entries(CPUMIPSState *env, Error **errp)
 {
-    env->tlb_entries = 1 + extract32(env->cpu_model->CP0_Config1, CP0C1_MMU, 6);
+    const unsigned *preset = env->cpu_model->CP0_Config1_MMU_preset;
+    bool valid = false;
 
-    return true;
+    if (!env->tlb_entries) {
+        env->tlb_entries = 1 + extract32(env->cpu_model->CP0_Config1,
+                                         CP0C1_MMU, 6);
+        return true;
+    }
+    if (!preset) {
+        error_setg(errp, "Property 'tlb-entries' not modifiable for this CPU");
+        return false;
+    }
+    while (!valid && *preset) {
+        if (*preset == env->tlb_entries) {
+            valid = true;
+            break;
+        }
+        preset++;
+    }
+    if (!valid) {
+        error_setg(errp, "Invalid value '%u' for property 'tlb-entries'",
+                   env->tlb_entries);
+    }
+    return valid;
 }
 
 bool cpu_mips_realize_env(CPUMIPSState *env, Error **errp)
-- 
2.26.2


