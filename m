Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B387C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449AB20873
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMkJkTJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449AB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRldT-0003Fo-DF
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:47:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbG-0001Gj-TE
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hRlbF-0005QU-J7
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:14 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:36234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hRlbF-0005PI-E0
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:45:13 -0400
Received: by mail-yb1-xb43.google.com with SMTP id m10so3243000ybk.3
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 15:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=G8++Lr3rIIt9kikJ2cxj2YKTqF9/McsFoEFrbLSU8eY=;
	b=tMkJkTJz44esF7IecnmRUEIPyPlB7gqYB60+B1b3npGCZiax2MGOLi74+aHShW6vng
	nC3hNKsi3PHs9d2r/jgQ6zxFygx5wztcEAVXeghbOmdifBs6LLqar8XNw2CohUcK54Nd
	zGMBW8L4dKrs2Qaec8a9CxPwScTniOJVVG+hztydiKUhNQlXNiZkJnETun8WUaDplIQ4
	JTPaNZAL60ch6lLUWHnTgcm8YJHi91xWKzQugVSR1D1JEJkoaZ+ia0oyGj+EUWNa8H2i
	jeOst76gsCah1Mrc7QYzqA7t5TnSvXe9atvA+5IwGseyinKrRw2LCkvyip6aRmpKuoF4
	R7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=G8++Lr3rIIt9kikJ2cxj2YKTqF9/McsFoEFrbLSU8eY=;
	b=spufjPGumFRNX5J0LpAnUH70jxBKaOH4vgLWvevO5jgg3NcoBntKG0radCl7sU7nFP
	QIrdtTQrJC07IEPfP3+V/1iBkPJmwJ3PcAhYwfI+ilUCdoWFHEuaa5i64kerIATwQ+Ll
	UT8w+C5X2mj//DPvurvwGo8dznFcOr4hPuAieWlWUYujI7E+Hnpg/sgqkNxQbj86+Pmp
	pcfGd4sJKT5vf+xacGjYLb4Abe8knriNZwchHg2ozBXatRzV/UQgAQxsf10R+npwmLgB
	VAtJs2DsmmbRrGtgXZZLRsTdoUPBbS6QZdmIny+NReleXvh/S/oq7hWcn8L2iPCzVvNq
	Ru9w==
X-Gm-Message-State: APjAAAV8k2/AUEvN8aSbAi7AeUAThUitG1y0AtX3XStUSImV0fBRzIuG
	FJOebLHA7HD1vVQ+/skQ2xVZ27jgKlljSA==
X-Google-Smtp-Source: APXvYqxGY66LudO9Tc9MaNpHj/MnmwnpWxBem9PyJCkgpAA1/NnLQJHvN4TWmOBZCxLdN2abecyJ6A==
X-Received: by 2002:a25:81c3:: with SMTP id n3mr27146039ybm.206.1558133112858; 
	Fri, 17 May 2019 15:45:12 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	u73sm2480260ywf.62.2019.05.17.15.45.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 15:45:12 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:44:41 -0400
Message-Id: <20190517224450.15566-3-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517224450.15566-1-jan.bobek@gmail.com>
References: <20190517224450.15566-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RISU v2 02/11] risu_i386: move reginfo_t and related
 defines to risu_reginfo_i386.h
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to build risu successfully for i386, we need files
risu_reginfo_i386.{h,c}; this patch adds the former by extracting the
relevant code from risu_i386.c.

This patch is pure code motion; no functional changes were made.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_reginfo_i386.h | 37 +++++++++++++++++++++++++++++++++++++
 risu_i386.c         | 23 +----------------------
 2 files changed, 38 insertions(+), 22 deletions(-)
 create mode 100644 risu_reginfo_i386.h

diff --git a/risu_reginfo_i386.h b/risu_reginfo_i386.h
new file mode 100644
index 0000000..5bba439
--- /dev/null
+++ b/risu_reginfo_i386.h
@@ -0,0 +1,37 @@
+/*******************************************************************************
+ * Copyright (c) 2010 Linaro Limited
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     Peter Maydell (Linaro) - initial implementation
+ ******************************************************************************/
+
+#ifndef RISU_REGINFO_I386_H
+#define RISU_REGINFO_I386_H
+
+/* This is the data structure we pass over the socket.
+ * It is a simplified and reduced subset of what can
+ * be obtained with a ucontext_t*
+ */
+struct reginfo {
+    uint32_t faulting_insn;
+    gregset_t gregs;
+};
+
+#ifndef REG_GS
+/* Assume that either we get all these defines or none */
+#   define REG_GS      0
+#   define REG_FS      1
+#   define REG_ES      2
+#   define REG_DS      3
+#   define REG_ESP     7
+#   define REG_TRAPNO 12
+#   define REG_EIP    14
+#   define REG_EFL    16
+#   define REG_UESP   17
+#endif /* !defined(REG_GS) */
+
+#endif /* RISU_REGINFO_I386_H */
diff --git a/risu_i386.c b/risu_i386.c
index 5e7e01d..6798a78 100644
--- a/risu_i386.c
+++ b/risu_i386.c
@@ -14,28 +14,7 @@
 #include <string.h>
 
 #include "risu.h"
-
-/* This is the data structure we pass over the socket.
- * It is a simplified and reduced subset of what can
- * be obtained with a ucontext_t*
- */
-struct reginfo {
-    uint32_t faulting_insn;
-    gregset_t gregs;
-};
-
-#ifndef REG_GS
-/* Assume that either we get all these defines or none */
-#define REG_GS 0
-#define REG_FS 1
-#define REG_ES 2
-#define REG_DS 3
-#define REG_ESP 7
-#define REG_TRAPNO 12
-#define REG_EIP 14
-#define REG_EFL 16
-#define REG_UESP 17
-#endif
+#include "risu_reginfo_i386.h"
 
 struct reginfo master_ri, apprentice_ri;
 
-- 
2.20.1


