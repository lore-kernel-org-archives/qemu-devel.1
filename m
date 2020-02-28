Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F20C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C527224672
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d8Hb5eA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C527224672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7izW-0002ru-U4
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifO-0007wH-7s
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifM-0001zk-SA
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:10 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifM-0001zI-Le
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:08 -0500
Received: by mail-wr1-x441.google.com with SMTP id v4so3642525wrs.8
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=H9vgJ1xHyPTbz5vgbyrb9N1PuwfNuQ0QSjFXbJuKM48=;
 b=d8Hb5eA9ftrUsULuODN5juju2IgEVy3sSpUaHbbx40qsXUSO0tstmosyZGiCCxCgSn
 BwaFsgunCSR/zn8S7qeheUXcXy/3WoCYzvW1whaS/PAF56jkXw7bpIYM1a9O4FjoWOUw
 3ZVazTWpVuO4e3U/6DotxWHHIF13uI4UQ4LNCFgVYRCNYgiZ2N08ns7re5l6k1UBnGqp
 /FHLI7ybJJC2DyA5xro6z5EI7ctJ0CrANiY7+3eaob9I6wN9vOsaae3XdFcvNASKTnXc
 ur6WopbvutIUp352T1q2SklM/qlBfa7Bab93PPVWGpcuUu4TBpQYyUFK+iRnHQ41F3u4
 i4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H9vgJ1xHyPTbz5vgbyrb9N1PuwfNuQ0QSjFXbJuKM48=;
 b=HfBnz32/SYn+BfgwoljVCw5Ls7QxQM89tKUImh6ozmYnjupQ3P361aTc8rRsrxNzly
 ++dl2OuSOy3ekpGOODo1Z5W7irLpsLvdrDFZq3+OK1Dp7XYJMz2954A56UAK2OSS8XEH
 PFe+w50ctJ1LB7eSG2pdADUfCswsFnTGyE3KoNF+gPj4UiqsXgfYc9atn/O47lyo1iV2
 7zR4dKI1J0t8IxXqbMQUK7KyvSHupMJH/W8EkLv9VR6n2ILzxQdfAB0laOv5WXjXfa1/
 m1ZNFeJSPcGDetrdJlnz1tUVWuqsfFpwrDGwtwZ43QbPFecoSRTH0+22FkmDr5MPIz24
 dasA==
X-Gm-Message-State: APjAAAVgH2D1iEast/tFW0NMPSqrs54RS4WIGiNrkblbG4qkwlEtbhPB
 r0yqZ+8vcFKVPI5AwEyMdyMj8iQ9x+dOiw==
X-Google-Smtp-Source: APXvYqxxwZQ7PBWv2Y8MJOjF7eRG/uFopVTTz+P1pdFAQlaoz3nM0HpVUnWZNUtodiJgmUxQIGgWIA==
X-Received: by 2002:a5d:5007:: with SMTP id e7mr5661156wrt.228.1582907947340; 
 Fri, 28 Feb 2020 08:39:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/33] target/arm: Split VFM decode
Date: Fri, 28 Feb 2020 16:38:28 +0000
Message-Id: <20200228163840.23585-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

From: Richard Henderson <richard.henderson@linaro.org>

Passing the raw o1 and o2 fields from the manual is less
instructive than it might be.  Do the full decode and let
the trans_* functions pass in booleans to a helper.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200224222232.13807-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-vfp.inc.c | 52 ++++++++++++++++++++++++++++++----
 target/arm/vfp.decode          | 17 +++++------
 2 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 1964af3ea5e..41aa67c133a 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1784,7 +1784,7 @@ static bool trans_VDIV_dp(DisasContext *s, arg_VDIV_dp *a)
     return do_vfp_3op_dp(s, gen_helper_vfp_divd, a->vd, a->vn, a->vm, false);
 }
 
-static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
+static bool do_vfm_sp(DisasContext *s, arg_VFMA_sp *a, bool neg_n, bool neg_d)
 {
     /*
      * VFNMA : fd = muladd(-fd,  fn, fm)
@@ -1828,12 +1828,12 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
 
     neon_load_reg32(vn, a->vn);
     neon_load_reg32(vm, a->vm);
-    if (a->o2) {
+    if (neg_n) {
         /* VFNMS, VFMS */
         gen_helper_vfp_negs(vn, vn);
     }
     neon_load_reg32(vd, a->vd);
-    if (a->o1 & 1) {
+    if (neg_d) {
         /* VFNMA, VFNMS */
         gen_helper_vfp_negs(vd, vd);
     }
@@ -1849,7 +1849,27 @@ static bool trans_VFM_sp(DisasContext *s, arg_VFM_sp *a)
     return true;
 }
 
