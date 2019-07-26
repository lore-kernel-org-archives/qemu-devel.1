Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54288C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18854218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcq8eWPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18854218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Y8-00082Y-WF
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59599)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nu-0007Ms-Op
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nr-0001Hz-HP
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:00 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34806)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Nn-0001AI-IY
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:56 -0400
Received: by mail-pg1-x541.google.com with SMTP id n9so18890225pgc.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GfZoaF1PKj02fL5gI7kwlJOVMtCnQ9O6XVR81E0meI8=;
 b=kcq8eWPVuVdKWR6yW1d/KHcSAnOLyfw8o2AyH2g3hGs0sb1lxn1A0JA91+kpnwI0CS
 qppjr3UV2eo+kWSsTPm3Igg9+XENJRT6omZwXtoPzln8YbZFwhvmXqShJtOs+gWUxCbI
 HJL5Qwclub7i4zjhVYFcV/RnUvyw7xJ7RNyViifawnoL+u/kaoFsODr9lQYgnxIZr9Ee
 yGVhmt9i+LHlYGxDHjym7zm4dxuy5Fbnac9Pgng2GmSzyrkwS3bmj3hDq13G9v6VJfFp
 K49ZJeCEvLowoCCkYWtjZwPgnRGejqDJGD6/7r4MYQgJ/f9VNIQrxVniWbS1iD2tJ7qK
 MLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GfZoaF1PKj02fL5gI7kwlJOVMtCnQ9O6XVR81E0meI8=;
 b=eHDBEObfeFUkmJ5lHLlEIhd2uI88aTn9xDKoGAJ3B9/unYqyITTDCw5W6XNZNpOD9L
 kAiaoTzJbn/PofZNui7zF1oPBM0Pt0XKELsDzvdulcuGN343EU6NG1GQ7PeFo5N3iDuv
 cF7CVA/Ftm4kR0eCRySg4BfgjzZbj4vIFdk2Hp8bn6BmBukE8SgoIhjRTJ8tdVcm9sVr
 nmPAjdcLWWQuVpMl98LRKJq8hMbY49bLDx/3iojpabHMW69VeHz1Tyx8fOhXVFszMvSi
 wz6+ehVBZIcd5XxQtNMyGxy3nXsZTdFn5y1I78YiIbR1qk/yhktSFCjdk8M7wn46mSUm
 B++A==
X-Gm-Message-State: APjAAAWt1u3eRVuHv3bGPnyuIiJrn8Mydctz0/Q6x69zYBOGS3gGfc1x
 JG3Mjs3jYF/VoTrfdcy/qOhlvDTZiX0=
X-Google-Smtp-Source: APXvYqzVE8B2mzx60xssgjTgsd+M67p9tl80pak7Zh1+teSK+EutOz2+fAnoMN9JoFaJa/Bey3kDvw==
X-Received: by 2002:aa7:8218:: with SMTP id k24mr22628587pfi.221.1564163511718; 
 Fri, 26 Jul 2019 10:51:51 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:30 -0700
Message-Id: <20190726175032.6769-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 65/67] target/arm: Clean up disas_thumb_insn
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that everything is converted, remove the rest of
the legacy decode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index a8db6e9280..c2b8b86fd2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10677,32 +10677,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    if (disas_t16(s, insn)) {
-        return;
+    if (!disas_t16(s, insn)) {
+        gen_illegal_op(s);
     }
-    /* fall back to legacy decoder */
-
-    switch (insn >> 12) {
-    case 0: case 1: /* add/sub (3reg, 2reg imm), shift imm; in decodetree */
-    case 2: case 3: /* add, sub, cmp, mov (reg, imm), in decodetree */
-    case 4: /* ldr lit, data proc (2reg), data proc ext, bx; in decodetree */
-    case 5: /* load/store register offset, in decodetree */
-    case 6: /* load/store word immediate offset, in decodetree */
-    case 7: /* load/store byte immediate offset, in decodetree */
-    case 8: /* load/store halfword immediate offset, in decodetree */
-    case 9: /* load/store from stack, in decodetree */
-    case 10: /* add PC/SP (immediate), in decodetree */
-    case 11: /* misc, in decodetree */
-    case 12: /* load/store multiple, in decodetree */
-    case 13: /* conditional branch or swi, in decodetree */
-    case 14:
-    case 15:
-        /* branches, in decodetree */
-        goto illegal_op;
-    }
-    return;
-illegal_op:
-    gen_illegal_op(s);
 }
 
 static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
-- 
2.17.1


