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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578E5C742A2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2569821019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVTuDoVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2569821019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhdg-0002tT-SP
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40406)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdA-00016p-EL
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhd5-0003u5-Vk
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:36 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:44542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhcz-0003mM-Ss
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:26 -0400
Received: by mail-yb1-xb41.google.com with SMTP id a14so3192578ybm.11
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qEdVyJ5GUS6Z8ePstAHmdSOkyMUonubPZrVG688CeCA=;
 b=IVTuDoVP0urovXejbCEaiuk+bbPi1fOvhF8PhfmnrSPdNoD709vavYhA/2dPCmlPlo
 1PlSWf1uyWX35R3nYfZFHugJRdEPHLjltEvvjup8egMl4pPkmKgc2XjErccALytZoC51
 0HSH/QoD90OuHzbsP3K3xnJuH4vpBinFX7saPUwYUFx6ZbJXrptLJFppf2LPKwwjniva
 LEHFw1G6I2ePqU+sdR83pvrGdTS6GV+ElJnchpIFlDEgYmQpSPfcbCl5iFqtTsGW3FgU
 v/6YUVYopI1wDZ3+iHzgUgsW1JN/9EvqAA8USgfG35W0grzWF4kAUSTsvMRkvd+cs+lS
 zV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qEdVyJ5GUS6Z8ePstAHmdSOkyMUonubPZrVG688CeCA=;
 b=XqW6/LGWKjas/CWHZIRW6fJki78Lp8J4MKDa3zAQWCB23j0gQkuGdmt4GPbwwYL+56
 tj3CJQp4xZ2OMSaJ1wbeiuIxGFpY21zuddHFhEJzrCNZ7I1W3sZ/YC/DmnoM6O9TitCo
 Pb+VKHDKe62Xggkwxw3Hb5J2E9Nkt9TmCb8Lx6D/g0MDG9AutQ5quk6JgAAyI3am3VHY
 9Wap0zYXjSZxldyy6nbpXCDr4+aiHrej20djgYucC2XeGpfHY0MzNoAOvxAeUCOgIJ59
 CwGniezKhRF15UPnISPxCR4bKXKXBLtC27vXsn1iUW7RP0k4E5H2YRL9v9iIhgk1gSBu
 ke3A==
X-Gm-Message-State: APjAAAW703B7u+iREnT+CAhBuEzMXlivFB0j32sp4cD5NLo7FnZErWV/
 Bm5d4iyzFLl5NXfmtzWbHrs6Rgwm
X-Google-Smtp-Source: APXvYqyTNndXsQsrEAizMlYlYSRuE/OFi893KNV762ybqjnZu/H3fE6dMCXDvLbpv9NRlWNyZ2YBAw==
X-Received: by 2002:a05:6902:508:: with SMTP id
 x8mr4380692ybs.406.1562884402993; 
 Thu, 11 Jul 2019 15:33:22 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:22 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:58 -0400
Message-Id: <20190711223300.6061-17-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RISU PATCH v3 16/18] x86.risu: add AES and PCLMULQDQ
 instructions
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

Add AES-NI and PCLMULQDQ instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/x86.risu b/x86.risu
index bc6636e..177979a 100644
--- a/x86.risu
+++ b/x86.risu
@@ -886,6 +886,51 @@ ROUNDSD SSE4_1 00001111 00111010 00001011 \
   !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
   !memory { load(size => 8); }
 
+#
+# AES Instructions
+# ----------------
+#
+
+# 66 0F 38 DE /r: AESDEC xmm1, xmm2/m128
+AESDEC AES 00001111 00111000 11011110 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 38 DF /r: AESDECLAST xmm1, xmm2/m128
+AESDECLAST AES 00001111 00111000 11011111 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 38 DC /r: AESENC xmm1, xmm2/m128
+AESENC AES 00001111 00111000 11011100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 38 DD /r: AESENCLAST xmm1, xmm2/m128
+AESENCLAST AES 00001111 00111000 11011101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 38 DB /r: AESIMC xmm1, xmm2/m128
+AESIMC AES 00001111 00111000 11011011 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 3A DF /r ib: AESKEYGENASSIST xmm1, xmm2/m128, imm8
+AESKEYGENASSIST AES 00001111 00111010 11011111 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+#
+# PCLMULQDQ Instructions
+# ----------------------
+#
+
+# 66 0F 3A 44 /r ib: PCLMULQDQ xmm1, xmm2/m128, imm8
+PCLMULQDQ PCLMULQDQ 00001111 00111010 01000100 \
+  !constraints { data16($_); modrm($_); imm($_, width => 8); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 #
 # Comparison Instructions
 # -----------------------
-- 
2.20.1


