Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAD6C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01F52206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VStycXpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F52206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51959 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnzN-0003yx-1c
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:17:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc7-00086N-Tq
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc7-0004Zs-0A
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:35 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnc6-0004ZR-NX
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:34 -0400
Received: by mail-pg1-x543.google.com with SMTP id d31so3761378pgl.7
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=FH8HIUisgKxx/wO5rpgn7QNUU9WJqnDYvJ4xHC9+spw=;
	b=VStycXpYORhcyAUFJqdxZY9HOJhs0NROhjHN/6JwygcC4G3d05u0Y/NpMjft9zfccR
	frtH/JxN/wFU8na+G8bwlgu77jeOLuPYZIkdxO6odXF5+NggQ/W4H0Q9lV4BHk+blSGP
	BisLSulbGWV0lFb/VD5m3WcBsKDwRqxzx+4R1EWcZ6qblgaGuxaS/WCjsEDhtZVkKPuU
	wGXrPmuFMintwEM5wJ6B9iokxRSGmmWqcXBwU0BBeo1hjgDf/LR/MVBzs5+ilTt25koq
	bLEdFf1niEhC9mV8uf0wW4CQ/5l0rqZpyLDpV9QwSPFMk1hGMaaPDS8wTVFxj59Ct0TC
	PAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=FH8HIUisgKxx/wO5rpgn7QNUU9WJqnDYvJ4xHC9+spw=;
	b=hPPqGsOy5hzlZHQZYwi3kV9pCkhNJ5MfWnivPuu4esDoj0XRaHxQzOfFSeDd4hVibQ
	qMp1BrPiImOG5MQkQQ1750I+uC24e9twDI3Y+k8k3Qh0+kQGDR6uG3YSunESrrN+Natm
	5teZuHDpXitBnaKJhhJRiJEEl+Ew9WzFgU5UVEzQ7D9aefLA/hqxGMc7oYVzc4+ZAuy9
	V43BNX/Uc2Ua3tP7FdRJO9xmaHQVa+3xsXoz4QCwgUIu9s60eH+n3hiVVIoDciEtztxK
	izfkJHa+IAS5605n2KtvPh+tlnB8hOnz1O56JlVjPThDFXhDJg7RygYgX0DT7iMVqCxl
	dgDg==
X-Gm-Message-State: APjAAAWaHD9MYrZYxQFh1B2uLRbVsg6r4h3OCYXVLZcLEIMe0CxlD0n6
	ZByL+JIDm8CFb20JLzU8kCTfwaP1jnY=
X-Google-Smtp-Source: APXvYqw2mGnQpCd/4kiKX9YHuVT+MwnkqxGiusTLAcGw+ogd7L++F/eqJ/hyTfxG/3vSRshvNvAm4A==
X-Received: by 2002:a62:164f:: with SMTP id 76mr17023836pfw.172.1556949213489; 
	Fri, 03 May 2019 22:53:33 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:55 -0700
Message-Id: <20190504055300.18426-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v3 26/31] target/ppc: Use tcg_gen_abs_i32
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
Cc: alex.bennee@linaro.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504055255.sPq_eD_zJ4Z_Hq-gXc_sOvAWNQLPtyD4qyKos-kt1pA@z>

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


