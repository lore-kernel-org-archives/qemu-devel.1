Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035CCC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79301208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRnc/kG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79301208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb3hU-00080M-CG
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 10:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3eV-0003QH-J9
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:27:47 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb3eS-0001HF-T8
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 10:27:47 -0500
Received: by mail-wr1-x443.google.com with SMTP id w1so1736244wrm.4
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 07:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=V0VNebrgohv9IYYKN87N6YOfgqI0isAkODJyfYTaOuA=;
 b=oRnc/kG/USrld8T6l8ev+0XBp8k1MhWvamOVi8CuEOPTRGuFG4EtZHe9bsjFQuC71H
 eHYh/7AFZjbalw4FD1Y4QaEaidDdAlwyRqKW5cBZK19+vQh35iASCnNOOy9/4pPxa+rb
 bfU8qvXYNmRBqLG1XsEtmmREj+ZYVx5opUBFHgbueqUTxuk8Wh+uh0JFe5ndYdbMkZhx
 cWSDv26K8ipyyXy7rBKwItSSbc8oe66twiF0q/H/Pdy+4ASf4rg53x+uthDZg5aImms8
 f1YXsFOg7eYRn8ZEL5iTCsa1IaGgLECDrdxjtiVybWocKS5BdWuZe+AArIicPCdu2Vde
 ufFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V0VNebrgohv9IYYKN87N6YOfgqI0isAkODJyfYTaOuA=;
 b=g879kSE92DgZEtxbL7uqSEox7SuijVJenh9ZGwsY0E1LLr10icTTCGwmxs3IWsnUie
 ZUpqiS9c1wTN3LqomcyqHDCHrVdYgxdapgIYRZplM4mKHdPffg/rcKzJKw2jaTejcaIK
 b501DquoGjFuNQFuL8voWraXgPktJA57Ow9nZzD3Kdp9TfVt1bKRPuURtmwpnTtRzFPt
 gzsKa9pQw4kKenDb1b3Dx8Dw8ZtOfEs8zkdBvNZfF5fXt3ImMubqtrVaw0SlMP+YduZB
 0CQfwxya/dW9ebhSNX05yi8/gRwQiNdXGS4B3372NrCNmUwRHDh3Fo8UB5lXMAWYBwJY
 Qslg==
X-Gm-Message-State: AOAM532LORIiyVXWe/PDGtiEuX92HwRq7xPDBQrpr0KqCohZKHiBAabq
 m9mbbkvj0rXnjpy8qbyMvLxGb1rPpAMv9g==
X-Google-Smtp-Source: ABdhPJy3hcRBUhQ0MxF7oFIZ9exCJC4oxmH4uv0Tztrfs+3fZrDWW5mzE7Oqtcu0LM6dHqIIXHMulg==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr3316614wru.356.1604676463318; 
 Fri, 06 Nov 2020 07:27:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 109sm2723462wra.29.2020.11.06.07.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 07:27:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] linux-user/sparc: Remove unneeded checks of 'err' from
 sparc64_get_context()
Date: Fri,  6 Nov 2020 15:27:36 +0000
Message-Id: <20201106152738.26026-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106152738.26026-1-peter.maydell@linaro.org>
References: <20201106152738.26026-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unlike the kernel macros, our __get_user() and __put_user() do not
return a failure code.  Kernel code typically has a style of
  err |= __get_user(...); err |= __get_user(...);
and then checking err at the end.  In sparc64_get_context() our
version of the code dropped the accumulating into err but left the
"if (err) goto do_sigsegv" checks, which will never be taken. Delete
unnecessary if()s.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/sparc/signal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index e661a769cb1..43dcd137f51 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -555,8 +555,6 @@ void sparc64_get_context(CPUSPARCState *env)
         for (i = 0; i < TARGET_NSIG_WORDS; i++, dst++, src++) {
             __put_user(*src, dst);
         }
-        if (err)
-            goto do_sigsegv;
     }
 
     /* XXX: tstate must be saved properly */
@@ -598,8 +596,6 @@ void sparc64_get_context(CPUSPARCState *env)
      * hidden behind an "if (fenab)" where fenab is always 0).
      */
 
-    if (err)
-        goto do_sigsegv;
     unlock_user_struct(ucp, ucp_addr, 1);
     return;
 do_sigsegv:
-- 
2.20.1


