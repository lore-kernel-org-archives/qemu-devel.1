Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6077FC43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31592173E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUaQnseq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31592173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSkFa-0007tX-Gp
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 13:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSkBW-00047D-Nl; Wed, 14 Oct 2020 13:03:30 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:39853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSkBU-0000tY-UO; Wed, 14 Oct 2020 13:03:30 -0400
Received: by mail-ed1-x542.google.com with SMTP id t21so204798eds.6;
 Wed, 14 Oct 2020 10:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=92nNHGekcXjozElp8/v0sBJL6HAmOeJklotiQRx2fgQ=;
 b=NUaQnseqI6umX1GzsB96aYyBNvuzjrIygLTaWEaKHl5S8a8rpWhExAvuIykobz22TO
 ckmm+47wKJGTqQ2gbPSRitny6E+EdKs+dnL8GBh8pWPzBKsocHbEm6d31lMWdzIxCXIr
 g7MKGZbxu2vh/SYhtQ85N/YntTxy7xOc0G9aGZaxXdnOyhZk4oCzO/yRUzZRljnjA9CV
 uqs/ntYghmUDJ2lm9n9BhUKt0PvXNtum5o3BAPP1I64jmPwMgJleiDR5JhrfzzzlfmZe
 NK6+25THojWdBS77IJZu0bEqk609cYCo+cNL2eT4LGHdrr0k/oWvq7102xgqgMD1yymq
 mv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=92nNHGekcXjozElp8/v0sBJL6HAmOeJklotiQRx2fgQ=;
 b=PUNd7CfBX2uXOaEuYZWv35JzMwFDPvgMgdxE2395cH80El3hzs7hOZysbMJW8x3dQ7
 bFGygt+I35kxOL7yCWm35MndgfqdK0sap9C5iTirjM4cKN9Y4E0z+1eUXRcqBiEP7DxF
 fgJqxjaoMWdJnjLaluO+uFITYHwWMOiJJbXuzduQgFyNOmlh/pUPED+IFbmrQlww9BhP
 y1T372P4rp6rlm63UFT1L7fas0idM+qnvWcG0hGoH+A7176Ua2MV/6JL6rMcba71bTny
 23VZatjAeLCWk9NNMGUI5uAGOux8BgWpANa9eQPDC//P2pxMG0R4PDxbqul69dmBnd43
 s6cw==
X-Gm-Message-State: AOAM530I8xZllkEtoExEAWLGuigNlFpShOWmwOHtw09qTzxyuCdrzLLY
 oxlZVAFdxqudaSR+N5wML4O2ClXdbLFoBNYR
X-Google-Smtp-Source: ABdhPJyv+LorvONxX2+4OfPTae8mFrDlXG0zSmahZl7y5xynRxSRvNI2quLk6wBU8JS77FehYkbWDg==
X-Received: by 2002:aa7:d988:: with SMTP id u8mr6601312eds.64.1602695007107;
 Wed, 14 Oct 2020 10:03:27 -0700 (PDT)
Received: from neptune.lab ([46.39.229.194])
 by smtp.googlemail.com with ESMTPSA id c17sm2675ejb.15.2020.10.14.10.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 10:03:26 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH 0/5] RISC-V Pointer Masking implementation
Date: Wed, 14 Oct 2020 20:03:23 +0300
Message-Id: <20201014170323.27348-1-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ed1-x542.google.com
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

These patches implement Pointer Masking proposal which is developed by J-ext group.
This proposal is not yet ratified, but I hope QEMU implementation is done.
The proposal itself could be found here: https://github.com/riscv/riscv-j-extension
This functionality is submitted as experimental, as Richard Henderson suggested, thus there're some obvious issues:
- Introducing J extension is not the 100% correct way as I see it, but no Zname has been assigned and on J WG meeting we agreed to go with J ext for now
- CSR numbers for PM are not yet ratified, so they're subject to change
- No CSR have been implemented for recent hypervisor spec update. I didn't have enough time to get familiar with it, so I'll add it later
- No compliance tests for PM exist in RISC-V compliance infra, however in order to check it I did some simple asm tests(https://github.com/gattaca-lab/riscv_pm) and we have LLVM HWASAN enabled for RISC-V that relies on this PM implementation(https://github.com/gattaca-lab/riscv_hwasan)
This is my first QEMU patch submission, so please tell me if I'm doing something wrong.

Thanks

Alexey Baturo (4):
  [RISCV_PM] Add J-extension into RISC-V
  [RISCV_PM] Support CSRs required for RISC-V PM extension except for
    ones in hypervisor mode
  [RISCV_PM] Print new PM CSRs in QEMU logs
  [RISCV_PM] Support pointer masking for RISC-V for i/c/f/d/a types of
    instructions

Anatoly Parshintsev (1):
  [RISCV_PM] Add address masking functions required for RISC-V Pointer
    Masking extension

 target/riscv/cpu.c                      |  14 ++
 target/riscv/cpu.h                      |  13 +
 target/riscv/cpu_bits.h                 |  66 ++++++
 target/riscv/csr.c                      | 302 ++++++++++++++++++++++++
 target/riscv/insn_trans/trans_rva.c.inc |   9 +
 target/riscv/insn_trans/trans_rvd.c.inc |   6 +
 target/riscv/insn_trans/trans_rvf.c.inc |   6 +
 target/riscv/insn_trans/trans_rvi.c.inc |   6 +
 target/riscv/translate.c                |  77 ++++++
 9 files changed, 499 insertions(+)

-- 
2.20.1


