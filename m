Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6428C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7168C20771
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gS96TwDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7168C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhTs-0000Gv-L4
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHB-0003IX-7H
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhH7-0003JP-97
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id v3so12682975wrc.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=vCRlIZ7cqAXG2v+VfE7BrmBrtfArLobRZmrL/chqA/A=;
 b=gS96TwDWMAs8e1l1VaynySl7FRjOlMFCHHP1HcP4ugKcY3GHtxzFFJU25RCeE4z5Ts
 v+rnKMiP9kzMad9sqgN2dEHFwoN7egAxl8K3gcVzfpu+y/vBm4LNk+xQ0Kc14Txc2cAe
 3lG7WpiH2OksaF0CNFbnQabJtGDpyke60TSv+2PIEW69LucqxEDTea3FzDHnzREW92uM
 rLOnWCmwlo32EyH6S4NHcO1Tnhc5GNwCv3oBRrtgt41rrR/GJFuHTei+nys1Y6/Wc09D
 LhS8ViCaBIQWA4wFKzc9sDO+ucyb5lRM1vujl3I0IF09p6JXi4kDoX9u4gs4RME8DlGJ
 ROvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vCRlIZ7cqAXG2v+VfE7BrmBrtfArLobRZmrL/chqA/A=;
 b=tJ7bfdJUGOqZmbNJodnQCJlF/fN8fIffApPp1upRw65m8d7jNB59MYJnKbbPMACjaf
 s5Lp/m7GuoXdaKdVqE9YxXAScXIJcqvFnVh0R3cRibFeZ+AhMVPgEq6Y1Gwtia2sG6ym
 wr7sbGNfKknFvdoBq2rcEOLu9D8iw/KsZU7CKoIgymqIdUqTxM30qxWw57DNnqpdVgAD
 bGlG1k3k9gcdUgtL3C8sAal7C0BUx7/Uqp50s0t2VrkTlZlyoH2SU/Ir1T3/e85LX2B+
 /JR5dB/S4UQn6oTV2S/dJ9cWhqGaTVJfO5+dzso9qiHQ+1urk+0E7WjCccTsnUnfu57v
 t+aw==
X-Gm-Message-State: AOAM530ZyJewlRlqDXEZ2gire3KFyWJaMlVg2HFp3kRiMW6IpL+znBv9
 QkXAL04Hs9nz8VhcUoIj5FWGUzLaDGqepg==
X-Google-Smtp-Source: ABdhPJxjB3+ZE4tz/B9jtbVnpFwGFbtH1qXmO/VZgP5ebGn1KhyvgT6LukfQmYdXzZql9gIHwIGepQ==
X-Received: by 2002:adf:ff83:: with SMTP id j3mr24873176wrr.264.1592912375626; 
 Tue, 23 Jun 2020 04:39:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/42] target/arm: Remove dead code relating to SABA and UABA
Date: Tue, 23 Jun 2020 12:38:47 +0100
Message-Id: <20200623113904.28805-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

In commit cfdb2c0c95ae9205b0 ("target/arm: Vectorize SABA/UABA") we
replaced the old handling of SABA/UABA with a vectorized implementation
which returns early rather than falling into the loop-ever-elements
code. We forgot to delete the part of the old looping code that
did the accumulate step, and Coverity correctly warns (CID 1428955)
that this code is now dead. Delete it.

Fixes: cfdb2c0c95ae9205b0
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200619171547.29780-1-peter.maydell@linaro.org
---
 target/arm/translate-a64.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 12040984981..4cef862c415 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11370,18 +11370,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                 genfn(tcg_res, tcg_op1, tcg_op2);
             }
 
-            if (opcode == 0xf) {
-                /* SABA, UABA: accumulating ops */
-                static NeonGenTwoOpFn * const fns[3] = {
-                    gen_helper_neon_add_u8,
-                    gen_helper_neon_add_u16,
-                    tcg_gen_add_i32,
-                };
-
-                read_vec_element_i32(s, tcg_op1, rd, pass, MO_32);
-                fns[size](tcg_res, tcg_op1, tcg_res);
-            }
-
             write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
 
             tcg_temp_free_i32(tcg_res);
-- 
2.20.1


