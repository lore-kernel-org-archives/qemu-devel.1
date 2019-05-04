Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C60DC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:01:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12E820675
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhX/PqE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12E820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51712 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnjJ-0005En-4B
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:01:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbk-0007hA-If
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbj-00049c-I5
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:12 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbj-00048Y-C7
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:11 -0400
Received: by mail-pf1-x441.google.com with SMTP id u17so3971243pfn.7
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=eQYUrWBgaVSTGc+XM8Y45frZ2xC0wqtFT2VlLB2AH5Q=;
	b=hhX/PqE1FuFEYc3EYflwn2g3vvEjqip7NuPeEf3CR6ivyErkHRmeiu5u5epsNio9OW
	I4AbgN4qQOPh4P4+qCQR8Y5MhbcNfGC+WRG0guA4bon0suv5vGM5MQKLEacimkfXfLHN
	oUSkS/E7+dnNuKtBR11+2LzTBmQx8TrIGs8E6i/oIluvcJsvLhxyIYB95YFM41fnrF9E
	fHe0RXABmZwE1g1pL08PB820ekSJMggYSl2ibrCXlLItfh0ftnNkIlqF2R7KMg+yGp54
	zLUWPs1Hc/pjXy94m0s00QzR3rC+BGHmkVt6RCPgFjcdC4d5Om9VZV5toPw+D7VksdtI
	YlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=eQYUrWBgaVSTGc+XM8Y45frZ2xC0wqtFT2VlLB2AH5Q=;
	b=I1pug7PHFz58Xq30Y8LStw/sHKj6Q61kZWuaBszvxrtsrxWIAQJpdqQNYqNnSubokb
	Ea3X5s5zvGbWoXSmpcF6Th90sjK7rLHWoeHXlIVwBJ1Y2eziElofuz3OFyDlq2DHhSh0
	D0UCllhqDuVRFTVAxdncLeZcdVR+03ny9GkBAlsGw+cHe6BoAU5DByafJKshvv5y5K2n
	RaGj6tDjiGgGpabY8e3tkfsbKEgf7n6hoj4pIT4MN0skXAejuqt0OaJTxb66fOpTBR4B
	lzCaeGa4c06wwc7h5ySyno7NbmfPGxEVO4tTQ4s7NNE6GVHbIkpIbZrQWD8nKqBtth0R
	8KhQ==
X-Gm-Message-State: APjAAAVqJJuJWASXj+TlSd2wAFCNvTsGZKioqG0I9/AVgAoIXzoxIU3o
	NrG/KiwSsprWq88t1X2Q0bqdhja3OXk=
X-Google-Smtp-Source: APXvYqxDcWnLvdsGNVzefHM2EjvjnKxoBiSVYLq3CZak99/jxrtJwMBGKz7IRGcFMTEJmvbDmTLJ1g==
X-Received: by 2002:a62:56d9:: with SMTP id h86mr6871436pfj.195.1556949189950; 
	Fri, 03 May 2019 22:53:09 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:35 -0700
Message-Id: <20190504055300.18426-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 06/31] tcg/arm: Use tcg_out_mov_reg in
 tcg_out_mov
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504055235.PNxlRKg8EhK-F6-oBckEv_O2tlzzwJQGCbR3pwOsHP0@z>

We have a function that takes an additional condition parameter
over the standard backend interface.  It already takes care of
eliding no-op moves.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.inc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index abf0c444b4..130b6bef1e 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -2267,7 +2267,7 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 static inline void tcg_out_mov(TCGContext *s, TCGType type,
                                TCGReg ret, TCGReg arg)
 {
-    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, ret, 0, arg, SHIFT_IMM_LSL(0));
+    tcg_out_mov_reg(s, COND_AL, ret, arg);
 }
 
 static inline void tcg_out_movi(TCGContext *s, TCGType type,
-- 
2.17.1


