Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE8DC742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D194A2084B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsRxZI8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D194A2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhgp-0007wC-6U
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhda-00030K-2f
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdO-0004Az-Rz
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:34:01 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:40731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhdO-0003qc-G1
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:50 -0400
Received: by mail-yw1-xc43.google.com with SMTP id b143so4457552ywb.7
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KGAprb/O8OKJ/HlTaVuYvXWrpva6najMT+4XAsFTqs0=;
 b=nsRxZI8d3Em6bzY4Cd+kL3bFIGYnwTP4BCIxdEJRvhy/9BqD2bpHrrWwzp49ypHGe/
 q31lJPC0jSpjWBq2PyZG1lN8Q66L6gb3SbXJvtSvR+0QXb8tKg/yryKotPYghANLEvXk
 CGvoBSBgGDEf9azpSbVU+Fu2sjIubpLRl5YRTA5xEtm2JC0OonSlSMpheNCfRXsDBmMT
 3/w+tog0S0DkvS4Y1IylY9s2xZv3tpkNH7lV4JH00CMOvqBISZON7ZMHP69yWItX1HHU
 7jxK6jMcvFqOUGpPBzAdVqc9maotYJnBIaxfWb/MMORbedwrEm5LRMbePzJDZokrFxp1
 H5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KGAprb/O8OKJ/HlTaVuYvXWrpva6najMT+4XAsFTqs0=;
 b=QthGX1NvJLyCRhA9lnyLdvtojAeAEsWNgKgmL4e7fE/DVE+UmYPsD3An3pFZO/3DeR
 nTUs81XU2aC5xADM6UalxTaPAdftGwN/eYz3rsdz7YdqoB4pzPJfxkz3QIvmyAdedUE9
 HWH9wfY0ubeHqTyn4L3l5OyPVrDqqzi6IyC2rcKg+CT51i4I28tEWTez4w+Fe6hdWBeu
 NO7FM+gB4SXQy2nirJoD4W8eWQWgxuS+gKgV+BogxzujBgeihilfexC0cpzoe5ust1tB
 MGhR8ItdwfI2V7rTloCHT7ChG+JutwirjYe+s2lT8llOylvITH/hhP/Gbvb+nvIk+DQ0
 b0yA==
X-Gm-Message-State: APjAAAVSo+XtfLuLku/cGaO7S5NqiSSmdSM0C1iUYlARBKcxdQhkZ+Ub
 /VbBHOuouxl3Nhm6BKtZcPBTP/4F
X-Google-Smtp-Source: APXvYqypHQs5DLHQbHiVMx3yixFgHtzZuSAo5IA4oCJTbkvoTqcprM1V5vG6nkw5SiLHl0JXVDyQtw==
X-Received: by 2002:a81:8187:: with SMTP id r129mr3587947ywf.309.1562884404679; 
 Thu, 11 Jul 2019 15:33:24 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:24 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:33:00 -0400
Message-Id: <20190711223300.6061-19-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RISU PATCH v3 18/18] x86.risu: add AVX2 instructions
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

Add AVX2 instructions to the configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 1239 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1239 insertions(+)

diff --git a/x86.risu b/x86.risu
index 03ffc89..1705a8e 100644
--- a/x86.risu
+++ b/x86.risu
@@ -91,6 +91,12 @@ VMOVAPS AVX 0010100 d \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
   !memory { $d ? store(size => 16, align => 16) : load(size => 16, align => 16); }
 
+# VEX.256.0F.WIG 28 /r: VMOVAPS ymm1, ymm2/m256
+# VEX.256.0F.WIG 29 /r: VMOVAPS ymm2/m256, ymm1
+VMOVAPS AVX2 0010100 d \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0); modrm($_); 1 } \
+  !memory { $d ? store(size => 32, align => 32) : load(size => 32, align => 32); }
+
 # 66 0F 28 /r: MOVAPD xmm1, xmm2/m128
 # 66 0F 29 /r: MOVAPD xmm2/m128, xmm1
 MOVAPD SSE2 00001111 0010100 d \
@@ -103,6 +109,12 @@ VMOVAPD AVX 0010100 d \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { $d ? store(size => 16, align => 16) : load(size => 16, align => 16); }
 
+# VEX.256.66.0F.WIG 28 /r: VMOVAPD ymm1, ymm2/m256
+# VEX.256.66.0F.WIG 29 /r: VMOVAPD ymm2/m256, ymm1
+VMOVAPD AVX2 0010100 d \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { $d ? store(size => 32, align => 32) : load(size => 32, align => 32); }
+
 # 66 0F 6F /r: MOVDQA xmm1, xmm2/m128
 # 66 0F 7F /r: MOVDQA xmm2/m128, xmm1
 MOVDQA SSE2 00001111 011 d 1111 \
@@ -115,6 +127,12 @@ VMOVDQA AVX 011 d 1111 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { $d ? store(size => 16, align => 16) : load(size => 16, align => 16); }
 
+# VEX.256.66.0F.WIG 6F /r: VMOVDQA ymm1, ymm2/m256
+# VEX.256.66.0F.WIG 7F /r: VMOVDQA ymm2/m256, ymm1
+VMOVDQA AVX2 011 d 1111 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { $d ? store(size => 32, align => 32) : load(size => 32, align => 32); }
+
 # NP 0F 10 /r: MOVUPS xmm1, xmm2/m128
 # NP 0F 11 /r: MOVUPS xmm2/m128, xmm1
 MOVUPS SSE 00001111 0001000 d \
@@ -127,6 +145,12 @@ VMOVUPS AVX 0001000 d \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
   !memory { $d ? store(size => 16) : load(size => 16); }
 
+# VEX.256.0F.WIG 10 /r: VMOVUPS ymm1, ymm2/m256
+# VEX.256.0F.WIG 11 /r: VMOVUPS ymm2/m256, ymm1
+VMOVUPS AVX2 0001000 d \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0); modrm($_); 1 } \
+  !memory { $d ? store(size => 32) : load(size => 32); }
+
 # 66 0F 10 /r: MOVUPD xmm1, xmm2/m128
 # 66 0F 11 /r: MOVUPD xmm2/m128, xmm1
 MOVUPD SSE2 00001111 0001000 d \
@@ -139,6 +163,12 @@ VMOVUPD AVX 0001000 d \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { $d ? store(size => 16) : load(size => 16); }
 
+# VEX.256.66.0F.WIG 10 /r: VMOVUPD ymm1, ymm2/m256
+# VEX.256.66.0F.WIG 11 /r: VMOVUPD ymm2/m256, ymm1
+VMOVUPD AVX2 0001000 d \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { $d ? store(size => 32) : load(size => 32); }
+
 # F3 0F 6F /r: MOVDQU xmm1,xmm2/m128
 # F3 0F 7F /r: MOVDQU xmm2/m128,xmm1
 MOVDQU SSE2 00001111 011 d 1111 \
@@ -151,6 +181,12 @@ VMOVDQU AVX 011 d 1111 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF3); modrm($_); 1 } \
   !memory { $d ? store(size => 16) : load(size => 16); }
 
+# VEX.256.F3.0F.WIG 6F /r: VMOVDQU ymm1,ymm2/m256
+# VEX.256.F3.0F.WIG 7F /r: VMOVDQU ymm2/m256,ymm1
+VMOVDQU AVX2 011 d 1111 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { $d ? store(size => 32) : load(size => 32); }
+
 # F3 0F 10 /r: MOVSS xmm1, xmm2/m32
 # F3 0F 11 /r: MOVSS xmm2/m32, xmm1
 MOVSS SSE 00001111 0001000 d \
@@ -263,6 +299,10 @@ PMOVMSKB SSE2 00001111 11010111 \
 VPMOVMSKB AVX 11010111 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
 
+# VEX.256.66.0F.WIG D7 /r: VPMOVMSKB reg, ymm1
+VPMOVMSKB AVX2 11010111 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0x66); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
+
 # NP 0F 50 /r: MOVMSKPS reg, xmm
 MOVMSKPS SSE 00001111 01010000 \
   !constraints { modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
@@ -271,6 +311,10 @@ MOVMSKPS SSE 00001111 01010000 \
 VMOVMSKPS AVX 01010000 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
 
+# VEX.256.0F.WIG 50 /r: VMOVMSKPS reg, ymm2
+VMOVMSKPS AVX2 01010000 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
+
 # 66 0F 50 /r: MOVMSKPD reg, xmm
 MOVMSKPD SSE2 00001111 01010000 \
   !constraints { data16($_); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
@@ -279,6 +323,10 @@ MOVMSKPD SSE2 00001111 01010000 \
 VMOVMSKPD AVX 01010000 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
 
+# VEX.256.66.0F.WIG 50 /r: VMOVMSKPD reg, ymm2
+VMOVMSKPD AVX2 01010000 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0x66); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
+
 # F2 0F F0 /r: LDDQU xmm1, m128
 LDDQU SSE3 00001111 11110000 \
   !constraints { repne($_); modrm($_); !defined $_->{modrm}{reg2} } \
@@ -289,6 +337,11 @@ VLDDQU AVX 11110000 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF2); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { load(size => 16); }
 
+# VEX.256.F2.0F.WIG F0 /r: VLDDQU ymm1, m256
+VLDDQU AVX2 11110000 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0xF2); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 32); }
+
 # F3 0F 16 /r: MOVSHDUP xmm1, xmm2/m128
 MOVSHDUP SSE3 00001111 00010110 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -299,6 +352,11 @@ VMOVSHDUP AVX 00010110 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF3); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.F3.0F.WIG 16 /r: VMOVSHDUP ymm1, ymm2/m256
+VMOVSHDUP AVX2 00010110 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F 12 /r: MOVSLDUP xmm1, xmm2/m128
 MOVSLDUP SSE3 00001111 00010010 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -309,6 +367,11 @@ VMOVSLDUP AVX 00010010 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF3); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.F3.0F.WIG 12 /r: VMOVSLDUP ymm1, ymm2/m256
+VMOVSLDUP AVX2 00010010 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F2 0F 12 /r: MOVDDUP xmm1, xmm2/m64
 MOVDDUP SSE3 00001111 00010010 \
   !constraints { repne($_); modrm($_); 1 } \
@@ -319,6 +382,11 @@ VMOVDDUP AVX 00010010 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF2); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.256.F2.0F.WIG 12 /r: VMOVDDUP ymm1, ymm2/m256
+VMOVDDUP AVX2 00010010 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 #
 # Arithmetic Instructions
 # -----------------------
@@ -339,6 +407,11 @@ VPADDB AVX 11111100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG FC /r: VPADDB ymm1, ymm2, ymm3/m256
+VPADDB AVX2 11111100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F FD /r: PADDW mm, mm/m64
 PADDW MMX 00001111 11111101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -354,6 +427,11 @@ VPADDW AVX 11111101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG FD /r: VPADDW ymm1, ymm2, ymm3/m256
