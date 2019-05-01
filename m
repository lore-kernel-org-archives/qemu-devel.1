Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0DBC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AAFC2081C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 05:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4k64hXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAFC2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLhoV-0000qO-DZ
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 01:29:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRo-0006oE-Dj
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLhRl-00036o-D1
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:24 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLhRl-00036V-7a
	for qemu-devel@nongnu.org; Wed, 01 May 2019 01:06:21 -0400
Received: by mail-pg1-x543.google.com with SMTP id n2so7846960pgg.13
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 22:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=XwoaUdVIRqjp6Whyx2wUcZDo65i8rf+ItxdtJjgV/mU=;
	b=F4k64hXY//oO6HmbKkxd9YWheaP9IbgnoTlAHeTa920tyi2MeIdMf7ll8DcQhiGCHB
	DDPzWWJwjAKO8k9Z+jlGMvFqtdTsXeRQv8+vFE/xDKHDLlhP8ker8WN3MRfntkL7UpfP
	qwugmd998DW30MHgE9tEOYisGOy6Gkbiv97NPHg1B9d/8DFENQhwgDJsboEXHgs9QAQx
	uu2LcuBRd78kSmfbXkStqmm8fpdPFIMsY0pwYiNZ4mSUmQoJs0bRRyl435QyoSxWrd3v
	O0WJHizH9l4gpeqE5kPKQFrUPzivkYTlj6M5AnCpIEuwVb6dfc82HnvsnQjsLAeMBnHy
	FJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=XwoaUdVIRqjp6Whyx2wUcZDo65i8rf+ItxdtJjgV/mU=;
	b=YmG5+qnBlMJXXHWYkBCtYU3fUFP2HeRyWKjROmUXf11cRMpgA4Z6B3vhtab+mJ+2iD
	wqeh63Xx7vTf7F1lBbSFZhItdq8REMyoE8TnPQuwEfMnBsE/AGnIMhRIhPVqaEXJRHlg
	STsLK4uUcFgwzmSttafHPzYenpoD+RHFWwQDTP8fp3TrwBJP73GHSl93VDX7c0G6VIPf
	eKcd9EFoJr76aAX5w30oLbb7fjWZT8VjpqNshGY5lcKYrNnS3129dFdHOdtTJO97Eg7N
	ISu8qeUffcfyyuByM5dt/ZZdEv1vuXrJ4w7I2vGsJvL7IffSrb18wC/NGQ47a8YwWsaE
	IIMw==
X-Gm-Message-State: APjAAAUY8XeRTniiXIDDgQYZSB2JnTXTaUuXJUvL5T1pfpzE9hY2bZhi
	uvoJyk5yrOIBTN5sBppqbvzXvvatIzk=
X-Google-Smtp-Source: APXvYqyVxb2Y8UagwHQghtJuZ+G1O/8vkfHhFppSWGt2uR3bJTh8ZfVWj4DXZBx3UJbmu461l3UZ/g==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr73580019pgc.25.1556687180059;
	Tue, 30 Apr 2019 22:06:20 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	t127sm9687251pfb.106.2019.04.30.22.06.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 22:06:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 22:05:36 -0700
Message-Id: <20190501050536.15580-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190501050536.15580-1-richard.henderson@linaro.org>
References: <20190501050536.15580-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v2 29/29] target/xtensa: Use tcg_gen_abs_i32
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190501050536.aSCsFFht-hOduv6OmauxW1MNnmSgsqumB7pfIoHYTsc@z>

Cc: Max Filippov <jcmvbkbc@gmail.com>
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


