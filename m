Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53562C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1020F20661
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ItlmCKE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1020F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaRj-0003C3-5D
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHz-0000bF-ND
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:39 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:50440)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaHy-00017a-8G
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id x25so8240574wmc.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4YQ/rTjV1fP71MbbXsuZqGDm+GOeiBgK+8+e4T5Y2mw=;
 b=ItlmCKE6HuyxbLOBDQy63EFSNb6tPGbOWDfW1Ul28nRbl6iD0Dp8D6RT4IazuITu6j
 QY/8sEfbcCbwqmOPg6+WPYYDoBGUytZqhzanmNxQUZzzcxbxTZnmOhkQs8f9LU59LUdl
 7XlJMo+ckHY/sq2TIt4YsdK/AMeZGiA9jkL6d7hNPlyxbc9wu2bpi+CJztXenOBjT3xb
 e8Us5JpOQKSbIqgVi3IqauOWhrSJxhj62M/rH2eqNizcrCvFWlmH7saX/OJ8JpppZy6Y
 krMw8DF9JFIHHnq95L+g6+u7GUHfgUQmYhasb+yUW2dSQ6vD1FTjbYar0FNaoORFMmPS
 9hZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4YQ/rTjV1fP71MbbXsuZqGDm+GOeiBgK+8+e4T5Y2mw=;
 b=GokBD9XMfmuELmVpaOGXKnk8HDUmNKx699xHPF0oVRLWfAKVlJxdE0gkCxkmJiv8Dz
 wZNhkDU6ImjjwdnLWIu2hXW+PedViQOm6//Pcyc0PuCw3kXC5cuEvrUpcy2tBmkfh40d
 YiNrr6VhuyniocMjv1suURB0jj6k3N4IUcsbR7Dgm2YgNDUA2RniypUOnPolccyyuZ/x
 BVi4oT2QUDL5YMG8GvwjATQl+mGqc1iUbbOWfUHyYVkejf97YfrKOzWtIkDAZzd/BnoX
 vKIt2+bMt6SSJCflQgFlOV7Y0UR40rRk4EiAfFPQ3BtX6lEmhSe7yWwR7Y9Hi7AZLcdk
 Trfg==
X-Gm-Message-State: AGi0PuYEJOq3hcQLK4gQp/3vo8FdXBLYTMdluHuH6mvIq5Zv2+U0Vp43
 6Zmj13BGT2vNvOadG3SY8oS2weDWseIxfw==
X-Google-Smtp-Source: APiQypKkG5FtAEWFJD1ga6WJsC/w/MHrK47oEBPX1JXfcubtu9Ry22CxcnbFRa0IdR1gAWyWIuobEg==
X-Received: by 2002:a1c:3986:: with SMTP id g128mr14146102wma.8.1588595616178; 
 Mon, 04 May 2020 05:33:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/39] target/arm: Add stubs for AArch32 Neon decodetree
Date: Mon,  4 May 2020 13:32:52 +0100
Message-Id: <20200504123309.3808-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Add the infrastructure for building and invoking a decodetree decoder
for the AArch32 Neon encodings.  At the moment the new decoder covers
nothing, so we always fall back to the existing hand-written decode.

We follow the same pattern we did for the VFP decodetree conversion
(commit 78e138bc1f672c145ef6ace74617d and following): code that deals
with Neon will be moving gradually out to translate-neon.vfp.inc,
which we #include into translate.c.

In order to share the decode files between A32 and T32, we
split Neon into 3 parts:
 * data-processing
 * load-store
 * 'shared' encodings

