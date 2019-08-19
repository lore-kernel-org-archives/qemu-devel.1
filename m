Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77E9C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:25:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B83214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ok3UFEdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B83214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzq5N-0007OX-MY
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMk-0002YI-DE
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMj-0006jE-53
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:02 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMi-0006iJ-Ux
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:39:01 -0400
Received: by mail-pf1-x442.google.com with SMTP id v12so1937607pfn.10
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=t3Sk/E++ZxrnmWMmhTr25Xzz1GIdoAzJpID10oiImmY=;
 b=ok3UFEdRGD0YJd50WuI90ajBk8TNZGyW8QH/1774NdQnLoVOk0cW+80VXhPKHOm0Bj
 Pr3bjHt/4LTtedHVGCkro5MdQQzYzyRMRFiwdbKaGmc1TDEwCYKToWdFxLpf5jX0IgMd
 qwoCY2aEVfCAo2e4KotWxk+LohIDwv0yRTm9qF+kPjtHsZtZ6IPTbQWmOgLYueK0RnZP
 nLtOoVdiaxe7ialYgoI+h4Kc2W3ICzdaac47K/GGJqm/dPyC3sK3T0y2Hao5TUUid7W5
 4Izauc/CShQ9Vqlr/8rvpsoxgGMIEZB8lWXcx2/+vLI4i3BJlNhYE+Vwpw1ZfCTe6mjQ
 QKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=t3Sk/E++ZxrnmWMmhTr25Xzz1GIdoAzJpID10oiImmY=;
 b=RfwFH1rJteXbFi41A8SYNdyBCYbuVKC6UH67ia8nfvYWqBjhgo+rejBJdACy1i68zG
 B5xIaniCNSKYf4ub2+ulWwLO75eDG/rAJOPx40eXF65fzrLxiHR1VQyK8OvF90znIW2X
 mBOFEGjx+jza9FHsHC++7FpwJl+W4xS8eO/tijXJiGohduGh2LqHKHH8/Y8Dxn+9NO+A
 t7Medxki7BR8TGjgq+gVhX0JOnoxH2ZonP9cMOKBcsIr1kMDOBLpLJdHN35xeBVCbc0T
 l08wvt6FcIWAtRTDV3iFCYln6z92x+BEbp4u1pD/qtAB8Yzp94Kpbn8u1b1LxIC3I0g7
 jj4g==
X-Gm-Message-State: APjAAAXGIN7gnnxROrDjgs7WaBG/iKzhk+WkLHmL4L+7EkrkrraybKsA
 BDGp8f8xaSV813CdvaNvIeGnzGyZbN4=
X-Google-Smtp-Source: APXvYqyHePtM5Fqk2cUwp97MrgbB6mVNFSGiWwtdzPXGYhMCLzHhGdzD1oYju9dWSjd05TnUgtHiNA==
X-Received: by 2002:a17:90a:4485:: with SMTP id
 t5mr22658907pjg.65.1566250739222; 
 Mon, 19 Aug 2019 14:38:59 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:38 -0700
Message-Id: <20190819213755.26175-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v2 51/68] target/arm: Convert T16 one low
 register and immediate
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
 target/arm/translate.c | 44 ++----------------------------------------
 target/arm/t16.decode  | 11 +++++++++++
 2 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6f30415371..3a3b113822 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10586,48 +10586,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
             store_reg(s, rd, tmp);
         }
         break;
-    case 2: case 3:
-        /*
-         * 0b001x_xxxx_xxxx_xxxx
-         *  - Add, subtract, compare, move (one low register and immediate)
-         */
-        op = (insn >> 11) & 3;
-        rd = (insn >> 8) & 0x7;
-        if (op == 0) { /* mov */
-            tmp = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp, insn & 0xff);
-            if (!s->condexec_mask)
-                gen_logic_CC(tmp);
-            store_reg(s, rd, tmp);
-        } else {
-            tmp = load_reg(s, rd);
-            tmp2 = tcg_temp_new_i32();
-            tcg_gen_movi_i32(tmp2, insn & 0xff);
-            switch (op) {
-            case 1: /* cmp */
-                gen_sub_CC(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp);
-                tcg_temp_free_i32(tmp2);
-                break;
-            case 2: /* add */
-                if (s->condexec_mask)
-                    tcg_gen_add_i32(tmp, tmp, tmp2);
-                else
-                    gen_add_CC(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
-                store_reg(s, rd, tmp);
-                break;
-            case 3: /* sub */
-                if (s->condexec_mask)
-                    tcg_gen_sub_i32(tmp, tmp, tmp2);
-                else
-                    gen_sub_CC(tmp, tmp, tmp2);
-                tcg_temp_free_i32(tmp2);
-                store_reg(s, rd, tmp);
-                break;
-            }
-        }
-        break;
+    case 2: case 3: /* add, sub, cmp, mov (reg, imm), in decodetree */
+        goto illegal_op;
     case 4:
         if (insn & (1 << 11)) {
             rd = (insn >> 8) & 7;
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 2b5f368d31..0654275e68 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -133,3 +133,14 @@ SUB_rrri        0001101 ... ... ...             @addsub_3
 
 ADD_rri         0001 110 ... ... ...            @addsub_2i
 SUB_rri         0001 111 ... ... ...            @addsub_2i
+
+# Add, subtract, compare, move (one low register and immediate)
+
+%reg_8          8:3
+@arith_1i       ..... rd:3 imm:8 \
+                &s_rri_rot rot=0 rn=%reg_8
+
+MOV_rxi         00100 ... ........              @arith_1i %s
+CMP_xri         00101 ... ........              @arith_1i s=1
+ADD_rri         00110 ... ........              @arith_1i %s
+SUB_rri         00111 ... ........              @arith_1i %s
-- 
2.17.1