+VPADDW AVX2 11111101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F FE /r: PADDD mm, mm/m64
 PADDD MMX 00001111 11111110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -369,6 +447,11 @@ VPADDD AVX 11111110 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG FE /r: VPADDD ymm1, ymm2, ymm3/m256
+VPADDD AVX2 11111110 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F D4 /r: PADDQ mm, mm/m64
 PADDQ_mm SSE2 00001111 11010100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -384,6 +467,11 @@ VPADDQ AVX 11010100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG D4 /r: VPADDQ ymm1, ymm2, ymm3/m256
+VPADDQ AVX2 11010100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F EC /r: PADDSB mm, mm/m64
 PADDSB MMX 00001111 11101100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -399,6 +487,11 @@ VPADDSB AVX 11101100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG EC /r: VPADDSB ymm1, ymm2, ymm3/m256
+VPADDSB AVX2 11101100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F ED /r: PADDSW mm, mm/m64
 PADDSW MMX 00001111 11101101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -414,6 +507,11 @@ VPADDSW AVX 11101101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG ED /r: VPADDSW ymm1, ymm2, ymm3/m256
+VPADDSW AVX2 11101101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F DC /r: PADDUSB mm,mm/m64
 PADDUSB MMX 00001111 11011100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -429,6 +527,11 @@ VPADDUSB AVX 11011100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG DC /r: VPADDUSB ymm1,ymm2,ymm3/m256
+VPADDUSB AVX2 11011100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F DD /r: PADDUSW mm,mm/m64
 PADDUSW MMX 00001111 11011101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -444,6 +547,11 @@ VPADDUSW AVX 11011101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG DD /r: VPADDUSW ymm1,ymm2,ymm3/m256
+VPADDUSW AVX2 11011101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 58 /r: ADDPS xmm1, xmm2/m128
 ADDPS SSE 00001111 01011000 \
   !constraints { modrm($_); 1 } \
@@ -454,6 +562,11 @@ VADDPS AVX 01011000 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG 58 /r: VADDPS ymm1, ymm2, ymm3/m256
+VADDPS AVX2 01011000 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 58 /r: ADDPD xmm1, xmm2/m128
 ADDPD SSE2 00001111 01011000 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -464,6 +577,11 @@ VADDPD AVX 01011000 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 58 /r: VADDPD ymm1, ymm2, ymm3/m256
+VADDPD AVX2 01011000 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F 58 /r: ADDSS xmm1, xmm2/m32
 ADDSS SSE 00001111 01011000 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -499,6 +617,11 @@ VPHADDW AVX 00000001 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 01 /r: VPHADDW ymm1, ymm2, ymm3/m256
+VPHADDW AVX2 00000001 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 38 02 /r: PHADDD mm1, mm2/m64
 PHADDD_mm SSSE3 00001111 00111000 00000010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -514,6 +637,11 @@ VPHADDD AVX 00000010 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 02 /r: VPHADDD ymm1, ymm2, ymm3/m256
+VPHADDD AVX2 00000010 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 38 03 /r: PHADDSW mm1, mm2/m64
 PHADDSW_mm SSSE3 00001111 00111000 00000011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -529,6 +657,11 @@ VPHADDSW AVX 00000011 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 03 /r: VPHADDSW ymm1, ymm2, ymm3/m256
+VPHADDSW AVX2 00000011 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F2 0F 7C /r: HADDPS xmm1, xmm2/m128
 HADDPS SSE3 00001111 01111100 \
   !constraints { repne($_); modrm($_); 1 } \
@@ -539,6 +672,11 @@ VHADDPS AVX 01111100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0xF2); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.F2.0F.WIG 7C /r: VHADDPS ymm1, ymm2, ymm3/m256
+VHADDPS AVX2 01111100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 7C /r: HADDPD xmm1, xmm2/m128
 HADDPD SSE3 00001111 01111100 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -549,6 +687,11 @@ VHADDPD AVX 01111100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 7C /r: VHADDPD ymm1, ymm2, ymm3/m256
+VHADDPD AVX2 01111100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F F8 /r: PSUBB mm, mm/m64
 PSUBB MMX 00001111 11111000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -564,6 +707,11 @@ VPSUBB AVX 11111000 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG F8 /r: VPSUBB ymm1, ymm2, ymm3/m256
+VPSUBB AVX2 11111000 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F F9 /r: PSUBW mm, mm/m64
 PSUBW MMX 00001111 11111001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -579,6 +727,11 @@ VPSUBW AVX 11111001 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG F9 /r: VPSUBW ymm1, ymm2, ymm3/m256
+VPSUBW AVX2 11111001 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F FA /r: PSUBD mm, mm/m64
 PSUBD MMX 00001111 11111010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -594,6 +747,11 @@ VPSUBD AVX 11111010 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG FA /r: VPSUBD ymm1, ymm2, ymm3/m256
+VPSUBD AVX2 11111010 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F FB /r: PSUBQ mm1, mm2/m64
 PSUBQ_mm SSE2 00001111 11111011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -609,6 +767,11 @@ VPSUBQ AVX 11111011 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG FB /r: VPSUBQ ymm1, ymm2, ymm3/m256
+VPSUBQ AVX2 11111011 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F E8 /r: PSUBSB mm, mm/m64
 PSUBSB MMX 00001111 11101000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -624,6 +787,11 @@ VPSUBSB AVX 11101000 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG E8 /r: VPSUBSB ymm1, ymm2, ymm3/m256
+VPSUBSB AVX2 11101000 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F E9 /r: PSUBSW mm, mm/m64
 PSUBSW MMX 00001111 11101001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -639,6 +807,11 @@ VPSUBSW AVX 11101001 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG E9 /r: VPSUBSW ymm1, ymm2, ymm3/m256
+VPSUBSW AVX2 11101001 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F D8 /r: PSUBUSB mm, mm/m64
 PSUBUSB MMX 00001111 11011000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -654,6 +827,11 @@ VPSUBUSB AVX 11011000 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG D8 /r: VPSUBUSB ymm1, ymm2, ymm3/m256
+VPSUBUSB AVX2 11011000 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F D9 /r: PSUBUSW mm, mm/m64
 PSUBUSW MMX 00001111 11011001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -669,6 +847,11 @@ VPSUBUSW AVX 11011001 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG D9 /r: VPSUBUSW ymm1, ymm2, ymm3/m256
+VPSUBUSW AVX2 11011001 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 5C /r: SUBPS xmm1, xmm2/m128
 SUBPS SSE 00001111 01011100 \
   !constraints { modrm($_); 1 } \
@@ -679,6 +862,11 @@ VSUBPS AVX 01011100 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG 5C /r: VSUBPS ymm1, ymm2, ymm3/m256
+VSUBPS AVX2 01011100 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 5C /r: SUBPD xmm1, xmm2/m128
 SUBPD SSE2 00001111 01011100 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -689,6 +877,11 @@ VSUBPD AVX 01011100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 5C /r: VSUBPD ymm1, ymm2, ymm3/m256
+VSUBPD AVX2 01011100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F 5C /r: SUBSS xmm1, xmm2/m32
 SUBSS SSE 00001111 01011100 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -724,6 +917,11 @@ VPHSUBW AVX 00000101 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 05 /r: VPHSUBW ymm1, ymm2, ymm3/m256
+VPHSUBW AVX2 00000101 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 38 06 /r: PHSUBD mm1, mm2/m64
 PHSUBD_mm SSSE3 00001111 00111000 00000110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -739,6 +937,11 @@ VPHSUBD AVX 00000110 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 06 /r: VPHSUBD ymm1, ymm2, ymm3/m256
+VPHSUBD AVX2 00000110 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 38 07 /r: PHSUBSW mm1, mm2/m64
 PHSUBSW_mm SSSE3 00001111 00111000 00000111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -754,6 +957,11 @@ VPHSUBSW AVX 00000111 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 07 /r: VPHSUBSW ymm1, ymm2, ymm3/m256
+VPHSUBSW AVX2 00000111 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F2 0F 7D /r: HSUBPS xmm1, xmm2/m128
 HSUBPS SSE3 00001111 01111101 \
   !constraints { repne($_); modrm($_); 1 } \
@@ -764,6 +972,11 @@ VHSUBPS AVX 01111101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0xF2); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.F2.0F.WIG 7D /r: VHSUBPS ymm1, ymm2, ymm3/m256
+VHSUBPS AVX2 01111101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 7D /r: HSUBPD xmm1, xmm2/m128
 HSUBPD SSE3 00001111 01111101 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -774,6 +987,11 @@ VHSUBPD AVX 01111101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 7D /r: VHSUBPD ymm1, ymm2, ymm3/m256
+VHSUBPD AVX2 01111101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F2 0F D0 /r: ADDSUBPS xmm1, xmm2/m128
 ADDSUBPS SSE3 00001111 11010000 \
   !constraints { repne($_); modrm($_); 1 } \
@@ -784,6 +1002,11 @@ VADDSUBPS AVX 11010000 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0xF2); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.F2.0F.WIG D0 /r: VADDSUBPS ymm1, ymm2, ymm3/m256
+VADDSUBPS AVX2 11010000 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F D0 /r: ADDSUBPD xmm1, xmm2/m128
 ADDSUBPD SSE3 00001111 11010000 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -794,6 +1017,11 @@ VADDSUBPD AVX 11010000 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG D0 /r: VADDSUBPD ymm1, ymm2, ymm3/m256
+VADDSUBPD AVX2 11010000 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F D5 /r: PMULLW mm, mm/m64
 PMULLW MMX 00001111 11010101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -809,6 +1037,11 @@ VPMULLW AVX 11010101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG D5 /r: VPMULLW ymm1, ymm2, ymm3/m256
+VPMULLW AVX2 11010101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 40 /r: PMULLD xmm1, xmm2/m128
 PMULLD SSE4_1 00001111 00111000 01000000 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -819,6 +1052,11 @@ VPMULLD AVX 01000000 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 40 /r: VPMULLD ymm1, ymm2, ymm3/m256
+VPMULLD AVX2 01000000 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F E5 /r: PMULHW mm, mm/m64
 PMULHW MMX 00001111 11100101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -834,6 +1072,11 @@ VPMULHW AVX 11100101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG E5 /r: VPMULHW ymm1, ymm2, ymm3/m256
+VPMULHW AVX2 11100101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F E4 /r: PMULHUW mm1, mm2/m64
 PMULHUW SSE 00001111 11100100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -849,6 +1092,11 @@ VPMULHUW AVX 11100100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG E4 /r: VPMULHUW ymm1, ymm2, ymm3/m256
