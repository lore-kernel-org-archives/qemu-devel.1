Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C6BC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB3521534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8Sgmka4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB3521534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLPA-0007vo-UD
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGk-0007P1-SW
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:02 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGj-00072v-3B
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:02 -0400
Received: by mail-pj1-x1043.google.com with SMTP id b17so3463689pji.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=isaI5MdmjrbtBjf8VoptM4IIRi7lAgi5cvu7Yitun8I=;
 b=H8Sgmka4nfdqcYEWoKnbL5ekuNyccZKjAdONvGtToaQBV3qM313Sz5ukeLFUqHC87c
 g5iaNnFC4yB95skyKmYxkJRCDmrXoakHByFlMAUtKvITbWL72ltyzFOno4jpxQ8RTdKY
 UBEb+0vYpaW9421Yub/5Vp7qv7YCRVgrPHCjxRBF8evGtBhp8HJMOTr6/m9ND1j4q8p+
 va9j8mq/NDX+tJ/P4FSxoYFOA9hX0a/QwqqtAmTwQgDEgpcEjWfWzxjC2nr/JtX64UDr
 0HxO6RVNgz5svSSJcUeOvVMj2PClXw3aJlwS587fFUJRCJbKMAvXEmIFAZnckjRqo0kJ
 bb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=isaI5MdmjrbtBjf8VoptM4IIRi7lAgi5cvu7Yitun8I=;
 b=orK7JpBMLZT70wmOalB9J5NDmmy4LR6Yl2YFG4JMfyuyAYd/Jlznf4L9LMHrkaP/dm
 MAI7gRgP7S9MpzpeUEfXrI1TWBDV5KFvDk02nAN6otNIrQYDY45N28wx/jpJF7p/HyGv
 +U6hZszUvk8zYchu8VFFlYPuqPaWfEbC8LB9zuAWWxon7uHLq/+B3HdLMK5NsKS2hZj7
 BvLqhtqjm2JelMIY3sZz4q7ZBz1YZwJPkK1BjEvPFzM0Pe36fsyVfn7GsHbdigbg5sR+
 FLMpELJB/SvE/ERDCpBOpRmCU/xDPTE2XPhNrcMLO7Ya1gGPl7MMiC9FLpRc9gPTn9ff
 DFHg==
X-Gm-Message-State: AOAM5335B2B62KZQ4erI0njjkKDpEbbXwWvp/dj3xY8vIWYx8Fi8EoxO
 yS3L3ZGFu3XYt8lEIsVkUHY8zBvCjOorwA==
X-Google-Smtp-Source: ABdhPJxKhAvvigAIqlJRPyfU4frgfG0YUXRJXM5lVR9LFc/XXYeof+4uBDMYOT6eWQQgM5uNOPJRjA==
X-Received: by 2002:a17:902:c151:b029:d1:9bd3:6855 with SMTP id
 17-20020a170902c151b02900d19bd36855mr34064171plj.38.1600454279433; 
 Fri, 18 Sep 2020 11:37:59 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:37:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/81] target/arm: Add ID_AA64ZFR0 fields and
 isar_feature_aa64_sve2
Date: Fri, 18 Sep 2020 11:36:34 -0700
Message-Id: <20200918183751.2787647-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Will be used for SVE2 isa subset enablement.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Do not read zfr0 from kvm unless sve is available.
---
 target/arm/cpu.h    | 16 ++++++++++++++++
 target/arm/helper.c |  3 +--
 target/arm/kvm64.c  | 11 +++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6036f61d60..6f80a85fd0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -920,6 +920,7 @@ struct ARMCPU {
         uint64_t id_aa64mmfr2;
         uint64_t id_aa64dfr0;
         uint64_t id_aa64dfr1;
+        uint64_t id_aa64zfr0;
     } isar;
     uint64_t midr;
     uint32_t revidr;
@@ -1880,6 +1881,16 @@ FIELD(ID_AA64DFR0, PMSVER, 32, 4)
 FIELD(ID_AA64DFR0, DOUBLELOCK, 36, 4)
 FIELD(ID_AA64DFR0, TRACEFILT, 40, 4)
 
+FIELD(ID_AA64ZFR0, SVEVER, 0, 4)
+FIELD(ID_AA64ZFR0, AES, 4, 4)
+FIELD(ID_AA64ZFR0, BITPERM, 16, 4)
+FIELD(ID_AA64ZFR0, BFLOAT16, 20, 4)
+FIELD(ID_AA64ZFR0, SHA3, 32, 4)
+FIELD(ID_AA64ZFR0, SM4, 40, 4)
+FIELD(ID_AA64ZFR0, I8MM, 44, 4)
+FIELD(ID_AA64ZFR0, F32MM, 52, 4)
+FIELD(ID_AA64ZFR0, F64MM, 56, 4)
+
 FIELD(ID_DFR0, COPDBG, 0, 4)
 FIELD(ID_DFR0, COPSDBG, 4, 4)
 FIELD(ID_DFR0, MMAPDBG, 8, 4)
@@ -3886,6 +3897,11 @@ static inline bool isar_feature_aa64_tts2uxn(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, XNX) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SVEVER) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 88bd9dd35d..c0b84f9b99 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7414,8 +7414,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              /* At present, only SVEver == 0 is defined anyway.  */
-              .resetvalue = 0 },
+              .resetvalue = cpu->isar.id_aa64zfr0 },
             { .name = "ID_AA64PFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 987b35e33f..904d97bdd6 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -548,6 +548,17 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
                               ARM64_SYS_REG(3, 0, 0, 7, 2));
 
+        /*
+         * Before v5.1, KVM did not support SVE and did not expose
+         * ID_AA64ZFR0_EL1 even as RAZ.  Afterward, KVM still does
+         * not expose the register to "user" requests like this
+         * unless the host supports SVE.
+         */
+        if (isar_feature_aa64_sve(&ahcf->isar)) {
+            err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64zfr0,
+                                  ARM64_SYS_REG(3, 0, 0, 4, 4));
+        }
+
         /*
          * Note that if AArch32 support is not present in the host,
          * the AArch32 sysregs are present to be read, but will
-- 
2.25.1


