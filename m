Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69218C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F11320BED
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuqgzU65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F11320BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXfC-0005u0-Cr
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsXeZ-0005S9-Ut
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:23:52 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jsXeY-0007f5-63
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:23:51 -0400
Received: by mail-pf1-x441.google.com with SMTP id i14so940851pfu.13
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 13:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VkI/7OkT/JQH939iZ2rt2OKPxgnREi50rQESgyzIJ1k=;
 b=JuqgzU65FoRKodaR9pmkpQqoFSVyafa+l0Ri8y9ZnOxXxlD74WTnzwf+jI3ZWJnj8H
 aYU2CqcFH6py4Mp6DKGodjxMBuOfYbnHvYWkTLrCr3ztk2Z+OzVloTj7lV1+2QTlRFeE
 tuMJIqolNuMEtwVQ2T3ZYaIK4pXYqjUV5/Dd+tEEQNLMmRBgtld2xB+5hj6hwxAWsb/w
 NYWLsl9UDjKOFSPkebRiP4kPmjNT2Ps1hGxAxM2sPd6+iONQusbvlTPkLjtEh9UeGbfZ
 /dcb4jI29+5kbkv6fvcXu9lK1YaSlhTaKnTUsHp0Elmcsvuwm+31VpRuGyxBp4xtESiO
 /5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VkI/7OkT/JQH939iZ2rt2OKPxgnREi50rQESgyzIJ1k=;
 b=DDl5DX/SYMyfsu33GlEVBy6vZfVoym4fuRgOHHLHID4H+At4i5rNfjGdUeGL8OcXCO
 qqUQ268b4DwnoCdJM0MVihbKkh+LBYtiwIBbW/0RJyzt/Fi1OALdUB5ch4q+2vmH/nOG
 fzdsukXpA/TXnuOPoEN1axyViE1rI/rLkJR/YCz1TbpsJOLCQvegiP8Q/RH6szb7BKxW
 RyaPJY7fOqf89F6aN69hXpbklB0Z9VMVi8df4gzdw2urzHYdk8HqD4gs7UXx1k5jVgpa
 EvanZIBJgMhyG7YTkQ5lBSCzKM7vaIAfa3Kd6e5Mm9zAiCCnPHA2QH+aJc4FjNtbX36B
 fn7A==
X-Gm-Message-State: AOAM532kNBvxREnwEnct3QU5ai8l/Batdf7/D60r0pXGkG2Nl4QkaH+o
 l1ko452X6DZAZuUXS/AltBJZySvtvjc=
X-Google-Smtp-Source: ABdhPJxz1aNGDJBky14K3S35yr+UW6NsRtHs6yyy/Ykmv92XX2x8ckQ+EQXhq6hIPbpuJbiJyCBj6Q==
X-Received: by 2002:a63:3ec4:: with SMTP id l187mr9547145pga.371.1594067027804; 
 Mon, 06 Jul 2020 13:23:47 -0700 (PDT)
Received: from localhost.localdomain (097-090-106-114.biz.spectrum.com.
 [97.90.106.114])
 by smtp.gmail.com with ESMTPSA id mg17sm282049pjb.55.2020.07.06.13.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 13:23:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Fix mtedesc for do_mem_zpz
Date: Mon,  6 Jul 2020 13:23:45 -0700
Message-Id: <20200706202345.193676-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mtedesc that was contructed was not actually passed in.
Found by Coverity (CID 1429996).

Fixes: d28d12f008e
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 08f0fd15b2..88a2fb271d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5275,7 +5275,7 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
         desc = FIELD_DP32(desc, MTEDESC, ESIZE, 1 << msz);
         desc <<= SVE_MTEDESC_SHIFT;
     }
-    desc = simd_desc(vsz, vsz, scale);
+    desc = simd_desc(vsz, vsz, desc | scale);
     t_desc = tcg_const_i32(desc);
 
     tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
-- 
2.25.1


