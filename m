Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29938C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6634D2065D
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 16:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xnlyr6De"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6634D2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYuaz-0003Jd-V5
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 12:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJZ-0003iw-Us
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:33:02 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYuJX-00021F-Sn
 for qemu-devel@nongnu.org; Wed, 13 May 2020 12:33:00 -0400
Received: by mail-pf1-x444.google.com with SMTP id b190so2464116pfg.6
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0XPH9ZnuWODr1aczdQy13UdDY+XzlpSDX0OJjahOFSQ=;
 b=Xnlyr6DewUk05UaxzDoYmd8KQpFrb81ykp6darc4Lz04gdyaBZMiUOQFKqiu2HOj73
 SNYw8y5Z0+hLuqQ8y1+9nqdQvsMaCWEoYnumQqlNOdA+eAI1+u9LvRAJXVnDuOMq5FdY
 19Q3RBCmD54scSu1SlviTwUbfj7GEhTqXPLtn/KlvVsTkiCyHY9Y/MmCIY8cgYiky79h
 NLLHAXGy7eeK2E+KYC9ySIhWeykqQKKNNC8Tn4Bv36nxu/UktkqLzgTLG2tX5n8QFeCf
 RZYw/CXYtFOHItJV8sp8f6ygEe8ZNmYslLs/B8Tu4A1AdLOm/LihTLDmRwFoOUzWwtoO
 SMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0XPH9ZnuWODr1aczdQy13UdDY+XzlpSDX0OJjahOFSQ=;
 b=YZa/znZrZRUVhOD1xFmU4KkbCsecxtDY9D4Uv9818sdaN+ALGQplQpvVj2dLL3NEcq
 w89y2ORo+oD+v0y7zwDoo40AwBUkSZ1jOv5zJHwiQfkNhZs8kXTy9xFqeNuBc0bmC2w3
 bzA6W+2ZIhSFXuwCfGPltgLZyqC0Fiko7kvB+kkUMAad7knsUD+44V+HVV1dqo3ozlwj
 HZeV/CPG1okeX0n25oZItaVpXbOqno6sPWM4CePWd3NI2hS5NIzQYroCvR/GBaNIpNPD
 K7rexdHZd/+CSwoOYCNbl40U/S+fNDqWCElzcfxV1bt0zaJhhj1EIpaJB2u1SRZ5hACN
 4eFA==
X-Gm-Message-State: AOAM5329NRIqUehchxwnWGIAnN4ugypqqr+f9GQADT8JHRbPrNx00PE7
 1Umu/2GvBpMrkAlIEbu8I1icfujU+Fg=
X-Google-Smtp-Source: ABdhPJzH97qwtARlIRbXKfugiwh1CLjXp5v1/krNL7vZc1PXELbCel70jzzV7xSG3q0g4BX57rtX4g==
X-Received: by 2002:a63:6a82:: with SMTP id f124mr152238pgc.378.1589387577859; 
 Wed, 13 May 2020 09:32:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b11sm158025pgq.50.2020.05.13.09.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 09:32:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/16] target/arm: Swap argument order for VSHL during
 decode
Date: Wed, 13 May 2020 09:32:37 -0700
Message-Id: <20200513163245.17915-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200513163245.17915-1-richard.henderson@linaro.org>
References: <20200513163245.17915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       | 17 +++++++++++++++--
 target/arm/translate-neon.inc.c |  3 +--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index ec3a92fe75..593f7fff03 100644
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


