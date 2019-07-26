Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46529C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023A7217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMX8tfFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023A7217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4S8-0000Za-Ms
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58917)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NR-0005Lb-Nm
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NQ-0000p1-I4
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:33 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NQ-0000if-CO
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:32 -0400
Received: by mail-pg1-x544.google.com with SMTP id f20so15878106pgj.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DJdrX3hGPWd+nibN4wc0pBIHsM6KUMw+bIbJb3gnsWg=;
 b=SMX8tfFkoYwIcv28vMhG4MahozdMyw8XYZvQYpm8lIsJRiHb2YmyH0RHZXRjuDqG8h
 aNaPPkmq5W0/5pVAmjCWfTw3wz9bM+uMD8/wWAd7UTVSZcmT3E1EswqaoFFdThQENjXW
 m6/AdnpmZt44SLMTqMHuS/1Ygct9wrRViSSX1T/N16/h31A7MIrgfc+3VctsYstZwYBF
 binQlAKZEC9FHXAt+6B1htgh6+w9laFYIrPMfNyZu/up+pEGglfJE8rnNYlPcS1VZbOD
 Tb+UqKL8bN/1z/8zfK4TddcX6zacp/nRkYa/T+205DTcD+r2xOL0uRy/6kbL+3xOLaUi
 +eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DJdrX3hGPWd+nibN4wc0pBIHsM6KUMw+bIbJb3gnsWg=;
 b=FA2fHL1YvejWdllZ2nh8lcPtWMf0iiD2GX74OkmgzkrRa6eKE+vdRF5lr8zlGEy1Af
 cSZOigovVA4ATU59zKLa1whbLXCPDNk2UbN1VkNMkacfMZOVquiclyqo6htuzoJZOySU
 BQIBXRhsBsO5EaYFXVs825Gs8xUE8pe+mDeebD1tNEK1444pzyyuDHffMeBYDMia1hca
 eScGN6GXYbsdDbo+dmnx2LnmLRH8KJx0UjkGEHrX4x5OLTOAeZM/5XEEL8S94L14WzPj
 X/3MqVcl35IzBUldglo83n47TR2s6ktv2PalHeSJGZqwWTlBy/YzTe+933+9zgwcHARO
 7dlA==
X-Gm-Message-State: APjAAAVs3hwH7U1DJjCCxNanArryV7kUEi6wCGmeBhBwm9GWKzbZ6ItX
 TFUcaEiH2szJE8ZVn+sWgQeEpbNgthc=
X-Google-Smtp-Source: APXvYqxt5OeXyTqlms/fhyEnWqA7BM19XAhuclm4VyzXPMYj4CgieR1zEPJaoVEaJ23TsrDFfI/G/g==
X-Received: by 2002:a63:5823:: with SMTP id m35mr93897621pgb.329.1564163489154; 
 Fri, 26 Jul 2019 10:51:29 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:10 -0700
Message-Id: <20190726175032.6769-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 45/67] target/arm: Convert T16 load/store
 (register offset)
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
 target/arm/translate.c | 51 ++----------------------------------------
 target/arm/t16.decode  | 15 +++++++++++++
 2 files changed, 17 insertions(+), 49 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 17a0eea425..7b87621315 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10754,55 +10754,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
         goto illegal_op;
 
     case 5:
-        /* load/store register offset.  */
-        rd = insn & 7;
-        rn = (insn >> 3) & 7;
-        rm = (insn >> 6) & 7;
-        op = (insn >> 9) & 7;
-        addr = load_reg(s, rn);
-        tmp = load_reg(s, rm);
-        tcg_gen_add_i32(addr, addr, tmp);
-        tcg_temp_free_i32(tmp);
-
-        if (op < 3) { /* store */
-            tmp = load_reg(s, rd);
-        } else {
-            tmp = tcg_temp_new_i32();
-        }
-
-        switch (op) {
-        case 0: /* str */
-            gen_aa32_st32_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 1: /* strh */
-            gen_aa32_st16_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 2: /* strb */
-            gen_aa32_st8_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 3: /* ldrsb */
-            gen_aa32_ld8s_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 4: /* ldr */
-            gen_aa32_ld32u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 5: /* ldrh */
-            gen_aa32_ld16u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 6: /* ldrb */
-            gen_aa32_ld8u_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        case 7: /* ldrsh */
-            gen_aa32_ld16s_iss(s, tmp, addr, get_mem_index(s), rd | ISSIs16Bit);
-            break;
-        }
-        if (op >= 3) { /* load */
-            store_reg(s, rd, tmp);
-        } else {
-            tcg_temp_free_i32(tmp);
-        }
-        tcg_temp_free_i32(addr);
-        break;
+        /* load/store register offset, in decodetree */
+        goto illegal_op;
 
     case 6:
         /* load/store word immediate offset */
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 9833fc97e7..567c5005d6 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -23,6 +23,7 @@
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
+&ldst_rr         !extern p w u rn rt rm shimm shtype
 
 # Set S if the instruction is outside of an IT block.
 %s               !function=t16_setflags
@@ -54,3 +55,17 @@ ORR_rrri         010000 1100 ... ...            @lll_noshr
 MUL              010000 1101 rn:3 rd:3          &s_rrrr %s rm=%reg_0 ra=0
 BIC_rrri         010000 1110 ... ...            @lll_noshr
 MVN_rrri         010000 1111 ... ...            @lll_noshr
+
+# Load/store (register offset)
+
+@ldst_rr         ....... rm:3 rn:3 rt:3 \
+                 &ldst_rr p=1 w=0 u=1 shimm=0 shtype=0
+
+STR_rr           0101 000 ... ... ...           @ldst_rr
+STRH_rr          0101 001 ... ... ...           @ldst_rr
+STRB_rr          0101 010 ... ... ...           @ldst_rr
+LDRSB_rr         0101 011 ... ... ...           @ldst_rr
+LDR_rr           0101 100 ... ... ...           @ldst_rr
+LDRH_rr          0101 101 ... ... ...           @ldst_rr
+LDRB_rr          0101 110 ... ... ...           @ldst_rr
+LDRSH_rr         0101 111 ... ... ...           @ldst_rr
-- 
2.17.1