The first two groups of instructions have similar but not identical
A32 and T32 encodings, so we need to manually transform the T32
encoding into the A32 one before calling the decoder; the third group
covers the Neon instructions which are identical in A32 and T32.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-4-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       | 29 ++++++++++++++++++++++++++
 target/arm/neon-ls.decode       | 29 ++++++++++++++++++++++++++
 target/arm/neon-shared.decode   | 27 +++++++++++++++++++++++++
 target/arm/translate-neon.inc.c | 32 +++++++++++++++++++++++++++++
 target/arm/translate.c          | 36 +++++++++++++++++++++++++++++++--
 target/arm/Makefile.objs        | 18 +++++++++++++++++
 6 files changed, 169 insertions(+), 2 deletions(-)
 create mode 100644 target/arm/neon-dp.decode
 create mode 100644 target/arm/neon-ls.decode
 create mode 100644 target/arm/neon-shared.decode
 create mode 100644 target/arm/translate-neon.inc.c

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
new file mode 100644
index 00000000000..c89a1a58591
--- /dev/null
+++ b/target/arm/neon-dp.decode
@@ -0,0 +1,29 @@
+# AArch32 Neon data-processing instruction descriptions
+#
+#  Copyright (c) 2020 Linaro, Ltd
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
+
+# Encodings for Neon data processing instructions where the T32 encoding
+# is a simple transformation of the A32 encoding.
+# More specifically, this file covers instructions where the A32 encoding is
+#   0b1111_001p_qqqq_qqqq_qqqq_qqqq_qqqq_qqqq
+# and the T32 encoding is
+#   0b111p_1111_qqqq_qqqq_qqqq_qqqq_qqqq_qqqq
+# This file works on the A32 encoding only; calling code for T32 has to
+# transform the insn into the A32 version first.
diff --git a/target/arm/neon-ls.decode b/target/arm/neon-ls.decode
new file mode 100644
index 00000000000..2b16c9256df
--- /dev/null
+++ b/target/arm/neon-ls.decode
@@ -0,0 +1,29 @@
+# AArch32 Neon load/store instruction descriptions
+#
+#  Copyright (c) 2020 Linaro, Ltd
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
+
+# Encodings for Neon load/store instructions where the T32 encoding
+# is a simple transformation of the A32 encoding.
+# More specifically, this file covers instructions where the A32 encoding is
+#   0b1111_0100_xxx0_xxxx_xxxx_xxxx_xxxx_xxxx
+# and the T32 encoding is
+#   0b1111_1001_xxx0_xxxx_xxxx_xxxx_xxxx_xxxx
+# This file works on the A32 encoding only; calling code for T32 has to
+# transform the insn into the A32 version first.
diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
new file mode 100644
index 00000000000..3aea7c5e188
--- /dev/null
+++ b/target/arm/neon-shared.decode
@@ -0,0 +1,27 @@
+# AArch32 Neon instruction descriptions
+#
+#  Copyright (c) 2020 Linaro, Ltd
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
+
+# Encodings for Neon instructions whose encoding is the same for
+# both A32 and T32.
+
+# More specifically, this covers:
+# 2reg scalar ext: 0b1111_1110_xxxx_xxxx_xxxx_1x0x_xxxx_xxxx
+# 3same ext:       0b1111_110x_xxxx_xxxx_xxxx_1x0x_xxxx_xxxx
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
new file mode 100644
index 00000000000..a33e81ba3ab
--- /dev/null
+++ b/target/arm/translate-neon.inc.c
@@ -0,0 +1,32 @@
+/*
+ *  ARM translation: AArch32 Neon instructions
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *  Copyright (c) 2005-2007 CodeSourcery
+ *  Copyright (c) 2007 OpenedHand, Ltd.
+ *  Copyright (c) 2020 Linaro, Ltd.
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
+/* Include the generated Neon decoder */
+#include "decode-neon-dp.inc.c"
+#include "decode-neon-ls.inc.c"
+#include "decode-neon-shared.inc.c"
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4cf5267be00..5a82a56e8ed 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1313,8 +1313,9 @@ static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
 
 #define ARM_CP_RW_BIT   (1 << 20)
 
-/* Include the VFP decoder */
+/* Include the VFP and Neon decoders */
 #include "translate-vfp.inc.c"
