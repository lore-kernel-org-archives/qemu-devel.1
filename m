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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1733AC742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C534520872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrEwspbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C534520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlheE-0005TV-Of
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40467)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdL-0001xi-Ro
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdJ-00047B-2J
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:47 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:35102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhdG-0003hl-3H
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:43 -0400
Received: by mail-yw1-xc41.google.com with SMTP id g19so3840220ywe.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qMfM6LMdYDZMdtezCn2Gp9rtfQAN2Pf/g18YxiRTC2w=;
 b=KrEwspbXds2GCzGZLUZQuZv/SqgdX+n5pXeOgrLi8QaUywY72amiquWfAwZmuOQj3T
 9NsOb/5eq2odPzFUd+YM/iuCRkBnApzBUbBKs89xvyYLhMGIxYz6AkrnjAMTKufFFW8M
 EI53PtYsbHrZnLpxeLEerQUH5QARbPajktvy5BAOBSicGQkfzGgZHxZO6hrKwks9dF28
 tvBQt0mR7Vlla30c2TTbwylILi9OlgKjgJhEssp+Aan1/pXB1p0+EM+HIiEiMYx1AYD+
 R/4c4XwXTT8Jj4rU3QpcMp2obbbL6dp4G3NcpdFD9eT/20SUHGtE56szA+Pth3hbTbfe
 G4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qMfM6LMdYDZMdtezCn2Gp9rtfQAN2Pf/g18YxiRTC2w=;
 b=iItxJ1ijVVMlKfSHBQKDIC7DpdRt27ub84lJMJQhQp7UFGgu3IjX+502bZOzWeIBUx
 4P1jYf0BLeNZ6xe2kCqgyweu5Mx5QKSArRNrK2gt+7e4Avhyqy9Y/k0M4w0bSk0xuY3a
 vVre1ONCYjSipfPu428fLKAIDZScLV7V4M8buu7gu8Y7Pxh87PIWjr3s99h8xbrj4biy
 GcbSIWoKvoPbgeu+0k8sbwI2dRuxRgEZiLbICp1D4fYSeJTRLbNSkLvAtcVDuVRaSvMq
 EKhbafo+WlQIzY40fQtArxVKxwjP4U08cDaQYdaB3g1bzfUp+GB+JayWVLcKyYzMufWe
 q8jw==
X-Gm-Message-State: APjAAAUppMHnthbClP8MaPPKG2hgRu3P/OohTdtlwXCauybnB1h++aLA
 KZA8rtowEyg3WEA+xPcJUjgC3uBJ
X-Google-Smtp-Source: APXvYqx/GJNmU81z0j1p0ek8fLudU7fjtHeuL0JZpViHswDyV55idT4SIwWlqRL+pl6Ciia/eTqRrA==
X-Received: by 2002:a81:2e45:: with SMTP id u66mr3652408ywu.410.1562884400086; 
 Thu, 11 Jul 2019 15:33:20 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:19 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:53 -0400
Message-Id: <20190711223300.6061-12-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RISU PATCH v3 11/18] x86.risu: add SSE instructions
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

Add SSE instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 318 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 318 insertions(+)

diff --git a/x86.risu b/x86.risu
index 208ac16..2d963fc 100644
--- a/x86.risu
+++ b/x86.risu
@@ -35,6 +35,52 @@ MOVQ_mm MMX 00001111 011 d 1111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { $d ? store(size => 8) : load(size => 8); }
 
