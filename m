Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B47BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2621B20757
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mlqP/lXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2621B20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfXy-0006Xg-9x
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfF3-0001N9-0S
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:33 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfF1-0005G1-8b
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:32 -0400
Received: by mail-pf1-x441.google.com with SMTP id 17so730586pfw.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UD6YQPwqrNk8aVHv/Pbf8iTSNfjWSSiBgehdYJhx7tU=;
 b=mlqP/lXHcJ+i+A0RZwyKXETVs2fnnodznLFd7sZOKCkABHtOqDlWQk6TUShhqlfUeS
 uONuvkmvFSuZJB0VJ2PkeQg9UbdzsWvB1ISLVg8vxhiTj4cDRb3t6Ef9AjWQIvuhxeA/
 65quXobR3U4w+PX2rHGp9tdXL0met06OTLU42kDUCdkFvsgsJd9DxI0PIUT+DAT4edOK
 SyBlLz6FdJ7nLVkBJRVfZNHGLZoHI7WlPe8RuUoSeUMZ1c3Ks2ia9ERVwk1u/ipg3fjP
 1kZHcJdp5OGY5o3+HAjRQTs/5eGtQDhT5e1sznFd+TvtFtdQDgCSckNBwIxE1dd11Qcf
 7JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UD6YQPwqrNk8aVHv/Pbf8iTSNfjWSSiBgehdYJhx7tU=;
 b=kzsZTgkTM8x5u6wxR2sNdMnhvFKOXe6IdIwK4zJTje/D3FRGYt/rxRzDVR7SkNhvmP
 u/FOvfk8GoYYaR88S3kK9Dks/b6flXbM17CZ4fe/DfvUxNFXl67xnOcpcGitHwn/IyXY
 aq13/BU21l6lJocPtqYYa945lNYOuArXAqguoRv8w/DxuVHpYUA36LqsHrmSPiBjLadO
 nfXaEq89vtp85O8EaMQwKc4qz6Rpsb9JCLnsQZi1NlHBdFNCQfrh1sJJjbrMFirYbMxN
 UnTZISHxxTY3ZvPX1gNUV3nOcR0XhtYx5Ifne4qxPaqSTeKmcuZR3JZ8AD15x2IZ1zyv
 g54w==
X-Gm-Message-State: AOAM532CcnrnwyLx8gGbkZu+926gZfRF4bt70c8aRJ9h2+V7AgwjMabi
 2GBO/lLSVMqzV+PFc1S36Xu9u14HZYsBnQ==
X-Google-Smtp-Source: ABdhPJwvNp7RKgqah1zkp7N/ta+SqS3Tj6OOiDT3pyZpgVVIfv3k+oYYE/YFti2l2vJHMyxu5TVLZg==
X-Received: by 2002:a62:17d5:: with SMTP id 204mr1474738pfx.109.1598624429658; 
 Fri, 28 Aug 2020 07:20:29 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 46/76] target/microblaze: Convert dec_imm to decodetree
Date: Fri, 28 Aug 2020 07:18:59 -0700
Message-Id: <20200828141929.77854-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  2 ++
 target/microblaze/translate.c  | 18 +++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 4644defbfe..ad15c16f9b 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -79,6 +79,8 @@ cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
 idiv            010010 ..... ..... ..... 000 0000 0000  @typea
 idivu           010010 ..... ..... ..... 000 0000 0010  @typea
 
+imm             101100 00000 00000 imm:16
+
 mul             010000 ..... ..... ..... 000 0000 0000  @typea
 mulh            010000 ..... ..... ..... 000 0000 0001  @typea
 mulhu           010000 ..... ..... ..... 000 0000 0011  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 964525f75e..54de136a16 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -477,6 +477,15 @@ static void gen_idivu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA_CFG(idiv, use_div, true, gen_idiv)
 DO_TYPEA_CFG(idivu, use_div, true, gen_idivu)
 
+static bool trans_imm(DisasContext *dc, arg_imm *arg)
+{
+    dc->ext_imm = arg->imm << 16;
+    tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
+    dc->tb_flags |= IMM_FLAG;
+    dc->clear_imm = 0;
+    return true;
+}
+
 static void gen_mulh(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
@@ -848,14 +857,6 @@ static inline void sync_jmpstate(DisasContext *dc)
     }
 }
 
-static void dec_imm(DisasContext *dc)
-{
-    dc->ext_imm = dc->imm << 16;
-    tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
-    dc->tb_flags |= IMM_FLAG;
-    dc->clear_imm = 0;
-}
-
 static inline void compute_ldst_addr(DisasContext *dc, bool ea, TCGv t)
 {
     /* Should be set to true if r1 is used by loadstores.  */
@@ -1561,7 +1562,6 @@ static struct decoder_info {
 } decinfo[] = {
     {DEC_LD, dec_load},
     {DEC_ST, dec_store},
-    {DEC_IMM, dec_imm},
     {DEC_BR, dec_br},
     {DEC_BCC, dec_bcc},
     {DEC_RTS, dec_rts},
-- 
2.25.1


