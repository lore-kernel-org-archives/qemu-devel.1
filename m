Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCD2C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FB92244C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 18:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NoUbKxpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FB92244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIP1-0006EC-Kg
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3x-0006g6-Hq
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:13 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3u-0006Uf-6C
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:13 -0400
Received: by mail-pl1-x643.google.com with SMTP id 1so1583264ple.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kGZNmudBhXIU/a8gp/KXcyIKcPKoqtSco3EGBov+V2s=;
 b=NoUbKxpW3VhC+PWgLSxnCQTeahhzhagmdmde0QQeat3O5qHiw6hSLW8n1O57vyK1EY
 oIxiBKpVz82L/3ku+RrZGf5DKOx59IaBIMd3UwUYmg4c6HpN+XDY10L7/auGic1RQU8z
 S4rclsYwA4p52fjPeQViETn8Vqw6YC768SETF/n97JHCaj4vNvdW6YGmAnQDPiHNOc3m
 PJPCXmhPUUot51A7EX8FJERHhdQrn0pMiLrlFoK7IiSl+glUw0hFHCAJPAtkcqDMUmWD
 pKWLm3xz+FQgjFiOtaQTad6IivEnXY+++hK2mgAIGQ4hu00kjjKiFtBLyOgvGxL6HOcn
 KKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kGZNmudBhXIU/a8gp/KXcyIKcPKoqtSco3EGBov+V2s=;
 b=DcKDa1fmnxat+c56tzWX1kxSpnWzKAwAwAoaNdjgYbv1CgtI9FTdiz2O9IbLzRz+HA
 GFNP/ZNQfDJ4Yh6GskfRVk96jvcXXxwRHuUuUZpjtFxX8JuBoFVfmgEOQ1nddTWwtC70
 SXwDxhibJJfxmucNbsHozt7NQL/u+87Ikay1W7kZIXErgOhHiiivoZqAnONgbPM7pWHK
 vp5WvFnY5C7X7g7pRtyELVyGgvDY1riUFMl07D0DGZu7pYE5qWe8xyd0bWEyvsgkqL+U
 XE1a8tRqhGdi+m6ryhlX9V5CNGDUXxuC904bFXpSOuI74pzPSjnHMr9MfygIBumnpcsX
 NWkw==
X-Gm-Message-State: AOAM5330MZaJvtf2/Xcmek0qlnEApDJKHnKlATCvkUJzRsbiSprJIv2C
 tYbATQoCtg3e46GhkKK18ARdnLV7hjeFPA==
X-Google-Smtp-Source: ABdhPJzoafBy+ad2vMGdAlW4743GlbVD10bCPorz0DA+Z9ptQl0Iz1KU4tY6N+hf6F06uaLcL5F2Gg==
X-Received: by 2002:a17:90a:cb86:: with SMTP id
 a6mr4215936pju.161.1603301888152; 
 Wed, 21 Oct 2020 10:38:08 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h5sm2928829pfh.9.2020.10.21.10.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:38:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v12 11/12] linux-user/elfload: Parse
 GNU_PROPERTY_AARCH64_FEATURE_1_AND
Date: Wed, 21 Oct 2020 10:37:48 -0700
Message-Id: <20201021173749.111103-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021173749.111103-1-richard.henderson@linaro.org>
References: <20201021173749.111103-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: peter.maydell@linaro.org
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


