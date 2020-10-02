Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4587CC35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B886620719
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 22:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/tYdAfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B886620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOTAS-0007zI-RW
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 18:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT5z-0002bm-GR
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:07 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOT5x-0007Ok-L1
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 18:00:07 -0400
Received: by mail-ot1-x341.google.com with SMTP id c2so2882297otp.7
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 15:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qqi4bkkjlO0OmQq7eFe7VQbO2qUT9g9kE2iVHKsaR1Y=;
 b=D/tYdAfSWu0ZA5cfpaVheM9LeiEXdHESrKwiijJO4u4y4Hzr7YKDhdI6POpbmRmMDT
 HYJ+tI9rpda5rPj6D+yfeQAcIc4GawSxyqowSJmLtGFLMMiCjCGpuPQXsGYSyx9y2od+
 sTkbuVKwsBtlUkgL0tSE/zdtYlTqC9a6cFgnft1PcNoHUkMrE7PpmcpzyBHW2WhicfsR
 V/ucHr8VACjlh46A+RsaH7BGekU8rE1V96T+HF9grOOwVNyC7BI1VhlmZA7940RHRTY4
 JnP8fzh6SCp8HMLP8Wozvu7MLeObRKKRX6Ex0EPFA8uShLnuise4tc7NbXS1OhzG0X5x
 aXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qqi4bkkjlO0OmQq7eFe7VQbO2qUT9g9kE2iVHKsaR1Y=;
 b=Rkb4e7yRFVqSWHe2BVWDP6PbdlMRQxliEGMmLKnGZsnmTT7DUVFMUx70mKAnYeYYeH
 Ntz2hklMsvkZAs9q6dJZWWpwJc2F/gdmE0m0XZZoluAql7Zq3RrecvMvf6eCz5ugsfyw
 4pgE9dGJef5FcpMSVvLHbmu8DtObj1R3T0Ofy5W5P7OSBHOeYnNmS0rk1IRxfHbg1qVO
 N18BNvpgTZq+0zsFJIulOedt2It5Ors9KQ0aHmR5Wn1xM6ssUjkJwE6hwop+A96We3Yd
 VeJTTlHORwXJBro05FV16Z7jeygXI/LALfLlC2yDjU2vzfUY2YGcUKZGKvZpgzcpgaM8
 cA8w==
X-Gm-Message-State: AOAM533OCHg/WGtR+OkbpaDpAaPszM6v4kOM3+o4ue3CMSeOebjejdAN
 PKixokk1oUqGp93aIiCh5XKwt5Mar+ziTTtQ
X-Google-Smtp-Source: ABdhPJwOMMrY2zqmaVeVWtgvqkV+NEiKiqKLMo/z8+xqSqfWlq9BoXCLN0wwVWtoAfApe2gWmoCnnA==
X-Received: by 2002:a9d:4c0a:: with SMTP id l10mr3189312otf.166.1601676004063; 
 Fri, 02 Oct 2020 15:00:04 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id k10sm684268ots.60.2020.10.02.15.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 15:00:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 4/8] linux-user/elfload: Fix coding style in load_elf_image
Date: Fri,  2 Oct 2020 16:59:51 -0500
Message-Id: <20201002215955.254866-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002215955.254866-1-richard.henderson@linaro.org>
References: <20201002215955.254866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x341.google.com
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
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixing this now will clarify following patches.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f6022fd704..7572a32a30 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2531,9 +2531,15 @@ static void load_elf_image(const char *image_name, int image_fd,
             abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em, vaddr_len;
             int elf_prot = 0;
 
-            if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
-            if (eppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
-            if (eppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
+            if (eppnt->p_flags & PF_R) {
+                elf_prot |= PROT_READ;
+            }
+            if (eppnt->p_flags & PF_W) {
+                elf_prot |= PROT_WRITE;
+            }
+            if (eppnt->p_flags & PF_X) {
+                elf_prot |= PROT_EXEC;
+            }
 
             vaddr = load_bias + eppnt->p_vaddr;
             vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
-- 
2.25.1


