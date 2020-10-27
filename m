Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BE2C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6ED222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgHDZgWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6ED222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNor-0001NY-R4
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPR-0001Gx-0Q
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:34812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPM-0004R3-Ca
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id k21so902031wmi.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=NehaV0T5jpi1H97RxmXskYUCuVVnNIGAcpGsWGzfotc=;
 b=dgHDZgWvMoIESm4JuNYAzCF4AF/OMQw5nOY5UHpRzCU2cDdj1FFSb95A9XFgDmZDaH
 QHJxudev+EjJ1puCGnWwms2ErZwnzWp4zJd8booKRl531mOqKMopeHd+2EBZjTAhAjYB
 GkefPny21+Cgxad/OyFtMs49lD3ERq5CVdnbH9OBr6Ux0lY5blUIwlY/79pTQ1d/1d/g
 euEmphIbD4W3cGQAlX1A0GbY080to2WyioEppmN9QU1yYd3Ya3je9oB6Vh3cNYjNzRo0
 79r6nD5YDdFb7E+ED82lPFJhJKOkBzjWhJU6n6X2WWWwpvPKsgIBMF+TVG159qKjBqof
 hCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NehaV0T5jpi1H97RxmXskYUCuVVnNIGAcpGsWGzfotc=;
 b=VNHtVOw8+5VCpz9p7a7ChSO1+o5qhpm1cCqRQYWZ++/pGWe9L2NDF9vyuHSsvpOQW3
 9D4OHIWKrs6ip17KRW0K5HQZTC5tBMyu87iOlMTQKVFLzXqHT4q2WcDdpbhbR6naRw8Y
 DX48KkP8jh9wLfFSCiQ5flIvOTFBEQPbS6GfkTbqDlRw0xkRtUHKZHtbmq0PIVe549Dl
 qyMmn3fU+zGLdWUgM1cWSGPP2yt8J1NuQ8YQEH/6Z/bEXAJbj7IjGCV+xBhXIypTC/T1
 EDn7Ns7V6UXvJu6f6fS/R7HcTbSSxb27X42c/8rSWz8H6QZtMcrUbsgPcXFztD2WW4wA
 Uymw==
X-Gm-Message-State: AOAM530bwpKF+AP9nycTFVxSy/Bc7/bdJkqNbCIKF2/8FFcsU9vHtV4/
 17vry3bN8KMAD6N3JAVfDFGzNnnGEnj0qQ==
X-Google-Smtp-Source: ABdhPJxT+Yhf/SyDdMFk1iMgoj23iopOKM3/Zkoam4tNBPyCy02UwHoS+vSOGQN19/fdwOXxZbWcrA==
X-Received: by 2002:a1c:44e:: with SMTP id 75mr2306810wme.117.1603799087009;
 Tue, 27 Oct 2020 04:44:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.44.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:44:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/48] linux-user/elfload: Avoid leaking interp_name using GLib
 memory API
Date: Tue, 27 Oct 2020 11:43:54 +0000
Message-Id: <20201027114438.17662-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Fix an unlikely memory leak in load_elf_image().

Fixes: bf858897b7 ("linux-user: Re-use load_elf_image for the main binary.")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201021173749.111103-5-richard.henderson@linaro.org
Message-Id: <20201003174944.1972444-1-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f6022fd7049..1a3150df7c0 100644
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
2.20.1


