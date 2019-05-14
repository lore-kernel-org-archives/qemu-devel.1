Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D07AC04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CB821734
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 00:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtcz28yA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CB821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36875 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQLHF-0001Ir-1d
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 20:26:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQL4N-0004h8-S5
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQKxi-0003u7-77
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:08:13 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxf-0003kn-U9
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:06:28 -0400
Received: by mail-pl1-x644.google.com with SMTP id f97so2171963plb.5
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=noj71OX2nBmtjQYQqqpKzc/I+BY/kKSngSA5N+1PwXo=;
	b=jtcz28yA526udG4B48oNCqm7yEW54j8bRtwkhwSvWd4tkdYt5//ZF4sPwNhEzdSD0F
	ClPCon1esoPYq5sw65/d5kjS0fL4HG7iH61x7bW5UnG4+hZ+DTNisXutkBE/uWrO6IRp
	5InJx9aVIvvDePzPpjjzcIvUg1BberPxpW5X40e6RmdQKOlLOTpTi+CIYaaXL0ZE523C
	XHXXIwgub9LdFrExuTd+N6OfyUziQTYS37cAdlUdH0oyMtqs+XL28ZlKNJ4Uj6HS9xFF
	CiB1tTRqbLC8eHq2Hwe+OHhWxOYqtlYncPjqWASORNdZLvHAA4bgAEmJ8m9y+AkcRwWp
	PuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=noj71OX2nBmtjQYQqqpKzc/I+BY/kKSngSA5N+1PwXo=;
	b=FB9VysfiXTVv73I+ZejP3NnDSb3wK8zzspuusZIYMm89EGdc3Ietlbc3zWnP5IvukB
	yWxibT5ywFC3HKQvUT/FM3O7Lqq+dBN7KtLU2yUYVoRrlCkYvehTMOZlVjmp0jTNhewR
	Fi1Q3dxNdAGw6gbdY6FsgLET/P5WKpf4CntL9ugUEtLBAq8PLcv436FSHhnZF5GIFKzg
	5AlkXeNtuq5yM0Q2eG37Y03lR3s4ScVOSybDFqwi4CHqPT5SaoPO2ZluF1w84AzxI06Q
	eY1FhEXdT2LxUcspYGfSlSG6+u2fcuXdaTPYaegkJ4DFyqNWUzadD/kGX0Ts6XL0SGyJ
	sV1A==
X-Gm-Message-State: APjAAAW9rRHSSZQvJaNv0c88HazbyZsfk0FY93jucHZTYcRPwBFTEO/B
	kvMMh8biyTHsLaYw4iEwCKhGFvFIIoA=
X-Google-Smtp-Source: APXvYqxkffx8y4YWWZhr+m8Fv5rObCSnQYSj+/CiU50YCd0YlGoRlBFC1WGrknena8v8XHa3S5CtoA==
X-Received: by 2002:a17:902:868c:: with SMTP id
	g12mr17201396plo.323.1557792381317; 
	Mon, 13 May 2019 17:06:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.06.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:06:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:39 -0700
Message-Id: <20190514000540.4313-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PULL 30/31] target/xtensa: Use tcg_gen_abs_i32
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 301c8e3161..b063fa85f2 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1709,14 +1709,7 @@ void restore_state_to_opc(CPUXtensaState *env, TranslationBlock *tb,
 static void translate_abs(DisasContext *dc, const OpcodeArg arg[],
                           const uint32_t par[])
 {
-    TCGv_i32 zero = tcg_const_i32(0);
-    TCGv_i32 neg = tcg_temp_new_i32();
-
-    tcg_gen_neg_i32(neg, arg[1].in);
-    tcg_gen_movcond_i32(TCG_COND_GE, arg[0].out,
-                        arg[1].in, zero, arg[1].in, neg);
-    tcg_temp_free(neg);
-    tcg_temp_free(zero);
+    tcg_gen_abs_i32(arg[0].out, arg[1].in);
 }
 
 static void translate_add(DisasContext *dc, const OpcodeArg arg[],
-- 
2.17.1


