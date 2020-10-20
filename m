Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A710C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16CE2223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdhuRvpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16CE2223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuPd-0005qo-OZ
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1Q-0005jt-Th
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:58:00 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1O-0003yt-TK
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:58:00 -0400
Received: by mail-wr1-x431.google.com with SMTP id j7so2774569wrt.9
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8R4Ou6ltaxWaVYPwl0wl/jMrZU+UDDkqwU0qcucYDcc=;
 b=RdhuRvpOrnQ5qr4ztKa5yLNPCj52DQ1E9balA/C6PW6zucqfoFU226FZDcbdJTvGPM
 OZZhdTr+jgSxem1wMNN1ZDRWbiYDlCUd5lFCpK+8rovHDkBgfpPAiU3P2AGJtQVbNL3W
 PQWRv6N2HyYKU0ZalMm5XAbN0FwV0raAl/6s5FswlT0QtG12nvzknDIgMSFL/sAtfucu
 4THzsPBRm+eADL2a25Gxkw9qvzOzcWotrvVMMzcThPwrqDAbefcX5UQDwl+0+5RfBar7
 7g+zGrCu3fdMVM4aZCm86EtH7HvGUUIV1oYcgi6mfkbQJXNJ/Yy7IBsZp8jv+hzfMDNo
 n9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8R4Ou6ltaxWaVYPwl0wl/jMrZU+UDDkqwU0qcucYDcc=;
 b=lFXu6i70z6/20I2c66nMdjizX0gBHOhMB8WImwbsslrETR/RrBgNrNARUEZgHftIeA
 h10VPwOlF8AVqdcKdK0nnDPKMr6aRm4mzntxxvrtiLpW6hiOuD5bd5fNOQLhrv2GlXSW
 +SAoLYRLjy2T5Qy9NyK7Gv/Vp3FJ40TOolsdtlYzCnu9PCOAobp19HWjai3bIHxQYL4A
 uAtdgYyCC3zGTbCTj/NiouR6cF5CPXf+OCw1cLvI+P6uBzTq1gxcIT44cPuY+VsxmBHk
 nWee6N0xFOE0MnokV8WExDsDzKy08WQlh/GnqDYJgDtLTnOg6rafixl2WO4mrLzxpiC2
 0qkw==
X-Gm-Message-State: AOAM530m7mORaQUKX9x/MU5kWDSxPca7Y71wt3RyCqJWQulWM/CdyZtA
 Y6FYYhGbOUvk7TgIp62JRlRUAi/y5Pf45w==
X-Google-Smtp-Source: ABdhPJyJQA8JF5TfCTVSysBO3omCT3pxmJZqyw5XWu2AwXzgVNU7+k5ckDO5aIbutorlg/+Kb2J0Jg==
X-Received: by 2002:adf:f246:: with SMTP id b6mr4265868wrp.111.1603209477126; 
 Tue, 20 Oct 2020 08:57:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/41] linux-user/elfload: Parse
 GNU_PROPERTY_AARCH64_FEATURE_1_AND
Date: Tue, 20 Oct 2020 16:56:55 +0100
Message-Id: <20201020155656.8045-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Use the new generic support for NT_GNU_PROPERTY_TYPE_0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201016184207.786698-12-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 48 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 428dcaa1528..bf8c1bd2533 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1522,6 +1522,28 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #include "elf.h"
 
+/* We must delay the following stanzas until after "elf.h". */
+#if defined(TARGET_AARCH64)
+
+static bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
+                                    const uint32_t *data,
+                                    struct image_info *info,
+                                    Error **errp)
+{
+    if (pr_type == GNU_PROPERTY_AARCH64_FEATURE_1_AND) {
+        if (pr_datasz != sizeof(uint32_t)) {
+            error_setg(errp, "Ill-formed GNU_PROPERTY_AARCH64_FEATURE_1_AND");
+            return false;
+        }
+        /* We will extract GNU_PROPERTY_AARCH64_FEATURE_1_BTI later. */
+        info->note_flags = *data;
+    }
+    return true;
+}
+#define ARCH_USE_GNU_PROPERTY 1
+
+#else
+
 static bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
                                     const uint32_t *data,
                                     struct image_info *info,
@@ -1531,6 +1553,8 @@ static bool arch_parse_elf_property(uint32_t pr_type, uint32_t pr_datasz,
 }
 #define ARCH_USE_GNU_PROPERTY 0
 
+#endif
+
 struct exec
 {
     unsigned int a_info;   /* Use macros N_MAGIC, etc for access */
@@ -2545,7 +2569,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
     struct elf_phdr *phdr;
     abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
-    int i, retval;
+    int i, retval, prot_exec;
     Error *err = NULL;
 
     /* First of all, some simple consistency checks */
@@ -2712,6 +2736,26 @@ static void load_elf_image(const char *image_name, int image_fd,
     info->brk = 0;
     info->elf_flags = ehdr->e_flags;
 
+    prot_exec = PROT_EXEC;
+#ifdef TARGET_AARCH64
+    /*
+     * If the BTI feature is present, this indicates that the executable
+     * pages of the startup binary should be mapped with PROT_BTI, so that
+     * branch targets are enforced.
+     *
+     * The startup binary is either the interpreter or the static executable.
+     * The interpreter is responsible for all pages of a dynamic executable.
+     *
+     * Elf notes are backward compatible to older cpus.
+     * Do not enable BTI unless it is supported.
+     */
+    if ((info->note_flags & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)
+        && (pinterp_name == NULL || *pinterp_name == 0)
+        && cpu_isar_feature(aa64_bti, ARM_CPU(thread_cpu))) {
+        prot_exec |= TARGET_PROT_BTI;
+    }
+#endif
+
     for (i = 0; i < ehdr->e_phnum; i++) {
         struct elf_phdr *eppnt = phdr + i;
         if (eppnt->p_type == PT_LOAD) {
@@ -2725,7 +2769,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                 elf_prot |= PROT_WRITE;
             }
             if (eppnt->p_flags & PF_X) {
-                elf_prot |= PROT_EXEC;
+                elf_prot |= prot_exec;
             }
 
             vaddr = load_bias + eppnt->p_vaddr;
-- 
2.20.1


