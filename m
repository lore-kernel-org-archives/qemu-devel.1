Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304FFC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AA42189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AA42189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibLq-0005uY-7Z
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51630)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiaq7-0006Kx-3Q
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiaq5-0008DK-Jb
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45471)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiaq5-0007sF-9M
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so1136560lfm.12
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=jNAXnuen/EqceGboq9jqUh/HLce5kvK8361K7LpbToc=;
 b=jBG6YboXUDPFnJHfgzd2lAAH8uI8Kr7LmwHZA7SUOA4F6+tZKnVzMh6qfHAEL2Ejo4
 GehXZA8YPKzsv36Kges0NeZzmR771qVexvbAAR8UDwKSxux88GVHF3CK7wH4o9ZUxJrd
 EQfRG6WHYtJFuCZ5s6pJnh2YjqZgp8CwcanZK/9/OC3hHtJZ4ie2oHdATiNWofEp0z6e
 yA0gyDK9IojwoS7+WrGASN4LngJ0/Jjwd0uDDZhHmxgoec6lzQNnOz+PkxHqjjGF4F5f
 5ZGq8fdJKBzd7bqJoR3ttNPsqy2QOXvzrNQ3vX3pqANoCBIrZ+KvgEaFF/YMG6aCl7bW
 p0Yw==
X-Gm-Message-State: APjAAAWlWgrkFwO5QFHTkSJbBvYPMqTnquwHBYjzdc9dC1V4mGeUhaUl
 ZkbxIbBciE7UJXxDGxXfHgtMvVfE9LAYqw==
X-Google-Smtp-Source: APXvYqw0177dRk8t6+GqkUBQqdB02q7H755r2HjoQgikU9Vobzver7vtSZb6cxvP5oBSZvfHRvyJ5w==
X-Received: by 2002:a19:491d:: with SMTP id w29mr14152929lfa.149.1562143317411; 
 Wed, 03 Jul 2019 01:41:57 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id z23sm291802lfq.77.2019.07.03.01.41.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:41:56 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:43 -0700
Message-Id: <20190703084048.6980-28-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.67
Subject: [Qemu-devel] [PULL 27/32] disas/riscv: Fix `rdinstreth` constraint
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


