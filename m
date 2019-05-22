Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE11C282DC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF11F20868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f1PZ2iIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF11F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWaY-00032x-5w
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:07:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOn-0008P8-Gi
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCU-0008CY-5n
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:54 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:33509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCU-0008C5-19
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:54 -0400
Received: by mail-yw1-xc43.google.com with SMTP id v81so1252036ywe.0
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jubgcMuTGNSY5TtGEwh0c6OxeP3qp5DidyhAq6jVSSw=;
	b=f1PZ2iIn9dsO3VMKtMvskBrGiJK4m9OrtvCaexOuwm0hu3vKwY6EmmdZbFdpr8Bj5q
	etomMpuqZXjetwUr01u5T1/ScbyUjCW7CDEwkLYroNgnJTVSwuBpsYYh+ru9vP+FqZp+
	wVCWXZtZaSpJJY1kjH1sjfDMyvsMaqdJPjbhNl/jBG4+Sy1OcYnZlriRf1+ey2v7zJk9
	EpgQYgYiY5ivG//HsHY7r0PTVJ6Mm7738DOhgvp439k9URnpX3XvL/to4YSfjO0BahFx
	cF7Qf/NpeSVILfSlFIIXfgQQAJmHuGYX/VP0h60jFBF5KXH+zUAlr7zgILWFbdPqkw+4
	CrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jubgcMuTGNSY5TtGEwh0c6OxeP3qp5DidyhAq6jVSSw=;
	b=M6yV0Jt9z0x57FaQvAn5NXEHx8zw9Vn+j+LfI1RQEXKtTyMQi/IEd7D0v2JrQq8bmx
	Li8E6uYgIWe9g35i/3gGOO0NO/nY+9ZpfRt0ajfGrrLrpz5lAhkoA9EyIJTw35YhtI84
	4sB5VVSvIgnwGcqNAqLq8ETuKRGmXQIm4P7LlOYLoZYE94EUS0LY1dimox79vsRgQkuT
	v19H/JRm44EA6Hx8enfg5phZajUa5K4IRsI+uET6q2LIgMkmVy/baH1V/ERN81QccJlF
	mnSP33Ds8o8MBBneruwVmC6nLCo3g4731UqplMs2Vihklr+RBi10uri2epwoM6Xa1pOm
	MUrQ==
X-Gm-Message-State: APjAAAVLFuFGB+31NuJPCOcxrdiHI/MjxAxDRken2wvgrFx7ddnYjkLV
	oSvmmvBnru6GDXTiP4toHG8si40x2tY=
X-Google-Smtp-Source: APXvYqzKD96eHrhxDzKNOQrj62NmxlATmt5ICBslN+ccxkv7rjbpcBDEd+bY115xJgfX42n+MusjKg==
X-Received: by 2002:a81:3088:: with SMTP id w130mr42322592yww.63.1558550572691;
	Wed, 22 May 2019 11:42:52 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:24 -0400
Message-Id: <20190522184226.17871-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [PULL 23/25] target/ppc: Use gen_io_start/end around
 DARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Generating a random number counts as I/O, as it cannot be
replayed and produce the same results.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b5217f632f..4a5de28036 100644
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


