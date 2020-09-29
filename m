Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EABC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38CC20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UJPgziaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38CC20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLTe-0000Ju-VQ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyj-0006aD-Kr
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:57 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:38855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyi-0002Kj-0D
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:07:57 -0400
Received: by mail-pj1-x102f.google.com with SMTP id u3so3180536pjr.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ixyI25Op3UHIzQVDkZuN65LzcuGaVJwh7enn2EMY8MY=;
 b=UJPgziaPA2ImJGp5jiwHyxecAiA3RNTInVrU1A4nWJavYiUbei3ESo7YfyZ14ZjlfK
 djXr+qsHtRMSk7ETbdDwuKMoyBEfhYoDj1+l2k4fz0fu/CymvIOvypW7LP1erHv96yma
 lqIjFS+7by1lWmVGRDz3whjvUWeKQUM05bGH1c2QTRjCrodlSOi40emBStVjbGEKo0qB
 bnq6w7AgkuQ6RgkHR0ye/expAuDz19gEvagoc0dg/xmrTV87N+qxBf8zCb7OzGCzAYz6
 mDzE+bx4gaL79ZN3vUH99zI3xxjTtgULfl8aJNM8NNKjZ2Ee0Qzl2DjGphkl9dPd/JIW
 j/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ixyI25Op3UHIzQVDkZuN65LzcuGaVJwh7enn2EMY8MY=;
 b=TEKOd9BztplbnoZfJGbcaxTVR18UN/esZKBsDViKJBzaKU5gjVnqSBNvQpAGzSyUf0
 L9em6v6ae9HXkuKu2JOLsoc61tLfTNHRZndlm225QUvp1fZ1Ke7Y9gcQvTxQZMC2SV1Y
 vBMo0TRaqfxDFCKbad+MwrJXjHkAVd4K/xGQ5I75u5DbZjq1gCQgc/AZkiSMyeBy4Q74
 2NC5KJF+mhk6qZ/fk1gOYztz45bdKzIbA0FrDT8G32z4ASQ1EyDuXXMu2Zy5i18LTjzR
 AbAd0B4Qn63IVIW09C60K6aeFcYWzOJUAP21ijM1yvR2BvPgMGLxvt3OQHMpe3IfpQqT
 AWKg==
X-Gm-Message-State: AOAM533WdBID5Gd5npP6V4O918+xzCuob0rTklBx3TMzeypDk9GZlWs3
 5QXQNfNVQFcl2xpi9+4KdzP79P1W2rCfyA==
X-Google-Smtp-Source: ABdhPJy5njKl2XEwmYqGhbSE3b3X3KPrbycmmmUVrGmQ55+LiXpsqriQr5NoP3YM1edcWcHHyRblwA==
X-Received: by 2002:a17:90b:1050:: with SMTP id
 gq16mr5464581pjb.234.1601406474460; 
 Tue, 29 Sep 2020 12:07:54 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:07:53 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 44/68] target/riscv: rvv-1.0: widening integer multiply-add
 instructions
Date: Wed, 30 Sep 2020 03:04:19 +0800
Message-Id: <20200929190448.31116-45-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn32.decode | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 4517f8ed54..c75d728fc5 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -449,9 +449,9 @@ vwmaccu_vv      111100 . ..... ..... 010 ..... 1010111 @r_vm
 vwmaccu_vx      111100 . ..... ..... 110 ..... 1010111 @r_vm
 vwmacc_vv       111101 . ..... ..... 010 ..... 1010111 @r_vm
 vwmacc_vx       111101 . ..... ..... 110 ..... 1010111 @r_vm
-vwmaccsu_vv     111110 . ..... ..... 010 ..... 1010111 @r_vm
-vwmaccsu_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
-vwmaccus_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccsu_vv     111111 . ..... ..... 010 ..... 1010111 @r_vm
+vwmaccsu_vx     111111 . ..... ..... 110 ..... 1010111 @r_vm
+vwmaccus_vx     111110 . ..... ..... 110 ..... 1010111 @r_vm
 vmv_v_v         010111 1 00000 ..... 000 ..... 1010111 @r2
 vmv_v_x         010111 1 00000 ..... 100 ..... 1010111 @r2
 vmv_v_i         010111 1 00000 ..... 011 ..... 1010111 @r2
-- 
2.17.1


