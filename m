Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36E0C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1D7218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZqwVVtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1D7218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Y9-00082t-2L
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58836)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NS-0005Cv-Jy
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NO-0000jk-Cf
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:31 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NO-0000e4-5r
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:30 -0400
Received: by mail-pf1-x441.google.com with SMTP id m30so24865980pff.8
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BeJ+pb6ctnzLHVd1R33fd022stp222LK5CW6SHtredI=;
 b=pZqwVVtHLxWhL94AkDYYgYTXk1sGL8fnfLESWlIPloluyfnCXCrXrlQok3gH3Hod8O
 2DN/m31BMtPDGnBdhJnjasfsVoc1IaApeEhwh1gauPzgOg1nOlUkhOAb5YQ6cMKc/uuI
 xTXO7w0KqHU9ePwl25vFJ9t3j7lZhhIm7LfaLB8VS09mSmvVza6OBAZSlvZVjEfNO3YV
 WXcJJWCrCyq9Qgp0PpBCC62jmn4n3hhYfoJdDWrERwKza+p4pLDjfCeSPRmNW11iy9o9
 5FqdDPpou1NF9S7wRRJGkdWOIZVsgWB6ygCM6m1oF75PJucJWmwWIY3scZSG3DpS5Wkg
 NReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BeJ+pb6ctnzLHVd1R33fd022stp222LK5CW6SHtredI=;
 b=Rltmb1lQvSv9YFSg7QNyed+asvXNd5Pyfg3U9nUdwGocgraRf7xc7RSsNiqZxNw30W
 hTg8TkuAp1yxSq+fEmHiqmIGIukp4axFwGmUKPs5nVC92P4LUC/zQJ+2qSjHkvSZANK7
 +qyhODLoHSDViDAbhU6U9hD2TsJC/qHS9ZCI1OsBCKvsabPccCGlgqLC2tKuXr3RYPGc
 2qhpnVCO1gSz5laok6NZpPZIOmUM5MDVPDYK5TMonnGHoV8dS//Xhtz/E9s+U6AF6vDa
 VYvuS9DaUtBgECZUcXUXRYU66abP+CewIBdZXm00Y4HLTz1GOz965tpMzAA85y4N/Tn9
 pUiw==
X-Gm-Message-State: APjAAAVjnkffmdh07P9euE3Qno1QZp3SyCKYgaKQsiBZalDvbOR3eNe3
 BxEP58hSX9OVRZuYsCCDcXr677uXweQ=
X-Google-Smtp-Source: APXvYqyyL/u9LNINsiyDFyavW78h1Dk6i2x2dIqu+MObX9ZfP0f3qjYsFRteY92tHudJA9VVOSK1Aw==
X-Received: by 2002:a17:90a:d814:: with SMTP id
 a20mr99531064pjv.48.1564163486971; 
 Fri, 26 Jul 2019 10:51:26 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:08 -0700
Message-Id: <20190726175032.6769-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 43/67] target/arm: Add skeleton for T16
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c   |  6 ++++++
 target/arm/Makefile.objs |  6 ++++++
 target/arm/t16.decode    | 20 ++++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 target/arm/t16.decode

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 65a74a963b..db93b12608 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7608,6 +7608,7 @@ static int t32_branch24(DisasContext *s, int x)
 #include "decode-a32.inc.c"
 #include "decode-a32-uncond.inc.c"
 #include "decode-t32.inc.c"
+#include "decode-t16.inc.c"
 
 #ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
 # pragma GCC diagnostic pop
@@ -10559,6 +10560,11 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
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


