Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB19C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3672376F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkImU6cA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3672376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmTh-00051F-SB
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOh-000836-TF
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:11 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOf-0004Lb-Js
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:11 -0400
Received: by mail-pj1-x1041.google.com with SMTP id t7so1844154pjd.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fL9vcubZUcrgmVjSWEvSPM+/Ls8w7nQK9m+00GRHc10=;
 b=MkImU6cAIAbe0MvakOL2TARvA6rK63JRjLZBh9PmpPSCogeg8NfZJc8cf/cfM+hn2I
 jAhAxVdLdgTDJ+hh2NGlq7RPyAJWzF+kVPS0+cDvgpnECq/0EaWfVoX5bwkC7WcBVO6K
 2npIQJBSNTEgN3r+v/U7zqtDE3f4gd0zbxf6LZmXqeWYX2HlJmLuN2+IsOxEiUf71nKp
 7XQLafK7Tb2rSWsDfuJsVwGmHb2mUwNeCAfkOHx/rGwhWMy2RZNsk2AWvxTTc6B60q5Y
 DOqY78P6TLXAU+MCbq2QEnz50yThZk7KrC7BwiR4amJK8kvdBqYNqUidetJ2jDE3c4ko
 sBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fL9vcubZUcrgmVjSWEvSPM+/Ls8w7nQK9m+00GRHc10=;
 b=TrRmZd5hdwG7J14UHRgHACOi3rE0BKEIKp37/81RqWrJ/lppYu6L9PW4h02I6Uxlxr
 vgMMtjYpFZRONIuu6z29jUnuOFCHhk/LI7ZCqnnG379uY3DgBWDTUxKnexESgSXxGcCc
 7sXHo+pnxIHOkTWupmjRTXTNvfOQV2f6nDVnVlEBeitqjHeg1jABzp7YwMaO3aUyoh8q
 mDZSjskoMqE72puVgqoXVFRIQXgY5ZnlFoG7O2EFGuZ86XK/Aavr9knrk6jgn7GBSqrA
 71LTX7eTryAUDK9Dyt9p7KU3jmFS3FjLrjzJWjWrSNwDqFvgfrXwK7dJVGxyxZJTGpu+
 uy1Q==
X-Gm-Message-State: AOAM531ihPetA3XWMZ1PaWfqYVDGDOwiRaeWkMe+KZ9hGuwCzIHoiMuI
 vNMtU3BmQ0H3Yo1br/tuK/jK+QhMpiTrYQ==
X-Google-Smtp-Source: ABdhPJwgduNFkYxk204k2YPCIi2kGLIwTnMvHvLdyBDw+wcYb0OZ5lzAHByCMrA/PKu7EMid8OYNQw==
X-Received: by 2002:a17:90b:1098:: with SMTP id
 gj24mr910074pjb.55.1600796881019; 
 Tue, 22 Sep 2020 10:48:01 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r1sm14825310pgl.66.2020.09.22.10.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 10:48:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] disas/capstone: Add skipdata hook for s390x
Date: Tue, 22 Sep 2020 10:47:41 -0700
Message-Id: <20200922174741.475876-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922174741.475876-1-richard.henderson@linaro.org>
References: <20200922174741.475876-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is always possible to tell the length of an insn, even if the
actual insn is unknown.  Skip the correct number of bytes, so that
we stay in sync with the instruction stream.

Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


