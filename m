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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7673C742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:37:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 681032084B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJsBELDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681032084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhhC-0000LW-PF
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40644)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhda-000302-1m
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:34:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdP-0004BP-1C
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:34:01 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:42522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhdO-0003po-MA
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:50 -0400
Received: by mail-yb1-xb42.google.com with SMTP id f195so3194849ybg.9
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ynq10fbwG/+HFbepoV1LFAlGQaECXBo8l1ymMHhws8c=;
 b=AJsBELDNek3B6cM/WbArP0t9SHBxF+ExV+CX6AyfPGDAUqgHB5x+GSpNLHYAdJoQxy
 QUq/mIpyF+Y8bcFGpqZ+UhKmt3WGrpMdN4aI2hYQuuz+bXZP3O1rWR7Io+RrRTQDatb7
 oqPaVjCPFsN5GHbV6G9CBCzEHKYAK0TB4qTXQX4yLj3V6KVJ5OKUDgHrlYlZIB8s+N68
 akqnZVdlwD3crJ/ecfLVx79lifJvYMNxU9tgIm/BB19AWC5m2dzpzMXarCdFukTfiF5Z
 fkDbAdpS01b/4qD+oLUyrL4rDLNm1xjbjjFN1SylgcvLXmdIFY87VZNARm4eZ5DIYZOJ
 ZFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ynq10fbwG/+HFbepoV1LFAlGQaECXBo8l1ymMHhws8c=;
 b=cmOHO2In9NeKAwCtAq6nW9HD/9TB5ORBz3aqtmgdr03AiTXfRCJ/VThcNpU0RzhX9M
 OPMeLgA205B6XTvKJXfA+RfFs4R7GBOJgvRIjlqTE5s9ziFYVTWMRXk+LVdBFedrWJfL
 qXh/xjtG6cT5pIyg8AhARyxkJ80frlUrH97Qx0gu+t85Pq1xstynAgPsiWH/kkDPMeRR
 9l1poc7AuC3CiaEKNStQ0/q0w9a0zHvs/fJ1HbioGQ6ImNBPq7b9rOZyS+XjA5eUzCw5
 ZQ23dRPSZZtalXq9yW8VQHBa1gJgER/OkLhaWGGUSglYIbc6gqN4yBUHJR8z5/ziCeaH
 fyHA==
X-Gm-Message-State: APjAAAUBIGfVJ+4fMhEGHeqTdcnVXsF+j1Cee5DZEX0f3xDVvKsyUlGq
 k6DxTn6YidnZpVpN+Bgf4ZHDTN/M
X-Google-Smtp-Source: APXvYqzFKix9iPFuvku/VRSUBOVqB2DXOwMhxYXe4S3zKcE0lDXyzWiEsgzThvRWdYpZExLZ2JIetA==
X-Received: by 2002:a25:790d:: with SMTP id u13mr3657704ybc.65.1562884403947; 
 Thu, 11 Jul 2019 15:33:23 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:23 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:59 -0400
Message-Id: <20190711223300.6061-18-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RISU PATCH v3 17/18] x86.risu: add AVX instructions
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

Add AVX instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 1362 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1362 insertions(+)

diff --git a/x86.risu b/x86.risu
index 177979a..03ffc89 100644
--- a/x86.risu
+++ b/x86.risu
@@ -29,6 +29,12 @@ MOVD SSE2 00001111 011 d 1110 \
   !constraints { data16($_); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { $d ? store(size => 4) : load(size => 4); }
 
+# VEX.128.66.0F.W0 6E /r: VMOVD xmm1,r32/m32
+# VEX.128.66.0F.W0 7E /r: VMOVD r32/m32,xmm1
+VMOVD AVX 011 d 1110 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66, w => 0); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { $d ? store(size => 4) : load(size => 4); }
+
 # NP REX.W + 0F 6E /r: MOVQ mm,r/m64
 # NP REX.W + 0F 7E /r: MOVQ r/m64,mm
 MOVQ MMX 00001111 011 d 1110 \
@@ -41,6 +47,12 @@ MOVQ SSE2 00001111 011 d 1110 \
   !constraints { data16($_); rex($_, w => 1); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { $d ? store(size => 8) : load(size => 8); }
 
+# VEX.128.66.0F.W1 6E /r: VMOVQ xmm1,r64/m64
+# VEX.128.66.0F.W1 7E /r: VMOVQ r64/m64,xmm1
+VMOVQ AVX 011 d 1110 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66, w => 1); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { $d ? store(size => 8) : load(size => 8); }
+
 # NP 0F 6F /r: MOVQ mm, mm/m64
 # NP 0F 7F /r: MOVQ mm/m64, mm
 MOVQ_mm MMX 00001111 011 d 1111 \
@@ -52,59 +64,121 @@ MOVQ_xmm1 SSE2 00001111 01111110 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.128.F3.0F.WIG 7E /r: VMOVQ xmm1, xmm2/m64
+VMOVQ_xmm1 AVX 01111110 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # 66 0F D6 /r: MOVQ xmm2/m64, xmm1
 MOVQ_xmm2 SSE2 00001111 11010110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { store(size => 8); }
 
+# VEX.128.66.0F.WIG D6 /r: VMOVQ xmm1/m64, xmm2
+VMOVQ_xmm2 AVX 11010110 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { store(size => 8); }
+
 # NP 0F 28 /r: MOVAPS xmm1, xmm2/m128
 # NP 0F 29 /r: MOVAPS xmm2/m128, xmm1
 MOVAPS SSE 00001111 0010100 d \
   !constraints { modrm($_); 1 } \
   !memory { $d ? store(size => 16, align => 16) : load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 28 /r: VMOVAPS xmm1, xmm2/m128
+# VEX.128.0F.WIG 29 /r: VMOVAPS xmm2/m128, xmm1
+VMOVAPS AVX 0010100 d \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
+  !memory { $d ? store(size => 16, align => 16) : load(size => 16, align => 16); }
+
 # 66 0F 28 /r: MOVAPD xmm1, xmm2/m128
 # 66 0F 29 /r: MOVAPD xmm2/m128, xmm1
 MOVAPD SSE2 00001111 0010100 d \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { $d ? store(size => 16, align => 16) : load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 28 /r: VMOVAPD xmm1, xmm2/m128
+# VEX.128.66.0F.WIG 29 /r: VMOVAPD xmm2/m128, xmm1
+VMOVAPD AVX 0010100 d \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { $d ? store(size => 16, align => 16) : load(size => 16, align => 16); }
+
 # 66 0F 6F /r: MOVDQA xmm1, xmm2/m128
 # 66 0F 7F /r: MOVDQA xmm2/m128, xmm1
 MOVDQA SSE2 00001111 011 d 1111 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { $d ? store(size => 16, align => 16) : load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 6F /r: VMOVDQA xmm1, xmm2/m128
+# VEX.128.66.0F.WIG 7F /r: VMOVDQA xmm2/m128, xmm1
+VMOVDQA AVX 011 d 1111 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { $d ? store(size => 16, align => 16) : load(size => 16, align => 16); }
+
 # NP 0F 10 /r: MOVUPS xmm1, xmm2/m128
 # NP 0F 11 /r: MOVUPS xmm2/m128, xmm1
 MOVUPS SSE 00001111 0001000 d \
   !constraints { modrm($_); 1 } \
   !memory { $d ? store(size => 16) : load(size => 16); }
 
+# VEX.128.0F.WIG 10 /r: VMOVUPS xmm1, xmm2/m128
+# VEX.128.0F.WIG 11 /r: VMOVUPS xmm2/m128, xmm1
+VMOVUPS AVX 0001000 d \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
+  !memory { $d ? store(size => 16) : load(size => 16); }
+
 # 66 0F 10 /r: MOVUPD xmm1, xmm2/m128
 # 66 0F 11 /r: MOVUPD xmm2/m128, xmm1
 MOVUPD SSE2 00001111 0001000 d \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { $d ? store(size => 16) : load(size => 16); }
 
+# VEX.128.66.0F.WIG 10 /r: VMOVUPD xmm1, xmm2/m128
+# VEX.128.66.0F.WIG 11 /r: VMOVUPD xmm2/m128, xmm1
+VMOVUPD AVX 0001000 d \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { $d ? store(size => 16) : load(size => 16); }
+
 # F3 0F 6F /r: MOVDQU xmm1,xmm2/m128
 # F3 0F 7F /r: MOVDQU xmm2/m128,xmm1
 MOVDQU SSE2 00001111 011 d 1111 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { $d ? store(size => 16) : load(size => 16); }
 
+# VEX.128.F3.0F.WIG 6F /r: VMOVDQU xmm1,xmm2/m128
+# VEX.128.F3.0F.WIG 7F /r: VMOVDQU xmm2/m128,xmm1
+VMOVDQU AVX 011 d 1111 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { $d ? store(size => 16) : load(size => 16); }
+
 # F3 0F 10 /r: MOVSS xmm1, xmm2/m32
 # F3 0F 11 /r: MOVSS xmm2/m32, xmm1
 MOVSS SSE 00001111 0001000 d \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { $d ? store(size => 4) : load(size => 4); }
 
+# VEX.LIG.F3.0F.WIG 10 /r: VMOVSS xmm1, xmm2, xmm3
+# VEX.LIG.F3.0F.WIG 10 /r: VMOVSS xmm1, m32
+# VEX.LIG.F3.0F.WIG 11 /r: VMOVSS xmm1, xmm2, xmm3
+# VEX.LIG.F3.0F.WIG 11 /r: VMOVSS m32, xmm1
+VMOVSS AVX 0001000 d \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3); modrm($_); $_->{vex}{v} = 0 unless defined $_->{modrm}{reg2}; 1 } \
+  !memory { $d ? store(size => 4) : load(size => 4); }
+
 # F2 0F 10 /r: MOVSD xmm1, xmm2/m64
 # F2 0F 11 /r: MOVSD xmm1/m64, xmm2
 MOVSD SSE2 00001111 0001000 d \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { $d ? store(size => 8): load(size => 8); }
 
+# VEX.LIG.F2.0F.WIG 10 /r: VMOVSD xmm1, xmm2, xmm3
+# VEX.LIG.F2.0F.WIG 10 /r: VMOVSD xmm1, m64
+# VEX.LIG.F2.0F.WIG 11 /r: VMOVSD xmm1, xmm2, xmm3
+# VEX.LIG.F2.0F.WIG 11 /r: VMOVSD m64, xmm1
+VMOVSD AVX 0001000 d \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF2); modrm($_); $_->{vex}{v} = 0 unless defined $_->{modrm}{reg2}; 1 } \
+  !memory { $d ? store(size => 8) : load(size => 8); }
+
 # F3 0F D6 /r: MOVQ2DQ xmm, mm
 MOVQ2DQ SSE2 00001111 11010110 \
   !constraints { rep($_); modrm($_); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -119,32 +193,64 @@ MOVLPS SSE 00001111 0001001 d \
   !constraints { modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { $d ? store(size => 8) : load(size => 8); }
 
+# VEX.128.0F.WIG 12 /r: VMOVLPS xmm2, xmm1, m64
+# VEX.128.0F.WIG 13 /r: VMOVLPS m64, xmm1
+VMOVLPS AVX 0001001 d \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); $_->{vex}{v} = 0 if $d; !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 8) : load(size => 8); }
+
 # 66 0F 12 /r: MOVLPD xmm1,m64
 # 66 0F 13 /r: MOVLPD m64,xmm1
 MOVLPD SSE2 00001111 0001001 d \
   !constraints { data16($_); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { $d ? store(size => 8) : load(size => 8); }
 
+# VEX.128.66.0F.WIG 12 /r: VMOVLPD xmm2,xmm1,m64
+# VEX.128.66.0F.WIG 13 /r: VMOVLPD m64,xmm1
+VMOVLPD AVX 0001001 d \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); $_->{vex}{v} = 0 if $d; !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 8) : load(size => 8); }
+
 # NP 0F 16 /r: MOVHPS xmm1, m64
 # NP 0F 17 /r: MOVHPS m64, xmm1
 MOVHPS SSE 00001111 0001011 d \
   !constraints { modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { $d ? store(size => 8) : load(size => 8); }
 
+# VEX.128.0F.WIG 16 /r: VMOVHPS xmm2, xmm1, m64
+# VEX.128.0F.WIG 17 /r: VMOVHPS m64, xmm1
+VMOVHPS AVX 0001011 d \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); $_->{vex}{v} = 0 if $d; !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 8) : load(size => 8); }
+
 # 66 0F 16 /r: MOVHPD xmm1, m64
 # 66 0F 17 /r: MOVHPD m64, xmm1
 MOVHPD SSE2 00001111 0001011 d \
   !constraints { data16($_); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { $d ? store(size => 8) : load(size => 8); }
 
+# VEX.128.66.0F.WIG 16 /r: VMOVHPD xmm2, xmm1, m64
+# VEX.128.66.0F.WIG 17 /r: VMOVHPD m64, xmm1
+VMOVHPD AVX 0001011 d \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); $_->{vex}{v} = 0 if $d; !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 8) : load(size => 8); }
+
 # NP 0F 16 /r: MOVLHPS xmm1, xmm2
 MOVLHPS SSE 00001111 00010110 \
   !constraints { modrm($_); defined $_->{modrm}{reg2} }
 
