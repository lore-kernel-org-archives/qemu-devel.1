Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BB8C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:33:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C4E2076D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPzZr+LS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C4E2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOAK-0004Yh-4K
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPN-0001Co-N5
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:44:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPG-0004RC-HH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:44:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id n6so1489064wrm.13
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=UjqYDN2HcJB9MuNc+XxxOQlH1H1YaNBWkczMJdA8sYE=;
 b=OPzZr+LSfsZ3rS/pqQVS8FVd3wH9NU/LNmrjyIRbOnFBtz9sDEQLwvTfUTC8NQldPg
 Un4WQyCSxEYC7nITTsECSYF1sghifKy5xjyp0WL6vuLZasPQ7LuIAqupEtzbm2W2jkmJ
 6dydSr/TGQAVBl9ckJIHDYIQR5XTJ9Zaxa7ehwmY99tQAv/GPgOv+U6TqLNE2pxtYm1F
 gYiiy6vHWT85HbxokdrHfzRXehlkivHF6rGTf8cs/fEmHE0EiJ8H9LUYxhvXobVGL5ov
 IxZdkOEaoR/ZjgNXar+C/D4os8ffQAr+CHRI4eDfJ0GwZxzHQ61NS5/MRtPd9SLN5/5R
 li5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UjqYDN2HcJB9MuNc+XxxOQlH1H1YaNBWkczMJdA8sYE=;
 b=q68r8c3xD6SOvoAnXaME6YBAAzzopKPiAeyL3JsoYkgQNvJLvD3QDdGu7JmpKBG3Qz
 Uj4fbYQX9ov3ZMyVGIoj4YrWs5rZyIhaAh+6N1Y+txcnM4lEr5mJYMpgWxmMKVTKlIwL
 ZK6AXeujG6CWzZ/RR5MMfQLdz8Ji/zmaXzdQL7c/h+LrDkr+tBG2gdBRDqWyyGQCT5Mr
 NUSko2IDz/xG6WnForelqIGzXxVXs+xgEN9KFxmdKJVy8R/rGeXHg31ZmLq5998jPvpt
 mtc7qM9TYRz141B72OEGKziCCkDJnYGaSbg0CwGtUG1lzb2bz4aysTbrIUXNKM4BSCo0
 QTtQ==
X-Gm-Message-State: AOAM533fT9vCjFYAU7jFIyNVqF7lZbE0yS8OVeh57Sfi/vgldyCTAQ5v
 OIT7CK4+UwaIWri0bKAqjg+lHx3Aryr/gA==
X-Google-Smtp-Source: ABdhPJx/GlFikjXUSVoKUGq/5eEEdIWXgIeTwK22eci/dYuj5EOlkr+oyQbBmWRw6v0nrkWDbq3xYw==
X-Received: by 2002:a5d:6407:: with SMTP id z7mr2557037wru.271.1603799088031; 
 Tue, 27 Oct 2020 04:44:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.44.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:44:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/48] linux-user/elfload: Fix coding style in load_elf_image
Date: Tue, 27 Oct 2020 11:43:55 +0000
Message-Id: <20201027114438.17662-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Message-id: 20201021173749.111103-6-richard.henderson@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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