+VPMULHUW AVX2 11100100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 28 /r: PMULDQ xmm1, xmm2/m128
 PMULDQ SSE4_1 00001111 00111000 00101000 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -859,6 +1107,11 @@ VPMULDQ AVX 00101000 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 28 /r: VPMULDQ ymm1, ymm2, ymm3/m256
+VPMULDQ AVX2 00101000 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F F4 /r: PMULUDQ mm1, mm2/m64
 PMULUDQ_mm SSE2 00001111 11110100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -874,6 +1127,11 @@ VPMULUDQ AVX 11110100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG F4 /r: VPMULUDQ ymm1, ymm2, ymm3/m256
+VPMULUDQ AVX2 11110100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 38 0B /r: PMULHRSW mm1, mm2/m64
 PMULHRSW_mm SSSE3 00001111 00111000 00001011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -889,6 +1147,11 @@ VPMULHRSW AVX 00001011 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 0B /r: VPMULHRSW ymm1, ymm2, ymm3/m256
+VPMULHRSW AVX2 00001011 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 59 /r: MULPS xmm1, xmm2/m128
 MULPS SSE 00001111 01011001 \
   !constraints { modrm($_); 1 } \
@@ -899,6 +1162,11 @@ VMULPS AVX 01011001 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG 59 /r: VMULPS ymm1, ymm2, ymm3/m256
+VMULPS AVX2 01011001 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 59 /r: MULPD xmm1, xmm2/m128
 MULPD SSE2 00001111 01011001 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -909,6 +1177,11 @@ VMULPD AVX 01011001 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 59 /r: VMULPD ymm1, ymm2, ymm3/m256
+VMULPD AVX2 01011001 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F 59 /r: MULSS xmm1,xmm2/m32
 MULSS SSE 00001111 01011001 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -944,6 +1217,11 @@ VPMADDWD AVX 11110101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG F5 /r: VPMADDWD ymm1, ymm2, ymm3/m256
+VPMADDWD AVX2 11110101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 38 04 /r: PMADDUBSW mm1, mm2/m64
 PMADDUBSW_mm SSSE3 00001111 00111000 00000100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -959,6 +1237,11 @@ VPMADDUBSW AVX 00000100 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 04 /r: VPMADDUBSW ymm1, ymm2, ymm3/m256
+VPMADDUBSW AVX2 00000100 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 5E /r: DIVPS xmm1, xmm2/m128
 DIVPS SSE 00001111 01011110 \
   !constraints { modrm($_); 1 } \
@@ -969,6 +1252,11 @@ VDIVPS AVX 01011110 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG 5E /r: VDIVPS ymm1, ymm2, ymm3/m256
+VDIVPS AVX2 01011110 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 5E /r: DIVPD xmm1, xmm2/m128
 DIVPD SSE2 00001111 01011110 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -979,6 +1267,11 @@ VDIVPD AVX 01011110 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 5E /r: VDIVPD ymm1, ymm2, ymm3/m256
+VDIVPD AVX2 01011110 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F 5E /r: DIVSS xmm1, xmm2/m32
 DIVSS SSE 00001111 01011110 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -1009,6 +1302,11 @@ VRCPPS AVX 01010011 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG 53 /r: VRCPPS ymm1, ymm2/m256
+VRCPPS AVX2 01010011 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F 53 /r: RCPSS xmm1, xmm2/m32
 RCPSS SSE 00001111 01010011 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -1029,6 +1327,11 @@ VSQRTPS AVX 01010001 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG 51 /r: VSQRTPS ymm1, ymm2/m256
+VSQRTPS AVX2 01010001 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 51 /r: SQRTPD xmm1, xmm2/m128
 SQRTPD SSE2 00001111 01010001 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1039,6 +1342,11 @@ VSQRTPD AVX 01010001 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 51 /r: VSQRTPD ymm1, ymm2/m256
+VSQRTPD AVX2 01010001 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F 51 /r: SQRTSS xmm1, xmm2/m32
 SQRTSS SSE 00001111 01010001 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -1069,6 +1377,11 @@ VRSQRTPS AVX 01010010 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG 52 /r: VRSQRTPS ymm1, ymm2/m256
+VRSQRTPS AVX2 01010010 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F 52 /r: RSQRTSS xmm1, xmm2/m32
 RSQRTSS SSE 00001111 01010010 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -1094,6 +1407,11 @@ VPMINUB AVX 11011010 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F DA /r: VPMINUB ymm1, ymm2, ymm3/m256
+VPMINUB AVX2 11011010 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 3A /r: PMINUW xmm1, xmm2/m128
 PMINUW SSE4_1 00001111 00111000 00111010 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1104,6 +1422,11 @@ VPMINUW AVX 00111010 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38 3A /r: VPMINUW ymm1, ymm2, ymm3/m256
+VPMINUW AVX2 00111010 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 3B /r: PMINUD xmm1, xmm2/m128
 PMINUD SSE4_1 00001111 00111000 00111011 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1114,6 +1437,11 @@ VPMINUD AVX 00111011 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 3B /r: VPMINUD ymm1, ymm2, ymm3/m256
+VPMINUD AVX2 00111011 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 38 /r: PMINSB xmm1, xmm2/m128
 PMINSB SSE4_1 00001111 00111000 00111000 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1124,6 +1452,11 @@ VPMINSB AVX 00111000 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38 38 /r: VPMINSB ymm1, ymm2, ymm3/m256
+VPMINSB AVX2 00111000 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F EA /r: PMINSW mm1, mm2/m64
 PMINSW SSE 00001111 11101010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1139,6 +1472,11 @@ VPMINSW AVX 11101010 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F EA /r: VPMINSW ymm1, ymm2, ymm3/m256
+VPMINSW AVX2 11101010 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 39 /r: PMINSD xmm1, xmm2/m128
 PMINSD SSE4_1 00001111 00111000 00111001 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1149,6 +1487,11 @@ VPMINSD AVX 00111001 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 39 /r: VPMINSD ymm1, ymm2, ymm3/m256
+VPMINSD AVX2 00111001 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 5D /r: MINPS xmm1, xmm2/m128
 MINPS SSE 00001111 01011101 \
   !constraints { modrm($_); 1 } \
@@ -1159,6 +1502,11 @@ VMINPS AVX 01011101 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG 5D /r: VMINPS ymm1, ymm2, ymm3/m256
+VMINPS AVX2 01011101 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 5D /r: MINPD xmm1, xmm2/m128
 MINPD SSE2 00001111 01011101 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1169,6 +1517,11 @@ VMINPD AVX 01011101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 5D /r: VMINPD ymm1, ymm2, ymm3/m256
+VMINPD AVX2 01011101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F 5D /r: MINSS xmm1,xmm2/m32
 MINSS SSE 00001111 01011101 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -1214,6 +1567,11 @@ VPMAXUB AVX 11011110 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F DE /r: VPMAXUB ymm1, ymm2, ymm3/m256
+VPMAXUB AVX2 11011110 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 3E /r: PMAXUW xmm1, xmm2/m128
 PMAXUW SSE4_1 00001111 00111000 00111110 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1224,6 +1582,11 @@ VPMAXUW AVX 00111110 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38 3E /r: VPMAXUW ymm1, ymm2, ymm3/m256
+VPMAXUW AVX2 00111110 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 3F /r: PMAXUD xmm1, xmm2/m128
 PMAXUD SSE4_1 00001111 00111000 00111111 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1234,6 +1597,11 @@ VPMAXUD AVX 00111111 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 3F /r: VPMAXUD ymm1, ymm2, ymm3/m256
+VPMAXUD AVX2 00111111 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 3C /r: PMAXSB xmm1, xmm2/m128
 PMAXSB SSE4_1 00001111 00111000 00111100 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1244,6 +1612,11 @@ VPMAXSB AVX 00111100 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 3C /r: VPMAXSB ymm1, ymm2, ymm3/m256
+VPMAXSB AVX2 00111100 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F EE /r: PMAXSW mm1, mm2/m64
 PMAXSW SSE 00001111 11101110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1259,6 +1632,11 @@ VPMAXSW AVX 11101110 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG EE /r: VPMAXSW ymm1, ymm2, ymm3/m256
+VPMAXSW AVX2 11101110 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 3D /r: PMAXSD xmm1, xmm2/m128
 PMAXSD SSE4_1 00001111 00111000 00111101 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1269,6 +1647,11 @@ VPMAXSD AVX 00111101 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 3D /r: VPMAXSD ymm1, ymm2, ymm3/m256
+VPMAXSD AVX2 00111101 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 5F /r: MAXPS xmm1, xmm2/m128
 MAXPS SSE 00001111 01011111 \
   !constraints { modrm($_); 1 } \
@@ -1279,6 +1662,11 @@ VMAXPS AVX 01011111 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG 5F /r: VMAXPS ymm1, ymm2, ymm3/m256
+VMAXPS AVX2 01011111 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 5F /r: MAXPD xmm1, xmm2/m128
 MAXPD SSE2 00001111 01011111 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1289,6 +1677,11 @@ VMAXPD AVX 01011111 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 5F /r: VMAXPD ymm1, ymm2, ymm3/m256
+VMAXPD AVX2 01011111 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F 5F /r: MAXSS xmm1, xmm2/m32
 MAXSS SSE 00001111 01011111 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -1324,6 +1717,11 @@ VPAVGB AVX 11100000 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG E0 /r: VPAVGB ymm1, ymm2, ymm3/m256
+VPAVGB AVX2 11100000 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F E3 /r: PAVGW mm1, mm2/m64
 PAVGW SSE 00001111 11100011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1339,6 +1737,11 @@ VPAVGW AVX 11100011 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG E3 /r: VPAVGW ymm1, ymm2, ymm3/m256
+VPAVGW AVX2 11100011 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F F6 /r: PSADBW mm1, mm2/m64
 PSADBW SSE 00001111 11110110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1354,6 +1757,11 @@ VPSADBW AVX 11110110 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG F6 /r: VPSADBW ymm1, ymm2, ymm3/m256
+VPSADBW AVX2 11110110 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 3A 42 /r ib: MPSADBW xmm1, xmm2/m128, imm8
 MPSADBW SSE4_1 00001111 00111010 01000010 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
@@ -1364,6 +1772,11 @@ VMPSADBW AVX 01000010 \
   !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F3A.WIG 42 /r ib: VMPSADBW ymm1, ymm2, ymm3/m256, imm8
+VMPSADBW AVX2 01000010 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 38 1C /r: PABSB mm1, mm2/m64
 PABSB_mm SSSE3 00001111 00111000 00011100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1379,6 +1792,11 @@ VPABSB AVX 00011100 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 1C /r: VPABSB ymm1, ymm2/m256
