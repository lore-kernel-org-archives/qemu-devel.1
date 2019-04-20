Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFD4C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B998921479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rp8jtGDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B998921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38237 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkiv-0002dB-01
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:47:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXV-000108-Vw
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXT-0000k8-Gb
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:56 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXP-0000Eo-ME
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:53 -0400
Received: by mail-pg1-x544.google.com with SMTP id e6so3598764pgc.4
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=aLpUjQsuKJz6T6SbjeElUaQ0sY108vEanXCZ8S+u8lw=;
	b=Rp8jtGDjhHNIwYXfe5djKCIi44U5/YOw29tGwP1Tu709gLbgvYfBZHx/uf1DSg4gdR
	71WnmzCUR4HBAdk5l3vGzqrR6dQs42BulIhwFaIwlRTrHKlfqY9WzQkTd5+MHbhTCSj/
	P8e2JVi3LodRoVH2+tO2W9eVtFUUolWO1GPD/6Y0YXxToz7fSxoJ/L1OpxDaK4wuZncF
	6ROMdi9JVuYWK1CYNhLLaPmhmobUX4qg4qrpWXvk6+AOfs3bi/N5MgmWmCjH111X8sCn
	lizjNYxWswtb7i2qDFLIFkiJjwQYs2I84tDKEjZCvyeKrCQlX7wEMbGJC/JyBq4Cj0b6
	OCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=aLpUjQsuKJz6T6SbjeElUaQ0sY108vEanXCZ8S+u8lw=;
	b=LOYlcO/FNrVDOH1O31i6L2RbevGCGIWjd7td3p0is7DvBobOd1lhctJlueeXugr7aG
	dvNMSWT6cuUUnssr9n8oMjvrm7ma3+g4cdiM5foy0xuUUA9tyGcWT1hSptXbNxItDo+w
	/xN6JtKylYr3BQA2HZMnvQpYMTT1+U+ZkP5H294bwbYzFIIM7T4mceM1IPVewN5P0Xa8
	ULppk8/+pfprmgqW5ENw+JFZFUslRc9SGkOcLL4esvUq+b8zfznNaUYkf8mouqvPJ33f
	Adf71FYN81z/pf/+ibILbwT4VH6xwLf2bnnnWGCM3urIyFLiKkZLcWXwW6LhxUxXv4yc
	1K5g==
X-Gm-Message-State: APjAAAUn9UjN8i29RfszZyjKsgsjUaShILW6pr6kCP3F+5wRllaNy056
	z1OBZ1zbSY8rXkzCNwQQ+uuSpRY2kmo=
X-Google-Smtp-Source: APXvYqzq+S+TX3DvtpDHmIi8fUyA3C3y1NfSo9fuJAn29Pdiyqm1I43Zuv1pFTMmu5zEZDpL6D+JXQ==
X-Received: by 2002:a63:1247:: with SMTP id 7mr7965982pgs.352.1555745734929;
	Sat, 20 Apr 2019 00:35:34 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:35 -1000
Message-Id: <20190420073442.7488-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 31/38] target/ppc: Use vector variable shifts
 for VS{L, R, RA}{B, H, W, D}
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073435._IbfW4Po4N7qyl1U5aPuOCBJweIh8CYf5Y0UEWbS-SM@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 |  24 ++--
 target/ppc/int_helper.c             |   6 +-
 target/ppc/translate/vmx-impl.inc.c | 168 ++++++++++++++++++++++++++--
 3 files changed, 172 insertions(+), 26 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 638a6e99c4..5416dc55ce 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -180,18 +180,18 @@ DEF_HELPER_3(vmuloub, void, avr, avr, avr)
 DEF_HELPER_3(vmulouh, void, avr, avr, avr)
 DEF_HELPER_3(vmulouw, void, avr, avr, avr)
 DEF_HELPER_3(vmuluwm, void, avr, avr, avr)
