Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8620C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6321420738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9CcqrSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6321420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADfK-0004T0-KK
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADVW-0002oW-Vh
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:31:35 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADVT-0003EI-PS
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:31:34 -0400
Received: by mail-wr1-x42c.google.com with SMTP id w13so8593801wrk.5
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eUj8WJsMWaZA0d7mwrJMzwASqxSsQwup7y0SCLE/WH8=;
 b=C9CcqrSuM3maAuY5PN7IbwG4k4FBY3IbzJoCbJoutnjgkuHQFRSitEaOCEVolFUbRR
 d82KZnsUHivzWFVW8TtdJ3YrLlyILwDRYFXV6jPrFNvtWsITIcoKIEmoZJGYTcTFBr6v
 0h/T4cCWKgQDUMx4+2n8UPCIzv6aQlS2IdM7p//7/b4/+umqlt1V4NbqFNlSw2u7B0Ik
 v2w4ZGn8CQCI3WkCX3kD5S2aWxfBGq7PuSPS4km5pLyyJF2Y0doE/sRzGzYU16HwVcf3
 oOthpCRotYsr1haUfxicuzgYcwnZ/MDpkbEgegolK2KFS/OPVVESzH+tzqxiQOzU1g+g
 wkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eUj8WJsMWaZA0d7mwrJMzwASqxSsQwup7y0SCLE/WH8=;
 b=XB3x1PYZ5SZAAOjZt4XFOicppUnHmF3sHi7FbCbilJ6BsCdeQP86PlD/pO6vese/WU
 QVNzye69lIxORTvVccebvXolEsgReyKAKXWYLpmiYyUAYBkeSp0ELJQNjyxaMQq5tBxu
 rFiFQVG+c/4Z05MfOy2+vc0AfDRu6e909dSti0NJxIckMBPtan3bjj18Lkgo1yeJni85
 LwNSnonxe4t6EC49ewkkPjq0UKqVzZRiPmJ++IKROgEOT+dT7BILx7/b6tAmq7dZMWr9
 LQyibIFnp3DhsSjuY36NEkLmppTnnlrYK1/iDCsc0IZN5AIDZTLu5IkNeCMDrx1hdptq
 shXg==
X-Gm-Message-State: AOAM5326mwqOiVNbS/U+TY9R2WUhS6QO3gJtZRogmr3G9ez98OHqMW8j
 XSoNFIWAk4Hh6xuGWQrPL9WFxQ==
X-Google-Smtp-Source: ABdhPJyayGVVOIuvlhWOIuk9WzChcqk3iJx4Imb6T3mgAN2ke8pluGanEEb3eH8Kte+iIu6HunaXYg==
X-Received: by 2002:adf:ba10:: with SMTP id o16mr6203646wrg.100.1598279489557; 
 Mon, 24 Aug 2020 07:31:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d11sm22574721wrw.77.2020.08.24.07.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:31:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH RISU] arm.risu: Add patterns for fp16 insns
Date: Mon, 24 Aug 2020 15:31:27 +0100
Message-Id: <20200824143127.23170-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Add patterns for the fp16 half-precision floating point extension.
Where older pre-fp16 patterns used to include UNDEF encodings
that now mean fp16, constrain them so that tests generated
from those patterns will give the same results on CPUs both
with and without fp16.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is what I've been testing my fp16 support patchset with.
NB that if you have pre-built golden-reference files for the
old patterns that wanted to see UNDEFs for fp16 insns you'll
need to regenerate those at some point when the fp16 support
lands for -cpu max.

 arm.risu | 218 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 170 insertions(+), 48 deletions(-)

diff --git a/arm.risu b/arm.risu
index 048215b..adebf37 100644
--- a/arm.risu
+++ b/arm.risu
@@ -456,6 +456,9 @@ VLDST_UNDEF A1c 1111 0100 1 x 0 0 any:8 11 any2:10
 # space (table A7-9 in DDI0406B)
 # We include UNDEF combinations here; there are no
 # UNPREDICTABLE encodings we need to avoid.
+# We avoid size encodings that are fp16 under the v8.2-FP16 extension:
+# sz=1 for the float insns which have a 1-bit size field in bit 20,
+# and instead hard-wire that bit to 0.
 ###########################################################
 
 VHADD A1 1111 001 u 0 d sz:2 vn:4 vd:4 0000 n q m 0 vm:4
