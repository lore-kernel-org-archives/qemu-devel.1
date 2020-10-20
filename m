Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BEAC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB702224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6ljUV3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB702224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuL3-00077a-NS
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1J-0005Z4-G8
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:51981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1G-0003xd-VY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id d81so2330608wmc.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Z0HMWgiSgaHAnfHC4nGM232rOSwhB2ZkX8mExK/8DHQ=;
 b=G6ljUV3lqm+5uTyg2aKi5HDLvCYnCRKuE4qYkWIxTlt0VJtFg4kGGxouDq9B2q58gd
 Bn55M20jqF3aKx2Bj6TjNGK3fTvmUSu09uTdLyUDa2BBRtX6xQl3hVZvWpbHgru/ocpG
 yorRThli/rEdYw5Ev02ca/FdjrAwQnowSgirvgkWm2JctModYdtSTS2hS38EAk9AJUDp
 t6CFlIKNOsBroPpatgxuXqDzBUoyHSjrLZW85D6+6gqIY9zVX8LX0oJjNgXJ0oapc/q0
 jjeNYqL5M0FE3SZKwydGZ/uDowviPX13KTiArQHFjA3t7Lb/d1E2U9/tsSaepAXEL8HK
 4TLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z0HMWgiSgaHAnfHC4nGM232rOSwhB2ZkX8mExK/8DHQ=;
 b=nwnDSsljjKpbQwire8mGcen+m25ES2EKWA6jE/DAZyi1Q8S4YlCXJpD1n9rMyNlXFw
 +NXxmeOTQBFIyNSCkJPBkqX1Qoo928UxHt37xIj4kTjxROXurL7sNBnGRc01mqNU4bLA
 O15ShpQgBSiMX6+wxJMFvGAtP6okl/B0a9vHQGwsaVJDMl4OaWFmA6i3nGMncG9yYPxB
 wp7PlWChDrsRi/umcs5+21kzUijLPZXX+JcHm0ZvIsAySMwVYBs0Y1WW451GoCjPAqc2
 l4uiZ5ksPsfX/1NrmjlK55/5Chc3Xr6cLuBM81FmRh8B+trXVvvTshgnno3Y2F2/O0vZ
 lHaA==
X-Gm-Message-State: AOAM531SetcQ3HM3uV+97MtpZV/7fzuUWzQFRz1IXmVoPQSJoo04Pi4N
 Wp0NQ9n1uFyLxYx4Y7bZtKz9qFAm3m4Vaw==
X-Google-Smtp-Source: ABdhPJwdWIW9lWwtB9bcHX5smUjYTCMPsuyu+AKGnByy9Q3D5OHdaYWc6wLY+a24/qFzfIL9p0mb6A==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr3458978wmk.136.1603209468042; 
 Tue, 20 Oct 2020 08:57:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/41] linux-user/elfload: Avoid leaking interp_name using GLib
 memory API
Date: Tue, 20 Oct 2020 16:56:48 +0100
Message-Id: <20201020155656.8045-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
Message-id: 20201016184207.786698-5-richard.henderson@linaro.org
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


