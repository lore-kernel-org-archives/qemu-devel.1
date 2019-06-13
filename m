Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089C8C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D185620B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDC2C3uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D185620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUrE-0007qj-2C
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53864)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlL-0004BM-CI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbSlH-0003S8-6K
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:43 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbSlG-0002oK-JW
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:39:38 -0400
Received: by mail-wm1-x344.google.com with SMTP id h19so7008315wme.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XS2MzO+cZz80eCqH3YLxLgykyR6csa7kzG0bgwV0MQs=;
 b=jDC2C3ucnpWxPg+WaSc54V269pFuNFIb5O964icnyjuTfv99fMovYHHGeOhZBOS83m
 XzJlsSCudwGb9zoTssiR6OCjK/ncKGIlw85odhbwrhbY549dsASdGmcv0uMu/FAuvdNu
 t6bgHxzUgjaZIXdIvdSSTUHuduxnV7K2q6h8Jc2H+hIJSeTGTZ9/DGPGJ98RM87ZaVhm
 drjymb3HhWo3As6kq7Lz+zNLT35gYLASdWUoK6RsoPKhyaOcZ3d3p7l/Dx3b89Nk0iMv
 eLg3Q8GbOI2AHbYW4Zt71LbLUMwFxZRReSoMBURpmwzuXVffxUhAg/MUwaajb5lyWppY
 Y7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XS2MzO+cZz80eCqH3YLxLgykyR6csa7kzG0bgwV0MQs=;
 b=qUJUua1UoQz3fDTlP4akYw6X8HL46SzGJxMwz1ePFp5cHUxDF39mL1lNLvDCbm/Srz
 KU5Q4+p500ZRg3tk4dTWhV5aHrQOrIXPwnEo4lfo3gwJaZLdBiJCtqZiAHg08zHtNkPN
 7UK6EnmRZSOcp7FVNOMXXbnyVmt6DNQV+WZVPSMrjYLCU/KoxEdFuOeue81lz+/RvNkS
 Z3zFP6K8zQonh6pF53OByzfK6D/xFog116QHCVT6af9lPGKxNIlj+3CkTLhDWyCauP6s
 Ochd1W0buStbzTSv4afMRde1cuct6uPXJsia5UwNg8EszUoG4bMIORJqd6Qd4m7yzV9J
 WNxQ==
X-Gm-Message-State: APjAAAVspoc/NrwUtGeqoUm5vjvZFpWFxPLexHA0WGEemoCUXzFP68oV
 +TmyiI6nlheYqSarOcv26a8ey5fPfX11Mw==
X-Google-Smtp-Source: APXvYqx4Ru4SKe7Zh+MV4lNYvP/AFw1gFyiMBU+Z5gcpnSHkszSLFyn+mMAGKarscMqJZKV0AFTAtg==
X-Received: by 2002:a1c:9a05:: with SMTP id c5mr4245105wme.36.1560443970002;
 Thu, 13 Jun 2019 09:39:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f197sm358747wme.39.2019.06.13.09.39.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 09:39:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 17:39:15 +0100
Message-Id: <20190613163917.28589-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613163917.28589-1-peter.maydell@linaro.org>
References: <20190613163917.28589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 10/12] target/arm: stop using deprecated
 functions in NEON_2RM_VCVT_F16_F32
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove some old constructs from NEON_2RM_VCVT_F16_F32 code:
 * don't use cpu_F0s
 * don't use tcg_gen_ld_f32

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d8b46130d42..2ba620ac1e1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1542,7 +1542,6 @@ static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
     return ret;
 }
 
-#define tcg_gen_ld_f32 tcg_gen_ld_i32
 #define tcg_gen_st_f32 tcg_gen_st_i32
 
 #define ARM_CP_RW_BIT   (1 << 20)
@@ -6425,25 +6424,23 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         q || (rm & 1)) {
                         return 1;
                     }
-                    tmp = tcg_temp_new_i32();
-                    tmp2 = tcg_temp_new_i32();
                     fpst = get_fpstatus_ptr(true);
                     ahp = get_ahp_flag();
-                    tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 0));
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp, cpu_F0s, fpst, ahp);
-                    tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 1));
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp2, cpu_F0s, fpst, ahp);
+                    tmp = neon_load_reg(rm, 0);
+                    gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
+                    tmp2 = neon_load_reg(rm, 1);
+                    gen_helper_vfp_fcvt_f32_to_f16(tmp2, tmp2, fpst, ahp);
                     tcg_gen_shli_i32(tmp2, tmp2, 16);
                     tcg_gen_or_i32(tmp2, tmp2, tmp);
-                    tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 2));
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp, cpu_F0s, fpst, ahp);
-                    tcg_gen_ld_f32(cpu_F0s, cpu_env, neon_reg_offset(rm, 3));
+                    tcg_temp_free_i32(tmp);
+                    tmp = neon_load_reg(rm, 2);
+                    gen_helper_vfp_fcvt_f32_to_f16(tmp, tmp, fpst, ahp);
+                    tmp3 = neon_load_reg(rm, 3);
                     neon_store_reg(rd, 0, tmp2);
-                    tmp2 = tcg_temp_new_i32();
-                    gen_helper_vfp_fcvt_f32_to_f16(tmp2, cpu_F0s, fpst, ahp);
-                    tcg_gen_shli_i32(tmp2, tmp2, 16);
-                    tcg_gen_or_i32(tmp2, tmp2, tmp);
-                    neon_store_reg(rd, 1, tmp2);
+                    gen_helper_vfp_fcvt_f32_to_f16(tmp3, tmp3, fpst, ahp);
+                    tcg_gen_shli_i32(tmp3, tmp3, 16);
+                    tcg_gen_or_i32(tmp3, tmp3, tmp);
+                    neon_store_reg(rd, 1, tmp3);
                     tcg_temp_free_i32(tmp);
                     tcg_temp_free_i32(ahp);
                     tcg_temp_free_ptr(fpst);
-- 
2.20.1


