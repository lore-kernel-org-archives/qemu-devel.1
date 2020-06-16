Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550C3C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 00:51:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2166C2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 00:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgcfaX/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2166C2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkzpU-0008Ky-CJ
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 20:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jkzoU-00072Z-G7; Mon, 15 Jun 2020 20:50:54 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:32969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jkzoS-0006Hg-Ok; Mon, 15 Jun 2020 20:50:54 -0400
Received: by mail-pj1-x1036.google.com with SMTP id b7so516606pju.0;
 Mon, 15 Jun 2020 17:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=hxP9ej2HA7Ca9A4VfaY9B/rkx3hEHxCpnwcLDTwk8qs=;
 b=SgcfaX/PxBu0wNC2mK0gysNd4GmAxkvU40AMjtURSp9RDQHWpDQSQ9blEQ7s/n29cE
 a0lRRxOi9b2AlwbmaAyhvOO/S+E6OyIXPGrox1/hj/TANSSD3lZL3LOsch4+GNEpPlqz
 MItK6abhCyWLLYurQVaHl9BULG+zWjvKTZYI1XloBOm6VXOtuv8mEgBAfzeQB7KXuksr
 gZTz1+INP43GYwrSl++/9GYpgd2mLaCKfliEuRqurZ5pYTjqUlrI2y8SwLs9+E2j7M0D
 xAe76FFIqtQrjOwEucKBIodHpjfNYRHX4xZ6XwHgsRJqAlcROfYSVEEFYpeGAzXam4g7
 5RWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=hxP9ej2HA7Ca9A4VfaY9B/rkx3hEHxCpnwcLDTwk8qs=;
 b=Qrt6SwfQLaVZUAFm2zDSGnpV/YNASUK1P9fBn4qT3PPx9CILk+CiFtTDGC/uo/HjU8
 rhtLVpjZzkq49r7wlJerVi6+uiammOW7+TULCXZXwb321N2+axW7aiM7ikneaAR8ha9t
 XcMsE6LDvy8ddeMl8uv+QhfB7aH76fmPQ6AbY5Uzxs6GOedwB+uX9O6pfVzBiZV6vzhV
 1Kuh4nYd3bMZNOuHf0dkFjA9N6h00yzeZ8OxwE0oiplK1EED5DMfZRwvgwxxeVQX5ivY
 MxSbjtKqG1c+JMeuBD64bEH0aMajdR69PJEdNv/p8WYgKqKQYsVZEC0GILCmuR0Qj9PG
 cL1Q==
X-Gm-Message-State: AOAM5332KZNnH7OIkLPXIoQf6SH0p+Hn0MJ8UQVZTYbMVd3oPApSdD96
 A7bDm5a4f/SUalvXPwccOa0=
X-Google-Smtp-Source: ABdhPJx3j0AnOKg6YoBNRoHiN2Sp313Jz9cEpwIEEbAHcYHNIbUsDsFH40AoArareEUWxdKackLfyg==
X-Received: by 2002:a17:90b:4c0b:: with SMTP id
 na11mr309392pjb.176.1592268650040; 
 Mon, 15 Jun 2020 17:50:50 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id i20sm15210539pfd.81.2020.06.15.17.50.49
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 15 Jun 2020 17:50:49 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 0/5] hw/riscv: sifive_u: Add Mode Select (MSEL[3:0]) support
Date: Mon, 15 Jun 2020 17:50:36 -0700
Message-Id: <1592268641-7478-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1036.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

This series updates the 'sifive_u' machine support:

- Change SiFive E/U series CPU reset vector to 0x1004
- Support Mode Select (MSEL[3:0]) settings at 0x1000 via a new
  "msel" machine property
- Add a dummy DDR memory controller device

With this series, QEMU can boot U-Boot SPL built for SiFive FU540
all the way up to loading U-Boot proper from MMC:

$ qemu-system-riscv64 -nographic -M sifive_u,msel=6 -m 8G -bios u-boot-spl.bin

U-Boot SPL 2020.07-rc3-00208-g88bd5b1 (Jun 08 2020 - 20:16:10 +0800)
Trying to boot from MMC1
Unhandled exception: Load access fault
EPC: 0000000008009be6 TVAL: 0000000010050014

The last big gap for the 'sifive_u' machine is the QSPI modeling.

Changes in v2:
- Drop the already applied patch 01 to 11 in v1
- new patch: Rename IBEX CPU init routine
- rebase on https://github.com/alistair23/qemu riscv-to-apply.next branch
- rename SiFive E/U CPU init routine names

Bin Meng (5):
  target/riscv: Rename IBEX CPU init routine
  hw/riscv: sifive: Change SiFive E/U CPU reset vector to 0x1004
  hw/riscv: sifive_u: Support different boot source per MSEL pin state
  hw/riscv: sifive_u: Sort the SoC memmap table entries
  hw/riscv: sifive_u: Add a dummy DDR memory controller device

 hw/riscv/sifive_e.c         | 10 +++++----
 hw/riscv/sifive_u.c         | 51 ++++++++++++++++++++++++++++++++++-----------
 include/hw/riscv/sifive_u.h |  7 +++++++
 target/riscv/cpu.c          | 20 +++++++++---------
 4 files changed, 62 insertions(+), 26 deletions(-)

-- 
2.7.4