+# VEX.128.0F.WIG 16 /r: VMOVLHPS xmm1, xmm2, xmm3
+VMOVLHPS AVX 00010110 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); defined $_->{modrm}{reg2} }
+
 # NP 0F 12 /r: MOVHLPS xmm1, xmm2
 MOVHLPS SSE 00001111 00010010 \
   !constraints { modrm($_); defined $_->{modrm}{reg2} }
 
+# VEX.128.0F.WIG 12 /r: VMOVHLPS xmm1, xmm2, xmm3
+VMOVHLPS AVX 00010010 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); defined $_->{modrm}{reg2} }
+
 # NP 0F D7 /r: PMOVMSKB reg, mm
 PMOVMSKB SSE 00001111 11010111 \
   !constraints { modrm($_); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
@@ -153,34 +259,66 @@ PMOVMSKB SSE 00001111 11010111 \
 PMOVMSKB SSE2 00001111 11010111 \
   !constraints { data16($_); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
 
+# VEX.128.66.0F.WIG D7 /r: VPMOVMSKB reg, xmm1
+VPMOVMSKB AVX 11010111 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
+
 # NP 0F 50 /r: MOVMSKPS reg, xmm
 MOVMSKPS SSE 00001111 01010000 \
   !constraints { modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
 
+# VEX.128.0F.WIG 50 /r: VMOVMSKPS reg, xmm2
+VMOVMSKPS AVX 01010000 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
+
 # 66 0F 50 /r: MOVMSKPD reg, xmm
 MOVMSKPD SSE2 00001111 01010000 \
   !constraints { data16($_); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
 
+# VEX.128.66.0F.WIG 50 /r: VMOVMSKPD reg, xmm2
+VMOVMSKPD AVX 01010000 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
+
 # F2 0F F0 /r: LDDQU xmm1, m128
 LDDQU SSE3 00001111 11110000 \
   !constraints { repne($_); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { load(size => 16); }
 
+# VEX.128.F2.0F.WIG F0 /r: VLDDQU xmm1, m128
+VLDDQU AVX 11110000 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF2); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 16); }
+
 # F3 0F 16 /r: MOVSHDUP xmm1, xmm2/m128
 MOVSHDUP SSE3 00001111 00010110 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.F3.0F.WIG 16 /r: VMOVSHDUP xmm1, xmm2/m128
+VMOVSHDUP AVX 00010110 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F 12 /r: MOVSLDUP xmm1, xmm2/m128
 MOVSLDUP SSE3 00001111 00010010 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.F3.0F.WIG 12 /r: VMOVSLDUP xmm1, xmm2/m128
+VMOVSLDUP AVX 00010010 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F2 0F 12 /r: MOVDDUP xmm1, xmm2/m64
 MOVDDUP SSE3 00001111 00010010 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.128.F2.0F.WIG 12 /r: VMOVDDUP xmm1, xmm2/m64
+VMOVDDUP AVX 00010010 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 #
 # Arithmetic Instructions
 # -----------------------
@@ -196,6 +334,11 @@ PADDB SSE2 00001111 11111100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG FC /r: VPADDB xmm1, xmm2, xmm3/m128
+VPADDB AVX 11111100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F FD /r: PADDW mm, mm/m64
 PADDW MMX 00001111 11111101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -206,6 +349,11 @@ PADDW SSE2 00001111 11111101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG FD /r: VPADDW xmm1, xmm2, xmm3/m128
+VPADDW AVX 11111101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F FE /r: PADDD mm, mm/m64
 PADDD MMX 00001111 11111110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -216,6 +364,11 @@ PADDD SSE2 00001111 11111110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG FE /r: VPADDD xmm1, xmm2, xmm3/m128
+VPADDD AVX 11111110 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F D4 /r: PADDQ mm, mm/m64
 PADDQ_mm SSE2 00001111 11010100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -226,6 +379,11 @@ PADDQ SSE2 00001111 11010100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG D4 /r: VPADDQ xmm1, xmm2, xmm3/m128
+VPADDQ AVX 11010100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F EC /r: PADDSB mm, mm/m64
 PADDSB MMX 00001111 11101100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -236,6 +394,11 @@ PADDSB SSE2 00001111 11101100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG EC /r: VPADDSB xmm1, xmm2, xmm3/m128
+VPADDSB AVX 11101100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F ED /r: PADDSW mm, mm/m64
 PADDSW MMX 00001111 11101101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -246,6 +409,11 @@ PADDSW SSE2 00001111 11101101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG ED /r: VPADDSW xmm1, xmm2, xmm3/m128
+VPADDSW AVX 11101101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F DC /r: PADDUSB mm,mm/m64
 PADDUSB MMX 00001111 11011100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -256,6 +424,11 @@ PADDUSB SSE2 00001111 11011100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG DC /r: VPADDUSB xmm1,xmm2,xmm3/m128
+VPADDUSB AVX 11011100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F DD /r: PADDUSW mm,mm/m64
 PADDUSW MMX 00001111 11011101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -266,26 +439,51 @@ PADDUSW SSE2 00001111 11011101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG DD /r: VPADDUSW xmm1,xmm2,xmm3/m128
+VPADDUSW AVX 11011101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 58 /r: ADDPS xmm1, xmm2/m128
 ADDPS SSE 00001111 01011000 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 58 /r: VADDPS xmm1,xmm2, xmm3/m128
+VADDPS AVX 01011000 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 58 /r: ADDPD xmm1, xmm2/m128
 ADDPD SSE2 00001111 01011000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 58 /r: VADDPD xmm1,xmm2, xmm3/m128
+VADDPD AVX 01011000 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F 58 /r: ADDSS xmm1, xmm2/m32
 ADDSS SSE 00001111 01011000 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.F3.0F.WIG 58 /r: VADDSS xmm1,xmm2, xmm3/m32
+VADDSS AVX 01011000 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # F2 0F 58 /r: ADDSD xmm1, xmm2/m64
 ADDSD SSE2 00001111 01011000 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.LIG.F2.0F.WIG 58 /r: VADDSD xmm1, xmm2, xmm3/m64
+VADDSD AVX 01011000 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 38 01 /r: PHADDW mm1, mm2/m64
 PHADDW_mm SSSE3 00001111 00111000 00000001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -296,6 +494,11 @@ PHADDW SSSE3 00001111 00111000 00000001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 01 /r: VPHADDW xmm1, xmm2, xmm3/m128
+VPHADDW AVX 00000001 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 38 02 /r: PHADDD mm1, mm2/m64
 PHADDD_mm SSSE3 00001111 00111000 00000010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -306,6 +509,11 @@ PHADDD SSSE3 00001111 00111000 00000010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 02 /r: VPHADDD xmm1, xmm2, xmm3/m128
+VPHADDD AVX 00000010 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 38 03 /r: PHADDSW mm1, mm2/m64
 PHADDSW_mm SSSE3 00001111 00111000 00000011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -316,16 +524,31 @@ PHADDSW SSSE3 00001111 00111000 00000011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 03 /r: VPHADDSW xmm1, xmm2, xmm3/m128
+VPHADDSW AVX 00000011 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F2 0F 7C /r: HADDPS xmm1, xmm2/m128
 HADDPS SSE3 00001111 01111100 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.F2.0F.WIG 7C /r: VHADDPS xmm1, xmm2, xmm3/m128
+VHADDPS AVX 01111100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 7C /r: HADDPD xmm1, xmm2/m128
 HADDPD SSE3 00001111 01111100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 7C /r: VHADDPD xmm1,xmm2, xmm3/m128
+VHADDPD AVX 01111100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F F8 /r: PSUBB mm, mm/m64
 PSUBB MMX 00001111 11111000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -336,6 +559,11 @@ PSUBB SSE2 00001111 11111000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG F8 /r: VPSUBB xmm1, xmm2, xmm3/m128
+VPSUBB AVX 11111000 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F F9 /r: PSUBW mm, mm/m64
 PSUBW MMX 00001111 11111001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -346,6 +574,11 @@ PSUBW SSE2 00001111 11111001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG F9 /r: VPSUBW xmm1, xmm2, xmm3/m128
+VPSUBW AVX 11111001 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F FA /r: PSUBD mm, mm/m64
 PSUBD MMX 00001111 11111010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -356,6 +589,11 @@ PSUBD SSE2 00001111 11111010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG FA /r: VPSUBD xmm1, xmm2, xmm3/m128
+VPSUBD AVX 11111010 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F FB /r: PSUBQ mm1, mm2/m64
 PSUBQ_mm SSE2 00001111 11111011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -366,6 +604,11 @@ PSUBQ SSE2 00001111 11111011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG FB /r: VPSUBQ xmm1, xmm2, xmm3/m128
+VPSUBQ AVX 11111011 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F E8 /r: PSUBSB mm, mm/m64
 PSUBSB MMX 00001111 11101000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -376,6 +619,11 @@ PSUBSB SSE2 00001111 11101000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG E8 /r: VPSUBSB xmm1, xmm2, xmm3/m128
+VPSUBSB AVX 11101000 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F E9 /r: PSUBSW mm, mm/m64
 PSUBSW MMX 00001111 11101001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -386,6 +634,11 @@ PSUBSW SSE2 00001111 11101001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG E9 /r: VPSUBSW xmm1, xmm2, xmm3/m128
+VPSUBSW AVX 11101001 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F D8 /r: PSUBUSB mm, mm/m64
 PSUBUSB MMX 00001111 11011000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -396,6 +649,11 @@ PSUBUSB SSE2 00001111 11011000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG D8 /r: VPSUBUSB xmm1, xmm2, xmm3/m128
+VPSUBUSB AVX 11011000 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F D9 /r: PSUBUSW mm, mm/m64
 PSUBUSW MMX 00001111 11011001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -406,26 +664,51 @@ PSUBUSW SSE2 00001111 11011001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG D9 /r: VPSUBUSW xmm1, xmm2, xmm3/m128
+VPSUBUSW AVX 11011001 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 5C /r: SUBPS xmm1, xmm2/m128
 SUBPS SSE 00001111 01011100 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 5C /r: VSUBPS xmm1,xmm2, xmm3/m128
+VSUBPS AVX 01011100 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 5C /r: SUBPD xmm1, xmm2/m128
 SUBPD SSE2 00001111 01011100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 5C /r: VSUBPD xmm1,xmm2, xmm3/m128
+VSUBPD AVX 01011100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F 5C /r: SUBSS xmm1, xmm2/m32
 SUBSS SSE 00001111 01011100 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.F3.0F.WIG 5C /r: VSUBSS xmm1,xmm2, xmm3/m32
+VSUBSS AVX 01011100 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # F2 0F 5C /r: SUBSD xmm1, xmm2/m64
 SUBSD SSE2 00001111 01011100 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.LIG.F2.0F.WIG 5C /r: VSUBSD xmm1,xmm2, xmm3/m64
+VSUBSD AVX 01011100 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 38 05 /r: PHSUBW mm1, mm2/m64
 PHSUBW_mm SSSE3 00001111 00111000 00000101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -436,6 +719,11 @@ PHSUBW SSSE3 00001111 00111000 00000101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 05 /r: VPHSUBW xmm1, xmm2, xmm3/m128
+VPHSUBW AVX 00000101 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 38 06 /r: PHSUBD mm1, mm2/m64
 PHSUBD_mm SSSE3 00001111 00111000 00000110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -446,6 +734,11 @@ PHSUBD SSSE3 00001111 00111000 00000110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 06 /r: VPHSUBD xmm1, xmm2, xmm3/m128
+VPHSUBD AVX 00000110 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 38 07 /r: PHSUBSW mm1, mm2/m64
 PHSUBSW_mm SSSE3 00001111 00111000 00000111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -456,26 +749,51 @@ PHSUBSW SSSE3 00001111 00111000 00000111 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 07 /r: VPHSUBSW xmm1, xmm2, xmm3/m128
+VPHSUBSW AVX 00000111 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F2 0F 7D /r: HSUBPS xmm1, xmm2/m128
 HSUBPS SSE3 00001111 01111101 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.F2.0F.WIG 7D /r: VHSUBPS xmm1, xmm2, xmm3/m128
+VHSUBPS AVX 01111101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 7D /r: HSUBPD xmm1, xmm2/m128
 HSUBPD SSE3 00001111 01111101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 7D /r: VHSUBPD xmm1,xmm2, xmm3/m128
+VHSUBPD AVX 01111101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F2 0F D0 /r: ADDSUBPS xmm1, xmm2/m128
 ADDSUBPS SSE3 00001111 11010000 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.F2.0F.WIG D0 /r: VADDSUBPS xmm1, xmm2, xmm3/m128
+VADDSUBPS AVX 11010000 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F D0 /r: ADDSUBPD xmm1, xmm2/m128
 ADDSUBPD SSE3 00001111 11010000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG D0 /r: VADDSUBPD xmm1, xmm2, xmm3/m128
+VADDSUBPD AVX 11010000 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F D5 /r: PMULLW mm, mm/m64
 PMULLW MMX 00001111 11010101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -486,11 +804,21 @@ PMULLW SSE2 00001111 11010101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG D5 /r: VPMULLW xmm1, xmm2, xmm3/m128
+VPMULLW AVX 11010101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 40 /r: PMULLD xmm1, xmm2/m128
 PMULLD SSE4_1 00001111 00111000 01000000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 40 /r: VPMULLD xmm1, xmm2, xmm3/m128
+VPMULLD AVX 01000000 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F E5 /r: PMULHW mm, mm/m64
 PMULHW MMX 00001111 11100101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -501,6 +829,11 @@ PMULHW SSE2 00001111 11100101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG E5 /r: VPMULHW xmm1, xmm2, xmm3/m128
+VPMULHW AVX 11100101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F E4 /r: PMULHUW mm1, mm2/m64
 PMULHUW SSE 00001111 11100100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -511,11 +844,21 @@ PMULHUW SSE2 00001111 11100100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG E4 /r: VPMULHUW xmm1, xmm2, xmm3/m128
+VPMULHUW AVX 11100100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 28 /r: PMULDQ xmm1, xmm2/m128
 PMULDQ SSE4_1 00001111 00111000 00101000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 28 /r: VPMULDQ xmm1, xmm2, xmm3/m128
+VPMULDQ AVX 00101000 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F F4 /r: PMULUDQ mm1, mm2/m64
 PMULUDQ_mm SSE2 00001111 11110100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -526,6 +869,11 @@ PMULUDQ SSE2 00001111 11110100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG F4 /r: VPMULUDQ xmm1, xmm2, xmm3/m128
+VPMULUDQ AVX 11110100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 38 0B /r: PMULHRSW mm1, mm2/m64
 PMULHRSW_mm SSSE3 00001111 00111000 00001011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -536,26 +884,51 @@ PMULHRSW SSSE3 00001111 00111000 00001011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 0B /r: VPMULHRSW xmm1, xmm2, xmm3/m128
+VPMULHRSW AVX 00001011 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 59 /r: MULPS xmm1, xmm2/m128
 MULPS SSE 00001111 01011001 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 59 /r: VMULPS xmm1,xmm2, xmm3/m128
+VMULPS AVX 01011001 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 59 /r: MULPD xmm1, xmm2/m128
 MULPD SSE2 00001111 01011001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 59 /r: VMULPD xmm1,xmm2, xmm3/m128
+VMULPD AVX 01011001 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F 59 /r: MULSS xmm1,xmm2/m32
 MULSS SSE 00001111 01011001 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.F3.0F.WIG 59 /r: VMULSS xmm1,xmm2, xmm3/m32
+VMULSS AVX 01011001 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # F2 0F 59 /r: MULSD xmm1,xmm2/m64
 MULSD SSE2 00001111 01011001 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.LIG.F2.0F.WIG 59 /r: VMULSD xmm1,xmm2, xmm3/m64
+VMULSD AVX 01011001 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F F5 /r: PMADDWD mm, mm/m64
 PMADDWD MMX 00001111 11110101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -566,6 +939,11 @@ PMADDWD SSE2 00001111 11110101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG F5 /r: VPMADDWD xmm1, xmm2, xmm3/m128
+VPMADDWD AVX 11110101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 38 04 /r: PMADDUBSW mm1, mm2/m64
 PMADDUBSW_mm SSSE3 00001111 00111000 00000100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -576,66 +954,131 @@ PMADDUBSW SSSE3 00001111 00111000 00000100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 04 /r: VPMADDUBSW xmm1, xmm2, xmm3/m128
+VPMADDUBSW AVX 00000100 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 5E /r: DIVPS xmm1, xmm2/m128
 DIVPS SSE 00001111 01011110 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 5E /r: VDIVPS xmm1, xmm2, xmm3/m128
+VDIVPS AVX 01011110 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 5E /r: DIVPD xmm1, xmm2/m128
 DIVPD SSE2 00001111 01011110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 5E /r: VDIVPD xmm1, xmm2, xmm3/m128
+VDIVPD AVX 01011110 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F 5E /r: DIVSS xmm1, xmm2/m32
 DIVSS SSE 00001111 01011110 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.F3.0F.WIG 5E /r: VDIVSS xmm1, xmm2, xmm3/m32
+VDIVSS AVX 01011110 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # F2 0F 5E /r: DIVSD xmm1, xmm2/m64
 DIVSD SSE2 00001111 01011110 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.LIG.F2.0F.WIG 5E /r: VDIVSD xmm1, xmm2, xmm3/m64
+VDIVSD AVX 01011110 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 53 /r: RCPPS xmm1, xmm2/m128
 RCPPS SSE 00001111 01010011 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 53 /r: VRCPPS xmm1, xmm2/m128
+VRCPPS AVX 01010011 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F 53 /r: RCPSS xmm1, xmm2/m32
 RCPSS SSE 00001111 01010011 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.F3.0F.WIG 53 /r: VRCPSS xmm1, xmm2, xmm3/m32
+VRCPSS AVX 01010011 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # NP 0F 51 /r: SQRTPS xmm1, xmm2/m128
 SQRTPS SSE 00001111 01010001 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 51 /r: VSQRTPS xmm1, xmm2/m128
+VSQRTPS AVX 01010001 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 51 /r: SQRTPD xmm1, xmm2/m128
 SQRTPD SSE2 00001111 01010001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 51 /r: VSQRTPD xmm1, xmm2/m128
+VSQRTPD AVX 01010001 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F 51 /r: SQRTSS xmm1, xmm2/m32
 SQRTSS SSE 00001111 01010001 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.F3.0F.WIG 51 /r: VSQRTSS xmm1, xmm2, xmm3/m32
+VSQRTSS AVX 01010001 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # F2 0F 51 /r: SQRTSD xmm1,xmm2/m64
 SQRTSD SSE2 00001111 01010001 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.LIG.F2.0F.WIG 51 /r: VSQRTSD xmm1,xmm2, xmm3/m64
+VSQRTSD AVX 01010001 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 52 /r: RSQRTPS xmm1, xmm2/m128
 RSQRTPS SSE 00001111 01010010 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 52 /r: VRSQRTPS xmm1, xmm2/m128
+VRSQRTPS AVX 01010010 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F 52 /r: RSQRTSS xmm1, xmm2/m32
 RSQRTSS SSE 00001111 01010010 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.F3.0F.WIG 52 /r: VRSQRTSS xmm1, xmm2, xmm3/m32
+VRSQRTSS AVX 01010010 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # NP 0F DA /r: PMINUB mm1, mm2/m64
 PMINUB SSE 00001111 11011010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -646,21 +1089,41 @@ PMINUB SSE2 00001111 11011010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F DA /r: VPMINUB xmm1, xmm2, xmm3/m128
+VPMINUB AVX 11011010 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 3A /r: PMINUW xmm1, xmm2/m128
 PMINUW SSE4_1 00001111 00111000 00111010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38 3A /r: VPMINUW xmm1, xmm2, xmm3/m128
+VPMINUW AVX 00111010 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 3B /r: PMINUD xmm1, xmm2/m128
 PMINUD SSE4_1 00001111 00111000 00111011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 3B /r: VPMINUD xmm1, xmm2, xmm3/m128
+VPMINUD AVX 00111011 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 38 /r: PMINSB xmm1, xmm2/m128
 PMINSB SSE4_1 00001111 00111000 00111000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38 38 /r: VPMINSB xmm1, xmm2, xmm3/m128
+VPMINSB AVX 00111000 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F EA /r: PMINSW mm1, mm2/m64
 PMINSW SSE 00001111 11101010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -671,36 +1134,71 @@ PMINSW SSE2 00001111 11101010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F EA /r: VPMINSW xmm1, xmm2, xmm3/m128
+VPMINSW AVX 11101010 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 39 /r: PMINSD xmm1, xmm2/m128
 PMINSD SSE4_1 00001111 00111000 00111001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 39 /r: VPMINSD xmm1, xmm2, xmm3/m128
+VPMINSD AVX 00111001 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 5D /r: MINPS xmm1, xmm2/m128
 MINPS SSE 00001111 01011101 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 5D /r: VMINPS xmm1, xmm2, xmm3/m128
+VMINPS AVX 01011101 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 5D /r: MINPD xmm1, xmm2/m128
 MINPD SSE2 00001111 01011101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 5D /r: VMINPD xmm1, xmm2, xmm3/m128
+VMINPD AVX 01011101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F 5D /r: MINSS xmm1,xmm2/m32
 MINSS SSE 00001111 01011101 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.F3.0F.WIG 5D /r: VMINSS xmm1,xmm2, xmm3/m32
+VMINSS AVX 01011101 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # F2 0F 5D /r: MINSD xmm1, xmm2/m64
 MINSD SSE2 00001111 01011101 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.LIG.F2.0F.WIG 5D /r: VMINSD xmm1, xmm2, xmm3/m64
+VMINSD AVX 01011101 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # 66 0F 38 41 /r: PHMINPOSUW xmm1, xmm2/m128
 PHMINPOSUW SSE4_1 00001111 00111000 01000001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 41 /r: VPHMINPOSUW xmm1, xmm2/m128
+VPHMINPOSUW AVX 01000001 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F DE /r: PMAXUB mm1, mm2/m64
 PMAXUB SSE 00001111 11011110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -711,21 +1209,41 @@ PMAXUB SSE2 00001111 11011110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F DE /r: VPMAXUB xmm1, xmm2, xmm3/m128
+VPMAXUB AVX 11011110 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 3E /r: PMAXUW xmm1, xmm2/m128
 PMAXUW SSE4_1 00001111 00111000 00111110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38 3E /r: VPMAXUW xmm1, xmm2, xmm3/m128
+VPMAXUW AVX 00111110 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 3F /r: PMAXUD xmm1, xmm2/m128
 PMAXUD SSE4_1 00001111 00111000 00111111 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 3F /r: VPMAXUD xmm1, xmm2, xmm3/m128
+VPMAXUD AVX 00111111 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 3C /r: PMAXSB xmm1, xmm2/m128
 PMAXSB SSE4_1 00001111 00111000 00111100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 3C /r: VPMAXSB xmm1, xmm2, xmm3/m128
+VPMAXSB AVX 00111100 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F EE /r: PMAXSW mm1, mm2/m64
 PMAXSW SSE 00001111 11101110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -736,31 +1254,61 @@ PMAXSW SSE2 00001111 11101110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG EE /r: VPMAXSW xmm1, xmm2, xmm3/m128
+VPMAXSW AVX 11101110 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 3D /r: PMAXSD xmm1, xmm2/m128
 PMAXSD SSE4_1 00001111 00111000 00111101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 3D /r: VPMAXSD xmm1, xmm2, xmm3/m128
+VPMAXSD AVX 00111101 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 5F /r: MAXPS xmm1, xmm2/m128
 MAXPS SSE 00001111 01011111 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 5F /r: VMAXPS xmm1, xmm2, xmm3/m128
+VMAXPS AVX 01011111 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 5F /r: MAXPD xmm1, xmm2/m128
 MAXPD SSE2 00001111 01011111 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 5F /r: VMAXPD xmm1, xmm2, xmm3/m128
+VMAXPD AVX 01011111 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F 5F /r: MAXSS xmm1, xmm2/m32
 MAXSS SSE 00001111 01011111 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.F3.0F.WIG 5F /r: VMAXSS xmm1, xmm2, xmm3/m32
+VMAXSS AVX 01011111 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # F2 0F 5F /r: MAXSD xmm1, xmm2/m64
 MAXSD SSE2 00001111 01011111 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.LIG.F2.0F.WIG 5F /r: VMAXSD xmm1, xmm2, xmm3/m64
+VMAXSD AVX 01011111 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F E0 /r: PAVGB mm1, mm2/m64
 PAVGB SSE 00001111 11100000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -771,6 +1319,11 @@ PAVGB SSE2 00001111 11100000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG E0 /r: VPAVGB xmm1, xmm2, xmm3/m128
+VPAVGB AVX 11100000 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F E3 /r: PAVGW mm1, mm2/m64
 PAVGW SSE 00001111 11100011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -781,6 +1334,11 @@ PAVGW SSE2 00001111 11100011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG E3 /r: VPAVGW xmm1, xmm2, xmm3/m128
+VPAVGW AVX 11100011 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F F6 /r: PSADBW mm1, mm2/m64
 PSADBW SSE 00001111 11110110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -791,11 +1349,21 @@ PSADBW SSE2 00001111 11110110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG F6 /r: VPSADBW xmm1, xmm2, xmm3/m128
+VPSADBW AVX 11110110 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 42 /r ib: MPSADBW xmm1, xmm2/m128, imm8
 MPSADBW SSE4_1 00001111 00111010 01000010 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.WIG 42 /r ib: VMPSADBW xmm1, xmm2, xmm3/m128, imm8
+VMPSADBW AVX 01000010 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 38 1C /r: PABSB mm1, mm2/m64
 PABSB_mm SSSE3 00001111 00111000 00011100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -806,6 +1374,11 @@ PABSB SSSE3 00001111 00111000 00011100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 1C /r: VPABSB xmm1, xmm2/m128
+VPABSB AVX 00011100 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 38 1D /r: PABSW mm1, mm2/m64
 PABSW_mm SSSE3 00001111 00111000 00011101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -816,6 +1389,11 @@ PABSW SSSE3 00001111 00111000 00011101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 1D /r: VPABSW xmm1, xmm2/m128
+VPABSW AVX 00011101 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 38 1E /r: PABSD mm1, mm2/m64
 PABSD_mm SSSE3 00001111 00111000 00011110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -826,6 +1404,11 @@ PABSD SSSE3 00001111 00111000 00011110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 1E /r: VPABSD xmm1, xmm2/m128
+VPABSD AVX 00011110 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 38 08 /r: PSIGNB mm1, mm2/m64
 PSIGNB_mm SSSE3 00001111 00111000 00001000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -836,6 +1419,11 @@ PSIGNB SSSE3 00001111 00111000 00001000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 08 /r: VPSIGNB xmm1, xmm2, xmm3/m128
+VPSIGNB AVX 00001000 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 38 09 /r: PSIGNW mm1, mm2/m64
 PSIGNW_mm SSSE3 00001111 00111000 00001001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -846,6 +1434,11 @@ PSIGNW SSSE3 00001111 00111000 00001001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 09 /r: VPSIGNW xmm1, xmm2, xmm3/m128
+VPSIGNW AVX 00001001 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 38 0A /r: PSIGND mm1, mm2/m64
 PSIGND_mm SSSE3 00001111 00111000 00001010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -856,36 +1449,71 @@ PSIGND SSSE3 00001111 00111000 00001010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 0A /r: VPSIGND xmm1, xmm2, xmm3/m128
+VPSIGND AVX 00001010 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 40 /r ib: DPPS xmm1, xmm2/m128, imm8
 DPPS SSE4_1 00001111 00111010 01000000 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.WIG 40 /r ib: VDPPS xmm1,xmm2, xmm3/m128, imm8
+VDPPS AVX 01000000 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 41 /r ib: DPPD xmm1, xmm2/m128, imm8
 DPPD SSE4_1 00001111 00111010 01000001 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.WIG 41 /r ib: VDPPD xmm1,xmm2, xmm3/m128, imm8
+VDPPD AVX 01000001 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 08 /r ib: ROUNDPS xmm1, xmm2/m128, imm8
 ROUNDPS SSE4_1 00001111 00111010 00001000 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.WIG 08 /r ib: VROUNDPS xmm1, xmm2/m128, imm8
+VROUNDPS AVX 00001000 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 09 /r ib: ROUNDPD xmm1, xmm2/m128, imm8
 ROUNDPD SSE4_1 00001111 00111010 00001001 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.WIG 09 /r ib: VROUNDPD xmm1, xmm2/m128, imm8
+VROUNDPD AVX 00001001 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 0A /r ib: ROUNDSS xmm1, xmm2/m32, imm8
 ROUNDSS SSE4_1 00001111 00111010 00001010 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.66.0F3A.WIG 0A /r ib: VROUNDSS xmm1, xmm2, xmm3/m32, imm8
+VROUNDSS AVX 00001010 \
+  !constraints { vex($_, m => 0x0F3A, l => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 4); }
+
 # 66 0F 3A 0B /r ib: ROUNDSD xmm1, xmm2/m64, imm8
 ROUNDSD SSE4_1 00001111 00111010 00001011 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 8); }
 
