Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C68CC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F06F321842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="socwDXsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F06F321842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4bZ-0003tS-87
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59737)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nw-0007Wy-Nc
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nu-0001PG-3K
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:03 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Ns-0000zB-Oa
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:01 -0400
Received: by mail-pf1-x443.google.com with SMTP id y15so24861200pfn.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+4XfaDCTfyuI+ugQIIzBK6MHDxWWrmnHUnH0Hltgmbo=;
 b=socwDXsHqY7yZXUSpb45ST5QixBbzT62HHOJE0nIj3BKMkNL+Fd/ljjQXsGqYj0d9U
 2x0aGRFsn78hjoqjMD9kLH7I/VFO17xuInQU4fT1TSHxmh/Wju1VvLCemgIraxVDW5JU
 Ij3gYHaEOaFqN8EbOSNK8SRPCVf30pWyawBsqlfl5CPZjU3kN8eAMJCwC0b7aEeNCyYr
 g5XyGZj7jhh3Ygsfncq8K3iT0ZSH8Ptn3H4CFrlYvF+09H9O64rPysxgzDnF1N6kLcL5
 hfR5mt2E9+Fp7C0gw2oNsKzxRJCNsLl5BLuLipH8Y8TuU2vwD5VLPoRa49+TqV563Wa9
 Fs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+4XfaDCTfyuI+ugQIIzBK6MHDxWWrmnHUnH0Hltgmbo=;
 b=bu0HgrdAJn0uMXpYe7aolKlp8TkNthurIYKayBytKS125oRrqT/Nj3P4LkyGB/82k+
 2FK6TXpcjCGsrEIvlJhkjCsB0BsCEQxt7fh87l0scyA/W3ONacCTF4QHriNPJabpfnEw
 SHpNEk/V2tOcZaRlp+D5jicuyvbIkKCUift/ngD7/tYC83k3O7/KtH4Y6pTfJntFPiFK
 JrQOXPE83py08uve9gz8uo8Lu4d+k+yhBI+dZj5EXoc3MZiL8eA+k25bz54afEBe7qFe
 AFYcMwxQTAp6dlmE3dkz0+8Orus8DN4QJk3FURCguuYT//NWTNn9K/MG8NB005LvEieZ
 CA/A==
X-Gm-Message-State: APjAAAVDIjzUrnMRcg4x17kabo9LGms65riWf/pNx53A8Pln1uOBv/Ns
 dqBcbXKI17MPWrIQ5eaRgkoSqhfz0yk=
X-Google-Smtp-Source: APXvYqzQ8CbhwVQxxqWQ0wuEul4ykQ/j3dw+J99hx8fyUXP9s3EivI1snWt2BfKwRzI18amUbalnmg==
X-Received: by 2002:a63:7b18:: with SMTP id w24mr91960531pgc.328.1564163497124; 
 Fri, 26 Jul 2019 10:51:37 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:17 -0700
Message-Id: <20190726175032.6769-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 52/67] target/arm: Convert T16 add, compare,
 move (two high registers)
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 49 ++----------------------------------------
 target/arm/t16.decode  | 10 +++++++++
 2 files changed, 12 insertions(+), 47 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index e2183eb543..23f5f982f5 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10628,55 +10628,10 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             store_reg(s, rd, tmp);
             break;
         }
-        if (insn & (1 << 10)) {
-            /* 0b0100_01xx_xxxx_xxxx
-             * - data processing extended, branch and exchange
-             */
-            rd = (insn & 7) | ((insn >> 4) & 8);
-            rm = (insn >> 3) & 0xf;
-            op = (insn >> 8) & 3;
-            switch (op) {
-            case 0: /* add */
-                tmp = load_reg(s, rd);
-                tmp2 = load_reg(s, rm);
-                tcg_gen_add_i32(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
-                if (rd == 13) {
-                    /* ADD SP, SP, reg */
-                    store_sp_checked(s, tmp);
-                } else {
-                    store_reg(s, rd, tmp);
-                }
-                break;
-            case 1: /* cmp */
-                tmp = load_reg(s, rd);
-                tmp2 = load_reg(s, rm);
-                gen_sub_CC(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
-                tcg_temp_free_i32(tmp);
-                break;
-            case 2: /* mov/cpy */
-                tmp = load_reg(s, rm);
-                if (rd == 13) {
-                    /* MOV SP, reg */
-                    store_sp_checked(s, tmp);
-                } else {
-                    store_reg(s, rd, tmp);
-                }
-                break;
-            case 3:
-                /* 0b0100_0111_xxxx_xxxx
-                 * - branch [and link] exchange thumb register
-                 * In decodetree
-                 */
-                goto illegal_op;
-            }
-            break;
-        }
 
         /*
-         * 0b0100_00xx_xxxx_xxxx
-         *  - Data-processing (two low registers), in decodetree
+         * - Data-processing (two low registers), in decodetree
+         * - data processing extended, branch and exchange, in decodetree
          */
         goto illegal_op;
 
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 4701f72357..69d3894ba7 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -146,6 +146,16 @@ CMP_rri         00101 ... ........              @arith_1i s=1
 ADD_rri         00110 ... ........              @arith_1i %s
 SUB_rri         00111 ... ........              @arith_1i %s
 
+# Add, compare, move (two high registers)
+
+%reg_0_7        7:1 0:3
+@addsub_2h      .... .... . rm:4 ... \
+                &s_rrr_shi rd=%reg_0_7 rn=%reg_0_7 shim=0 shty=0
+
+ADD_rrri        0100 0100 . .... ...            @addsub_2h s=0
+CMP_rrri        0100 0101 . .... ...            @addsub_2h s=1
+MOV_rrri        0100 0110 . .... ...            @addsub_2h s=0
+
 # Branch and exchange
 
 @branchr        .... .... . rm:4 ...            &r
-- 
2.17.1


