Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB811C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6E42065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JTsK1dyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6E42065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEmO-0006DX-MQ
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkG-00038q-AG
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkE-0005Tr-KA
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:21:55 -0400
Received: by mail-wr1-x42b.google.com with SMTP id 50so4329266wrc.11
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=IzyO8U/Vt27hwDrgZ4KQ9+8AH5suUqMiUHLnwA1A03I=;
 b=JTsK1dyXsXZkrT3ic4hAE24m0wrwGUiQGj1cq55NPG3k+LNsxopz+gimp5wauAOSDj
 RLN8aNW0LFSOnejGzvFhxeJSZemDrAXJwOqNNbQEMm7LuAkrxTrU/O6wvb0k8RoNC40X
 cd2at6CrLRpo/bHyENKYtktWEMLpAtDLYs4v6UNCVBJtgRgNZcu7FKYJNjT9JNeN+d4F
 4C9HYoNScUczt02/U/Clb+03yhTAfF0oxqFW8aR4+Q1l6NivJP8yGa3k+KvdebL4T19p
 y6b2IlENq3CKzsdW9VgYveZZ9njwCvwYr7a9oWMX5lcycmngrAJuYsibwgFKhhKkPm0C
 YxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IzyO8U/Vt27hwDrgZ4KQ9+8AH5suUqMiUHLnwA1A03I=;
 b=RwllRqTqfnanU+9h1YllyVYEb5Xs4rs4TqS7l+wS79PXSF9p+29OKPJKQg/Ahkd6SS
 kdfjeLYaHO644702xuEyNJl8eDL/pZQLOCXYwOfDDn3hhJq/QOJ9XlPZywg45QJjVwX1
 zySjCHtYdyL8FUO0SMOgwhH10jhyp7B3l68icmLU/eosfG2FMiU6WI7oiwksZL0MTm1F
 yFV8Nj0kdFa0FMS8nrF8p+zN7Pn/0l3870GkSJjY6jhzEgsXhM2AWrz6oSjNRaVue4G/
 NHyLfjK6Z6nWg2eSOduHBC/Pij3t39SfJDPAXW1YJx44TDfZW8bR+pezfxXVXqJtdN98
 aEjQ==
X-Gm-Message-State: AOAM533DpUOuTZ+9Rs9qbh0vb04Hvg/LUiODP5HZBX7YNKEfqFC9ptnx
 Mpsy79XyYYzcIQ++ps2/sEDX9UZpWYmmOw==
X-Google-Smtp-Source: ABdhPJwG6uEJ7JuvaDyTRcIlXI4ixkKd6JXPSu/a56NQmrwowO3D7EMJ8vtlwcJWahBFyuLbz39Dbw==
X-Received: by 2002:adf:8483:: with SMTP id 3mr5823080wrg.206.1589466112943;
 Thu, 14 May 2020 07:21:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.21.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:21:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/45] target/arm: Swap argument order for VSHL during decode
Date: Thu, 14 May 2020 15:21:02 +0100
Message-Id: <20200514142138.20875-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Rather than perform the argument swap during code generation,
perform it during decode.  This means it doesn't have to be
special cased later, and we can share code with aarch64 code
generation.  Hopefully the decode comment addresses any confusion
that might arise in between.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200513163245.17915-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       | 17 +++++++++++++++--
 target/arm/translate-neon.inc.c |  3 +--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index ec3a92fe753..593f7fff03d 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -65,8 +65,21 @@ VCGT_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 0 .... @3same
 VCGE_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 1 .... @3same
 VCGE_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 1 .... @3same
 
-VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same
-VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same
+# The _rev suffix indicates that Vn and Vm are reversed. This is
+# the case for shifts. In the Arm ARM these insns are documented
+# with the Vm and Vn fields in their usual places, but in the
+# assembly the operands are listed "backwards", ie in the order
+# Dd, Dm, Dn where other insns use Dd, Dn, Dm. For QEMU we choose
+# to consider Vm and Vn as being in different fields in the insn,
+# which allows us to avoid special-casing shifts in the trans_
+# function code. We would otherwise need to manually swap the operands
+# over to call Neon helper functions that are shared with AArch64,
+# which does not have this odd reversed-operand situation.
+@3same_rev       .... ... . . . size:2 .... .... .... . q:1 . . .... \
+                 &3same vn=%vm_dp vm=%vn_dp vd=%vd_dp
+
+VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same_rev
+VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same_rev
 
 VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
 VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index aefeff498a6..416302bcc78 100644
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