+# NP 0F 28 /r: MOVAPS xmm1, xmm2/m128
+# NP 0F 29 /r: MOVAPS xmm2/m128, xmm1
+MOVAPS SSE 00001111 0010100 d \
+  !constraints { modrm($_); 1 } \
+  !memory { $d ? store(size => 16, align => 16) : load(size => 16, align => 16); }
+
+# NP 0F 10 /r: MOVUPS xmm1, xmm2/m128
+# NP 0F 11 /r: MOVUPS xmm2/m128, xmm1
+MOVUPS SSE 00001111 0001000 d \
+  !constraints { modrm($_); 1 } \
+  !memory { $d ? store(size => 16) : load(size => 16); }
+
+# F3 0F 10 /r: MOVSS xmm1, xmm2/m32
+# F3 0F 11 /r: MOVSS xmm2/m32, xmm1
+MOVSS SSE 00001111 0001000 d \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { $d ? store(size => 4) : load(size => 4); }
+
+# NP 0F 12 /r: MOVLPS xmm1, m64
+# 0F 13 /r: MOVLPS m64, xmm1
+MOVLPS SSE 00001111 0001001 d \
+  !constraints { modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 8) : load(size => 8); }
+
+# NP 0F 16 /r: MOVHPS xmm1, m64
+# NP 0F 17 /r: MOVHPS m64, xmm1
+MOVHPS SSE 00001111 0001011 d \
+  !constraints { modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 8) : load(size => 8); }
+
+# NP 0F 16 /r: MOVLHPS xmm1, xmm2
+MOVLHPS SSE 00001111 00010110 \
+  !constraints { modrm($_); defined $_->{modrm}{reg2} }
+
+# NP 0F 12 /r: MOVHLPS xmm1, xmm2
+MOVHLPS SSE 00001111 00010010 \
+  !constraints { modrm($_); defined $_->{modrm}{reg2} }
+
+# NP 0F D7 /r: PMOVMSKB reg, mm
+PMOVMSKB SSE 00001111 11010111 \
+  !constraints { modrm($_); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
+
+# NP 0F 50 /r: MOVMSKPS reg, xmm
+MOVMSKPS SSE 00001111 01010000 \
+  !constraints { modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
+
 #
 # Arithmetic Instructions
 # -----------------------
@@ -75,6 +121,16 @@ PADDUSW MMX 00001111 11011101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# NP 0F 58 /r: ADDPS xmm1, xmm2/m128
+ADDPS SSE 00001111 01011000 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F 58 /r: ADDSS xmm1, xmm2/m32
+ADDSS SSE 00001111 01011000 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # NP 0F F8 /r: PSUBB mm, mm/m64
 PSUBB MMX 00001111 11111000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -110,6 +166,16 @@ PSUBUSW MMX 00001111 11011001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# NP 0F 5C /r: SUBPS xmm1, xmm2/m128
+SUBPS SSE 00001111 01011100 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F 5C /r: SUBSS xmm1, xmm2/m32
+SUBSS SSE 00001111 01011100 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # NP 0F D5 /r: PMULLW mm, mm/m64
 PMULLW MMX 00001111 11010101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -120,11 +186,121 @@ PMULHW MMX 00001111 11100101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# NP 0F E4 /r: PMULHUW mm1, mm2/m64
+PMULHUW SSE 00001111 11100100 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 59 /r: MULPS xmm1, xmm2/m128
+MULPS SSE 00001111 01011001 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F 59 /r: MULSS xmm1,xmm2/m32
+MULSS SSE 00001111 01011001 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # NP 0F F5 /r: PMADDWD mm, mm/m64
 PMADDWD MMX 00001111 11110101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# NP 0F 5E /r: DIVPS xmm1, xmm2/m128
+DIVPS SSE 00001111 01011110 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F 5E /r: DIVSS xmm1, xmm2/m32
+DIVSS SSE 00001111 01011110 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# NP 0F 53 /r: RCPPS xmm1, xmm2/m128
+RCPPS SSE 00001111 01010011 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F 53 /r: RCPSS xmm1, xmm2/m32
+RCPSS SSE 00001111 01010011 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# NP 0F 51 /r: SQRTPS xmm1, xmm2/m128
+SQRTPS SSE 00001111 01010001 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F 51 /r: SQRTSS xmm1, xmm2/m32
+SQRTSS SSE 00001111 01010001 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# NP 0F 52 /r: RSQRTPS xmm1, xmm2/m128
+RSQRTPS SSE 00001111 01010010 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F 52 /r: RSQRTSS xmm1, xmm2/m32
+RSQRTSS SSE 00001111 01010010 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# NP 0F DA /r: PMINUB mm1, mm2/m64
+PMINUB SSE 00001111 11011010 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F EA /r: PMINSW mm1, mm2/m64
+PMINSW SSE 00001111 11101010 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 5D /r: MINPS xmm1, xmm2/m128
+MINPS SSE 00001111 01011101 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F 5D /r: MINSS xmm1,xmm2/m32
+MINSS SSE 00001111 01011101 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# NP 0F DE /r: PMAXUB mm1, mm2/m64
+PMAXUB SSE 00001111 11011110 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F EE /r: PMAXSW mm1, mm2/m64
+PMAXSW SSE 00001111 11101110 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 5F /r: MAXPS xmm1, xmm2/m128
+MAXPS SSE 00001111 01011111 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F 5F /r: MAXSS xmm1, xmm2/m32
+MAXSS SSE 00001111 01011111 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# NP 0F E0 /r: PAVGB mm1, mm2/m64
+PAVGB SSE 00001111 11100000 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F E3 /r: PAVGW mm1, mm2/m64
+PAVGW SSE 00001111 11100011 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F F6 /r: PSADBW mm1, mm2/m64
+PSADBW SSE 00001111 11110110 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
 #
 # Comparison Instructions
 # -----------------------
@@ -160,6 +336,26 @@ PCMPGTD MMX 00001111 01100110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# NP 0F C2 /r ib: CMPPS xmm1, xmm2/m128, imm8
+CMPPS SSE 00001111 11000010 \
+  !constraints { modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F C2 /r ib: CMPSS xmm1, xmm2/m32, imm8
+CMPSS SSE 00001111 11000010 \
+  !constraints { rep($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 4); }
+
+# NP 0F 2E /r: UCOMISS xmm1, xmm2/m32
+UCOMISS SSE 00001111 00101110 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 4); }
+
+# NP 0F 2F /r: COMISS xmm1, xmm2/m32
+COMISS SSE 00001111 00101111 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 #
 # Logical Instructions
 # --------------------
@@ -170,21 +366,41 @@ PAND MMX 00001111 11011011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# NP 0F 54 /r: ANDPS xmm1, xmm2/m128
+ANDPS SSE 00001111 01010100 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F DF /r: PANDN mm, mm/m64
 PANDN MMX 00001111 11011111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# NP 0F 55 /r: ANDNPS xmm1, xmm2/m128
+ANDNPS SSE 00001111 01010101 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F EB /r: POR mm, mm/m64
 POR MMX 00001111 11101011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# NP 0F 56 /r: ORPS xmm1, xmm2/m128
+ORPS SSE 00001111 01010110 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F EF /r: PXOR mm, mm/m64
 PXOR MMX 00001111 11101111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 8); }
 
