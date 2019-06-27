Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42EAC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9548620659
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9548620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgX0Z-00061f-KW
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33430)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHw-0003Po-Hr
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHr-0000WU-3a
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44969)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWHo-0007H5-Qo
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so1167863pgp.11
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=jNAXnuen/EqceGboq9jqUh/HLce5kvK8361K7LpbToc=;
 b=VMXj/XPwCHnXeqVfc3JqwHOnBYRuWa7EeJVZwwgE0OMSMFSMC8QLxn03gzo9gLBLhr
 Yiyio/nONXIesWXb/jZFt3UJqcbLtGz2uobXPtUQxhrOFHhpkK/d6aE7dp3EydqYkO+y
 oCP3WbC4w9LK2g34uJIbcj/gsu9OE7zny7h06tQhw7IQvxLfMLSn4b7CS0v/R7Mb1OfP
 mZ1ss3BjFSlzNEtBVAnStQNp9gZxbu/tqPq/4k1Hsi06HoeWzEBrk9Kgq0DbZVawYkCP
 6Y9bJdkS6GcRv7gj3sTsSfLHCO3jAvNnsot/0kDaFeEDXCuJv59mAlf7E/dASj5Knvuz
 CLcQ==
X-Gm-Message-State: APjAAAVV/Tf6iQk1MXsroA/xOJsgVQZ9ZNkf07bFR37uGANiLPbanR19
 dzdg8yy0z2BpdZyHG1wstBdWVw==
X-Google-Smtp-Source: APXvYqzWMlnaE1X5C4yiofYhLiuqPsrEf8BZb+R6LZa9V7v6zwnulh0AdTxVJXGYiVDMXNA1xiNb8Q==
X-Received: by 2002:a17:90a:71cb:: with SMTP id
 m11mr6419278pjs.40.1561649068364; 
 Thu, 27 Jun 2019 08:24:28 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id k3sm2637153pgo.81.2019.06.27.08.24.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:24:27 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:20:04 -0700
Message-Id: <20190627152011.18686-28-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627152011.18686-1-palmer@sifive.com>
References: <20190627152011.18686-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
Subject: [Qemu-devel] [PULL 27/34] disas/riscv: Fix `rdinstreth` constraint
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
Cc: "Wladimir J. van der Laan" <laanwj@gmail.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 Michael Clark <mjc@sifive.com>, Alistair Francis <alistair.francis@wdc.com>,
 qemu-riscv@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Wladimir J. van der Laan" <laanwj@gmail.com>

The constraint for `rdinstreth` was comparing the csr number to 0xc80,
which is `cycleh` instead. Fix this.

Signed-off-by: Wladimir J. van der Laan <laanwj@gmail.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 disas/riscv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index d37312705516..278d9be9247e 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -614,7 +614,8 @@ static const rvc_constraint rvcc_rdtime[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc01, r
 static const rvc_constraint rvcc_rdinstret[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc02, rvc_end };
 static const rvc_constraint rvcc_rdcycleh[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc80, rvc_end };
 static const rvc_constraint rvcc_rdtimeh[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc81, rvc_end };
-static const rvc_constraint rvcc_rdinstreth[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc80, rvc_end };
+static const rvc_constraint rvcc_rdinstreth[] = { rvc_rs1_eq_x0,
+                                                  rvc_csr_eq_0xc82, rvc_end };
 static const rvc_constraint rvcc_frcsr[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x003, rvc_end };
 static const rvc_constraint rvcc_frrm[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x002, rvc_end };
 static const rvc_constraint rvcc_frflags[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x001, rvc_end };
@@ -1038,7 +1039,7 @@ const rv_opcode_data opcode_data[] = {
     { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai,
       rv_op_srai, rv_op_srai, rvcd_imm_nz },
     { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi,
-      rv_op_andi, rv_op_andi, rvcd_imm_nz },
+      rv_op_andi, rv_op_andi },
     { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_sub, rv_op_sub, rv_op_sub },
     { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_xor, rv_op_xor, rv_op_xor },
     { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_or, rv_op_or, rv_op_or },
-- 
2.21.0


