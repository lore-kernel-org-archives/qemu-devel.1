Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15240C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47DD20673
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 11:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYf46yLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47DD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56218 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haeXC-0005Lw-0U
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 07:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38827)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haePf-00071E-AY
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haePc-0007Al-UK
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:53:59 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haePc-00079o-KC
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:53:56 -0400
Received: by mail-wm1-x341.google.com with SMTP id s3so2438049wms.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qg/q28/1l7FZ4RskG5OVkaABmpJcNNAgYVp1eUduElc=;
 b=HYf46yLmF/0wqPkGW/XTezzAiofwoLDjWODLPoucVetrmg6dRYuDaQsheWjscnwo/z
 HJ9Ic5j41UENofIL9d1iWwMeiCgcAzyFD6Wck1CNt8QMmyYASejvYB2S4UhPKltRCFMb
 LtbJSCWS5Cpt1Q1UgR2523bR6lc+dUIL2WTstF+XsYB1kC7G9EF9YvzjjBlCgqy41dk8
 9xCQQSmHAzwfEkFMzQjAceFt3FUqkZIfYS05/F7ofN0Eh5Wqy3uxiQnhBMw6XGER0iv9
 l6uP/7frY5sZczRmlh5UcbU3n3PhZnP+nY0eK1AW334yRRIR+4V7FA/zmT0JzkXg2O6P
 v8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qg/q28/1l7FZ4RskG5OVkaABmpJcNNAgYVp1eUduElc=;
 b=forrvDHqSjMF6elefjhjde3mOUnDGshPRMV5SxgTo1/PgnfF9KikkEploNFHCt3rYo
 tLz7Xc1ftZ8obeMCZAxkIQ5V7oSpESj1dIlhN+KLEd3vag/IdKVoMo1HniJZ8ruYHYwg
 vXp1hrUhm6U0OnAro94038eQfMenCuQzKfuGbnDUnuLvaauB4zQ17kHhlEy7gkKuDTCG
 BYOlDWebgLM6EszhfXDWI6QlB938KgmW2QKaHbJ3yfNtXogiHDlivuAoYcWWADKX/SBH
 z9DWZxbRFAKpiuf0wz2lqZyHobcuaLIVhUwTVWzva3VkGWhcbVzCMuxIPBK5pR9r1oZ0
 S1YQ==
X-Gm-Message-State: APjAAAW6ERhS1VeTh2zRsX5bTtSZ+/iVKDZynw4H/7c4w+H5I7nI3Dyi
 QkUUY5kRYFUHl2nTvf9IQr+0Pw==
X-Google-Smtp-Source: APXvYqxakfdpnZLbNof/TazCmG+43nl8hOW3jM3FOg7o6PQEHiVDdAS2TAx0MtZMoMw2Up4fzxUZiQ==
X-Received: by 2002:a05:600c:21d4:: with SMTP id
 x20mr10738729wmj.149.1560250435460; 
 Tue, 11 Jun 2019 03:53:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e17sm10785945wrt.95.2019.06.11.03.53.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 03:53:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 11:53:11 +0100
Message-Id: <20190611105351.9871-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611105351.9871-1-peter.maydell@linaro.org>
References: <20190611105351.9871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v2 02/42] target/arm: Add stubs for AArch32 VFP
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the infrastructure for building and invoking a decodetree decoder
for the AArch32 VFP encodings.  At the moment the new decoder covers
nothing, so we always fall back to the existing hand-written decode.

We need to have one decoder for the unconditional insns and one for
the conditional insns, as otherwise the patterns for conditional
insns would incorrectly match against the unconditional ones too.

Since translate.c is over 14,000 lines long and we're going to be
touching pretty much every line of the VFP code as part of the
decodetree conversion, we create a new translate-vfp.inc.c to hold
the code which deals with VFP in the new scheme.  It should be
possible to convert this into a standalone translation unit
eventually, but the conversion process will be much simpler if we
simply #include it midway through translate.c to start with.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/Makefile.objs       | 13 +++++++++++++
 target/arm/translate-vfp.inc.c | 31 +++++++++++++++++++++++++++++++
 target/arm/translate.c         | 19 +++++++++++++++++++
 target/arm/vfp-uncond.decode   | 28 ++++++++++++++++++++++++++++
 target/arm/vfp.decode          | 28 ++++++++++++++++++++++++++++
 5 files changed, 119 insertions(+)
 create mode 100644 target/arm/translate-vfp.inc.c
 create mode 100644 target/arm/vfp-uncond.decode
 create mode 100644 target/arm/vfp.decode

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 6bdcc65c2c8..dfa736a3752 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -19,5 +19,18 @@ target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.decode $(DECODETREE)
 	  $(PYTHON) $(DECODETREE) --decode disas_sve -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