@@ -471,9 +474,9 @@ VORN A1 1111 0010 0 d 11 vn:4 vd:4 0001 n q m 1 vm:4
 VEOR_VBIT A1 1111 0011 0 d op:2 vn:4 vd:4 0001 n q m 1 vm:4
 VQSUB A1 1111 001 u 0 d sz:2 vn:4 vd:4 0010 n q m 1 vm:4
 VCGT A1 1111 001 u 0 d sz:2 vn:4 vd:4 0011 n q m 0 vm:4
-VCGT A2 1111 0011 0 d 1 sz vn:4 vd:4 1110 n q m 0 vm:4
+VCGT A2 1111 0011 0 d 1 0 vn:4 vd:4 1110 n q m 0 vm:4
 VCGE A1 1111 001 u 0 d sz:2 vn:4 vd:4 0011 n q m 1 vm:4
-VCGE A2 1111 0011 0 d 0 sz vn:4 vd:4 1110 n q m 0 vm:4
+VCGE A2 1111 0011 0 d 0 0 vn:4 vd:4 1110 n q m 0 vm:4
 VSHL A1 1111 001 u 0 d sz:2 vn:4 vd:4 0100 n q m 0 vm:4
 VQSHL A1 1111 001 u 0 d sz:2 vn:4 vd:4 0100 n q m 1 vm:4
 VRSHL A1 1111 001 u 0 d sz:2 vn:4 vd:4 0101 n q m 0 vm:4
@@ -486,7 +489,7 @@ VADD A1 1111 0010 0 d sz:2 vn:4 vd:4 1000 n q m 0 vm:4
 VSUB A1 1111 0011 0 d sz:2 vn:4 vd:4 1000 n q m 0 vm:4
 VTST A1 1111 0010 0 d sz:2 vn:4 vd:4 1000 n q m 1 vm:4
 VCEQ A1 1111 0011 0 d sz:2 vn:4 vd:4 1000 n q m 1 vm:4
-VCEQ A2 1111 0010 0 d 0 sz vn:4 vd:4 1110 n q m 0 vm:4
+VCEQ A2 1111 0010 0 d 0 0 vn:4 vd:4 1110 n q m 0 vm:4
 VMLA A1 1111 001 op 0 d sz:2 vn:4 vd:4 1001 n q m 0 vm:4
 VMUL A1 1111 001 op 0 d sz:2 vn:4 vd:4 1001 n q m 1 vm:4
 VPMAX A1 1111 001 u 0 d sz:2 vn:4 vd:4 1010 n q m 0 vm:4
@@ -495,22 +498,22 @@ VQDMULH A1 1111 0010 0 d sz:2 vn:4 vd:4 1011 n q m 0 vm:4
 VQRDMULH A1 1111 0011 0 d sz:2 vn:4 vd:4 1011 n q m 0 vm:4
 VPADD A1 1111 0010 0 d sz:2 vn:4 vd:4 1011 n q m 1 vm:4
 # NB: VFM is VFPv4 only. There is no Neon encoding for VFNM.