+# VEX.LIG.66.0F3A.WIG 0B /r ib: VROUNDSD xmm1, xmm2, xmm3/m64, imm8
+VROUNDSD AVX 00001011 \
+  !constraints { vex($_, m => 0x0F3A, l => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 8); }
+
 #
 # AES Instructions
 # ----------------
@@ -896,31 +1524,61 @@ AESDEC AES 00001111 00111000 11011110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG DE /r: VAESDEC xmm1, xmm2, xmm3/m128
+VAESDEC AES_AVX 11011110 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 DF /r: AESDECLAST xmm1, xmm2/m128
 AESDECLAST AES 00001111 00111000 11011111 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG DF /r: VAESDECLAST xmm1, xmm2, xmm3/m128
+VAESDECLAST AES_AVX 11011111 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 DC /r: AESENC xmm1, xmm2/m128
 AESENC AES 00001111 00111000 11011100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG DC /r: VAESENC xmm1, xmm2, xmm3/m128
+VAESENC AES_AVX 11011100 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 DD /r: AESENCLAST xmm1, xmm2/m128
 AESENCLAST AES 00001111 00111000 11011101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG DD /r: VAESENCLAST xmm1, xmm2, xmm3/m128
+VAESENCLAST AES_AVX 11011101 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 DB /r: AESIMC xmm1, xmm2/m128
 AESIMC AES 00001111 00111000 11011011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG DB /r: VAESIMC xmm1, xmm2/m128
