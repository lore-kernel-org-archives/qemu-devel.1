Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB771C76190
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF04218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 18:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVe2eF5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF04218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4aj-0000Ni-IN
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 14:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59458)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nr-0007DC-Hp
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Nn-0001Eu-Mi
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:57 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Nl-00016t-GG
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:55 -0400
Received: by mail-pf1-x443.google.com with SMTP id p184so24849389pfp.7
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=8QVQ4BiqNc7iS0VjGNnUVyPSyENYZan6FBJAYfvLZTc=;
 b=QVe2eF5t5OwKctLNlKcL1Cp/S1HuU3u6npmInBLg3MDJTacCR0bML8eN+coRv0pbfv
 fLSOCeNWiPxy/8AIXOrKPgXvMkKY6Ff7QMEdesGKPqy70QVK5Z16zFslntSDkUbuKJyI
 oTbSy2oonDD3UwsbvTFlbPR2zK/GQfwyEcAbRMTJrKEi/oe7buRlUPd8tU1nk8KbP6ff
 S2jI7/EXaec4/SA2OYPJLcu6WhkrgmBh+cS5Vd3hR5GTZuZHV0HTSyEIFZ26YqbJ3rPK
 72tOnaeVDwDFU3fO/Ytap2znGT6mIglouuMwHztJHkLStwCWeMvpSLqpsjpufPaNUy+z
 Wvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=8QVQ4BiqNc7iS0VjGNnUVyPSyENYZan6FBJAYfvLZTc=;
 b=ZiRmWFRIeRmR+97XSul+Lzs1Yu6QrwTo5TQhelK54T0PKpCYF3F8vq+gj7WIyv718V
 4K2qWKJxO465eRQf94PCnlqqQoT3rH9wFYDyM6h9o60rYnD8wPeX+kXH5W52Mlg+dAj7
 SlXL4Ii/Scbniq73bWIBDrXNg9Xm1to/SZHD9e/UD4Y/KShUeU6cCQel13wJGgTBILPN
 PCDHfksBCt9ezwc/ldLv+LS3yxIw3+9R3y3wvSF/zVEhWCP/Q2CMoDJ5/KyUU/MWjh+K
 VNMGblXGZnzF7nHmaZhqtzWCnuw8/gbW/Tn+JKbvmKIggLL1Ymtoytz6KCVa58628mNv
 z2JQ==
X-Gm-Message-State: APjAAAW4KHxMb1Q4tyh0ept9NxoPm9wZMQsGrltk86RfUhpxPzp2EWE1
 PBHVRu94f8XhPBBuA6QdOdhXq4bEww0=
X-Google-Smtp-Source: APXvYqz8ljBw/qlm89WBne2jFlT876lxaKbNtgC10rRL1yl+nmsFW1+FS2a/T8fI0YUdnfOArEgvLg==
X-Received: by 2002:a17:90a:1b4c:: with SMTP id
 q70mr96449651pjq.69.1564163507269; 
 Fri, 26 Jul 2019 10:51:47 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.46
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:26 -0700
Message-Id: <20190726175032.6769-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 61/67] target/arm: Convert T16, shift immediate
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
 target/arm/translate.c | 26 ++------------------------
 target/arm/t16.decode  |  8 ++++++++
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index f3a946d8c9..f9022fe65c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10657,7 +10657,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val, op, rm, rd, shift;
+    uint32_t val, rd;
     int32_t offset;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
@@ -10669,29 +10669,7 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
     /* fall back to legacy decoder */
 
     switch (insn >> 12) {
-    case 0: case 1:
-
-        rd = insn & 7;
-        op = (insn >> 11) & 3;
-        if (op == 3) {
-            /*
-             * 0b0001_1xxx_xxxx_xxxx
-             *  - Add, subtract (three low registers)
-             *  - Add, subtract (two low registers and immediate)
-             * In decodetree.
-             */
-            goto illegal_op;
-        } else {
-            /* shift immediate */
-            rm = (insn >> 3) & 7;
-            shift = (insn >> 6) & 0x1f;
-            tmp = load_reg(s, rm);
-            gen_arm_shift_im(tmp, op, shift, s->condexec_mask == 0);
-            if (!s->condexec_mask)
-                gen_logic_CC(tmp);
-            store_reg(s, rd, tmp);
-        }
-        break;
+    case 0: case 1: /* add/sub (3reg, 2reg imm), shift imm; in decodetree */
     case 2: case 3: /* add, sub, cmp, mov (reg, imm), in decodetree */
         goto illegal_op;
     case 4:
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 17297a3032..ddffd073a2 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -126,6 +126,14 @@ ADD_rri         10101 rd:3 ........ \
 STM             11000 ... ........              @ldstm
 LDM_t16         11001 ... ........              @ldstm
 
+# Shift (immediate)
+
+@shift_i        ..... shim:5 rm:3 rd:3          &s_rrr_shi %s rn=%reg_0
+
+MOV_rrri        000 00 ..... ... ...            @shift_i shty=0  # LSL
+MOV_rrri        000 01 ..... ... ...            @shift_i shty=1  # LSR
+MOV_rrri        000 10 ..... ... ...            @shift_i shty=2  # ASR
+
 # Add/subtract (three low registers)
 
 @addsub_3       ....... rm:3 rn:3 rd:3 \
-- 
2.17.1


