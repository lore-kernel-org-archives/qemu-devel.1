Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0FAC388F7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C912224E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGoG4XUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C912224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuaP-0002Y8-UP
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1K-0005a9-RD
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:54 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40663)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu1H-0003xo-0F
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:54 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so2783520wrv.7
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5nfpzWU6BWZQ/unvn/jtnNuBbIIj9jq3hDXWSf3EW64=;
 b=HGoG4XUh3DL0F8obt22WCybl0g//prPVx+o72G1ITdvpwt3pyGpCEw0RPz+d5yZVDE
 AjswTHNn2R2CBtgmbz5wdheTTbAJCI8xTv04TGDvPdaIQPfgh1sflPXgUsTeyQGrpJL9
 Sl93tWpzSjP+wjiiCSOTq3IuSrfxy15Kzwf7sy+i6jqr0ayejP8aI/OmbsO0SmiwX7HW
 IDtWZpD2oCj6cWh/BF8Z3ZDoDfpBbpeiYKjbq5wqR/UBdAZA2FfR44SPMEeLo0Tg/+TY
 uo1uDzT/5vG/gLbEA43TSBFwx+Z47UnyB4MGwT2iP9QeTeD3w4hjkEvv/tLuj39Mr0fR
 2AnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5nfpzWU6BWZQ/unvn/jtnNuBbIIj9jq3hDXWSf3EW64=;
 b=FTKO+oa65Sf2OhcrKiGfDiQXCmXKUIoErtiuAZQhny1m3wMqaZT9MeRJhkKtAjixfC
 ybA9kCuGTFIgo+4oJ2ej74YJt9aVBArxNSYY8424hLmWMZHbnCb7alzlIvfalRfLdu9f
 z+duudx3/IPE6M2SmacpdzTqzUOq5Vd68i3agFFPefs19sXKNgOSnEot/3Wp/j6TRjFB
 KC8qpqBEJeiKkfYfT8eR6OWzlfnbjiVQodKXIiifTr7KI5iPHxkGOiVslvjXGkj98Pjc
 03s3E24Z/CGEVfTSh68gOyuMuCaru0sGvqPDkIbZ/aokwo0QAJixvpPlTr8zOSx2rbyc
 K4lw==
X-Gm-Message-State: AOAM530Y6yK/JExWYCSD2UnrqCHDeyqBKaxgp/8fmFewxztELMYNLoXc
 GphZRfmJz8pxn6I1ruADz3pBocJU6eoJTg==
X-Google-Smtp-Source: ABdhPJwZMerkEdTq3/vyE5ficgxRR5GfXmsi2uHVXgNYWwOaDMdDDO0s7bwLmOjPRkpsOQDNzT185w==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr4281079wrv.36.1603209469250; 
 Tue, 20 Oct 2020 08:57:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/41] linux-user/elfload: Fix coding style in load_elf_image
Date: Tue, 20 Oct 2020 16:56:49 +0100
Message-Id: <20201020155656.8045-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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

Fixing this now will clarify following patches.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201016184207.786698-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1a3150df7c0..290ef70222b 100644
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
2.20.1