+VPABSB AVX2 00011100 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 38 1D /r: PABSW mm1, mm2/m64
 PABSW_mm SSSE3 00001111 00111000 00011101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1394,6 +1812,11 @@ VPABSW AVX 00011101 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 1D /r: VPABSW ymm1, ymm2/m256
+VPABSW AVX2 00011101 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 38 1E /r: PABSD mm1, mm2/m64
 PABSD_mm SSSE3 00001111 00111000 00011110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1409,6 +1832,11 @@ VPABSD AVX 00011110 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 1E /r: VPABSD ymm1, ymm2/m256
+VPABSD AVX2 00011110 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 38 08 /r: PSIGNB mm1, mm2/m64
 PSIGNB_mm SSSE3 00001111 00111000 00001000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1424,6 +1852,11 @@ VPSIGNB AVX 00001000 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 08 /r: VPSIGNB ymm1, ymm2, ymm3/m256
+VPSIGNB AVX2 00001000 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 38 09 /r: PSIGNW mm1, mm2/m64
 PSIGNW_mm SSSE3 00001111 00111000 00001001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1439,6 +1872,11 @@ VPSIGNW AVX 00001001 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 09 /r: VPSIGNW ymm1, ymm2, ymm3/m256
+VPSIGNW AVX2 00001001 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 38 0A /r: PSIGND mm1, mm2/m64
 PSIGND_mm SSSE3 00001111 00111000 00001010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1454,6 +1892,11 @@ VPSIGND AVX 00001010 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 0A /r: VPSIGND ymm1, ymm2, ymm3/m256
+VPSIGND AVX2 00001010 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 3A 40 /r ib: DPPS xmm1, xmm2/m128, imm8
 DPPS SSE4_1 00001111 00111010 01000000 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
@@ -1464,6 +1907,11 @@ VDPPS AVX 01000000 \
   !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F3A.WIG 40 /r ib: VDPPS ymm1, ymm2, ymm3/m256, imm8
+VDPPS AVX2 01000000 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 3A 41 /r ib: DPPD xmm1, xmm2/m128, imm8
 DPPD SSE4_1 00001111 00111010 01000001 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
@@ -1484,6 +1932,11 @@ VROUNDPS AVX 00001000 \
   !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F3A.WIG 08 /r ib: VROUNDPS ymm1, ymm2/m256, imm8
+VROUNDPS AVX2 00001000 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 3A 09 /r ib: ROUNDPD xmm1, xmm2/m128, imm8
 ROUNDPD SSE4_1 00001111 00111010 00001001 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
@@ -1494,6 +1947,11 @@ VROUNDPD AVX 00001001 \
   !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F3A.WIG 09 /r ib: VROUNDPD ymm1, ymm2/m256, imm8
+VROUNDPD AVX2 00001001 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 3A 0A /r ib: ROUNDSS xmm1, xmm2/m32, imm8
 ROUNDSS SSE4_1 00001111 00111010 00001010 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
@@ -1614,6 +2072,11 @@ VPCMPEQB AVX 01110100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 74 /r: VPCMPEQB ymm1,ymm2,ymm3/m256
+VPCMPEQB AVX2 01110100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 75 /r: PCMPEQW mm,mm/m64
 PCMPEQW MMX 00001111 01110101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1629,6 +2092,11 @@ VPCMPEQW AVX 01110101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 75 /r: VPCMPEQW ymm1,ymm2,ymm3/m256
+VPCMPEQW AVX2 01110101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 76 /r: PCMPEQD mm,mm/m64
 PCMPEQD MMX 00001111 01110110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1644,6 +2112,11 @@ VPCMPEQD AVX 01110110 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 76 /r: VPCMPEQD ymm1,ymm2,ymm3/m256
+VPCMPEQD AVX2 01110110 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 29 /r: PCMPEQQ xmm1, xmm2/m128
 PCMPEQQ SSE4_1 00001111 00111000 00101001 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1654,6 +2127,11 @@ VPCMPEQQ AVX 00101001 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 29 /r: VPCMPEQQ ymm1, ymm2, ymm3/m256
+VPCMPEQQ AVX2 00101001 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 64 /r: PCMPGTB mm,mm/m64
 PCMPGTB MMX 00001111 01100100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1669,6 +2147,11 @@ VPCMPGTB AVX 01100100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 64 /r: VPCMPGTB ymm1,ymm2,ymm3/m256
+VPCMPGTB AVX2 01100100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 65 /r: PCMPGTW mm,mm/m64
 PCMPGTW MMX 00001111 01100101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1684,6 +2167,11 @@ VPCMPGTW AVX 01100101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 65 /r: VPCMPGTW ymm1,ymm2,ymm3/m256
+VPCMPGTW AVX2 01100101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 66 /r: PCMPGTD mm,mm/m64
 PCMPGTD MMX 00001111 01100110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1699,6 +2187,11 @@ VPCMPGTD AVX 01100110 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 66 /r: VPCMPGTD ymm1,ymm2,ymm3/m256
+VPCMPGTD AVX2 01100110 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 37 /r: PCMPGTQ xmm1,xmm2/m128
 PCMPGTQ SSE4_2 00001111 00111000 00110111 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1709,6 +2202,11 @@ VPCMPGTQ AVX 00110111 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 37 /r: VPCMPGTQ ymm1, ymm2, ymm3/m256
+VPCMPGTQ AVX2 00110111 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 3A 60 /r imm8: PCMPESTRM xmm1, xmm2/m128, imm8
 PCMPESTRM SSE4_2 00001111 00111010 01100000 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
@@ -1759,16 +2257,31 @@ VPTEST AVX 00010111 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 17 /r: VPTEST ymm1, ymm2/m256
+VPTEST AVX2 00010111 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # VEX.128.66.0F38.W0 0E /r: VTESTPS xmm1, xmm2/m128
 VTESTPS AVX 00001110 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.W0 0E /r: VTESTPS ymm1, ymm2/m256
+VTESTPS AVX2 00001110 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # VEX.128.66.0F38.W0 0F /r: VTESTPD xmm1, xmm2/m128
 VTESTPD AVX 00001111 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.W0 0F /r: VTESTPD ymm1, ymm2/m256
+VTESTPD AVX2 00001111 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F C2 /r ib: CMPPS xmm1, xmm2/m128, imm8
 CMPPS SSE 00001111 11000010 \
   !constraints { modrm($_); imm($_, width => 8); 1 } \
@@ -1779,6 +2292,11 @@ VCMPPS AVX 11000010 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG C2 /r ib: VCMPPS ymm1, ymm2, ymm3/m256, imm8
+VCMPPS AVX2 11000010 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F C2 /r ib: CMPPD xmm1, xmm2/m128, imm8
 CMPPD SSE2 00001111 11000010 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
@@ -1789,6 +2307,11 @@ VCMPPD AVX 11000010 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG C2 /r ib: VCMPPD ymm1, ymm2, ymm3/m256, imm8
+VCMPPD AVX2 11000010 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F C2 /r ib: CMPSS xmm1, xmm2/m32, imm8
 CMPSS SSE 00001111 11000010 \
   !constraints { rep($_); modrm($_); imm($_, width => 8); 1 } \
@@ -1869,6 +2392,11 @@ VPAND AVX 11011011 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG DB /r: VPAND ymm1, ymm2, ymm3/m256
+VPAND AVX2 11011011 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 54 /r: ANDPS xmm1, xmm2/m128
 ANDPS SSE 00001111 01010100 \
   !constraints { modrm($_); 1 } \
@@ -1879,6 +2407,11 @@ VANDPS AVX 01010100 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F 54 /r: VANDPS ymm1, ymm2, ymm3/m256
+VANDPS AVX2 01010100 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 54 /r: ANDPD xmm1, xmm2/m128
 ANDPD SSE2 00001111 01010100 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1889,6 +2422,11 @@ VANDPD AVX 01010100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F 54 /r: VANDPD ymm1, ymm2, ymm3/m256
+VANDPD AVX2 01010100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F DF /r: PANDN mm, mm/m64
 PANDN MMX 00001111 11011111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1904,6 +2442,11 @@ VPANDN AVX 11011111 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG DF /r: VPANDN ymm1, ymm2, ymm3/m256
+VPANDN AVX2 11011111 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 55 /r: ANDNPS xmm1, xmm2/m128
 ANDNPS SSE 00001111 01010101 \
   !constraints { modrm($_); 1 } \
@@ -1914,6 +2457,11 @@ VANDNPS AVX 01010101 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F 55 /r: VANDNPS ymm1, ymm2, ymm3/m256
+VANDNPS AVX2 01010101 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 55 /r: ANDNPD xmm1, xmm2/m128
 ANDNPD SSE2 00001111 01010101 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1924,6 +2472,11 @@ VANDNPD AVX 01010101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F 55 /r: VANDNPD ymm1, ymm2, ymm3/m256
+VANDNPD AVX2 01010101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F EB /r: POR mm, mm/m64
 POR MMX 00001111 11101011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1939,6 +2492,11 @@ VPOR AVX 11101011 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG EB /r: VPOR ymm1, ymm2, ymm3/m256
+VPOR AVX2 11101011 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 56 /r: ORPS xmm1, xmm2/m128
 ORPS SSE 00001111 01010110 \
   !constraints { modrm($_); 1 } \
@@ -1949,6 +2507,11 @@ VORPS AVX 01010110 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F 56 /r: VORPS ymm1, ymm2, ymm3/m256
+VORPS AVX2 01010110 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 56 /r: ORPD xmm1, xmm2/m128
 ORPD SSE2 00001111 01010110 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1959,6 +2522,11 @@ VORPD AVX 01010110 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F 56 /r: VORPD ymm1, ymm2, ymm3/m256
+VORPD AVX2 01010110 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F EF /r: PXOR mm, mm/m64
 PXOR MMX 00001111 11101111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1974,6 +2542,11 @@ VPXOR AVX 11101111 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG EF /r: VPXOR ymm1, ymm2, ymm3/m256
+VPXOR AVX2 11101111 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 57 /r: XORPS xmm1, xmm2/m128
 XORPS SSE 00001111 01010111 \
   !constraints { modrm($_); 1 } \
@@ -1984,6 +2557,11 @@ VXORPS AVX 01010111 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG 57 /r: VXORPS ymm1, ymm2, ymm3/m256
+VXORPS AVX2 01010111 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 57 /r: XORPD xmm1, xmm2/m128
 XORPD SSE2 00001111 01010111 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -1994,6 +2572,11 @@ VXORPD AVX 01010111 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 57 /r: VXORPD ymm1, ymm2, ymm3/m256
+VXORPD AVX2 01010111 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 #
 # Shift and Rotate Instructions
 # -----------------------------
