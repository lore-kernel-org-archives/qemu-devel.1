Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBBEC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A573E207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoIDMQLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A573E207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVIHp-0003sg-K0
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3l-0006UV-NY
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:03 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kVI3j-0006SM-2c
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:38:01 -0400
Received: by mail-pf1-x444.google.com with SMTP id h7so1909055pfn.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tcQiTVPZ4EDkEsGCvdGZmCD7eErMNKvjpgH4j/u5Y8I=;
 b=OoIDMQLVZbuk92/VKrSIe20T2WfqrPoyPIEZs65mjRaVg1XQbW7bPXw+v4qBANTZ6R
 i/AD7oNFZa5Y1A4H7oE5mZg/LIxpYIcyH0GjByCodoMSPtYAOWi4jST2k5qQ3wvh9ERB
 w11MZR58c/QORQsACqj1pAq3wqN/KexD0Xh2tOo3arL5hrjjygNziO+9vpR+4Tzb0AsI
 QSwoTnKm0yicoAxsSI7pfGrs+KKCabT0NB4zvjSn0mH+rVQEhPEoJLpQc5s4+qJu6j3k
 oJY+i8ayLt9MTzx+UMHhh4iWYjJ08KB04dl2fdFdrdohxXvCEsKYv6dT3y54tQaeABDH
 kabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tcQiTVPZ4EDkEsGCvdGZmCD7eErMNKvjpgH4j/u5Y8I=;
 b=nAkK0mR7f04dSH9ftn2gXrNelJ38ABeIlk8y4LhOiGPNU7kKCPHSafmAhlsZsL+eeN
 J4CHQu7l8RM0UQkkwNTtIVMC8qvoaaFUsTFkEJvQZHxgJw1WwqTzq4LMDIqkfMdytRuj
 gsS5KwOypVUBoVrHKZQUO3NFO8Q+Nksku/hIR+PADk59DahZsdVCoWsYi1G+tqk171ct
 pL4JH2Pt7K3uvXjo3b+ahp8dekVDp1eMCY07goGQH/QQfGsArKMekBZ4mJMDWMRjN/J5
 tgJikf6Z5GcyBWBKJlzp2bq6YmPoFr5LAaiT7tzqKlQZwWBq7kWhr03ZOOaKvc3MS5w1
 hoWQ==
X-Gm-Message-State: AOAM531bVGEJOOFeglHBXdkIvTODnYfto4HMqRfeQqs22IkKFW3hUx/I
 rq1DxZl0Em3nHzGRRCY2BzNRDHM6VgvLUQ==
X-Google-Smtp-Source: ABdhPJz8hCC9Lz3q3xQovQ857JoaGVWA/whzxfPCQubkEB6qq/WsfKhEpy+5nsDIcim6LY3/qcwCqg==
X-Received: by 2002:aa7:908d:0:b029:15f:d774:584 with SMTP id
 i13-20020aa7908d0000b029015fd7740584mr300509pfa.6.1603301876889; 
 Wed, 21 Oct 2020 10:37:56 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h5sm2928829pfh.9.2020.10.21.10.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:37:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v12 04/12] linux-user/elfload: Avoid leaking interp_name using
 GLib memory API
Date: Wed, 21 Oct 2020 10:37:41 -0700
Message-Id: <20201021173749.111103-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021173749.111103-1-richard.henderson@linaro.org>
References: <20201021173749.111103-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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


