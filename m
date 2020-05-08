Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0A3C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B3F924953
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjBb+YGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B3F924953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX54d-0004Id-Bx
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pM-0004bO-8c
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:17 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pL-00076O-9D
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:15 -0400
Received: by mail-pl1-x642.google.com with SMTP id s20so858166plp.6
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I+AyE2bJa10UxodOkXAXrVws6OuY7h9XFrym37/9NTI=;
 b=sjBb+YGrz5hisCzyfJ5eZEZSuQjzKv/3/DWIqIya4a0HyY18QMZxb5bdRYSIL7dskB
 h6trMfvD/p50bLgPVLtQS/L6Ub3dlTjRefMjacTsscqtJYlkWxRKSA9jfADtOyUOULQW
 H7n3lGHWrKnV7tJPImPmvq2qtaBw1xRfRBw43qeLcS0gqfLl1nouHbADkrebZMaX9LVA
 +cNzQjFHv8Sek/hruKBamvrWbzTUhAYvaneRMybwK1u7ajAOksalVmedBGYKLBLmix27
 NkjytkVu+GfEfZWbtNgzr+kB6m6T7Ep8RWXAxLu2+1jdJlAmpgzIK/9zN+PRQV4OL5NN
 6Asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=I+AyE2bJa10UxodOkXAXrVws6OuY7h9XFrym37/9NTI=;
 b=S7MGHb0hQbuqWvPT76bvcfQclu5XNv5oqdIfWtDve4nK/CSPbehDz2v5eSXj6Q8ab2
 b5XrlN0Fw+qntsh01jkPD3BdXFAVm/6S2l7RA/UApBrHDG5xFBDxRAU2LKnL7mjJb58f
 ZGRx/KMNPz+DQrVJsGBVABya2RpfEXdkRMwSt7c30C1dMdUxMpauPtRMtXFz032f43ld
 w9XL8+HUo2hsYF2LfGHCr7jWNQtky8rT9zxr5iMkHsMSJZZXqXRCJ6ov2D866A53r/7G
 rIgwrhmWZMvUn/RdK/Nm88c6sk4cwyatD1mNLGj+UpJW5CsD2u7e2iBiKcjfq4wnwnfe
 RASA==
X-Gm-Message-State: AGi0PubMqVml6wRGdGYrwuO4B6qXFuHFDYb94EvrWp0E/w4Uxj+r1QWu
 Boz6AIDUHGbcDERi/lkdlq1imKb4GjQ=
X-Google-Smtp-Source: APiQypIxHhogPupHT07SG3N5RVSezXncpV8tUpdYmDthPrZuZTiGzcAQ2+RiVCjyi59Em5bOoO63jQ==
X-Received: by 2002:a17:902:549:: with SMTP id
 67mr2901759plf.115.1588951333075; 
 Fri, 08 May 2020 08:22:13 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n16sm2104575pfq.61.2020.05.08.08.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:22:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/16] target/arm: Swap argument order for VSHL during
 decode
Date: Fri,  8 May 2020 08:21:52 -0700
Message-Id: <20200508152200.6547-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508152200.6547-1-richard.henderson@linaro.org>
References: <20200508152200.6547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than perform the argument swap during code generation,
perform it during decode.  This means it doesn't have to be
special cased later, and we can share code with aarch64 code
generation.  Hopefully the decode comment addresses any confusion
that might arise in between.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       | 9 +++++++--
 target/arm/translate-neon.inc.c | 3 +--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index ec3a92fe75..6b0b6566d6 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -65,8 +65,13 @@ VCGT_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 0 .... @3same
 VCGE_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 1 .... @3same
 VCGE_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 1 .... @3same
 
-VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same
-VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same
+# The shift operations are of the form Vd = Vm << Vn.
+# By reversing the names of the fields here, we can use standard expanders.
+@3same_rev       .... ... . . . size:2 .... .... .... . q:1 . . .... \
+                 &3same vn=%vm_dp vm=%vn_dp vd=%vd_dp
+
+VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same_rev
+VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same_rev
 
 VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
 VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index aefeff498a..416302bcc7 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -692,8 +692,7 @@ static bool trans_VMUL_p_3s(DisasContext *s, arg_3same *a)
                                 uint32_t rn_ofs, uint32_t rm_ofs,       \
                                 uint32_t oprsz, uint32_t maxsz)         \
     {                                                                   \
-        /* Note the operation is vshl vd,vm,vn */                       \
-        tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs,                          \
+        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,                          \
                        oprsz, maxsz, &OPARRAY[vece]);                   \
     }                                                                   \
     DO_3SAME(INSN, gen_##INSN##_3s)
-- 
2.20.1


