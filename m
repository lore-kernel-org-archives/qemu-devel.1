Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EBAC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8FB2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7Ln1MSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8FB2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9Id-0005l8-Rb
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 06:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9HU-000463-J9
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:48 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:38045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9HT-0006UW-1S
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:48 -0400
Received: by mail-lf1-x142.google.com with SMTP id k10so1168426lfm.5
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 03:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PqHm69GgyLtMiUEuM+bi1ibVuXEct1ZgT4gQS/un0FM=;
 b=c7Ln1MSMX7NrzhfBXjwBYrWzvaHDtbM3Y3STk2Ko1Id3BiCgA+DXwM+sPaLXOhEcO4
 tEbXhzMyoF4tSkz3KmNPvwMw0DWlvdbYNt2YOq6yFTqY5UELfAsYaw9Q4fzqkfLxgq6D
 /sSgp/rr/c/7OTBBv6RrDnYAwYUKNx0mI0yZVBgvS9+Ocz4GupjmoUW88epB3cKNbgsN
 gwgTvZPuefiJ/JYROjuyuiE1/DjXAfg/TNE93wTcDPfFZPV7iflBUnCXpcpD6x3P9Myb
 KKq/3NHv5IXFVux7rgM+oYiIz1RQj7CaN7euffmIhThsSe75ncxAFtxImqDN/wsrctXa
 88Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PqHm69GgyLtMiUEuM+bi1ibVuXEct1ZgT4gQS/un0FM=;
 b=aRkjgvLzyspTB+DeMUnbacH2VSA+J1tp5K9bpmKzyMkA9t3MGsFY+fjt9t7XHBSWcA
 MEWmScUYTIUA+hSQFknxaRiYJtlJ+9evvbXkiSjqsKRF8vLXPEDZoHcjtRv29zicQGnb
 8BtmDUMSNljzsNqKVu9XXmZxflBVVDFLv8TU2oNfhIMLEZjUNYBiE/Wkmwq+ciMxddRZ
 6xwgvidLvjasag7SvDAZUCQiMHUpb0O635XbJCIzlEZLO+ddLNTg6LLMx5XZb00oXe4F
 0K2VGANwogd1spPenWaZguauAyp3vDub6X4XYJG9jpv5m3+cuHvGsB7vhQGe/bnAvShs
 jDpw==
X-Gm-Message-State: AOAM533MMUqP8o9WxSs6wyorK+oiVXFG2+qlNIL/deBd7lsEIJkF31kp
 NqkU1j4rhNCKfCiHH72/7o02sIHQBRw=
X-Google-Smtp-Source: ABdhPJwtEn88dj2Cqrmf+iW8bANye9yZK7Rtxx7LzxCDWmYoxPYZliG4fAoAldUTylHAxLyQVzW/tg==
X-Received: by 2002:a05:6512:3a5:: with SMTP id
 v5mr2253813lfp.138.1598263245079; 
 Mon, 24 Aug 2020 03:00:45 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id u14sm2094383ljg.55.2020.08.24.03.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 03:00:44 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 2/8] target/microblaze: mbar: Move LOG_DIS to before sleep
Date: Mon, 24 Aug 2020 12:00:35 +0200
Message-Id: <20200824100041.1864420-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
References: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.724, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Move LOG_DIS log to before sleeping handling so that it logs
for sleep instructions aswell.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 47637f152b..c1be76d4c8 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1231,6 +1231,8 @@ static void dec_br(DisasContext *dc)
     if (mbar == 2 && dc->imm == 4) {
         uint16_t mbar_imm = dc->rd;
 
+        LOG_DIS("mbar %d\n", mbar_imm);
+
         /* mbar IMM & 16 decodes to sleep.  */
         if (mbar_imm & 16) {
             TCGv_i32 tmp_hlt = tcg_const_i32(EXCP_HLT);
@@ -1248,7 +1250,6 @@ static void dec_br(DisasContext *dc)
             tcg_temp_free_i32(tmp_1);
             return;
         }
-        LOG_DIS("mbar %d\n", mbar_imm);
         /* Break the TB.  */
         dc->cpustate_changed = 1;
         return;
-- 
2.25.1


