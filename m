Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4360BC38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEDB22176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6587C+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEDB22176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MGq-0003gd-2N
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7t-0004lF-T8
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7s-0005yC-6l
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:57 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46458)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7r-0005xb-Vj
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:56 -0500
Received: by mail-pl1-x643.google.com with SMTP id y8so4607982pll.13
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UjJ9iZKHSouFYZlDrlpMHjdteZRncNwvhF4XGeCLWsY=;
 b=v6587C+nZ28pjxxCIAVJ4LI3tsgys+6pFrwhEJSb6vYV7gLZeXAHDEwUXdZe2TDkyE
 C4xNY32wTN5M9/i1N6MjlN+LXLR6QVt5hxks8T2YiHDinvyG3RhHHRYCcEydSbrlHUWS
 KNJ83G5bGZxIsu0Nq4VEGK2y4MzEwoMm2Y1TYCgfKRhw0hsPq4RMPouuL1WiEwrOaB1T
 mftxYmIDk0X1gxYVvu4IKeAQaIPUc8Vt8smiYXBZN7hUvyxCKtpidMZ239zaLcafk9xM
 PJdFAIfoW3BrHak2XsL3tSc7yGx5yeOtG7bvrmovAJI1ci8Ohvo6T2hoCrt3aCOoJKU7
 PVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UjJ9iZKHSouFYZlDrlpMHjdteZRncNwvhF4XGeCLWsY=;
 b=kqk4+8Ckgm386ILRCIOXKSxcf0l3G4X29pmUfhiBqB6qmePWnL2V7V4bJcNOi7Hjkm
 svSfJFQbelpE5Z0hRdQStD7tHHsuHHqdAPycvYobSWyIY6XgcTBCwgE5HCj9q7EheSQY
 EirArhYFfCEkhc83q2OaZV68GJ1IB8EB5G5Ki4xROiMxKQCE1BKWeALQ0TVpjUgMcXSx
 7zvKixtGrb2vkCInHnSmyR8/RMQKx59Luv/DTX3NK6+Mj7TKYTFsVuJAyWy1alHkLk+c
 u3kxGfDB9pbDyEHH0SzyxwKKEeTQvvwO8KqxpsJSvYQ/6j/uZXS+Yqgrl1bF+eLYqui+
 iURQ==
X-Gm-Message-State: APjAAAV3uP8MX2NGWEhoL2HJphjW+CxeGcBZ3PODfFfe9dGmJAIN2uX0
 GnEXlTGfzVBy6faxWosDwWmQazqDbks=
X-Google-Smtp-Source: APXvYqyjY63fn3H9ciiZhl3vypKBSQZJ3UW48VZXvMc60nj1kvaiM1tZmmLUFPCbYKtAfolb2vFsiw==
X-Received: by 2002:a17:90a:db0f:: with SMTP id
 g15mr1404254pjv.40.1582582974177; 
 Mon, 24 Feb 2020 14:22:54 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/17] target/arm: Add formats for some vfp 2 and
 3-register insns
Date: Mon, 24 Feb 2020 14:22:30 -0800
Message-Id: <20200224222232.13807-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Those vfp instructions without extra opcode fields can
share a common @format for brevity.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp.decode | 134 ++++++++++++++++--------------------------
 1 file changed, 52 insertions(+), 82 deletions(-)

diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 592fe9e1e4..4f294f88be 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -46,6 +46,14 @@
 
 %vmov_imm 16:4 0:4
 
+@vfp_dnm_s   ................................ vm=%vm_sp vn=%vn_sp vd=%vd_sp
+@vfp_dnm_d   ................................ vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+@vfp_dm_ss   ................................ vm=%vm_sp vd=%vd_sp
+@vfp_dm_dd   ................................ vm=%vm_dp vd=%vd_dp
+@vfp_dm_ds   ................................ vm=%vm_sp vd=%vd_dp
+@vfp_dm_sd   ................................ vm=%vm_dp vd=%vd_sp
+
 # VMOV scalar to general-purpose register; note that this does
 # include some Neon cases.
 VMOV_to_gp   ---- 1110 u:1 1.        1 .... rt:4 1011 ... 1 0000 \
@@ -66,20 +74,15 @@ VDUP         ---- 1110 1 b:1 q:1 0 .... rt:4 1011 . 0 e:1 1 0000 \
              vn=%vn_dp
 
 VMSR_VMRS    ---- 1110 111 l:1 reg:4 rt:4 1010 0001 0000
