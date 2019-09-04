Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0787C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B926A21883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nP0gy5CA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B926A21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bWf-0006QC-FA
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0T-00057Q-LS
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0R-0002ke-CA
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:53 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0Q-0002j0-W2
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:51 -0400
Received: by mail-pf1-x442.google.com with SMTP id r12so1751751pfh.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uBQvYz8IHxhp6JSRYx+eAJLbYd/WxV5+vKoQFHwhKKE=;
 b=nP0gy5CA8F+hMVqR1RfqRCtQOYZtv4ByApFNWYu5Y7QSKSC84dP0ezc6vrzChPerie
 Qtvl0whj6iiKAoO2qPoOOv/F0M/kX5kHKwDKSw3Yrr5HZGXs006i5s1UsZh2oKdHNrTq
 sYNJcGaRKkWlY4NR7xiVn5Y9W2HvQFBzdr5Nbf+GTa+wory0Ud6cTdKFpISgDG2WYM1y
 FTXYewj4ikPmdcS1fc2OnwM5z/UMC1KA10K2RcNQhbIpDTntUoCgS0aUbm2MwbCSuojY
 yguEVQBlmL4KnPkpcG1yZ1c0CRI/TsRDBt19uulMMZLC6klP1nCaFEDl5Al88k8oS7Df
 YeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uBQvYz8IHxhp6JSRYx+eAJLbYd/WxV5+vKoQFHwhKKE=;
 b=uU/v+0g939z3eJdObCw6cBR5oH5GprYz/rOQjFQQnHcU5B0iMdrKTZ3Xbr7SrgjZ6P
 C0VjRKDidXmRLWV2ZQ6kVG0DjP3ewzM8J7pNNwZrfwWFnqaSN6tiIoCPM7ZsnCnW+wug
 yDM6eW+NOHPbS2D+jnyoM01vqdEZxNm1CemiZKUnsxI3y6zuw1J0riBFc6IIFjOjVdbB
 RFFbAg5uNMQpKy6Yl/BGTpoB3C9KrDAsO79GGMLQujcZsQcdJeLo8+cW5OT+Uboe7+Da
 jxFKWKezZH35B5k6OgFHZOyJgWepJsm/cp15e2k0CCDWpHM5YcNBBRezM1+cBJJKjCzB
 i1gQ==
X-Gm-Message-State: APjAAAXpAnwbq1qbOrvsMEfB6uYiWGDxb1u75/FOjDsdfSs+Q7r2aPLN
 WScbdhtnVLW2yubSwxDLSPFbUug+EDc=
X-Google-Smtp-Source: APXvYqxj0zaZOYoa9oLkmHv6q9vEuIy2XsuijlGAOeejWknllDPpB40oFQGPOmNiZgbNMJFPMTAYMw==
X-Received: by 2002:a17:90a:a40e:: with SMTP id
 y14mr6414114pjp.83.1567625509182; 
 Wed, 04 Sep 2019 12:31:49 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:27 -0700
Message-Id: <20190904193059.26202-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v4 37/69] target/arm: Convert SETEND
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 22 +++++++++++++---------
 target/arm/a32-uncond.decode |  4 ++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 664ea281f8..a599da96e1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10240,6 +10240,18 @@ static bool trans_SB(DisasContext *s, arg_SB *a)
     return true;
 }
 
+static bool trans_SETEND(DisasContext *s, arg_SETEND *a)
+{
+    if (!ENABLE_ARCH_6) {
+        return false;
+    }
+    if (a->E != (s->be_data == MO_BE)) {
+        gen_helper_setend(cpu_env);
+        s->base.is_jmp = DISAS_UPDATE;
+    }
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
@@ -10325,15 +10337,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             return; /* v7MP: Unallocated memory hint: must NOP */
         }
 
-        if ((insn & 0x0ffffdff) == 0x01010000) {
-            ARCH(6);
-            /* setend */
-            if (((insn >> 9) & 1) != !!(s->be_data == MO_BE)) {
-                gen_helper_setend(cpu_env);
-                s->base.is_jmp = DISAS_UPDATE;
-            }
-            return;
-        } else if ((insn & 0x0e000f00) == 0x0c000100) {
+        if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
                 if (extract32(s->c15_cpar, 1, 1)) {
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index de611e8aff..32253b4f9a 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -24,6 +24,7 @@
 
 &empty           !extern
 &i               !extern imm
+&setend          E
 
 # Branch with Link and Exchange
 
@@ -50,3 +51,6 @@ DSB              1111 0101 0111 1111 1111 0000 0100 ----
 DMB              1111 0101 0111 1111 1111 0000 0101 ----
 ISB              1111 0101 0111 1111 1111 0000 0110 ----
 SB               1111 0101 0111 1111 1111 0000 0111 0000
+
+# Set Endianness
+SETEND           1111 0001 0000 0001 0000 00 E:1 0 0000 0000  &setend
-- 
2.17.1