+VAESIMC AES_AVX 11011011 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A DF /r ib: AESKEYGENASSIST xmm1, xmm2/m128, imm8
 AESKEYGENASSIST AES 00001111 00111010 11011111 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.WIG DF /r ib: VAESKEYGENASSIST xmm1, xmm2/m128, imm8
+VAESKEYGENASSIST AES_AVX 11011111 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 #
 # PCLMULQDQ Instructions
 # ----------------------
@@ -931,6 +1589,11 @@ PCLMULQDQ PCLMULQDQ 00001111 00111010 01000100 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.WIG 44 /r ib: VPCLMULQDQ xmm1, xmm2, xmm3/m128, imm8
+VPCLMULQDQ PCLMULQDQ_AVX 01000100 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 #
 # Comparison Instructions
 # -----------------------
@@ -946,6 +1609,11 @@ PCMPEQB SSE2 00001111 01110100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 74 /r: VPCMPEQB xmm1,xmm2,xmm3/m128
+VPCMPEQB AVX 01110100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 75 /r: PCMPEQW mm,mm/m64
 PCMPEQW MMX 00001111 01110101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -956,6 +1624,11 @@ PCMPEQW SSE2 00001111 01110101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 75 /r: VPCMPEQW xmm1,xmm2,xmm3/m128
+VPCMPEQW AVX 01110101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 76 /r: PCMPEQD mm,mm/m64
 PCMPEQD MMX 00001111 01110110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -966,11 +1639,21 @@ PCMPEQD SSE2 00001111 01110110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 76 /r: VPCMPEQD xmm1,xmm2,xmm3/m128
+VPCMPEQD AVX 01110110 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 29 /r: PCMPEQQ xmm1, xmm2/m128
 PCMPEQQ SSE4_1 00001111 00111000 00101001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 29 /r: VPCMPEQQ xmm1, xmm2, xmm3/m128
+VPCMPEQQ AVX 00101001 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 64 /r: PCMPGTB mm,mm/m64
 PCMPGTB MMX 00001111 01100100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -981,6 +1664,11 @@ PCMPGTB SSE2 00001111 01100100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 64 /r: VPCMPGTB xmm1,xmm2,xmm3/m128
+VPCMPGTB AVX 01100100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 65 /r: PCMPGTW mm,mm/m64
 PCMPGTW MMX 00001111 01100101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -991,6 +1679,11 @@ PCMPGTW SSE2 00001111 01100101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 65 /r: VPCMPGTW xmm1,xmm2,xmm3/m128
