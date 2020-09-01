Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B56C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03FD2078B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vfPI1miL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03FD2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD8Fd-0007Qf-N8
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83l-0008KS-3F
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:37236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83i-0006Dz-V3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id z4so1987568wrr.4
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=h02J47J0NAEkCFyJiV01L5/BuhEXjgNdEYvUqqwW3do=;
 b=vfPI1miL3skFzDV1zpH58LcXJbHVT67nTG+da9mp8QiDOn4+aiBbNGkEJROkfePBt4
 grM8yi3QaWYC1AYbHxMfzlkp3/vue0E9dI1UbnMrFem/jFmQYXXqP0QwTIN3FaynDc6h
 5b1dHPpJrI/X2gju1pEwpIhxtsr9/9COZ45H73cmR35Fqjdi9Az8Qq+gUJvH6EH8D0BT
 zU54MQ3rlsjGMaT2xBBzxYTMdySRRG2jt0IyQN5iDiBcxiOXj4IxTytvEagnsrBiXNhS
 ppip/0G06RyS3AXQoEXvD0uc5ZgIHisaVj4AThzltilVZihEvdAmb1vUo8V/JsQVIDcl
 Vymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h02J47J0NAEkCFyJiV01L5/BuhEXjgNdEYvUqqwW3do=;
 b=nVqXGhq24RqXYkbs9Dw25hRyRccHsRkRQZ8OQOujVOBbYQrHzq3gZ5BPwQsd7Xft+I
 QcETPe6t776F2mKMxwevNrHmDh5FiKXZjWIgVayTjNqwOYOjdK7WPETddprvcToroRdc
 ioJNEK0mSL2o+L96+HhDsjpnxds3lxQenUnBW4W1bVN5iVBTLgA78jZlL6KlUn94Hg20
 yd7jbrBRpnISMO3JN3UDW817uU71khvhwu8ylZFBzLsGMhaedT6aSP97nv3kUetRntFX
 SU5pdq8cq9IAEwmzw9RIr4wBtd8nAS9ZPVtZ08RtJaZTaEZ3EWYM/ErCxqDNPkG2/Lyt
 7Hkw==
X-Gm-Message-State: AOAM531y1o7yThqO9sQ7+QEwaKOFzP0VMl7qAJVCwCSj78HDJdRb15zY
 zTDKfS9wnVT+ySVDM/4IYhdzd1cSRWSz8Cna
X-Google-Smtp-Source: ABdhPJzSg3clF5LFP0axHNjnwBZ/CW5X7HdkuW9EB7PJK6d47BZkCckfktFhj6V3f7L3IztWNEAWKQ==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr2496710wrq.203.1598973533221; 
 Tue, 01 Sep 2020 08:18:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/47] target/arm: Implement VFP fp16 VMOV between gp and
 halfprec registers
Date: Tue,  1 Sep 2020 16:17:57 +0100
Message-Id: <20200901151823.29785-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901151823.29785-1-peter.maydell@linaro.org>
References: <20200901151823.29785-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement the VFP fp16 variant of VMOV that transfers a 16-bit
value between a general purpose register and a VFP register.

Note that Rt == 15 is UNPREDICTABLE; since this insn is v8 and later
only we have no need to replicate the old "updates CPSR.NZCV"
behaviour that the singleprec version of this insn does.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200828183354.27913-22-peter.maydell@linaro.org
---
 target/arm/vfp.decode          |  1 +
 target/arm/translate-vfp.c.inc | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 9a79e99f1b0..51f143b4a51 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -74,6 +74,7 @@ VDUP         ---- 1110 1 b:1 q:1 0 .... rt:4 1011 . 0 e:1 1 0000 \
              vn=%vn_dp
 
 VMSR_VMRS    ---- 1110 111 l:1 reg:4 rt:4 1010 0001 0000
+VMOV_half    ---- 1110 000 l:1 .... rt:4 1001 . 001 0000    vn=%vn_sp
 VMOV_single  ---- 1110 000 l:1 .... rt:4 1010 . 001 0000    vn=%vn_sp
 
 VMOV_64_sp   ---- 1100 010 op:1 rt2:4 rt:4 1010 00.1 ....   vm=%vm_sp
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 4b26156eccc..28e0dba5f14 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -809,6 +809,40 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
     return true;
 }
 
+static bool trans_VMOV_half(DisasContext *s, arg_VMOV_single *a)
+{
+    TCGv_i32 tmp;
+
+    if (!dc_isar_feature(aa32_fp16_arith, s)) {
+        return false;
+    }
+
+    if (a->rt == 15) {
+        /* UNPREDICTABLE; we choose to UNDEF */
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (a->l) {
+        /* VFP to general purpose register */
+        tmp = tcg_temp_new_i32();
+        neon_load_reg32(tmp, a->vn);
+        tcg_gen_andi_i32(tmp, tmp, 0xffff);
+        store_reg(s, a->rt, tmp);
+    } else {
+        /* general purpose register to VFP */
+        tmp = load_reg(s, a->rt);
+        tcg_gen_andi_i32(tmp, tmp, 0xffff);
+        neon_store_reg32(tmp, a->vn);
+        tcg_temp_free_i32(tmp);
+    }
+
+    return true;
+}
+
 static bool trans_VMOV_single(DisasContext *s, arg_VMOV_single *a)
 {
     TCGv_i32 tmp;
-- 
2.20.1


