Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88275C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55AAE21721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 13:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sn/Etjvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55AAE21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39594 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbPT9-0003nk-Gu
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 09:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59304)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdX-0008CM-6x
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOdU-0004Y7-49
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:22 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45625)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOdT-0004Sg-Nv
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:15:19 -0400
Received: by mail-wr1-x441.google.com with SMTP id f9so20488615wre.12
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sy3O4KyBuYWQ/J2PNF/xf+lfkK6caYhPQsGZjkxlcxg=;
 b=Sn/EtjvwLVlC3e35jkEjy1lqBiAN5BfKGFVUztQUeOtug2IUJQOtWqhcXGpg8MXZI9
 LF0KcxeBexe0uO02uvEW9t5nfvIVDxyJ+LI9qVjwFESjyeOSoM51nbH5yMd0ldTCI+UV
 FFu8ddm1awzPlxpWYFttA5cEHydkiwkxa8JCWbRaWqMIR75wuCjslk5Me4Q3u9yCVk2f
 8CxpnpMLjQvYdRSuUCf4alcfqlB+hfpBZsWpexIilt3SSmcHXqk65w6jvCS4DOSji5jS
 b4OkcqXks2bMwpN4zYPKfXXT0pp4UQ/x6lzEA+opSkpRe584KIi4dk1XUPtXZMezyJTb
 GMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sy3O4KyBuYWQ/J2PNF/xf+lfkK6caYhPQsGZjkxlcxg=;
 b=VwuWqf4UJDRSuaUkdaMfr7svz6F4KX4sjOjCBcWSnvGXan4BJXsZtaUlXss88tV/VX
 scvA3V5chv06J39Yao8kztkc/9oR4f1jxBazuFF+XFULkAN8cSQsv8EGHwDoRxFly/B0
 NzN6gyjc/rlW1sd5eb66fGue9UxN1C7zkVFE6rc2XfHHpd0oAjE01sNkI14+kRqO8V/l
 c+aXrOR2uSPmIdvdwuFrIjXlzYcfaVoDKCBqiPyF2qYcSjWniC6XmWsmcI3w7HU6nGuG
 5JqiGsvy1D3lUKxbNbhJ/NYBKVZDFtVE0Npyl2+uj73p3A+mLXeadbjhEjkYJT1yhgkO
 R16Q==
X-Gm-Message-State: APjAAAVWGU2ZsLgZwCfqnSK8lAwyw6+C4ya2eVSDKkTupUf6u76zAPDr
 DaIImyxKsjqt8w0Aq/bNUgKREJIuy/xDKw==
X-Google-Smtp-Source: APXvYqzbXRRWY23ra3spozHj8qMrHZjUb0Jb1//b9jxZj4OLH1bvQLkKheU8r17ehlI1KyUEoR8TvA==
X-Received: by 2002:adf:b64e:: with SMTP id i14mr6406348wre.248.1560428115061; 
 Thu, 13 Jun 2019 05:15:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.15.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:15:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:14:22 +0100
Message-Id: <20190613121433.5246-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613121433.5246-1-peter.maydell@linaro.org>
References: <20190613121433.5246-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 37/48] target/arm: Convert VSQRT to decodetree
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

Convert the VSQRT instruction to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-vfp.inc.c | 20 ++++++++++++++++++++
 target/arm/translate.c         | 14 +-------------
 target/arm/vfp.decode          |  5 +++++
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate-vfp.inc.c b/target/arm/translate-vfp.inc.c
index 6e06b2a130a..ae2f77a873b 100644
--- a/target/arm/translate-vfp.inc.c
+++ b/target/arm/translate-vfp.inc.c
@@ -1908,3 +1908,23 @@ static bool trans_VNEG_dp(DisasContext *s, arg_VNEG_dp *a)
 {
     return do_vfp_2op_dp(s, gen_helper_vfp_negd, a->vd, a->vm);
 }
+
+static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
+{
+    gen_helper_vfp_sqrts(vd, vm, cpu_env);
+}
+
+static bool trans_VSQRT_sp(DisasContext *s, arg_VSQRT_sp *a)
+{
+    return do_vfp_2op_sp(s, gen_VSQRT_sp, a->vd, a->vm);
+}
+
+static void gen_VSQRT_dp(TCGv_i64 vd, TCGv_i64 vm)
+{
+    gen_helper_vfp_sqrtd(vd, vm, cpu_env);
+}
+
+static bool trans_VSQRT_dp(DisasContext *s, arg_VSQRT_dp *a)
+{
+    return do_vfp_2op_dp(s, gen_VSQRT_dp, a->vd, a->vm);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3baf2baec3f..b0fd4051f1f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1390,14 +1390,6 @@ static inline void gen_vfp_neg(int dp)
         gen_helper_vfp_negs(cpu_F0s, cpu_F0s);
 }
 
-static inline void gen_vfp_sqrt(int dp)
-{
-    if (dp)
-        gen_helper_vfp_sqrtd(cpu_F0d, cpu_F0d, cpu_env);
-    else
-        gen_helper_vfp_sqrts(cpu_F0s, cpu_F0s, cpu_env);
-}
-
 static inline void gen_vfp_cmp(int dp)
 {
     if (dp)
@@ -3098,7 +3090,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 return 1;
             case 15:
                 switch (rn) {
-                case 1 ... 2:
+                case 1 ... 3:
                     /* Already handled by decodetree */
                     return 1;
                 default:
@@ -3112,7 +3104,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                 /* rn is opcode, encoded as per VFP_SREG_N. */
                 switch (rn) {
                 case 0x00: /* vmov */
-                case 0x03: /* vsqrt */
                     break;
 
                 case 0x04: /* vcvtb.f64.f16, vcvtb.f32.f16 */
@@ -3290,9 +3281,6 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     case 0: /* cpy */
                         /* no-op */
                         break;
-                    case 3: /* sqrt */
-                        gen_vfp_sqrt(dp);
-                        break;
                     case 4: /* vcvtb.f32.f16, vcvtb.f64.f16 */
                     {
                         TCGv_ptr fpst = get_fpstatus_ptr(false);
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 79e41963be4..2780e1ed9ea 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -166,3 +166,8 @@ VNEG_sp      ---- 1110 1.11 0001 .... 1010 01.0 .... \
              vd=%vd_sp vm=%vm_sp
 VNEG_dp      ---- 1110 1.11 0001 .... 1011 01.0 .... \
              vd=%vd_dp vm=%vm_dp
+
+VSQRT_sp     ---- 1110 1.11 0001 .... 1010 11.0 .... \
+             vd=%vd_sp vm=%vm_sp
+VSQRT_dp     ---- 1110 1.11 0001 .... 1011 11.0 .... \
+             vd=%vd_dp vm=%vm_dp
-- 
2.20.1


