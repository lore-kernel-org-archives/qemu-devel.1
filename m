Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B754C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4044020873
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hLGl9GIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4044020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4pK-0005Cs-GD
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:17:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dV-0002lS-G7
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4ap-0002Vt-U3
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:04 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4ap-0002Uu-NA
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:03 -0400
Received: by mail-pg1-x544.google.com with SMTP id 145so4821612pgg.9
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=CNtLSsppNDq+qCEdta/UyzFB0xSoIc+vMFY+eO0LpIo=;
	b=hLGl9GIvAqE3EuUUjA3yuves4T/8nvL2eDXBxfXOg/++HaH9XUvebkvmjQGSkWwDlH
	yw3jrtdHKTUR9IgLVANIk5HlVSYdQf2+jOiD+CnKufPnfBX7WfUDBmaVdvcod1vVteZA
	gc7n3naHXT01k1Eg8nkS8Y84H+dOXdlCcI8akFasbl18AiIDt0HjsQXNudZ4+NMqnBk/
	ezde8d7tPL+n0nGn2X2ljhanjAr/IUZxvf1fHnyvR41hJOUfCuZp77GvIlp6zsRwz7EH
	nhk8yHjIB8Q1pFv0cxR3KFsIPqsvnGiMDAsuOXTM0lK9l0ok0aZtkib8e48fIF9O8yB4
	6AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=CNtLSsppNDq+qCEdta/UyzFB0xSoIc+vMFY+eO0LpIo=;
	b=lr8J0JlhagD8uPH498Nrp2/ZINjqZ9JTdQRFiu5DtwHuAIfDRyXN+y1WEiIGs5OPCk
	iw6tEoM8gdHQo0ZF01FvKH2wGTBb5gZI0ft2dj1PAeMqUL47ttTiDl/uIfwB6XUXNA2B
	ZJ9HcNqzlk3qSP165gBJblaKqcdOORyZU5bpbr+ssnj06/G/TIK66Bb0n3GmPbbWiJ8M
	y0ewBBY01K09bVXrDTkUYnb7WAwnYkT2Qe1XbhfqB2BZAs4p9NQykU4hXptQrbY93A+7
	UDtrkCD2qSbTKPlb6MwctKRdD+gSbnDPFmd0sgT60MixOBCu944kQ1QwgwgkqtZd54Hk
	bJfw==
X-Gm-Message-State: APjAAAXG/JJzn38khpHcKe08OmKProX1eYuoIdsCziVMjcTQGpkJ+UcM
	UCg+dbwLTIIt6cUYQ0tudOpnuXOaK4A=
X-Google-Smtp-Source: APXvYqyuCZXAf/BlKdq2ke7e/fI/IhaQdPTTfHcyW5ewlD9KRua8EoBX6AAK3IzbOtMG0jpuwLJpGA==
X-Received: by 2002:a63:e52:: with SMTP id 18mr65624292pgo.3.1558206122332;
	Sat, 18 May 2019 12:02:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.02.01
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:02:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:42 -0700
Message-Id: <20190518190157.21255-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518190157.21255-1-richard.henderson@linaro.org>
References: <20190518190157.21255-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 01/16] tcg/i386: Fix dupi/dupm for avx1 and
 32-bit hosts
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VBROADCASTSD instruction only allows %ymm registers as destination.
Rather than forcing VEX.L and writing to the entire 256-bit register,
revert to using MOVDDUP with an %xmm register.  This is sufficient for
an avx1 host since we do not support TCG_TYPE_V256 for that case.

Also fix the 32-bit avx2, which should have used VPBROADCASTW.

Fixes: 1e262b49b533
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index aafd01cb49..b3601446cd 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -358,6 +358,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVBE_MyGy  (0xf1 | P_EXT38)
 #define OPC_MOVD_VyEy   (0x6e | P_EXT | P_DATA16)
 #define OPC_MOVD_EyVy   (0x7e | P_EXT | P_DATA16)
+#define OPC_MOVDDUP     (0x12 | P_EXT | P_SIMDF2)
 #define OPC_MOVDQA_VxWx (0x6f | P_EXT | P_DATA16)
 #define OPC_MOVDQA_WxVx (0x7f | P_EXT | P_DATA16)
 #define OPC_MOVDQU_VxWx (0x6f | P_EXT | P_SIMDF3)
@@ -921,7 +922,7 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
     } else {
         switch (vece) {
         case MO_64:
-            tcg_out_vex_modrm_offset(s, OPC_VBROADCASTSD, r, 0, base, offset);
+            tcg_out_vex_modrm_offset(s, OPC_MOVDDUP, r, 0, base, offset);
             break;
         case MO_32:
             tcg_out_vex_modrm_offset(s, OPC_VBROADCASTSS, r, 0, base, offset);
@@ -963,12 +964,12 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
         } else if (have_avx2) {
             tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTQ + vex_l, ret);
         } else {
-            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSD, ret);
+            tcg_out_vex_modrm_pool(s, OPC_MOVDDUP, ret);
         }
         new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
     } else {
         if (have_avx2) {
-            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSD + vex_l, ret);
+            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTW + vex_l, ret);
         } else {
             tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
         }
-- 
2.17.1


