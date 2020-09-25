Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E933BC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4518720878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2jX6yv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4518720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLph1-0002Lq-8l
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpX3-0001C5-SC
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:21:10 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWw-0005Ru-9B
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:21:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id w7so3519781pfi.4
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mpMuefpfKDSRa7HcV8+nIrrA4a3VHPfcVNzq0zqqZrA=;
 b=s2jX6yv6L6/OYkKhCLJhUKpvPgP6Qh3E4zUP/V/2J9EQboIuqhHH2Vniu9Lq8NJWKm
 b2ViiQWtzIxldMab9CixRJ7K5xqlrL804mf3CY+WXCC6mG7XU8mDsCBKQ3S/j0nlIAlW
 LOP62ur7H24YihB0umcT7SgHKQb9TKA7p20qAlk1dh6ItKOXGHXOphhwSv4Wn+NmFfG6
 z16TpL1nWQP/d4U8pLWb3USIXctxjC6qzKN2cmjvZOELjKXMpJDuNgmFBr2nHKBTwoa8
 wwa02ubeiEZPc/pQqtFl0kdZYwqPTzmydBSLlMWkSZYcCZTcQjKjcmf+IQ/9YVFfjqBg
 JDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mpMuefpfKDSRa7HcV8+nIrrA4a3VHPfcVNzq0zqqZrA=;
 b=TYHr62WsTefMf7chK98eYSpaYeQ8gmJMQgHpnU9dsmdLcF1mMM2jUEmKMZcN7jW6ka
 vio3EzvRMLkAmzIS5EwsI0Itof9c2FKQdsVleO899b+7AKooT9QQorEJXrtJKU0b738v
 9hTNLEQ5eyMD59aeyt9O/lHdsY7Aulrxk6kkQTkU7RVIKo8FUUzGXiiycF+Jjk3t6wSU
 Hgk+pE3yj3wWbL8I2mZqWORkXtUBgsyAUlui1+cyg70SX5dXgY7mrXNBwQlOrt0CyU9Q
 Ye1aUduFhoIlPTx3oq3TbN6tuUqHAaAW7wfApgsUklYh2rboditT0OriOZOozRSe176Z
 XGyQ==
X-Gm-Message-State: AOAM531frLK4nsEsrzxab5gEw5meJGqRBPpsTHvuADNB09pdZ6oAH8cR
 ZYSXJk4hmzsfzzPEmkZpv+ZUxanWuL4Vug==
X-Google-Smtp-Source: ABdhPJzehvrMKHj33fbqTtrMScVPTlqFQMlemzbuahlLQ8PdWsvK6TgXkKViP4O/DzNe5ORJ8I+YRw==
X-Received: by 2002:aa7:9f4a:0:b029:142:2501:34f7 with SMTP id
 h10-20020aa79f4a0000b0290142250134f7mr4489385pfr.80.1601047260559; 
 Fri, 25 Sep 2020 08:21:00 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a5sm2717859pgk.13.2020.09.25.08.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:20:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/10] softfloat: Use x86_64 assembly for sh[rl]_double
Date: Fri, 25 Sep 2020 08:20:45 -0700
Message-Id: <20200925152047.709901-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925152047.709901-1-richard.henderson@linaro.org>
References: <20200925152047.709901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: bharata@linux.ibm.com, alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GCC isn't recognizing this pattern for x86, and it
probably couldn't recognize that the outer condition
is not required either.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 54d0b210ac..fdf5bde69e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7260,12 +7260,22 @@ typedef struct UInt256 {
 
 static inline uint64_t shl_double(uint64_t h, uint64_t l, unsigned lsh)
 {
+#ifdef __x86_64__
+    asm("shld %b2, %1, %0" : "+r"(h) : "r"(l), "ci"(lsh));
+    return h;
+#else
     return lsh ? (h << lsh) | (l >> (64 - lsh)) : h;
+#endif
 }
 
 static inline uint64_t shr_double(uint64_t h, uint64_t l, unsigned rsh)
 {
+#ifdef __x86_64__
+    asm("shrd %b2, %1, %0" : "+r"(l) : "r"(h), "ci"(rsh));
+    return l;
+#else
     return rsh ? (h << (64 - rsh)) | (l >> rsh) : l;
+#endif
 }
 
 static void shortShift256Left(UInt256 *p, unsigned lsh)
-- 
2.25.1


