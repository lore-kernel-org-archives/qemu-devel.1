Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349B7C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCFDE20881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTiFpJr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFDE20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52633 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZtG-0002Ux-79
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:39:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj5-0003Ab-8u
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj3-0007S7-Vo
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:47 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:42799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZj3-0007Pp-P9
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:45 -0400
Received: by mail-yb1-xb42.google.com with SMTP id a21so1487406ybg.9
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=xoXIkCrK3V7BH4MhmjLPxOrcr1ayi9bYK48w1V2yt0Q=;
	b=fTiFpJr6MaizSsFIhcrL8ePFaPoA/fdloKYzsG/NjD6FCXV9MSF96sPiscm/12Hc8P
	jmolJMzgFClnXxz01bH9J05E0m7TMStGYP2cusMN20WSoWhFUv9j0fgPIrMdd3T3+vaH
	MwkZCaf7MeB3ZuYovoVTKqs0KMO2dy9kEzQLyhRA62BabiV1jzybnFQ+/WbWodwTT01f
	HixsX7yoEm+yOeARKsZhcfjtAXPBZQzb0cZlqoujYHixc39jznt+/m+k2rH5/x7fzMKR
	qRrJXGVVqvW8h2RMt0GAp1vZEyfWsTbgENYXPfmP3/I3TFT6jiwoXOrrEg0g8kz8jwfa
	8Zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=xoXIkCrK3V7BH4MhmjLPxOrcr1ayi9bYK48w1V2yt0Q=;
	b=g4wZtGPeyxfmjHLS6WKQdtCvp+kwICqR8l3ZwBPeVrxzgUHn6DIxlBHzS6BeOmDcCA
	D3z05qdef7Z5ri4zYBujLwhm0gXdQG2wv7sV8PZrs0TFUDbGOBgGkareauwntbAfYp4c
	JKZptozY3zgd86QbYW8CLBkKkfiREvzIid4tDlYDacMcvpb2/YQ44KQNk91hoKDwxOVU
	gVei4nn59WjLFHPAYYf5LpU3rPQNjtFA9z8c/CG+3OULqQEMBu2HOb0uDdoTGC7LZt/Y
	ucRt/TOZFdABUJIhPI8Gh9JplX6zNNGi4GXNqtOwVzJ2Er8+bIYRe1jI/OM1HbK5VXib
	V6Iw==
X-Gm-Message-State: APjAAAVXT58C1/JPi8VaLGvp/UVWRasLaxnLdl/8JQ4o7SdCQeEbCq8b
	njcZBe0XArt7VoLNwlkBpEtcJsce2tw=
X-Google-Smtp-Source: APXvYqxN/wUVAAZoaLfQi0YFG74OhQoRtFizsIxcy09LwaRFiRcgzy/YQiT65vAeAzn+LcbLwBMYSg==
X-Received: by 2002:a25:dc3:: with SMTP id 186mr22561627ybn.276.1558564121109; 
	Wed, 22 May 2019 15:28:41 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:21 -0400
Message-Id: <20190522222821.23850-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [PULL 16/16] tcg/i386: Use MOVDQA for TCG_TYPE_V128
 load/store
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

This instruction raises #GP, aka SIGSEGV, if the effective address
is not aligned to 16-bytes.

We have assertions in tcg-op-gvec.c that the offset from ENV is
aligned, for vector types <= V128.  But the offset itself does not
validate that the final pointer is aligned -- one must also remember
to use the QEMU_ALIGNED() attribute on the vector member within ENV.

PowerPC Altivec has vector load/store instructions that silently
discard the low 4 bits of the address, making alignment mistakes
difficult to discover.  Aid that by making the most popular host
visibly signal the error.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 6ec5e60448..c0443da4af 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -1082,14 +1082,24 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret,
         }
         /* FALLTHRU */
     case TCG_TYPE_V64:
+        /* There is no instruction that can validate 8-byte alignment.  */
         tcg_debug_assert(ret >= 16);
         tcg_out_vex_modrm_offset(s, OPC_MOVQ_VqWq, ret, 0, arg1, arg2);
         break;
     case TCG_TYPE_V128:
+        /*
+         * The gvec infrastructure is asserts that v128 vector loads
+         * and stores use a 16-byte aligned offset.  Validate that the
+         * final pointer is aligned by using an insn that will SIGSEGV.
+         */
         tcg_debug_assert(ret >= 16);
-        tcg_out_vex_modrm_offset(s, OPC_MOVDQU_VxWx, ret, 0, arg1, arg2);
+        tcg_out_vex_modrm_offset(s, OPC_MOVDQA_VxWx, ret, 0, arg1, arg2);
         break;
     case TCG_TYPE_V256:
+        /*
+         * The gvec infrastructure only requires 16-byte alignment,
+         * so here we must use an unaligned load.
+         */
         tcg_debug_assert(ret >= 16);
         tcg_out_vex_modrm_offset(s, OPC_MOVDQU_VxWx | P_VEXL,
                                  ret, 0, arg1, arg2);
@@ -1117,14 +1127,24 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
         }
         /* FALLTHRU */
     case TCG_TYPE_V64:
+        /* There is no instruction that can validate 8-byte alignment.  */
         tcg_debug_assert(arg >= 16);
         tcg_out_vex_modrm_offset(s, OPC_MOVQ_WqVq, arg, 0, arg1, arg2);
         break;
     case TCG_TYPE_V128:
+        /*
+         * The gvec infrastructure is asserts that v128 vector loads
+         * and stores use a 16-byte aligned offset.  Validate that the
+         * final pointer is aligned by using an insn that will SIGSEGV.
+         */
         tcg_debug_assert(arg >= 16);
-        tcg_out_vex_modrm_offset(s, OPC_MOVDQU_WxVx, arg, 0, arg1, arg2);
+        tcg_out_vex_modrm_offset(s, OPC_MOVDQA_WxVx, arg, 0, arg1, arg2);
         break;
     case TCG_TYPE_V256:
+        /*
+         * The gvec infrastructure only requires 16-byte alignment,
+         * so here we must use an unaligned store.
+         */
         tcg_debug_assert(arg >= 16);
         tcg_out_vex_modrm_offset(s, OPC_MOVDQU_WxVx | P_VEXL,
                                  arg, 0, arg1, arg2);
-- 
2.17.1