+VPCMPGTW AVX 01100101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 66 /r: PCMPGTD mm,mm/m64
 PCMPGTD MMX 00001111 01100110 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1001,76 +1694,161 @@ PCMPGTD SSE2 00001111 01100110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 66 /r: VPCMPGTD xmm1,xmm2,xmm3/m128
+VPCMPGTD AVX 01100110 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 37 /r: PCMPGTQ xmm1,xmm2/m128
 PCMPGTQ SSE4_2 00001111 00111000 00110111 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 37 /r: VPCMPGTQ xmm1, xmm2, xmm3/m128
+VPCMPGTQ AVX 00110111 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 60 /r imm8: PCMPESTRM xmm1, xmm2/m128, imm8
 PCMPESTRM SSE4_2 00001111 00111010 01100000 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.128.66.0F3A 60 /r ib: VPCMPESTRM xmm1, xmm2/m128, imm8
+VPCMPESTRM AVX 01100000 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 61 /r imm8: PCMPESTRI xmm1, xmm2/m128, imm8
 PCMPESTRI SSE4_2 00001111 00111010 01100001 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != REG_RCX)); }
 
+# VEX.128.66.0F3A 61 /r ib: VPCMPESTRI xmm1, xmm2/m128, imm8
+VPCMPESTRI AVX 01100001 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != REG_RCX)); }
+
 # 66 0F 3A 62 /r imm8: PCMPISTRM xmm1, xmm2/m128, imm8
 PCMPISTRM SSE4_2 00001111 00111010 01100010 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16); }
 
+# VEX.128.66.0F3A.WIG 62 /r ib: VPCMPISTRM xmm1, xmm2/m128, imm8
+VPCMPISTRM AVX 01100010 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 63 /r imm8: PCMPISTRI xmm1, xmm2/m128, imm8
 PCMPISTRI SSE4_2 00001111 00111010 01100011 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != REG_RCX)); }
 
+# VEX.128.66.0F3A.WIG 63 /r ib: VPCMPISTRI xmm1, xmm2/m128, imm8
+VPCMPISTRI AVX 01100011 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != REG_RCX)); }
+
 # 66 0F 38 17 /r: PTEST xmm1, xmm2/m128
 PTEST SSE4_1 00001111 00111000 00010111 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 17 /r: VPTEST xmm1, xmm2/m128
+VPTEST AVX 00010111 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
+# VEX.128.66.0F38.W0 0E /r: VTESTPS xmm1, xmm2/m128
+VTESTPS AVX 00001110 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
+# VEX.128.66.0F38.W0 0F /r: VTESTPD xmm1, xmm2/m128
+VTESTPD AVX 00001111 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F C2 /r ib: CMPPS xmm1, xmm2/m128, imm8
 CMPPS SSE 00001111 11000010 \
   !constraints { modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG C2 /r ib: VCMPPS xmm1, xmm2, xmm3/m128, imm8
+VCMPPS AVX 11000010 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F C2 /r ib: CMPPD xmm1, xmm2/m128, imm8
 CMPPD SSE2 00001111 11000010 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG C2 /r ib: VCMPPD xmm1, xmm2, xmm3/m128, imm8
+VCMPPD AVX 11000010 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F C2 /r ib: CMPSS xmm1, xmm2/m32, imm8
 CMPSS SSE 00001111 11000010 \
   !constraints { rep($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.F3.0F.WIG C2 /r ib: VCMPSS xmm1, xmm2, xmm3/m32, imm8
+VCMPSS AVX 11000010 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 4); }
+
 # F2 0F C2 /r ib: CMPSD xmm1, xmm2/m64, imm8
 CMPSD SSE2 00001111 11000010 \
   !constraints { repne($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 8); }
 
+# VEX.LIG.F2.0F.WIG C2 /r ib: VCMPSD xmm1, xmm2, xmm3/m64, imm8
+VCMPSD AVX 11000010 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF2); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 2E /r: UCOMISS xmm1, xmm2/m32
 UCOMISS SSE 00001111 00101110 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.0F.WIG 2E /r: VUCOMISS xmm1, xmm2/m32
+VUCOMISS AVX 00101110 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # 66 0F 2E /r: UCOMISD xmm1, xmm2/m64
 UCOMISD SSE2 00001111 00101110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.LIG.66.0F.WIG 2E /r: VUCOMISD xmm1, xmm2/m64
+VUCOMISD AVX 00101110 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 2F /r: COMISS xmm1, xmm2/m32
 COMISS SSE 00001111 00101111 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.0F.WIG 2F /r: VCOMISS xmm1, xmm2/m32
+VCOMISS AVX 00101111 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # 66 0F 2F /r: COMISD xmm1, xmm2/m64
 COMISD SSE2 00001111 00101111 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.LIG.66.0F.WIG 2F /r: VCOMISD xmm1, xmm2/m64
+VCOMISD AVX 00101111 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 #
 # Logical Instructions
 # --------------------
@@ -1086,16 +1864,31 @@ PAND SSE2 00001111 11011011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG DB /r: VPAND xmm1, xmm2, xmm3/m128
+VPAND AVX 11011011 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 54 /r: ANDPS xmm1, xmm2/m128
 ANDPS SSE 00001111 01010100 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F 54 /r: VANDPS xmm1,xmm2, xmm3/m128
+VANDPS AVX 01010100 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 54 /r: ANDPD xmm1, xmm2/m128
 ANDPD SSE2 00001111 01010100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F 54 /r: VANDPD xmm1, xmm2, xmm3/m128
+VANDPD AVX 01010100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F DF /r: PANDN mm, mm/m64
 PANDN MMX 00001111 11011111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1106,16 +1899,31 @@ PANDN SSE2 00001111 11011111 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG DF /r: VPANDN xmm1, xmm2, xmm3/m128
+VPANDN AVX 11011111 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 55 /r: ANDNPS xmm1, xmm2/m128
 ANDNPS SSE 00001111 01010101 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F 55 /r: VANDNPS xmm1, xmm2, xmm3/m128
+VANDNPS AVX 01010101 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 55 /r: ANDNPD xmm1, xmm2/m128
 ANDNPD SSE2 00001111 01010101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F 55 /r: VANDNPD xmm1, xmm2, xmm3/m128
+VANDNPD AVX 01010101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F EB /r: POR mm, mm/m64
 POR MMX 00001111 11101011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1126,16 +1934,31 @@ POR SSE2 00001111 11101011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG EB /r: VPOR xmm1, xmm2, xmm3/m128
+VPOR AVX 11101011 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 56 /r: ORPS xmm1, xmm2/m128
 ORPS SSE 00001111 01010110 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F 56 /r: VORPS xmm1,xmm2, xmm3/m128
+VORPS AVX 01010110 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 56 /r: ORPD xmm1, xmm2/m128
 ORPD SSE2 00001111 01010110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F 56 /r: VORPD xmm1,xmm2, xmm3/m128
+VORPD AVX 01010110 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F EF /r: PXOR mm, mm/m64
 PXOR MMX 00001111 11101111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1146,16 +1969,31 @@ PXOR SSE2 00001111 11101111 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG EF /r: VPXOR xmm1, xmm2, xmm3/m128
+VPXOR AVX 11101111 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 57 /r: XORPS xmm1, xmm2/m128
 XORPS SSE 00001111 01010111 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 57 /r: VXORPS xmm1,xmm2, xmm3/m128
+VXORPS AVX 01010111 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 57 /r: XORPD xmm1, xmm2/m128
 XORPD SSE2 00001111 01010111 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 57 /r: VXORPD xmm1,xmm2, xmm3/m128
+VXORPD AVX 01010111 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 #
 # Shift and Rotate Instructions
 # -----------------------------
@@ -1171,6 +2009,11 @@ PSLLW SSE2 00001111 11110001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG F1 /r: VPSLLW xmm1, xmm2, xmm3/m128
+VPSLLW AVX 11110001 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F F2 /r: PSLLD mm, mm/m64
 PSLLD MMX 00001111 11110010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1181,6 +2024,11 @@ PSLLD SSE2 00001111 11110010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG F2 /r: VPSLLD xmm1, xmm2, xmm3/m128
+VPSLLD AVX 11110010 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F F3 /r: PSLLQ mm, mm/m64
 PSLLQ MMX 00001111 11110011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1191,6 +2039,11 @@ PSLLQ SSE2 00001111 11110011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG F3 /r: VPSLLQ xmm1, xmm2, xmm3/m128
