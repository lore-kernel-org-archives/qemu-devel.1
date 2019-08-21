Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF11DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D5422D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRvAHIAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D5422D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0V8O-000148-5f
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URQ-0001M8-J7
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URP-0007jq-7D
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:36 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:40496)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URP-0007jP-3G
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:35 -0400
Received: by mail-yb1-xb43.google.com with SMTP id g7so1338540ybd.7
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IcwQpmkLt1xTNEoF+bKnuxFt/yx/kcsF9Q+D3f4422I=;
 b=nRvAHIAPxGkQDt3et5N4S2mvV+FztDRTCV+QuOlNF1wT/2XxAoP1sFv4QFpgT1kDMb
 N1iBfP+O1/ZZSgyje0ZSFmBD1cafGbf3kZoz5A9oybZZU/0teMethlpPFebPGp6KEqvF
 EWjA2t0KgUmDrKBQVZC6NY4SRORRhk8FUM4VKPX3fdKONfswP+UcLStLS16LjZiYVl52
 UcFOZTJVbsvmj024dTFN6fTlV75/44mzpCeMQqmujQ72fM24bFJroeCHPA1Wmq8rT9jM
 CD/pEESzhY/KxhgyKWtaNxujhH8LKEeopdU055h6HeFii5ifj4z1mlVUSuQYwTi03vuc
 2BKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IcwQpmkLt1xTNEoF+bKnuxFt/yx/kcsF9Q+D3f4422I=;
 b=hekFNDhuKsWpNmAhHdG5qkQvIoVu6tc0MHsDTK0d9ZBCHqRIvH0cnRcnje7fNVb1nY
 5CGuFQL1ABMYiRd2/O3lA8S4Eqmn49nEkqKdsGYz54BBQrrBrSb+VbFUXSMdgUqq4Hc0
 gbK8Q7ZVf5DK7aFfwy35xVxdtiVHitsQMUi2Kw8nkl8os/mDgti+Jnw0j+6qY4AxgS05
 0dVfUY1eMErRovS/ywwx6DFmG4d3siOEfBt86MgG16LqI1C2Xw28+wuSZjEEhrjTl+Of
 xzq7TJseXxvDfna927kIrkk5jeFBTyVPalNbREzZ7GnXangNaKdyU1o6Sb/iSmpgM6+X
 awHA==
X-Gm-Message-State: APjAAAVYEegPCRwRCDBEzQLnZtRFYKNERrnqoZNToveuA0myVxigLsNi
 mhCAov+feN4vlfsk6GG+zgRtOQti
X-Google-Smtp-Source: APXvYqwzP/lQ/uOT1hAXiiRVlX1hNr86JbO07SQXfxps5TrXU6OZvdqbVjCTz8BGvvXK0MIif1EhoQ==
X-Received: by 2002:a25:2455:: with SMTP id k82mr23846689ybk.12.1566408634437; 
 Wed, 21 Aug 2019 10:30:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:33 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:10 -0400
Message-Id: <20190821172951.15333-35-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v4 34/75] target/i386: introduce
 sse-opcode.inc.h
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

This header is intended to eventually list all supported instructions
along with some useful details (e.g. mnemonics, opcode, operands etc.)
It shall be used (along with some preprocessor magic) anytime we need
to automatically generate code for every instruction.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/sse-opcode.inc.h | 75 ++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 target/i386/sse-opcode.inc.h

diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
new file mode 100644
index 0000000000..04d0c49168
--- /dev/null
+++ b/target/i386/sse-opcode.inc.h
@@ -0,0 +1,75 @@
+#define FMTI____      (0, 0, 0, )
+#define FMTI__R__     (1, 1, 0, r)
+#define FMTI__RR__    (2, 2, 0, rr)
+#define FMTI__RRR__   (3, 3, 0, rrr)
+#define FMTI__W__     (1, 0, 1, w)
+#define FMTI__WR__    (2, 1, 1, wr)
+#define FMTI__WRR__   (3, 2, 1, wrr)
+#define FMTI__WRRR__  (4, 3, 1, wrrr)
+#define FMTI__WRRRR__ (5, 4, 1, wrrrr)
+#define FMTI__WWRRR__ (5, 3, 2, wwrrr)
+
+#define FMTI__(prop, fmti) FMTI_ ## prop ## __ fmti
+
+#define FMTI_ARGC__(argc, argc_rd, argc_wr, lower)    argc
+#define FMTI_ARGC_RD__(argc, argc_rd, argc_wr, lower) argc_rd
+#define FMTI_ARGC_WR__(argc, argc_rd, argc_wr, lower) argc_wr
+#define FMTI_LOWER__(argc, argc_rd, argc_wr, lower)   lower
+
+#define FMT_ARGC(fmt)    FMTI__(ARGC, FMTI__ ## fmt ## __)
+#define FMT_ARGC_RD(fmt) FMTI__(ARGC_RD, FMTI__ ## fmt ## __)
+#define FMT_ARGC_WR(fmt) FMTI__(ARGC_WR, FMTI__ ## fmt ## __)
+#define FMT_LOWER(fmt)   FMTI__(LOWER, FMTI__ ## fmt ## __)
+#define FMT_UPPER(fmt)   fmt
+
+#ifndef OPCODE
+#   define OPCODE(mnem, opcode, feat, fmt, ...)
+#endif /* OPCODE */
+
+#ifndef OPCODE_GRP
+#   define OPCODE_GRP(grpname, opcode)
+#endif /* OPCODE_GRP */
+
+#ifndef OPCODE_GRP_BEGIN
+#   define OPCODE_GRP_BEGIN(grpname)
+#endif /* OPCODE_GRP_BEGIN */
+
+#ifndef OPCODE_GRPMEMB
+#   define OPCODE_GRPMEMB(grpname, mnem, opcode, feat, fmt, ...)
+#endif /* OPCODE_GRPMEMB */
+
+#ifndef OPCODE_GRP_END
+#   define OPCODE_GRP_END(grpname)
+#endif /* OPCODE_GRP_END */
+
+#undef FMTI____
+#undef FMTI__R__
+#undef FMTI__RR__
+#undef FMTI__RRR__
+#undef FMTI__W__
+#undef FMTI__WR__
+#undef FMTI__WRR__
+#undef FMTI__WRRR__
+#undef FMTI__WRRRR__
+#undef FMTI__WWRRR__
+
+#undef FMTI__
+
+#undef FMTI_ARGC__
+#undef FMTI_ARGC_RD__
+#undef FMTI_ARGC_WR__
+#undef FMTI_LOWER__
+
+#undef FMT_ARGC
+#undef FMT_ARGC_RD
+#undef FMT_ARGC_WR
+#undef FMT_LOWER
+#undef FMT_UPPER
+
+#undef LEG
+#undef VEX
+#undef OPCODE
+#undef OPCODE_GRP
+#undef OPCODE_GRP_BEGIN
+#undef OPCODE_GRPMEMB
+#undef OPCODE_GRP_END
-- 
2.20.1


