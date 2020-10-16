Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7EDC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7F72145D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPk1qod+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7F72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUp5-0007oz-UQ
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 14:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgX-0000Xe-CX
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:37 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgK-00028K-0S
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:37 -0400
Received: by mail-pg1-x544.google.com with SMTP id o3so1941911pgr.11
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XLExgzrLRIoZ+1AkNjtHtGQ6oai05Dc/yN88SMU2dO4=;
 b=hPk1qod+fK8AtQQrSb7TPV6K9ZeH6o4v5Hy6KIGmSclYFut1xPUDzTFQKBacGsalLz
 nQW64DIwzktBdMA+Nl1k0fRJQv7vPs5h2oruYo59xIbLxcSnQ4AkvW8Yp1pIql7mHZ6b
 VEkCAPTkO39Mjd0oOKm9ZurYx6KKpEHiSvo6UTa/2yZTRouCkZNbVVCCjEkmKmGdCPD5
 +kSi9O+if6bYOraccuVhleCD0gEl5h2tNFu1xUue/G7Me4ieOABxhdcRp/5LMOwX9cJN
 +hQalGw5bK/I3fr+mAGXcahuMiyrgXEbbnP/EoUgafb/mOjc2M3ChfVCSQJG+1K9wQqe
 Kg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XLExgzrLRIoZ+1AkNjtHtGQ6oai05Dc/yN88SMU2dO4=;
 b=KJD3y/8xBgFZuBWgeQua2I3wFGbOGoNjSrBHaJspzaTuq8a1hJN75wwUUf7mnonh8j
 G5hyqc5jfuOKOnBxakrCfCo21yXpucTcOzz71vi0bsiSD/6bglWrCv/q5Tv7aoxhvxXm
 75Rommde0qdEvArrwbJ78oMyB227v/oWafNeHebok795Uwt2BpUbTCNFaJFRGxMFN7SM
 Rf7OSG4tlzEHqGc9reNc5N3ordULNeG9MkYM/9LJQU9zuRz44OVnyNLDpbSx6QGZbB9k
 8ZMp197YZjh3nEfhlVm31D90Ya8KYBcctQYcgSKwwkTEBkVKCjz7l5vsSq/rjFV7aHza
 6Ffg==
X-Gm-Message-State: AOAM531mLJFkvzc/Ijr2DTGgkTjimnP0ONaGdhvvWxYTCGhsSEqwGTUI
 Pun7Q+Wd/nafMTrgnN0mT5IfYlZHt6Pp3g==
X-Google-Smtp-Source: ABdhPJweavnub6Y8gAoYuo2wCaYnYwsqEqkbeNMd+w8JQVgmsJQTAjEUSGzlkVW+97s/Ltt5clFI8g==
X-Received: by 2002:a62:7ad3:0:b029:155:7c08:cc9a with SMTP id
 v202-20020a627ad30000b02901557c08cc9amr4956913pfc.28.1602873740299; 
 Fri, 16 Oct 2020 11:42:20 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c15sm3426011pgg.77.2020.10.16.11.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:42:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 07/12] linux-user/elfload: Move PT_INTERP detection to
 first loop
Date: Fri, 16 Oct 2020 11:42:02 -0700
Message-Id: <20201016184207.786698-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
References: <20201016184207.786698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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


