Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E4EC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873F021738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 10:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9WsV79n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873F021738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51266 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIsaL-0004VO-GG
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 06:23:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hIsYj-0003ZY-QA
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hIsYg-0005sr-RY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:21:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hIsYg-0005sP-L2; Tue, 23 Apr 2019 06:21:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id w15so18143195wmc.3;
	Tue, 23 Apr 2019 03:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=JHiKM9oSqGLKu3O7QGQk7XfF7raf/raQcBHibEYeyS8=;
	b=S9WsV79nXoIHNNP3+RDkmNQm7xGqtlPv//LBvs4xtPdFIGFaeBNBRnt+5170C9T+pm
	3Fo+XK4ZRiVmJcR7Pnqxs91U2jesgUhQ/lpY3saGEapr+USDFs+pdvoT4FTl7z2J2j1A
	CGiD+aKBVKd+c1wzM8DERQ8cZOFI08ltS9x3aYz/oO4bRcp/5pMD4YUGBH3bAImVC9E1
	imHhZ5X3b/3ah2oylFKR7irFQEOegM6DGwy2z17PW+4cm3ayOUor6UoxzwAYgNXh38+L
	tGB62Blfc55+l0WgMVB2geRQYgqgbNVzWczTrVVaQGY6UPoB9b49dFPU+9wm0D7zcFIU
	G8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=JHiKM9oSqGLKu3O7QGQk7XfF7raf/raQcBHibEYeyS8=;
	b=nUmnvvwKIhAurTtWzZ72xm8nOwNmFKU3JTGi8Lh+vYCuSY0VhtUcp0T7erlkH45AQ9
	dYi/kpgqes8dhqX8FPOuSF0/rSqp6KZfYCXY4hezAj6mYCyt8Cze63gLGzy0HTYGgU19
	0bpj52+xx4y7/9IaqaOFlMtciZPkEgQY9a2dZVXNAb1rWMCcejMsBuzvk4vTU6F3GGiL
	8XpHOeA5h1kVzeOLknUclGzfzfr0lIbZFOrmHilsfsuq5FbZ74EidgCayOWLBprtw1gQ
	AopFqHc8vB4JTYQtCtChe4ut7iX0c/Duatu9GjUgGruC1tT0A9tAvHOTdcG0cchFBs2X
	rvfg==
X-Gm-Message-State: APjAAAVt8hcpNzMuRg9t1yQ33HtKoV1wgUmm4opLL6UMqKDI/zr7eusc
	T74Y0mg3xJJv64HRRVFGE5Q=
X-Google-Smtp-Source: APXvYqzk74vRbLsdVCVs2uU3vUjYOfEMObZmb2YmIEH9jjocWH/0Adm7sy+1u8e658Yv3WTfCvXcsw==
X-Received: by 2002:a1c:4187:: with SMTP id o129mr1614054wma.57.1556014909026; 
	Tue, 23 Apr 2019 03:21:49 -0700 (PDT)
Received: from x1.local (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	j190sm17934653wmb.19.2019.04.23.03.21.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 03:21:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 12:21:44 +0200
Message-Id: <20190423102145.14812-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190423102145.14812-1-f4bug@amsat.org>
References: <20190423102145.14812-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 1/2] target/ppc: Use tcg_gen_abs_i32
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423102144.efMRnYhoibURSLxx3WOY6Mg-e8njv0OLDOo4Mm09-0M@z>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/ppc/translate/spe-impl.inc.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/target/ppc/translate/spe-impl.inc.c b/target/ppc/translate/spe-impl.inc.c
index 8c1c16c63e..41da7fab97 100644
--- a/target/ppc/translate/spe-impl.inc.c
+++ b/target/ppc/translate/spe-impl.inc.c
@@ -125,19 +125,7 @@ static inline void gen_##name(DisasContext *ctx)                              \
     tcg_temp_free_i32(t0);                                                    \
 }
 
-static inline void gen_op_evabs(TCGv_i32 ret, TCGv_i32 arg1)
-{
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-
-    tcg_gen_brcondi_i32(TCG_COND_GE, arg1, 0, l1);
-    tcg_gen_neg_i32(ret, arg1);
-    tcg_gen_br(l2);
-    gen_set_label(l1);
-    tcg_gen_mov_i32(ret, arg1);
-    gen_set_label(l2);
-}
-GEN_SPEOP_ARITH1(evabs, gen_op_evabs);
+GEN_SPEOP_ARITH1(evabs, tcg_gen_abs_i32);
 GEN_SPEOP_ARITH1(evneg, tcg_gen_neg_i32);
 GEN_SPEOP_ARITH1(evextsb, tcg_gen_ext8s_i32);
 GEN_SPEOP_ARITH1(evextsh, tcg_gen_ext16s_i32);
-- 
2.19.1


