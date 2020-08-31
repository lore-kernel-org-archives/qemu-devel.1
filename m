Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81928C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ABB92073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckY9sN+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABB92073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmdP-0003Gq-2s
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKr-0005Vo-Tj
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:09 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:52760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKq-00064n-3N
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:09 -0400
Received: by mail-pj1-x1029.google.com with SMTP id o16so29089pjr.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jni1aHgtz1xoXSckuiw7DlpTrv9tJ1hfnOPizu6DAmk=;
 b=ckY9sN+WUn7AlY2+rkuto/4pq/OVmB/rjI0nPhU7+NDoyvJGcyGv2ufNF+xR6v0WiW
 6Oda1WzW+a8y9059m1EAw6CgMPYYg9+42YqPMMdtLd8BU41+DfOHNLSQAT3JLJDPXdF3
 BbbhEzW7HWe5Djwn5s0F9ueA7aZO3GLDNiXjiegfxRH7BQmI7SJMqgUbuvikf6B7MgIS
 zrgNhOgKqs92wqNDE5Wvc33NVAN8F6ZnCd2xWqAqutwIjCBxIvVSc+L0N0V4TIs/ZHCn
 7CfNCL+YhvQhwjrRHkfrwZiRR2TyRaVGU4oK45dURI4fR/x/dV8pgyoALsVa9xvGiaa4
 OP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jni1aHgtz1xoXSckuiw7DlpTrv9tJ1hfnOPizu6DAmk=;
 b=DJ8EPwjLL6q9S/HWtDg6j4eUYCbjnx5HNTrzM+qSaObFE0FTogzkSyX+XRbI0LU7W2
 VIpwWM513yUWVtpjnzgj8FhDn90je2ocp8J8sH3Jnv3kXINO/18z98AT/SEKuNaxZW6S
 s/jjcH8TITSEXFA8KaZPhBeYPQK8dYrkYw1ggZ1pdYjZJUkYT8HyranrEJVPoulAfHBB
 7uUOGXFjdvMpy0f81e09HKGSnIoUpiFBjFMKX2kLamfbvcjbefBh/FpJjkGvsWPXFOr3
 2qcKBzw78koTNCmPF8RZBo5LDbCfI8tFM2u5w3Z07aXFabP29SwAW+0p5eNQpe8kEEnK
 xWdw==
X-Gm-Message-State: AOAM531i3gm3WkpGBcpZkrMLepjn7AoO6t5Q3md9Hr6zmZ2yqskSVhZT
 11lhxiMBL+iAAqHIMJgAf+k61dpmtP0g8w==
X-Google-Smtp-Source: ABdhPJxoHY3OYpr0HSn+WzPeZBnnPSTXlS029PIiM7ED8Jhi0A6aytj/tPq4TXBNt/nVXL4Qkhk07g==
X-Received: by 2002:a17:90a:5a48:: with SMTP id m8mr64011pji.181.1598890026338; 
 Mon, 31 Aug 2020 09:07:06 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/76] target/microblaze: Convert dec_imm to decodetree
Date: Mon, 31 Aug 2020 09:05:31 -0700
Message-Id: <20200831160601.833692-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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


