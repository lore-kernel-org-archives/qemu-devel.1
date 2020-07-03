Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C4BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 03:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBDE208FE
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 03:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5CAxro7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBDE208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrCEU-0000xG-My
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 23:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrCDQ-0007nE-Jr; Thu, 02 Jul 2020 23:18:16 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jrCDO-0005we-PW; Thu, 02 Jul 2020 23:18:16 -0400
Received: by mail-pl1-x643.google.com with SMTP id g17so12090010plq.12;
 Thu, 02 Jul 2020 20:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=yf+OmVTyoq3hsfua6BQiiX83ycjNeMc4v1oMFR0Jn3A=;
 b=q5CAxro7m871sAotJ0qjT3af6DkY+Mek4EeFylFOAHw+GRit221uXMgDbf2/PO1HDS
 O3tpsaes+qTgUJxaZmc/6pOnlm7Qes3GquvpABCn9fJxQ2Qo8TQrdW/PZHJULsQqAtkt
 gVerciQyL+mIwMjORNSuIxhLfk/4p1DCiv13I2zof04gp7TScSmn1ZeIyQf1G//aKRC2
 0LICu8WWjHA/hiY4cHPf7ZTOqrG5ejxrfdANk/7Zn6AHHdpD/Vx/0rfmw11m6uHga9eD
 YjMrXXTU3v6jixtHT+v3U/REik3VZQrU6KzkQ6KcKzeiPfYVYccD+lEXp3LFsd3AdpBR
 JE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=yf+OmVTyoq3hsfua6BQiiX83ycjNeMc4v1oMFR0Jn3A=;
 b=IzeS2Z2AzKnZU4yehM7bOjm5U9knEm0NHBAydgG76ZAIR6eMCbEunzVqHEwXCrdAwo
 tXJ8wCCJqF5sYsbeaxNwUzBfUjae92W9o7YMggph2+4g/aYYj6UelUxhjYUAAJzvpeVD
 7COIODIRr+5XPhyElOzpnGuvq0PlBePeEmvNoRvMe1fjsDWi1AwjQLcEmvWb4J/Kg0wp
 2zQlS//y7VVHhkM31kzrgoD2To+WpO1I6w55pU04aSTyq6RXDEhbPuQmPGmdhis+ZXUo
 8ksPM0COL5jhoepgBSpRhq0XaZC/fAVUT2QSBYk3l/3M5RpEap6x4xMlXmbZdoRIiyGu
 ZYog==
X-Gm-Message-State: AOAM530Oq3Y9/GnqcTnjOF1OPz+MDakk8p1u00rF0lRJWWsJvzL3g/3c
 I4ZCjSLIfbA8VBis7dohI9g=
X-Google-Smtp-Source: ABdhPJw92VSMSrDX9X+Jqtyqt3bE+NNtMW7iktpaeUt4UaPE9qQeK+J/BmBIMkcB9Q/fbkgS/NxCTA==
X-Received: by 2002:a17:90b:1881:: with SMTP id
 mn1mr34007337pjb.198.1593746292882; 
 Thu, 02 Jul 2020 20:18:12 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id c12sm10165745pfn.162.2020.07.02.20.18.12
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 02 Jul 2020 20:18:12 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 0/7] riscv: Switch to use generic platform fw_dynamic type
 opensbi bios images
Date: Thu,  2 Jul 2020 20:18:00 -0700
Message-Id: <1593746287-19251-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x643.google.com
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
Cc: Anup Patel <anup@brainfault.org>, Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

The RISC-V generic platform is a flattened device tree (FDT) based
platform where all platform specific functionality is provided based
on FDT passed by previous booting stage. The support was added in
the upstream OpenSBI v0.8 release recently.

This series updates QEMU to switch to use generic platform of opensbi
bios images. With the recent fw_dynamic image support, let's replace
the fw_jump images with fw_dynamic ones too.

The patch emails do not contain binary bits, please grab all updates
at https://github.com/lbmeng/qemu.git bios branch.

This series is rebased on Atish's fw_dynamic series @
http://patchwork.ozlabs.org/project/qemu-devel/list/?series=186980

Changes in v3:
- Change fw_jump to fw_dynamic in the make rules
- Change to fw_dynamic.bin for virt & sifive_u
- Change to fw_dynamic.elf for Spike
- Generate fw_dynamic images in the artifacts
- change fw_jump to fw_dynamic in the Makefile

Changes in v2:
- new patch: configure: Create symbolic links for pc-bios/*.elf files
- Upgrade OpenSBI to v0.8 release
- Copy the ELF images too in the make rules
- Include ELF images in the artifacts
- new patch: Makefile: Ship the generic platform bios images for RISC-V

Bin Meng (7):
  configure: Create symbolic links for pc-bios/*.elf files
  roms/opensbi: Upgrade from v0.7 to v0.8
  roms/Makefile: Build the generic platform for RISC-V OpenSBI firmware
  hw/riscv: Use pre-built bios image of generic platform for virt &
    sifive_u
  hw/riscv: spike: Change the default bios to use generic platform image
  gitlab-ci/opensbi: Update GitLab CI to build generic platform
  Makefile: Ship the generic platform bios images for RISC-V

 .gitlab-ci.d/opensbi.yml                       |  28 ++++++++--------------
 Makefile                                       |   4 ++--
 configure                                      |   1 +
 hw/riscv/sifive_u.c                            |   4 ++--
 hw/riscv/spike.c                               |   9 +++++--
 hw/riscv/virt.c                                |   4 ++--
 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 0 -> 62144 bytes
 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf | Bin 0 -> 558668 bytes
 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin   | Bin 49520 -> 0 bytes
 pc-bios/opensbi-riscv32-virt-fw_jump.bin       | Bin 49504 -> 0 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 0 -> 70792 bytes
 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf | Bin 0 -> 620424 bytes
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin   | Bin 57936 -> 0 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin       | Bin 57920 -> 0 bytes
 roms/Makefile                                  |  32 ++++++++-----------------
 roms/opensbi                                   |   2 +-
 16 files changed, 35 insertions(+), 49 deletions(-)
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
 create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
 delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
 create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf
 delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin

-- 
2.7.4


