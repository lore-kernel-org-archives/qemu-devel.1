Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083ADC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF932084A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBRTNCWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF932084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcton-00071F-VE
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsib-0003ps-PD
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsia-0008IH-4r
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:45 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiY-0008EA-1T
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id w9so112657wmd.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XTL6vXsjTHflOLJ+e9+ddR0nb34AKoiPztLrrZicDQo=;
 b=jBRTNCWhLhvz66UFl/CDCvq9ye4qNbrqs0vbk5HVUcOzk25C2Vgmkr1QRVFEygpBCX
 nwkuPy/gXBZKXSQFYFX3cZjpdSLarSBbW2gWrZcC30OEqTzJIv6zWLT9cBX2JnENsUK/
 LwPmV44KniHuJAXbCmrItr0GMgRm+dByij/o39/ea23xEtNsguEerU2SuNwRuGgwY6vz
 G2EWY/KAPDspf2rCrx9ZmaAQPbgp+QqaBEPe0hj2R6XoyApwhTD+++yGJUZe6CBZ6GU3
 hvYU+v/ULrG/Yo8zh5LPtNrIn/rgtj6CmQjOIU9TPspSMTmu5DsuEB/Pr9H0EORyRs6C
 nGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XTL6vXsjTHflOLJ+e9+ddR0nb34AKoiPztLrrZicDQo=;
 b=UUsCR2fk/z34++HZ7sNstctF6Zw3XDAGr/1T0ASHHd+DSJUFhRDcMTvOcaAH4bpdXA
 fR85iMB0K9jt2RLNYdb72UfyKevUU21DIzQIvBO7LgWugSpkvELDLZK2O+7f+pExBJPd
 1ZpfLEbBg4HnRMz21GIkDP5Tq1QOST3nMAU9eGLtmauphVZMxsrfYB+HiTGLpFIytqVm
 9w2iqqNmdKgVEHbZMTJl0//DW+hKJEGgEziZAqOx6qqXeNaTOHKSyW2/+X462qaPW5Da
 L3u0V1ZbgPofzbSW0x86Xf4j6/whG2Tzb+cBA4/BerXqDNcnqLoy2zT9x7mef6zsVflD
 3tiQ==
X-Gm-Message-State: APjAAAWoBN/aO6qIyl3FPj51MQQIk0/TxSlAuxB1uR4JwQPtAAHgv3rV
 Cj0Kbnjz2HVGm2I8PSPemaRCCN5lvk2coA==
X-Google-Smtp-Source: APXvYqxHOxyU9+b2rjbHAqGJQ/hSstDSEo6gyGLG+vWbB64GWDcr2WN0vg19EpzwLzrUurGs+q8xQw==
X-Received: by 2002:a1c:8a:: with SMTP id 132mr19189066wma.44.1560782077170;
 Mon, 17 Jun 2019 07:34:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:34:09 +0100
Message-Id: <20190617143412.5734-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 21/24] target/arm: Stop using deprecated
 functions in NEON_2RM_VCVT_F32_F16
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove some old constructns from NEON_2RM_VCVT_F16_F32 code:
 * don't use CPU_F0s
 * don't use tcg_gen_st_f32

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190613163917.28589-12-peter.maydell@linaro.org
---
 target/arm/translate.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2ba620ac1e1..8f124a953b6 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1542,8 +1542,6 @@ static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
     return ret;
 }
 
-#define tcg_gen_st_f32 tcg_gen_st_i32
-
 #define ARM_CP_RW_BIT   (1 << 20)
 
 /* Include the VFP decoder */
@@ -6460,20 +6458,18 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     tmp = neon_load_reg(rm, 0);
                     tmp2 = neon_load_reg(rm, 1);
                     tcg_gen_ext16u_i32(tmp3, tmp);
-                    gen_helper_vfp_fcvt_f16_to_f32(cpu_F0s, tmp3, fpst, ahp);
-                    tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, 0));
-                    tcg_gen_shri_i32(tmp3, tmp, 16);
-                    gen_helper_vfp_fcvt_f16_to_f32(cpu_F0s, tmp3, fpst, ahp);
-                    tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, 1));
-                    tcg_temp_free_i32(tmp);
+                    gen_helper_vfp_fcvt_f16_to_f32(tmp3, tmp3, fpst, ahp);
+                    neon_store_reg(rd, 0, tmp3);
+                    tcg_gen_shri_i32(tmp, tmp, 16);
+                    gen_helper_vfp_fcvt_f16_to_f32(tmp, tmp, fpst, ahp);
+                    neon_store_reg(rd, 1, tmp);
+                    tmp3 = tcg_temp_new_i32();
                     tcg_gen_ext16u_i32(tmp3, tmp2);
-                    gen_helper_vfp_fcvt_f16_to_f32(cpu_F0s, tmp3, fpst, ahp);
-                    tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, 2));
-                    tcg_gen_shri_i32(tmp3, tmp2, 16);
-                    gen_helper_vfp_fcvt_f16_to_f32(cpu_F0s, tmp3, fpst, ahp);
-                    tcg_gen_st_f32(cpu_F0s, cpu_env, neon_reg_offset(rd, 3));
-                    tcg_temp_free_i32(tmp2);
-                    tcg_temp_free_i32(tmp3);
+                    gen_helper_vfp_fcvt_f16_to_f32(tmp3, tmp3, fpst, ahp);
+                    neon_store_reg(rd, 2, tmp3);
+                    tcg_gen_shri_i32(tmp2, tmp2, 16);
+                    gen_helper_vfp_fcvt_f16_to_f32(tmp2, tmp2, fpst, ahp);
+                    neon_store_reg(rd, 3, tmp2);
                     tcg_temp_free_i32(ahp);
                     tcg_temp_free_ptr(fpst);
                     break;
-- 
2.20.1