@@ -2014,6 +2597,11 @@ VPSLLW AVX 11110001 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG F1 /r: VPSLLW ymm1, ymm2, xmm3/m128
+VPSLLW AVX2 11110001 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F F2 /r: PSLLD mm, mm/m64
 PSLLD MMX 00001111 11110010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2029,6 +2617,11 @@ VPSLLD AVX 11110010 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG F2 /r: VPSLLD ymm1, ymm2, xmm3/m128
+VPSLLD AVX2 11110010 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F F3 /r: PSLLQ mm, mm/m64
 PSLLQ MMX 00001111 11110011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2044,6 +2637,11 @@ VPSLLQ AVX 11110011 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG F3 /r: VPSLLQ ymm1, ymm2, xmm3/m128
+VPSLLQ AVX2 11110011 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 71 /6 ib: PSLLW mm1, imm8
 PSLLW_imm MMX 00001111 01110001 \
   !constraints { modrm($_, reg => 6); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -2056,6 +2654,10 @@ PSLLW_imm SSE2 00001111 01110001 \
 VPSLLW_imm AVX 01110001 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.256.66.0F.WIG 71 /6 ib: VPSLLW ymm1, ymm2, imm8
+VPSLLW_imm AVX2 01110001 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 72 /6 ib: PSLLD mm, imm8
 PSLLD_imm MMX 00001111 01110010 \
   !constraints { modrm($_, reg => 6); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -2068,6 +2670,10 @@ PSLLD_imm SSE2 00001111 01110010 \
 VPSLLD_imm AVX 01110010 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.256.66.0F.WIG 72 /6 ib: VPSLLD ymm1, ymm2, imm8
+VPSLLD_imm AVX2 01110010 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 73 /6 ib: PSLLQ mm, imm8
 PSLLQ_imm MMX 00001111 01110011 \
   !constraints { modrm($_, reg => 6); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -2080,6 +2686,10 @@ PSLLQ_imm SSE2 00001111 01110011 \
 VPSLLQ_imm AVX 01110011 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.256.66.0F.WIG 73 /6 ib: VPSLLQ ymm1, ymm2, imm8
+VPSLLQ_imm AVX2 01110011 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # 66 0F 73 /7 ib: PSLLDQ xmm1, imm8
 PSLLDQ_imm SSE2 00001111 01110011 \
   !constraints { data16($_); modrm($_, reg => 7); imm($_, width => 8); defined $_->{modrm}{reg2} }
@@ -2088,6 +2698,30 @@ PSLLDQ_imm SSE2 00001111 01110011 \
 VPSLLDQ_imm AVX 01110011 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 7); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.256.66.0F.WIG 73 /7 ib: VPSLLDQ ymm1, ymm2, imm8
+VPSLLDQ_imm AVX2 01110011 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_, reg => 7); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
+# VEX.128.66.0F38.W0 47 /r: VPSLLVD xmm1, xmm2, xmm3/m128
+VPSLLVD_xmm AVX2 01000111 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
+# VEX.256.66.0F38.W0 47 /r: VPSLLVD ymm1, ymm2, ymm3/m256
+VPSLLVD AVX2 01000111 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
+# VEX.128.66.0F38.W1 47 /r: VPSLLVQ xmm1, xmm2, xmm3/m128
+VPSLLVQ_xmm AVX2 01000111 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 1); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
+# VEX.256.66.0F38.W1 47 /r: VPSLLVQ ymm1, ymm2, ymm3/m256
+VPSLLVQ AVX2 01000111 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 1); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F D1 /r: PSRLW mm, mm/m64
 PSRLW MMX 00001111 11010001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2103,6 +2737,11 @@ VPSRLW AVX 11010001 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG D1 /r: VPSRLW ymm1, ymm2, xmm3/m128
+VPSRLW AVX2 11010001 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F D2 /r: PSRLD mm, mm/m64
 PSRLD MMX 00001111 11010010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2118,6 +2757,11 @@ VPSRLD AVX 11010010 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG D2 /r: VPSRLD ymm1, ymm2, xmm3/m128
+VPSRLD AVX2 11010010 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F D3 /r: PSRLQ mm, mm/m64
 PSRLQ MMX 00001111 11010011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2133,6 +2777,11 @@ VPSRLQ AVX 11010011 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG D3 /r: VPSRLQ ymm1, ymm2, xmm3/m128
+VPSRLQ AVX2 11010011 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 71 /2 ib: PSRLW mm, imm8
 PSRLW_imm MMX 00001111 01110001 \
   !constraints { modrm($_, reg => 2); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -2145,6 +2794,10 @@ PSRLW_imm SSE2 00001111 01110001 \
 VPSRLW_imm AVX 01110001 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.256.66.0F.WIG 71 /2 ib: VPSRLW ymm1, ymm2, imm8
+VPSRLW_imm AVX2 01110001 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 72 /2 ib: PSRLD mm, imm8
 PSRLD_imm MMX 00001111 01110010 \
   !constraints { modrm($_, reg => 2); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -2157,6 +2810,10 @@ PSRLD_imm SSE2 00001111 01110010 \
 VPSRLD_imm AVX 01110010 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.256.66.0F.WIG 72 /2 ib: VPSRLD ymm1, ymm2, imm8
+VPSRLD_imm AVX2 01110010 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 73 /2 ib: PSRLQ mm, imm8
 PSRLQ_imm MMX 00001111 01110011 \
   !constraints { modrm($_, reg => 2); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -2169,6 +2826,10 @@ PSRLQ_imm SSE2 00001111 01110011 \
 VPSRLQ_imm AVX 01110011 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.256.66.0F.WIG 73 /2 ib: VPSRLQ ymm1, ymm2, imm8
+VPSRLQ_imm AVX2 01110011 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # 66 0F 73 /3 ib: PSRLDQ xmm1, imm8
 PSRLDQ_imm SSE2 00001111 01110011 \
   !constraints { data16($_); modrm($_, reg => 3); imm($_, width => 8); defined $_->{modrm}{reg2} }
@@ -2177,6 +2838,30 @@ PSRLDQ_imm SSE2 00001111 01110011 \
 VPSRLDQ_imm AVX 01110011 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 3); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.256.66.0F.WIG 73 /3 ib: VPSRLDQ ymm1, ymm2, imm8
+VPSRLDQ_imm AVX2 01110011 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_, reg => 3); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
+# VEX.128.66.0F38.W0 45 /r: VPSRLVD xmm1, xmm2, xmm3/m128
+VPSRLVD_xmm AVX2 01000101 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
+# VEX.256.66.0F38.W0 45 /r: VPSRLVD ymm1, ymm2, ymm3/m256
+VPSRLVD AVX2 01000101 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
+# VEX.128.66.0F38.W1 45 /r: VPSRLVQ xmm1, xmm2, xmm3/m128
+VPSRLVQ_xmm AVX2 01000101 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 1); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
+# VEX.256.66.0F38.W1 45 /r: VPSRLVQ ymm1, ymm2, ymm3/m256
+VPSRLVQ AVX2 01000101 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 1); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F E1 /r: PSRAW mm,mm/m64
 PSRAW MMX 00001111 11100001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2192,6 +2877,11 @@ VPSRAW AVX 11100001 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG E1 /r: VPSRAW ymm1,ymm2,xmm3/m128
+VPSRAW AVX2 11100001 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F E2 /r: PSRAD mm,mm/m64
 PSRAD MMX 00001111 11100010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2207,6 +2897,11 @@ VPSRAD AVX 11100010 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG E2 /r: VPSRAD ymm1,ymm2,xmm3/m128
+VPSRAD AVX2 11100010 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 71 /4 ib: PSRAW mm,imm8
 PSRAW_imm MMX 00001111 01110001 \
   !constraints { modrm($_, reg => 4); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -2219,6 +2914,10 @@ PSRAW_imm SSE2 00001111 01110001 \
 VPSRAW_imm AVX 01110001 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 4); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.256.66.0F.WIG 71 /4 ib: VPSRAW ymm1,ymm2,imm8
+VPSRAW_imm AVX2 01110001 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_, reg => 4); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 72 /4 ib: PSRAD mm,imm8
 PSRAD_imm MMX 00001111 01110010 \
   !constraints { modrm($_, reg => 4); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -2231,6 +2930,20 @@ PSRAD_imm SSE2 00001111 01110010 \
 VPSRAD_imm AVX 01110010 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 4); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.256.66.0F.WIG 72 /4 ib: VPSRAD ymm1,ymm2,imm8
+VPSRAD_imm AVX2 01110010 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_, reg => 4); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
+# VEX.128.66.0F38.W0 46 /r: VPSRAVD xmm1, xmm2, xmm3/m128
+VPSRAVD_xmm AVX2 01000110 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
+# VEX.256.66.0F38.W0 46 /r: VPSRAVD ymm1, ymm2, ymm3/m256
+VPSRAVD AVX2 01000110 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 3A 0F /r ib: PALIGNR mm1, mm2/m64, imm8
 PALIGNR_mm SSSE3 00001111 00111010 00001111 \
   !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2246,6 +2959,11 @@ VPALIGNR AVX 00001111 \
   !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F3A.WIG 0F /r ib: VPALIGNR ymm1, ymm2, ymm3/m256, imm8
+VPALIGNR AVX2 00001111 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 #
 # Shuffle, Unpack, Blend, Insert, Extract, Broadcast, Permute, Gather Instructions
 # --------------------------------------------------------------------------------
@@ -2266,6 +2984,11 @@ VPACKSSWB AVX 01100011 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 63 /r: VPACKSSWB ymm1, ymm2, ymm3/m256
+VPACKSSWB AVX2 01100011 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 6B /r: PACKSSDW mm1, mm2/m64
 PACKSSDW MMX 00001111 01101011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2281,6 +3004,11 @@ VPACKSSDW AVX 01101011 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 6B /r: VPACKSSDW ymm1, ymm2, ymm3/m256
+VPACKSSDW AVX2 01101011 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 67 /r: PACKUSWB mm, mm/m64
 PACKUSWB MMX 00001111 01100111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2296,6 +3024,11 @@ VPACKUSWB AVX 01100111 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 67 /r: VPACKUSWB ymm1, ymm2, ymm3/m256
+VPACKUSWB AVX2 01100111 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 2B /r: PACKUSDW xmm1, xmm2/m128
 PACKUSDW SSE4_1 00001111 00111000 00101011 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2306,6 +3039,11 @@ VPACKUSDW AVX 00101011 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38 2B /r: VPACKUSDW ymm1, ymm2, ymm3/m256
+VPACKUSDW AVX2 00101011 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 68 /r: PUNPCKHBW mm, mm/m64
 PUNPCKHBW MMX 00001111 01101000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2321,6 +3059,11 @@ VPUNPCKHBW AVX 01101000 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 68 /r: VPUNPCKHBW ymm1, ymm2, ymm3/m256
