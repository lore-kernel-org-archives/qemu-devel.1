Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1ACC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0638208C0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YyXfQkP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0638208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38075 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkYD-0001K6-Rj
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:36:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWP-0008K8-Rg
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWP-0007dk-0C
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:49 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWO-0007d9-Qo
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:48 -0400
Received: by mail-pg1-x544.google.com with SMTP id j26so3592082pgl.5
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=YkMxlfFJAQpW3I+t0/p8rsXbmxL072IYugeieLVyM2c=;
	b=YyXfQkP4rGw8S1CRIa21uD6k894XLt6wYqEz5301YXMOgb7wjc/2+UjCbhr2xroMTi
	Y0GQ3ho2LnRV47gsd0/k0bCrsoMMnpByIyY4qjSIrF6jSSfOoUDq26XXwpzAzQnI3yPr
	XLbRqKzILHmEMozg4sJrvvpP7RPWPgTXSMa9IOU/b3lwtld4W5GIsdNGTsHetfWOnFFD
	VX2B+NEQ0XycfLKyos+JCYwapWBLmxIOjVDm8p9EgC1Jy16z5IML+2xwiEPzHiV/ioLL
	5Wt/JVLuxxHEgoIyeP1MjAKM7dQ/SomVGtOPda/GykMSffvxglvft0b1w/zbRJtI3TNR
	HTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=YkMxlfFJAQpW3I+t0/p8rsXbmxL072IYugeieLVyM2c=;
	b=AOx6Cc/c1R7/MTgp1RvFPvmLceuXgORWUn6NWYx3/LrEgl4cqg8uWv3XGOQDQDvXDR
	XQDkfbMyXTw2qIH3gUJ4lfjiIKupsRV2FLUaaxcOXeEp24DLQUfZtJ+sGkwzLgJEag2M
	wfl+FD4hIOnY8+WCk0ouKMezPq7DnWl4I5k4654MLhX/c42D750/iqtpCr4sFxb7Nxr6
	bRR8QT02zfKQc+TDmnuhHNJ60Wf62/iO1Cisu6GbrNjEtrLeJ/FZHf3X/czfdnHBV2i0
	ic1CxGvsJp6Dx8mjv7YZmyfmMgG0lYdAt0IGtqNYMmydOxfxIy6z2d00S9NFUDb1F6FC
	0lFA==
X-Gm-Message-State: APjAAAURIdkTmZGK/BDr3i3DNN7rpqDZI20g2BYeKkUQZbnAjRK4Gf1I
	H9oDyqc5bWXVPzCry6ZIfqfd1oBZ7fo=
X-Google-Smtp-Source: APXvYqy/B9Wv3Qj0NIijdmuHfeIBYfDyKmLqMCwQ2SzoV9Rw6v0ZECJ30wV+NPymELg6IggLG0oFKw==
X-Received: by 2002:a63:744b:: with SMTP id e11mr8044950pgn.327.1555745687606; 
	Sat, 20 Apr 2019 00:34:47 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.34.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:34:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:05 -1000
Message-Id: <20190420073442.7488-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 01/38] target/arm: Fill in .opc for cmtst_op
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
Message-ID: <20190420073405.DXwhkekLMGJHWhKTH1wRPAs_068mFmNA5MWMKsRBPis@z>

This allows us to fall back to integers if the tcg backend
does not support comparisons in the given vece.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d408e4d7ef..13e2dc6562 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6140,16 +6140,20 @@ static void gen_cmtst_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b)
 const GVecGen3 cmtst_op[4] = {
     { .fni4 = gen_helper_neon_tst_u8,
       .fniv = gen_cmtst_vec,
+      .opc = INDEX_op_cmp_vec,
       .vece = MO_8 },
     { .fni4 = gen_helper_neon_tst_u16,
       .fniv = gen_cmtst_vec,
+      .opc = INDEX_op_cmp_vec,
       .vece = MO_16 },
     { .fni4 = gen_cmtst_i32,
       .fniv = gen_cmtst_vec,
+      .opc = INDEX_op_cmp_vec,
       .vece = MO_32 },
     { .fni8 = gen_cmtst_i64,
       .fniv = gen_cmtst_vec,
       .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+      .opc = INDEX_op_cmp_vec,
       .vece = MO_64 },
 };
 
-- 
2.17.1