-VFM A1 1111 0010 0 d op sz vn:4 vd:4 1100 n q m 1 vm:4
-VADD_float A1 1111 0010 0 d 0 sz vn:4 vd:4 1101 n q m 0 vm:4
-VSUB_float A1 1111 0010 0 d 1 sz vn:4 vd:4 1101 n q m 0 vm:4
-VPADD_float A1 1111 0011 0 d 0 sz vn:4 vd:4 1101 n q m 0 vm:4
-VABD_float A1 1111 0011 0 d 1 sz vn:4 vd:4 1101 n q m 0 vm:4
-VMLA_float A1 1111 0010 0 d 0 sz vn:4 vd:4 1101 n q m 1 vm:4
-VMLS_float A1 1111 0010 0 d 1 sz vn:4 vd:4 1101 n q m 1 vm:4
-VMUL_float A1 1111 0011 0 d 0 sz vn:4 vd:4 1101 n q m 1 vm:4
-VACGE A1 1111 0011 0 d 0 sz vn:4 vd:4 1110 n q m 1 vm:4
-VACGT A1 1111 0011 0 d 1 sz vn:4 vd:4 1110 n q m 1 vm:4
-VMAX_float A1 1111 0010 0 d 0 sz vn:4 vd:4 1111 n q m 0 vm:4
-VMIN_float A1 1111 0010 0 d 1 sz vn:4 vd:4 1111 n q m 0 vm:4
-VPMAX_float A1 1111 0011 0 d 0 sz vn:4 vd:4 1111 n q m 0 vm:4
-VPMIN_float A1 1111 0011 0 d 1 sz vn:4 vd:4 1111 n q m 0 vm:4
-VRECPS A1 1111 0010 0 d 0 sz vn:4 vd:4 1111 n q m 1 vm:4
-VRSQRTS A1 1111 0010 0 d 1 sz vn:4 vd:4 1111 n q m 1 vm:4
+VFM A1 1111 0010 0 d op 0 vn:4 vd:4 1100 n q m 1 vm:4
+VADD_float A1 1111 0010 0 d 0 0 vn:4 vd:4 1101 n q m 0 vm:4
+VSUB_float A1 1111 0010 0 d 1 0 vn:4 vd:4 1101 n q m 0 vm:4
+VPADD_float A1 1111 0011 0 d 0 0 vn:4 vd:4 1101 n q m 0 vm:4
+VABD_float A1 1111 0011 0 d 1 0 vn:4 vd:4 1101 n q m 0 vm:4
+VMLA_float A1 1111 0010 0 d 0 0 vn:4 vd:4 1101 n q m 1 vm:4
+VMLS_float A1 1111 0010 0 d 1 0 vn:4 vd:4 1101 n q m 1 vm:4
+VMUL_float A1 1111 0011 0 d 0 0 vn:4 vd:4 1101 n q m 1 vm:4
+VACGE A1 1111 0011 0 d 0 0 vn:4 vd:4 1110 n q m 1 vm:4
+VACGT A1 1111 0011 0 d 1 0 vn:4 vd:4 1110 n q m 1 vm:4
+VMAX_float A1 1111 0010 0 d 0 0 vn:4 vd:4 1111 n q m 0 vm:4
+VMIN_float A1 1111 0010 0 d 1 0 vn:4 vd:4 1111 n q m 0 vm:4
+VPMAX_float A1 1111 0011 0 d 0 0 vn:4 vd:4 1111 n q m 0 vm:4
+VPMIN_float A1 1111 0011 0 d 1 0 vn:4 vd:4 1111 n q m 0 vm:4
+VRECPS A1 1111 0010 0 d 0 0 vn:4 vd:4 1111 n q m 1 vm:4
+VRSQRTS A1 1111 0010 0 d 1 0 vn:4 vd:4 1111 n q m 1 vm:4
 
 ########### Neon 1 reg + modified immediate ###############
 # Instructions from the Neon "1 reg + modified immediate"
@@ -577,15 +580,19 @@ VQDMULL A1 1111 0010 1 d sz:2 vn:4 vd:4 1101 n 0 m 0 vm:4 { $sz != 3; }
 # (table A7-11 in DDI0406B)
 # UNDEF cases included.
 # sz = 11 is in vext/vtbl/vtbx/vdup/2reg-misc space.
+# We avoid f=1 sz=01 which is v8.2-FP16
 ###########################################################
 # includes float variants
-VMLA_scalar A1 1111 001 q 1  d sz:2 vn:4 vd:4 0 0 0 f n 1 m 0 vm:4 { $sz != 3; }
-VMLS_scalar A1 1111 001 q 1  d sz:2 vn:4 vd:4 0 1 0 f n 1 m 0 vm:4 { $sz != 3; }
+VMLA_scalar A1 1111 001 q 1  d sz:2 vn:4 vd:4 0 0 0 f n 1 m 0 vm:4 \
+  { $sz != 3 && ($f == 0 || $sz != 1); }
+VMLS_scalar A1 1111 001 q 1  d sz:2 vn:4 vd:4 0 1 0 f n 1 m 0 vm:4 \
+  { $sz != 3 && ($f == 0 || $sz != 1); }
 VMLAL_scalar A2 1111 001 u 1 d sz:2 vn:4 vd:4 0 0 1 0 n 1 m 0 vm:4 { $sz != 3; }
 VMLSL_scalar A2 1111 001 u 1 d sz:2 vn:4 vd:4 0 1 1 0 n 1 m 0 vm:4 { $sz != 3; }
 VQDMLAL_scalar A2 1111 0010 1 d sz:2 vn:4 vd:4 0 0 11 n 1 m 0 vm:4 { $sz != 3; }
 VQDMLSL_scalar A2 1111 0010 1 d sz:2 vn:4 vd:4 0 1 11 n 1 m 0 vm:4 { $sz != 3; }