+VPUNPCKHBW AVX2 01101000 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 69 /r: PUNPCKHWD mm, mm/m64
 PUNPCKHWD MMX 00001111 01101001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2336,6 +3079,11 @@ VPUNPCKHWD AVX 01101001 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 69 /r: VPUNPCKHWD ymm1, ymm2, ymm3/m256
+VPUNPCKHWD AVX2 01101001 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 6A /r: PUNPCKHDQ mm, mm/m64
 PUNPCKHDQ MMX 00001111 01101010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2351,6 +3099,11 @@ VPUNPCKHDQ AVX 01101010 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 6A /r: VPUNPCKHDQ ymm1, ymm2, ymm3/m256
+VPUNPCKHDQ AVX2 01101010 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 6D /r: PUNPCKHQDQ xmm1, xmm2/m128
 PUNPCKHQDQ SSE2 00001111 01101101 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2361,6 +3114,11 @@ VPUNPCKHQDQ AVX 01101101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 6D /r: VPUNPCKHQDQ ymm1, ymm2, ymm3/m256
+VPUNPCKHQDQ AVX2 01101101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 60 /r: PUNPCKLBW mm, mm/m32
 PUNPCKLBW MMX 00001111 01100000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2376,6 +3134,11 @@ VPUNPCKLBW AVX 01100000 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 60 /r: VPUNPCKLBW ymm1, ymm2, ymm3/m256
+VPUNPCKLBW AVX2 01100000 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 61 /r: PUNPCKLWD mm, mm/m32
 PUNPCKLWD MMX 00001111 01100001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2391,6 +3154,11 @@ VPUNPCKLWD AVX 01100001 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 61 /r: VPUNPCKLWD ymm1, ymm2, ymm3/m256
+VPUNPCKLWD AVX2 01100001 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 62 /r: PUNPCKLDQ mm, mm/m32
 PUNPCKLDQ MMX 00001111 01100010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2406,6 +3174,11 @@ VPUNPCKLDQ AVX 01100010 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 62 /r: VPUNPCKLDQ ymm1, ymm2, ymm3/m256
+VPUNPCKLDQ AVX2 01100010 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 6C /r: PUNPCKLQDQ xmm1, xmm2/m128
 PUNPCKLQDQ SSE2 00001111 01101100 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2416,6 +3189,11 @@ VPUNPCKLQDQ AVX 01101100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 6C /r: VPUNPCKLQDQ ymm1, ymm2, ymm3/m256
+VPUNPCKLQDQ AVX2 01101100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 14 /r: UNPCKLPS xmm1, xmm2/m128
 UNPCKLPS SSE 00001111 00010100 \
   !constraints { modrm($_); 1 } \
@@ -2426,6 +3204,11 @@ VUNPCKLPS AVX 00010100 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG 14 /r: VUNPCKLPS ymm1,ymm2,ymm3/m256
+VUNPCKLPS AVX2 00010100 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 14 /r: UNPCKLPD xmm1, xmm2/m128
 UNPCKLPD SSE2 00001111 00010100 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2436,6 +3219,11 @@ VUNPCKLPD AVX 00010100 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 14 /r: VUNPCKLPD ymm1,ymm2, ymm3/m256
+VUNPCKLPD AVX2 00010100 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 15 /r: UNPCKHPS xmm1, xmm2/m128
 UNPCKHPS SSE 00001111 00010101 \
   !constraints { modrm($_); 1 } \
@@ -2446,6 +3234,11 @@ VUNPCKHPS AVX 00010101 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG 15 /r: VUNPCKHPS ymm1, ymm2, ymm3/m256
+VUNPCKHPS AVX2 00010101 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 15 /r: UNPCKHPD xmm1, xmm2/m128
 UNPCKHPD SSE2 00001111 00010101 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2456,6 +3249,11 @@ VUNPCKHPD AVX 00010101 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 15 /r: VUNPCKHPD ymm1,ymm2, ymm3/m256
+VUNPCKHPD AVX2 00010101 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 38 00 /r: PSHUFB mm1, mm2/m64
 PSHUFB_mm SSSE3 00001111 00111000 00000000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2471,6 +3269,11 @@ VPSHUFB AVX 00000000 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.WIG 00 /r: VPSHUFB ymm1, ymm2, ymm3/m256
+VPSHUFB AVX2 00000000 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F 70 /r ib: PSHUFW mm1, mm2/m64, imm8
 PSHUFW SSE 00001111 01110000 \
   !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -2486,6 +3289,11 @@ VPSHUFLW AVX 01110000 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF2); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.F2.0F.WIG 70 /r ib: VPSHUFLW ymm1, ymm2/m256, imm8
+VPSHUFLW AVX2 01110000 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0xF2); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F 70 /r ib: PSHUFHW xmm1, xmm2/m128, imm8
 PSHUFHW SSE2 00001111 01110000 \
   !constraints { rep($_); modrm($_); imm($_, width => 8); 1 } \
@@ -2496,6 +3304,11 @@ VPSHUFHW AVX 01110000 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF3); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.F3.0F.WIG 70 /r ib: VPSHUFHW ymm1, ymm2/m256, imm8
+VPSHUFHW AVX2 01110000 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0xF3); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 70 /r ib: PSHUFD xmm1, xmm2/m128, imm8
 PSHUFD SSE2 00001111 01110000 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
@@ -2506,6 +3319,11 @@ VPSHUFD AVX 01110000 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 70 /r ib: VPSHUFD ymm1, ymm2/m256, imm8
+VPSHUFD AVX2 01110000 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # NP 0F C6 /r ib: SHUFPS xmm1, xmm3/m128, imm8
 SHUFPS SSE 00001111 11000110 \
   !constraints { modrm($_); imm($_, width => 8); 1 } \
@@ -2516,6 +3334,11 @@ VSHUFPS AVX 11000110 \
   !constraints { vex($_, m => 0x0F, l => 128); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG C6 /r ib: VSHUFPS ymm1, ymm2, ymm3/m256, imm8
+VSHUFPS AVX2 11000110 \
+  !constraints { vex($_, m => 0x0F, l => 256); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F C6 /r ib: SHUFPD xmm1, xmm2/m128, imm8
 SHUFPD SSE2 00001111 11000110 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
@@ -2526,6 +3349,11 @@ VSHUFPD AVX 11000110 \
   !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG C6 /r ib: VSHUFPD ymm1, ymm2, ymm3/m256, imm8
+VSHUFPD AVX2 11000110 \
+  !constraints { vex($_, m => 0x0F, l => 256, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 3A 0C /r ib: BLENDPS xmm1, xmm2/m128, imm8
 BLENDPS SSE4_1 00001111 00111010 00001100 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
@@ -2536,6 +3364,11 @@ VBLENDPS AVX 00001100 \
   !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F3A.WIG 0C /r ib: VBLENDPS ymm1, ymm2, ymm3/m256, imm8
+VBLENDPS AVX2 00001100 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 3A 0D /r ib: BLENDPD xmm1, xmm2/m128, imm8
 BLENDPD SSE4_1 00001111 00111010 00001101 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
@@ -2546,6 +3379,11 @@ VBLENDPD AVX 00001101 \
   !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F3A.WIG 0D /r ib: VBLENDPD ymm1, ymm2, ymm3/m256, imm8
+VBLENDPD AVX2 00001101 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 14 /r: BLENDVPS xmm1, xmm2/m128, <XMM0>
 BLENDVPS SSE4_1 00001111 00111000 00010100 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2556,6 +3394,11 @@ VBLENDVPS AVX 01001010 \
   !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F3A.W0 4A /r /is4: VBLENDVPS ymm1, ymm2, ymm3/m256, ymm4
+VBLENDVPS AVX2 01001010 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 15 /r: BLENDVPD xmm1, xmm2/m128 , <XMM0>
 BLENDVPD SSE4_1 00001111 00111000 00010101 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2566,6 +3409,11 @@ VBLENDVPD AVX 01001011 \
   !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F3A.W0 4B /r /is4: VBLENDVPD ymm1, ymm2, ymm3/m256, ymm4
+VBLENDVPD AVX2 01001011 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 38 10 /r: PBLENDVB xmm1, xmm2/m128, <XMM0>
 PBLENDVB SSE4_1 00001111 00111000 00010000 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2576,6 +3424,11 @@ VPBLENDVB AVX 01001100 \
   !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F3A.W0 4C /r /is4: VPBLENDVB ymm1, ymm2, ymm3/m256, ymm4
+VPBLENDVB AVX2 01001100 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 3A 0E /r ib: PBLENDW xmm1, xmm2/m128, imm8
 PBLENDW SSE4_1 00001111 00111010 00001110 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
@@ -2586,6 +3439,21 @@ VPBLENDW AVX 00001110 \
   !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F3A.WIG 0E /r ib: VPBLENDW ymm1, ymm2, ymm3/m256, imm8
+VPBLENDW AVX2 00001110 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
+# VEX.128.66.0F3A.W0 02 /r ib: VPBLENDD xmm1, xmm2, xmm3/m128, imm8
+VPBLENDD_xmm AVX2 00000010 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
+# VEX.256.66.0F3A.W0 02 /r ib: VPBLENDD ymm1, ymm2, ymm3/m256, imm8
+VPBLENDD AVX2 00000010 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 3A 21 /r ib: INSERTPS xmm1, xmm2/m32, imm8
 INSERTPS SSE4_1 00001111 00111010 00100001 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
@@ -2641,6 +3509,16 @@ VPINSRQ AVX 00100010 \
   !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66, w => 1); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { load(size => 8); }
 
+# VEX.256.66.0F3A.W0 18 /r ib: VINSERTF128 ymm1, ymm2, xmm3/m128, imm8
+VINSERTF128 AVX2 00011000 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
+# VEX.256.66.0F3A.W0 38 /r ib: VINSERTI128 ymm1, ymm2, xmm3/m128, imm8
+VINSERTI128 AVX2 00111000 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 17 /r ib: EXTRACTPS reg/m32, xmm1, imm8
 EXTRACTPS SSE4_1 00001111 00111010 00010111 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
@@ -2703,26 +3581,231 @@ PEXTRW_reg SSE2 00001111 11000101 \
 VPEXTRW_reg AVX 11000101 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66, w => 0); modrm($_); imm($_, width => 8); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
 
+# VEX.256.66.0F3A.W0 19 /r ib: VEXTRACTF128 xmm1/m128, ymm2, imm8
+VEXTRACTF128 AVX2 00011001 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, v => 0, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { store(size => 16); }
+
+# VEX.256.66.0F3A.W0 39 /r ib: VEXTRACTI128 xmm1/m128, ymm2, imm8
+VEXTRACTI128 AVX2 00111001 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, v => 0, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { store(size => 16); }
+
+# VEX.128.66.0F38.W0 78 /r: VPBROADCASTB xmm1,xmm2/m8
+VPBROADCASTB_xmm AVX2 01111000 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 1); }
+
+# VEX.256.66.0F38.W0 78 /r: VPBROADCASTB ymm1,xmm2/m8
+VPBROADCASTB AVX2 01111000 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 1); }
+
+# VEX.128.66.0F38.W0 79 /r: VPBROADCASTW xmm1,xmm2/m16
+VPBROADCASTW_xmm AVX2 01111001 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 2); }
+
+# VEX.256.66.0F38.W0 79 /r: VPBROADCASTW ymm1,xmm2/m16
+VPBROADCASTW AVX2 01111001 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 2); }
+
+# VEX.128.66.0F38.W0 58 /r: VPBROADCASTD xmm1,xmm2/m32
+VPBROADCASTD_xmm AVX2 01011000 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# VEX.256.66.0F38.W0 58 /r: VPBROADCASTD ymm1,xmm2/m32
+VPBROADCASTD AVX2 01011000 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# VEX.128.66.0F38.W0 59 /r: VPBROADCASTQ xmm1,xmm2/m64
+VPBROADCASTQ_xmm AVX2 01011001 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
+# VEX.256.66.0F38.W0 59 /r: VPBROADCASTQ ymm1,xmm2/m64
+VPBROADCASTQ AVX2 01011001 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
+# VEX.128.66.0F38.W0 18 /r: VBROADCASTSS xmm1, xmm2/m32
+VBROADCASTSS_xmm AVX2 00011000 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# VEX.256.66.0F38.W0 18 /r: VBROADCASTSS ymm1, xmm2/m32
+VBROADCASTSS AVX2 00011000 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# VEX.256.66.0F38.W0 19 /r: VBROADCASTSD ymm1, xmm2/m64
+VBROADCASTSD AVX2 00011001 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
+# VEX.256.66.0F38.W0 1A /r: VBROADCASTF128 ymm1, m128
+VBROADCASTF128 AVX2 00011010 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66, w => 0); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 16); }
+
+# VEX.256.66.0F38.W0 5A /r: VBROADCASTI128 ymm1,m128
+VBROADCASTI128 AVX2 01011010 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66, w => 0); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 16); }
+
+# VEX.256.66.0F3A.W0 06 /r ib: VPERM2F128 ymm1, ymm2, ymm3/m256, imm8
+VPERM2F128 AVX2 00000110 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
+# VEX.256.66.0F3A.W0 46 /r ib: VPERM2I128 ymm1, ymm2, ymm3/m256, imm8
+VPERM2I128 AVX2 01000110 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
+# VEX.256.66.0F38.W0 36 /r: VPERMD ymm1, ymm2, ymm3/m256
+VPERMD AVX2 00110110 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
+# VEX.256.66.0F38.W0 16 /r: VPERMPS ymm1, ymm2, ymm3/m256
+VPERMPS AVX2 00010110 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # VEX.128.66.0F38.W0 0C /r: VPERMILPS xmm1, xmm2, xmm3/m128
 VPERMILPS AVX 00001100 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.W0 0C /r: VPERMILPS ymm1, ymm2, ymm3/m256
