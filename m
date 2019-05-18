Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0469EC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84B4204EC
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCLlpwfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84B4204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37874 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4uX-0000i4-2I
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:22:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4n3-0003Ge-NR
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4n2-0002l9-G0
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:14:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4n2-0002kR-9u
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:14:40 -0400
Received: by mail-pg1-x544.google.com with SMTP id c13so4850640pgt.1
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/XvYsO2SMXHmlimUy7MwwAYOFOLdPZ1B4fSPHYjvaz0=;
	b=qCLlpwfKHSJpgpjBA2qtiiK9mqNyw6GYWneW+yg5spKIxvhl7VtBWeWh1Ctx7ipXkI
	LhbnoFraiqyOO/bH/2KXbkBPsb46O+4w/u85ioTDF52yGqqg5vop9uBuaMdbYfHLV0Kj
	5pq0w77H6FrzC/TeqaWQQvCwbkpGNTRlrP0JODWN03LH9uifd6zD9B3k5ma7xf0ZxoS4
	Ke1wYfLPaXGcPOcCnst/F54pAFxGYyWxrAIBnpZdo0SE+wMh1o45EMV90cdPBTq+qYlG
	htQDqHO+bgShN4GWIYQ9/ck6wNKc7Z55QTZ3JDfPrkR3r5fB7jOGALkqo4nWCPM8+KRK
	Grmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=/XvYsO2SMXHmlimUy7MwwAYOFOLdPZ1B4fSPHYjvaz0=;
	b=E0wyB4g6L+6rv6DAcCEofYOH8D8R7P9XN81XlYYPzWbVmnbSxxbyVComicUQzvNI1F
	sGhakIbMG6ft4Ehn4NcLMeL3KaIny6Ay11IDNkpdsOEV0j5wy0d6ECiT1Kz9kMthNMhq
	PU0X2JezLWdmtTl4VwBslThbA3InYQVyu9MocibdSm1xT1WuPkwu2VaQLoIiVtuCOc3j
	e+RK4LitJ+GNQ91G4+O/nkFIUI6UWCVE4eIRPCfxApoyC5aOxOmtrOZR8Ve4wY6TagTd
	W++pqaEF/UiVTKBZJmOVso8NU3lyomas6bkncWxe9hvnUuTdgqHwa7HIDY/ZUesz/u+k
	Mv+g==
X-Gm-Message-State: APjAAAXMBtbOpEyhWsQQrWoGmPG25uigtYF+1u51LWd2taYsVLjwyncX
	jp/GXVg2ZzgsBXrIbZCVC0Bd9GCW5oE=
X-Google-Smtp-Source: APXvYqyZeP6HkzQwq82OraQSh1a2uW8Vj8/99lwf+90FDnFczw8xIV+NRgEM2zCQYbHjglqspW29iA==
X-Received: by 2002:a65:640b:: with SMTP id a11mr50182725pgv.219.1558206879108;
	Sat, 18 May 2019 12:14:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	d186sm19206675pfd.183.2019.05.18.12.14.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:14:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:14:29 -0700
Message-Id: <20190518191430.21686-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518191430.21686-1-richard.henderson@linaro.org>
References: <20190518191430.21686-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 1/2] target/ppc: Use vector variable shifts for
 VSL, VSR, VSRA
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The gvec expanders take care of masking the shift amount
against the element width.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 | 12 ----------
 target/ppc/int_helper.c             | 37 -----------------------------
 target/ppc/translate/vmx-impl.inc.c | 24 +++++++++----------
 3 files changed, 12 insertions(+), 61 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 638a6e99c4..02b67a333e 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -180,18 +180,6 @@ DEF_HELPER_3(vmuloub, void, avr, avr, avr)
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
 DEF_HELPER_3(vslo, void, avr, avr, avr)
 DEF_HELPER_3(vsro, void, avr, avr, avr)
 DEF_HELPER_3(vsrv, void, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index f6a088ac08..40a7035df0 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1776,23 +1776,6 @@ VSHIFT(l, 1)
 VSHIFT(r, 0)
 #undef VSHIFT
 
-#define VSL(suffix, element, mask)                                      \
-    void helper_vsl##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   \
-    {                                                                   \
-        int i;                                                          \
-                                                                        \
-        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
-            unsigned int shift = b->element[i] & mask;                  \
-                                                                        \
-            r->element[i] = a->element[i] << shift;                     \
-        }                                                               \
-    }
-VSL(b, u8, 0x7)
-VSL(h, u16, 0x0F)
-VSL(w, u32, 0x1F)
-VSL(d, u64, 0x3F)
-#undef VSL
-
 void helper_vslv(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i;
@@ -1965,26 +1948,6 @@ VNEG(vnegw, s32)
 VNEG(vnegd, s64)
 #undef VNEG
 
-#define VSR(suffix, element, mask)                                      \
-    void helper_vsr##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   \
-    {                                                                   \
-        int i;                                                          \
-                                                                        \
-        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
-            unsigned int shift = b->element[i] & mask;                  \
-            r->element[i] = a->element[i] >> shift;                     \
-        }                                                               \
-    }
-VSR(ab, s8, 0x7)
-VSR(ah, s16, 0xF)
-VSR(aw, s32, 0x1F)
-VSR(ad, s64, 0x3F)
-VSR(b, u8, 0x7)
-VSR(h, u16, 0xF)
-VSR(w, u32, 0x1F)
-VSR(d, u64, 0x3F)
-#undef VSR
-
 void helper_vsro(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int sh = (b->VsrB(0xf) >> 3) & 0xf;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 6861f4c5b9..663275b729 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -530,21 +530,21 @@ GEN_VXFORM(vmuleuw, 4, 10);
 GEN_VXFORM(vmulesb, 4, 12);
 GEN_VXFORM(vmulesh, 4, 13);
 GEN_VXFORM(vmulesw, 4, 14);
-GEN_VXFORM(vslb, 2, 4);
-GEN_VXFORM(vslh, 2, 5);
-GEN_VXFORM(vslw, 2, 6);
+GEN_VXFORM_V(vslb, MO_8, tcg_gen_gvec_shlv, 2, 4);
+GEN_VXFORM_V(vslh, MO_16, tcg_gen_gvec_shlv, 2, 5);
+GEN_VXFORM_V(vslw, MO_32, tcg_gen_gvec_shlv, 2, 6);
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
+GEN_VXFORM_V(vsld, MO_64, tcg_gen_gvec_shlv, 2, 23);
+GEN_VXFORM_V(vsrb, MO_8, tcg_gen_gvec_shrv, 2, 8);
+GEN_VXFORM_V(vsrh, MO_16, tcg_gen_gvec_shrv, 2, 9);
+GEN_VXFORM_V(vsrw, MO_32, tcg_gen_gvec_shrv, 2, 10);
+GEN_VXFORM_V(vsrd, MO_64, tcg_gen_gvec_shrv, 2, 27);
+GEN_VXFORM_V(vsrab, MO_8, tcg_gen_gvec_sarv, 2, 12);
+GEN_VXFORM_V(vsrah, MO_16, tcg_gen_gvec_sarv, 2, 13);
+GEN_VXFORM_V(vsraw, MO_32, tcg_gen_gvec_sarv, 2, 14);
+GEN_VXFORM_V(vsrad, MO_64, tcg_gen_gvec_sarv, 2, 15);
 GEN_VXFORM(vsrv, 2, 28);
 GEN_VXFORM(vslv, 2, 29);
 GEN_VXFORM(vslo, 6, 16);
-- 
2.17.1