+VPSLLQ AVX 11110011 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 71 /6 ib: PSLLW mm1, imm8
 PSLLW_imm MMX 00001111 01110001 \
   !constraints { modrm($_, reg => 6); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -1199,6 +2052,10 @@ PSLLW_imm MMX 00001111 01110001 \
 PSLLW_imm SSE2 00001111 01110001 \
   !constraints { data16($_); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.128.66.0F.WIG 71 /6 ib: VPSLLW xmm1, xmm2, imm8
+VPSLLW_imm AVX 01110001 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 72 /6 ib: PSLLD mm, imm8
 PSLLD_imm MMX 00001111 01110010 \
   !constraints { modrm($_, reg => 6); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -1207,6 +2064,10 @@ PSLLD_imm MMX 00001111 01110010 \
 PSLLD_imm SSE2 00001111 01110010 \
   !constraints { data16($_); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.128.66.0F.WIG 72 /6 ib: VPSLLD xmm1, xmm2, imm8
+VPSLLD_imm AVX 01110010 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 73 /6 ib: PSLLQ mm, imm8
 PSLLQ_imm MMX 00001111 01110011 \
   !constraints { modrm($_, reg => 6); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -1215,10 +2076,18 @@ PSLLQ_imm MMX 00001111 01110011 \
 PSLLQ_imm SSE2 00001111 01110011 \
   !constraints { data16($_); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.128.66.0F.WIG 73 /6 ib: VPSLLQ xmm1, xmm2, imm8
+VPSLLQ_imm AVX 01110011 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 6); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # 66 0F 73 /7 ib: PSLLDQ xmm1, imm8
 PSLLDQ_imm SSE2 00001111 01110011 \
   !constraints { data16($_); modrm($_, reg => 7); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.128.66.0F.WIG 73 /7 ib: VPSLLDQ xmm1, xmm2, imm8
+VPSLLDQ_imm AVX 01110011 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 7); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F D1 /r: PSRLW mm, mm/m64
 PSRLW MMX 00001111 11010001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1229,6 +2098,11 @@ PSRLW SSE2 00001111 11010001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG D1 /r: VPSRLW xmm1, xmm2, xmm3/m128
+VPSRLW AVX 11010001 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F D2 /r: PSRLD mm, mm/m64
 PSRLD MMX 00001111 11010010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1239,6 +2113,11 @@ PSRLD SSE2 00001111 11010010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG D2 /r: VPSRLD xmm1, xmm2, xmm3/m128
+VPSRLD AVX 11010010 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F D3 /r: PSRLQ mm, mm/m64
 PSRLQ MMX 00001111 11010011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1249,6 +2128,11 @@ PSRLQ SSE2 00001111 11010011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG D3 /r: VPSRLQ xmm1, xmm2, xmm3/m128
+VPSRLQ AVX 11010011 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 71 /2 ib: PSRLW mm, imm8
 PSRLW_imm MMX 00001111 01110001 \
   !constraints { modrm($_, reg => 2); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -1257,6 +2141,10 @@ PSRLW_imm MMX 00001111 01110001 \
 PSRLW_imm SSE2 00001111 01110001 \
   !constraints { data16($_); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.128.66.0F.WIG 71 /2 ib: VPSRLW xmm1, xmm2, imm8
+VPSRLW_imm AVX 01110001 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 72 /2 ib: PSRLD mm, imm8
 PSRLD_imm MMX 00001111 01110010 \
   !constraints { modrm($_, reg => 2); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -1265,6 +2153,10 @@ PSRLD_imm MMX 00001111 01110010 \
 PSRLD_imm SSE2 00001111 01110010 \
   !constraints { data16($_); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.128.66.0F.WIG 72 /2 ib: VPSRLD xmm1, xmm2, imm8
+VPSRLD_imm AVX 01110010 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 73 /2 ib: PSRLQ mm, imm8
 PSRLQ_imm MMX 00001111 01110011 \
   !constraints { modrm($_, reg => 2); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -1273,10 +2165,18 @@ PSRLQ_imm MMX 00001111 01110011 \
 PSRLQ_imm SSE2 00001111 01110011 \
   !constraints { data16($_); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.128.66.0F.WIG 73 /2 ib: VPSRLQ xmm1, xmm2, imm8
+VPSRLQ_imm AVX 01110011 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 2); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # 66 0F 73 /3 ib: PSRLDQ xmm1, imm8
 PSRLDQ_imm SSE2 00001111 01110011 \
   !constraints { data16($_); modrm($_, reg => 3); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.128.66.0F.WIG 73 /3 ib: VPSRLDQ xmm1, xmm2, imm8
+VPSRLDQ_imm AVX 01110011 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 3); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F E1 /r: PSRAW mm,mm/m64
 PSRAW MMX 00001111 11100001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1287,6 +2187,11 @@ PSRAW SSE2 00001111 11100001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG E1 /r: VPSRAW xmm1,xmm2,xmm3/m128
+VPSRAW AVX 11100001 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F E2 /r: PSRAD mm,mm/m64
 PSRAD MMX 00001111 11100010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1297,6 +2202,11 @@ PSRAD SSE2 00001111 11100010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG E2 /r: VPSRAD xmm1,xmm2,xmm3/m128
+VPSRAD AVX 11100010 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 71 /4 ib: PSRAW mm,imm8
 PSRAW_imm MMX 00001111 01110001 \
   !constraints { modrm($_, reg => 4); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -1305,6 +2215,10 @@ PSRAW_imm MMX 00001111 01110001 \
 PSRAW_imm SSE2 00001111 01110001 \
   !constraints { data16($_); modrm($_, reg => 4); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.128.66.0F.WIG 71 /4 ib: VPSRAW xmm1,xmm2,imm8
+VPSRAW_imm AVX 01110001 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 4); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 72 /4 ib: PSRAD mm,imm8
 PSRAD_imm MMX 00001111 01110010 \
   !constraints { modrm($_, reg => 4); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
@@ -1313,6 +2227,10 @@ PSRAD_imm MMX 00001111 01110010 \
 PSRAD_imm SSE2 00001111 01110010 \
   !constraints { data16($_); modrm($_, reg => 4); imm($_, width => 8); defined $_->{modrm}{reg2} }
 
+# VEX.128.66.0F.WIG 72 /4 ib: VPSRAD xmm1,xmm2,imm8
+VPSRAD_imm AVX 01110010 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_, reg => 4); imm($_, width => 8); defined $_->{modrm}{reg2} }
+
 # NP 0F 3A 0F /r ib: PALIGNR mm1, mm2/m64, imm8
 PALIGNR_mm SSSE3 00001111 00111010 00001111 \
   !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1323,6 +2241,11 @@ PALIGNR SSSE3 00001111 00111010 00001111 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.WIG 0F /r ib: VPALIGNR xmm1, xmm2, xmm3/m128, imm8
+VPALIGNR AVX 00001111 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 #
 # Shuffle, Unpack, Blend, Insert, Extract, Broadcast, Permute, Gather Instructions
 # --------------------------------------------------------------------------------
@@ -1338,6 +2261,11 @@ PACKSSWB SSE2 00001111 01100011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 63 /r: VPACKSSWB xmm1,xmm2, xmm3/m128
+VPACKSSWB AVX 01100011 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 6B /r: PACKSSDW mm1, mm2/m64
 PACKSSDW MMX 00001111 01101011 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1348,6 +2276,11 @@ PACKSSDW SSE2 00001111 01101011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 6B /r: VPACKSSDW xmm1,xmm2, xmm3/m128
+VPACKSSDW AVX 01101011 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 67 /r: PACKUSWB mm, mm/m64
 PACKUSWB MMX 00001111 01100111 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1358,11 +2291,21 @@ PACKUSWB SSE2 00001111 01100111 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 67 /r: VPACKUSWB xmm1, xmm2, xmm3/m128
+VPACKUSWB AVX 01100111 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 2B /r: PACKUSDW xmm1, xmm2/m128
 PACKUSDW SSE4_1 00001111 00111000 00101011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38 2B /r: VPACKUSDW xmm1,xmm2, xmm3/m128
+VPACKUSDW AVX 00101011 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 68 /r: PUNPCKHBW mm, mm/m64
 PUNPCKHBW MMX 00001111 01101000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1373,6 +2316,11 @@ PUNPCKHBW SSE2 00001111 01101000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 68 /r: VPUNPCKHBW xmm1,xmm2, xmm3/m128
+VPUNPCKHBW AVX 01101000 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 69 /r: PUNPCKHWD mm, mm/m64
 PUNPCKHWD MMX 00001111 01101001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1383,6 +2331,11 @@ PUNPCKHWD SSE2 00001111 01101001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 69 /r: VPUNPCKHWD xmm1,xmm2, xmm3/m128
+VPUNPCKHWD AVX 01101001 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 6A /r: PUNPCKHDQ mm, mm/m64
 PUNPCKHDQ MMX 00001111 01101010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1393,11 +2346,21 @@ PUNPCKHDQ SSE2 00001111 01101010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 6A /r: VPUNPCKHDQ xmm1, xmm2, xmm3/m128
+VPUNPCKHDQ AVX 01101010 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 6D /r: PUNPCKHQDQ xmm1, xmm2/m128
 PUNPCKHQDQ SSE2 00001111 01101101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 6D /r: VPUNPCKHQDQ xmm1, xmm2, xmm3/m128
+VPUNPCKHQDQ AVX 01101101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 60 /r: PUNPCKLBW mm, mm/m32
 PUNPCKLBW MMX 00001111 01100000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1408,6 +2371,11 @@ PUNPCKLBW SSE2 00001111 01100000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 60 /r: VPUNPCKLBW xmm1,xmm2, xmm3/m128
+VPUNPCKLBW AVX 01100000 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 61 /r: PUNPCKLWD mm, mm/m32
 PUNPCKLWD MMX 00001111 01100001 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1418,6 +2386,11 @@ PUNPCKLWD SSE2 00001111 01100001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 61 /r: VPUNPCKLWD xmm1,xmm2, xmm3/m128
+VPUNPCKLWD AVX 01100001 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 62 /r: PUNPCKLDQ mm, mm/m32
 PUNPCKLDQ MMX 00001111 01100010 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1428,31 +2401,61 @@ PUNPCKLDQ SSE2 00001111 01100010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 62 /r: VPUNPCKLDQ xmm1, xmm2, xmm3/m128
+VPUNPCKLDQ AVX 01100010 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 6C /r: PUNPCKLQDQ xmm1, xmm2/m128
 PUNPCKLQDQ SSE2 00001111 01101100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 6C /r: VPUNPCKLQDQ xmm1, xmm2, xmm3/m128
+VPUNPCKLQDQ AVX 01101100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 14 /r: UNPCKLPS xmm1, xmm2/m128
 UNPCKLPS SSE 00001111 00010100 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 14 /r: VUNPCKLPS xmm1,xmm2, xmm3/m128
+VUNPCKLPS AVX 00010100 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 14 /r: UNPCKLPD xmm1, xmm2/m128
 UNPCKLPD SSE2 00001111 00010100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 14 /r: VUNPCKLPD xmm1,xmm2, xmm3/m128
+VUNPCKLPD AVX 00010100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 15 /r: UNPCKHPS xmm1, xmm2/m128
 UNPCKHPS SSE 00001111 00010101 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 15 /r: VUNPCKHPS xmm1, xmm2, xmm3/m128
+VUNPCKHPS AVX 00010101 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 15 /r: UNPCKHPD xmm1, xmm2/m128
 UNPCKHPD SSE2 00001111 00010101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 15 /r: VUNPCKHPD xmm1,xmm2, xmm3/m128
+VUNPCKHPD AVX 00010101 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 38 00 /r: PSHUFB mm1, mm2/m64
 PSHUFB_mm SSSE3 00001111 00111000 00000000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1463,6 +2466,11 @@ PSHUFB SSSE3 00001111 00111000 00000000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 00 /r: VPSHUFB xmm1, xmm2, xmm3/m128
+VPSHUFB AVX 00000000 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F 70 /r ib: PSHUFW mm1, mm2/m64, imm8
 PSHUFW SSE 00001111 01110000 \
   !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1473,66 +2481,131 @@ PSHUFLW SSE2 00001111 01110000 \
   !constraints { repne($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.F2.0F.WIG 70 /r ib: VPSHUFLW xmm1, xmm2/m128, imm8
+VPSHUFLW AVX 01110000 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF2); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F 70 /r ib: PSHUFHW xmm1, xmm2/m128, imm8
 PSHUFHW SSE2 00001111 01110000 \
   !constraints { rep($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.F3.0F.WIG 70 /r ib: VPSHUFHW xmm1, xmm2/m128, imm8
+VPSHUFHW AVX 01110000 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF3); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 70 /r ib: PSHUFD xmm1, xmm2/m128, imm8
 PSHUFD SSE2 00001111 01110000 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 70 /r ib: VPSHUFD xmm1, xmm2/m128, imm8
+VPSHUFD AVX 01110000 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # NP 0F C6 /r ib: SHUFPS xmm1, xmm3/m128, imm8
 SHUFPS SSE 00001111 11000110 \
   !constraints { modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG C6 /r ib: VSHUFPS xmm1, xmm2, xmm3/m128, imm8
+VSHUFPS AVX 11000110 \
+  !constraints { vex($_, m => 0x0F, l => 128); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F C6 /r ib: SHUFPD xmm1, xmm2/m128, imm8
 SHUFPD SSE2 00001111 11000110 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG C6 /r ib: VSHUFPD xmm1, xmm2, xmm3/m128, imm8
+VSHUFPD AVX 11000110 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 0C /r ib: BLENDPS xmm1, xmm2/m128, imm8
 BLENDPS SSE4_1 00001111 00111010 00001100 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.WIG 0C /r ib: VBLENDPS xmm1, xmm2, xmm3/m128, imm8
+VBLENDPS AVX 00001100 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 0D /r ib: BLENDPD xmm1, xmm2/m128, imm8
 BLENDPD SSE4_1 00001111 00111010 00001101 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.WIG 0D /r ib: VBLENDPD xmm1, xmm2, xmm3/m128, imm8
+VBLENDPD AVX 00001101 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 14 /r: BLENDVPS xmm1, xmm2/m128, <XMM0>
 BLENDVPS SSE4_1 00001111 00111000 00010100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.W0 4A /r /is4: VBLENDVPS xmm1, xmm2, xmm3/m128, xmm4
+VBLENDVPS AVX 01001010 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 15 /r: BLENDVPD xmm1, xmm2/m128 , <XMM0>
 BLENDVPD SSE4_1 00001111 00111000 00010101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.W0 4B /r /is4: VBLENDVPD xmm1, xmm2, xmm3/m128, xmm4
+VBLENDVPD AVX 01001011 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 38 10 /r: PBLENDVB xmm1, xmm2/m128, <XMM0>
 PBLENDVB SSE4_1 00001111 00111000 00010000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.W0 4C /r /is4: VPBLENDVB xmm1, xmm2, xmm3/m128, xmm4
+VPBLENDVB AVX 01001100 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 0E /r ib: PBLENDW xmm1, xmm2/m128, imm8
 PBLENDW SSE4_1 00001111 00111010 00001110 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F3A.WIG 0E /r ib: VPBLENDW xmm1, xmm2, xmm3/m128, imm8
+VPBLENDW AVX 00001110 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 3A 21 /r ib: INSERTPS xmm1, xmm2/m32, imm8
 INSERTPS SSE4_1 00001111 00111010 00100001 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 4); }
 
+# VEX.128.66.0F3A.WIG 21 /r ib: VINSERTPS xmm1, xmm2, xmm3/m32, imm8
+VINSERTPS AVX 00100001 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 4); }
+
 # 66 0F 3A 20 /r ib: PINSRB xmm1,r32/m8,imm8
 PINSRB SSE4_1 00001111 00111010 00100000 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { load(size => 1); }
 
+# VEX.128.66.0F3A.W0 20 /r ib: VPINSRB xmm1,xmm2,r32/m8,imm8
+VPINSRB AVX 00100000 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66, w => 0); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 1); }
+
 # NP 0F C4 /r ib: PINSRW mm, r32/m16, imm8
 PINSRW SSE 00001111 11000100 \
   !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg} &= 0b111; !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
@@ -1543,41 +2616,81 @@ PINSRW SSE2 00001111 11000100 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { load(size => 2); }
 
+# VEX.128.66.0F.W0 C4 /r ib: VPINSRW xmm1, xmm2, r32/m16, imm8
+VPINSRW AVX 11000100 \
+  !constraints { vex($_, m => 0x0F, l => 128, p => 0x66, w => 0); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 2); }
+
 # 66 0F 3A 22 /r ib: PINSRD xmm1,r/m32,imm8
 PINSRD SSE4_1 00001111 00111010 00100010 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { load(size => 4); }
 
+# VEX.128.66.0F3A.W0 22 /r ib: VPINSRD xmm1,xmm2,r/m32,imm8
+VPINSRD AVX 00100010 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66, w => 0); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 4); }
+
 # 66 REX.W 0F 3A 22 /r ib: PINSRQ xmm1,r/m64,imm8
 PINSRQ SSE4_1 00001111 00111010 00100010 \
   !constraints { data16($_); rex($_, w => 1); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { load(size => 8); }
 
+# VEX.128.66.0F3A.W1 22 /r ib: VPINSRQ xmm1,xmm2,r/m64,imm8
+VPINSRQ AVX 00100010 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, p => 0x66, w => 1); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 8); }
+
 # 66 0F 3A 17 /r ib: EXTRACTPS reg/m32, xmm1, imm8
 EXTRACTPS SSE4_1 00001111 00111010 00010111 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { store(size => 4); }
 
