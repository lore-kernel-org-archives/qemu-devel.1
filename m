Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3221FC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F064F216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgryOp0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F064F216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VMg-000805-RP
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URs-0001iI-Bi
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URq-0008Sp-Ax
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:04 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:42622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URo-0008NF-D7
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:31:02 -0400
Received: by mail-yb1-xb42.google.com with SMTP id h8so1331449ybq.9
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zvMRzv39EspM75H8ERsykoJrSPB7wF2pNE1eGfQdv/M=;
 b=vgryOp0h1dx8F6YsuXCLKIq0/QoNylw85mlsS/78xL41RiLfDBoh2fyv5RappkSn0o
 9DXDwZLyZxFWbSOmSy3Hhfs72mhi/7vqiF7hq5FBNJ41nzbh+So/jPZZ+WxzZ64PpMB8
 0H0EEhnlDxMwVG+f30PYJOuQj/KgczsrcELLvuqykW5EkPiGC+bJDP02kOc8O61rhYLQ
 VcNDUe7hbQF1zG+KPHh5RlzcE3vdESgO2ydQifA/+EyXnpLkNiT3oVUOpGT8zBCmAmhD
 0dGkbx8xJC0+ZO6LJ3N4j/0Fg95SCBF1ia/0J6XY7ZAGH1OgZCz9mE42+MQB7cb6Amid
 a2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zvMRzv39EspM75H8ERsykoJrSPB7wF2pNE1eGfQdv/M=;
 b=p7BFTbfLOhUASxTxxKyASgwkvZRLHHyr5jRdhEq6pRvFNANh0VCCiR17FDt+bkP1TM
 xu8JtZ67HRQ2BQGIYVQRRmlfgSpdSQg6juu8hWMCQEkN29j+SCKoX+muJcx14wYuUjah
 vC+55O6jZSxsvlTklPQioGuOASNojyC5vz0ZiP8mafm9LQxs0mmgtKu9Q9q4apBgHWJK
 Nl3m2OT4ilHQlqL2UlZtGDh6NNpJrCZTo4p4/67VltF25BKjHQfb6kuK9dxl66Uo+seb
 T9rLFr+b3W3WyViKcq0PjSkzVrRHku1cMLvDzAc2aQ3BifxoFLIcdw5sGICMpgenCieU
 hxDQ==
X-Gm-Message-State: APjAAAWtDbKPH/X+G5ncU7fXc/0DOxlsE7U1bZGQbNY5RIAJJ2b5SVTT
 b+Ze1W4PiD9MrMp0kOxxPP4wqGa9
X-Google-Smtp-Source: APXvYqyVuuexPP63eaZERmdsmYhgExMf1FhFYzIGlVfScNS56WS5esPWqfgi44EtDZqulu9tW0v5JQ==
X-Received: by 2002:a25:aa4e:: with SMTP id s72mr24947703ybi.485.1566408659162; 
 Wed, 21 Aug 2019 10:30:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:58 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:38 -0400
Message-Id: <20190821172951.15333-63-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v4 62/75] target/i386: introduce AVX2
 translators
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

Use the translator macros to define translators required by AVX2
instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 50eab9181c..3f4bb40932 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -7692,11 +7692,11 @@ DEF_TRANSLATE_INSN2(Vd, Wd)
 DEF_TRANSLATE_INSN2(Vd, Wq)
 DEF_TRANSLATE_INSN2(Vdq, Ed)
 DEF_TRANSLATE_INSN2(Vdq, Eq)
-DEF_TRANSLATE_INSN2(Vdq, Md)
 DEF_TRANSLATE_INSN2(Vdq, Mdq)
 DEF_TRANSLATE_INSN2(Vdq, Nq)
 DEF_TRANSLATE_INSN2(Vdq, Qq)
 DEF_TRANSLATE_INSN2(Vdq, Udq)
+DEF_TRANSLATE_INSN2(Vdq, Wb)
 DEF_TRANSLATE_INSN2(Vdq, Wd)
 DEF_TRANSLATE_INSN2(Vdq, Wdq)
 DEF_TRANSLATE_INSN2(Vdq, Wq)
@@ -7706,12 +7706,14 @@ DEF_TRANSLATE_INSN2(Vq, Ed)
 DEF_TRANSLATE_INSN2(Vq, Eq)
 DEF_TRANSLATE_INSN2(Vq, Wd)
 DEF_TRANSLATE_INSN2(Vq, Wq)