-DEF_HELPER_3(vsrab, void, avr, avr, avr)
-DEF_HELPER_3(vsrah, void, avr, avr, avr)
-DEF_HELPER_3(vsraw, void, avr, avr, avr)
-DEF_HELPER_3(vsrad, void, avr, avr, avr)
-DEF_HELPER_3(vsrb, void, avr, avr, avr)
-DEF_HELPER_3(vsrh, void, avr, avr, avr)
-DEF_HELPER_3(vsrw, void, avr, avr, avr)
-DEF_HELPER_3(vsrd, void, avr, avr, avr)
-DEF_HELPER_3(vslb, void, avr, avr, avr)
-DEF_HELPER_3(vslh, void, avr, avr, avr)
-DEF_HELPER_3(vslw, void, avr, avr, avr)
-DEF_HELPER_3(vsld, void, avr, avr, avr)
+DEF_HELPER_4(vsrab, void, avr, avr, avr, i32)
+DEF_HELPER_4(vsrah, void, avr, avr, avr, i32)
+DEF_HELPER_4(vsraw, void, avr, avr, avr, i32)
+DEF_HELPER_4(vsrad, void, avr, avr, avr, i32)
+DEF_HELPER_4(vsrb, void, avr, avr, avr, i32)
+DEF_HELPER_4(vsrh, void, avr, avr, avr, i32)
+DEF_HELPER_4(vsrw, void, avr, avr, avr, i32)
+DEF_HELPER_4(vsrd, void, avr, avr, avr, i32)
+DEF_HELPER_4(vslb, void, avr, avr, avr, i32)
+DEF_HELPER_4(vslh, void, avr, avr, avr, i32)
+DEF_HELPER_4(vslw, void, avr, avr, avr, i32)
+DEF_HELPER_4(vsld, void, avr, avr, avr, i32)
 DEF_HELPER_3(vslo, void, avr, avr, avr)
 DEF_HELPER_3(vsro, void, avr, avr, avr)
 DEF_HELPER_3(vsrv, void, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 162add561e..35ec1ccdfb 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1770,7 +1770,8 @@ VSHIFT(r, 0)
 #undef VSHIFT
 
 #define VSL(suffix, element, mask)                                      \
-    void helper_vsl##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   \
+    void helper_vsl##suffix(ppc_avr_t *r, ppc_avr_t *a,                 \
+                            ppc_avr_t *b, uint32_t desc)                \
     {                                                                   \
         int i;                                                          \
                                                                         \
@@ -1958,7 +1959,8 @@ VNEG(vnegd, s64)
 #undef VNEG
 
 #define VSR(suffix, element, mask)                                      \
-    void helper_vsr##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   \
+    void helper_vsr##suffix(ppc_avr_t *r, ppc_avr_t *a,                 \
+                            ppc_avr_t *b, uint32_t desc)                \
     {                                                                   \
         int i;                                                          \
                                                                         \
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index c83e605a00..8cc2e99963 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -511,6 +511,150 @@ static void gen_vmrgow(DisasContext *ctx)
     tcg_temp_free_i64(avr);
 }
 
