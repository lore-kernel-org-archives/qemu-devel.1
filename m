Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4334AC07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164A420644
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164A420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49229 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUi5k-0002ec-3n
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:36:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxR-0003Hg-27
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhfr-0005nT-DL
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhfr-0005lj-69
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id b76so7496168pfb.5
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=AGynrsN21pUOx1n9WYF4sVDzoqOhDbKXNfRUTxBfjrw=;
	b=O8sDa5kVYJLu0kOQNUNewa9Zhl7pqUVzOWCUxhyRpTsvRc4DP5L0I5n72LDHALSz2I
	C48E5TSIt5VQsSvqOAJt5JId00z4FV8RTKc7gphiNlG595gA9ew55UaGpZv+XG+4zz8S
	GiJyeQ//5SmldHibJsw5eENTiOgsM670jU2ni7QWhEgCEb6T8oBxS8Ef70TgKrqzUzmq
	+OumWLAvOEdN9GcNlgqJT4h9J+oPU9gEMCurdrbqW//uelYGC/dLz/ozktnIqFIeS5Dw
	I8l3Sko47XGWvLGTc22mZuDRiQlsrI9cIHTFY7TK9rf6TSzmPbnkkVKpZY5h/NWgYrk1
	gQsg==
X-Gm-Message-State: APjAAAWi97+HnaWZrIV94MtC36BdGPbPyYf3+4Xjl63yCC+yvVqCC4gO
	L3Hu9bf8Gck799rVU3EOAdRDwwkFSds=
X-Google-Smtp-Source: APXvYqwZY92aKwMSdJQkCQ2IbMRsfUvYIvnktU69XpIv7DBfceh2O5y1c7D6P9AsqkIeKoTCD+mQLw==
X-Received: by 2002:aa7:8dcd:: with SMTP id j13mr22711737pfr.107.1558833005679;
	Sat, 25 May 2019 18:10:05 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	e123sm6733854pgc.29.2019.05.25.18.10.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:05 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:23 -0700
Message-Id: <20190526010948.3923-5-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.193
Subject: [Qemu-devel] [PULL 04/29] target/riscv: Name the argument sets for
 all of insn32 formats
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/insn32.decode | 10 +++++++---
 target/riscv/translate.c   | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6f3ab7aa52d3..77f794ed703d 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -34,9 +34,13 @@
 %imm_u    12:s20                 !function=ex_shift_12
 
 # Argument sets:
+&empty
 &b    imm rs2 rs1
 &i    imm rs1 rd
+&j    imm rd
 &r    rd rs1 rs2
+&s    imm rs1 rs2
+&u    imm rd
 &shift     shamt rs1 rd
 &atomic    aq rl rs2 rs1 rd
 
@@ -44,9 +48,9 @@
 @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
 @i       ............    ..... ... ..... ....... &i      imm=%imm_i     %rs1 %rd
 @b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
-@s       .......   ..... ..... ... ..... .......         imm=%imm_s %rs2 %rs1
-@u       ....................      ..... .......         imm=%imm_u          %rd
-@j       ....................      ..... .......         imm=%imm_j          %rd
+@s       .......   ..... ..... ... ..... ....... &s      imm=%imm_s %rs2 %rs1
+@u       ....................      ..... ....... &u      imm=%imm_u          %rd
+@j       ....................      ..... ....... &j      imm=%imm_j          %rd
 
 @sh      ......  ...... .....  ... ..... ....... &shift  shamt=%sh10      %rs1 %rd
 @csr     ............   .....  ... ..... .......               %csr     %rs1 %rd
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 840ecbef36e7..928374242e83 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -687,11 +687,29 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
 #include "insn_trans/trans_rvd.inc.c"
 #include "insn_trans/trans_privileged.inc.c"
 
+/*
+ * Auto-generated decoder.
+ * Note that the 16-bit decoder reuses some of the trans_* functions
+ * initially declared by the 32-bit decoder, which results in duplicate
+ * declaration warnings.  Suppress them.
+ */
+#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+# pragma GCC diagnostic push
+# pragma GCC diagnostic ignored "-Wredundant-decls"
+# ifdef __clang__
+#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
+# endif
+#endif
+
 bool decode_insn16(DisasContext *ctx, uint16_t insn);
 /* auto-generated decoder*/
 #include "decode_insn16.inc.c"
 #include "insn_trans/trans_rvc.inc.c"
 
+#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
+# pragma GCC diagnostic pop
+#endif
+
 static void decode_opc(DisasContext *ctx)
 {
     /* check for compressed insn */
-- 
2.21.0