-VMUL_scalar A1 1111 001 q 1 d sz:2 vn:4 vd:4 100 f n 1 m 0 vm:4 { $sz != 3; }
+VMUL_scalar A1 1111 001 q 1 d sz:2 vn:4 vd:4 100 f n 1 m 0 vm:4 \
+  { $sz != 3 && ($f == 0 || $sz != 1); }
 VMULL_scalar A2 1111 001 u 1 d sz:2 vn:4 vd:4 1010 n 1 m 0 vm:4 { $sz != 3; }
 VQDMULL_scalar A2 1111 0010 1 d sz:2 vn:4 vd:4 1011 n 1 m 0 vm:4 { $sz != 3; }
 VQDMULH_scalar A2 1111 001 q 1 d sz:2 vn:4 vd:4 1100 n 1 m 0 vm:4 { $sz != 3; }
@@ -595,6 +602,7 @@ VQRDMULH_scalar A2 1111 001 q 1 d sz:2 vn:4 vd:4 1101 n 1 m 0 vm:4 { $sz != 3; }
 # Instructions from the Neon "2 regs miscellaneous" space
 # (table A7-13 in DDI0406B)
 # UNDEF cases included.
+# We avoid f=1 sz=01 which is v8.2-FP16
 ###########################################################
 VREV A1 1111 0011 1 d 11 sz:2 00 vd:4 000 op:2 q m 0 vm:4
 VPADDL A1 1111 0011 1 d 11 sz:2 00 vd:4 0010 op q m 0 vm:4
@@ -605,13 +613,13 @@ VMVN A1 1111 0011 1 d 11 sz:2 00 vd:4 0 1011 q m 0 vm:4
 VPADAL A1 1111 0011 1 d 11 sz:2 00 vd:4 0110 op q m 0 vm:4
 VQABS A1 1111 0011 1 d 11 sz:2 00 vd:4 0111 0 q m 0 vm:4
 VQNEG A1 1111 0011 1 d 11 sz:2 00 vd:4 0111 1 q m 0 vm:4
-VCGT0 A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 000 q m 0 vm:4
-VCGE0 A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 001 q m 0 vm:4
-VCEQ0 A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 010 q m 0 vm:4
-VCLE0 A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 011 q m 0 vm:4
-VCLT0 A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 100 q m 0 vm:4
-VABS A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 110 q m 0 vm:4
-VNEG A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 111 q m 0 vm:4
+VCGT0 A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 000 q m 0 vm:4 { $f == 0 || $sz != 1; }
+VCGE0 A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 001 q m 0 vm:4 { $f == 0 || $sz != 1; }
+VCEQ0 A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 010 q m 0 vm:4 { $f == 0 || $sz != 1; }
+VCLE0 A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 011 q m 0 vm:4 { $f == 0 || $sz != 1; }
+VCLT0 A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 100 q m 0 vm:4 { $f == 0 || $sz != 1; }
+VABS A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 110 q m 0 vm:4 { $f == 0 || $sz != 1; }
+VNEG A1 1111 0011 1 d 11 sz:2 01 vd:4 0 f 111 q m 0 vm:4 { $f == 0 || $sz != 1; }
 VSWP A1 1111 0011 1 d 11 sz:2 10 vd:4 00000 q m 0 vm:4
 # d == m gives UNKNOWN results, so avoid it
 VTRN A1 1111 0011 1 d 11 sz:2 10 vd:4 00001 q m 0 vm:4 { ($d != $m) || ($vd != $vm); }
@@ -624,10 +632,10 @@ VSHLL A2 1111 0011 1 d 11 sz:2 10 vd:4 0011 0 0 m 0 vm:4
 # float-halfprec (A8.6.299)
 # NB that half-precision needs at least an A9; A8 doesn't have it
 VCVT_half A1 1111 0011 1 d 11 sz:2 10 vd:4 011 op 0 0 m 0 vm:4
