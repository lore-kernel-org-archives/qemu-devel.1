Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274D5C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E008F2189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9athz1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E008F2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i345P-0006c8-Qt
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33Gd-0003rT-R4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GZ-0000Uc-9j
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:06:01 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33GY-0000Ty-Sb
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:59 -0400
Received: by mail-pg1-x541.google.com with SMTP id u17so220173pgi.6
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0SMzf99NHPKkTWoLRfHeddqKK5zZsCfVSTziSkomW74=;
 b=o9athz1cN8z7ysn/AeMY5z5p05i0NYludTqS5KfjUvY/ksbmAKVtnkPO+dMxoC8BkN
 54pGppMXIu8Gac8IRrN5YF+puPLOEQCOOFxJsPHt/9Qc3jGGqQOxPRWeqTpasKgTeV9x
 xehdyziK1ZaTSCtkXloiJ/RmFbXAHGP01PGS5IlGEYFKOi8GiVLLCtaQ1TVjz/yr522l
 np7FI2oXUPspoZXrhpVwNJi5XIfWZunr8LAmXrPpDR0g0PyGpJYYd1nAZNq5X4KQ2L3B
 hjaIMCC05Sh/3PL4Y5wWVnJHQOgUkYobvyxyw5ljFBT8mSXtAXSeVXgcq2O8Rnjmgp3Z
 mAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0SMzf99NHPKkTWoLRfHeddqKK5zZsCfVSTziSkomW74=;
 b=qG8nFSCliEtCZambEaXVoQ0olMAAHSWqbGWQ4AXAKN2w89pZHMci7vGWlRhJbKJT59
 o3Qp8oLG8ELi0/voNNAq2dWBUVrx+u24+rNBuH6MsEimgNcPy9CqbSY+rgkJzJDixjRX
 yb3gjxG/vek1mpj8H5YMA+lmKxqOChqPZ20Z1o3bNJYVl0tWFe8GbGvDvOD9YTpOFOU0
 v0rEzh6vGddi9vUFcpIZ3/0Wv8SUM0hJUm11UQEqkW/Jep6JsJauq5o8uwuo0mkmi5Ka
 mXYsfR+q4hvxA6JYuQGCjcCXDWOqaPUrvK6b2GfZQN93KgWorUi+trd5eaIh40KJPXMf
 feOA==
X-Gm-Message-State: APjAAAVmNH88gmi0YHloMNWHVuPlhJk4TGYRuiN+lK7YLU8FpND15f5z
 DHieCb3WiREQysLBykuspyrQzkZa4rA=
X-Google-Smtp-Source: APXvYqzoR15oM1Its0m0jFu81d6wASEy4qOO5mQ8BMnAN3DebyJJQ/rA3gBmbKR6keAhxgva6yimlQ==
X-Received: by 2002:a62:b415:: with SMTP id h21mr6525106pfn.198.1567019157501; 
 Wed, 28 Aug 2019 12:05:57 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:32 -0700
Message-Id: <20190828190456.30315-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v3 45/69] target/arm: Add skeleton for T16
 decodetree
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
 target/arm/translate.c   |  6 ++++++
 target/arm/Makefile.objs |  6 ++++++
 target/arm/t16.decode    | 20 ++++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 target/arm/t16.decode

diff --git a/target/arm/translate.c b/target/arm/translate.c
index defbcf68db..106ef08ada 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7534,6 +7534,7 @@ static int t32_branch24(DisasContext *s, int x)
 #include "decode-a32.inc.c"
 #include "decode-a32-uncond.inc.c"
 #include "decode-t32.inc.c"
+#include "decode-t16.inc.c"
 
 /* Helpers to swap operands for reverse-subtract.  */
 static void gen_rsb(TCGv_i32 dst, TCGv_i32 a, TCGv_i32 b)
@@ -10646,6 +10647,11 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     TCGv_i32 tmp2;
     TCGv_i32 addr;
 
+    if (disas_t16(s, insn)) {
+        return;
+    }
+    /* fall back to legacy decoder */
+
     switch (insn >> 12) {
     case 0: case 1:
 
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 7806b4dac0..cf26c16f5f 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -43,12 +43,18 @@ target/arm/decode-t32.inc.c: $(SRC_PATH)/target/arm/t32.decode $(DECODETREE)
 	  $(PYTHON) $(DECODETREE) --static-decode disas_t32 -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
+target/arm/decode-t16.inc.c: $(SRC_PATH)/target/arm/t16.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) -w 16 --static-decode disas_t16 -o $@ $<,\
+	  "GEN", $(TARGET_DIR)$@)
+
 target/arm/translate-sve.o: target/arm/decode-sve.inc.c
 target/arm/translate.o: target/arm/decode-vfp.inc.c
 target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
 target/arm/translate.o: target/arm/decode-a32.inc.c
 target/arm/translate.o: target/arm/decode-a32-uncond.inc.c
 target/arm/translate.o: target/arm/decode-t32.inc.c
+target/arm/translate.o: target/arm/decode-t16.inc.c
 
 obj-y += tlb_helper.o debug_helper.o
 obj-y += translate.o op_helper.o
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
new file mode 100644
index 0000000000..e954f61fe4
--- /dev/null
+++ b/target/arm/t16.decode
@@ -0,0 +1,20 @@
+# Thumb1 instructions
+#
+#  Copyright (c) 2019 Linaro, Ltd
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+
+#
+# This file is processed by scripts/decodetree.py
+#
-- 
2.17.1


