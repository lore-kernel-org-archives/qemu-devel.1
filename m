Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EA0C46477
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C87A208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udyEAChx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C87A208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdSso-00033D-Sf
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 01:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34474)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmZ-0003zc-Co
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmV-0001hT-LX
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:15 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:40974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hdSmV-0001gC-Ft
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:11 -0400
Received: by mail-yw1-xc41.google.com with SMTP id y185so7761480ywy.8
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 22:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ooU8FJeSDRA23SxTjs7rxoY/oQzHow1ePTidkogrqFk=;
 b=udyEAChx6lEZx6vivOQts92yG0jU4AtdZkqdxK6z4wE8Ph4zMno6wENpTWos4FOKJ5
 w4O2NkZ7CWAa375Uhuau/NhBVKTer1cEsjU+MihPiBNLdMoQmTIjj1z9Z9cUnhht0O79
 Zm8ntNC1i0yN/tNt66sSlLhhn/ZCK5J/Gxqp8LF5ZA/4mVZuuqNSvuk+jqp9Y+B2BQBO
 QRwhzF/IjHhMANHXiw4B+tbG2Pb3OEhzR431E8xI6Dno68GptN0bl62c8PdF0HEgc7EN
 w8iZuJlm2oeVfYfB0uWoeayJcrRXRzwkn6FYDJgzfpWPTZD2xek+PILgobbMjFq8g8V3
 d1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ooU8FJeSDRA23SxTjs7rxoY/oQzHow1ePTidkogrqFk=;
 b=nncfJJswmmDsxatfm0u6phwPm2Cc0o5+s3MikJpI+rEKLldmjveMGS2tf834DCFE19
 vhtgFXOzEHTAUfD+BnBpr6gSS5JcG1VPkSu7ALorpgYL+aJlsIRvFqB+9d18XDzQmNa4
 SBfdygHCSXbGJmdlUiO3nShaQ0ELg07rf5bCNqPuwYmjfrzp/7xMhietZBqie3Qmve0j
 FZoMqCFc2ADu8piC2wzHhEwqoZ0kb7hWucXJLaUpf+S8/pRoIZB3+pgq80jKXoO7I8xC
 +Y2H95e/DJJ4d4jdfaVdGyqOo5XLgZLvstZMM0bh9CGNSIZIQ1mGyjhjc30/X6LztnLo
 SXGw==
X-Gm-Message-State: APjAAAUnKtn6pfiEfyHEUE275l62a7T+DitaZlgmbRqCid8kMOXwqgRG
 om3g5ZMz0b1Ks+81+ZZ9NTwNRLCt
X-Google-Smtp-Source: APXvYqxEKuQJo4s5Y2XKDYfNhBnuKy+sobYpR5uqcijZOTJp7GZpeW2ka/tQF/8VDEEEHoefzM927w==
X-Received: by 2002:a81:110a:: with SMTP id 10mr7306168ywr.48.1560920708882;
 Tue, 18 Jun 2019 22:05:08 -0700 (PDT)
Received: from localhost.localdomain (67-9-99-67.biz.bhn.net. [67.9.99.67])
 by smtp.gmail.com with ESMTPSA id e12sm1714426ywe.85.2019.06.18.22.05.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 18 Jun 2019 22:05:08 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 01:04:47 -0400
Message-Id: <20190619050447.22201-8-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619050447.22201-1-jan.bobek@gmail.com>
References: <20190619050447.22201-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RISU RFC PATCH v1 7/7] x86.risu: add SSE2 instructions
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add all SSE2 instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 153 insertions(+), 7 deletions(-)

diff --git a/x86.risu b/x86.risu
index cc40bbc..b3e4c88 100644
--- a/x86.risu
+++ b/x86.risu
@@ -12,63 +12,137 @@
 # Input file for risugen defining x86 instructions
 .mode x86
 
-# SSE Data Transfer Instructions
+# SSE/SSE2 Data Transfer Instructions
 MOVUPS          SSE     00001111 0001000 d !emit { modrm(); mem(size => 16); }
+MOVUPD          SSE2    00001111 0001000 d !emit { data16(); modrm(); mem(size => 16); }
 MOVSS           SSE     00001111 0001000 d !emit { rep(); modrm(); mem(size => 4); }
+MOVSD           SSE2    00001111 0001000 d !emit { repne(); modrm(); mem(size => 8); }
+
 MOVHLPS         SSE     00001111 00010010  !emit { modrm(mod => MOD_DIRECT); }
 MOVLPS          SSE     00001111 0001001 d !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+MOVLPD          SSE2    00001111 0001001 d !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+
 MOVLHPS         SSE     00001111 00010110  !emit { modrm(mod => MOD_DIRECT); }
 MOVHPS          SSE     00001111 0001011 d !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+MOVHPD          SSE2    00001111 0001011 d !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+
 MOVAPS          SSE     00001111 0010100 d !emit { modrm(); mem(size => 16, align => 16); }
