Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCECC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360CD20771
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2v3OJW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360CD20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ3uv-0004qH-62
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 20:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mV-00044n-Co
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:39 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:33663)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mS-0006fy-05
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:39 -0400
Received: by mail-pj1-x1043.google.com with SMTP id md22so3469653pjb.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 16:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wjvg2SPI3pDSrleHGUZpH6t3zzxOiZw90GPESZPEUKw=;
 b=A2v3OJW5miBkSu4Cj8Dsdolat5v9+DoDIoaQcRXEkq80SDP+GHvMxVJi49PHt4qUWn
 sXobC9chgcp9SEj9H0obUWOP1z3Ndm0uWpRG3W7+1McMDu7zNIEN7EKP1bLXWsjWAd/4
 BypOi3h8m9fIJcUO3RxDkUlNT0sHSTp/EvI2sAUHnNdGIzmaKXFv6h6znT3uGvwz/F9O
 U/Lee6rR2dyePqPHL13FXJdRtFsWW5ZEWDn49OCLXYjTMPjegzvRvrNWJZZvjNds9Xi3
 30wNZgsYTXDVWy48DFyOP29xPUimxyuN44HRLkp5diQndcZEtf9ZiuLRfVBqkdi7sSxm
 D97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wjvg2SPI3pDSrleHGUZpH6t3zzxOiZw90GPESZPEUKw=;
 b=c7M+VeTgTCsAuPblU5F/8pFgNjcQK0xAQ/o03UGJkFgKYNHPvTT/cWqzZpc2O9nJAb
 BK4A38obelN2DrX6J237PMKFh3Q08vgMMIvhsji9C9TnojiAItmz+h9CSuNyXU4WHSLx
 7RTFQz5IynIcXPJE66ke8onYV926N8Y3oaGRLD4MZzbR2e1VzF45ONVCB/4opZ29hupJ
 pNErfFG/NdbFAE2WXMbpjWD8hX1c/Ocv9Wu78RkJl+cur6GuzUYfGZlRPrf2DVzb7ARn
 08cXQ+GhUUJCpVvLtDC3eN3Ki8Z56tGT/X7bdwAwRa1BVnYydygLM/ls0pAigbHb/vVh
 j9/A==
X-Gm-Message-State: AOAM531hTgNTkq6X3RFbyCmDrTWr15mdayuGk+g3NIPFRxplST/GJmYS
 EdcIHMcBhOhrqFxHVUMRTlFxx0BEEjxyQg==
X-Google-Smtp-Source: ABdhPJygwh4H1AkxBKEtzFUYsC4WZfl1SyBNlOYx8TA7M1UtCskZBPSo7S0gTVItwLC1uHXDWPNjXg==
X-Received: by 2002:a17:902:525:b029:d1:920c:c200 with SMTP id
 34-20020a1709020525b02900d1920cc200mr30959400plf.25.1600387054278; 
 Thu, 17 Sep 2020 16:57:34 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m13sm772699pfk.103.2020.09.17.16.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 16:57:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/10] disas/capstone: Add skipdata hook for s390x
Date: Thu, 17 Sep 2020 16:57:20 -0700
Message-Id: <20200917235720.2685978-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917235720.2685978-1-richard.henderson@linaro.org>
References: <20200917235720.2685978-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is always possible to tell the length of an insn, even if the
actual insn is unknown.  Skip the correct number of bytes, so that
we stay in sync with the instruction stream.

Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/capstone.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/disas/capstone.c b/disas/capstone.c
index b48f83958d..0a9ef9c892 100644
--- a/disas/capstone.c
+++ b/disas/capstone.c
@@ -16,6 +16,39 @@
  */
 static __thread cs_insn *cap_insn;
 
+/*
+ * The capstone library always skips 2 bytes for S390X.
+ * This is less than ideal, since we can tell from the first two bits
+ * the size of the insn and thus stay in sync with the insn stream.
+ */
+static size_t CAPSTONE_API
+cap_skipdata_s390x_cb(const uint8_t *code, size_t code_size,
+                      size_t offset, void *user_data)
+{
+    size_t ilen;
+
+    /* See get_ilen() in target/s390x/internal.h.  */
+    switch (code[offset] >> 6) {
+    case 0:
+        ilen = 2;
+        break;
+    case 1:
+    case 2:
+        ilen = 4;
+        break;
+    default:
+        ilen = 6;
+        break;
+    }
+
+    return ilen;
+}
+
+static const cs_opt_skipdata cap_skipdata_s390x = {
+    .mnemonic = ".byte",
+    .callback = cap_skipdata_s390x_cb
+};
+
 /*
  * Initialize the Capstone library.
  *
@@ -42,13 +75,20 @@ static cs_err cap_disas_start(disassemble_info *info, csh *handle)
     /* "Disassemble" unknown insns as ".byte W,X,Y,Z".  */
     cs_option(*handle, CS_OPT_SKIPDATA, CS_OPT_ON);
 
-    if (info->cap_arch == CS_ARCH_X86) {
+    switch (info->cap_arch) {
+    case CS_ARCH_SYSZ:
+        cs_option(*handle, CS_OPT_SKIPDATA_SETUP,
+                  (uintptr_t)&cap_skipdata_s390x);
+        break;
+
+    case CS_ARCH_X86:
         /*
          * We don't care about errors (if for some reason the library
          * is compiled without AT&T syntax); the user will just have
          * to deal with the Intel syntax.
          */
         cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
+        break;
     }
 
     /* Allocate temp space for cs_disasm_iter.  */
-- 
2.25.1


