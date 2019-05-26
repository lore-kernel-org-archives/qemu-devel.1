Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ABDC07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C432820815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C432820815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49483 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiJ2-0005n9-3h
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:50:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxP-0003HK-PV
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhfs-0005o7-HA
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhfs-0005nj-Ab
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so7086073pgi.6
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=OmquU5pLX4FdtJeBi0sZUSl7FBDLh8w+FhsdYMBvZRk=;
	b=LtoZgn4O9WBk7B/uvmTB+HfsxMb30Mz+qE78HE1gvNeuBfhLBPZnCKyIZMSGdLUA/5
	BNlEkYt7wZEvHs3TQ1y9dn2rb2VKySqRNtdMHOO/84TXV8Enr546rKRFFbsXWxKtsSn8
	LGxPJNnnOCPqcFDBLHOh05s99Z/h9EXWjnHywCDNGhkAhni25wxy43zjznqXQ9wTCPsM
	BYMD4pN0eVWK3AkRUTd5XwgpjIhjqtJuhcUiNzJgbRTCbhztRQuyCFK8lWAqD5rGI0qF
	ZGKz+FyZ2f2nkyaO2A4FAOJnNV5ITiBhhVYFkaHpnuyEtwIUrbWFcxNDxfzjJxbTHHBy
	en8w==
X-Gm-Message-State: APjAAAWaiXSdQYZ1bgfwWWgauwSewquCi/YS9etdZorfIHoqAKoJTnm1
	dOYfJAbFoA8xWjcK4nFnt0e3Ng==
X-Google-Smtp-Source: APXvYqzHrhWdg2xAkYl//ofxdVxMzdkhOY6GD2xewYUdhuga8Io9eYYbJNiWn6yClY9Fqh62oaYYpg==
X-Received: by 2002:a17:90a:de0e:: with SMTP id
	m14mr20184255pjv.36.1558833007034; 
	Sat, 25 May 2019 18:10:07 -0700 (PDT)
Received: from localhost ([12.206.222.5])
	by smtp.gmail.com with ESMTPSA id n2sm6014719pgp.27.2019.05.25.18.10.06
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:06 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:24 -0700
Message-Id: <20190526010948.3923-6-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.215.196
Subject: [Qemu-devel] [PULL 05/29] target/riscv: Use --static-decode for
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The generated functions are only used within translate.c
and do not need to be global, or declared.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/Makefile.objs | 8 ++++----
 target/riscv/translate.c   | 3 ---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index 9c6c1093271e..c7a1b063edc2 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -7,14 +7,14 @@ decode32-$(TARGET_RISCV64) += $(SRC_PATH)/target/riscv/insn32-64.decode
 
 target/riscv/decode_insn32.inc.c: $(decode32-y) $(DECODETREE)
 	$(call quiet-command, \
-	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn32 $(decode32-y), \
-	  "GEN", $(TARGET_DIR)$@)
+	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn32 \
+          $(decode32-y), "GEN", $(TARGET_DIR)$@)
 
 target/riscv/decode_insn16.inc.c: \
   $(SRC_PATH)/target/riscv/insn16.decode $(DECODETREE)
 	$(call quiet-command, \
-	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn16 --insnwidth 16 $<, \
-	  "GEN", $(TARGET_DIR)$@)
+	  $(PYTHON) $(DECODETREE) -o $@ --static-decode decode_insn16 \
+          --insnwidth 16 $<, "GEN", $(TARGET_DIR)$@)
 
 target/riscv/translate.o: target/riscv/decode_insn32.inc.c \
 	target/riscv/decode_insn16.inc.c
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 928374242e83..b09158117f32 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -558,7 +558,6 @@ static int ex_rvc_register(DisasContext *ctx, int reg)
     return 8 + reg;
 }
 
-bool decode_insn32(DisasContext *ctx, uint32_t insn);
 /* Include the auto-generated decoder for 32 bit insn */
 #include "decode_insn32.inc.c"
 
@@ -701,8 +700,6 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 # endif
 #endif
 
-bool decode_insn16(DisasContext *ctx, uint16_t insn);
-/* auto-generated decoder*/
 #include "decode_insn16.inc.c"
 #include "insn_trans/trans_rvc.inc.c"
 
-- 
2.21.0


