Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B0AC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC61206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f10gAB5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC61206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51918 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnxD-0001ys-8H
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:15:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMncC-0008AT-Tf
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMncC-0004hR-0M
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:40 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMncB-0004gi-RN
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:39 -0400
Received: by mail-pg1-x544.google.com with SMTP id h1so3773942pgs.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=noj71OX2nBmtjQYQqqpKzc/I+BY/kKSngSA5N+1PwXo=;
	b=f10gAB5VruJnZW4D3xDGE4DyPtMaj1mtYWNggF1S3KEb1aq5nyVdBqBsGu8Un1P0XS
	7MzyGe7FkYoU69kLTfL/iP3fMsX0ReTrpKF5fFQtim63X8M4uKoFgT1F/0zJ6OB25iMb
	iN73RGMrMgDqD/gdHnjAtm6caZrnAbf18VdwqBRO9zMUowKbraaY019YLWITgsStBN1o
	SXpzSFhd+X2DKjv2vO/FFo5c1i3/6JLeI3F7+R2yntnvRZNY2r0JfyYEuAnGLYcJAKH4
	KQ34SmpNqrU3Zr6JA6vcdXNcDQ9AHomA1bk562G5jelWCRU9I6LWkdKh8POb17GNelU+
	OTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=noj71OX2nBmtjQYQqqpKzc/I+BY/kKSngSA5N+1PwXo=;
	b=I/PxDaBWBQ++I1hl7AEjYWGAVuglo2D5hi9F+fvC/ZVfJenNwGLoeCC3Bj2BtlGlXL
	TwwKopVRSn0xep5eAx4LhQae6OCH+8zJZzNGRUB1j3zcnrkHC7npw1hkeNGJwSNBA2XX
	h+VsKk/CD2Sdzu51w+MUUbH2yR9Pyr3Aeu87pA8yYX8XdAhUQFHCek0/rJ4y85QOmS3s
	OzrjJChur7GN/Iw06YZrvbm8084RyINUV2nWovsrPt86tHDfALpaFOd3exrbu3hp++OG
	1aPHXpqLb3KXmXZKPlZtRaUA1Vj7GvkC3rWml4jDQFNuTNC9Y4Qzg/yJEKWPineGwQln
	j2iw==
X-Gm-Message-State: APjAAAWIJWG8/Xj8VLQC6adcc5nnyLheEode1mqpKvA4+cnNf7IRcoeh
	G+7HRzZ7ZMiuiNIrR4ZUEz1qzQHNXOc=
X-Google-Smtp-Source: APXvYqx6jhL7i1+WbDlLV+qfPO2XKKJ+qXpBCapixxI0xnp7D4kc2HVg9dPgo9HwKoIF1DsHlhGoaQ==
X-Received: by 2002:a65:584f:: with SMTP id s15mr12608825pgr.171.1556949218632;
	Fri, 03 May 2019 22:53:38 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:59 -0700
Message-Id: <20190504055300.18426-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v3 30/31] target/xtensa: Use tcg_gen_abs_i32
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504055259.YWxuP6yUSMdvNGjWkpNXkbH4kMRx-WO9iXehl-xRq9w@z>

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 301c8e3161..b063fa85f2 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1709,14 +1709,7 @@ void restore_state_to_opc(CPUXtensaState *env, TranslationBlock *tb,
 static void translate_abs(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    TCGv_i32 zero = tcg_const_i32(0);
-    TCGv_i32 neg = tcg_temp_new_i32();
-
-    tcg_gen_neg_i32(neg, arg[1].in);
-    tcg_gen_movcond_i32(TCG_COND_GE, arg[0].out,
-                        arg[1].in, zero, arg[1].in, neg);
-    tcg_temp_free(neg);
-    tcg_temp_free(zero);
+    tcg_gen_abs_i32(arg[0].out, arg[1].in);
 }
 
 static void translate_add(DisasContext *dc, const OpcodeArg arg[],
-- 
2.17.1


