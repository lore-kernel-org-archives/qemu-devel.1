Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB011C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A0E520639
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTm9I81M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0E520639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx6B-0003QT-ML
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLr-0004nW-Vc; Thu, 03 Sep 2020 17:01:00 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLq-0007ol-2p; Thu, 03 Sep 2020 17:00:59 -0400
Received: by mail-oi1-x244.google.com with SMTP id r64so4523757oib.6;
 Thu, 03 Sep 2020 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hBv/652Zc3vxedUaDXUBkYliuRqc7HcQ84NCJAihy/4=;
 b=KTm9I81M8cWYvo2JUKgDM5VV/LzuZirf1yRjQgxyMQNbNO+1D3w4WRZdp7f3Ud8bOB
 qXF0jcg+dpuHkix0MkTQDcBRgf5oE9Low9Vk5jZSROQ8qav8pLZzCRPxjhQuuFxyRC5F
 uQb7Ej2AMfgQ2OV1SsXMVMQvZjH40i+1bf7vKMzNhkQltemPAqClQl35wrmTErUh0pf1
 ckVNPgh/omhhwyOb0T4oE2JkmAxs7LZNTuma93y4sUtUHNYY3a7fLKsY+vkMPh8eT/VD
 ZcuwBxZnlLB2iGYsyaCAUCG6yfEcY97EVIafu5j0H3gU8LIiPO69O38WYvfIoFIsZPoQ
 tpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hBv/652Zc3vxedUaDXUBkYliuRqc7HcQ84NCJAihy/4=;
 b=G6FA79Et4BQy61frLxEZ+HqNVALJJB4iYeBMFKh3zpwmVKw/uJKxQP1DAvmhBMmvxZ
 IS1EZ1AMvc3qzcKkneIV6fAX8XoXGshBAdqNf4Gg9d8kQJVk+7hWdDGQMaAKjJQLPNVm
 8nJCWvO73FWgC3MYHDmx7M/+4nG3uNStwac+FcKNXGT+ZrWyC5xTN6TYWqtdwrcZSvTP
 htiEi2EVCMp5IrYPM76S3/dLs7qBqSisDW2x7PhU5Edv3WCR9P95OUg4DW8XwWy3VJFd
 DNNhjcCLt+lFb+Jh50VztjPZhG5gEAk9mR4hDWxDAJsorlWKjXDvFeoGxm/DVGkCK7uC
 dPzg==
X-Gm-Message-State: AOAM530G+cEKWN68HoraZEU9yGBY3oZRzzXxOWNzYf3CGWYPnSM6bdOL
 krsV6A1+JNcRoyvSn/I6Gz3UBBdJoO8=
X-Google-Smtp-Source: ABdhPJy//E3qeJYtO8uurp2A08lQP2AGt+yAbHxqmkKqdVWvA1At/ppHFIq0FUDEc9Q5a6NbKkA0Eg==
X-Received: by 2002:aca:44c3:: with SMTP id r186mr3256905oia.53.1599166856381; 
 Thu, 03 Sep 2020 14:00:56 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id t22sm765241otq.44.2020.09.03.14.00.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:00:55 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 56/77] target/hppa: Free some temps in do_sub
Date: Thu,  3 Sep 2020 15:59:14 -0500
Message-Id: <20200903205935.27832-57-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Two temps allocated but not freed.  Do enough subtractions
within a single TB and one can run out of temps entirely.

Fixes: b2167459ae ("target-hppa: Implement basic arithmetic")
Buglink: https://bugs.launchpad.net/qemu/+bug/1880287
Tested-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200720174039.517902-1-richard.henderson@linaro.org>
(cherry picked from commit 79826f99feb7222b7804058f0b4ace9ee0546361)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/hppa/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 52d7bea1ea..4bd22d4820 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1294,6 +1294,8 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     save_or_nullify(ctx, cpu_psw_cb_msb, cb_msb);
     save_gpr(ctx, rt, dest);
     tcg_temp_free(dest);
+    tcg_temp_free(cb);
+    tcg_temp_free(cb_msb);
 
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
-- 
2.17.1


