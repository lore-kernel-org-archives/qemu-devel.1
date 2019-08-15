Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4580C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD263208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqxMWsqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD263208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5eR-0006iE-CS
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Df-0006KQ-1W
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dd-0000Fr-FR
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:26 -0400
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:44238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Dd-0000FH-BO
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:25 -0400
Received: by mail-yw1-xc42.google.com with SMTP id l79so286428ywe.11
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=85q8nHDAFiG6B9LJyV7irB3KAWqhTWFUgDopfKUI68Y=;
 b=XqxMWsqY/XqXuYHZccGgG0e3DOwQqblwhtZTQAkiqhw2cp3EWhO7gLuH4e6/S51Bg0
 MOL5RBP87Ennz4gKu6arn0Jrxz7jDkxJkToYGvdNEILnZKJl+jA0PLu3tW2nlORMspt4
 89TMIHBvNjvti9uGPNQFH17pBrZH52DVqNb4DzzuaBHZpg/WTW4XJhCdBL4YThhMXeaQ
 Vfrq8KSP+3nacKWChiTBUx8TBGsK6sK4krVIWp3T+WnogLpcRFyx7t5sQVed/PH687a1
 gXVALYKPyDg8GVAWpRpnlYQLKjtZsooEzqs5YP2AufQRUo1ZEaVBk/0dbZLnvUNofDYJ
 yx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=85q8nHDAFiG6B9LJyV7irB3KAWqhTWFUgDopfKUI68Y=;
 b=X6VyFYyxSYlEF911prKwQRa/B2cAWflSRGoOToLHofqj66D9wZHdgTCF/srqnS5stn
 +e/nN+++DfD0U38PUYKfR7GGwuIACifdzSCTNYHPHn6/6aD0UhQ9TnMmoP1DeaFCcLtv
 0IjZkBTKeAqIwnAirVDolmUOgfdpOISFD2qdAAQ6p0S4lnugFOdxLEJrmmtvZT0Zg2l+
 fsPXcSF39Hvy5vrQont9hLQLTf2JVD+ctBFEy/tBXkScoYfsEbFW5ELpd8hcyxJgyDEw
 c8TxVK+dE7oRLOPUOUTGBK71Bl292jxJJv3Q/Qqd8pRQuwLr5ICsKsy8pKBrebb/7YIC
 ztwg==
X-Gm-Message-State: APjAAAXMbWpW9rjCQB7qejJBn7MX/28dIygWjBj1x/PVfCS4xbLggKM0
 2v20TZ990ZhOo4xkbegrmSp4CMLR
X-Google-Smtp-Source: APXvYqwzn8By1mumwbQqx4xuEPBtcE8uYOdcRGXbcBkjolyZStRzpXLdWOZNcVP0Sn84pkBgG9mkKQ==
X-Received: by 2002:a81:2841:: with SMTP id o62mr1598527ywo.238.1565835024702; 
 Wed, 14 Aug 2019 19:10:24 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:24 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:15 -0400
Message-Id: <20190815020928.9679-34-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
Subject: [Qemu-devel] [RFC PATCH v3 33/46] target/i386: introduce
 sse-opcode.inc.h
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This header is intended to eventually list all supported instructions
along with some useful details (e.g. mnemonics, opcode, operands etc.)
It shall be used (along with some preprocessor magic) anytime we need
to automatically generate code for every instruction.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/sse-opcode.inc.h | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 target/i386/sse-opcode.inc.h

diff --git a/target/i386/sse-opcode.inc.h b/target/i386/sse-opcode.inc.h
new file mode 100644
index 0000000000..c5e81a6a80
--- /dev/null
+++ b/target/i386/sse-opcode.inc.h
@@ -0,0 +1,69 @@
+#define FMTI____     (0, 0, 0, )
+#define FMTI__R__    (1, 1, 0, r)
+#define FMTI__RR__   (2, 2, 0, rr)
+#define FMTI__W__    (1, 0, 1, w)
+#define FMTI__WR__   (2, 1, 1, wr)
+#define FMTI__WRR__  (3, 2, 1, wrr)
+#define FMTI__WRRR__ (4, 3, 1, wrrr)
+
+#define FMTI__(prop, fmti) FMTI_ ## prop ## __ fmti
+
+#define FMTI_ARGC__(argc, argc_rd, argc_wr, lower)    argc
+#define FMTI_ARGC_RD__(argc, argc_rd, argc_wr, lower) argc_rd
+#define FMTI_ARGC_WR__(argc, argc_rd, argc_wr, lower) argc_wr
+#define FMTI_LOWER__(argc, argc_rd, argc_wr, lower)   lower
+
+#define FMT_ARGC(fmt)    FMTI__(ARGC, FMTI__ ## fmt ## __)
+#define FMT_ARGC_RD(fmt) FMTI__(ARGC_RD, FMTI__ ## fmt ## __)
+#define FMT_ARGC_WR(fmt) FMTI__(ARGC_WR, FMTI__ ## fmt ## __)
+#define FMT_LOWER(fmt)   FMTI__(LOWER, FMTI__ ## fmt ## __)
+#define FMT_UPPER(fmt)   fmt
+
+#ifndef OPCODE
+#   define OPCODE(mnem, opcode, feat, fmt, ...)
+#endif /* OPCODE */
+
+#ifndef OPCODE_GRP
+#   define OPCODE_GRP(grpname, opcode)
+#endif /* OPCODE_GRP */
+
+#ifndef OPCODE_GRP_BEGIN
+#   define OPCODE_GRP_BEGIN(grpname)
+#endif /* OPCODE_GRP_BEGIN */
+
+#ifndef OPCODE_GRPMEMB
+#   define OPCODE_GRPMEMB(grpname, mnem, opcode, feat, fmt, ...)
+#endif /* OPCODE_GRPMEMB */
+
+#ifndef OPCODE_GRP_END
+#   define OPCODE_GRP_END(grpname)
+#endif /* OPCODE_GRP_END */
+
+#undef FMTI____
+#undef FMTI__R__
+#undef FMTI__RR__
+#undef FMTI__W__
+#undef FMTI__WR__
+#undef FMTI__WRR__
+#undef FMTI__WRRR__
+
+#undef FMTI__
+
+#undef FMTI_ARGC__
+#undef FMTI_ARGC_RD__
+#undef FMTI_ARGC_WR__
+#undef FMTI_LOWER__
+
+#undef FMT_ARGC
+#undef FMT_ARGC_RD
+#undef FMT_ARGC_WR
+#undef FMT_LOWER
+#undef FMT_UPPER
+
+#undef LEG
+#undef VEX
+#undef OPCODE
+#undef OPCODE_GRP
+#undef OPCODE_GRP_BEGIN
+#undef OPCODE_GRPMEMB
+#undef OPCODE_GRP_END
-- 
2.20.1