+target/arm/decode-vfp.inc.c: $(SRC_PATH)/target/arm/vfp.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) --static-decode disas_vfp -o $@ $<,\
+	  "GEN", $(TARGET_DIR)$@)
+
+target/arm/decode-vfp-uncond.inc.c: $(SRC_PATH)/target/arm/vfp-uncond.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) --static-decode disas_vfp_uncond -o $@ $<,\
+	  "GEN", $(TARGET_DIR)$@)
+
 target/arm/translate-sve.o: target/arm/decode-sve.inc.c
+target/arm/translate.o: target/arm/decode-vfp.inc.c
+target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
+
 obj-$(TARGET_AARCH64) += translate-sve.o sve_helper.o
diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
new file mode 100644
index 00000000000..3447b3e6466
--- /dev/null
+++ b/target/arm/translate-vfp.inc.c
@@ -0,0 +1,31 @@
+/*
+ *  ARM translation: AArch32 VFP instructions
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *  Copyright (c) 2005-2007 CodeSourcery
+ *  Copyright (c) 2007 OpenedHand, Ltd.
+ *  Copyright (c) 2019 Linaro, Ltd.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * This file is intended to be included from translate.c; it uses
+ * some macros and definitions provided by that file.
+ * It might be possible to convert it to a standalone .c file eventually.
+ */
+
+/* Include the generated VFP decoder */
+#include "decode-vfp.inc.c"
+#include "decode-vfp-uncond.inc.c"
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d25e19ef113..c75d94952de 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1727,6 +1727,9 @@ static inline void gen_mov_vreg_F0(int dp, int reg)
 
 #define ARM_CP_RW_BIT   (1 << 20)
 
+/* Include the VFP decoder */
+#include "translate-vfp.inc.c"
+
 static inline void iwmmxt_load_reg(TCGv_i64 var, int reg)
 {
     tcg_gen_ld_i64(var, cpu_env, offsetof(CPUARMState, iwmmxt.regs[reg]));
@@ -3384,6 +3387,22 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
         return 1;
     }
 
+    /*
+     * If the decodetree decoder handles this insn it will always
+     * emit code to either execute the insn or generate an appropriate
+     * exception; so we don't need to ever return non-zero to tell
+     * the calling code to emit an UNDEF exception.
+     */
+    if (extract32(insn, 28, 4) == 0xf) {
+        if (disas_vfp_uncond(s, insn)) {
+            return 0;
+        }
+    } else {
+        if (disas_vfp(s, insn)) {
+            return 0;
+        }
+    }
+
     /* FIXME: this access check should not take precedence over UNDEF
      * for invalid encodings; we will generate incorrect syndrome information
      * for attempts to execute invalid vfp/neon encodings with FP disabled.
diff --git a/target/arm/vfp-uncond.decode b/target/arm/vfp-uncond.decode
new file mode 100644
index 00000000000..b1d9dc507c2
--- /dev/null
+++ b/target/arm/vfp-uncond.decode
@@ -0,0 +1,28 @@
+# AArch32 VFP instruction descriptions (unconditional insns)
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
+# Encodings for the unconditional VFP instructions are here:
+# generally anything matching A32
+#  1111 1110 .... .... .... 101. ...0 ....
+# and T32
+#  1111 110. .... .... .... 101. .... ....
+#  1111 1110 .... .... .... 101. .... ....
+# (but those patterns might also cover some Neon instructions,
+# which do not live in this file.)
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
new file mode 100644
index 00000000000..28ee664d8c3
--- /dev/null
+++ b/target/arm/vfp.decode
@@ -0,0 +1,28 @@
+# AArch32 VFP instruction descriptions (conditional insns)
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
+# Encodings for the conditional VFP instructions are here:
+# generally anything matching A32
+#  cccc 11.. .... .... .... 101. .... ....
+# and T32
+#  1110 110. .... .... .... 101. .... ....
+#  1110 1110 .... .... .... 101. .... ....
+# (but those patterns might also cover some Neon instructions,
+# which do not live in this file.)
-- 
2.20.1


