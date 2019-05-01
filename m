Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EC2C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E19920866
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Typa60c+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E19920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36391 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLheW-0000tw-Fh
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:19:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRk-0006jC-3K
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRh-000344-1q
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:20 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRg-00033F-SZ
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:16 -0400
Received: by mail-pg1-x541.google.com with SMTP id z16so7854964pgv.11
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=FH8HIUisgKxx/wO5rpgn7QNUU9WJqnDYvJ4xHC9+spw=;
	b=Typa60c+Z3EIomuumJgdLEIvLgoW18goDviL8Ikh1kRgWYGsKBSfLvyrKklGaMeYn4
	V49XvPlDOJJ/tL5Lwl/dhmEplZEYbYTS29l0NX0oyMB+22i21Lkobh5JOuJFn5fQoua4
	vH6Bh96ZezD0wnTGWT86/qvUv86dubLrWDAyToa7J4H1VQbvyZuPCFuze3krvQiFABSm
	DWcUAPacFj9wtnnmrfDOK2lbj1y//Vj9lL+3B2v/cYqyP+wVHZhdAfLCwGhsFhAPUwPg
	wM00QsbpJ6m1RqaN8/DA8/gmFhwDiOtjAYfiCkPTqoqPOwvJeg+wT/lPwrbWtK3uaY70
	0zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FH8HIUisgKxx/wO5rpgn7QNUU9WJqnDYvJ4xHC9+spw=;
	b=pu/DKOmE7CoCrUWFm2Sh428/mhZU53kDAyY+zatzPr0BYvNAVq0qM10XfvOZophs+1
	t/fhvzKDcoaRqtcfKh5x88rfsOyQ7ZFfWW4ZEZM8v/NSM0C/9wYluh4fvt9G9pqIk846
	94AlUimVzE7tA5/PgyEWxniitv/u7g0jhuZS0uTD8WU6aiVPEkAEvCtWO0gIHXSTJpC6
	Vz9q0loy1BnmxVcE0JOWkBd7rijewQx9bkPvbp4o1QwTeVBHsvEG/QX9pVtfMvLkxlJF
	01uL3TCtEyzbEhtEAyajcT5cy8GrPLeRqXwdfpW5JlRapd/C042KJIZE+uEaJB4SfnZQ
	ULvA==
X-Gm-Message-State: APjAAAV2WeTvc3krc38+CH2a6gMBkP9xTULFEdK3YahiYhovNMMHGER1
	EYqaFlSb1WaLxcgZI3EwJ6qwDP4fcnw=
X-Google-Smtp-Source: APXvYqyppPX4wuErEXfawuK5c9Q31Dlyf7yuc5jhMaUGe2+2cx0+3A62F2R8boQvmVWT5pYsGWQGMg==
X-Received: by 2002:aa7:9aaa:: with SMTP id x10mr33551672pfi.225.1556687175197;
	Tue, 30 Apr 2019 22:06:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.06.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:32 -0700
Message-Id: <20190501050536.15580-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v2 25/29] target/ppc: Use tcg_gen_abs_i32
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501050532.o9nDEnxYRsLtSl0TvmbNgZrawRvN-BePq08XmVngLyY@z>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20190423102145.14812-2-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate/spe-impl.inc.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/target/ppc/translate/spe-impl.inc.c b/target/ppc/translate/spe-impl.inc.c
index 7ab0a29b5f..36b4d5654d 100644
--- a/target/ppc/translate/spe-impl.inc.c
+++ b/target/ppc/translate/spe-impl.inc.c
@@ -126,19 +126,7 @@ static inline void gen_##name(DisasContext *ctx)                              \
     tcg_temp_free_i32(t0);                                                    \
 }
 
-static inline void gen_op_evabs(TCGv_i32 ret, TCGv_i32 arg1)
-{
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-
-    tcg_gen_brcondi_i32(TCG_COND_GE, arg1, 0, l1);
-    tcg_gen_neg_i32(ret, arg1);
-    tcg_gen_br(l2);
-    gen_set_label(l1);
-    tcg_gen_mov_i32(ret, arg1);
-    gen_set_label(l2);
-}
-GEN_SPEOP_ARITH1(evabs, gen_op_evabs);
+GEN_SPEOP_ARITH1(evabs, tcg_gen_abs_i32);
 GEN_SPEOP_ARITH1(evneg, tcg_gen_neg_i32);
 GEN_SPEOP_ARITH1(evextsb, tcg_gen_ext8s_i32);
 GEN_SPEOP_ARITH1(evextsh, tcg_gen_ext16s_i32);
-- 
2.17.1