-VRECPE A1 1111 0011 1 d 11 sz:2 11 vd:4 010 f 0 q m 0 vm:4
-VRSQRTE A1 1111 0011 1 d 11 sz:2 11 vd:4 010 f 1 q m 0 vm:4
-# float to int, neon versions (A8.6.294)
-VCVT_neon A1 1111 0011 1 d 11 sz:2 11 vd:4 0 11 op:2 q m 0 vm:4
+VRECPE A1 1111 0011 1 d 11 sz:2 11 vd:4 010 f 0 q m 0 vm:4 { $f == 0 || $sz != 1; }
+VRSQRTE A1 1111 0011 1 d 11 sz:2 11 vd:4 010 f 1 q m 0 vm:4 { $f == 0 || $sz != 1; }
+# float to int, neon versions (A8.6.294); avoid sz=01 which is FP16
+VCVT_neon A1 1111 0011 1 d 11 sz:2 11 vd:4 0 11 op:2 q m 0 vm:4 { $sz != 1; }
 
 ########### Neon other ####################################
 # Instructions which have their own entry in the top level
@@ -649,6 +657,8 @@ VDUP_scalar A1 1111 0011 1 d 11 imm:4 vd:4 11000 q m 0 vm:4
 # "VFP data-processing instructions" space
 # as described in DDI0406B table A7-16 and the subtables
 # it refers to.
+# These don't include fp16, which has [11:9] 0b100
+# (described in the Arm ARM as [11:9] 0b10 and a 2-bit size field)
 ###########################################################
 
 # VMLA, VMLS
@@ -752,7 +762,7 @@ VLDM A2b cond:4 110 p 0 d w 1 rn:4 vd:4 1010 00 imm:6  \
 # UNDEF cases for both A1 and A2:  P==U && W==1
 VLDM A1c cond:4 110 p u d 1 1 rn:4 vd:4 101 x imm:8 !constraints { $p == $u; }
 
-# VSTR
+# VSTR (no overlap with VSTR_f16)
 # both A1 and A2 encodings, U = 1
 VSTR A1a cond:4 1101 1 d 00 rn:4 vd:4 101 x imm:8 \
  !memory { reg_plus_imm($rn, $imm * 4); }
@@ -760,7 +770,7 @@ VSTR A1a cond:4 1101 1 d 00 rn:4 vd:4 101 x imm:8 \
 VSTR A1b cond:4 1101 0 d 00 rn:4 vd:4 101 x imm:8 \
  !memory { reg_minus_imm($rn, $imm * 4); }
 
-# VLDR
+# VLDR (no overlap with VLDR_f16)
 # both A1 and A2 encodings, U = 1
 VLDR A1a cond:4 1101 1 d 01 rn:4 vd:4 101 x imm:8 \
  !memory { reg_plus_imm($rn, $imm * 4); }
