Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E82C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 05:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72DA1208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 05:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mH26fGaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72DA1208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQQ6e-00012A-SF
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 01:36:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQQ5d-0000UG-N5
	for qemu-devel@nongnu.org; Tue, 14 May 2019 01:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQQ5b-0003XQ-LA
	for qemu-devel@nongnu.org; Tue, 14 May 2019 01:35:01 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43229)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxA-000329-T2
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:05:58 -0400
Received: by mail-pl1-x643.google.com with SMTP id n8so7266493plp.10
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=eQYUrWBgaVSTGc+XM8Y45frZ2xC0wqtFT2VlLB2AH5Q=;
	b=mH26fGaGPiHha/BXvai1qtLdlWeL8KkKkQdpv7U64LKNa6LMcKQiOw6k+yv3LN2fF/
	RiL0JuwuO7O6yySkmSmLYKFm6zZf8Rt2tCIpj1vm8OTa4aoSKuOlQeoTcWlkz/2wwOAL
	1PWNa3XPElL7RzVDbawZHNWe3QMTmd+Cs/jU3CgLdFWYfl/41AtqGMQ8ZEoQdsenC/kB
	sXspskInX1amn66CX5UEgLXtflYDMCQVasLuzxe0uPKFfCGNcuJXbJON8wvXEX0yU5jc
	fU4hRgS+XzzhIYDYyNTHJfHf3HfG4gNFHHxygmpVdn0GS0KAcGVoYzIa7FrIaGLURQ8f
	oFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=eQYUrWBgaVSTGc+XM8Y45frZ2xC0wqtFT2VlLB2AH5Q=;
	b=ApoegiCRnHFeib0yVS5+7At7QHBt+Lt86bCwhLo46PzCMY3MJQKLwnWaQ36D7KrAH9
	EoVia/+giL5jppQ9QnBEyXSagLL3fdwlP9sx/KwO1MewVBuq1AB71Acke2Q0z6dJpEd0
	H9itaMDI0MQRvcsZVZaC7TLBT88yNFlCYh4DI+6UXOeZT+S++AAgMiSJ7L+a3K48Szc7
	N8OcZhMzu3msu8+rWVk+0ufQaTlHCGipNIzcaNRJB2wNbxU6JYaB6mi4fVPdQjSNpgQU
	Dn2xrxi4+3GhApri3VOQ/TRL8E1nyeSDtXknDqARTNmGQhoRsjnYBFyQrZ0HJ91rUvtY
	4Vxw==
X-Gm-Message-State: APjAAAUMp/lihf4XQGLJG5vmbnIeraMcazjxwzqqS3R/zj0qGeQXzPdd
	3JJ9VEcomjytq+Fy0TmLmFBLq6fnr6g=
X-Google-Smtp-Source: APXvYqwvEqC/fd3E1DMYVPCpU7jwfjjvtBLjK/Y6ui7gWFhu8YZmuerFMIS64F6bWW5YkVvBugzh0g==
X-Received: by 2002:a17:902:e104:: with SMTP id
	cc4mr33070434plb.254.1557792351612; 
	Mon, 13 May 2019 17:05:51 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.05.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:05:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:15 -0700
Message-Id: <20190514000540.4313-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PULL 06/31] tcg/arm: Use tcg_out_mov_reg in
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


