Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EEDC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0D422267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 07:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKbu9XDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0D422267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVQb-0003DG-0s
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 03:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVFr-00012M-6n; Thu, 22 Oct 2020 03:43:23 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:45203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVFn-0007cF-FH; Thu, 22 Oct 2020 03:43:22 -0400
Received: by mail-lf1-x142.google.com with SMTP id r127so1003165lff.12;
 Thu, 22 Oct 2020 00:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8ARzpJg8p5t8932EqX1FVkuQXZUB7UQJa9J/tgPPydA=;
 b=nKbu9XDUOCmGOIZom/WY6fOC8ohoQi4OpdTnQ19FQG8ccPnxpEwU27SUnVuI0QE/iy
 E/aLZdEN9bJ0qg5QnZ9FrM5tZCwo0gN9xjspwSKe124ZAF+8LmDtQfolYTcySmvVHPHr
 0plpgLILP1a/43r7D4Eq6gY/tTJUi2I/J7cMCVWN3UUpsxdr4HxEMUd13yFMvxvw+wJP
 4yfAmIvvO49bCciZZMAC1MquNSeGUqYbPchUMkWolC+MWYrjktUvAwUMpYahOmJ/B9ra
 Zkpwc9Xu1wJxRPyPxTCxPcRftPuUZH1+3ftgRY52Q/SxlJMxSZyN9gJHkr6omNDHDCj/
 E+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8ARzpJg8p5t8932EqX1FVkuQXZUB7UQJa9J/tgPPydA=;
 b=PUVnRysO/kQ4YzsoUQ5hf+LCchtzC/97xVE4sPewa338BLOxpYjAC+t2DoUFBFL/TC
 fFlAe7ey7d+rfbcypaOdyMgn63WnFA7b8xDdooaYPf3dF/P3Vv/lnny3GP8zNMUzCh1p
 9jNQl8B3oyYkBcBVanEn3VxFK/1ojm3Ko8eQyV0ZKV4Bm4hIZ14f/POe3wJQkDooUj9c
 4lcDkS8OumE3seAXOJAX9yaXrycvoVzer0oGbafZoVg9MFN0W718y4HKkR1Yu4evkxlt
 xXWKcnBXcjC0xpRMXUbWQGO0cDtvE849FvmqANAxnDrRvZM7myWrDkU7GcG0fvpK6EDf
 tAyg==
X-Gm-Message-State: AOAM533NSUGmoNTdYTEcoI1cwiTw1s/XSs3eWtafJ6vrWHIaTb1+VWQz
 vgTsMVJZ1tgSlN8Zyr5Ltks=
X-Google-Smtp-Source: ABdhPJzJl5irWc9omFz8ShfR8hjYS5zKpCR0vzTReN16P4RSTXFwSFcdg4CijNaQoaLkZxec9Auo/A==
X-Received: by 2002:a05:6512:3455:: with SMTP id
 j21mr443821lfr.135.1603352595237; 
 Thu, 22 Oct 2020 00:43:15 -0700 (PDT)
Received: from neptune.lab ([46.39.229.104])
 by smtp.googlemail.com with ESMTPSA id n19sm138887lfe.142.2020.10.22.00.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 00:43:14 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH v5 0/6] RISC-V Pointer Masking implementation
Date: Thu, 22 Oct 2020 10:43:03 +0300
Message-Id: <20201022074309.3210-1-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x142.google.com
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

Hi,

Addressing Alistair comment: J-ext enabling patch is now the last one in the series.

Thanks

Alexey Baturo (5):
  [RISCV_PM] Add J-extension into RISC-V
  [RISCV_PM] Support CSRs required for RISC-V PM extension except for
    ones in hypervisor mode
  [RISCV_PM] Print new PM CSRs in QEMU logs
  [RISCV_PM] Support pointer masking for RISC-V for i/c/f/d/a types of
    instructions
  [RISCV_PM] Allow experimental J-ext to be turned on

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


