Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC4FC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 04:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC41420855
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 04:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ydro3mSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC41420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34775 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDiAQ-0002FU-SJ
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 00:15:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDi8p-0001PO-Mx
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDi8o-00007y-Fx
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:47 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:41099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDi8o-000075-8F
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:46 -0400
Received: by mail-pg1-x52b.google.com with SMTP id f6so8513847pgs.8
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 21:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=fNgDJEtSfSlRgEnoJPzj+CuwzjJQh8hSC2zVaPEmKgU=;
	b=Ydro3mSXg9+S/NZUWn9Q5BRc93afTOCTJB+rnsjptEMPgw858p2Dv/IRvotVHMiKmp
	WJQkvacIDfluUolgGBwnZKQSo0DhARb7I6T/Ob4wVCoxmOVW+FoOkif7NApCXXuF2Zzb
	Ma5gXXQkxnkyEem0qABWkrvlx3iUwLToJ8UGrLax0ESk34IxQWaVDIcIzyMnjLUcnh31
	teDvVk9enCov6aMyhP8al37Hl9h3yNmsDOqmbm6ne87QzkImSAfjBccWcgxLbRVUsIG0
	jWVwN1q8nNRKOqr2utq5QQIMdQrwOSMcRQ5nfsEuZ04S2s9ABoDJWaYrUdeTaQe+Lt7t
	8Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=fNgDJEtSfSlRgEnoJPzj+CuwzjJQh8hSC2zVaPEmKgU=;
	b=eSEBXAjYxSr1ki0L6Oh2tHSS1+iiOyr+OAw7mPNo9SO/4dBA7Te66mSrgb9CRyqGaz
	lvIPjE8/YjZQzqJg+lgTlACiLe+FCz20Hy7jm0hUX/R2nJYAtqf6dLj4i1ltrRYBFIeL
	cjctCViWK1jXXJXSiMo8iHYlcFAK2e+PLATgXV1fvUdd2/I1h1wVvJjP9O4tY/Y5RKfY
	WVP68Bx89/t94v9bWd6mnPqqjxF6ExPS1igJzkd79TMBQxfVHxqOH7zHER+Pv5YXfVq0
	zgc4sgm3yj581AcIe17gD082vz14tcaOcbI25Fh2M/llgLpT8w0t3sB38I4za1FQb+5M
	smGw==
X-Gm-Message-State: APjAAAVWmCLxqRpdSjFeJDLWtHHrkvyebkLBZ9C8bj/6v83MKn8k2etm
	pz0aZ/sGW+hiC4yAi3RpBiXjD+qSKVs=
X-Google-Smtp-Source: APXvYqy+fQ4lAgjwejK7It7UJMg9Csenr1IadXivoeTTe1DkABmoEP3/K/m6DddTVbFWr2FNs63aQg==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr31964254pgv.248.1554783224787; 
	Mon, 08 Apr 2019 21:13:44 -0700 (PDT)
Received: from localhost.localdomain (rrcs-173-198-79-114.west.biz.rr.com.
	[173.198.79.114]) by smtp.gmail.com with ESMTPSA id
	d129sm46012024pfa.142.2019.04.08.21.13.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 21:13:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 18:13:37 -1000
Message-Id: <20190409041337.23602-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190409041337.23602-1-richard.henderson@linaro.org>
References: <20190409041337.23602-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52b
Subject: [Qemu-devel] [PATCH 2/2] HACK: Test avx2 state
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
Cc: jan.bobek@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409041337.hAlvXTFsrURfUviFb3BhkGywJFe6DQC1XT0KSwp1XXw@z>

In order to not be a hack, we'd have to test whether avx2 exists.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 test_i386.S | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/test_i386.S b/test_i386.S
index 05344d7..55815fe 100644
--- a/test_i386.S
+++ b/test_i386.S
@@ -23,24 +23,24 @@
 	add	$2f-1b, BASE
 #endif
 
-	movdqa	0(BASE), %xmm0
-	movdqa	1*16(BASE), %xmm1
-	movdqa	2*16(BASE), %xmm2
-	movdqa	3*16(BASE), %xmm3
-	movdqa	4*16(BASE), %xmm4
-	movdqa	5*16(BASE), %xmm5
-	movdqa	6*16(BASE), %xmm6
-	movdqa	7*16(BASE), %xmm7
+	vmovdqa	0(BASE), %ymm0
+	vmovdqa	1*32(BASE), %ymm1
+	vmovdqa	2*32(BASE), %ymm2
+	vmovdqa	3*32(BASE), %ymm3
+	vmovdqa	4*32(BASE), %ymm4
+	vmovdqa	5*32(BASE), %ymm5
+	vmovdqa	6*32(BASE), %ymm6
+	vmovdqa	7*32(BASE), %ymm7
 
 #ifdef __x86_64__
-	movdqa	8*16(BASE), %xmm8
-	movdqa	9*16(BASE), %xmm9
-	movdqa	10*16(BASE), %xmm10
-	movdqa	11*16(BASE), %xmm11
-	movdqa	12*16(BASE), %xmm12
-	movdqa	13*16(BASE), %xmm13
-	movdqa	14*16(BASE), %xmm14
-	movdqa	15*16(BASE), %xmm15
+	vmovdqa	8*32(BASE), %ymm8
+	vmovdqa	9*32(BASE), %ymm9
+	vmovdqa	10*32(BASE), %ymm10
+	vmovdqa	11*32(BASE), %ymm11
+	vmovdqa	12*32(BASE), %ymm12
+	vmovdqa	13*32(BASE), %ymm13
+	vmovdqa	14*32(BASE), %ymm14
+	vmovdqa	15*32(BASE), %ymm15
 #endif
 
 	xor	%eax, %eax
@@ -75,6 +75,6 @@
 2:
 	.set	i, 0
 	.rept	256
-	.byte	i
+	.byte	i, i, i, i
 	.set	i, i + 1
 	.endr
-- 
2.17.1


