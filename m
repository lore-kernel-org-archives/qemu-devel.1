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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8B8C742A2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B23120645
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k10q5v8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B23120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhdX-0002AR-3n
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40393)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhd5-0000nS-W1
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhcy-0003oQ-Vd
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:26 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:34185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhcy-0003iz-03
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:24 -0400
Received: by mail-yb1-xb42.google.com with SMTP id x32so3207906ybh.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DSu5nbYWZ76xynVR37r/29Jm/9k6kUEJc32cv8XWBIk=;
 b=k10q5v8NZImJBdyzUygIu2J3j6FSB71ek8Fv+TepecGdD75mFce/eJKiXTTIz8DVcA
 DekDLp0FSlGa+xBxLKwXLxRfUovmZIj4rjgucLoTvPUHhiLVajBImkt6jRCkPZdBK0D7
 PaZnX8BCFYM/Q5N9IU33qyZjq+QphSGUpPvQETNX4eloCXFzUpOBJi/dy7U3ywwadrl1
 iSyR5p6rYIxWw1nlU8xkAgqzwJIZ00ExnXKRSyiPC6qXScj2ts9P3/D27bEvjjk1j4ix
 Y+Dn1Fr2P17XPlG6+jZfaO7kDaJ1QCR+H3STOa6fgQU6EoDUrTvutntbv9UomQfchkQ3
 beig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DSu5nbYWZ76xynVR37r/29Jm/9k6kUEJc32cv8XWBIk=;
 b=QGZEhLz1u3ICsxJHtHNx3/LoZRidW9E7iHljbtHLRBQwuOL/cqk98wLq6uEAzekKL7
 4Au3s5e3FGRQxk3sGpazBZgiYrvMmqIEbeVPOzBwCiF+UuyltAv6lIvYKyq5NGwSYWj3
 10DvLYsurmgUgcJSNe8UuzJH8dfrfPRIff9gYCG8VfCLnHwAUzwuyDJ1Xj+J/ZoKEPdE
 IEhwRcLLI2g1t2ak0jXrxlnBOugxv53ceEpyu+qY4mQiiK9mDy15BxhcBbS6NaWxXUpT
 u0TVKX8bte3G3c/LiVXMwxEvWYigthRe7zD/tno+ErDRFOFzP3fwckoMe+p+HJJAizYp
 UXdA==
X-Gm-Message-State: APjAAAWcT1Wxz/U0/KrINdEDBXnuJ9ARMHbOweiQRDWwc6B0v6dVvyf4
 idDVeQ9IyJdkWID1A8CAbuu0fW77
X-Google-Smtp-Source: APXvYqwWZgBaA08zm8JZ3OS999LQbfRuNEi5frGwyIu/anMypuqK3YoVwDpkrBZrAgMR0r7nXVKRPQ==
X-Received: by 2002:a25:86cd:: with SMTP id y13mr3872645ybm.289.1562884401151; 
 Thu, 11 Jul 2019 15:33:21 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:20 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:55 -0400
Message-Id: <20190711223300.6061-14-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RISU PATCH v3 13/18] x86.risu: add SSE3 instructions
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

Add SSE3 instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/x86.risu b/x86.risu
index b9d424e..d40b9df 100644
--- a/x86.risu
+++ b/x86.risu
@@ -161,6 +161,26 @@ MOVMSKPS SSE 00001111 01010000 \
 MOVMSKPD SSE2 00001111 01010000 \
   !constraints { data16($_); modrm($_); $_->{modrm}{reg} != REG_RSP && defined $_->{modrm}{reg2} }
 
+# F2 0F F0 /r: LDDQU xmm1, m128
+LDDQU SSE3 00001111 11110000 \
+  !constraints { repne($_); modrm($_); !defined $_->{modrm}{reg2} } \
+  !memory { load(size => 16); }
+
+# F3 0F 16 /r: MOVSHDUP xmm1, xmm2/m128
+MOVSHDUP SSE3 00001111 00010110 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F3 0F 12 /r: MOVSLDUP xmm1, xmm2/m128
+MOVSLDUP SSE3 00001111 00010010 \
+  !constraints { rep($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F2 0F 12 /r: MOVDDUP xmm1, xmm2/m64
+MOVDDUP SSE3 00001111 00010010 \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { load(size => 8); }
+
 #
 # Arithmetic Instructions
 # -----------------------
@@ -266,6 +286,16 @@ ADDSD SSE2 00001111 01011000 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# F2 0F 7C /r: HADDPS xmm1, xmm2/m128
+HADDPS SSE3 00001111 01111100 \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 7C /r: HADDPD xmm1, xmm2/m128
+HADDPD SSE3 00001111 01111100 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F F8 /r: PSUBB mm, mm/m64
 PSUBB MMX 00001111 11111000 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
@@ -366,6 +396,26 @@ SUBSD SSE2 00001111 01011100 \
   !constraints { repne($_); modrm($_); 1 } \
   !memory { load(size => 8); }
 
+# F2 0F 7D /r: HSUBPS xmm1, xmm2/m128
+HSUBPS SSE3 00001111 01111101 \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F 7D /r: HSUBPD xmm1, xmm2/m128
+HSUBPD SSE3 00001111 01111101 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# F2 0F D0 /r: ADDSUBPS xmm1, xmm2/m128
+ADDSUBPS SSE3 00001111 11010000 \
+  !constraints { repne($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
+# 66 0F D0 /r: ADDSUBPD xmm1, xmm2/m128
+ADDSUBPD SSE3 00001111 11010000 \
+  !constraints { data16($_); modrm($_); 1 } \
+  !memory { load(size => 16, align => 16); }
+
 # NP 0F D5 /r: PMULLW mm, mm/m64
 PMULLW MMX 00001111 11010101 \
   !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
-- 
2.20.1


