Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931BDC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECCF0222E9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8Tc/R58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECCF0222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVILr-0000tx-LI
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3u-0006Yd-V5
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:10 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:39837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3n-0006Sj-Cw
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:10 -0400
Received: by mail-pj1-x1043.google.com with SMTP id m3so408181pjf.4
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XLExgzrLRIoZ+1AkNjtHtGQ6oai05Dc/yN88SMU2dO4=;
 b=e8Tc/R58wCdYTQ2hvOg04zN84/j1Ce51unYv4lddeokkAQ5lyy+SUD2p+qiHGMiWjg
 HCfxguZzWItSLGQbnhj5rBzPSpjkW9Q0Ql/kI7A4gnYobZxboYKSTiMirNAYs+hsT9xg
 vgZm43SkUN826+bYjV7LstyN6kHCbYUJGFkzvDsNrFuPRFgdPs50cT45fy69ge4KSAOj
 Ll7RDE9nlnkupdUY0JXALI1H/QuuD9OQFh3smLzziPL87epVqwDsS4F3mYU8LrULxUge
 KOi217nlkoGn/Ze6mIJ+t2rf5Q3n4IhhWySpCDmjIbB6PcfVGlnJpqZbD6E90eoKyIFW
 cTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XLExgzrLRIoZ+1AkNjtHtGQ6oai05Dc/yN88SMU2dO4=;
 b=tRvsAomKMWoulHKggEdM3+w1f5AHGmOYio2e7/qranE5NE+2zCwqasOnr/DLTd0U+R
 aZiSyzwDXRzKuQUbW+Aiab2lDGW95rgQY0DGkIGZUBM7PZRxryX3eGjIAyYuBZzdxu9e
 tdJco7RgN80++4CcyvJJ7/QA6lUjKaj8BtM8dVkxio/kDF1g2hhQD3loGHWan6Il1kjM
 QDQ6RSP/R0tsawcFDtsIxEjWHvPiH4eDYCY90MsxAZ7taeiHTyJwetF0AHAO5sPJeIFg
 +DPzTCh8BY3Z/tN4vq2l8daRwzSSAJf87joTZTrSC7529xmG0oq6JgsG191hv6Rym1vH
 dXhg==
X-Gm-Message-State: AOAM532IjAgLAYNuA8HqbAaQoPlwgiF35WyvgT1rmhFOFBTXQusNJSjW
 sSlZSQQgQelZA4G21pVCYhua3eJII65oCQ==
X-Google-Smtp-Source: ABdhPJxTUESwvxIH0+jb/rLZXik5oyLqjzQdHqXB1yyZSXhfOoPSLX2IJdWCZ+njhUKzI81eF2qCLQ==
X-Received: by 2002:a17:902:bc8a:b029:d4:dc57:6c29 with SMTP id
 bb10-20020a170902bc8ab02900d4dc576c29mr4765610plb.77.1603301881450; 
 Wed, 21 Oct 2020 10:38:01 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h5sm2928829pfh.9.2020.10.21.10.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:38:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v12 07/12] linux-user/elfload: Move PT_INTERP detection to
 first loop
Date: Wed, 21 Oct 2020 10:37:44 -0700
Message-Id: <20201021173749.111103-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021173749.111103-1-richard.henderson@linaro.org>
References: <20201021173749.111103-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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
Cc: peter.maydell@linaro.org
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
index 210592aa90..107a628a9e 100644
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
2.25.1