+# VEX.128.66.0F3A.WIG 17 /r ib: VEXTRACTPS reg/m32, xmm1, imm8
+VEXTRACTPS AVX 00010111 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { store(size => 4); }
+
 # 66 0F 3A 14 /r ib: PEXTRB reg/m8,xmm2,imm8
 PEXTRB SSE4_1 00001111 00111010 00010100 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { store(size => 1); }
 
+# VEX.128.66.0F3A.W0 14 /r ib: VPEXTRB reg/m8,xmm2,imm8
+VPEXTRB AVX 00010100 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66, w => 0); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { store(size => 1); }
+
 # 66 0F 3A 15 /r ib: PEXTRW reg/m16, xmm, imm8
 PEXTRW SSE4_1 00001111 00111010 00010101 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { store(size => 2); }
 
+# VEX.128.66.0F3A.W0 15 /r ib: VPEXTRW reg/m16, xmm2, imm8
+VPEXTRW AVX 00010101 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66, w => 0); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { store(size => 2); }
+
 # 66 0F 3A 16 /r ib: PEXTRD r/m32,xmm2,imm8
 PEXTRD SSE4_1 00001111 00111010 00010110 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { store(size => 4); }
 
+# VEX.128.66.0F3A.W0 16 /r ib: VPEXTRD r32/m32,xmm2,imm8
+VPEXTRD AVX 00010110 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66, w => 0); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { store(size => 4); }
+
 # 66 REX.W 0F 3A 16 /r ib: PEXTRQ r/m64,xmm2,imm8
 PEXTRQ SSE4_1 00001111 00111010 00010110 \
   !constraints { data16($_); rex($_, w => 1); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { store(size => 8); }
 
+# VEX.128.66.0F3A.W1 16 /r ib: VPEXTRQ r64/m64,xmm2,imm8
+VPEXTRQ AVX 00010110 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66, w => 1); modrm($_); imm($_, width => 8); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { store(size => 8); }
+
 # NP 0F C5 /r ib: PEXTRW reg, mm, imm8
 PEXTRW_reg SSE 00001111 11000101 \
   !constraints { modrm($_); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
@@ -1586,6 +2699,30 @@ PEXTRW_reg SSE 00001111 11000101 \
 PEXTRW_reg SSE2 00001111 11000101 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
 
+# VEX.128.66.0F.W0 C5 /r ib: VPEXTRW reg, xmm1, imm8
+VPEXTRW_reg AVX 11000101 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66, w => 0); modrm($_); imm($_, width => 8); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
+
+# VEX.128.66.0F38.W0 0C /r: VPERMILPS xmm1, xmm2, xmm3/m128
+VPERMILPS AVX 00001100 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
+# VEX.128.66.0F3A.W0 04 /r ib: VPERMILPS xmm1, xmm2/m128, imm8
+VPERMILPS_imm AVX 00000100 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
+# VEX.128.66.0F38.W0 0D /r: VPERMILPD xmm1, xmm2, xmm3/m128
+VPERMILPD AVX 00001101 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
+# VEX.128.66.0F3A.W0 05 /r ib: VPERMILPD xmm1, xmm2/m128, imm8
+VPERMILPD_imm AVX 00000101 \
+  !constraints { vex($_, m => 0x0F3A, l => 128, v => 0, p => 0x66, w => 0); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16); }
+
 #
 # Conversion Instructions
 # -----------------------
@@ -1596,61 +2733,121 @@ PMOVSXBW SSE4_1 00001111 00111000 00100000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.128.66.0F38.WIG 20 /r: VPMOVSXBW xmm1, xmm2/m64
+VPMOVSXBW AVX 00100000 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # 66 0f 38 21 /r: PMOVSXBD xmm1, xmm2/m32
 PMOVSXBD SSE4_1 00001111 00111000 00100001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.128.66.0F38.WIG 21 /r: VPMOVSXBD xmm1, xmm2/m32
+VPMOVSXBD AVX 00100001 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # 66 0f 38 22 /r: PMOVSXBQ xmm1, xmm2/m16
 PMOVSXBQ SSE4_1 00001111 00111000 00100010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 2); }
 
+# VEX.128.66.0F38.WIG 22 /r: VPMOVSXBQ xmm1, xmm2/m16
+VPMOVSXBQ AVX 00100010 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 2); }
+
 # 66 0f 38 23 /r: PMOVSXWD xmm1, xmm2/m64
 PMOVSXWD SSE4_1 00001111 00111000 00100011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.128.66.0F38.WIG 23 /r: VPMOVSXWD xmm1, xmm2/m64
+VPMOVSXWD AVX 00100011 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # 66 0f 38 24 /r: PMOVSXWQ xmm1, xmm2/m32
 PMOVSXWQ SSE4_1 00001111 00111000 00100100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.128.66.0F38.WIG 24 /r: VPMOVSXWQ xmm1, xmm2/m32
+VPMOVSXWQ AVX 00100100 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # 66 0f 38 25 /r: PMOVSXDQ xmm1, xmm2/m64
 PMOVSXDQ SSE4_1 00001111 00111000 00100101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.128.66.0F38.WIG 25 /r: VPMOVSXDQ xmm1, xmm2/m64
+VPMOVSXDQ AVX 00100101 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # 66 0f 38 30 /r: PMOVZXBW xmm1, xmm2/m64
 PMOVZXBW SSE4_1 00001111 00111000 00110000 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.128.66.0F38.WIG 30 /r: VPMOVZXBW xmm1, xmm2/m64
+VPMOVZXBW AVX 00110000 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # 66 0f 38 31 /r: PMOVZXBD xmm1, xmm2/m32
 PMOVZXBD SSE4_1 00001111 00111000 00110001 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.128.66.0F38.WIG 31 /r: VPMOVZXBD xmm1, xmm2/m32
+VPMOVZXBD AVX 00110001 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # 66 0f 38 32 /r: PMOVZXBQ xmm1, xmm2/m16
 PMOVZXBQ SSE4_1 00001111 00111000 00110010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 2); }
 
+# VEX.128.66.0F38.WIG 32 /r: VPMOVZXBQ xmm1, xmm2/m16
+VPMOVZXBQ AVX 00110010 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 2); }
+
 # 66 0f 38 33 /r: PMOVZXWD xmm1, xmm2/m64
 PMOVZXWD SSE4_1 00001111 00111000 00110011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.128.66.0F38.WIG 33 /r: VPMOVZXWD xmm1, xmm2/m64
+VPMOVZXWD AVX 00110011 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # 66 0f 38 34 /r: PMOVZXWQ xmm1, xmm2/m32
 PMOVZXWQ SSE4_1 00001111 00111000 00110100 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.128.66.0F38.WIG 34 /r: VPMOVZXWQ xmm1, xmm2/m32
+VPMOVZXWQ AVX 00110100 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # 66 0f 38 35 /r: PMOVZXDQ xmm1, xmm2/m64
 PMOVZXDQ SSE4_1 00001111 00111000 00110101 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.128.66.0F38.WIG 35 /r: VPMOVZXDQ xmm1, xmm2/m64
+VPMOVZXDQ AVX 00110101 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 2A /r: CVTPI2PS xmm, mm/m64
 CVTPI2PS SSE 00001111 00101010 \
   !constraints { modrm($_); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1666,6 +2863,16 @@ CVTSI2SS_64 SSE2 00001111 00101010 \
   !constraints { rep($_); rex($_, w => 1); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { load(size => 8); }
 
+# VEX.LIG.F3.0F.W0 2A /r: VCVTSI2SS xmm1,xmm2,r/m32
+VCVTSI2SS AVX 00101010 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3, w => 0); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 4); }
+
+# VEX.LIG.F3.0F.W1 2A /r: VCVTSI2SS xmm1,xmm2,r/m64
+VCVTSI2SS_64 AVX 00101010 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3, w => 1); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 8); }
+
 # 66 0F 2A /r: CVTPI2PD xmm, mm/m64
 CVTPI2PD SSE2 00001111 00101010 \
   !constraints { data16($_); modrm($_); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -1681,6 +2888,16 @@ CVTSI2SD_64 SSE2 00001111 00101010 \
   !constraints { repne($_); rex($_, w => 1); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
   !memory { load(size => 8); }
 
+# VEX.LIG.F2.0F.W0 2A /r: VCVTSI2SD xmm1,xmm2,r/m32
+VCVTSI2SD AVX 00101010 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF2, w => 0); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 4); }
+
+# VEX.LIG.F2.0F.W1 2A /r: VCVTSI2SD xmm1,xmm2,r/m64
+VCVTSI2SD_64 AVX 00101010 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF2, w => 1); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { load(size => 8); }
+
 # NP 0F 2D /r: CVTPS2PI mm, xmm/m64
 CVTPS2PI SSE 00001111 00101101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; 1 } \
