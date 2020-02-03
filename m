Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6ECC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472F82080C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blArgvmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472F82080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd3r-0003OY-F2
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0b-0006qP-6f
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0a-0003Fb-56
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:29 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0Z-0003EX-VJ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:28 -0500
Received: by mail-wm1-x342.google.com with SMTP id p9so16235633wmc.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C0PdOrMCFpbNK82WNUW0H1iqrpAaqeLX3nijX9wXiI0=;
 b=blArgvmAvO/Dvnfmg9Ej5qvcGd3b2fg7n3cAkZ4oJnEwjP4QPH3YqLR2xALFzwFjy4
 OcA3FFA9loP5rTfVlmEDT5fzwjr2xw62EvWCpDEYuwKOZMjuXnp08ETJOuznLQF7VZbg
 Fjwvn8ALcoDzURyxaxvt5qgixkrl66lTjhRuspLoBW+ry5OtrtdjbZ5h12aovHtHZ3eR
 MVEqo6TH5uIwtHSSalzIcNH4uJ4jSPtngLPo1GWcjEHeyoY7NSgE9KV3LQgUwtYV5E24
 vt5r2pMibeF7AnabDE23vpV5sNv027GwkrvtlAMeC0ToCbPK6NtafWGb4ACKGICLaC9Z
 PJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C0PdOrMCFpbNK82WNUW0H1iqrpAaqeLX3nijX9wXiI0=;
 b=YM41hE5v7xekaCyTi6nJ9bSPAJOjDaHXKmr8pOIBo9ZWfCMm1SU2IjNyr18wx71Vl+
 PBqbyu+V+phFV3t6s0GgfRQMlPVcwmV9qSke0byxNZhf2n2TP2qbVXTtJVSNulA7MR9i
 rdSDV2chJj9hZYo27FCzlBTcLZzMFG319rAfpbIydliuPe9H+sEoouS8Vz8arJJ/YBAY
 l+vwLECnzkM+2KHLKhgDBreD83yOH/oiK4+yKfmnVww6gyRa88QfPc/mahdqLqQC+e2Z
 TUVs4pOCXSmY5nsXFHyF8Vq2u58y3vWlsPDzx5weGG30UIXy0tEcqeR6ZkZIW/oSSl7F
 Xsag==
X-Gm-Message-State: APjAAAU/fgYf90qyIfO1bPCh/sXpR1zoYWe6kaYMGqttQfg2RfJ7OMAm
 mjFw4Tn0jyTneRvt1jT85hMUg+PSRzppKw==
X-Google-Smtp-Source: APXvYqyg2ir4YWeay+SJ3FKeZ0G7iqSvMf15ajkdR43gn8G1uNLYc8QPYJVyvGxK7mxIzCyyX4gHSA==
X-Received: by 2002:a05:600c:2150:: with SMTP id
 v16mr29005049wml.156.1580741246586; 
 Mon, 03 Feb 2020 06:47:26 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/20] target/arm: Tidy msr_mask
Date: Mon,  3 Feb 2020 14:47:05 +0000
Message-Id: <20200203144716.32204-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The CPSR_USER mask for IS_USER already avoids all of the RES0
bits as per aarch32_cpsr_valid_mask.  Fix up the formatting.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 032f7074cb..2b3bfcf7ca 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2734,28 +2734,34 @@ static inline void gen_mulxy(TCGv_i32 t0, TCGv_i32 t1, int x, int y)
 /* Return the mask of PSR bits set by a MSR instruction.  */
 static uint32_t msr_mask(DisasContext *s, int flags, int spsr)
 {
-    uint32_t mask;
+    uint32_t mask = 0;
 
-    mask = 0;
-    if (flags & (1 << 0))
+    if (flags & (1 << 0)) {
         mask |= 0xff;
-    if (flags & (1 << 1))
-        mask |= 0xff00;
-    if (flags & (1 << 2))
-        mask |= 0xff0000;
-    if (flags & (1 << 3))
-        mask |= 0xff000000;
-
-    /* Mask out undefined bits.  */
-    mask &= aarch32_cpsr_valid_mask(s->features, s->isar);
-
-    /* Mask out execution state and reserved bits.  */
-    if (!spsr) {
-        mask &= ~CPSR_EXEC;
     }
-    /* Mask out privileged bits.  */
-    if (IS_USER(s))
+    if (flags & (1 << 1)) {
+        mask |= 0xff00;
+    }
+    if (flags & (1 << 2)) {
+        mask |= 0xff0000;
+    }
+    if (flags & (1 << 3)) {
+        mask |= 0xff000000;
+    }
+
+    if (IS_USER(s)) {
+        /* Mask out privileged bits.  */
         mask &= CPSR_USER;
+    } else {
+        /* Mask out undefined bits.  */
+        mask &= aarch32_cpsr_valid_mask(s->features, s->isar);
+
+        /* Mask out execution state and reserved bits.  */
+        if (!spsr) {
+            mask &= ~CPSR_EXEC;
+        }
+    }
+
     return mask;
 }
 
-- 
2.20.1


