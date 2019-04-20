Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7854C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00102087F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2rdJeN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00102087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38371 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHks2-0001wY-UU
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:57:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXS-0000yt-Bm
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXO-0000fE-PB
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:51 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXL-0000Sm-Tm
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:49 -0400
Received: by mail-pl1-x642.google.com with SMTP id n8so3526796plp.10
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=I6XLb1qOv9FkxV4sEapnWKsb8dxwM3qKBe7iS0e8mFM=;
	b=T2rdJeN+sSY0/ciB0T/ptw6x/beeh0FKjxmYpWJ4TyBYNRvzY/pfE4BJpS3INUO2VJ
	yD3I6vI/DJxOF4FDW4fZ2E2MJsQpKUfEsE1AJpYqJRkc9H26P6Wg10rMCjpyPPbsv0pW
	ttYgAmR3qkRk2oe97Ogk6eBvLKpjTQEcSNDLU2AyAUb6VJWX8STzCqobqz7d92DU2GGb
	1hjLRIFYOtwYTQskCjrXN4sizVJd5ygRTYH+1OEJNeprqoGjyN+WvDXgKF4M7r+EBMPN
	q9M16dHu/MakBv4B3b4f+La39jJZMG9DNimzwPJbzAcDZo+v3TBWfR8bikTx6eAsiqhr
	qh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=I6XLb1qOv9FkxV4sEapnWKsb8dxwM3qKBe7iS0e8mFM=;
	b=jVrXEdj9/Oaj15caNGb3JhX6yKYDAAGtO0gY5KJf+6AXwg7oinxK5E89OZnwKv7f34
	dB/HJRFnojkqwoeaMkusrXugJ969Kgas12VWa0YzG1eSkR5jcKvtVUO7pXyGoMFITNU1
	ol66TbH37YpC/KfGqJZsBB47ijICt5SzTVU4mQytmI5AbgZy70AZc7MvXVbaPTIhFUVP
	e5Y/2o1AxThwBcy704JfdwfT3NLvTykYQf7TfMgePSoeZqbBv4m8ie0s2ZOZFZgDS9Rz
	8/IOvUCXIwe4tRtleIr7z6RcMvN+7nmwnQ6ogdo7H/4GeCEqM6kpjzXjLIRHW3BM5VnN
	Rrdg==
X-Gm-Message-State: APjAAAW20PKBjWnRptcJAfey+4a3ewwzJwArRbKj9K6GYfCd3EAzTQMi
	8Pg7DGbBcSkgFJSashlAZf/f8gF/4aU=
X-Google-Smtp-Source: APXvYqzu1Seh4zJdlQMpC78ZJ6S8q4vJcp+4LKSF6a0NlM9MP+xXYq6FeUJvDjQpcm/zWSORDDfMOw==
X-Received: by 2002:a17:902:900a:: with SMTP id
	a10mr759928plp.336.1555745743903; 
	Sat, 20 Apr 2019 00:35:43 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:41 -1000
Message-Id: <20190420073442.7488-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH 37/38] tcg/aarch64: Use MVNI for expansion of
 dupi
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
Message-ID: <20190420073441.tvUUkPIN6mgkmjpdJKlVvT8e0TYJ_6GQcmASsRK-POs@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index e68e4de08c..20c8699f79 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -513,6 +513,7 @@ typedef enum {
 
     /* AdvSIMD modified immediate */
     I3606_MOVI      = 0x0f000400,
+    I3606_MVNI      = 0x2f000400,
 
     /* AdvSIMD shift by immediate */
     I3614_SSHR      = 0x0f000400,
@@ -823,6 +824,9 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
 
     if (is_fimm(v64, &op, &cmode, &imm8)) {
         tcg_out_insn(s, 3606, MOVI, type == TCG_TYPE_V128, rd, op, cmode, imm8);
+    } else if (is_fimm(~v64, &op, &cmode, &imm8)
+               && op == 0 && ((1 << cmode) & 0x03555)) {
+        tcg_out_insn(s, 3606, MVNI, type == TCG_TYPE_V128, rd, 0, cmode, imm8);
     } else if (type == TCG_TYPE_V128) {
         new_pool_l2(s, R_AARCH64_CONDBR19, s->code_ptr, 0, v64, v64);
         tcg_out_insn(s, 3305, LDR_v128, 0, rd);
-- 
2.17.1


