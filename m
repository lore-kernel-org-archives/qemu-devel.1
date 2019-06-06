Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA3EC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0912083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDSC3XoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0912083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36020 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwcA-0003Yb-1C
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:55:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTo-00048I-SA
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYwTl-0003b3-6D
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:11 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYwTj-0002nf-Ec
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:07 -0400
Received: by mail-wm1-x341.google.com with SMTP id w9so2345892wmd.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=j5ydsVQQjlU+U9mkvBoHU9cgpy9nhwg90mny4tusCq8=;
	b=JDSC3XoQRb0UdYw73cJW3jfkO++We1GFd7tVp3oGIRW3fNvDG6MBu0Kw0kvFPK4Z7/
	b9j1vb14FZpYuT0riKCpvNesVTx7eCaBb7Ce+b7TN/S4fOgEP7uLZBun8HGxN9xEZcTB
	+PRGEklUn0S56LCYPvyR7DBOFkyaEIa411h68IS5TASdIKB674zncB+7Kzs71U0lL2wj
	wHNs4VWct5MI2rl18bXpKYVV9xjwbDRMI8pN4YsgMYZhV7CPgxiGLhZfvwnpcNXZI4xj
	ykYpgIlKms9N+ey+LK6BcNMCq+Ax82onpQlvGIK9Ng9qKGRCfokyTRtqsnCYdDlrcOjs
	VWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=j5ydsVQQjlU+U9mkvBoHU9cgpy9nhwg90mny4tusCq8=;
	b=tFfGthzG38+WEt7mhNpwe1Wmvl9xhT8+P1xDWD2udzp8kRppCGLplTDn6/2T+cBS5Z
	N7xIUSVwoGobYOMU+AAJ3qghEpQ0G7tHMdp07Qm2xM/nqDAaRmCzpNX93JlB9mUV2Efa
	1eEGxbCOb4DPrRKbnipYjWRSch2vTzYW7dx4qoOW1YTpZInbv8tUyXlmT8FkNzqokPPB
	Xts5soaoaPYkNhwB+lzPfquLAp2Q4ABaUspijKzrngEkF/7tbHggez2vPo/dD0OXZ4yV
	GMUt+4T++nyCGQVyle8t/DDi3HVOsCLWRNXnP3LiDURvu/5iZgvuYwAGU9nWVo1Jt/Ok
	rdfg==
X-Gm-Message-State: APjAAAVhE4i5nfzCFFwwA+yinN2tI3wpU1sPi7VR9riTPe2dRm9H4QMZ
	bip2us/zX/Ic5xyofICjxytQeg==
X-Google-Smtp-Source: APXvYqwr6jpylUFNVlRiBg9G+D5AfmWXQXi8CRFjEJHptewK6c62NEYH2gwm6O/dbemILJ7v5VMDew==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr806883wmb.88.1559843173672;
	Thu, 06 Jun 2019 10:46:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	z135sm2596784wmc.45.2019.06.06.10.46.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:46:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 18:45:29 +0100
Message-Id: <20190606174609.20487-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606174609.20487-1-peter.maydell@linaro.org>
References: <20190606174609.20487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH 02/42] target/arm: Add stubs for AArch32 VFP
 decodetree
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
index d240c1b7144..ca9e0bfd99e 100644
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


