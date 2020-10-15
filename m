Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46C7C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3458622210
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0drZSfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3458622210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5zb-0001Io-6j
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT5xn-0008NK-Dr; Thu, 15 Oct 2020 12:18:47 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:46111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kT5xl-0005PJ-LV; Thu, 15 Oct 2020 12:18:47 -0400
Received: by mail-ej1-x641.google.com with SMTP id t25so4402297ejd.13;
 Thu, 15 Oct 2020 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xOi6udjgz0JwJO/WEcAmWIX4jLmkdSG7Qe4LLaXgX04=;
 b=S0drZSfN1poQ9Ol3TDXnL1YE54MFlJu5w0uXFo7XjQqBnLN4NXSqL0HMuB8WNvV9ye
 a/k9jc3SAYkXu1txnbv1s5pDhQUZWsffy80YJfe9DHVfRRxZ5psJ5vgWTYuY5b9mmJ+1
 97u8qEhUdM4Bd2Os9Q+kNNG5uWAoQ/QstFt20/bGESpf0Du5Q2XPipGVMjrqSBR0qdsq
 Cso8FCd8nelEw+Ry2P4pSravA7m/Xy6bqTOWhXmbGbCeCw06AckdMlckyYJSSxZxB7pK
 +CJGis9F2OcUJelBINr8exbf6Paw6qHlotRlJ1BJlqUrLQtZY7L7Nbi/d9GcMy6nNRxu
 HGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xOi6udjgz0JwJO/WEcAmWIX4jLmkdSG7Qe4LLaXgX04=;
 b=FgBsXoeLMw3Slen9LoNNvdhSKF649PVg5pucNtvqfq/FVWQs4wgsrv5uQaIztRA358
 cJOuIFPGGFZhqNeWv+kEaV16jyZRhA670BRbTsITjn75YJ+L56XhnE852Oj+zepynhtA
 FfnHmeyI1HdkNVQ2nkfs9yus7X5rDNt0g6UwR6BBqNopCzvSrjTlkkdmh8Tm8TjEc0jT
 xd3/fsfd/8sHNwS0gH6Egwqh6EEZnsXr5zmHFvW7J4keOVbytMYHgKBgNw3WTy7cCqAn
 TZiAPXcFSB+PCZdOCm35UMJwE3u0QUSMscHYb8412fVbnRAeIKfbXEHMJ+OqkjXPfaMg
 yEYw==
X-Gm-Message-State: AOAM531LDIhpKcC6XaMoIP8uzN0RXzYxvGTFW6KEmoUMNLDdtXdK2T0T
 CR4GK4bY2D46+LfabJQRwxk=
X-Google-Smtp-Source: ABdhPJwAlgPa39YecEFRlumLF3FpFUvpfn74gumIUiEia748h4gG8hJi93C88apUPKU8v/P4tLnTyw==
X-Received: by 2002:a17:906:2bc5:: with SMTP id
 n5mr5180875ejg.476.1602778723426; 
 Thu, 15 Oct 2020 09:18:43 -0700 (PDT)
Received: from neptune.lab ([46.39.229.194])
 by smtp.googlemail.com with ESMTPSA id i23sm1861005eja.66.2020.10.15.09.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 09:18:41 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH v2 0/5] RISC-V Pointer Masking implementation
Date: Thu, 15 Oct 2020 19:18:33 +0300
Message-Id: <20201015161833.17107-1-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x641.google.com
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

Hi all,

This patch series adresses comments and suggestions from v1.
I hope that I managedd to address all of them.

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

 target/riscv/cpu.c                      |  24 ++
 target/riscv/cpu.h                      |  32 +++
 target/riscv/cpu_bits.h                 |  66 ++++++
 target/riscv/csr.c                      | 277 ++++++++++++++++++++++++
 target/riscv/insn_trans/trans_rva.c.inc |   3 +
 target/riscv/insn_trans/trans_rvd.c.inc |   2 +
 target/riscv/insn_trans/trans_rvf.c.inc |   2 +
 target/riscv/insn_trans/trans_rvi.c.inc |   2 +
 target/riscv/translate.c                |  49 +++++
 9 files changed, 457 insertions(+)

-- 
2.20.1