-VMOV_single  ---- 1110 000 l:1 .... rt:4 1010 . 001 0000 \
-             vn=%vn_sp
+VMOV_single  ---- 1110 000 l:1 .... rt:4 1010 . 001 0000    vn=%vn_sp
 
-VMOV_64_sp   ---- 1100 010 op:1 rt2:4 rt:4 1010 00.1 .... \
-             vm=%vm_sp
-VMOV_64_dp   ---- 1100 010 op:1 rt2:4 rt:4 1011 00.1 .... \
-             vm=%vm_dp
+VMOV_64_sp   ---- 1100 010 op:1 rt2:4 rt:4 1010 00.1 ....   vm=%vm_sp
+VMOV_64_dp   ---- 1100 010 op:1 rt2:4 rt:4 1011 00.1 ....   vm=%vm_dp
 
 # Note that the half-precision variants of VLDR and VSTR are
 # not part of this decodetree at all because they have bits [9:8] == 0b01
-VLDR_VSTR_sp ---- 1101 u:1 .0 l:1 rn:4 .... 1010 imm:8 \
-             vd=%vd_sp
-VLDR_VSTR_dp ---- 1101 u:1 .0 l:1 rn:4 .... 1011 imm:8 \
-             vd=%vd_dp
+VLDR_VSTR_sp ---- 1101 u:1 .0 l:1 rn:4 .... 1010 imm:8      vd=%vd_sp
+VLDR_VSTR_dp ---- 1101 u:1 .0 l:1 rn:4 .... 1011 imm:8      vd=%vd_dp
 
 # We split the load/store multiple up into two patterns to avoid
 # overlap with other insns in the "Advanced SIMD load/store and 64-bit move"
@@ -100,50 +103,32 @@ VLDM_VSTM_dp ---- 1101 0.1 l:1 rn:4 .... 1011 imm:8 \
              vd=%vd_dp p=1 u=0 w=1
 
 # 3-register VFP data-processing; bits [23,21:20,6] identify the operation.
-VMLA_sp      ---- 1110 0.00 .... .... 1010 .0.0 .... \
-             vm=%vm_sp vn=%vn_sp vd=%vd_sp
-VMLA_dp      ---- 1110 0.00 .... .... 1011 .0.0 .... \
-             vm=%vm_dp vn=%vn_dp vd=%vd_dp
+VMLA_sp      ---- 1110 0.00 .... .... 1010 .0.0 ....        @vfp_dnm_s
+VMLA_dp      ---- 1110 0.00 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
-VMLS_sp      ---- 1110 0.00 .... .... 1010 .1.0 .... \
-             vm=%vm_sp vn=%vn_sp vd=%vd_sp
-VMLS_dp      ---- 1110 0.00 .... .... 1011 .1.0 .... \
-             vm=%vm_dp vn=%vn_dp vd=%vd_dp
+VMLS_sp      ---- 1110 0.00 .... .... 1010 .1.0 ....        @vfp_dnm_s
+VMLS_dp      ---- 1110 0.00 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
-VNMLS_sp     ---- 1110 0.01 .... .... 1010 .0.0 .... \
-             vm=%vm_sp vn=%vn_sp vd=%vd_sp
-VNMLS_dp     ---- 1110 0.01 .... .... 1011 .0.0 .... \
-             vm=%vm_dp vn=%vn_dp vd=%vd_dp
+VNMLS_sp     ---- 1110 0.01 .... .... 1010 .0.0 ....        @vfp_dnm_s
+VNMLS_dp     ---- 1110 0.01 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
-VNMLA_sp     ---- 1110 0.01 .... .... 1010 .1.0 .... \
-             vm=%vm_sp vn=%vn_sp vd=%vd_sp
-VNMLA_dp     ---- 1110 0.01 .... .... 1011 .1.0 .... \
-             vm=%vm_dp vn=%vn_dp vd=%vd_dp
+VNMLA_sp     ---- 1110 0.01 .... .... 1010 .1.0 ....        @vfp_dnm_s
+VNMLA_dp     ---- 1110 0.01 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
-VMUL_sp      ---- 1110 0.10 .... .... 1010 .0.0 .... \
-             vm=%vm_sp vn=%vn_sp vd=%vd_sp
-VMUL_dp      ---- 1110 0.10 .... .... 1011 .0.0 .... \
-             vm=%vm_dp vn=%vn_dp vd=%vd_dp
+VMUL_sp      ---- 1110 0.10 .... .... 1010 .0.0 ....        @vfp_dnm_s
+VMUL_dp      ---- 1110 0.10 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
-VNMUL_sp     ---- 1110 0.10 .... .... 1010 .1.0 .... \
-             vm=%vm_sp vn=%vn_sp vd=%vd_sp
-VNMUL_dp     ---- 1110 0.10 .... .... 1011 .1.0 .... \
-             vm=%vm_dp vn=%vn_dp vd=%vd_dp
+VNMUL_sp     ---- 1110 0.10 .... .... 1010 .1.0 ....        @vfp_dnm_s
+VNMUL_dp     ---- 1110 0.10 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
-VADD_sp      ---- 1110 0.11 .... .... 1010 .0.0 .... \
-             vm=%vm_sp vn=%vn_sp vd=%vd_sp
-VADD_dp      ---- 1110 0.11 .... .... 1011 .0.0 .... \
-             vm=%vm_dp vn=%vn_dp vd=%vd_dp
+VADD_sp      ---- 1110 0.11 .... .... 1010 .0.0 ....        @vfp_dnm_s
+VADD_dp      ---- 1110 0.11 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
-VSUB_sp      ---- 1110 0.11 .... .... 1010 .1.0 .... \
-             vm=%vm_sp vn=%vn_sp vd=%vd_sp
-VSUB_dp      ---- 1110 0.11 .... .... 1011 .1.0 .... \
-             vm=%vm_dp vn=%vn_dp vd=%vd_dp
+VSUB_sp      ---- 1110 0.11 .... .... 1010 .1.0 ....        @vfp_dnm_s
+VSUB_dp      ---- 1110 0.11 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
-VDIV_sp      ---- 1110 1.00 .... .... 1010 .0.0 .... \
-             vm=%vm_sp vn=%vn_sp vd=%vd_sp
-VDIV_dp      ---- 1110 1.00 .... .... 1011 .0.0 .... \
-             vm=%vm_dp vn=%vn_dp vd=%vd_dp
+VDIV_sp      ---- 1110 1.00 .... .... 1010 .0.0 ....        @vfp_dnm_s
+VDIV_dp      ---- 1110 1.00 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
 VFM_sp       ---- 1110 1.01 .... .... 1010 . o2:1 . 0 .... \
              vm=%vm_sp vn=%vn_sp vd=%vd_sp o1=1
