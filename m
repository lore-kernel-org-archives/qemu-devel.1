Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD61C04AA7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 03:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5AD208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 03:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJqEkukh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5AD208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38392 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQO7x-0005KQ-Iw
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 23:29:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQO7A-00051J-Ge
	for qemu-devel@nongnu.org; Mon, 13 May 2019 23:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQLz9-0005u8-Sz
	for qemu-devel@nongnu.org; Mon, 13 May 2019 21:12:43 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQLyw-0005Tw-Qf
	for qemu-devel@nongnu.org; Mon, 13 May 2019 21:11:53 -0400
Received: by mail-pl1-x641.google.com with SMTP id x15so7328868pln.9
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 18:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=UDhIE0FmHFjvTg+Yc2t3Xw+YfnUzd/HuDHfr9sdMw70=;
	b=XJqEkukhImvF+TMIP67St4SDlllZ5Gc2UsTtGWU+hJbow/M4b0GfG058/m4nUfF/oy
	Td0MXABa9a01ph2dNKp5E/6IjlZ2hFzeoSBo91QSWM2SIaMWRlsKp5VrV/5JsiVN/+Nl
	ATrVUqy+pmk3aTcF53hTGTFbRhhrjKX8s+9DnNoVsR0kh7sWrBBwxVg2BEbwbkDgH6Qp
	PlgT4OBPBwzAERJul400rlCdI7/2VPc0bamuk7xRrMahHOBlEWxPfZL/SvzR6tFMtAJl
	NIzqzADn2sWWxqxK2Sh6v2QNUUYoVKxFJpTYlmGhpLtwXvwMmiBtE6wtAvmeK2YttNUS
	KvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=UDhIE0FmHFjvTg+Yc2t3Xw+YfnUzd/HuDHfr9sdMw70=;
	b=EFGWJJOehLcuPri7Ngk5dQdCFmUGCuJX2jjc7ayISr/d1tIuvtErkdzLM6+45qXGDq
	kmJO93dWNFxIo+IGkWEDLw5+1PB+6UXv1c/fQT8gIKBJwyvwnnIzyWh3fX3LG+eJNye4
	n4S+kmaifNg2p8mIJ4bz7YQ82XfTufUo27GWbEnlmtwORQ0iGUletvLpO15aqflKURQ1
	qAIm4SbdRTKUBuCo9+5phgmmP084N84gc5gl+URxwD/g5goFgQF8rOXr96FvMvYkGYyF
	DwulkjKCMrjZB+LeyRBwEK/mPK0+o822zKz424nKIsaDElQ0ZmJ4JJ937DrwD0cLI58N
	BqSA==
X-Gm-Message-State: APjAAAWocFXpLXVr2yqPTDD89aTSEszgwNBq2ZpQoyKTENupBke2xNVh
	htVXJ/n+n5Mo9aZ6tEPz/mkWymZoLHU=
X-Google-Smtp-Source: APXvYqymIQHzVZS/Ybm1YN+MjvUUbUyA8FZMpXWM88QHVkge6ArYV9DgvpqSInpQoj/0i3pbedyP3A==
X-Received: by 2002:a17:902:fa2:: with SMTP id
	31mr35551538plz.128.1557796296078; 
	Mon, 13 May 2019 18:11:36 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	b67sm20029147pfb.150.2019.05.13.18.11.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 18:11:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 18:11:29 -0700
Message-Id: <20190514011129.11330-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514011129.11330-1-richard.henderson@linaro.org>
References: <20190514011129.11330-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH 2/2] target/arm: Simplify BFXIL expansion
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mask implied by the extract is redundant with the one
implied by the deposit.  Also, fix spelling of BFXIL.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c4bee74ce5..472d898096 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4043,8 +4043,8 @@ static void disas_bitfield(DisasContext *s, uint32_t insn)
             tcg_gen_extract_i64(tcg_rd, tcg_tmp, ri, len);
             return;
         }
-        /* opc == 1, BXFIL fall through to deposit */
-        tcg_gen_extract_i64(tcg_tmp, tcg_tmp, ri, len);
+        /* opc == 1, BFXIL fall through to deposit */
+        tcg_gen_shri_i64(tcg_tmp, tcg_tmp, ri);
         pos = 0;
     } else {
         /* Handle the ri > si case with a deposit
@@ -4062,7 +4062,7 @@ static void disas_bitfield(DisasContext *s, uint32_t insn)
         len = ri;
     }
 
-    if (opc == 1) { /* BFM, BXFIL */
+    if (opc == 1) { /* BFM, BFXIL */
         tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, pos, len);
     } else {
         /* SBFM or UBFM: We start with zero, and we haven't modified
-- 
2.17.1


