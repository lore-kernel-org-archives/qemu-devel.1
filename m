Return-Path: <SRS0=Qpa9=VL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565BAC742D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 264DA20896
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2019 11:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SnjNwwFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264DA20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmcS8-0001Rq-JO
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 07:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60318)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hmcR5-0005Tg-D0
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hmcR4-0006MU-D7
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hmcR4-0006MC-6a
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 07:12:54 -0400
Received: by mail-wr1-x442.google.com with SMTP id p17so14119335wrf.11
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2019 04:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0wQZY7BwhMGbzrEOB1c2143JMgOfq1mTVa8os+QOs8k=;
 b=SnjNwwFgWLWo/sDnqsLQa0H3gMnaxxiVUJy1ljCTHjzYy15C7DEYkZWxwCFNs+/Cto
 I9f2O6uftSECOxttpVsh4bm0kNG5y3Pbf5cTFG/KrTpA3llKreMJUulW1Z9FXCoW6csa
 zT393DLvo2oLMNZ3iX9Teb9KaSV4xhjqXPbXfHzc6a4dG38/Nc4gFYQMeS7hRH2Pttcn
 Q7BuEYZ4fnfKyN2zj5TVZoWJ/E4icvgeUknkvIgNUR1r4aq6o/33Ou3EKf/u0VnCGhz5
 UpUOmP5DCPYIcr9CcJRi+HDQ9TykD1+P5vKMuCGU+dEDr7Yu++5NZ8dZmtatco04KhYv
 vU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0wQZY7BwhMGbzrEOB1c2143JMgOfq1mTVa8os+QOs8k=;
 b=CaHoM9CSNLHxBOoISCaBF2Ky68ZTE3ahZl3ckM0TqwQ3UtiQXTzlgf1PZdSNIG519W
 YtQ9o/+hUGE0fDKjHZmw1bSwimaWyk1f7NL1ZujxkK7pr7CNoJVjXlAVIrTNCW5IyYBt
 tIXj95yyPSwjH8UI9WAPsXiZa2vokx5m67FBntC2U+yQUqpIaRor8/lAj4vwU1R6cvBF
 /6VJicng1pOqMxTAz9QSqj+kTi0cpl6mSTysq46qm7tyAIwMQwP9ux+MI5CfUB3PBHgj
 X6znzS3jFKDbGhBel+JkuNyP8jrQvLkxD4zHpfakNyn3jFczA5idU7A2mu7trYqrlsWp
 6Lmg==
X-Gm-Message-State: APjAAAXB4w5fXU4xo2XFT9lDKYO1MOKEZCC9XRsf07H5p23kISB+ZBIQ
 gZT4Uqp28Ki4Bdds/7xeqJ3HCiDz1A7ubg==
X-Google-Smtp-Source: APXvYqxZkcShDOZVElySLxWxx+1XhoZelDeNjzY8uaHygzZPGXUba3Q7mO03WA00+HTQrcUEnxPylQ==
X-Received: by 2002:adf:80e6:: with SMTP id 93mr22588812wrl.298.1563102772979; 
 Sun, 14 Jul 2019 04:12:52 -0700 (PDT)
Received: from localhost.localdomain ([194.144.248.241])
 by smtp.gmail.com with ESMTPSA id f17sm12675795wmf.27.2019.07.14.04.12.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 14 Jul 2019 04:12:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 14 Jul 2019 11:12:44 +0000
Message-Id: <20190714111249.13859-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190714111249.13859-1-richard.henderson@linaro.org>
References: <20190714111249.13859-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PULL for-4.1 2/7] tcg/aarch64: Fix output of extract2
 opcodes
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch fixes two problems:
(1) The inputs to the EXTR insn were reversed,
(2) The input constraints use rZ, which means that we need to use
    the REG0 macro in order to supply XZR for a constant 0 input.

Fixes: 464c2969d5d
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index b0f8106642..0713448bf5 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -2226,7 +2226,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_extract2_i64:
     case INDEX_op_extract2_i32:
-        tcg_out_extr(s, ext, a0, a1, a2, args[3]);
+        tcg_out_extr(s, ext, a0, REG0(2), REG0(1), args[3]);
         break;
 
     case INDEX_op_add2_i32:
-- 
2.17.1


