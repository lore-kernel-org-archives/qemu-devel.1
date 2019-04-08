Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8948C10F14
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978E420855
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWizA0gK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978E420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57109 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZ1h-0008Tq-RI
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 14:29:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0L-0007Zk-03
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0J-0007Ap-ME
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:24 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hDZ0J-0007A3-BJ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:23 -0400
Received: by mail-oi1-x242.google.com with SMTP id e5so11346717oii.0
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=r88vxrdOANtSevF0RS6MjJXOTKwB4PzxdUtRxh2hHc4=;
	b=KWizA0gKhRZJH9ebhRvLM8VnTJ3VjrSol+jK/hvlam4DLt1ZJeO0ld1hRrxPSU7q/9
	vAsGF5WZVexdbPcgpgrPPeSHZ+X00u7Xp9BJ5g9T1N6hBBR07m7+rgq3rX2AlO4Q7Y8Y
	770rmR4V1FRTrDBBDHUtUpBgBIJJKUhWsgu6YpzmoBOgJLZx6Of8RQ2Lp9Joft18M8Yn
	7h4B1opk19CaABgT9snDkzylPdo07w9MULeZLt0nCu6U5xwrTy8K0HTmV7J5DyQV2ejZ
	Vqu+38KLQqv1//hkeNoDq07hnhXhTNtnPI+wSs8lzL91seTPZhAM07fOuDK/6Ov1oaiL
	M55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=r88vxrdOANtSevF0RS6MjJXOTKwB4PzxdUtRxh2hHc4=;
	b=kkXUNDM516FER7VEdeKfTWEgWgKTMyiTVRV1Gc0y2cE5+IdYa7B+tXDYBs8A+rPEAE
	tYjgyj+pKL2zKl/a8WLnUF+A8b0V6eDKVI9VIamYogRvbAysFkLQjrohrYYpCRzFq28z
	oxPjfTwkXkjYyQvp5+/tQD2zX/Qny0EhDESBR8JNP4hoETX6v2RCR1u5bAPzQh562DiU
	NuxmhpYWL2EaS9LhktMdsx6L7/MS6r0c5Mj2LE0h1FD5W5n05FPZ6AXk6ZbXFROFwqyI
	FsZbfQO16Q3r5yKINpupiQMJCG7mhtxkgHuEBMAUL0YqAAMfpIosHOOkcnsZtzSeaj0s
	wPPg==
X-Gm-Message-State: APjAAAXAQABXQVQFmXT6MPfcNskCbIaAn3MwvK4DKgcVYVO3djL/JWag
	RktMPkrUfnW/igC6XFQOg8XtUeoRGsI=
X-Google-Smtp-Source: APXvYqybR4tM/zFGkQIT5Q3q8gD7Mv7TZKlHc4ZWZxJMPJ3nfiVm23Xh2yZRKdMxpQ7rL7FIAtZx5A==
X-Received: by 2002:aca:3306:: with SMTP id z6mr17287864oiz.25.1554748102133; 
	Mon, 08 Apr 2019 11:28:22 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	r133sm9940295oib.21.2019.04.08.11.28.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 11:28:21 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 14:27:44 -0400
Message-Id: <20190408182748.1238-2-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408182748.1238-1-jan.bobek@gmail.com>
References: <20190408182748.1238-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: [Qemu-devel] [RISU PATCH 1/5] risu_i386: move reginfo_t and related
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Jan Bobek <jan.bobek@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408182744.AYPgT7zz4254BAJToC11nMTBJpHM-K3-I1NsguU2fPc@z>

In order to build risu successfully for i386, we need files
risu_reginfo_i386.{h,c}; this patch adds the former by extracting the
relevant code from risu_i386.c.

This patch is pure code motion; no functional changes were made.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_i386.c         | 23 +----------------------
 risu_reginfo_i386.h | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 22 deletions(-)
 create mode 100644 risu_reginfo_i386.h

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
-- 
2.20.1


