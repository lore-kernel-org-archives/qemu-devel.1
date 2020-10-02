Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1725EC35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87C7920719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCe9wMsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87C7920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOTAs-0000E8-KC
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 18:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT63-0002hk-6x
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:11 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT60-0007PM-GE
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:10 -0400
Received: by mail-oi1-x242.google.com with SMTP id x69so2722590oia.8
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 15:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0BbDoe9J1HK0fsnnyytHHCY6uKzAPenEs5cQszBMvV4=;
 b=JCe9wMsrZyC3phlm+nCPDYtTM2wgzzXqQeVhag4Fj3984KbhMy/YCPnTQjD5V683ek
 80XUY8dr7UseqrBnHBh6eWTf2s/VIHtLkOqqLbF5zXwRbRMPZt0mBlRxO7efMVcAQzi6
 BT6QjzAwGnJZ5BMr6zybhOFVpOJ5Q3JyM3ngN6Hb4FToUgKzO0ToJGOrnSow9pQ1qIBV
 u2MS0ZOQWRJK6mka+A/Gn2JTVkxEyq5C7OgpYg5ydfHRrUkpB/kkRV0zIyF+NsYt12G/
 d5tMHQSvmeahqTNqfssPePXXKTVOgvZ+AMvDNA8R0j/3/ATySk3IYWEn4DIUFao9GG9x
 IRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0BbDoe9J1HK0fsnnyytHHCY6uKzAPenEs5cQszBMvV4=;
 b=rlaeZZc912kXKWkaNcx4bfysLCDeEDhfeQ7XD5sELaHFxSEcVApx5BN+b/PujcqoMs
 EaYsZCpSfknpAijn4bOjzt2GNeKlHo4JmalHPEZx6a4jQ4nfGBAgIg0g6m0GyjdAB0cn
 GmvbNwb+/KIduSOeh15v0uCvMMgNPeGgyXvflplyhMje4wGQjCfUrGPJoLfByFEjPFNA
 MymDB2nkzihkTntL5Brd1WuANU6YE0uIAPc5j+lcasxTslwlOKK4rrpofC00BJL5FpKm
 pJ9SjbyVeyf+GzqWMu5IEEwYe5cPyxb8Q1iV3cBsVT+Ez9oRxadcYVzecYBVvrxscrPN
 jM0A==
X-Gm-Message-State: AOAM532KTBpUUL/aGZMczJ3PNo89XbjXNW7AeJ+Kd+c+n5XnKQbg5VwO
 ioJaZ1ZMfIqbxt9Rm74piVddNJN8jstnt9YW
X-Google-Smtp-Source: ABdhPJwGR+b4eiNsToawk3uOhGkWc/zWtEQm5DkyAXxEm9dRSKNuhaVjnQOtySeTyCt2zBPWkufzFg==
X-Received: by 2002:a54:4d88:: with SMTP id y8mr2501987oix.97.1601676006853;
 Fri, 02 Oct 2020 15:00:06 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id k10sm684268ots.60.2020.10.02.15.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 15:00:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 6/8] linux-user/elfload: Move PT_INTERP detection to first
 loop
Date: Fri,  2 Oct 2020 16:59:53 -0500
Message-Id: <20201002215955.254866-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002215955.254866-1-richard.henderson@linaro.org>
References: <20201002215955.254866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For BTI, we need to know if the executable is static or dynamic,
which means looking for PT_INTERP earlier.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 60 +++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 735ebfa190..6b422990ff 100644
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
+            char *interp_name;
+
+            if (*pinterp_name) {
+                errmsg = "Multiple PT_INTERP entries";
+                goto exit_errmsg;
+            }
+            interp_name = malloc(eppnt->p_filesz);
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
+            *pinterp_name = interp_name;
         }
     }
 
@@ -2590,33 +2619,6 @@ static void load_elf_image(const char *image_name, int image_fd,
             if (vaddr_em > info->brk) {
                 info->brk = vaddr_em;
             }
-        } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
-            char *interp_name;
-
-            if (*pinterp_name) {
-                errmsg = "Multiple PT_INTERP entries";
-                goto exit_errmsg;
-            }
-            interp_name = malloc(eppnt->p_filesz);
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
-            *pinterp_name = interp_name;
 #ifdef TARGET_MIPS
         } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
-- 
2.25.1


