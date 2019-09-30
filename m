Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44F6C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDA0224FE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 20:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n66VoN6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDA0224FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iF2HA-0002oW-KG
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 16:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2Ao-0004Tl-FP
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iF2An-0005Xl-Cw
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:34 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iF2An-0005XQ-7y
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 16:21:33 -0400
Received: by mail-pf1-x443.google.com with SMTP id y72so6213688pfb.12
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 13:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SzVKSOWxR21GxNNFEkqthMF5+mItMVvGCPcgyomd1W8=;
 b=n66VoN6cw0yROmNJ5enKQ27M2KM/lOpS6VNk+kp0zTmsO+0HsSmpYTqdJreYWJouaY
 062M5CIwN+wO484xLl7kFoqSqlBy4FvwepbAPQEkluxmTtWiSPz03jliNTmtEoRx9dSL
 VfeiqdahDCUscFjediuiisD2dPH/iOx6Ep8fc6tMUfArvQw46T+WObFKabg4ektSftBf
 pKv2pg13HrpJeI/Pq9lzlVaYklx0wyq2WufKRFLkZMOlmwPnz0skpzAWG0Fm+hZKfDGC
 zh5r/KwKqbWO8zved0EDwwPhiDnhCvJAXafvzZw5EHgNlO/TEhN3aXW8AZ5ePOQgadxf
 ArWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SzVKSOWxR21GxNNFEkqthMF5+mItMVvGCPcgyomd1W8=;
 b=fmXFhJ0LIwEcf4Cx4T8m4DrbINETEA1iNLVkr292EhLxAOHUtbyUOovaf19Cgc76ex
 jg2TVECYbiHJT704vbqHI9Iod9mRlx2rX39f4fIQU5mf19iqYQeawnffjpb+oF8nM7Wz
 VnWPE5sH1P8NpsRvm9gHY4RkRYHJfqer+n8G2z6PHcLth7on/ERmyvXIaYTbk/Xw1pEQ
 iEuLf4TCTkDFrqYMtIA5tYAu/MasqrdV5d8S0GziU0NPU5VFfZd+kiRtoSjf7lsH0reN
 MPpKFiRxBwyqpvouTcrQxk/VQO1K20FdjLBL6dU2hexHxSbsjCiAV16nugB/oNbDM6tt
 ncVQ==
X-Gm-Message-State: APjAAAXEJxaf+mWL2DgBBMjV54gOJg1AeqsKvhN/O3pfr6TRsxNWY4bC
 0rVJ+lI4kS2IUie2xUldWZy0K/N/hwM=
X-Google-Smtp-Source: APXvYqxeuf1a26uPfaxcr82rLtiLAyhcaCPrP7nYJp/IU0EmRail94sa+CSX4RqqqDp+EpEdkayh9Q==
X-Received: by 2002:a63:f74c:: with SMTP id f12mr23969606pgk.316.1569874891912; 
 Mon, 30 Sep 2019 13:21:31 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r28sm15336802pfg.62.2019.09.30.13.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2019 13:21:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 04/22] tcg/ppc: Create TCGPowerISA and have_isa
Date: Mon, 30 Sep 2019 13:21:07 -0700
Message-Id: <20190930202125.21064-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190930202125.21064-1-richard.henderson@linaro.org>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce an enum to hold base < 2.06 < 3.00.  Use macros to
preserve the existing have_isa_2_06 and have_isa_3_00 predicates.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.h     | 12 ++++++++++--
 tcg/ppc/tcg-target.inc.c |  8 ++++----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 690fa744e1..35ba8693fa 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -58,8 +58,16 @@ typedef enum {
     TCG_AREG0 = TCG_REG_R27
 } TCGReg;
 
-extern bool have_isa_2_06;
-extern bool have_isa_3_00;
+typedef enum {
+    tcg_isa_base,
+    tcg_isa_2_06,
+    tcg_isa_3_00,
+} TCGPowerISA;
+
+extern TCGPowerISA have_isa;
+
+#define have_isa_2_06  (have_isa >= tcg_isa_2_06)
+#define have_isa_3_00  (have_isa >= tcg_isa_3_00)
 
 /* optional instructions automatically implemented */
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi */
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 4aad5d2b36..0bfaef9418 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -64,8 +64,7 @@
 
 static tcg_insn_unit *tb_ret_addr;
 
-bool have_isa_2_06;
-bool have_isa_3_00;
+TCGPowerISA have_isa;
 
 #define HAVE_ISA_2_06  have_isa_2_06
 #define HAVE_ISEL      have_isa_2_06
@@ -2787,12 +2786,13 @@ static void tcg_target_init(TCGContext *s)
     unsigned long hwcap = qemu_getauxval(AT_HWCAP);
     unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
 
+    have_isa = tcg_isa_base;
     if (hwcap & PPC_FEATURE_ARCH_2_06) {
-        have_isa_2_06 = true;
+        have_isa = tcg_isa_2_06;
     }
 #ifdef PPC_FEATURE2_ARCH_3_00
     if (hwcap2 & PPC_FEATURE2_ARCH_3_00) {
-        have_isa_3_00 = true;
+        have_isa = tcg_isa_3_00;
     }
 #endif
 
-- 
2.17.1


