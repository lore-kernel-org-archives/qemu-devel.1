Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98289C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6657620830
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSahZhyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6657620830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57107 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZ1h-0008Tb-FU
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 14:29:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0M-0007Zw-Gk
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.bobek@gmail.com>) id 1hDZ0L-0007Co-Dv
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:26 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hDZ0L-0007Bq-66
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:28:25 -0400
Received: by mail-ot1-x344.google.com with SMTP id 64so13099362otb.8
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=8Ez4tXIquMxDTRtR9gb1w7DfYhokfkOQYjP9oOimxak=;
	b=WSahZhykbkLllzQoHV6Jk8IBQKSob2ZSN+e5HR+Keu0Q1fdHUJa3OaCSFm3lrmiKmn
	qLUqHMnwMkytB/+AYeremnLwlreiIiNjM6GLE9ph47aZQsefilUGn57XTGKrXNfxnxBz
	VwUVWs4ihgiXUUFN3vFareSCVMlMAlweUHOKJvyqFLjQ4L9G+7aYnTwBA44+jH6DoIBc
	SZGYMKIG6Ng1fDieN42LhsIcLRXzWzQBVbEorDMm3w2UpNSUOxQ1LjtEb4We5xpa/8CS
	97c5DQ9cWZXWvdr9tm/DfHJYp9rTokFRucW8fCMAH00EsRTxkHz7ZwcQsE6OVwXWgBw2
	rpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8Ez4tXIquMxDTRtR9gb1w7DfYhokfkOQYjP9oOimxak=;
	b=BWh12WaPfk6wSn+YXuKFP/EoYmPzj5azjEbjJICAvAlhSVDLUMlteSiJk6XGXNoFXv
	hpYiDYzweqw7y7bna73eMw6dQoQAwA9at4sEpG7M8PIIrCj2q7oOfOlKZ3K7nByTpucV
	gkTAH3BDsWm3Czke0NEwnMnTzk84KbAYuCjkT7+08lR33jXVzavCJWY5dNnnLgGUcRri
	25mcXzfnCuMy6oypnsW8wV5uGTFOfIrcZxhWnEhIB/ZlZMo7uWZbUoKr3U9ZPzJBEH9I
	oUJ1JSQ8SUT5/59MoyVsqtRnzqFNvdxnJa8u5+PsGwukLrGltagNG9qT1M+v9R/1EKoe
	cDVw==
X-Gm-Message-State: APjAAAX+WsWB8jOVosXM+5RPr9oWGisx4FBWYkh2jDEkYo7J/QPu5mjL
	xT3mfrs/PjljJn3cz1RQ0J3wi9jEpZU=
X-Google-Smtp-Source: APXvYqxsDrBXNpiymB4ioDRr2Vv9KkFJXZxgTfaKIaW/4/NoFAH8hJDm93zYzpApcyL6gowfyEazuA==
X-Received: by 2002:a05:6830:7:: with SMTP id c7mr19067062otp.85.1554748104286;
	Mon, 08 Apr 2019 11:28:24 -0700 (PDT)
Received: from dionysus.attlocal.net
	(69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
	by smtp.gmail.com with ESMTPSA id
	r133sm9940295oib.21.2019.04.08.11.28.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 11:28:23 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 14:27:46 -0400
Message-Id: <20190408182748.1238-4-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190408182748.1238-1-jan.bobek@gmail.com>
References: <20190408182748.1238-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [RISU PATCH 3/5] risu_reginfo_i386: implement
 arch-specific reginfo interface
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
Message-ID: <20190408182746.Jv4EoBGMViWygLD66YFxlhxX8yBM3wrbA-mjxvZiEw4@z>

CPU-specific code in risu_reginfo_* is expected to define and export
the following symbols:

- arch_long_opts, arch_extra_help, process_arch_opt
- reginfo_size
- reginfo_init
- reginfo_is_eq
- reginfo_dump, reginfo_dump_mismatch

Make risu_reginfo_i386.c implement this interface.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risu_reginfo_i386.c | 48 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index e8d671f..3882261 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -10,12 +10,28 @@
  ******************************************************************************/
 
 #include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include <ucontext.h>
 
 #include "risu.h"
 #include "risu_reginfo_i386.h"
 
-static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
+const struct option * const arch_long_opts;
+const char * const arch_extra_help;
+
+void process_arch_opt(int opt, const char *arg)
+{
+    abort();
+}
+
+const int reginfo_size(void)
+{
+    return sizeof(struct reginfo);
+}
+
+/* reginfo_init: initialize with a ucontext */
+void reginfo_init(struct reginfo *ri, ucontext_t *uc)
 {
     int i;
     for (i = 0; i < NGREG; i++) {
@@ -51,18 +67,38 @@ static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
     ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
 }
 
-static char *regname[] = {
+/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
+int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
+{
+    return 0 == memcmp(m, a, sizeof(*m));
+}
+
+static const char *const regname[NGREG] = {
     "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
     "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
-    "CS", "EFL", "UESP", "SS", 0
+    "CS", "EFL", "UESP", "SS"
 };
 
-static void dump_reginfo(struct reginfo *ri)
+/* reginfo_dump: print state to a stream, returns nonzero on success */
+int reginfo_dump(struct reginfo *ri, FILE *f)
 {
     int i;
-    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
+    fprintf(f, "  faulting insn %x\n", ri->faulting_insn);
     for (i = 0; i < NGREG; i++) {
-        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
+        fprintf(f, "  %s: %x\n", regname[i] ? regname[i] : "???",
                 ri->gregs[i]);
     }
+    return !ferror(f);
+}
+
+int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+{
+    int i;
+    for (i = 0; i < NGREG; i++) {
+        if (m->gregs[i] != a->gregs[i]) {
+            fprintf(f, "Mismatch: Register %s\n", regname[i] ? regname[i] : "???");
+            fprintf(f, "m: [%x] != a: [%x]\n", m->gregs[i], a->gregs[i]);
+        }
+    }
+    return !ferror(f);
 }
-- 
2.20.1