@@ -799,9 +809,9 @@ VMOV_core_double A1 cond:4 1100 010 op:1 rt2:4 rt:4 1011 00 m:1 1 vm:4 { $op ==
 # VSEL
 VSEL A1 1111 11100 d cc:2 vn:4 vd:4 101 sz n 0 m 0 vm:4
 # VMINNM and VMAXNM
-# neon
-VMINMAXNM A1 1111 00110 d op sz vn:4 vd:4 1111 n q m 1 vm:4
-# vfp
+# neon: sz=0 (avoiding sz=1 which is FP16)
+VMINMAXNM A1 1111 00110 d op 0 vn:4 vd:4 1111 n q m 1 vm:4
+# vfp (does not overlap with FP16)
 VMINMAXNM A2 1111 11101 d 00 vn:4 vd:4 101 sz n op m 0 vm:4
 
 # Crypto
@@ -842,8 +852,8 @@ VCVT_rm A1 1111 11101 d 1111 rm:2 vd:4 101 sz op 1 m 0 vm:4
 # 64<->16 conversions (see also pattern earlier which is the sz==0 case)
 VCVT_B_TT_64 A1 cond:4 1110 1 d 11 001 op vd:4 101 1 t 1 m 0 vm:4
 
-# VCVT with rounding mode specified, neon
-VCVT_rm_neon A1 1111 00111 d 11 size:2 11 vd:4 00 rm:2 op q m 0 vm:4
+# VCVT with rounding mode specified, neon; avoid sz=0b01 which is FP16
+VCVT_rm_neon A1 1111 00111 d 11 size:2 11 vd:4 00 rm:2 op q m 0 vm:4 { $size != 1; }
 
 # CRC
 # Note that sz == 0b11 is UNPREDICTABLE (either UNDEF, NOP or as if == 0b10)
@@ -879,16 +889,128 @@ VFMSL       A1 1111110 01 d:1 10 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
 VFMAL_s     A1 11111110 0 d:1 00 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
 VFMSL_s     A1 11111110 1 d:1 00 vn:4 vd:4 1000 n:1 q:1 m:1 1 vm:4
 
+@v8_2_fp16
+
+# v8.2-FP16 adds a lot of "and 16-bit flavour" to existing insn encodings;
+# these patterns are arranged in the same order as the earlier v7 patterns.
+# Pattern names follow the non-fp16 names with a _f16 suffix.
+
+# FP16: neon 3-reg-same: bit 20 sz=1 for f16
+VCGT_f16          A2 1111 0011 0 d 1 1 vn:4 vd:4 1110 n q m 0 vm:4
+VCGE_f16          A2 1111 0011 0 d 0 1 vn:4 vd:4 1110 n q m 0 vm:4
+VCEQ_f16          A2 1111 0010 0 d 0 1 vn:4 vd:4 1110 n q m 0 vm:4
+VFM_f16           A1 1111 0010 0 d op 1 vn:4 vd:4 1100 n q m 1 vm:4
+VADD_float_f16    A1 1111 0010 0 d 0 1 vn:4 vd:4 1101 n q m 0 vm:4
+VSUB_float_f16    A1 1111 0010 0 d 1 1 vn:4 vd:4 1101 n q m 0 vm:4
+VPADD_float_f16   A1 1111 0011 0 d 0 1 vn:4 vd:4 1101 n q m 0 vm:4
+VABD_float_f16    A1 1111 0011 0 d 1 1 vn:4 vd:4 1101 n q m 0 vm:4
+VMLA_float_f16    A1 1111 0010 0 d 0 1 vn:4 vd:4 1101 n q m 1 vm:4
+VMLS_float_f16    A1 1111 0010 0 d 1 1 vn:4 vd:4 1101 n q m 1 vm:4
+VMUL_float_f16    A1 1111 0011 0 d 0 1 vn:4 vd:4 1101 n q m 1 vm:4
+VACGE_f16         A1 1111 0011 0 d 0 1 vn:4 vd:4 1110 n q m 1 vm:4
+VACGT_f16         A1 1111 0011 0 d 1 1 vn:4 vd:4 1110 n q m 1 vm:4
+VMAX_float_f16    A1 1111 0010 0 d 0 1 vn:4 vd:4 1111 n q m 0 vm:4
+VMIN_float_f16    A1 1111 0010 0 d 1 1 vn:4 vd:4 1111 n q m 0 vm:4
+VPMAX_float_f16   A1 1111 0011 0 d 0 1 vn:4 vd:4 1111 n q m 0 vm:4
+VPMIN_float_f16   A1 1111 0011 0 d 1 1 vn:4 vd:4 1111 n q m 0 vm:4
+VRECPS_f16        A1 1111 0010 0 d 0 1 vn:4 vd:4 1111 n q m 1 vm:4
+VRSQRTS_f16       A1 1111 0010 0 d 1 1 vn:4 vd:4 1111 n q m 1 vm:4
+
+# FP16: neon 2-reg-scalar : f=1 sz=01
+VMLA_scalar_f16   A1 1111 001 q 1  d 01 vn:4 vd:4 0 0 0 f n 1 m 0 vm:4
+VMLS_scalar_f16   A1 1111 001 q 1  d 01 vn:4 vd:4 0 1 0 f n 1 m 0 vm:4
+VMUL_scalar_f16   A1 1111 001 q 1 d 01 vn:4 vd:4 100 f n 1 m 0 vm:4
+
+# FP16: Neon 2-reg-shift
+# this doesn't overlap with the non-fp16 insn, which has 111 in [11:9]
+VCVT_f16 A1 1111 001 u 1 d imm:6 vd:4 110 op 0 q m 1 vm:4 { ($imm & 0x38) != 0; }
+
+# FP16: neon 2-reg-misc: f=1 sz=01
+VCGT0_f16        A1 1111 0011 1 d 11 01 01 vd:4 0 f 000 q m 0 vm:4
+VCGE0_f16        A1 1111 0011 1 d 11 01 01 vd:4 0 f 001 q m 0 vm:4
+VCEQ0_f16        A1 1111 0011 1 d 11 01 01 vd:4 0 f 010 q m 0 vm:4
+VCLE0_f16        A1 1111 0011 1 d 11 01 01 vd:4 0 f 011 q m 0 vm:4
+VCLT0_f16        A1 1111 0011 1 d 11 01 01 vd:4 0 f 100 q m 0 vm:4
+VABS_f16         A1 1111 0011 1 d 11 01 01 vd:4 0 f 110 q m 0 vm:4
+VNEG_f16         A1 1111 0011 1 d 11 01 01 vd:4 0 f 111 q m 0 vm:4
+VRECPE_f16       A1 1111 0011 1 d 11 01 11 vd:4 010 f 0 q m 0 vm:4
+VRSQRTE_f16      A1 1111 0011 1 d 11 01 11 vd:4 010 f 1 q m 0 vm:4
+VCVT_neon_f16    A1 1111 0011 1 d 11 01 11 vd:4 0 11 op:2 q m 0 vm:4
+
+# FP16: vfp: these have no overlap with non-fp16 patterns, where [11:9] is 101
+VMLA_f16         A2 cond:4 11100 d 00 vn:4 vd:4 1001 n op m 0 vm:4
+VNMLA_f16        A1 cond:4 11100 d 01 vn:4 vd:4 1001 n op m 0 vm:4
+VNMUL_f16        A2 cond:4 11100 d 10 vn:4 vd:4 1001 n 1 m 0 vm:4
+VMUL_f16         A2 cond:4 11100 d 10 vn:4 vd:4 1001 n 0 m 0 vm:4
+VADD_f16         A2 cond:4 11100 d 11 vn:4 vd:4 1001 n 0 m 0 vm:4
+VSUB_f16         A2 cond:4 11100 d 11 vn:4 vd:4 1001 n 1 m 0 vm:4
+VDIV_f16         A1 cond:4 11101 d 00 vn:4 vd:4 1001 n 0 m 0 vm:4
+VMOV_imm_f16     A2 cond:4 11101 d 11 immh:4 vd:4 1001 0000 imml:4
+VABS_f16         A2 cond:4 11101 d 11 0000 vd:4 1001 1 1 m 0 vm:4
+VNEG_f16         A2 cond:4 11101 d 11 0001 vd:4 1001 0 1 m 0 vm:4
+VSQRT_f16        A1 cond:4 11101 d 11 0001 vd:4 1001 1 1 m 0 vm:4
+VCMP_f16         A1 cond:4 11101 d 11 0100 vd:4 1001 e 1 m 0 vm:4
+VCMP_f16         A2 cond:4 11101 d 11 0101 vd:4 1001 e 1 0 0 0000
+VCVT_a_f16       A1 cond:4 11101 d 111 000 vd:4 1001 op 1 m 0 vm:4
+VCVT_b_f16       A1 cond:4 11101 d 111 10 x vd:4 1001 op 1 m 0 vm:4
+# VCVT between fp and fixed point (A.8.6.297); same UNPREDICTABLE as non-fp16
+# sx==1 case first:
+VCVT_c_f16       A1 cond:4 11101 d 111 op 1 u vd:4 1001 1 1 i 0 imm:4
+# sx==0, bit 3 == 0
+VCVT_d_f16       A1 cond:4 11101 d 111 op 1 u vd:4 1001 0 1 i 0 0 imm:3
+# sx==0, bit 3 == 1, bits 2..0 and 5 0
+VCVT_e_f16       A1 cond:4 11101 d 111 op 1 u vd:4 1001 0 1 0 0 1000
+VFM_f16          A2 cond:4 11101 d 10 vn:4 vd:4 1001 n op m 0 vm:4
+VFNM_f16         A1 cond:4 11101 d 01 vn:4 vd:4 1001 n op m 0 vm:4
+# both A1 and A2 encodings, U = 1
+VSTR_f16         A1a cond:4 1101 1 d 00 rn:4 vd:4 1001 imm:8 \
+                 !memory { reg_plus_imm($rn, $imm * 2); }
+# both A1 and A2 encodings, U = 0
+VSTR_f16         A1b cond:4 1101 0 d 00 rn:4 vd:4 1001 imm:8 \
+                 !memory { reg_minus_imm($rn, $imm * 2); }
+# both A1 and A2 encodings, U = 1
+VLDR_f16         A1a cond:4 1101 1 d 01 rn:4 vd:4 1001 imm:8 \
+                 !memory { reg_plus_imm($rn, $imm * 2); }
+# both A1 and A2 encodings, U = 0
+VLDR_f16         A1b cond:4 1101 0 d 01 rn:4 vd:4 1001 imm:8 \
+                 !memory { reg_minus_imm($rn, $imm * 2); }
+
+# FP16: v8-only insns
+# Neon insns with sz=0b01
+VCVT_rm_neon_f16   A1 1111 00111 d 11 01 11 vd:4 00 rm:2 op q m 0 vm:4
+VRINTX_neon_f16    A1 1111 00111 d 11 01 10 vd:4 01001 q m 0 vm:4
+VRINTZ_neon_f16    A1 1111 00111 d 11 01 10 vd:4 01011 q m 0 vm:4
+VRINTANPM_neon_f16 A1 1111 00111 d 11 01 10 vd:4 01 op:3 q m 0 vm:4
+# Neon insn with sz=1
+VMINMAXNM_f16    A1 1111 00110 d op 1 vn:4 vd:4 1111 n q m 1 vm:4
+# VFP insns which don't overlap non-fp16 rules (which have 101 in [11:9])
+VCVT_rm_f16      A1 1111 11101 d 1111 rm:2 vd:4 1001 op 1 m 0 vm:4
+VSEL_f16         A1 1111 11100 d cc:2 vn:4 vd:4 1001 n 0 m 0 vm:4
+VMINMAXNM_f16    A2 1111 11101 d 00 vn:4 vd:4 1001 n op m 0 vm:4
+VRINTX_f16       A1 cond:4 11101 d 110111 vd:4 1001 0 1 m 0 vm:4
+VRINTZR_f16      A1 cond:4 11101 d 110110 vd:4 1001 op 1 m 0 vm:4
+VRINTANPM_f16    A1 1111 11101 d 1110 rmode:2 vd:4 1001 0 1 m 0 vm:4
+
+# FP16: Insns which are new for v8.2 FP16:
+VINS_f16         A1 1111 11101 d 110000 vd:4 101011 m 0 vm:4
+VMOVX_f16        A1 1111 11101 d 110000 vd:4 101001 m 0 vm:4
+# VMOV between general-purpose register and half-precision
+VMOV_core_f16    A1 cond:4 1110000 op:1 vn:4 rt:4 1001 n 0010000
+
+@v8_2_fp16_v8_3_compnum
+# These are only present if both v8.2-FP16 and v8.3-CompNum are implemented
+# sz=0 for FP16
+VCADD_f16        A1 1111110 rot:1 1 d:1 0 0 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4
+VCMLA_f16        A1 1111110 rot:2 d:1 1 0 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4
+VCMLA_s_f16      A1 11111110 0 d:1 rot:2 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4
+
 #
 # ARMv8.3 extensions
 #
 @v8_3_compnum
 
-# Disable fp16 until qemu supports it.
-VCADD       A1 1111110 rot:1 1 d:1 0 s:1 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4 \
-!constraints { $s != 0; }
-
-VCMLA       A1 1111110 rot:2 d:1 1 s:1 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4 \
-!constraints { $s != 0; }
-VCMLA_s     A1 11111110 s:1 d:1 rot:2 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4 \
-!constraints { $s != 0; }
+# We avoid the FP16 parts of this, which are in @v8_2_fp16_v8_3_compnum,
+# so here s=1
+VCADD       A1 1111110 rot:1 1 d:1 0 1 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4
+VCMLA       A1 1111110 rot:2 d:1 1 1 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4
+VCMLA_s     A1 11111110 1 d:1 rot:2 vn:4 vd:4 1000 n:1 q:1 m:1 0 vm:4
-- 
2.20.1


