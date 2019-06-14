Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A68C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220602183E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1DmIUjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220602183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53912 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqQv-0000P2-5K
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58666)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqj-0005bE-5a
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpqe-00078m-TI
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:47 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpqe-0006hj-7i
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:18:44 -0400
Received: by mail-wm1-x341.google.com with SMTP id z23so3055013wma.4
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qBxTdhQNZtrN8TCgxYqVNYuvZXvpIW53Hq/nYGE1p+s=;
 b=M1DmIUjJySM8HeXdTGllOAnCV5BQWwrV1ZQFtLnDqxSe2LLP/N+uoi7AKRg70JDFSJ
 oaPMDLXPqfdBoiN2qTzSdyo9HkxQbKz3psNqrDLueGza2A5702DY+6pfV2by6zN+ksVP
 8LNHPNSNEF2dKg9M71LyVkLbHN/3FGYzfouiDnEcWwWmmRappMgfb3EIC6ryJL8Mr8Nq
 IBWf+blPzV7TKFV+e6rYxhAnMFfjBv7HzzC5q6HtwDy4TXrkm+vr01IK1ep6vOgr/jkE
 9wvXj4Rxd0C0sYh1G8L7uf3iAO1OTW2z96pfBTT+nTbpauxHivoN4HDFKn2df36b+UeI
 ymgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qBxTdhQNZtrN8TCgxYqVNYuvZXvpIW53Hq/nYGE1p+s=;
 b=VBjlFLY3lHveV1gIWbiIa2xmed/+SfpBPaG416TcsOWZ4KE7Zwm6EbLk/BvLOy6Nni
 QVJg0z3m/aGpuZykZBNx35l2etGa4BIHtIZECPfr3DYuLXvwjUtFeRSNuF47mNOWFbtb
 5pKK6GeH+DFzhXVy9Zgyt4BSu0YZPv0+mxC+zdw587MuEyrbYARXJI1WcVjaJYG1CA4q
 DpvvWu3uKkYwxJJ9PDB20O6b6FmNzubv/3mUIxJzW2GxRTYv3AYX6A1LH6l8yl+MJSJg
 QPW74mhpjaxQ9reBF+6e+rR1edvnYavxa8ZpbRh9+a2opDAULBGVAnq1nOetlzMUVb17
 l3xw==
X-Gm-Message-State: APjAAAUkkKECLmc5t2OaVKrs4mWOiF65cNDYFeFiorX0pjk5Pf4OBfoV
 XfepiCz3yaG3elpPRLGTGnTaFw==
X-Google-Smtp-Source: APXvYqzVzcy/lNHpdyTqDBQUqPXBwnbG4otD543eQwqA42aI8vWZ7Xz/YgCZ6NYSB2WR8ltP7bX9mQ==
X-Received: by 2002:a1c:c549:: with SMTP id v70mr8517710wmf.135.1560532711546; 
 Fri, 14 Jun 2019 10:18:31 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s188sm4164408wmf.40.2019.06.14.10.18.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:18:29 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 697DA1FFB8;
 Fri, 14 Jun 2019 18:12:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:43 +0100
Message-Id: <20190614171200.21078-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v3 33/50] target/riscv: fetch code with
 translator_ld
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>, "Emilio G. Cota" <cota@braap.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/riscv/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 313c27b700..899abf41fa 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -793,7 +793,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPURISCVState *env = cpu->env_ptr;
 
-    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
+    ctx->opcode = translator_ldl(env, ctx->base.pc_next);
     decode_opc(ctx);
     ctx->base.pc_next = ctx->pc_succ_insn;
 
-- 
2.20.1


