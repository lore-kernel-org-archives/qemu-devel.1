Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9024C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65DC204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLi27PxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65DC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48582 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcthD-00085u-0W
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46762)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiP-0003jO-0y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiN-0008A4-ST
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53422)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiN-00088n-DG
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id x15so9550666wmj.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=L1QAxhdOtIdBK1xtHMazBBt8aewsGSxHd8eF0bvtE2w=;
 b=gLi27PxJkBunaTCfeqNp/HV3cboHFgmT6UlJo4uqXGs+5Hy5MfbaPe9KsxnL2Xn3CE
 lcdymT8iZwsOMiGigOYC4y7hkhEQMPnrzfztc9qVMTFF2yV20sWJw/u1jyOm1xNg/57D
 GDxtEX8yhyGLYtYuHLkXg2IF/CxkyCbPq4sLOK6Knbzyi6SXL55WOHlHbgdeyY0LrVJ7
 TcXlURXqCooiqhVClQZW/EA8YVUT5KUr/8URPlPPwJLRy1x8UxXS2ExUOantpqjclGzQ
 cnI4Nc8p4hzxBlFZGDJTnchrRdUMXlWIUyXTO7r7BdzdGEyzy7aA0LAdjyFUBrTM5bXj
 yYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L1QAxhdOtIdBK1xtHMazBBt8aewsGSxHd8eF0bvtE2w=;
 b=N+E0s+3LA8HPWk+M+BcoycLFAsx0B1z6Z2Qgzg3T4zfAmE98mhPMuKlCBjxzBTCfpj
 ORG59uwB9hKu435jsg/meakubdWwPmkj7cLR9ZDFRYhaVnhMjh/m5tz6F0MF7OnovtAz
 dr4ccotTx5z3BQX4s2QwBLTUCO/x5uvGXp9kYYLmmYeJZxOR7tg2zirR7tJ0FuN7jIUV
 waY2zyHxkq2boDvln+JEPQMDC+yX9UqaMsKNEPyFdtkKMbF46RMDh4E+akzFFxnn2zsy
 mgYd/IMkx42kOo9gNTlV1PLwbtOdzfhyOozVSVOAQcg4IGCWoHqVABWnZPbtJj9UywE0
 voVg==
X-Gm-Message-State: APjAAAXeuFUhj17zsrF7Iebmmyl6vj2gc8IG9rc4ZZ7dZ8mqe2pYOBY5
 SJXXX40C5op1xU3zFjZ6yzqAnaKaOspTTg==
X-Google-Smtp-Source: APXvYqxLsz9tLXyOwnSaCSsvorfZJbSAhafu9PiZ7b5PZ/xz5LKHik3Z0/kWUy+iq8+BZzOgdLxPdA==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr20892673wmh.115.1560782070131; 
 Mon, 17 Jun 2019 07:34:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:34:02 +0100
Message-Id: <20190617143412.5734-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PULL 14/24] target/arm: Stop using cpu_F0s for
 NEON_2RM_VNEG_F
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

Switch NEON_2RM_VABS_F away from using cpu_F0s.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190613163917.28589-5-peter.maydell@linaro.org
---
 target/arm/translate.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a10fded1f39..a006ab498e7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1374,14 +1374,6 @@ static TCGv_ptr get_fpstatus_ptr(int neon)
     return statusptr;
 }
 
-static inline void gen_vfp_neg(int dp)
-{
-    if (dp)
-        gen_helper_vfp_negd(cpu_F0d, cpu_F0d);
-    else
-        gen_helper_vfp_negs(cpu_F0s, cpu_F0s);
-}
-
 #define VFP_GEN_ITOF(name) \
 static inline void gen_vfp_##name(int dp, int neon) \
 { \
@@ -4189,8 +4181,7 @@ static int neon_2rm_is_float_op(int op)
      * what we are asking here is "does the code for this case in
      * the Neon for-each-pass loop use cpu_F0s?".
      */
-    return (op == NEON_2RM_VNEG_F ||
-            (op >= NEON_2RM_VRINTN && op <= NEON_2RM_VRINTZ) ||
+    return ((op >= NEON_2RM_VRINTN && op <= NEON_2RM_VRINTZ) ||
             op == NEON_2RM_VRINTM ||
             (op >= NEON_2RM_VRINTP && op <= NEON_2RM_VCVTMS) ||
             op >= NEON_2RM_VRECPE_F);
@@ -6761,7 +6752,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             gen_helper_vfp_abss(tmp, tmp);
                             break;
                         case NEON_2RM_VNEG_F:
-                            gen_vfp_neg(0);
+                            gen_helper_vfp_negs(tmp, tmp);
                             break;
                         case NEON_2RM_VSWP:
                             tmp2 = neon_load_reg(rd, pass);
-- 
2.20.1


