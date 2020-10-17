Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF25C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 07:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500A720758
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 07:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBBfRUoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500A720758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTgPC-0003uK-Eg
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 03:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kTgNo-0002Hv-Hj; Sat, 17 Oct 2020 03:12:04 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kTgNl-0003jE-HH; Sat, 17 Oct 2020 03:12:04 -0400
Received: by mail-lf1-x144.google.com with SMTP id c141so6297692lfg.5;
 Sat, 17 Oct 2020 00:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vOeD1SsNjpDDLo35ky18Kh1cJqNQOVwmY1R5PyR3Na4=;
 b=NBBfRUooJaynqZ+JIgdZNh9oTi338NgvU4VXtKReMB7RMLD8LW5KMIm5WxIHh0f2Ir
 tJ8RQD4de6XDXV2CxYeLUlqrJ+C41cGTEw0lQ49I6KFOva62wT9Q6xuad0ZXs0RYu9Cq
 SS8NtXTO9r/X8MfE20aTNDR2MIAimEsG28PN6Z43epah5KLwDQ7NH+Roh1nkwNL1e9Cs
 jhuJE/qUN3Xd3ZN36ln1KQ1Y1ZZNR36Ox9WnKmYUvG1QPedEeBAHPVtRwvEol9X1JBF1
 q0+7quGp8XmDGV0RRHIROHX8OIEUZc1H/fno7Gwy5UWy8WdhdEgOUSjzjNjV7MciCRP0
 nNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vOeD1SsNjpDDLo35ky18Kh1cJqNQOVwmY1R5PyR3Na4=;
 b=f4cjFI0VTkIX0p2kVp9arTDfcXsOOe6QSj1OfiE4eMzqHBR7S44x8lPL5QB+6YL7lf
 CiAP1qMKjqaHe8D8/2nikiZtgdcluQ2D1OeDYTcumuMKON1qQaMDuq5DU15rYxW0R/Me
 FjJvEIgp5mMvILzwZlrkz2s2hY2aGngQZYeVf3kCWLTz74CXV4M1fvavEBNRDSlDcEtz
 hXmXaHaCnbcAqsLB241Y29XUko6lqphg93K1QVXdmyZTfNP0stscCEiI9uXCdaMd7mco
 z5GwSNsgI+NFubEnvGOvE9qvqT+Ks2UeMpn7ZBQrN/RtZ9TFYogMKfu6wbpb++5mzzvw
 btmA==
X-Gm-Message-State: AOAM530O4jpBuklpTV5yu7IbQf0cBU8q323EixdcVvLg2FbqRaIw8LQC
 aq9Eudx55ezseIrshpBu/4M=
X-Google-Smtp-Source: ABdhPJwJknsMyZm+oC2S4E2QcJ1obXEQ1ZBK4vDD4JxYDXAkjoOfzNhkZPT7esFrnIHQskhT7qdK3g==
X-Received: by 2002:a19:3f06:: with SMTP id m6mr2621236lfa.25.1602918719026;
 Sat, 17 Oct 2020 00:11:59 -0700 (PDT)
Received: from neptune.lab ([46.39.229.194])
 by smtp.googlemail.com with ESMTPSA id 184sm1626905lfh.232.2020.10.17.00.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 00:11:58 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH v4 0/5] RISC-V Pointer Masking implementation
Date: Sat, 17 Oct 2020 10:11:49 +0300
Message-Id: <20201017071154.20642-1-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: baturo.alexey@gmail.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, space.monkey.delivers@gmail.com,
 Alistair.Francis@wdc.com, kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi folks,

Addressing code style issues that were found by patchew.
Also big thanks to Richard Henderson for reviewing the series and giving great comments!

Thanks

Alexey Baturo (4):
  [RISCV_PM] Add J-extension into RISC-V
  [RISCV_PM] Support CSRs required for RISC-V PM extension except for
    ones in hypervisor mode
  [RISCV_PM] Print new PM CSRs in QEMU logs
  [RISCV_PM] Support pointer masking for RISC-V for i/c/f/d/a types of
    instructions

Anatoly Parshintsev (1):
  [RISCV_PM] Implement address masking functions required for RISC-V
    Pointer Masking extension

 target/riscv/cpu.c                      |  30 +++
 target/riscv/cpu.h                      |  33 +++
 target/riscv/cpu_bits.h                 |  66 ++++++
 target/riscv/csr.c                      | 271 ++++++++++++++++++++++++
 target/riscv/insn_trans/trans_rva.c.inc |   3 +
 target/riscv/insn_trans/trans_rvd.c.inc |   2 +
 target/riscv/insn_trans/trans_rvf.c.inc |   2 +
 target/riscv/insn_trans/trans_rvi.c.inc |   2 +
 target/riscv/translate.c                |  44 ++++
 9 files changed, 453 insertions(+)

-- 
2.20.1


