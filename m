Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2F5C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 18:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC2CC20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 18:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQzd8xNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2CC20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Tuj-0002fy-Tx
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 14:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8TsA-0001wA-TQ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 14:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8Ts8-0008UJ-SN
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 14:31:13 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:44291)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8Ts6-0008Lu-Jw
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 14:31:12 -0400
Received: by mail-qt1-x842.google.com with SMTP id u40so30768141qth.11
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=Vtjd35BPZakeIT6rdGzEIxB/QlMjv0TxGabTZRgNM8I=;
 b=IQzd8xNMzyZuJaSrZQ1AHLSVDDljKBXeGGcnfSSK4uhK2XE5gQIN9EHj3k5E9TjY5T
 TkSH/uUffv+QvtAX/HNr7uruCP2v0FuCZZAbxu1ND2c52Ype2df2dtXn1eIAJggqXeDT
 iY96ZD+2ZQwel7l9LzYe6YD2G7sNv2dRHJGggDOJXx66Tp6RXN2giOpqc5SxF5SMlowx
 Epuc0xkC/9dtjMoOd45sIMt4gOwThINnnEHK8EgHgrxzU3Paz+S548022JH0NuJenNcR
 zXnGvaGh6eFVmF1lrHbEG7mS2IWTyQseAt6Ta/9ES1P+Y4UUXWvpLS1CfUkWJ76s2UZq
 qVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Vtjd35BPZakeIT6rdGzEIxB/QlMjv0TxGabTZRgNM8I=;
 b=OAZaRP2R/b5uSLYuqc/rPCCSQ3d7lXQWjxODiLOfjDs8HHh5mvuSA4xoKOW0gjyy9+
 leJK+0KGyJzMr4Y1f13EQyoXOY1r4Tt/69EUNPuSyxUVDeHDXj5TP1aYdnV0rcgQYP1Z
 GKB+wKFEDgIZ2YjM4RsWzuiD/VVfFsHjrHhYNjc6nvyj2hjRab/ay17eBRAzpvbonD1g
 xVAHSJ5pPA92VB//AhVylOku5LqJ1LqByw5PWKxIkh93zOn+Ox2eVq2CAmdrhsvNoyr5
 Hbh2cy0D694vbNE+wF783qYs5brz97mihyp2OWOJExxcR82N2zmuEabyF6DTNebjCewx
 H/iQ==
X-Gm-Message-State: APjAAAWXoA57vDlhCsNxjRdaexatSCfrD6AUwsPbDj6LMc1MlJShMQYF
 LQU6GBfyArGpvY+YdUc3bXBAdkgd7uElQA==
X-Google-Smtp-Source: APXvYqy/rb2JBdWtfY+jTHYOsAI2+/L+3BSekIoqLjyBVT8Tri/p7tRe6rbPAFr/WLbAdHTvMhKzYw==
X-Received: by 2002:a0c:fca4:: with SMTP id h4mr1292690qvq.236.1568313060542; 
 Thu, 12 Sep 2019 11:31:00 -0700 (PDT)
Received: from localhost.localdomain ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id t26sm11314116qkt.10.2019.09.12.11.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 11:30:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 14:30:58 -0400
Message-Id: <20190912183058.17947-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: [Qemu-devel] [PATCH] target/arm: Fix sign-extension for SMLAL*
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 32-bit product should be sign-extended, not zero-extended.

Fixes: ea96b374641b
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 34bb280e3d..fd2f0e3048 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8045,7 +8045,9 @@ static bool op_smlaxxx(DisasContext *s, arg_rrrr *a,
     case 2:
         tl = load_reg(s, a->ra);
         th = load_reg(s, a->rd);
-        t1 = tcg_const_i32(0);
+        /* Sign-extend the 32-bit product to 64 bits.  */
+        t1 = tcg_temp_new_i32();
+        tcg_gen_sari_i32(t1, t0, 31);
         tcg_gen_add2_i32(tl, th, tl, th, t0, t1);
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
-- 
2.17.1


