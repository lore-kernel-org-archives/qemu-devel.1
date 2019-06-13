Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8768C31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C57A21721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7FshUkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C57A21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39374 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbOn0-00039G-Pw
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58863)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOd8-0007ur-8b
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOcz-00041A-RM
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOcx-0003xN-JU
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id 207so2080614wma.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=k2MYwgAzYIN1OzgZk9hyeAfnDdny0N8Q/YN/4clJftg=;
 b=d7FshUkmQoCrAlSRIpEl0eFJ9KgiHL/fMYGUuovmwrRXkgGDSFvhBu2/Lxqgrfjymo
 G2UiTmnHJ2ClAssTWvLB+TL6jnlLRhs6SBcuuF+1Ug3ZfjoRDCdCOYwrPja+/T857mvT
 LLLj50qAKe/ma2aPyXsm9bbgpZdo053+b7WgF0hxMrjumdwqen18wTicUaVP8ZjMm3b2
 TvloV3RYOYyTQO1sagKy1UWHziYbQ7G/BIT3aDtCBrrqaJg4BTetIHaExZCUTYkWwGOB
 AHNXLJjtcSJsmqykUG9rnULVgIbKld3p7JQ4HMWgPQIu1v7vxBptvUWYZ5R8Q6rYi8ZB
 m7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k2MYwgAzYIN1OzgZk9hyeAfnDdny0N8Q/YN/4clJftg=;
 b=DrcuAhSoOtcWI3TfwOE5i/jou97pJbzg7B/HeWcch2/5dcwxuYOpyRbTF+T6euQ7ex
 THxh5DIghfhLPm59K35l9xIyz1LoyaITSL/9ZVtcaOmB2iwtz7hu6IOruneY0Atj2QXt
 FFMlCpYfC7Vzw2K4dECv+jF1rRvw78FvAQ4WnFzDxsxMkUaaCmRtDRqrpSb7c7iOx/xi
 QVcajKuJZ4mK8e8KnTx5Wjnx1ojuef4Kp3rFJn5BiwFqqs3SKoP2mP5zCxmdnZ3i7P//
 Uyp5kephO06WZGTiO5nb+Agr2F/faT7H93dVkC6bOWfLuHJ5ViSbE8lv5BIT0vTC91fM
 txTQ==
X-Gm-Message-State: APjAAAWzLE7uyhzZHueMVD4pPiBTs0H6/GzVcJ1DJa9NNM4BSa1pZwqm
 abXQlaXZzGkn4pd72b9nODM6IP2uU6wZVw==
X-Google-Smtp-Source: APXvYqx0ndA9R8Ms4OhE8Jvl84IAIJx3ZpAKi54Q3lhMOCr1Y/Vy3mBj3IlZ1hySE9QtseXR3AiukA==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr3751356wmi.14.1560428084082;
 Thu, 13 Jun 2019 05:14:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:13:53 +0100
Message-Id: <20190613121433.5246-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 08/48] target/arm: Add stubs for AArch32 VFP
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
index ab3026664af..c97e6c8238c 100644
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