@@ -159,25 +144,17 @@ VMOV_imm_sp  ---- 1110 1.11 .... .... 1010 0000 .... \
 VMOV_imm_dp  ---- 1110 1.11 .... .... 1011 0000 .... \
              vd=%vd_dp imm=%vmov_imm
 
-VMOV_reg_sp  ---- 1110 1.11 0000 .... 1010 01.0 .... \
-             vd=%vd_sp vm=%vm_sp
-VMOV_reg_dp  ---- 1110 1.11 0000 .... 1011 01.0 .... \
-             vd=%vd_dp vm=%vm_dp
+VMOV_reg_sp  ---- 1110 1.11 0000 .... 1010 01.0 ....        @vfp_dm_ss
+VMOV_reg_dp  ---- 1110 1.11 0000 .... 1011 01.0 ....        @vfp_dm_dd
 
-VABS_sp      ---- 1110 1.11 0000 .... 1010 11.0 .... \
-             vd=%vd_sp vm=%vm_sp
-VABS_dp      ---- 1110 1.11 0000 .... 1011 11.0 .... \
-             vd=%vd_dp vm=%vm_dp
+VABS_sp      ---- 1110 1.11 0000 .... 1010 11.0 ....        @vfp_dm_ss
+VABS_dp      ---- 1110 1.11 0000 .... 1011 11.0 ....        @vfp_dm_dd
 
-VNEG_sp      ---- 1110 1.11 0001 .... 1010 01.0 .... \
-             vd=%vd_sp vm=%vm_sp
-VNEG_dp      ---- 1110 1.11 0001 .... 1011 01.0 .... \
-             vd=%vd_dp vm=%vm_dp
+VNEG_sp      ---- 1110 1.11 0001 .... 1010 01.0 ....        @vfp_dm_ss
+VNEG_dp      ---- 1110 1.11 0001 .... 1011 01.0 ....        @vfp_dm_dd
 
