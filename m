Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97E9C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C47B21655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsDAbHhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C47B21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXO6B-0001Ar-03
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPV-0001Jj-Ri
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPN-0004SK-5F
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id n15so1552331wrq.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=wx1D7/WlF5vb0tirP6JgQb257M7QDCJnfU+OAvE8K6g=;
 b=EsDAbHhUJVeXOOkMniGOaf/iIsg05KE7hPX5cE3s0tI3LakmvG8loEinQ0B9Ao00Hp
 Aw+gEavn2H8KibHVRaJ4u0s1efpoF4gGPf5oat/ehqFBFoL0G3heBcurfRI62oLpe+69
 BZIGW/QCvOB6DYgCrVv0JsUWrH2ynQFbdsL6JumfQOvqbrqYX4hgf9hq9ThIDfKDfTVd
 q5lBNZrl6bNp+D+jH6A9DUhAGevt3MfyKCX2Bwi8vmzx5pbaxMELwm4wfbRgM06nB5TM
 GEXYGBpOHHHsQJjY3+qI0LU9sd8h6ZyhRTAJa0zOVEqJMLCQTyqYmhO/4pQaOy8dO5s9
 RHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wx1D7/WlF5vb0tirP6JgQb257M7QDCJnfU+OAvE8K6g=;
 b=Hprok4zb3ZcNSDEKYxCUii2YkAQw/Cd1knnZehvqEBJnX067yqzErTdk+cSBthsyDY
 YdQk1mtRtJ1jP3ikUiIsUD7S3Dy/oBWwUKqOol7deMaYeNY7gP2LykEJiMXpWzVyhdaH
 IPkWuKkku+fV/bms1cWnqW3NBELIdes/UB34xj+PxjyHBmsIPpwpWZdu1LvGWFRvZ+6c
 aPkAavZrr9VYSs6JjW5o9zhafM77SYvp8u5Sl5LmpW4zJIr/nrFR/y+5kN9qcKLAlMYm
 o1pOJoy/Pu9kmB/KTPT85GaecbCMQweqYjNaHwckU23x0z3IEtmHhmU4KPkVnmpID0kL
 15qA==
X-Gm-Message-State: AOAM530ji7M4gACfEJnbS0De37M7B/DYqlUcacR+9JxeyuK0l4/4ht29
 NJsMs9HagLwd/vqD0a7gifPMMEWFVKJBZQ==
X-Google-Smtp-Source: ABdhPJxVVLYqL5EDVKV1CtqRm0knLkQoFkYyA/zJg+1LVA/Mm3Lfrub2GXWnmyaVOUm2+CQqLWsCeQ==
X-Received: by 2002:a5d:6407:: with SMTP id z7mr2557686wru.271.1603799095384; 
 Tue, 27 Oct 2020 04:44:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.44.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:44:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/48] linux-user/elfload: Parse
 GNU_PROPERTY_AARCH64_FEATURE_1_AND
Date: Tue, 27 Oct 2020 11:44:01 +0000
Message-Id: <20201027114438.17662-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
Message-id: 20201021173749.111103-12-richard.henderson@linaro.org
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


