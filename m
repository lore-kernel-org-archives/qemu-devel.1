Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7D7C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08CB22264
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woATf8gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08CB22264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNlc-0006sR-Vf
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPQ-0001GB-5D
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:00 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:45666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPM-0004Rx-Bx
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:44:59 -0400
Received: by mail-wr1-x434.google.com with SMTP id e17so1490641wru.12
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9VkN0cyk2uHfxylP6EyCwu4+xF47dFUm4oQhbHYvOuY=;
 b=woATf8gzJSDU2QWuARXckT8wkvOYiNkj6XgwmWrLqXmA5DlB8zdYrxbyv0knSrrlRN
 dG2cHnoJyGTuVuriX8aVRgloRam+qNhz+sJ5OxIh6BjWp2lGdBt8fHEtZ2FB9VXhjeyq
 qWB25PTQN7DsZNDRtqYZ4SASJzKnq9YQFCRw6WCF0jLiOd6evjvyJNTi4Bhdfahwrz/p
 qGVSbpF4mFhSMkSgItd/1lWxiAYKbCnZ+eR0tkJZ7bRDigWAkRJlnB7yqysO89y/cYA3
 3gdyCKk6DfK6UwV7PdtIr1uU4OSw8Q9+cCqHgPgqWNuPn4k7V5FjKZiQC9NKNLlbtqDE
 BjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9VkN0cyk2uHfxylP6EyCwu4+xF47dFUm4oQhbHYvOuY=;
 b=j/NIKLJ3a1JPPrpXn4XC9/g9KIwn4xVD5beChxFjAlQty7SPahh+e+wWhjwWbEjl1J
 Ih0/d8XFr//hWFVFlKf/9vSytcr3eHv3GMYTzOfQ1q7t8KfgI2PhcaPhmqdnaWaJfFYX
 cWndwyKySlJ6fEp6tWQTAqhJYaWA1sl6mAa8SpnMTo+j9YSHPYrs52tADrLt2C2YMR4Q
 DrWFBXFSE8K89AxLKuikIOT0qXZ/jzk1zRyDRGe4wp8XaYLJW01nntIEFwzjK4f0zui2
 Hr5OSDRpC3U8RdrlB1SeT1lCDgA95whm39kTsmAVpNtQPK/yZ6VWx1p3aiJrUHwxM5hs
 9T3A==
X-Gm-Message-State: AOAM530pHajgxwY0dLdwFAFXiXl5mKU1ocj2HwfFSias2S19nhnbd4zg
 NhNrRgQA4uOaXpFuMKkdqvwhrx3g3EUq0A==
X-Google-Smtp-Source: ABdhPJxhDBl3bUOOodWTxxX2ScM5zf6ktRgP/3m5xwn970sJvXPTPjwFhT1nMKVFqcDYv3tNYzZcbg==
X-Received: by 2002:a5d:4fcc:: with SMTP id h12mr2540270wrw.132.1603799091533; 
 Tue, 27 Oct 2020 04:44:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.44.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:44:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/48] linux-user/elfload: Use Error for load_elf_image
Date: Tue, 27 Oct 2020 11:43:58 +0000
Message-Id: <20201027114438.17662-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

This is a bit clearer than open-coding some of this
with a bare c string.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201021173749.111103-9-richard.henderson@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 107a628a9ee..56fbda93d02 100644
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
2.20.1


