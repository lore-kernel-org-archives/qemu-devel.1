Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215EAC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68D5E22267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 08:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPRtHXpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D5E22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVVbq-0001Q2-An
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 04:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVaY-000870-V1; Thu, 22 Oct 2020 04:04:46 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:37059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kVVaX-0006su-7U; Thu, 22 Oct 2020 04:04:46 -0400
Received: by mail-lf1-x144.google.com with SMTP id j30so1110745lfp.4;
 Thu, 22 Oct 2020 01:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z+NfY8aVGlMJqARH9WMsBcDgAzwTThmmJiicXC1vCYc=;
 b=lPRtHXprLgs5b2jHZB63A6gL8DrSmScND3YuORQmgmNMIxonKzkAw4EwWTc1Wwn2hp
 U93X6Z3gAu2vxhyUyWxRRLNx39XCIh72vtjVJMizqfk7co0aSybK/cIyogrKKHO9gig8
 1fZFfejLIe8rLVT0XDn/eVGUpgZa0UZ8R+O15M2cmcJZ8FFMrPeks9KC+XU+EJ47Tj1f
 Ah3EBzq9PKZ3hDxzh6OQqoKtn26w7u4qwgexWWDbIdZslhdej+SwZhF61Z6ZPUtwgJNo
 lRT5LhcvYH1KKdekDSZt0pJ09yJSnGSn29/N4L1aZr+Oehgli7HuxNs9p8dQRgF0ItUk
 t7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Z+NfY8aVGlMJqARH9WMsBcDgAzwTThmmJiicXC1vCYc=;
 b=PuwnDQmxOV44M/thADQegvOCpAQlhsJ/1tJNM9bkk17eHssJ8NXWC1J8ljC9h5emAh
 wd2FXqQzdxqrkh9dm1ob/wjMdueNerkGwcz4ZjiK2YqmSpZkmphrKdwLNkgkBm3ayiYa
 c4Xc1O8eHSndO9KzO/rE5ZEmv2r7qUY3yU/uuylUZS9f6LAdJgGIDT4ZRXMTY6DKVKAG
 egNtn6lEfKkD7KHsUeJLF9DiURpEnxmcxv1nFSIVrhljFdmCNJajmEabHAb5P9K5o0AS
 NgtEfZwwlpwGZzwSR593JGQSRQAVtHWE8xKGlzHf4WcrMLyVTuqQDyzFKvU+2OzMBwn5
 Ldxw==
X-Gm-Message-State: AOAM533jxel1x55fYiW9a/3CsyfHvsz7fSLMqtkCdG6eBuvd//Oi5P4E
 3pzy5c7x1QF0ik2jgLFH5S4=
X-Google-Smtp-Source: ABdhPJyLoVe5DQvoS0R+NmcNxo1HiDjPYyY/tY/HQ3uP3qcu+oefCJZmmqCsdDAe8ZnEpJtEOfUUaQ==
X-Received: by 2002:a19:4c45:: with SMTP id z66mr404030lfa.168.1603353882964; 
 Thu, 22 Oct 2020 01:04:42 -0700 (PDT)
Received: from neptune.lab ([46.39.229.104])
 by smtp.googlemail.com with ESMTPSA id l8sm143682lfk.203.2020.10.22.01.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 01:04:42 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH v6 0/6] RISC-V Pointer Masking implementation
Date: Thu, 22 Oct 2020 11:04:34 +0300
Message-Id: <20201022080440.10069-1-space.monkey.delivers@gmail.com>
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

Hi,

Added missing sign-off on the first patch.

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