+# NP 0F 57 /r: XORPS xmm1, xmm2/m128
+XORPS SSE 00001111 01010111 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 #
 # Shift and Rotate Instructions
 # -----------------------------
@@ -312,6 +528,98 @@ PUNPCKLDQ MMX 00001111 01100010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
   !memory { load(size => 4); }
 
+# NP 0F 14 /r: UNPCKLPS xmm1, xmm2/m128
+UNPCKLPS SSE 00001111 00010100 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F 15 /r: UNPCKHPS xmm1, xmm2/m128
+UNPCKHPS SSE 00001111 00010101 \
+  !constraints { modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F 70 /r ib: PSHUFW mm1, mm2/m64, imm8
+PSHUFW SSE 00001111 01110000 \
+  !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F C6 /r ib: SHUFPS xmm1, xmm3/m128, imm8
+SHUFPS SSE 00001111 11000110 \
+  !constraints { modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# NP 0F C4 /r ib: PINSRW mm, r32/m16, imm8
+PINSRW SSE 00001111 11000100 \
+  !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg} &= 0b111; !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 2); }
+
+# NP 0F C5 /r ib: PEXTRW reg, mm, imm8
+PEXTRW_reg SSE 00001111 11000101 \
+  !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
+
+#
+# Conversion Instructions
+# -----------------------
+#
+
+# NP 0F 2A /r: CVTPI2PS xmm, mm/m64
+CVTPI2PS SSE 00001111 00101010 \
+  !constraints { modrm($_); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 2D /r: CVTPS2PI mm, xmm/m64
+CVTPS2PI SSE 00001111 00101101 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 2C /r: CVTTPS2PI mm, xmm/m64
+CVTTPS2PI SSE 00001111 00101100 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; 1 } \
+  !memory { load(size => 8); }
+
+#
+# Cacheability Control, Prefetch, and Instruction Ordering Instructions
+# ---------------------------------------------------------------------
+#
+
+# NP 0F F7 /r: MASKMOVQ mm1, mm2
+MASKMOVQ SSE 00001111 11110111 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} } \
+  !memory { load(size => 8, base => REG_RDI, rollback => 1); }
+
+# NP 0F 2B /r: MOVNTPS m128, xmm1
+MOVNTPS SSE 00001111 00101011 \
+  !constraints { modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { store(size => 16, align => 16); }
+
+# NP 0F E7 /r: MOVNTQ m64, mm
+MOVNTQ SSE 00001111 11100111 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; !defined $_->{modrm}{reg2} } \
+  !memory { store(size => 8); }
+
+# 0F 18 /1: PREFETCHT0 m8
+PREFETCHT0 SSE 00001111 00011000 \
+  !constraints { modrm($_, reg => 1); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 1); }
+
+# 0F 18 /2: PREFETCHT1 m8
+PREFETCHT1 SSE 00001111 00011000 \
+  !constraints { modrm($_, reg => 2); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 1); }
+
+# 0F 18 /3: PREFETCHT2 m8
+PREFETCHT2 SSE 00001111 00011000 \
+  !constraints { modrm($_, reg => 3); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 1); }
+
+# 0F 18 /0: PREFETCHNTA m8
+PREFETCHNTA SSE 00001111 00011000 \
+  !constraints { modrm($_, reg => 0); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 1); }
+
+# NP 0F AE F8: SFENCE
+SFENCE SSE 00001111 10101110 11111000
+
 #
 # State Management Instructions
 # -----------------------------
@@ -319,3 +627,13 @@ PUNPCKLDQ MMX 00001111 01100010 \
 
 # NP 0F 77: EMMS
 EMMS MMX 00001111 01110111
+
+# NP 0F AE /2: LDMXCSR m32
+LDMXCSR SSE 00001111 10101110 \
+  !constraints { modrm($_, reg => 2); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 4, value => 0x000001f80, mask => 0xffff1f80); }
+
+# NP 0F AE /3: STMXCSR m32
+STMXCSR SSE 00001111 10101110 \
+  !constraints { modrm($_, reg => 3); !defined $_->{modrm}{reg2} } \
+  !memory { store(size => 4); }
-- 
2.20.1


