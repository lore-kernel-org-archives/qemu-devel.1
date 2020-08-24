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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD50C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E0A2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siPh5Teh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E0A2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9Ic-0005jF-Qi
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 06:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9HT-00045j-VX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:48 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:32974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9HR-0006UD-L0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:47 -0400
Received: by mail-lj1-x242.google.com with SMTP id v4so8937833ljd.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 03:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BkCwcfBNM7BKOKl57gmWIMBqW7Axyc57b2XfxEBkcT0=;
 b=siPh5TehtJdwwZWxZ0MkUjNuLJdkYO8qKCGrDJjVIP/ZTnuyE6VPS3P6ByQZsHnQ+z
 Edqd1KIifkzPOJTlt5yH3xmjGoMwJn4HikLPrAHtlfVoNdAdJSMsAWlxNN9MrpzH0p7M
 tw/yBRSRgLlheGv5DB8oI8su5U2rDWoqsmZQGhoP4yuM6oaBsLk7IIoohf6eaX/Nu2Vb
 +XGLRaVgnoHJp/8fXWCekJQe8vmqF3eLFbKCWdYzsBsn80LdQEjuemRmUQVQdRd7PKsz
 u1sdg59EuYORRApkrKUx4iLSARU45CS6YeCKoIoyTLrwcwD/LhE5tSt9gsdW3RWVt6QZ
 p/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BkCwcfBNM7BKOKl57gmWIMBqW7Axyc57b2XfxEBkcT0=;
 b=WVzuv7x3KrTwYjPnGGLw/PqTaaK63HrNDNpd8o9XTGpI4X+T2/aL+3NcgY6otWefwX
 kMy4n4bWxEJxOqI/0fkhNnqJYjo3J2AmSdaf5WwiO5Aod+cNZgy8Hj8dkenXH/EnqjG/
 c19yhQLogCm+TWIa4F63qx9UJb5yumoSop7iNXVDaX8HfudEDXN6pN1AmmtYANEIT9fR
 2HCQ6XvhmrYWz03dKQHqGy9PfkZwNvJPv8uMDE4tF1NmClRFNjT9pARzWYl/b3nEyIhl
 tXWetcyHUivxjvgZub7jJc1hyjsbGoGErc5xW/5J5mrUqxrWrP3ccw8tY67g/sGjXXpP
 VikA==
X-Gm-Message-State: AOAM532qU9Tq3aH/HudmhOmxm6Rh6C81sNXeFhzmo8GaAie17Pvu4QvW
 xgmKBcwchyygNDQqmt18W5RIMVv9aL0=
X-Google-Smtp-Source: ABdhPJzVUPC6DazmOluXl4uGLfHkcAVslQcqB2WJtH2Xz4xw0g8DrF22MMkb0W5zzUdsOgIrrvkqVA==
X-Received: by 2002:a05:651c:31b:: with SMTP id
 a27mr2163418ljp.455.1598263243821; 
 Mon, 24 Aug 2020 03:00:43 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id l26sm2166500lfj.22.2020.08.24.03.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 03:00:43 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 1/8] target/microblaze: mbar: Transfer dc->rd to mbar_imm
Date: Mon, 24 Aug 2020 12:00:34 +0200
Message-Id: <20200824100041.1864420-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
References: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
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

Transfer dc->rd to mbar_imm to improve the readability when
comparing to the specs.

No functional change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index f6ff2591c3..47637f152b 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1229,8 +1229,10 @@ static void dec_br(DisasContext *dc)
     /* Memory barrier.  */
     mbar = (dc->ir >> 16) & 31;
     if (mbar == 2 && dc->imm == 4) {
+        uint16_t mbar_imm = dc->rd;
+
         /* mbar IMM & 16 decodes to sleep.  */
-        if (dc->rd & 16) {
+        if (mbar_imm & 16) {
             TCGv_i32 tmp_hlt = tcg_const_i32(EXCP_HLT);
             TCGv_i32 tmp_1 = tcg_const_i32(1);
 
@@ -1246,7 +1248,7 @@ static void dec_br(DisasContext *dc)
             tcg_temp_free_i32(tmp_1);
             return;
         }
-        LOG_DIS("mbar %d\n", dc->rd);
+        LOG_DIS("mbar %d\n", mbar_imm);
         /* Break the TB.  */
         dc->cpustate_changed = 1;
         return;
-- 
2.25.1