-VSQRT_sp     ---- 1110 1.11 0001 .... 1010 11.0 .... \
-             vd=%vd_sp vm=%vm_sp
-VSQRT_dp     ---- 1110 1.11 0001 .... 1011 11.0 .... \
-             vd=%vd_dp vm=%vm_dp
+VSQRT_sp     ---- 1110 1.11 0001 .... 1010 11.0 ....        @vfp_dm_ss
+VSQRT_dp     ---- 1110 1.11 0001 .... 1011 11.0 ....        @vfp_dm_dd
 
 VCMP_sp      ---- 1110 1.11 010 z:1 .... 1010 e:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
@@ -190,32 +167,26 @@ VCVT_f32_f16 ---- 1110 1.11 0010 .... 1010 t:1 1.0 .... \
 VCVT_f64_f16 ---- 1110 1.11 0010 .... 1011 t:1 1.0 .... \
              vd=%vd_dp vm=%vm_sp
 
-# VCVTB and VCVTT to f16: Vd format is always vd_sp; Vm format depends on size bit
+# VCVTB and VCVTT to f16: Vd format is always vd_sp;
+# Vm format depends on size bit
 VCVT_f16_f32 ---- 1110 1.11 0011 .... 1010 t:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_f16_f64 ---- 1110 1.11 0011 .... 1011 t:1 1.0 .... \
              vd=%vd_sp vm=%vm_dp
 
-VRINTR_sp    ---- 1110 1.11 0110 .... 1010 01.0 .... \
-             vd=%vd_sp vm=%vm_sp
-VRINTR_dp    ---- 1110 1.11 0110 .... 1011 01.0 .... \
-             vd=%vd_dp vm=%vm_dp
+VRINTR_sp    ---- 1110 1.11 0110 .... 1010 01.0 ....        @vfp_dm_ss
+VRINTR_dp    ---- 1110 1.11 0110 .... 1011 01.0 ....        @vfp_dm_dd
 
-VRINTZ_sp    ---- 1110 1.11 0110 .... 1010 11.0 .... \
-             vd=%vd_sp vm=%vm_sp
-VRINTZ_dp    ---- 1110 1.11 0110 .... 1011 11.0 .... \
-             vd=%vd_dp vm=%vm_dp
+VRINTZ_sp    ---- 1110 1.11 0110 .... 1010 11.0 ....        @vfp_dm_ss
+VRINTZ_dp    ---- 1110 1.11 0110 .... 1011 11.0 ....        @vfp_dm_dd
 
-VRINTX_sp    ---- 1110 1.11 0111 .... 1010 01.0 .... \
-             vd=%vd_sp vm=%vm_sp
-VRINTX_dp    ---- 1110 1.11 0111 .... 1011 01.0 .... \
-             vd=%vd_dp vm=%vm_dp
+VRINTX_sp    ---- 1110 1.11 0111 .... 1010 01.0 ....        @vfp_dm_ss
+VRINTX_dp    ---- 1110 1.11 0111 .... 1011 01.0 ....        @vfp_dm_dd
 
-# VCVT between single and double: Vm precision depends on size; Vd is its reverse
-VCVT_sp      ---- 1110 1.11 0111 .... 1010 11.0 .... \
-             vd=%vd_dp vm=%vm_sp
-VCVT_dp      ---- 1110 1.11 0111 .... 1011 11.0 .... \
-             vd=%vd_sp vm=%vm_dp
+# VCVT between single and double:
+# Vm precision depends on size; Vd is its reverse
+VCVT_sp      ---- 1110 1.11 0111 .... 1010 11.0 ....        @vfp_dm_ds
+VCVT_dp      ---- 1110 1.11 0111 .... 1011 11.0 ....        @vfp_dm_sd
 
 # VCVT from integer to floating point: Vm always single; Vd depends on size
 VCVT_int_sp  ---- 1110 1.11 1000 .... 1010 s:1 1.0 .... \
@@ -224,8 +195,7 @@ VCVT_int_dp  ---- 1110 1.11 1000 .... 1011 s:1 1.0 .... \
              vd=%vd_dp vm=%vm_sp
 
 # VJCVT is always dp to sp
-VJCVT        ---- 1110 1.11 1001 .... 1011 11.0 .... \
-             vd=%vd_sp vm=%vm_dp
+VJCVT        ---- 1110 1.11 1001 .... 1011 11.0 ....        @vfp_dm_sd
 
 # VCVT between floating-point and fixed-point. The immediate value
 # is in the same format as a Vm single-precision register number.
-- 
2.20.1