@@ -1696,6 +2913,16 @@ CVTSS2SI_64 SSE2 00001111 00101101 \
   !constraints { rep($_); rex($_, w => 1); modrm($_); $_->{modrm}{reg} != REG_RSP } \
   !memory { load(size => 4, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
 
+# VEX.LIG.F3.0F.W0 2D /r: VCVTSS2SI r32,xmm1/m32
+VCVTSS2SI AVX 00101101 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0, p => 0xF3, w => 0); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 4, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
+# VEX.LIG.F3.0F.W1 2D /r: VCVTSS2SI r64,xmm1/m32
+VCVTSS2SI_64 AVX 00101101 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0, p => 0xF3, w => 1); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 4, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
 # 66 0F 2D /r: CVTPD2PI mm, xmm/m128
 CVTPD2PI SSE2 00001111 00101101 \
   !constraints { data16($_); modrm($_); $_->{modrm}{reg} &= 0b111; 1 } \
@@ -1711,6 +2938,16 @@ CVTSD2SI_64 SSE2 00001111 00101101 \
   !constraints { repne($_); rex($_, w => 1); modrm($_); $_->{modrm}{reg} != REG_RSP } \
   !memory { load(size => 8, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
 
+# VEX.LIG.F2.0F.W0 2D /r: VCVTSD2SI r32,xmm1/m64
+VCVTSD2SI AVX 00101101 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0, p => 0xF2, w => 0); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 8, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
+# VEX.LIG.F2.0F.W1 2D /r: VCVTSD2SI r64,xmm1/m64
+VCVTSD2SI_64 AVX 00101101 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0, p => 0xF2, w => 1); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 8, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
 # NP 0F 2C /r: CVTTPS2PI mm, xmm/m64
 CVTTPS2PI SSE 00001111 00101100 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; 1 } \
@@ -1726,6 +2963,16 @@ CVTTSS2SI_64 SSE2 00001111 00101100 \
   !constraints { rep($_); rex($_, w => 1); modrm($_); $_->{modrm}{reg} != REG_RSP } \
   !memory { load(size => 4, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
 
+# VEX.LIG.F3.0F.W0 2C /r: VCVTTSS2SI r32,xmm1/m32
+VCVTTSS2SI AVX 00101100 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0, p => 0xF3, w => 0); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 4, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
+# VEX.LIG.F3.0F.W1 2C /r: VCVTTSS2SI r64,xmm1/m32
+VCVTTSS2SI_64 AVX 00101100 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0, p => 0xF3, w => 1); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 4, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
 # 66 0F 2C /r: CVTTPD2PI mm, xmm/m128
 CVTTPD2PI SSE2 00001111 00101100 \
   !constraints { data16($_); modrm($_); $_->{modrm}{reg} &= 0b111; 1 } \
@@ -1741,56 +2988,116 @@ CVTTSD2SI_64 SSE2 00001111 00101100 \
   !constraints { repne($_); rex($_, w => 1); modrm($_); $_->{modrm}{reg} != REG_RSP } \
   !memory { load(size => 8, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
 
+# VEX.LIG.F2.0F.W0 2C /r: VCVTTSD2SI r32,xmm1/m64
+VCVTTSD2SI AVX 00101100 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0, p => 0xF2, w => 0); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 8, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
+# VEX.LIG.F2.0F.W1 2C /r: VCVTTSD2SI r64,xmm1/m64
+VCVTTSD2SI_64 AVX 00101100 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0, p => 0xF2, w => 1); modrm($_); $_->{modrm}{reg} != REG_RSP } \
+  !memory { load(size => 8, rollback => (defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg})); }
+
 # F2 0F E6 /r: CVTPD2DQ xmm1, xmm2/m128
 CVTPD2DQ SSE2 00001111 11100110 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.F2.0F.WIG E6 /r: VCVTPD2DQ xmm1, xmm2/m128
+VCVTPD2DQ AVX 11100110 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F E6 /r: CVTTPD2DQ xmm1, xmm2/m128
 CVTTPD2DQ SSE2 00001111 11100110 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG E6 /r: VCVTTPD2DQ xmm1, xmm2/m128
+VCVTTPD2DQ AVX 11100110 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F E6 /r: CVTDQ2PD xmm1, xmm2/m64
 CVTDQ2PD SSE2 00001111 11100110 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.128.F3.0F.WIG E6 /r: VCVTDQ2PD xmm1, xmm2/m64
+VCVTDQ2PD AVX 11100110 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 5A /r: CVTPS2PD xmm1, xmm2/m64
 CVTPS2PD SSE2 00001111 01011010 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.128.0F.WIG 5A /r: VCVTPS2PD xmm1, xmm2/m64
+VCVTPS2PD AVX 01011010 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # 66 0F 5A /r: CVTPD2PS xmm1, xmm2/m128
 CVTPD2PS SSE2 00001111 01011010 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 5A /r: VCVTPD2PS xmm1, xmm2/m128
+VCVTPD2PS AVX 01011010 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F 5A /r: CVTSS2SD xmm1, xmm2/m32
 CVTSS2SD SSE2 00001111 01011010 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 4); }
 
+# VEX.LIG.F3.0F.WIG 5A /r: VCVTSS2SD xmm1, xmm2, xmm3/m32
+VCVTSS2SD AVX 01011010 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 4); }
+
 # F2 0F 5A /r: CVTSD2SS xmm1, xmm2/m64
 CVTSD2SS SSE2 00001111 01011010 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# VEX.LIG.F2.0F.WIG 5A /r: VCVTSD2SS xmm1,xmm2, xmm3/m64
+VCVTSD2SS AVX 01011010 \
+  !constraints { vex($_, m => 0x0F, l => 0, p => 0xF2); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 # NP 0F 5B /r: CVTDQ2PS xmm1, xmm2/m128
 CVTDQ2PS SSE2 00001111 01011011 \
   !constraints { modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 5B /r: VCVTDQ2PS xmm1, xmm2/m128
+VCVTDQ2PS AVX 01011011 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # 66 0F 5B /r: CVTPS2DQ xmm1, xmm2/m128
 CVTPS2DQ SSE2 00001111 01011011 \
   !constraints { data16($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 5B /r: VCVTPS2DQ xmm1, xmm2/m128
+VCVTPS2DQ AVX 01011011 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 # F3 0F 5B /r: CVTTPS2DQ xmm1, xmm2/m128
 CVTTPS2DQ SSE2 00001111 01011011 \
   !constraints { rep($_); modrm($_); 1 } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.F3.0F.WIG 5B /r: VCVTTPS2DQ xmm1, xmm2/m128
+VCVTTPS2DQ AVX 01011011 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0xF3); modrm($_); 1 } \
+  !memory { load(size => 16); }
+
 #
 # Cacheability Control, Prefetch, and Instruction Ordering Instructions
 # ---------------------------------------------------------------------
@@ -1806,16 +3113,43 @@ MASKMOVDQU SSE2 00001111 11110111 \
   !constraints { data16($_); modrm($_); defined $_->{modrm}{reg2} } \
   !memory { load(size => 16, base => REG_RDI, rollback => 1); }
 
+# VEX.128.66.0F.WIG F7 /r: VMASKMOVDQU xmm1, xmm2
+VMASKMOVDQU AVX 11110111 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); defined $_->{modrm}{reg2} } \
+  !memory { load(size => 16, base => REG_RDI, rollback => 1); }
+
+# VEX.128.66.0F38.W0 2C /r: VMASKMOVPS xmm1, xmm2, m128
+# VEX.128.66.0F38.W0 2E /r: VMASKMOVPS m128, xmm1, xmm2
+VMASKMOVPS AVX 001011 d 0 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 16) : load(size => 16); }
+
+# VEX.128.66.0F38.W0 2D /r: VMASKMOVPD xmm1, xmm2, m128
+# VEX.128.66.0F38.W0 2F /r: VMASKMOVPD m128, xmm1, xmm2
+VMASKMOVPD AVX 001011 d 1 \
+  !constraints { vex($_, m => 0x0F38, l => 128, p => 0x66, w => 0); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { $d ? store(size => 16) : load(size => 16); }
+
 # NP 0F 2B /r: MOVNTPS m128, xmm1
 MOVNTPS SSE 00001111 00101011 \
   !constraints { modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { store(size => 16, align => 16); }
 
+# VEX.128.0F.WIG 2B /r: VMOVNTPS m128, xmm1
+VMOVNTPS AVX 00101011 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { store(size => 16, align => 16); }
+
 # 66 0F 2B /r: MOVNTPD m128, xmm1
 MOVNTPD SSE2 00001111 00101011 \
   !constraints { data16($_); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { store(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG 2B /r: VMOVNTPD m128, xmm1
+VMOVNTPD AVX 00101011 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { store(size => 16, align => 16); }
+
 # NP 0F C3 /r: MOVNTI m32, r32
 MOVNTI SSE2 00001111 11000011 \
   !constraints { modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{base} && $_->{modrm}{base} != $_->{modrm}{reg} } \
@@ -1836,11 +3170,21 @@ MOVNTDQ SSE2 00001111 11100111 \
   !constraints { data16($_); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { store(size => 16, align => 16); }
 
+# VEX.128.66.0F.WIG E7 /r: VMOVNTDQ m128, xmm1
+VMOVNTDQ AVX 11100111 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0, p => 0x66); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { store(size => 16, align => 16); }
+
 # 66 0F 38 2A /r: MOVNTDQA xmm1, m128
 MOVNTDQA SSE4_1 00001111 00111000 00101010 \
   !constraints { data16($_); modrm($_); !defined $_->{modrm}{reg2} } \
   !memory { load(size => 16, align => 16); }
 
+# VEX.128.66.0F38.WIG 2A /r: VMOVNTDQA xmm1, m128
+VMOVNTDQA AVX 00101010 \
+  !constraints { vex($_, m => 0x0F38, l => 128, v => 0, p => 0x66); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 16, align => 16); }
+
 # 0F 18 /1: PREFETCHT0 m8
 PREFETCHT0 SSE 00001111 00011000 \
   !constraints { modrm($_, reg => 1); !defined $_->{modrm}{reg2} } \
@@ -1887,12 +3231,30 @@ PAUSE SSE2 10010000 \
 # NP 0F 77: EMMS
 EMMS MMX 00001111 01110111
 
+# VEX.128.0F.WIG 77: VZEROUPPER
+VZEROUPPER AVX 01110111 \
+  !constraints { vex($_, m => 0x0F, l => 128, v => 0); 1 }
+
+# VEX.256.0F.WIG 77: VZEROALL
+VZEROALL AVX 01110111 \
+  !constraints { vex($_, m => 0x0F, l => 256, v => 0); 1 }
+
 # NP 0F AE /2: LDMXCSR m32
 LDMXCSR SSE 00001111 10101110 \
   !constraints { modrm($_, reg => 2); !defined $_->{modrm}{reg2} } \
   !memory { load(size => 4, value => 0x000001f80, mask => 0xffff1f80); }
 
+# VEX.LZ.0F.WIG AE /2: VLDMXCSR m32
+VLDMXCSR AVX 10101110 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0); modrm($_, reg => 2); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 4, value => 0x000001f80, mask => 0xffff1f80); }
+
 # NP 0F AE /3: STMXCSR m32
 STMXCSR SSE 00001111 10101110 \
   !constraints { modrm($_, reg => 3); !defined $_->{modrm}{reg2} } \
   !memory { store(size => 4); }
+
+# VEX.LZ.0F.WIG AE /3: VSTMXCSR m32
+VSTMXCSR AVX 10101110 \
+  !constraints { vex($_, m => 0x0F, l => 0, v => 0); modrm($_, reg => 3); !defined $_->{modrm}{reg2} } \
+  !memory { store(size => 4); }
-- 
2.20.1