+static void gen_vsl_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(b);
+    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
+    tcg_gen_and_vec(vece, b, b, t);
+    tcg_temp_free_vec(t);
+    tcg_gen_shlv_vec(vece, d, a, b);
+}
+
+static void gen_vslw_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_andi_i32(b, b, 31);
+    tcg_gen_shl_i32(d, a, b);
+}
+
+static void gen_vsld_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_andi_i64(b, b, 63);
+    tcg_gen_shl_i64(d, a, b);
+}
+
+static void gen__vsl(unsigned vece, uint32_t dofs, uint32_t aofs,
+                     uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode shlv_list[] = { INDEX_op_shlv_vec, 0 };
+    static const GVecGen3 g[4] = {
+        { .fniv = gen_vsl_vec,
+          .fno = gen_helper_vslb,
+          .opt_opc = shlv_list,
+          .vece = MO_8 },
+        { .fniv = gen_vsl_vec,
+          .fno = gen_helper_vslh,
+          .opt_opc = shlv_list,
+          .vece = MO_16 },
+        { .fni4 = gen_vslw_i32,
+          .fniv = gen_vsl_vec,
+          .fno = gen_helper_vslw,
+          .opt_opc = shlv_list,
+          .vece = MO_32 },
+        { .fni8 = gen_vsld_i64,
+          .fniv = gen_vsl_vec,
+          .fno = gen_helper_vsld,
+          .opt_opc = shlv_list,
+          .vece = MO_64 }
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
+static void gen_vsr_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(b);
+    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
+    tcg_gen_and_vec(vece, b, b, t);
+    tcg_temp_free_vec(t);
+    tcg_gen_shrv_vec(vece, d, a, b);
+}
+
+static void gen_vsrw_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_andi_i32(b, b, 31);
+    tcg_gen_shr_i32(d, a, b);
+}
+
+static void gen_vsrd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_andi_i64(b, b, 63);
+    tcg_gen_shr_i64(d, a, b);
+}
+
+static void gen__vsr(unsigned vece, uint32_t dofs, uint32_t aofs,
+                     uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode shrv_list[] = { INDEX_op_shrv_vec, 0 };
+    static const GVecGen3 g[4] = {
+        { .fniv = gen_vsr_vec,
+          .fno = gen_helper_vsrb,
+          .opt_opc = shrv_list,
+          .vece = MO_8 },
+        { .fniv = gen_vsr_vec,
+          .fno = gen_helper_vsrh,
+          .opt_opc = shrv_list,
+          .vece = MO_16 },
+        { .fni4 = gen_vsrw_i32,
+          .fniv = gen_vsr_vec,
+          .fno = gen_helper_vsrw,
+          .opt_opc = shrv_list,
+          .vece = MO_32 },
+        { .fni8 = gen_vsrd_i64,
+          .fniv = gen_vsr_vec,
+          .fno = gen_helper_vsrd,
+          .opt_opc = shrv_list,
+          .vece = MO_64 }
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
+static void gen_vsra_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
+{
+    TCGv_vec t = tcg_temp_new_vec_matching(b);
+    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
+    tcg_gen_and_vec(vece, b, b, t);
+    tcg_temp_free_vec(t);
+    tcg_gen_sarv_vec(vece, d, a, b);
+}
+
+static void gen_vsraw_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
+{
+    tcg_gen_andi_i32(b, b, 31);
+    tcg_gen_sar_i32(d, a, b);
+}
+
+static void gen_vsrad_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
+{
+    tcg_gen_andi_i64(b, b, 63);
+    tcg_gen_sar_i64(d, a, b);
+}
+
+static void gen__vsra(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode sarv_list[] = { INDEX_op_sarv_vec, 0 };
+    static const GVecGen3 g[4] = {
+        { .fniv = gen_vsra_vec,
+          .fno = gen_helper_vsrab,
+          .opt_opc = sarv_list,
+          .vece = MO_8 },
+        { .fniv = gen_vsra_vec,
+          .fno = gen_helper_vsrah,
+          .opt_opc = sarv_list,
+          .vece = MO_16 },
+        { .fni4 = gen_vsraw_i32,
+          .fniv = gen_vsra_vec,
+          .fno = gen_helper_vsraw,
+          .opt_opc = sarv_list,
+          .vece = MO_32 },
+        { .fni8 = gen_vsrad_i64,
+          .fniv = gen_vsra_vec,
+          .fno = gen_helper_vsrad,
+          .opt_opc = sarv_list,
+          .vece = MO_64 }
+    };
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
+}
+
 GEN_VXFORM(vmuloub, 4, 0);
 GEN_VXFORM(vmulouh, 4, 1);
 GEN_VXFORM(vmulouw, 4, 2);
@@ -526,21 +670,21 @@ GEN_VXFORM(vmuleuw, 4, 10);
 GEN_VXFORM(vmulesb, 4, 12);
 GEN_VXFORM(vmulesh, 4, 13);
 GEN_VXFORM(vmulesw, 4, 14);
-GEN_VXFORM(vslb, 2, 4);
-GEN_VXFORM(vslh, 2, 5);
-GEN_VXFORM(vslw, 2, 6);
+GEN_VXFORM_V(vslb, MO_8, gen__vsl, 2, 4);
+GEN_VXFORM_V(vslh, MO_16, gen__vsl, 2, 5);
+GEN_VXFORM_V(vslw, MO_32, gen__vsl, 2, 6);
+GEN_VXFORM_V(vsld, MO_64, gen__vsl, 2, 23);
 GEN_VXFORM(vrlwnm, 2, 6);
 GEN_VXFORM_DUAL(vslw, PPC_ALTIVEC, PPC_NONE, \
                 vrlwnm, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM(vsld, 2, 23);
-GEN_VXFORM(vsrb, 2, 8);
-GEN_VXFORM(vsrh, 2, 9);
-GEN_VXFORM(vsrw, 2, 10);
-GEN_VXFORM(vsrd, 2, 27);
-GEN_VXFORM(vsrab, 2, 12);
-GEN_VXFORM(vsrah, 2, 13);
-GEN_VXFORM(vsraw, 2, 14);
-GEN_VXFORM(vsrad, 2, 15);
+GEN_VXFORM_V(vsrb, MO_8, gen__vsr, 2, 8);
+GEN_VXFORM_V(vsrh, MO_16, gen__vsr, 2, 9);
+GEN_VXFORM_V(vsrw, MO_32, gen__vsr, 2, 10);
+GEN_VXFORM_V(vsrd, MO_64, gen__vsr, 2, 27);
+GEN_VXFORM_V(vsrab, MO_8, gen__vsra, 2, 12);
+GEN_VXFORM_V(vsrah, MO_16, gen__vsra, 2, 13);
+GEN_VXFORM_V(vsraw, MO_32, gen__vsra, 2, 14);
+GEN_VXFORM_V(vsrad, MO_64, gen__vsra, 2, 15);
 GEN_VXFORM(vsrv, 2, 28);
 GEN_VXFORM(vslv, 2, 29);
 GEN_VXFORM(vslo, 6, 16);
-- 
2.17.1


