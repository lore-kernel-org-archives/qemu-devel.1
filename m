Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA03CC43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 17:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A090206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 17:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvlvXYnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A090206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJiBZ-0008Lj-RZ
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 13:29:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJi8w-0006e2-BN
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJi8v-00039q-Cq
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:42 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:41183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJi8v-00039K-7J
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:41 -0400
Received: by mail-pg1-x52a.google.com with SMTP id f6so173692pgs.8
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=7gtIWTRNKd5zdzhWtV9mqmxBLudIq3sczpVqqkNj2e0=;
	b=kvlvXYnm5Zatb2Wu09W1wEgCY/3egzEykwWc2CyOkI/MpU8CJG26RDrltOSW/qvvhX
	y6eUX0MbaYhfq6BQnQlaIYFXP/Eu6LJDDqvGMHaiBDe04o5nQx8mB4urEBVITQYVTwo5
	o8oO207W793JyfN4xB0oWmwFPYV33EYHbQ9b5S6YHbh1Ro5Wmxf2K+chPf447Zs0K4bl
	WIYbYEBtViSWSKVNl7rrmOKuaIFxfOsF57kLY/+6tpZ0tZi4nnYuPBhQg/VvoM4pgEPr
	g4gnzi/f6TWoF85oImigl2wIVdrKxsJ0YqVtmPGZ+QIL2TYWj5svkwtBq5144bHRjkFl
	wY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=7gtIWTRNKd5zdzhWtV9mqmxBLudIq3sczpVqqkNj2e0=;
	b=M1VPM7g2MofzwHEm2ZCQbo/tiijrzFlQuKFtD1DNJ6sYT0BmZvt8uJ+TlFLJWFqroP
	iSJ/aJAp1L3wylx4Chm6yAflZLFHw9qsmnqKanN2XTeiA7cQ95Kb8swvs0xp9gt3LdYx
	Dw8En0i5+FzjGNYEOxmkW/+otmgQuLMy4ZWh/yyQHvVSdnUw1Bg1I8zWdg+4aTlKo5rt
	fylUOLQD6/wPhI1+OTFR5uSlOmUy1nNQL/bRH722AO2gz17NSrpVivxYDDBvqlEd6lzr
	P1cZd9zAF4NlgFDHK1t5bpdJTEpjOg0yQZbopGBn1NdjFMSGCs2qKZjcARvM3WOlpk7W
	MDfA==
X-Gm-Message-State: APjAAAXL067ibHZiAIF9d8sVo9RkjgAw42LmdjApCEiBfvSdXxHykhrv
	J06aFjnmnHSfja0aShuXQFg06fG9ADA=
X-Google-Smtp-Source: APXvYqyLi6LU6I8371WbBMayuW/i/82wU5lAoPEnZ+n+dSPHo2L7jUuXKVBF3PcXK9AIPbVzBq/5ig==
X-Received: by 2002:a63:e818:: with SMTP id s24mr38894439pgh.190.1556213199171;
	Thu, 25 Apr 2019 10:26:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	128sm26439908pgb.47.2019.04.25.10.26.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 10:26:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 10:26:35 -0700
Message-Id: <20190425172636.11128-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190425172636.11128-1-richard.henderson@linaro.org>
References: <20190425172636.11128-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52a
Subject: [Qemu-devel] [PATCH 1/2] fixup! target/riscv: Name the argument
 sets for all of insn32 formats
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
Cc: palmer@sifive.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425172635.Q3v7eCHAGzO89OYdZnM5ChGmLLgNsMNtxxLgPRFixf0@z>

---
 target/riscv/translate.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d1f599a92d..009c146e8f 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -713,12 +713,19 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
  * initially declared by the 32-bit decoder, which results in duplicate
  * declaration warnings.  Suppress them.
  */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wredundant-decls"
+#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+# pragma GCC diagnostic push
+# pragma GCC diagnostic ignored "-Wredundant-decls"
+# ifdef __clang__
+#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
+# endif
+#endif
 
 #include "decode_insn16.inc.c"
 
-#pragma GCC diagnostic pop
+#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+# pragma GCC diagnostic pop
+#endif
 
 static void decode_opc(DisasContext *ctx)
 {
-- 
2.17.1