-static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
+static bool trans_VFMA_sp(DisasContext *s, arg_VFMA_sp *a)
+{
+    return do_vfm_sp(s, a, false, false);
+}
+
+static bool trans_VFMS_sp(DisasContext *s, arg_VFMS_sp *a)
+{
+    return do_vfm_sp(s, a, true, false);
+}
+
+static bool trans_VFNMA_sp(DisasContext *s, arg_VFNMA_sp *a)
+{
+    return do_vfm_sp(s, a, false, true);
+}
+
+static bool trans_VFNMS_sp(DisasContext *s, arg_VFNMS_sp *a)
+{
+    return do_vfm_sp(s, a, true, true);
+}
+
+static bool do_vfm_dp(DisasContext *s, arg_VFMA_dp *a, bool neg_n, bool neg_d)
 {
     /*
      * VFNMA : fd = muladd(-fd,  fn, fm)
@@ -1905,12 +1925,12 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
 
     neon_load_reg64(vn, a->vn);
     neon_load_reg64(vm, a->vm);
-    if (a->o2) {
+    if (neg_n) {
         /* VFNMS, VFMS */
         gen_helper_vfp_negd(vn, vn);
     }
     neon_load_reg64(vd, a->vd);
-    if (a->o1 & 1) {
+    if (neg_d) {
         /* VFNMA, VFNMS */
         gen_helper_vfp_negd(vd, vd);
     }
@@ -1926,6 +1946,26 @@ static bool trans_VFM_dp(DisasContext *s, arg_VFM_dp *a)
     return true;
 }
 
+static bool trans_VFMA_dp(DisasContext *s, arg_VFMA_dp *a)
+{
+    return do_vfm_dp(s, a, false, false);
+}
+
+static bool trans_VFMS_dp(DisasContext *s, arg_VFMS_dp *a)
+{
+    return do_vfm_dp(s, a, true, false);
+}
+
+static bool trans_VFNMA_dp(DisasContext *s, arg_VFNMA_dp *a)
+{
+    return do_vfm_dp(s, a, false, true);
+}
+
+static bool trans_VFNMS_dp(DisasContext *s, arg_VFNMS_dp *a)
+{
+    return do_vfm_dp(s, a, true, true);
+}
+
 static bool trans_VMOV_imm_sp(DisasContext *s, arg_VMOV_imm_sp *a)
 {
     uint32_t delta_d = 0;
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 4f294f88be5..5fd70f975ae 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -130,14 +130,15 @@ VSUB_dp      ---- 1110 0.11 .... .... 1011 .1.0 ....        @vfp_dnm_d
 VDIV_sp      ---- 1110 1.00 .... .... 1010 .0.0 ....        @vfp_dnm_s
 VDIV_dp      ---- 1110 1.00 .... .... 1011 .0.0 ....        @vfp_dnm_d
 
-VFM_sp       ---- 1110 1.01 .... .... 1010 . o2:1 . 0 .... \
-             vm=%vm_sp vn=%vn_sp vd=%vd_sp o1=1
-VFM_dp       ---- 1110 1.01 .... .... 1011 . o2:1 . 0 .... \
-             vm=%vm_dp vn=%vn_dp vd=%vd_dp o1=1
-VFM_sp       ---- 1110 1.10 .... .... 1010 . o2:1 . 0 .... \
-             vm=%vm_sp vn=%vn_sp vd=%vd_sp o1=2
-VFM_dp       ---- 1110 1.10 .... .... 1011 . o2:1 . 0 .... \
-             vm=%vm_dp vn=%vn_dp vd=%vd_dp o1=2
+VFMA_sp      ---- 1110 1.10 .... .... 1010 .0. 0 ....       @vfp_dnm_s
+VFMS_sp      ---- 1110 1.10 .... .... 1010 .1. 0 ....       @vfp_dnm_s
+VFNMA_sp     ---- 1110 1.01 .... .... 1010 .0. 0 ....       @vfp_dnm_s
+VFNMS_sp     ---- 1110 1.01 .... .... 1010 .1. 0 ....       @vfp_dnm_s
+
+VFMA_dp      ---- 1110 1.10 .... .... 1011 .0.0 ....        @vfp_dnm_d
+VFMS_dp      ---- 1110 1.10 .... .... 1011 .1.0 ....        @vfp_dnm_d
+VFNMA_dp     ---- 1110 1.01 .... .... 1011 .0.0 ....        @vfp_dnm_d
+VFNMS_dp     ---- 1110 1.01 .... .... 1011 .1.0 ....        @vfp_dnm_d
 
 VMOV_imm_sp  ---- 1110 1.11 .... .... 1010 0000 .... \
              vd=%vd_sp imm=%vmov_imm
-- 
2.20.1