+VPERMILPS AVX2 00001100 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # VEX.128.66.0F3A.W0 04 /r ib: VPERMILPS xmm1, xmm2/m128, imm8
 VPERMILPS_imm AVX 00000100 \
   !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F3A.W0 04 /r ib: VPERMILPS ymm1, ymm2/m256, imm8
+VPERMILPS_imm AVX2 00000100 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, v => 0, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
 # VEX.128.66.0F38.W0 0D /r: VPERMILPD xmm1, xmm2, xmm3/m128
 VPERMILPD AVX 00001101 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F38.W0 0D /r: VPERMILPD ymm1, ymm2, ymm3/m256
+VPERMILPD AVX2 00001101 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # VEX.128.66.0F3A.W0 05 /r ib: VPERMILPD xmm1, xmm2/m128, imm8
 VPERMILPD_imm AVX 00000101 \
   !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F3A.W0 05 /r ib: VPERMILPD ymm1, ymm2/m256, imm8
+VPERMILPD_imm AVX2 00000101 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, v => 0, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
+# VEX.256.66.0F3A.W1 00 /r ib: VPERMQ ymm1, ymm2/m256, imm8
+VPERMQ AVX2 00000000 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, v => 0, p => 0x66, w => 1); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
+# VEX.256.66.0F3A.W1 01 /r ib: VPERMPD ymm1, ymm2/m256, imm8
+VPERMPD AVX2 00000001 \
+  !constraints { vex($_, m => 0x0F3A, l => 256, v => 0, p => 0x66, w => 1); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 32); }
+
+# VEX.128.66.0F38.W0 92 /r: VGATHERDPS xmm1, vm32x, xmm2
+VGATHERDPS_xmm AVX2 10010010 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 4, addrw => 32, count => 4); }
+
+# VEX.256.66.0F38.W0 92 /r: VGATHERDPS ymm1, vm32y, ymm2
+VGATHERDPS AVX2 10010010 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 4, addrw => 32, count => 8); }
+
+# VEX.128.66.0F38.W1 92 /r: VGATHERDPD xmm1, vm32x, xmm2
+VGATHERDPD_xmm AVX2 10010010 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 1); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 8, addrw => 32, count => 4); }
+
+# VEX.256.66.0F38.W1 92 /r: VGATHERDPD ymm1, vm32x, ymm2
+VGATHERDPD AVX2 10010010 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 1); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 8, addrw => 32, count => 4); }
+
+# VEX.128.66.0F38.W0 93 /r: VGATHERQPS xmm1, vm64x, xmm2
+VGATHERQPS_xmm AVX2 10010011 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 4, addrw => 64, count => 2); }
+
+# VEX.256.66.0F38.W0 93 /r: VGATHERQPS xmm1, vm64y, xmm2
+VGATHERQPS AVX2 10010011 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 4, addrw => 64, count => 4); }
+
+# VEX.128.66.0F38.W1 93 /r: VGATHERQPD xmm1, vm64x, xmm2
+VGATHERQPD_xmm AVX2 10010011 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 1); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 8, addrw => 64, count => 2); }
+
+# VEX.256.66.0F38.W1 93 /r: VGATHERQPD ymm1, vm64y, ymm2
+VGATHERQPD AVX2 10010011 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 1); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 8, addrw => 64, count => 4); }
+
+# VEX.128.66.0F38.W0 90 /r: VPGATHERDD xmm1, vm32x, xmm2
+VPGATHERDD_xmm AVX2 10010000 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 4, addrw => 32, count => 4); }
+
+# VEX.256.66.0F38.W0 90 /r: VPGATHERDD ymm1, vm32y, ymm2
+VPGATHERDD AVX2 10010000 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 4, addrw => 32, count => 8); }
+
+# VEX.128.66.0F38.W1 90 /r: VPGATHERDQ xmm1, vm32x, xmm2
+VPGATHERDQ_xmm AVX2 10010000 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 1); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 8, addrw => 32, count => 4); }
+
+# VEX.256.66.0F38.W1 90 /r: VPGATHERDQ ymm1, vm32x, ymm2
+VPGATHERDQ AVX2 10010000 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 1); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 8, addrw => 32, count => 4); }
+
+# VEX.128.66.0F38.W0 91 /r: VPGATHERQD xmm1, vm64x, xmm2
+VPGATHERQD_xmm AVX2 10010001 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 4, addrw => 64, count => 2); }
+
+# VEX.256.66.0F38.W0 91 /r: VPGATHERQD xmm1, vm64y, xmm2
+VPGATHERQD AVX2 10010001 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 4, addrw => 64, count => 4); }
+
+# VEX.128.66.0F38.W1 91 /r: VPGATHERQQ xmm1, vm64x, xmm2
+VPGATHERQQ_xmm AVX2 10010001 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 1); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 8, addrw => 64, count => 2); }
+
+# VEX.256.66.0F38.W1 91 /r: VPGATHERQQ ymm1, vm64y, ymm2
+VPGATHERQQ AVX2 10010001 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 1); modrm_vsib($_); defined $_->{modrm}{vindex} && $_->{vex}{v} != $_->{modrm}{reg} && $_->{vex}{v} != $_->{modrm}{vindex} && $_->{modrm}{reg} != $_->{modrm}{vindex} } \
+  !memory { load(size => 8, addrw => 64, count => 4); }
+
 #
 # Conversion Instructions
 # -----------------------
@@ -2738,6 +3821,11 @@ VPMOVSXBW AVX 00100000 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.256.66.0F38.WIG 20 /r: VPMOVSXBW ymm1, xmm2/m128
+VPMOVSXBW AVX2 00100000 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0f 38 21 /r: PMOVSXBD xmm1, xmm2/m32
 PMOVSXBD SSE4_1 00001111 00111000 00100001 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2748,6 +3836,11 @@ VPMOVSXBD AVX 00100001 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.256.66.0F38.WIG 21 /r: VPMOVSXBD ymm1, xmm2/m64
+VPMOVSXBD AVX2 00100001 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # 66 0f 38 22 /r: PMOVSXBQ xmm1, xmm2/m16
 PMOVSXBQ SSE4_1 00001111 00111000 00100010 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2758,6 +3851,11 @@ VPMOVSXBQ AVX 00100010 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 2); }
 
+# VEX.256.66.0F38.WIG 22 /r: VPMOVSXBQ ymm1, xmm2/m32
+VPMOVSXBQ AVX2 00100010 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # 66 0f 38 23 /r: PMOVSXWD xmm1, xmm2/m64
 PMOVSXWD SSE4_1 00001111 00111000 00100011 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2768,6 +3866,11 @@ VPMOVSXWD AVX 00100011 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.256.66.0F38.WIG 23 /r: VPMOVSXWD ymm1, xmm2/m128
+VPMOVSXWD AVX2 00100011 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0f 38 24 /r: PMOVSXWQ xmm1, xmm2/m32
 PMOVSXWQ SSE4_1 00001111 00111000 00100100 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2778,6 +3881,11 @@ VPMOVSXWQ AVX 00100100 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.256.66.0F38.WIG 24 /r: VPMOVSXWQ ymm1, xmm2/m64
+VPMOVSXWQ AVX2 00100100 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # 66 0f 38 25 /r: PMOVSXDQ xmm1, xmm2/m64
 PMOVSXDQ SSE4_1 00001111 00111000 00100101 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2788,6 +3896,11 @@ VPMOVSXDQ AVX 00100101 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.256.66.0F38.WIG 25 /r: VPMOVSXDQ ymm1, xmm2/m128
