Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A1CC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A314721842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9xCZVJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A314721842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4U6-0000e9-D4
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59095)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nb-0005oT-Dn
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NT-0000v4-7M
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:38 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NR-0000qm-Vh
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:35 -0400
Received: by mail-pl1-x643.google.com with SMTP id b7so25061441pls.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BTtAZNtC5LEslFth4SXf60p+WzB9yMjQ3jwBVq1HIi4=;
 b=P9xCZVJSzzPbFwt0skLMTpo8XnRqYGuhw2eh9OeVGkUmwz70l2P48a8hNEpssL939P
 cD+1uSa2ZfLb+9AUrt85qbbGF3dQk06EazdGaBc0ekb9rnlyvujhFs157VEQceB7ijdT
 w8cuD4WpDWzftv3dtWezARrsm04RKbDv94SfS9dEVdgkLGnyuBlb2Xp5TKVLy4SEO0if
 a+igRl3ht4NxL1Wo2vopl7KFJaYW1cZEakz2h6t0QprPt/uqs802fXE1Qq8RD2kDPkw1
 cs35MLeu7axsUcn43OUGOSb8wvwiv2G8zjTpTt8oD1HF8pvClicJx8JJrrP4x3Rr9lhY
 AjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BTtAZNtC5LEslFth4SXf60p+WzB9yMjQ3jwBVq1HIi4=;
 b=NT8CtqEDA+4dt2STkzCo6mCQ4LxbgrtscadHsB7LVOJnUY4+cnaf8RNnXH1OSrEE/S
 +6Ve/qIzLV1V0HGekn1L2gi36A0MSWmM6tSwivffMjmn2r3Aj5e/vNhDXO7kWMlG5Oge
 j41LzXPQNfJeLn57rmmPDhs/Y02Aa6eSWPCzcIF7lR3p7CQKv0xi6F7br0L39wingA2o
 og15NYwNEzZ6yIOW0wyOx+w4O/11fIfp/yMHp8vwO+Kg81s11Ve9MSTJgyrIfz4vr7EU
 CaqZB2sADXErglNNQc1btMRX5rzbOzox62N5GDvRP0pUHNXrvP+qT2fndIKEQRpwMQxV
 gp3Q==
X-Gm-Message-State: APjAAAW3FLg4Ok6lMKvR2U+hP1WN9nrHX3LqD7lCfHQRY6y4UVdTQv5x
 zMnjw36s2wBxytCjkwTDkFBqAY9Mnsk=
X-Google-Smtp-Source: APXvYqxGKsWl+5/l25OfpcTTAgVJNE+QrokbXWOLMWIHBjhIfGI2O53Jfvx3OeIVgKAIDOr/bDTnmw==
X-Received: by 2002:a17:902:424:: with SMTP id
 33mr17653195ple.151.1564163492748; 
 Fri, 26 Jul 2019 10:51:32 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.31
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:13 -0700
Message-Id: <20190726175032.6769-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH 48/67] target/arm: Convert T16 load/store
 multiple
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
 target/arm/translate.c | 47 +++++++-----------------------------------
 target/arm/t16.decode  |  8 +++++++
 2 files changed, 16 insertions(+), 39 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 525276ed13..f551fde3db 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9988,6 +9988,13 @@ static bool trans_LDM(DisasContext *s, arg_ldst_block *a)
     return true;
 }
 
+static bool trans_LDM_t16(DisasContext *s, arg_ldst_block *a)
+{
+    /* Writeback is conditional on the base register not being loaded.  */
+    a->w = !(a->list & (1 << a->rn));
+    return trans_LDM(s, a);
+}
+
 /*
  * Branch, branch with link
  */
@@ -10759,6 +10766,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     case 8: /* load/store halfword immediate offset, in decodetree */
     case 9: /* load/store from stack, in decodetree */
     case 10: /* add PC/SP (immediate), in decodetree */
+    case 12: /* load/store multiple, in decodetree */
         goto illegal_op;
 
     case 11:
@@ -10984,45 +10992,6 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         }
         break;
 
-    case 12:
-    {
-        /* load/store multiple */
-        TCGv_i32 loaded_var = NULL;
-        rn = (insn >> 8) & 0x7;
-        addr = load_reg(s, rn);
-        for (i = 0; i < 8; i++) {
-            if (insn & (1 << i)) {
-                if (insn & (1 << 11)) {
-                    /* load */
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                    if (i == rn) {
-                        loaded_var = tmp;
-                    } else {
-                        store_reg(s, i, tmp);
-                    }
-                } else {
-                    /* store */
-                    tmp = load_reg(s, i);
-                    gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                    tcg_temp_free_i32(tmp);
-                }
-                /* advance to the next address */
-                tcg_gen_addi_i32(addr, addr, 4);
-            }
-        }
-        if ((insn & (1 << rn)) == 0) {
-            /* base reg not in list: base register writeback */
-            store_reg(s, rn, addr);
-        } else {
-            /* base reg in list: if load, complete it now */
-            if (insn & (1 << 11)) {
-                store_reg(s, rn, loaded_var);
-            }
-            tcg_temp_free_i32(addr);
-        }
-        break;
-    }
     case 13:
         /* conditional branch or swi */
         cond = (insn >> 8) & 0xf;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 568656ecd6..67476b30dc 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -26,6 +26,7 @@
 &ri              !extern rd imm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
 &ldst_ri         !extern p w u rn rt imm
+&ldst_block      !extern rn i b u w list
 
 # Set S if the instruction is outside of an IT block.
 %s               !function=t16_setflags
@@ -109,3 +110,10 @@ LDR_ri          10011 ... ........              @ldst_spec_i rn=13
 ADR             10100 rd:3 ........             imm=%imm8_0x4
 ADD_rri         10101 rd:3 ........ \
                 &s_rri_rot rn=13 s=0 rot=0 imm=%imm8_0x4  # SP
+
+# Load/store multiple
+
+@ldstm          ..... rn:3 list:8               &ldst_block i=1 b=0 u=0 w=1
+
+STM             11000 ... ........              @ldstm
+LDM_t16         11001 ... ........              @ldstm
-- 
2.17.1


