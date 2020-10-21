Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADFAC55179
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535802098B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTfU1Yq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535802098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVINO-00049d-Ah
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3x-0006fO-9b
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:13 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3u-0006T5-5C
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:12 -0400
Received: by mail-pl1-x644.google.com with SMTP id 1so1583148ple.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i9e477C0zg/4lfiSUJ/DUA8jokwPxP/mv4JJb8OtKrE=;
 b=hTfU1Yq5A14rUMvyRNdxWZNn5fDVheCb/WYZeB/u5humMA4BjkoEg2kBSvgzsjEPut
 gWry1Tk0U7AWQtqrNFphogmL4BzUqrkLeUOqF1h+/8NrPfxsaBOWsbTMyGNjuzfTzGiw
 0hTKb6+JHFhg0Bd+Tg6az9QNdqxpAe1VLfbF2Bh7/X+cdXyr+6ItqMAiU0URS3E8zje3
 k96aE8D0MU4t9rIjI3mP4P+XE/krI5GxqxKQwP+Hfph1yLL/ATcxdriI0jKJCP0vQHfu
 ijKIzSuY7U/25BrKcpqAW2sz9zu7676XGGfOhUjH5Pxf79DkET30EUhEgkNiIWN0rwfh
 q7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i9e477C0zg/4lfiSUJ/DUA8jokwPxP/mv4JJb8OtKrE=;
 b=dIrENPTeVRcK0MwaD10KzWKZG1D17TJUZ3GOtn/TNCPCcr9VC0ykmOK7QW3FL52U1M
 dYHYPIEYLbletTEyuSw5EIYYZZgKTzfaicqN73cv4AMr5ucq4Y6Xfnq7BFrJ+9Foq7GJ
 YTwSGmJYxgliRdtCxo3zH3wJrGFGXh7DDZYJsV8lJbo8lga8/9Z9h1t2m8TgP/LzT8/N
 yk0j/yOFzN+SGqWw4wNyeaqldOfxRGdOZExZL1JsIKXYZlR8qcSKfp1EJlTHiudg/7B+
 qYYp3/K3dRaMhWcf8jsJDb8ThnV4mFQK78hxUsN1vg30I2tyKBnJyBOV1E319D9Qc4aE
 mI5g==
X-Gm-Message-State: AOAM533omyUlmztM289qBZ0iXnbgVX3kKOPAeSHmRtSnIz0km1RFW2Ae
 fK7oAQSMowBodnxmUQf+Tsq3Am9Ba8XGGQ==
X-Google-Smtp-Source: ABdhPJzvI5PtwUlcSlkNe+Wivj4+f2aHNxepKoXFvghkFrTMH5B2fgYKqgE4/87j2SMQ4LN03TB/EQ==
X-Received: by 2002:a17:902:9f96:b029:d4:c459:a181 with SMTP id
 g22-20020a1709029f96b02900d4c459a181mr4759859plq.28.1603301882721; 
 Wed, 21 Oct 2020 10:38:02 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h5sm2928829pfh.9.2020.10.21.10.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:38:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v12 08/12] linux-user/elfload: Use Error for load_elf_image
Date: Wed, 21 Oct 2020 10:37:45 -0700
Message-Id: <20201021173749.111103-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021173749.111103-1-richard.henderson@linaro.org>
References: <20201021173749.111103-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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

This is a bit clearer than open-coding some of this
with a bare c string.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 107a628a9e..56fbda93d0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -12,6 +12,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
 #include "qemu/selfmap.h"
+#include "qapi/error.h"
 
 #ifdef _ARCH_PPC64
 #undef ARCH_DLINFO
@@ -2392,15 +2393,16 @@ static void load_elf_image(const char *image_name, int image_fd,
     struct elf_phdr *phdr;
     abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
     int i, retval;
-    const char *errmsg;
+    Error *err = NULL;
 
     /* First of all, some simple consistency checks */
-    errmsg = "Invalid ELF image for this architecture";
     if (!elf_check_ident(ehdr)) {
+        error_setg(&err, "Invalid ELF image for this architecture");
         goto exit_errmsg;
     }
     bswap_ehdr(ehdr);
     if (!elf_check_ehdr(ehdr)) {
+        error_setg(&err, "Invalid ELF image for this architecture");
         goto exit_errmsg;
     }
 
@@ -2444,13 +2446,11 @@ static void load_elf_image(const char *image_name, int image_fd,
             g_autofree char *interp_name = NULL;
 
             if (*pinterp_name) {
-                errmsg = "Multiple PT_INTERP entries";
+                error_setg(&err, "Multiple PT_INTERP entries");
                 goto exit_errmsg;
             }
+
             interp_name = g_malloc(eppnt->p_filesz);
-            if (!interp_name) {
-                goto exit_perror;
-            }
 
             if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
                 memcpy(interp_name, bprm_buf + eppnt->p_offset,
@@ -2459,11 +2459,11 @@ static void load_elf_image(const char *image_name, int image_fd,
                 retval = pread(image_fd, interp_name, eppnt->p_filesz,
                                eppnt->p_offset);
                 if (retval != eppnt->p_filesz) {
-                    goto exit_perror;
+                    goto exit_read;
                 }
             }
             if (interp_name[eppnt->p_filesz - 1] != 0) {
-                errmsg = "Invalid PT_INTERP entry";
+                error_setg(&err, "Invalid PT_INTERP entry");
                 goto exit_errmsg;
             }
             *pinterp_name = g_steal_pointer(&interp_name);
@@ -2520,7 +2520,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                             (ehdr->e_type == ET_EXEC ? MAP_FIXED : 0),
                             -1, 0);
     if (load_addr == -1) {
-        goto exit_perror;
+        goto exit_mmap;
     }
     load_bias = load_addr - loaddr;
 
@@ -2587,7 +2587,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                                     image_fd, eppnt->p_offset - vaddr_po);
 
                 if (error == -1) {
-                    goto exit_perror;
+                    goto exit_mmap;
                 }
             }
 
@@ -2623,7 +2623,7 @@ static void load_elf_image(const char *image_name, int image_fd,
         } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
             if (eppnt->p_filesz < sizeof(Mips_elf_abiflags_v0)) {
-                errmsg = "Invalid PT_MIPS_ABIFLAGS entry";
+                error_setg(&err, "Invalid PT_MIPS_ABIFLAGS entry");
                 goto exit_errmsg;
             }
             if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
@@ -2633,7 +2633,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                 retval = pread(image_fd, &abiflags, sizeof(Mips_elf_abiflags_v0),
                                eppnt->p_offset);
                 if (retval != sizeof(Mips_elf_abiflags_v0)) {
-                    goto exit_perror;
+                    goto exit_read;
                 }
             }
             bswap_mips_abiflags(&abiflags);
@@ -2658,13 +2658,16 @@ static void load_elf_image(const char *image_name, int image_fd,
 
  exit_read:
     if (retval >= 0) {
-        errmsg = "Incomplete read of file header";
-        goto exit_errmsg;
+        error_setg(&err, "Incomplete read of file header");
+    } else {
+        error_setg_errno(&err, errno, "Error reading file header");
     }
- exit_perror:
-    errmsg = strerror(errno);
+    goto exit_errmsg;
+ exit_mmap:
+    error_setg_errno(&err, errno, "Error mapping file");
+    goto exit_errmsg;
  exit_errmsg:
-    fprintf(stderr, "%s: %s\n", image_name, errmsg);
+    error_reportf_err(err, "%s: ", image_name);
     exit(-1);
 }
 
-- 
2.25.1