+VPMOVSXDQ AVX2 00100101 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0f 38 30 /r: PMOVZXBW xmm1, xmm2/m64
 PMOVZXBW SSE4_1 00001111 00111000 00110000 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2798,6 +3911,11 @@ VPMOVZXBW AVX 00110000 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.256.66.0F38.WIG 30 /r: VPMOVZXBW ymm1, xmm2/m128
+VPMOVZXBW AVX2 00110000 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0f 38 31 /r: PMOVZXBD xmm1, xmm2/m32
 PMOVZXBD SSE4_1 00001111 00111000 00110001 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2808,6 +3926,11 @@ VPMOVZXBD AVX 00110001 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.256.66.0F38.WIG 31 /r: VPMOVZXBD ymm1, xmm2/m64
+VPMOVZXBD AVX2 00110001 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # 66 0f 38 32 /r: PMOVZXBQ xmm1, xmm2/m16
 PMOVZXBQ SSE4_1 00001111 00111000 00110010 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2818,6 +3941,11 @@ VPMOVZXBQ AVX 00110010 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 2); }
 
+# VEX.256.66.0F38.WIG 32 /r: VPMOVZXBQ ymm1, xmm2/m32
+VPMOVZXBQ AVX2 00110010 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # 66 0f 38 33 /r: PMOVZXWD xmm1, xmm2/m64
 PMOVZXWD SSE4_1 00001111 00111000 00110011 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2828,6 +3956,11 @@ VPMOVZXWD AVX 00110011 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.256.66.0F38.WIG 33 /r: VPMOVZXWD ymm1, xmm2/m128
+VPMOVZXWD AVX2 00110011 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0f 38 34 /r: PMOVZXWQ xmm1, xmm2/m32
 PMOVZXWQ SSE4_1 00001111 00111000 00110100 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2838,6 +3971,11 @@ VPMOVZXWQ AVX 00110100 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.256.66.0F38.WIG 34 /r: VPMOVZXWQ ymm1, xmm2/m64
+VPMOVZXWQ AVX2 00110100 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # 66 0f 38 35 /r: PMOVZXDQ xmm1, xmm2/m64
 PMOVZXDQ SSE4_1 00001111 00111000 00110101 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -2848,6 +3986,11 @@ VPMOVZXDQ AVX 00110101 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.256.66.0F38.WIG 35 /r: VPMOVZXDQ ymm1, xmm2/m128
+VPMOVZXDQ AVX2 00110101 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 2A /r: CVTPI2PS xmm, mm/m64
 CVTPI2PS SSE 00001111 00101010 \
   !constraints { modrm($_); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -3008,6 +4151,11 @@ VCVTPD2DQ AVX 11100110 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF2); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.F2.0F.WIG E6 /r: VCVTPD2DQ xmm1, ymm2/m256
+VCVTPD2DQ AVX2 11100110 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F E6 /r: CVTTPD2DQ xmm1, xmm2/m128
 CVTTPD2DQ SSE2 00001111 11100110 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -3018,6 +4166,11 @@ VCVTTPD2DQ AVX 11100110 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG E6 /r: VCVTTPD2DQ xmm1, ymm2/m256
+VCVTTPD2DQ AVX2 11100110 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F E6 /r: CVTDQ2PD xmm1, xmm2/m64
 CVTDQ2PD SSE2 00001111 11100110 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -3028,6 +4181,11 @@ VCVTDQ2PD AVX 11100110 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF3); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.256.F3.0F.WIG E6 /r: VCVTDQ2PD ymm1, xmm2/m128
+VCVTDQ2PD AVX2 11100110 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 5A /r: CVTPS2PD xmm1, xmm2/m64
 CVTPS2PD SSE2 00001111 01011010 \
   !constraints { modrm($_); 1 } \
@@ -3038,6 +4196,11 @@ VCVTPS2PD AVX 01011010 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.256.0F.WIG 5A /r: VCVTPS2PD ymm1, xmm2/m128
+VCVTPS2PD AVX2 01011010 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 5A /r: CVTPD2PS xmm1, xmm2/m128
 CVTPD2PS SSE2 00001111 01011010 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -3048,6 +4211,11 @@ VCVTPD2PS AVX 01011010 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 5A /r: VCVTPD2PS xmm1, ymm2/m256
+VCVTPD2PS AVX2 01011010 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F 5A /r: CVTSS2SD xmm1, xmm2/m32
 CVTSS2SD SSE2 00001111 01011010 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -3078,6 +4246,11 @@ VCVTDQ2PS AVX 01011011 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.0F.WIG 5B /r: VCVTDQ2PS ymm1, ymm2/m256
+VCVTDQ2PS AVX2 01011011 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # 66 0F 5B /r: CVTPS2DQ xmm1, xmm2/m128
 CVTPS2DQ SSE2 00001111 01011011 \
   !constraints { data16($_); modrm($_); 1 } \
@@ -3088,6 +4261,11 @@ VCVTPS2DQ AVX 01011011 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.66.0F.WIG 5B /r: VCVTPS2DQ ymm1, ymm2/m256
+VCVTPS2DQ AVX2 01011011 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 # F3 0F 5B /r: CVTTPS2DQ xmm1, xmm2/m128
 CVTTPS2DQ SSE2 00001111 01011011 \
   !constraints { rep($_); modrm($_); 1 } \
@@ -3098,6 +4276,11 @@ VCVTTPS2DQ AVX 01011011 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF3); modrm($_); 1 } \
   !memory { load(size => 16); }
 
+# VEX.256.F3.0F.WIG 5B /r: VCVTTPS2DQ ymm1, ymm2/m256
+VCVTTPS2DQ AVX2 01011011 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 32); }
+
 #
 # Cacheability Control, Prefetch, and Instruction Ordering Instructions
 # ---------------------------------------------------------------------
@@ -3124,12 +4307,48 @@ VMASKMOVPS AVX 001011 d 0 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { $d ? store(size => 16) : load(size => 16); }
 
+# VEX.256.66.0F38.W0 2C /r: VMASKMOVPS ymm1, ymm2, m256
+# VEX.256.66.0F38.W0 2E /r: VMASKMOVPS m256, ymm1, ymm2
+VMASKMOVPS AVX2 001011 d 0 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 32) : load(size => 32); }
+
 # VEX.128.66.0F38.W0 2D /r: VMASKMOVPD xmm1, xmm2, m128
 # VEX.128.66.0F38.W0 2F /r: VMASKMOVPD m128, xmm1, xmm2
 VMASKMOVPD AVX 001011 d 1 \
   !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { $d ? store(size => 16) : load(size => 16); }
 
+# VEX.256.66.0F38.W0 2D /r: VMASKMOVPD ymm1, ymm2, m256
+# VEX.256.66.0F38.W0 2F /r: VMASKMOVPD m256, ymm1, ymm2
+VMASKMOVPD AVX2 001011 d 1 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 32) : load(size => 32); }
+
+# VEX.128.66.0F38.W0 8C /r: VPMASKMOVD xmm1, xmm2, m128
+# VEX.128.66.0F38.W0 8E /r: VPMASKMOVD m128, xmm1, xmm2
+VPMASKMOVD_xmm AVX2 100011 d 0 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 16) : load(size => 16); }
+
+# VEX.256.66.0F38.W0 8C /r: VPMASKMOVD ymm1, ymm2, m256
+# VEX.256.66.0F38.W0 8E /r: VPMASKMOVD m256, ymm1, ymm2
+VPMASKMOVD AVX2 100011 d 0 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 0); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 32) : load(size => 32); }
+
+# VEX.128.66.0F38.W1 8C /r: VPMASKMOVQ xmm1, xmm2, m128
+# VEX.128.66.0F38.W1 8E /r: VPMASKMOVQ m128, xmm1, xmm2
+VPMASKMOVQ_xmm AVX2 100011 d 0 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 1); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 16) : load(size => 16); }
+
+# VEX.256.66.0F38.W1 8C /r: VPMASKMOVQ ymm1, ymm2, m256
+# VEX.256.66.0F38.W1 8E /r: VPMASKMOVQ m256, ymm1, ymm2
+VPMASKMOVQ AVX2 100011 d 0 \
+  !constraints { vex($_, m => 0x0F38, l => 256, p => 0x66, w => 1); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 32) : load(size => 32); }
+
 # NP 0F 2B /r: MOVNTPS m128, xmm1
 MOVNTPS SSE 00001111 00101011 \
   !constraints { modrm($_); !defined $_->{modrm}{reg2} } \
@@ -3140,6 +4359,11 @@ VMOVNTPS AVX 00101011 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { store(size => 16, align => 16); }
 
+# VEX.256.0F.WIG 2B /r: VMOVNTPS m256, ymm1
+VMOVNTPS AVX2 00101011 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { store(size => 32, align => 32); }
+
 # 66 0F 2B /r: MOVNTPD m128, xmm1
 MOVNTPD SSE2 00001111 00101011 \
   !constraints { data16($_); modrm($_); !defined $_->{modrm}{reg2} } \
@@ -3150,6 +4374,11 @@ VMOVNTPD AVX 00101011 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { store(size => 16, align => 16); }
 
+# VEX.256.66.0F.WIG 2B /r: VMOVNTPD m256, ymm1
+VMOVNTPD AVX2 00101011 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0x66); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { store(size => 32, align => 32); }
+
 # NP 0F C3 /r: MOVNTI m32, r32
 MOVNTI SSE2 00001111 11000011 \
   !constraints { modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg} } \
@@ -3175,6 +4404,11 @@ VMOVNTDQ AVX 11100111 \
   !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { store(size => 16, align => 16); }
 
+# VEX.256.66.0F.WIG E7 /r: VMOVNTDQ m256, ymm1
+VMOVNTDQ AVX2 11100111 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0, p => 0x66); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { store(size => 32, align => 32); }
+
 # 66 0F 38 2A /r: MOVNTDQA xmm1, m128
 MOVNTDQA SSE4_1 00001111 00111000 00101010 \
   !constraints { data16($_); modrm($_); !defined $_->{modrm}{reg2} } \
@@ -3185,6 +4419,11 @@ VMOVNTDQA AVX 00101010 \
   !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.256.66.0F38.WIG 2A /r: VMOVNTDQA ymm1, m256
+VMOVNTDQA AVX2 00101010 \
+  !constraints { vex($_, m => 0x0F38, l => 256, v => 0, p => 0x66); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 32, align => 32); }
+
 # 0F 18 /1: PREFETCHT0 m8
 PREFETCHT0 SSE 00001111 00011000 \
   !constraints { modrm($_, reg => 1); !defined $_->{modrm}{reg2} } \
-- 
2.20.1


