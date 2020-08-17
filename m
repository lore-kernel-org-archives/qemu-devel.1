Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE41C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397842065D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YF/rUwhG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397842065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7fjG-00051M-EO
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k7fhx-0003Hv-J8; Mon, 17 Aug 2020 10:01:53 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:35510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k7fhv-0001We-0L; Mon, 17 Aug 2020 10:01:53 -0400
Received: by mail-lj1-x242.google.com with SMTP id i10so17606858ljn.2;
 Mon, 17 Aug 2020 07:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YijezSjj37b3KI8DzXtGc07DWsdbUe75Toiwcts1NQA=;
 b=YF/rUwhGmFUPujnQ7vq2K4GiXayIL+d1C3l7mjkgDdTVho3yD9xIOoiz5U8AM8aqPF
 8iWs1m2cK79vVFH+b9yDbmxCRxGBNtcQM8bjztfAKnfnAARhK/3Dzt+vF1d81V2+1gBu
 P00+ciwOq2zFSFEFVtLccCBpq4eB62qgLDd1BuRVLwLDXjqS4t4OXZvlKAzaOqG3grNO
 P5mTWOkKvenav7Dkr5p7waOvbjd6CKzY9ocK0NQ5Z1vJRWhI0nZSlmDNPUmZ4znDF+iR
 UOJaoFql9QYDiwgXznV0bU7QW+iVHUA9x5mIP6sv/FLKcxBCuIlwos6QVUwn9TTvRul4
 xIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YijezSjj37b3KI8DzXtGc07DWsdbUe75Toiwcts1NQA=;
 b=E4G4YHseFqpSG/XoGxzrE7FM+H6RxN8exKWlrXhRKGfGY60GAyEWxztE0dEy7ev0Ds
 rGmvWwDA07TdR/SMCSlSavyrPWETu4rmkCaSHuG9uz5WU49ptJTXdpdhaz3OMoI4Ptff
 CLwad5XCrX+gjkHoTvoEYyRHufZcMsL3XdeVt5bvrTv3nyPl0VDp+y+GbZFDgWCuyg43
 z+uZX8cao8MhtcT0ETWIJ0JrCmnmdMn3qdkWXPWaMIBLRcIvCYzRuJIiqV2zf+mQVj0/
 q7vzfhl31X/w+xosE7W4n7QkJcTp52g+SiAeTx8ulhk+2oClIzN7y0UhtTm0+p+mZwu6
 sN9g==
X-Gm-Message-State: AOAM5338rwBDlZkwNz93lgHkEZ4nf1rZM1eUWhK71HDgNGdZLYAyxv2q
 REEoV5F6L3e4ejWnHOKWYv54V3rXidb8cWi6
X-Google-Smtp-Source: ABdhPJzdYWfSc11z4Ar/F9bT0efMtFUq66I4lQZbOv2CKizNS/WvgzZNAb5IpbihimdKGSiVtTKMug==
X-Received: by 2002:a05:651c:110:: with SMTP id
 a16mr7987230ljb.152.1597672908652; 
 Mon, 17 Aug 2020 07:01:48 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id b16sm5063513ljk.24.2020.08.17.07.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:01:48 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/5] target/microblaze: mbar: Move LOG_DIS to before sleep
Date: Mon, 17 Aug 2020 16:01:41 +0200
Message-Id: <20200817140144.373403-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200817140144.373403-1-edgar.iglesias@gmail.com>
References: <20200817140144.373403-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Move LOG_DIS log to before sleeping handling so that it logs
for sleep instructions aswell.

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


