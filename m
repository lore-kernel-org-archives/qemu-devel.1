Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482ADC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CCD922447
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n0Zbg1pP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCD922447
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXO2k-0006FP-CA
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPU-0001Jg-Rn
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPM-0004Rh-V7
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:04 -0400
Received: by mail-wr1-x442.google.com with SMTP id s9so1514300wro.8
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RY/0B+cKSExVBa12aB38/wtYaK4XDoU9+twlxCjIWS8=;
 b=n0Zbg1pP3t50ZKg4KnGW8JY+wCB+LFZLiZlCF0slJ5KvlK5bcOHUEw9aei0w1igQTs
 BTyOInn/469ysYr5Cq/hYQOM/saG//cb3BDMTXDCMHCbnImLGTHM3xynSKiNAXkDNs2t
 Ty3U/RQU14sLfd7xEqKToCZCv7daCAFiEazoLEYZVvmMtY9RrUBAFylXjfE7rPJl2sk2
 +V3wg0VBlqatAqrJuZPN6tufcDPeD58J772WQS9BKZINOW3F2Sv8q/7GXYx27j3VC96b
 JrS9AnmUCTGo95fRdCbw9+kWy0nJzLtBH+5BdRvHVeCGpWGhdQT3aktZMvJBxeL1q5ix
 IT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RY/0B+cKSExVBa12aB38/wtYaK4XDoU9+twlxCjIWS8=;
 b=PwodCfKzDsb7XaBeyKl/YMfH544hrEkgKUk6JfQNPIuOB9A2Kq4/KKEEu4w8I3VNkU
 OyJWfl74ElVQ7VejbFwrYKVrzQd2+F6rUPko5UOHbKlqNn11reBEH5bPpC6QzQ98+Csj
 NekR0q+mez+97USZReUZ9Ga7e8JhWaBUk5YsSNxuEdinB/9WyUa3WInZ24kUMKxTi5a4
 F0g19hsDvvQhvrFwLPKDPm3HQYvVPjCmKiwqP9+HWp66uJscy2KylRbWQmRDRGUFKqGr
 tqNql6cPt5DdjQXW0VTTHbJsawQKGPD/vFsoIVoGHVvAIHUwduR0cn6onT0BxX788rjD
 VMDw==
X-Gm-Message-State: AOAM532uGPiHuawtMJtYw7WGNoLCeyC1FIkDwYe7CrID/xb+VNkgU0pY
 WD9//DKPqxZqS9SwFElt8cqqV6lVdO765g==
X-Google-Smtp-Source: ABdhPJwU27afmNbV+UFFWlNiyu4wAhB7TxaGCGwIHeOG88OxHi5skcduw8KIwNKucn6d3QO6fmmVQA==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr2415107wrr.300.1603799090335; 
 Tue, 27 Oct 2020 04:44:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.44.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:44:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/48] linux-user/elfload: Move PT_INTERP detection to first
 loop
Date: Tue, 27 Oct 2020 11:43:57 +0000
Message-Id: <20201027114438.17662-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Message-id: 20201021173749.111103-8-richard.henderson@linaro.org
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


