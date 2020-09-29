Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3ADC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E5E20774
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eNGb1N34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E5E20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLMZ-0008FC-HL
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKxh-0004y6-Ae
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:06:53 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:39606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKxe-00028c-SG
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:06:53 -0400
Received: by mail-pf1-x435.google.com with SMTP id n14so5524647pff.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rkiw3APuABfBa23cqFC0hN5yY79R/Z9co/HW0WOplcA=;
 b=eNGb1N34raAWMu2HV/a229Z+JV71Bc/ZSocmQTFiaC1WjeG9yGvuxSjhuGDJTkwdk6
 Ccen7KnSk4He7QwUAJwJ+tV7aZ0adjtm3EOJmwRE6nqJ7fb8Y7EXBDbcbhmZquU6kLV6
 EsII+xQe9UjmO+40usx9ZXIJ563FlJdSoN+Xk/9H+usDGkDxBRngoi701S6Epnwv8h4N
 pMc/qHWvUloCwT/DMf5lDhoGfxqbW9BGrcx59sDMgdWxH9Jfr3j7d8HXVC2cb/hjajgc
 cOYrUSSuuJfHlZWbQijblcaerZ8opto9DmP0ylIWQiVKS7FCsr2xhhQqhZ38fUPO7sCA
 Bshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rkiw3APuABfBa23cqFC0hN5yY79R/Z9co/HW0WOplcA=;
 b=bs4mMjyTNPDYCY3c6u7K21WuHeLuZ3K8sNgHgIS3Bz776/h0V6XqeE6wew4VYC3elN
 IcG6RgYZcNHHcUaPIRybvBIeSaheURLeLERbuJwzHmbMSdZizazc97lXoAkzjm+7f5m8
 qgQFcfGDf7UWDfVd94sOPa8k3KSstWAeYntErRKDtRPoPNrH5Rw+vReBVzHefwZ2d2ci
 cjqOMkf/yxcrT7Z9A5+tWjtT1f8BtpUfrTkqU8kePxgsKMt5tn7NEn9GrxaaFWsqxuQT
 pCprgUwJDq8fIsXJ/iRM7EupQU5UydENgactMQoe8UHwHbJoDM4fy57dGfgW2YHM16bI
 Ycwg==
X-Gm-Message-State: AOAM53296fioRCG4khO+ZT2C5he/juBGab6yEQ6rLKhb3WsqUwXKUL+Q
 S5LDJoJojAcvGzo2+F0FOC52XLc3/o+swA==
X-Google-Smtp-Source: ABdhPJxXXSdEe8OvyccLtqdyQlEKclMepHBMRcuHgLvEevw3I/qc0WHkhg8EDIT8Uw6rCIfvgDb3rw==
X-Received: by 2002:a63:5d09:: with SMTP id r9mr4046641pgb.397.1601406409487; 
 Tue, 29 Sep 2020 12:06:49 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:06:49 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 27/68] target/riscv: rvv-1.0: floating-point classify
 instructions
Date: Wed, 30 Sep 2020 03:04:02 +0800
Message-Id: <20200929190448.31116-28-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x435.google.com
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
 target/riscv/insn32.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6c95a3460a..958914458d 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -561,7 +561,7 @@ vmfgt_vf        011101 . ..... ..... 101 ..... 1010111 @r_vm
 vmfge_vf        011111 . ..... ..... 101 ..... 1010111 @r_vm
 vmford_vv       011010 . ..... ..... 001 ..... 1010111 @r_vm
 vmford_vf       011010 . ..... ..... 101 ..... 1010111 @r_vm
-vfclass_v       100011 . ..... 10000 001 ..... 1010111 @r2_vm
+vfclass_v       010011 . ..... 10000 001 ..... 1010111 @r2_vm
 vfmerge_vfm     010111 0 ..... ..... 101 ..... 1010111 @r_vm_0
 vfmv_v_f        010111 1 00000 ..... 101 ..... 1010111 @r2
 vfcvt_xu_f_v    100010 . ..... 00000 001 ..... 1010111 @r2_vm
-- 
2.17.1


