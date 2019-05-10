Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D085BC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4F1208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fj0nTSks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4F1208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47824 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9jB-0004V4-RH
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:54:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9Mh-0007cc-1B
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hP9Mg-0006Eu-51
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:23 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hP9Mf-0006Ed-VH
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:31:22 -0400
Received: by mail-pl1-x642.google.com with SMTP id b3so3138221plr.7
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=3/XT/GNbTz9t3be4QG6qS3S59cCXuga8GczXPdJ1EMM=;
	b=Fj0nTSksTM4fN1HQhx5uGxgNCq/HKYp0ojeEbcEI65djDLBJWYutwPjsmKSw8WB+uZ
	VoFRNfzbIvehNcc8KgAKWcm1EChcnteZxXjtTnkpkMsrnaHMNQcc91SX1nD/7oD/UdcL
	zCmMQctVdb5AmiC6HalqkhPbGjeCLIEEWba6C/JxkjDYwyO7CKWRXHNikicEjCy0pdas
	a/ERAkmLB2ouKdtheeWUj+HbV+V70yCAOo+ifobiFk1SchHM4u4NbGreB2LLvGqW5A5f
	ISauxo0DZwOvz5no/1BTgH7y1JamXDBezY7WgrBXuIKOq4zLSGuONPVujG7HBMbkXVCG
	2JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=3/XT/GNbTz9t3be4QG6qS3S59cCXuga8GczXPdJ1EMM=;
	b=FrM/Gq5JmwhafrNM7O7MxMRNNXHZXfhuJfmXRkKWKaTyV5xaeVQsVmk29bhYK2qYzz
	Kp8HgcrsL48mEMIzQCaP38eRi3tGLuDNbXIbenpDEPd9HWKVYktvClbFLEskhe2JfsSH
	kRvR3C33g2zoPA5ehdoYktKukpe/ROB2UH7mknmphYZQgsVxZOJ7OAHmoW9X4gVZqFtk
	JBfEqN69SNSUcGI2VLCf6o0kmah2eUiyRodHnynBr0MUjLLyZL97CJhNiFWKSx22BhSC
	R+bpJ5tADgK7JOEzIdGm1E5e6R4Xm5eIaHVxBi4fXTVxLPgUrX1M2X7qz1wi4x+DaDWE
	mD/Q==
X-Gm-Message-State: APjAAAWSx4260p4o58NFcW94nIRV1PdbvyatsUnyV3FgKh+XyCB+NewO
	Y+if1gV4gDZBnY97Jo+y4idaWRosRVE=
X-Google-Smtp-Source: APXvYqyxAalJ7+Qny5idoBn36QbyQfkIYJy64xiwdisR9O6FTb6r4MFIWVKUgu45u4zWBap034IAHg==
X-Received: by 2002:a17:902:8b8a:: with SMTP id
	ay10mr6272032plb.74.1557509480814; 
	Fri, 10 May 2019 10:31:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	v64sm7936792pfv.106.2019.05.10.10.31.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 May 2019 10:31:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 10:30:48 -0700
Message-Id: <20190510173049.28171-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510173049.28171-1-richard.henderson@linaro.org>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v6 24/25] target/ppc: Use gen_io_start/end
 around DARN
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
Cc: David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Generating a random number counts as I/O, as it cannot be
replayed and produce the same results.

Cc: David Gibson <david@gibson.dropbear.id.au>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8d08625c33..76628df6dd 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1847,13 +1847,22 @@ static void gen_darn(DisasContext *ctx)
 {
     int l = L(ctx->opcode);
 
-    if (l == 0) {
-        gen_helper_darn32(cpu_gpr[rD(ctx->opcode)]);
-    } else if (l <= 2) {
-        /* Return 64-bit random for both CRN and RRN */
-        gen_helper_darn64(cpu_gpr[rD(ctx->opcode)]);
-    } else {
+    if (l > 2) {
         tcg_gen_movi_i64(cpu_gpr[rD(ctx->opcode)], -1);
+    } else {
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+        }
+        if (l == 0) {
+            gen_helper_darn32(cpu_gpr[rD(ctx->opcode)]);
+        } else {
+            /* Return 64-bit random for both CRN and RRN */
+            gen_helper_darn64(cpu_gpr[rD(ctx->opcode)]);
+        }
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+            gen_io_end();
+            gen_stop_exception(ctx);
+        }
     }
 }
 #endif
-- 
2.17.1


