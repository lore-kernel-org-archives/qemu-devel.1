Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D916C4649E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB159216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHISs/FM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB159216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQnC-0000Cw-0B
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40288)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hjQhc-0002vB-JY
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hjQha-0001qR-D5
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:04:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hjQha-0000XK-4C
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:04:46 -0400
Received: by mail-wm1-x342.google.com with SMTP id h19so7885306wme.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qOB93lgrL4R9/I6qfgAIZn9QujVBWBIWVU/5cvf+96Y=;
 b=yHISs/FMVOK0HYzPaloOwliLqK1L8EbywhZiD2dTaa3syaAx/DPfSJEQErohzcjhA+
 fg+urcQHJcWn/tJF9hTAVXjaPJfxQskfNA6vlzpgC+qWP/e8zsmWvCwIDiLBhHSmW1F3
 4ADA3/qEe2aTD7a4nD6bkKmMSo9b/YkVLN3nsAQl9WPdNd5ShUxfS/M6tobWe1s0QkDu
 EfyF2/IeKo3dr7JqxNKdq6lI0srD+WctTrKt7iCBenTHUnSh/Ju0q34qweMj5W2R4M2S
 q5htEUZZXPfIXEadiUxDtcBC1oUNF8UMDwJYbPxLYsezj4Ktnl8tWPcBQ4EmvjQ7rywV
 HT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qOB93lgrL4R9/I6qfgAIZn9QujVBWBIWVU/5cvf+96Y=;
 b=EUwH/6gAGP5VckRw5aPzN9vJbxAYcFFeLa1gfy9VVWyjZTOlUR+CUFpIi96l22dLLF
 Xa134y6ZRLwPn4VYnmjjvDTkVg1YemXtBTUtX27VJIPAD6mAXmq/bl9nszstXj+lB2Wv
 5+lPaE7FmNgIBXf8IsznI3KpaZgDfCkz+YzGEV0vIadARHUPjB+FWXeBEUmJZr+Ss0QF
 HN2oBonW3+VUMBfYoEcAp2RR8mSeADqupMZcbYE+yJYFTZdyo9X73Ky+woipO+72wWT3
 LC5UjQvWXN8/lbDvMLMCa6vfM7RxnJnJYmP1e3MV1ASzUBe7H+uCgc+JJCQjp+LsvaCC
 XPPg==
X-Gm-Message-State: APjAAAWb2T0G7XKrsB1ABcyWThDQIP5wMHAExPmKi1ub1ykOFFzcxfVK
 JxYQuaeDDjxEIdBSvyi0prwJQw==
X-Google-Smtp-Source: APXvYqzOtHMYbzrFtdfxlQL9ebz/J5izClGAj2H46rkP6+qxtkGpHEiKPuwcDAjfxgN0zsdVgjfrKw==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr4185121wma.120.1562342665585; 
 Fri, 05 Jul 2019 09:04:25 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t15sm9442318wrx.84.2019.07.05.09.04.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 09:04:24 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DDC011FF92;
 Fri,  5 Jul 2019 17:04:21 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 17:04:21 +0100
Message-Id: <20190705160421.19015-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705160421.19015-1-alex.bennee@linaro.org>
References: <20190705160421.19015-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v1 5/5] gdbstub: revert to previous set_reg
 behaviour
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The refactoring of handle_set_reg missed the fact we previously had
responded with an empty packet when we were not using XML based
protocols. This broke the fallback behaviour for architectures that
don't have registers defined in QEMU's gdb-xml directory.

Revert to the previous behaviour and clean up the commentary for what
is going on.

Fixes: 62b3320bddd
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Cc: Jon Doron <arilou@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 gdbstub.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index ea3349d1aa..b6df7ee25a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1669,12 +1669,23 @@ static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
     put_packet(gdb_ctx->s, "E22");
 }
 
+/*
+ * handle_set/get_reg
+ *
+ * Older gdb are really dumb, and don't use 'G/g' if 'P/p' is available.
+ * This works, but can be very slow. Anything new enough to understand
+ * XML also knows how to use this properly. However to use this we
+ * need to define a local XML file as well as be talking to a
+ * reasonably modern gdb. Responding with an empty packet will cause
+ * the remote gdb to fallback to older methods.
+ */
+
 static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     int reg_size;
 
     if (!gdb_has_xml) {
-        put_packet(gdb_ctx->s, "E00");
+        put_packet(gdb_ctx->s, "");
         return;
     }
 
@@ -1694,11 +1705,6 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
     int reg_size;
 
-    /*
-     * Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
-     * This works, but can be very slow.  Anything new enough to
-     * understand XML also knows how to use this properly.
-     */
     if (!gdb_has_xml) {
         put_packet(gdb_ctx->s, "");
         return;
-- 
2.20.1


