Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3600BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B955206ED
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KkQnKXqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B955206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUvc-00069T-MW
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 14:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgi-0000fO-5D
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:48 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgQ-0002AL-NT
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:47 -0400
Received: by mail-pf1-x444.google.com with SMTP id n14so1990483pff.6
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kGZNmudBhXIU/a8gp/KXcyIKcPKoqtSco3EGBov+V2s=;
 b=KkQnKXqAJpPxExziYSE5F6lME8UFZmYRo3UqCal0JjMWuckbI/lZHAC8pmcFSypTl+
 uhIjZaE880M8+3VY+bZKUFcRPyNrUjOeX41+kFLMx/zTklG0CeQFyz7nBAYtwn5X6gXk
 54yD+sIyPEXFmenJrYbpTeVYJgnCdqNwLLSPdFpn9haYsUmlsC50MTsUUwtYf/7SuAHX
 V61+yiOUGhMAGP3I0dgZvbN9alrs+rGCME2qG1YhCnCLPTna+kOUvqYqymGt9KFf6W9h
 NkmM/QExcb51nr1UqlE7Yd8qrY9/5fZciEtafXUA8WGadDId3yx807lpTkEO9n1TJCWi
 cKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kGZNmudBhXIU/a8gp/KXcyIKcPKoqtSco3EGBov+V2s=;
 b=Wb28M0uQRjiSEgTqDIzKht4ZD6u8asOGLExRDARrB6AtafKY/WVTstsjDV5abVn8cg
 xNblueucwFp7ORztdi/w2mzuscT6A5qJlMRWge4ckyOFtNrKo+ZYnNbZAqM/aUwmfacN
 rGrZyLod9JmbEL7JQz360rhWTPoSoW7X0BN/A3MTUsTHuwvS24x6B6bgVk1p4rSqhY4C
 1kEl8N6EIOzno9RXcEyqJ8DHXEe0j4vjBtVTaJS1ryTUfWstoxG2DCzfU1UfptlnXHNA
 2tOOK6UrdSZYqIAAe7HaRZNL/JvHfv9PV1prdUsPFS5DrjPAxANnK9cElts5XtQBVE9V
 oBEQ==
X-Gm-Message-State: AOAM533b3j0iAZCR3AysxV0ndMcQGRsX7E8945i9tuj1g975zA/GwgOI
 pLWm23J3zU+9y+xp4MLy9sbektERWEKQ5Q==
X-Google-Smtp-Source: ABdhPJzJge76pwJCxGj0+2oKCY6gqJLt3HoWJfSHXqqmhMmb41blUIl6ptCFBqumAjGTeYLG67IKhA==
X-Received: by 2002:a63:e111:: with SMTP id z17mr4234127pgh.267.1602873746958; 
 Fri, 16 Oct 2020 11:42:26 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c15sm3426011pgg.77.2020.10.16.11.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:42:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 11/12] linux-user/elfload: Parse
 GNU_PROPERTY_AARCH64_FEATURE_1_AND
Date: Fri, 16 Oct 2020 11:42:06 -0700
Message-Id: <20201016184207.786698-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
References: <20201016184207.786698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the new generic support for NT_GNU_PROPERTY_TYPE_0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v11: Split out aarch64 bits from generic patch.
---
 linux-user/elfload.c | 48 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 428dcaa152..bf8c1bd253 100644
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
2.25.1


