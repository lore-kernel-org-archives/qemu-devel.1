Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AF6C43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 364D220725
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 18:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BIq43mfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364D220725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTUia-0002QK-6O
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 14:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgP-0000V9-8B
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:31 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTUgG-00026e-Ct
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 14:42:27 -0400
Received: by mail-pj1-x1041.google.com with SMTP id az3so1842483pjb.4
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tcQiTVPZ4EDkEsGCvdGZmCD7eErMNKvjpgH4j/u5Y8I=;
 b=BIq43mfIl6tPMcY1In/e2r93+woPXqHZoyGSA8eMLv2FIRvOtQ9a1kuUSIjsoN6lOI
 T2jIycCPbQAcU2X/v2GBYGnWd2hsAaALrejJrmkjH3Hn9ZmDcqD6ohIhgcGO0P8yj2Fn
 gHQALboLEEgdaKOOc3ooPWif2spFY+X1bhXIuivndCsynXb+e4Fclc6gwuEhnYbDESPX
 n2rOhuXRaxFP5Mg7HTrtx6jz3YEVDtt2UVGHItxk/H0/PZSaoW/vUk5i6EYTyucAUMIL
 ljl60noBwvmFXZfaJ8S3Q5wFBwUFnfNmFDyVZaqPkViQk9QflU+tpvYFfC1ZnRi6amZL
 mNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tcQiTVPZ4EDkEsGCvdGZmCD7eErMNKvjpgH4j/u5Y8I=;
 b=JhjJqHMGVfUkOdTc3nE8Q22tqFWjR24WmW/E/xBK5SCcCmsAb9kWQrOfUecV8UC0MD
 ob/p1ARsM1TbNazPNI4gmi83myNCd7HJvvIe/iybxAnWHBp3/UiyS+/xK6bMPHHuldMg
 5pHnskSovGI2o5gNI9YfdE8wkx4PjMANseTbUBxa0c3B3J75BE6bZ4WQJrB5C/T+VbA5
 xO7giW5AJYm9W6YQj1RCAdOmn/K4xLRLs0RdC8ZWF3TCAtjZIygBk9ocoVc5nvG423nd
 BA95vuk9bPKFtryaMyab4FpZ7d/seGTNt56WmM+OMIfo66DBvDujxjxrI5Tx7rnZg9yi
 ZqWw==
X-Gm-Message-State: AOAM532bhsPThUvZZFYlUGTehgameL5hpsEXyrHVb608ash2DTtvwnEo
 MS3DLwFVuwnnyVg3xIpA6SzjMkr+f7lVdw==
X-Google-Smtp-Source: ABdhPJyY6cd47FDfccdN3dhaPcSnA7qoUywjqtl2kuQYqDWbXvCmsDteT4ZxzTaHdA1rQXeo7n+OPw==
X-Received: by 2002:a17:90a:8596:: with SMTP id
 m22mr5218160pjn.42.1602873736199; 
 Fri, 16 Oct 2020 11:42:16 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c15sm3426011pgg.77.2020.10.16.11.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 11:42:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 04/12] linux-user/elfload: Avoid leaking interp_name using
 GLib memory API
Date: Fri, 16 Oct 2020 11:41:59 -0700
Message-Id: <20201016184207.786698-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016184207.786698-1-richard.henderson@linaro.org>
References: <20201016184207.786698-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
 laurent@vivier.eu, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Fix an unlikely memory leak in load_elf_image().

Fixes: bf858897b7 ("linux-user: Re-use load_elf_image for the main binary.")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20201003174944.1972444-1-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f6022fd704..1a3150df7c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2584,13 +2584,13 @@ static void load_elf_image(const char *image_name, int image_fd,
                 info->brk = vaddr_em;
             }
         } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
-            char *interp_name;
+            g_autofree char *interp_name = NULL;
 
             if (*pinterp_name) {
                 errmsg = "Multiple PT_INTERP entries";
                 goto exit_errmsg;
             }
-            interp_name = malloc(eppnt->p_filesz);
+            interp_name = g_malloc(eppnt->p_filesz);
             if (!interp_name) {
                 goto exit_perror;
             }
@@ -2609,7 +2609,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                 errmsg = "Invalid PT_INTERP entry";
                 goto exit_errmsg;
             }
-            *pinterp_name = interp_name;
+            *pinterp_name = g_steal_pointer(&interp_name);
 #ifdef TARGET_MIPS
         } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
@@ -2961,7 +2961,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
     if (elf_interpreter) {
         info->load_bias = interp_info.load_bias;
         info->entry = interp_info.entry;
-        free(elf_interpreter);
+        g_free(elf_interpreter);
     }
 
 #ifdef USE_ELF_CORE_DUMP
-- 
2.25.1