-DEF_TRANSLATE_INSN2(Vqq, Md)
 DEF_TRANSLATE_INSN2(Vqq, Mdq)
-DEF_TRANSLATE_INSN2(Vqq, Mq)
 DEF_TRANSLATE_INSN2(Vqq, Mqq)
+DEF_TRANSLATE_INSN2(Vqq, Wb)
+DEF_TRANSLATE_INSN2(Vqq, Wd)
 DEF_TRANSLATE_INSN2(Vqq, Wdq)
+DEF_TRANSLATE_INSN2(Vqq, Wq)
 DEF_TRANSLATE_INSN2(Vqq, Wqq)
+DEF_TRANSLATE_INSN2(Vqq, Ww)
 DEF_TRANSLATE_INSN2(Wd, Vd)
 DEF_TRANSLATE_INSN2(Wdq, Vdq)
 DEF_TRANSLATE_INSN2(Wq, Vq)
@@ -7763,6 +7765,7 @@ DEF_TRANSLATE_INSN3(Gd, Udq, Ib)
 DEF_TRANSLATE_INSN3(Gq, Nq, Ib)
 DEF_TRANSLATE_INSN3(Gq, Udq, Ib)
 DEF_TRANSLATE_INSN3(Hdq, Udq, Ib)
+DEF_TRANSLATE_INSN3(Hqq, Uqq, Ib)
 DEF_TRANSLATE_INSN3(Mdq, Hdq, Vdq)
 DEF_TRANSLATE_INSN3(Mqq, Hqq, Vqq)
 DEF_TRANSLATE_INSN3(Nq, Nq, Ib)
@@ -7789,6 +7792,7 @@ DEF_TRANSLATE_INSN3(Vdq, Vdq, UdqMhq)
 DEF_TRANSLATE_INSN3(Vdq, Vdq, Wdq)
 DEF_TRANSLATE_INSN3(Vdq, Vq, Mq)
 DEF_TRANSLATE_INSN3(Vdq, Vq, Wq)
+DEF_TRANSLATE_INSN3(Vdq, Wd, modrm_mod)
 DEF_TRANSLATE_INSN3(Vdq, Wdq, Ib)
 DEF_TRANSLATE_INSN3(Vq, Hq, Ed)
 DEF_TRANSLATE_INSN3(Vq, Hq, Eq)
@@ -7797,7 +7801,10 @@ DEF_TRANSLATE_INSN3(Vq, Hq, Wq)
 DEF_TRANSLATE_INSN3(Vq, Vq, Wq)
 DEF_TRANSLATE_INSN3(Vq, Wq, Ib)
 DEF_TRANSLATE_INSN3(Vqq, Hqq, Mqq)
+DEF_TRANSLATE_INSN3(Vqq, Hqq, Wdq)
 DEF_TRANSLATE_INSN3(Vqq, Hqq, Wqq)
+DEF_TRANSLATE_INSN3(Vqq, Wd, modrm_mod)
+DEF_TRANSLATE_INSN3(Vqq, Wq, modrm_mod)
 DEF_TRANSLATE_INSN3(Vqq, Wqq, Ib)
 DEF_TRANSLATE_INSN3(Wdq, Vqq, Ib)
 
@@ -7921,8 +7928,14 @@ DEF_TRANSLATE_INSN4(Vqq, Hqq, Wqq, Lqq)
         }                                                               \
     }
 
+DEF_TRANSLATE_INSN5(Vdq, Hdq, Vdq, MDdq, Hdq)
+DEF_TRANSLATE_INSN5(Vdq, Hdq, Vdq, MQdq, Hdq)
+DEF_TRANSLATE_INSN5(Vdq, Hdq, Vdq, MQqq, Hdq)
 DEF_TRANSLATE_INSN5(Vdq, Hdq, Wd, modrm_mod, vex_v)
 DEF_TRANSLATE_INSN5(Vdq, Hdq, Wq, modrm_mod, vex_v)
+DEF_TRANSLATE_INSN5(Vqq, Hqq, Vqq, MDdq, Hqq)
+DEF_TRANSLATE_INSN5(Vqq, Hqq, Vqq, MDqq, Hqq)
+DEF_TRANSLATE_INSN5(Vqq, Hqq, Vqq, MQqq, Hqq)
 DEF_TRANSLATE_INSN5(Wdq, Hdq, Vd, modrm_mod, vex_v)
 DEF_TRANSLATE_INSN5(Wdq, Hdq, Vq, modrm_mod, vex_v)
 
-- 
2.20.1


