Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1E3C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C5D206BB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOqI2pBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C5D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzq0U-0007e4-Bn
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMw-0002uU-2f
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMu-0006ui-Og
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:13 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:45900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMu-0006uI-JD
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:12 -0400
Received: by mail-pg1-x52a.google.com with SMTP id o13so1921690pgp.12
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ltc+Iekt5p0qb7H2sxDb1ZsirxTTtPcO/0Q5mx5ZDAc=;
 b=AOqI2pBLdPKE0yz8n1aVZ3uJqwZsJXfmxB/GOdPSA/hBZ4ZHHvS3ufqQp5UkDrECfg
 V0wGtku8vdSUuJptbaxjBG8OKwdpMBgOPRfShbsDFWKxScdP13IGHiwmts4mS8w3+tZt
 gENOINsYfXjz/h6CSYnxye/xwOm5Ei5n1hPrjlWAqEsbjWaPyI61DSg9tN4ti48MfAxS
 FRMmQjfYNlWoqSYSwC1oxY/Zaht33blLwN+yrHPStfsZ8jjcktDBXQ/TVYFoWetq6ziF
 ELawQecE5FboJXxauR+kHY5tdZG7lCg7cUaZ/GEjS3qfk2+pjqab+jabXBRy+YxzMYNC
 KX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ltc+Iekt5p0qb7H2sxDb1ZsirxTTtPcO/0Q5mx5ZDAc=;
 b=d321T/q23DqoAeP+EXb7/3ROyGNPhpFgKvumS5UtiiwlRSVYgu2ItxVzE29izHu0Wd
 vrWcxLhdF3z5D5w5BJWeyIsf5+Brg9rpZ3j2kbZud64GnSx7kctojqu5GK9ILjaPfpsh
 fTedjcai5PqomHv52b+OwnLClyWp0gritWSP42dNwh8RW6IMzfm03AO/2ehARdUYejlc
 sT6TGXq9Iu575wFqBqPlfqXkkFo+yuDZkHSZh7mU7TtUApZZuuj7s1SlwsvHu9B64PoD
 4KdUCq8icGCbZ3S7Wy7wn3LSfDKephrEJWLvdeZFMW+VjOmLqSuDGuB1CSTXiQGxKd3o
 501g==
X-Gm-Message-State: APjAAAXgoh0b3Y/mAjfracKHB5tuOiOrA24IhR08jw/e5dVFcTuscjC1
 q8Aap3NoCkGXicrTLL23cm1jVFDfrz8=
X-Google-Smtp-Source: APXvYqw31Z+a4S8bGc1TztxMTlaMGD0qlTEXTEAeS1cKy9k4t6it5/26fMsSH3HrGDFAerzJyNVI9A==
X-Received: by 2002:a17:90a:8a11:: with SMTP id
 w17mr11126377pjn.139.1566250751227; 
 Mon, 19 Aug 2019 14:39:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:39:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:47 -0700
Message-Id: <20190819213755.26175-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52a
Subject: [Qemu-devel] [PATCH v2 60/68] target/arm: Convert T16, push and pop
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 83 ++++++------------------------------------
 target/arm/t16.decode  | 10 +++++
 2 files changed, 22 insertions(+), 71 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 9e0345adf7..5f876290ba 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7494,6 +7494,16 @@ static int t16_setflags(DisasContext *s)
     return s->condexec_mask == 0;
 }
 
+static int t16_push_list(DisasContext *s, int x)
+{
+    return (x & 0xff) | (x & 0x100) << (14 - 8);
+}
+
+static int t16_pop_list(DisasContext *s, int x)
+{
+    return (x & 0xff) | (x & 0x100) << (15 - 8);
+}
+
 /*
  * Include the generated decoders.
  */
@@ -10591,7 +10601,6 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
     uint32_t val, op, rm, rd, shift, cond;
     int32_t offset;
-    int i;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
     TCGv_i32 addr;
@@ -10664,76 +10673,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             goto illegal_op;
 
         case 4: case 5: case 0xc: case 0xd:
-            /*
-             * 0b1011_x10x_xxxx_xxxx
-             *  - push/pop
-             */
-            addr = load_reg(s, 13);
-            if (insn & (1 << 8))
-                offset = 4;
-            else
-                offset = 0;
-            for (i = 0; i < 8; i++) {
-                if (insn & (1 << i))
-                    offset += 4;
-            }
-            if ((insn & (1 << 11)) == 0) {
-                tcg_gen_addi_i32(addr, addr, -offset);
-            }
-
-            if (s->v8m_stackcheck) {
-                /*
-                 * Here 'addr' is the lower of "old SP" and "new SP";
-                 * if this is a pop that starts below the limit and ends
-                 * above it, it is UNKNOWN whether the limit check triggers;
-                 * we choose to trigger.
-                 */
-                gen_helper_v8m_stackcheck(cpu_env, addr);
-            }
-
-            for (i = 0; i < 8; i++) {
-                if (insn & (1 << i)) {
-                    if (insn & (1 << 11)) {
-                        /* pop */
-                        tmp = tcg_temp_new_i32();
-                        gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                        store_reg(s, i, tmp);
-                    } else {
-                        /* push */
-                        tmp = load_reg(s, i);
-                        gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                        tcg_temp_free_i32(tmp);
-                    }
-                    /* advance to the next address.  */
-                    tcg_gen_addi_i32(addr, addr, 4);
-                }
-            }
-            tmp = NULL;
-            if (insn & (1 << 8)) {
-                if (insn & (1 << 11)) {
-                    /* pop pc */
-                    tmp = tcg_temp_new_i32();
-                    gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                    /* don't set the pc until the rest of the instruction
-                       has completed */
-                } else {
-                    /* push lr */
-                    tmp = load_reg(s, 14);
-                    gen_aa32_st32(s, tmp, addr, get_mem_index(s));
-                    tcg_temp_free_i32(tmp);
-                }
-                tcg_gen_addi_i32(addr, addr, 4);
-            }
-            if ((insn & (1 << 11)) == 0) {
-                tcg_gen_addi_i32(addr, addr, -offset);
-            }
-            /* write back the new stack pointer */
-            store_reg(s, 13, addr);
-            /* set the new PC value */
-            if ((insn & 0x0900) == 0x0900) {
-                store_reg_from_load(s, 15, tmp);
-            }
-            break;
+            /* push/pop, in decodetree */
+            goto illegal_op;
 
         case 1: case 3: case 9: case 11: /* czb */
             rm = insn & 7;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index d5b046d105..d731402036 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -221,3 +221,13 @@ REVSH           1011 1010 11 ... ...            @rdm
   # rest of the space is a reserved hint, behaves as nop.
   NOP           1011 1111 ---- 0000
 }
+
+# Push and Pop
+
+%push_list      0:9 !function=t16_push_list
+%pop_list       0:9 !function=t16_pop_list
+
+STM             1011 010 ......... \
+                &ldst_block i=0 b=1 u=0 w=1 rn=13 list=%push_list
+LDM_t16         1011 110 ......... \
+                &ldst_block i=1 b=0 u=0 w=1 rn=13 list=%pop_list
-- 
2.17.1