+#include "translate-neon.inc.c"
 
 static inline void iwmmxt_load_reg(TCGv_i64 var, int reg)
 {
@@ -10949,7 +10950,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         /* Unconditional instructions.  */
         /* TODO: Perhaps merge these into one decodetree output file.  */
         if (disas_a32_uncond(s, insn) ||
-            disas_vfp_uncond(s, insn)) {
+            disas_vfp_uncond(s, insn) ||
+            disas_neon_dp(s, insn) ||
+            disas_neon_ls(s, insn) ||
+            disas_neon_shared(s, insn)) {
             return;
         }
         /* fall back to legacy decoder */
@@ -11102,6 +11106,33 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         ARCH(6T2);
     }
 
+    if ((insn & 0xef000000) == 0xef000000) {
+        /*
+         * T32 encodings 0b111p_1111_qqqq_qqqq_qqqq_qqqq_qqqq_qqqq
+         * transform into
+         * A32 encodings 0b1111_001p_qqqq_qqqq_qqqq_qqqq_qqqq_qqqq
+         */
+        uint32_t a32_insn = (insn & 0xe2ffffff) |
+            ((insn & (1 << 28)) >> 4) | (1 << 28);
+
+        if (disas_neon_dp(s, a32_insn)) {
+            return;
+        }
+    }
+
+    if ((insn & 0xff100000) == 0xf9000000) {
+        /*
+         * T32 encodings 0b1111_1001_ppp0_qqqq_qqqq_qqqq_qqqq_qqqq
+         * transform into
+         * A32 encodings 0b1111_0100_ppp0_qqqq_qqqq_qqqq_qqqq_qqqq
+         */
+        uint32_t a32_insn = (insn & 0x00ffffff) | 0xf4000000;
+
+        if (disas_neon_ls(s, a32_insn)) {
+            return;
+        }
+    }
+
     /*
      * TODO: Perhaps merge these into one decodetree output file.
      * Note disas_vfp is written for a32 with cond field in the
@@ -11109,6 +11140,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
      */
     if (disas_t32(s, insn) ||
         disas_vfp_uncond(s, insn) ||
+        disas_neon_shared(s, insn) ||
         ((insn >> 28) == 0xe && disas_vfp(s, insn))) {
         return;
     }
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index cf26c16f5f6..775b3e24f22 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -18,6 +18,21 @@ target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.decode $(DECODETREE)
 	  $(PYTHON) $(DECODETREE) --decode disas_sve -o $@ $<,\
 	  "GEN", $(TARGET_DIR)$@)
 
+target/arm/decode-neon-shared.inc.c: $(SRC_PATH)/target/arm/neon-shared.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) --static-decode disas_neon_shared -o $@ $<,\
+	  "GEN", $(TARGET_DIR)$@)
+
+target/arm/decode-neon-dp.inc.c: $(SRC_PATH)/target/arm/neon-dp.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) --static-decode disas_neon_dp -o $@ $<,\
+	  "GEN", $(TARGET_DIR)$@)
+
+target/arm/decode-neon-ls.inc.c: $(SRC_PATH)/target/arm/neon-ls.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) --static-decode disas_neon_ls -o $@ $<,\
+	  "GEN", $(TARGET_DIR)$@)
+
 target/arm/decode-vfp.inc.c: $(SRC_PATH)/target/arm/vfp.decode $(DECODETREE)
 	$(call quiet-command,\
 	  $(PYTHON) $(DECODETREE) --static-decode disas_vfp -o $@ $<,\
@@ -49,6 +64,9 @@ target/arm/decode-t16.inc.c: $(SRC_PATH)/target/arm/t16.decode $(DECODETREE)
 	  "GEN", $(TARGET_DIR)$@)
 
 target/arm/translate-sve.o: target/arm/decode-sve.inc.c
+target/arm/translate.o: target/arm/decode-neon-shared.inc.c
+target/arm/translate.o: target/arm/decode-neon-dp.inc.c
+target/arm/translate.o: target/arm/decode-neon-ls.inc.c
 target/arm/translate.o: target/arm/decode-vfp.inc.c
 target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
 target/arm/translate.o: target/arm/decode-a32.inc.c
-- 
2.20.1


