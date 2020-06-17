Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0182FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5C32166E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EaXicV2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5C32166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfL5-0007hl-T3
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfE1-0003EU-4C
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:05 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:44349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfDt-0008UW-Pi
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:00 -0400
Received: by mail-qt1-x842.google.com with SMTP id c12so2730052qtq.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=YemnOlklw+URp/aLKC6SFqz2X8HrxCoaaT+NwLjZldo=;
 b=EaXicV2SrI+jZc6jXA3EYsKOVyBml4iIwvFptjrgJSaDZTl1CxdsgLEDDrg+OTstid
 /p0bJ/ZhZckKfDS983OAVfF+wUVE7MwWOnt9zISrGsGAI0TdgZXjmtuZAkylfJPmuJCN
 rWV4jZmZvFyKeJ69TKoVLZO7ID9PNOqbFiQyfE7oNgXwzNxvShyC7SRsUU+wWv3dhOxC
 yRjfgEL1vTFweXxAEIsGR4Sy6ca4YsqjFEIcU7Fb2ifqarqgxi09BpQSMBdIr1A9I8As
 u+47cOCFkkr0RBF25khfp7+zOR4Xh0ga3ykD7odaen/IwSoFIRliyhzHsQkAhSo9Ul7J
 0enA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=YemnOlklw+URp/aLKC6SFqz2X8HrxCoaaT+NwLjZldo=;
 b=Es6jOgL5zJbCXNpPjAhS9+OrpTaUwo9ZL9YyW0sCGjN4fHnTQ1ox4J+neeMg1W0NGA
 QhRpqksYIUH6GFeU7XlPKrr+BplvSiYVw/uIirxK2Q/exOyqJ6WB+3Qa5NRv1eW8UwHD
 t3UOmqzrCVLtgnt+HgIL7wuPyKEZH1YCawU1mPa9L3Ru2/hPTZFNQXxVZ5p6ztXlFuYS
 C0+s98Lfga7Eg+DelaI7ObFkpqG31sjBq2CBdcqUlpCAEvj1HBQSB/Uy3DZyWm08pZ5q
 0m1IeVBHBYk142+Vh/ixyI35hRjmwsTXuH3lgjV4Eg/HDtpmNb5JRxL60oQlHcptkK30
 dd7Q==
X-Gm-Message-State: AOAM533bHK+QKolMnwzfcxiwKEq8GAeKluGEf7pyZRa7UsVEPRFzAMpP
 1Nl5fJ4lhgT5SWm7ZsVca9aXRfj0BMs4xA==
X-Google-Smtp-Source: ABdhPJxHn8AowkC/EXsVktX4pts+OqQvGVJhH/dy8X8htxveYHYznjUY7wrfF7EOpcNQSeoyRZFQdw==
X-Received: by 2002:aed:35fa:: with SMTP id d55mr1054590qte.385.1592427830871; 
 Wed, 17 Jun 2020 14:03:50 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:03:50 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 24/73] riscv: convert to cpu_halted
Date: Wed, 17 Jun 2020 17:01:42 -0400
Message-Id: <20200617210231.4393-25-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x842.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, robert.foley@linaro.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, cota@braap.org,
 Palmer Dabbelt <palmer@dabbelt.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/riscv/op_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index b0c49efc4a..fe1373a95d 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -176,7 +176,7 @@ void helper_wfi(CPURISCVState *env)
         riscv_cpu_virt_enabled(env)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     } else {
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
         cs->exception_index = EXCP_HLT;
         cpu_loop_exit(cs);
     }
-- 
2.17.1


