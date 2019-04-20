Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA98DC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85EFD2087F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOoNgjHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85EFD2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38373 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHks3-0001xr-OV
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:57:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXN-0000uN-Rr
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXK-0000Ve-3u
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:49 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXI-0000Jh-7g
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:45 -0400
Received: by mail-pf1-x441.google.com with SMTP id c8so3458979pfd.10
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=iaXmBLRJ4AetvIw8U8LEOO46+IUqp272JP0xIL80EUs=;
	b=gOoNgjHukeRlvISeBnypWZmGThCjrKpAFA9VJde2eH4r3h58nQRzbELCV2hG/LMJXa
	VxwKP2n0q9gt5YlgVBLzmrrNPnglROvKNvkPimOAudF2fQP8Q9o2K0EN9aS1RtoOEUPY
	R6KR+lNyg6hwtFsloSPiti1L3tqfg3OpcDtS25TH7VS6nUyKd1TnuxWZYwuPQs7vX0i7
	m1GaIVUljizfwxxzTJ6YMT5fOG1eeYUETuKg9Ynn4yOP+0FKhNH4M3Jv+KDuaxqVtDCt
	9HEtgTMDk3nKSCwGXXyV//3nsorkXQR6ybwmz25dq10y3jgr9iKD9YqdFgKNwK1sr0Qi
	x4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=iaXmBLRJ4AetvIw8U8LEOO46+IUqp272JP0xIL80EUs=;
	b=JeK64MMKrYutltM/uG7DSaLAt27Dg/weI/pt9CAqRZQgm4vUNF6Lmt+EUZQFb8TwR8
	GgnJaVRKySv9P0+iornc7kJkqC/6xkh2zDtnAMwtjyfXkuD6Kow8OQGoLb6/XRHjqyq7
	I8/1qgB0O5vpoCVsITjmG2xL0JPIE4tByaTL0A/1hGwGrt/iFNqru9mNYSLwf9rkI8Om
	enb5uT4N1DdfreYSMsPkL5nKhb/F4MyL6IMvSpf2La2d0I2JcbuGYc0txx09DAH3TZ3m
	dweoI4U1kpOqNQY1JehBP+mzwjgdFnT32ZH/VpMzj59W2gmPjQ6ME3o4Ut0Kl44JG2Mn
	LJkQ==
X-Gm-Message-State: APjAAAWoW0hpmLm8plqZ+j7K5R1Vi8yFf6W1S/d4HOZJhM7eMxssi/9N
	8RAnLRsMCvnntj0t3Aq9cl65NqfI4qk=
X-Google-Smtp-Source: APXvYqyi0r9Pw3Lt4HethJXjU9cDCXIlvla/wAnTCS5zLmsW87d5970wu9BaA65ZIHh6hATJksmIlg==
X-Received: by 2002:a62:4115:: with SMTP id o21mr8453186pfa.153.1555745739569; 
	Sat, 20 Apr 2019 00:35:39 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:38 -1000
Message-Id: <20190420073442.7488-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 34/38] tcg: Do not recreate INDEX_op_neg_vec
 unless supported
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073438.m6lfy6Ozti3rryC5OiQZyhgaAzXzNccQaREmA76zPY8@z>

Use tcg_can_emit_vec_op instead of just TCG_TARGET_HAS_neg_vec,
so that we check the type and vece for the actual operation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5150c38a25..24faa06260 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -734,9 +734,13 @@ void tcg_optimize(TCGContext *s)
                 } else if (opc == INDEX_op_sub_i64) {
                     neg_op = INDEX_op_neg_i64;
                     have_neg = TCG_TARGET_HAS_neg_i64;
-                } else {
+                } else if (TCG_TARGET_HAS_neg_vec) {
+                    TCGType type = TCGOP_VECL(op) + TCG_TYPE_V64;
+                    unsigned vece = TCGOP_VECE(op);
                     neg_op = INDEX_op_neg_vec;
-                    have_neg = TCG_TARGET_HAS_neg_vec;
+                    have_neg = tcg_can_emit_vec_op(neg_op, type, vece) > 0;
+                } else {
+                    break;
                 }
                 if (!have_neg) {
                     break;
-- 
2.17.1


