Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1739C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C922224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZUgpZsMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C922224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuIw-0003uC-QG
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1N-0005cC-Aq
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1K-0003yA-Ez
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id a72so2331703wme.5
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yLHP+MWM/kiQHhSksWpmIgOl71BV9WcE6VdFocoDUmM=;
 b=ZUgpZsMCHfjVYDKXz1bdTr0OOwB7ZSyfRxRBihqoS3gHhCcbNvDUCfRTPD3bOlkpgY
 W1rSq/pfHQg3diwd53N1kvridyx6c32WeeVlGPmFc0+D1B4icZzurAZRQz3Q1/K6Qa2c
 JWxe8hB4aJXY2jeIBQ6ATLtMUCLLC+UHUmZc947o7fWhwe7ysZafdlJRPM8GXjW6ok7j
 c52w73r4N9aF2ThE1UVwMq3wGmx2iU/JcWtFSou9wQfbFqwZhnYGf1spO+q2QdCD6wuz
 9mgDIsE0eTZSWMRdV2xW2t8cr3Z3eTj3BiKAl2ucR9qO2B6zTZn78mEgXb/2uHbHq4W8
 KZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yLHP+MWM/kiQHhSksWpmIgOl71BV9WcE6VdFocoDUmM=;
 b=uVRqwCmP0NwxwIK0E8on5AODdWJ0SrdjOOJO2HvpWmdUPrMBWzIaxEaWszhJ2fha7u
 7bYzRAILa9PobTTrMcTUH+YVLTmPiG9jOelVV0NrUTdvxgBStzqi+b+LMDeOfrlXYqUJ
 qANtYKxPqq9JxsyuLfNeyMp8SrB/1tf4gOA+bgqH4igpfOlWkkt2dIXYz0iGE9IbMG3T
 eE2uB8XdkrcZ5VoxVYcS43PVEZjYI4jtLUDhLm7ZDEBzByQcG3QMQghDAhOuqNu4xSm1
 nzcFXJGxepEMRO4fMrNgDwKXTLhffwqDDPtEsDPxYt8f7iJusQpccOtLWTAHc23ReBPo
 LJAA==
X-Gm-Message-State: AOAM533S37wQ4kQH8k0G/QmG1bQJ0nC7BC6W7NxhWxcY7wbCkVfQAz+h
 2/7yCjMmTjVpEo4cMcg66TDtqTFS0Mj+ww==
X-Google-Smtp-Source: ABdhPJyJwc6Im9u/mR08HkGqduHDUQAGU2yuhpEFzRQkSl/qsdF0ight27oaaa0cISnfDPW/tpesow==
X-Received: by 2002:a7b:c349:: with SMTP id l9mr3607936wmj.148.1603209471934; 
 Tue, 20 Oct 2020 08:57:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/41] linux-user/elfload: Move PT_INTERP detection to first
 loop
Date: Tue, 20 Oct 2020 16:56:51 +0100
Message-Id: <20201020155656.8045-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

For BTI, we need to know if the executable is static or dynamic,
which means looking for PT_INTERP earlier.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201016184207.786698-8-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 60 +++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 210592aa90a..107a628a9ee 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2421,8 +2421,10 @@ static void load_elf_image(const char *image_name, int image_fd,
 
     mmap_lock();
 
-    /* Find the maximum size of the image and allocate an appropriate
-       amount of memory to handle that.  */
+    /*
+     * Find the maximum size of the image and allocate an appropriate
+     * amount of memory to handle that.  Locate the interpreter, if any.
+     */
     loaddr = -1, hiaddr = 0;
     info->alignment = 0;
     for (i = 0; i < ehdr->e_phnum; ++i) {
@@ -2438,6 +2440,33 @@ static void load_elf_image(const char *image_name, int image_fd,
             }
             ++info->nsegs;
             info->alignment |= eppnt->p_align;
+        } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
+            g_autofree char *interp_name = NULL;
+
+            if (*pinterp_name) {
+                errmsg = "Multiple PT_INTERP entries";
+                goto exit_errmsg;
+            }
+            interp_name = g_malloc(eppnt->p_filesz);
+            if (!interp_name) {
+                goto exit_perror;
+            }
+
+            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
+                memcpy(interp_name, bprm_buf + eppnt->p_offset,
+                       eppnt->p_filesz);
+            } else {
+                retval = pread(image_fd, interp_name, eppnt->p_filesz,
+                               eppnt->p_offset);
+                if (retval != eppnt->p_filesz) {
+                    goto exit_perror;
+                }
+            }
+            if (interp_name[eppnt->p_filesz - 1] != 0) {
+                errmsg = "Invalid PT_INTERP entry";
+                goto exit_errmsg;
+            }
+            *pinterp_name = g_steal_pointer(&interp_name);
         }
     }
 
@@ -2590,33 +2619,6 @@ static void load_elf_image(const char *image_name, int image_fd,
             if (vaddr_em > info->brk) {
                 info->brk = vaddr_em;
             }
-        } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
-            g_autofree char *interp_name = NULL;
-
-            if (*pinterp_name) {
-                errmsg = "Multiple PT_INTERP entries";
-                goto exit_errmsg;
-            }
-            interp_name = g_malloc(eppnt->p_filesz);
-            if (!interp_name) {
-                goto exit_perror;
-            }
-
-            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
-                memcpy(interp_name, bprm_buf + eppnt->p_offset,
-                       eppnt->p_filesz);
-            } else {
-                retval = pread(image_fd, interp_name, eppnt->p_filesz,
-                               eppnt->p_offset);
-                if (retval != eppnt->p_filesz) {
-                    goto exit_perror;
-                }
-            }
-            if (interp_name[eppnt->p_filesz - 1] != 0) {
-                errmsg = "Invalid PT_INTERP entry";
-                goto exit_errmsg;
-            }
-            *pinterp_name = g_steal_pointer(&interp_name);
 #ifdef TARGET_MIPS
         } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
-- 
2.20.1