+MOVAPD          SSE2    00001111 0010100 d !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
 MOVMSKPS        SSE     00001111 01010000  !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
+MOVMKSPD        SSE2    00001111 01010000  !emit { data16(); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 
-# SSE Packed Arithmetic Instructions
+# SSE/SSE2 Packed Arithmetic Instructions
 ADDPS           SSE     00001111 01011000 !emit { modrm(); mem(size => 16, align => 16); }
+ADDPD           SSE2    00001111 01011000 !emit { data16(); modrm(); mem(size => 16, align => 16) }
 ADDSS           SSE     00001111 01011000 !emit { rep(); modrm(); mem(size => 4); }
+ADDSD           SSE2    00001111 01011000 !emit { repne(); modrm(); mem(size => 4); }
+
 SUBPS           SSE     00001111 01011100 !emit { modrm(); mem(size => 16, align => 16); }
+SUBPD           SSE2    00001111 01011100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 SUBSS           SSE     00001111 01011100 !emit { rep(); modrm(); mem(size => 4); }
+SUBSD           SSE2    00001111 01011100 !emit { repne(); modrm(); mem(size => 4); }
+
 MULPS           SSE     00001111 01011001 !emit { modrm(); mem(size => 16, align => 16); }
+MULPD           SSE2    00001111 01011001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 MULSS           SSE     00001111 01011001 !emit { rep(); modrm(); mem(size => 4); }
-DIVPS           SSE     00001111 01011110 !emit { modrm(); mem(size => 16, align => 16); }
+MULSD           SSE2    00001111 01011001 !emit { repne(); modrm(); mem(size => 4); }
+
+DIVPS           SSE     00001111 01011110 !emit { modrm(); modrm(); mem(size => 16, align => 16); }
+DIVPD           SSE2    00001111 01011110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 DIVSS           SSE     00001111 01011110 !emit { rep(); modrm(); mem(size => 4); }
+DIVSD           SSE2    00001111 01011110 !emit { repne(); modrm(); mem(size => 4); }
+
 RCPPS           SSE     00001111 01010011 !emit { modrm(); mem(size => 16, align => 16); }
 RCPSS           SSE     00001111 01010011 !emit { rep(); modrm(); mem(size => 4); }
+
 SQRTPS          SSE     00001111 01010001 !emit { modrm(); mem(size => 16, align => 16); }
+SQRTPD          SSE2    00001111 01010001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 SQRTSS          SSE     00001111 01010001 !emit { rep(); modrm(); mem(size => 4); }
+SQRTSD          SSE2    00001111 01010001 !emit { repne(); modrm(); mem(size => 4); }
+
 RSQRTPS         SSE     00001111 01010010 !emit { modrm(); mem(size => 16, align => 16); }
 RSQRTSS         SSE     00001111 01010010 !emit { rep(); modrm(); mem(size => 4); }
+
 MINPS           SSE     00001111 01011101 !emit { modrm(); mem(size => 16, align => 16); }
+MINPD           SSE2    00001111 01011101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 MINSS           SSE     00001111 01011101 !emit { rep(); modrm(); mem(size => 4); }
+MINSD           SSE2    00001111 01011101 !emit { repne(); modrm(); mem(size => 4); }
+
 MAXPS           SSE     00001111 01011111 !emit { modrm(); mem(size => 16, align => 16); }
+MAXPD           SSE2    00001111 01011111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 MAXSS           SSE     00001111 01011111 !emit { rep(); modrm(); mem(size => 4); }
+MAXSD           SSE2    00001111 01011111 !emit { repne(); modrm(); mem(size => 4); }
 
-# SSE Comparison Instructions
+# SSE/SSE2 Comparison Instructions
 CMPPS           SSE     00001111 11000010 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
+CMPPD           SSE2    00001111 11000010 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 CMPSS           SSE     00001111 11000010 !emit { rep(); modrm(); mem(size => 4); imm(size => 1); }
+CMPSD           SSE2    00001111 11000010 !emit { repne(); modrm(); mem(size => 4); imm(size => 1); }
+
 UCOMISS         SSE     00001111 00101110 !emit { modrm(); mem(size => 4); }
+UCOMISD         SSE2    00001111 00101110 !emit { data16(); modrm(); mem(size => 4); }
+
 COMISS          SSE     00001111 00101111 !emit { modrm(); mem(size => 4); }
+COMISD          SSE2    00001111 00101111 !emit { data16(); modrm(); mem(size => 4); }
 
-# SSE Logical Instructions
+# SSE/SSE2 Logical Instructions
 ANDPS           SSE     00001111 01010100 !emit { modrm(); mem(size => 16, align => 16); }
+ANDPD           SSE2    00001111 01010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
 ANDNPS          SSE     00001111 01010101 !emit { modrm(); mem(size => 16, align => 16); }
+ANDNPD          SSE2    00001111 01010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
 ORPS            SSE     00001111 01010110 !emit { modrm(); mem(size => 16, align => 16); }
+ORPD            SSE2    00001111 01010110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
 XORPS           SSE     00001111 01010111 !emit { modrm(); mem(size => 16, align => 16); }
+XORPD           SSE2    00001111 01010111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
-# SSE Shuffle and Unpack Instructions
+# SSE/SSE2 Shuffle and Unpack Instructions
 SHUFPS          SSE     00001111 11000110 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
+SHUFPD          SSE2    00001111 11000110 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+
 UNPCKLPS        SSE     00001111 00010100 !emit { modrm(); mem(size => 16, align => 16); }
+UNPCKLPD        SSE2    00001111 00010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
 UNPCKHPS        SSE     00001111 00010101 !emit { modrm(); mem(size => 16, align => 16); }
+UNPCKHPD        SSE2    00001111 00010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
-# SSE Conversion Instructions
+# SSE/SSE2 Conversion Instructions
 CVTPI2PS        SSE     00001111 00101010 !emit { modrm(); mem(size => 8); }
+CVTPI2PD        SSE2    00001111 00101010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 CVTSI2SS        SSE     00001111 00101010 !emit { rep(); modrm(); mem(size => 4); }
+CVTSI2SD        SSE2    00001111 00101010 !emit { repne(); modrm(); mem(size => 8); }
 CVTSI2SS_64     SSE     00001111 00101010 !emit { rep(); rex(w => 1); modrm(); mem(size => 8); }
+CVTSI2SD_64     SSE2    00001111 00101010 !emit { repne(); rex(w => 1); modrm(); mem(size => 8); }
+
 CVTPS2PI        SSE     00001111 00101101 !emit { modrm(); mem(size => 8); }
+CVTPD2PI        SSE2    00001111 00101101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 CVTSS2SI        SSE     00001111 00101101 !emit { rep(); modrm(reg => ~REG_ESP); mem(size => 4); }
+CVTSD2SI        SSE2    00001111 00101101 !emit { repne(); modrm(reg => ~REG_ESP); mem(size => 8); }
 CVTSS2SI_64     SSE     00001111 00101101 !emit { rep(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 4); }
+CVTSD2SI_64     SSE2    00001111 00101101 !emit { repne(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 8); }
+
 CVTTPS2PI       SSE     00001111 00101100 !emit { modrm(); mem(size => 8); }
+CVTTPD2PI       SSE2    00001111 00101100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 CVTTSS2SI       SSE     00001111 00101100 !emit { rep(); modrm(reg => ~REG_ESP); mem(size => 4); }
+CVTTSD2SI       SSE2    00001111 00101100 !emit { repne(); modrm(reg => ~REG_ESP); mem(size => 8); }
 CVTTSS2SI_64    SSE     00001111 00101100 !emit { rep(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 4); }
+CVTTSD2SI_64    SSE2    00001111 00101100 !emit { repne(); rex(w => 1); modrm(reg => ~REG_ESP); mem(size => 8); }
+
+CVTPD2PQ        SSE2    00001111 11100110 !emit { repne(); modrm(); mem(size => 16, align => 16); }
+CVTTPD2PQ       SSE2    00001111 11100110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+CVTDQ2PD        SSE2    00001111 11100110 !emit { rep(); modrm(); mem(size => 8); }
+
+CVTPS2PD        SSE2    00001111 01011010 !emit { modrm(); mem(size => 8); }
+CVTPD2PS        SSE2    00001111 01011010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+CVTSS2SD        SSE2    00001111 01011010 !emit { rep(); modrm(); mem(size => 4); }
+CVTSD2SS        SSE2    00001111 01011010 !emit { repne(); modrm(); mem(size => 8); }
+
+CVTDQ2PS        SSE2    00001111 01011011 !emit { modrm(); mem(size => 16, align => 16); }
+CVTPS2DQ        SSE2    00001111 01011011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+CVTTPS2DQ       SSE2    00001111 01011011 !emit { rep(); modrm(); mem(size => 16, align => 16); }
 
 # SSE MXCSR State Management Instructions
 # LDMXCSR         SSE     00001111 10101110 !emit { modrm(mod => ~MOD_DIRECT, reg => 2); mem(size => 4); }
@@ -88,6 +162,67 @@ PMULHUW         SSE     00001111 11100100 !emit { modrm(); mem(size => 8); }
 PSADBW          SSE     00001111 11110110 !emit { modrm(); mem(size => 8); }
 PSHUFW          SSE     00001111 01110000 !emit { modrm(); mem(size => 8); imm(size => 1); }
 
+# SSE2 128-bit SIMD Integer Instructions
+MOVDQA          SSE2    00001111 011 d 1111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+MOVDQU          SSE2    00001111 011 d 1111 !emit { rep(); modrm(); mem(size => 16); }
+MOVQ2DQ         SSE2    00001111 11010110 !emit { rep(); modrm(mod => MOD_DIRECT); }
+MOVDQ2Q         SSE2    00001111 11010110 !emit { repne(); modrm(mod => MOD_DIRECT); }
+
+PMULUDQ_64      SSE2    00001111 11110100 !emit { modrm(); mem(size => 8); }
+PMULUDQ         SSE2    00001111 11110100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PADDB           SSE2    00001111 11111100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PADDW           SSE2    00001111 11111101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PADDD           SSE2    00001111 11111110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PADDQ           SSE2    00001111 11010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PADDSB          SSE2    00001111 11101100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PADDSW          SSE2    00001111 11101101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PADDUSB         SSE2    00001111 11011100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PADDUSW         SSE2    00001111 11011101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSUBB           SSE2    00001111 11111000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSUBW           SSE2    00001111 11111001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSUBD           SSE2    00001111 11111010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSUBQ_64        SSE2    00001111 11111011 !emit { modrm(); mem(size => 8); }
+PSUBQ           SSE2    00001111 11111011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSUBSB          SSE2    00001111 11101000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSUBSW          SSE2    00001111 11101001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSUBUSB         SSE2    00001111 11011000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSUBUSW         SSE2    00001111 11011001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
+PSHUFLW         SSE2    00001111 01110000 !emit { repne(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+PSHUFHW         SSE2    00001111 01110000 !emit { rep(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+PSHUFD          SSE2    00001111 01110000 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+
+PSLLW           SSE2    00001111 11110001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSLLW_imm       SSE2    00001111 01110001 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+PSLLD           SSE2    00001111 11110010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSLLD_imm       SSE2    00001111 01110010 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+PSLLQ           SSE2    00001111 11110011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSLLQ_imm       SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+PSLLDQ          SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 7); imm(size => 1); }
+
+PSRAW           SSE2    00001111 11100001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSRAW_imm       SSE2    00001111 01110001 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
+PSRAD           SSE2    00001111 11100010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSRAD_imm       SSE2    00001111 01110010 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
+
+PSRLW           SSE2    00001111 11010001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSRLW_imm       SSE2    00001111 01110001 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+PSRLD           SSE2    00001111 11010010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSRLD_imm       SSE2    00001111 01110010 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+PSRLQ           SSE2    00001111 11010011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSRLQ_imm       SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+PSRLDQ          SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 3); imm(size => 1); }
+
+PUNPCKHBW       SSE2    00001111 01101000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PUNPCKHWD       SSE2    00001111 01101001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PUNPCKHDQ       SSE2    00001111 01101010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PUNPCKHQDQ      SSE2    00001111 01101101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
+PUNPCKLBW       SSE2    00001111 01100000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PUNPCKLWD       SSE2    00001111 01100001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PUNPCKLDQ       SSE2    00001111 01100010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PUNPCKLQDQ      SSE2    00001111 01101100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
 # SSE Cacheability Control, Prefetch, and Instruction Ordering Instructions
 MASKMOVQ        SSE     00001111 11110111 !emit { modrm(mod => MOD_DIRECT); mem(size => 8, base => REG_EDI); }
 MOVNTQ          SSE     00001111 11100111 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
@@ -97,3 +232,14 @@ PREFETCHT1      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg
 PREFETCHT2      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 3); mem(size => 1); }
 PREFETCHNTA     SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 0); mem(size => 1); }
 SFENCE          SSE     00001111 10101110 !emit { modrm(mod => MOD_DIRECT, reg => 7); }
+
+# SSE2 Cacheability Control, Prefetch, and Instruction Ordering Instructions
+CFLUSH          SSE2    00001111 10101110 !emit { modrm(mod => ~MOD_DIRECT, reg => 7); mem(size => 1); }
+LFENCE          SSE2    00001111 10101110 !emit { modrm(mod => 0b11, reg => 0b101); }
+MFENCE          SSE2    00001111 10101110 !emit { modrm(mod => 0b11, reg => 0b111); }
+PAUSE           SSE2    10010000          !emit { rep(); }
+MASKMOVDQU      SSE2    00001111 11110111 !emit { data16(); modrm(mod => MOD_DIRECT); mem(size => 16, base => REG_EDI); }
+MOVNTPD         SSE2    00001111 00101011 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+MOVNTDQ         SSE2    00001111 11100111 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+MOVNTI          SSE2    00001111 11000011 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 4); }
+MOVNTI_64       SSE2    00001111 11000011 !emit { rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
-- 
2.20.1


