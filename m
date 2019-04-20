Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A4FC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 08:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F6F2087F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 08:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCtlkd1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F6F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38463 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkz6-0008Et-9g
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 04:04:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXY-00012p-Hs
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXW-0000nT-Ge
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:36:00 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXW-0008T6-A8
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:58 -0400
Received: by mail-pf1-x444.google.com with SMTP id 8so3469384pfr.4
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=6My5ewhJQTmrC7aPZrFJpyFIvvkO/0+nmBhhQ9PFA+k=;
	b=VCtlkd1w9plw02C6y3qV3WppgBB7Nh7i2ft8+M6T15fhTGSlaWktvrOR+u2oL3aJiq
	c5ZTfmxnMLQiSd7ycV1scZ29yhceZWZLdQLW1JiN0SUdb7p3ymZSs2/qEJmfHZScD4gF
	MazgtX/XV+mbATF2bG77E3j6x0kg4Nuc7KIFHi0zy3PCwzee2IplHMcAq+CeyMqaa7F1
	TCZxlhxFXJvCdBQ0ro1uNojmrBgxSqZP5HQZFG1WOwYOat10P7N3+XBDT2xeFwSQ9yYV
	yiqy3WGq1LCgGLcNwdGbPRMS6jy2jljcDyGs0zfvPRcPML2b37TOX4H8OQt9SaJt16Bf
	jzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=6My5ewhJQTmrC7aPZrFJpyFIvvkO/0+nmBhhQ9PFA+k=;
	b=TB0O+NCp2mio9tZyEypGVArpnnOyfE8JX45ESSmfjR4mEAVnQUjK0dzX4UuuFKYdPh
	yPh47aOUhkwphAuPC8ONSuQVU/I0QDD0HCta5AOscxA7/d7bX9RZpUx/oDPOfPIyI0b1
	d4WicFwvR+lnuusz8nyoDgSfgbtHhjbbKlMOYbVJYsu/pIc8DX4jtOUncFjkCaxEeT0u
	7qc96BH0W3ixL2fES/DMgjIua52HuZP8p96TL5cM4MHEwzsNYmaQYcDh1qwv+P9HyosV
	vZPZQ9moDPmqpq2SuzLZnYOwxd+P726X58wKfcmgaN+QsC5wyZa5ILT3tEJ2mEixMlqC
	X3Iw==
X-Gm-Message-State: APjAAAWLChe/e4EZSV3mRbN4gczYD8s0p5sqNwtkhEbSWwavrOwxmkek
	7SeyREpvUEZR+86dzY+2fKvAwl5FO4E=
X-Google-Smtp-Source: APXvYqwAIcRnBFR1ZYFLhTyeNmpJOOFRM5j/GAfF1iOMXzRTfosS3jRrRYq9O2pJyl+MShyh1/srtQ==
X-Received: by 2002:a62:6e05:: with SMTP id j5mr8517570pfc.5.1555745721726;
	Sat, 20 Apr 2019 00:35:21 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:26 -1000
Message-Id: <20190420073442.7488-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 22/38] target/cris: Use tcg_gen_abs_tl
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073426.9dfBb4r-qURWKPcaOvM_g3qI6bfa8pgEdqN-8wf2KKY@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/translate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 11b2c11174..0374718f66 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -1685,18 +1685,11 @@ static int dec_cmp_r(CPUCRISState *env, DisasContext *dc)
 
 static int dec_abs_r(CPUCRISState *env, DisasContext *dc)
 {
-    TCGv t0;
-
     LOG_DIS("abs $r%u, $r%u\n",
             dc->op1, dc->op2);
     cris_cc_mask(dc, CC_MASK_NZ);
 
-    t0 = tcg_temp_new();
-    tcg_gen_sari_tl(t0, cpu_R[dc->op1], 31);
-    tcg_gen_xor_tl(cpu_R[dc->op2], cpu_R[dc->op1], t0);
-    tcg_gen_sub_tl(cpu_R[dc->op2], cpu_R[dc->op2], t0);
-    tcg_temp_free(t0);
-
+    tcg_gen_abs_tl(cpu_R[dc->op2], cpu_R[dc->op1]);
     cris_alu(dc, CC_OP_MOVE,
             cpu_R[dc->op2], cpu_R[dc->op2], cpu_R[dc->op2], 4);
     return 2;
-- 
2.17.1


