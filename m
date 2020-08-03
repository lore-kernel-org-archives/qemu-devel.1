Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0C0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF4D2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah80WN9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF4D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2UxG-000368-Lb
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 03:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k2Uvm-0001Om-9d; Mon, 03 Aug 2020 03:30:46 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43985)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k2Uvk-00065g-38; Mon, 03 Aug 2020 03:30:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id a15so33167057wrh.10;
 Mon, 03 Aug 2020 00:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=x9ZHqpFOW+mw18lc3FPOEM8YlIVhGuhIIszL8eaScns=;
 b=ah80WN9pxpdXFiFLatfwfCMOXUPVEc565BfEcPun45Ael4ka+KXBuSMlfVV0VHFQtq
 w/9YjK+ZMRnEOrMA2SHBS8haAi6nGZO/weLai3oOhg7+B711iCAw8l7GSAJ6/7fiZGTK
 l2WOwub3yqY3GcO1yLb/EVOFuaR9L5U/08Ddpg1pJZedMNC9zhzYzziLE1cB8yME2D7H
 ejABsJiDOD/0dyTB6x+d57MKclaXD+wWbqcxypWb0MT+KMNcpTBLUe1xHDHE+Fxbp3EW
 v0AMrDs5XV4a14FOVJCKQrta229Fkd3LVdIGLguLvq+lCb481+0ocLgnAyc67SOLYxji
 gDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=x9ZHqpFOW+mw18lc3FPOEM8YlIVhGuhIIszL8eaScns=;
 b=VLN2dVmQ2CDBVKxcm9r3YhEyFRLXqVg7mOzege3D5d6CCSzeH4A/+KrLb151PZleOQ
 pg2G0K1PT/3kXNI8MlKPfPgRoUncy3lTU0XUDV1/tY7627ZIOlnBC4TVXORgKVEhPSeZ
 Ube9pilR2L904xi0HayzQCS2klrNGYskcOeqgah5jkiDJom05NfmVCqfGruGAcu68usI
 ksJoqLp9SooKzG8rj9Ko/Bo3DgdTA5orog9E+i/dWdS2e3aWn0HsXSWoSEXn0Ku+jDma
 jswqKktehg1sbN8I+H00pE5JvqmfQNtn36qG7zHy7leucTeafZfnGSNYJlakx2guUDda
 4cWA==
X-Gm-Message-State: AOAM530I5N0xuzqXSBhxsI+3whpQeuphJ5L1JEVglJHh+ZlH7JKSS4EF
 tbHkvoCFh5iWjpck9hHzqhQ=
X-Google-Smtp-Source: ABdhPJzlNT1qMAVVyfR/x4z6gxZLzQTfZCnZ43asXxp6w0iMmFSrBaZp4MBmsoUzk+cgnrttJPb3yA==
X-Received: by 2002:adf:c552:: with SMTP id s18mr13428322wrf.209.1596439840201; 
 Mon, 03 Aug 2020 00:30:40 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 130sm23969438wme.26.2020.08.03.00.30.38
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 03 Aug 2020 00:30:39 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v6 0/6] riscv: Switch to use generic platform fw_dynamic type
 opensbi bios images
Date: Mon,  3 Aug 2020 00:30:26 -0700
Message-Id: <1596439832-29238-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

The RISC-V generic platform is a flattened device tree (FDT) based
platform where all platform specific functionality is provided based
on FDT passed by previous booting stage. The support was added in
the upstream OpenSBI v0.8 release recently.

This series updates QEMU to switch to use generic platform of opensbi
bios images. With the recent fw_dynamic image support, let's replace
the fw_jump images with fw_dynamic ones too.

The patch emails do not contain binary bits, please grab all updates
at https://github.com/lbmeng/qemu.git bios branch.

Note:

1. To test 32-bit Linux kernel on QEMU 'sifive_u' 32-bit machine,
the following patch is needed:
http://lists.infradead.org/pipermail/linux-riscv/2020-July/001213.html

2. To test 64-bit Linux 5.3 kernel on QEMU 'virt' or 'sifive_u' 64-bit
machines, the following commit should be cherry-picked to 5.3:

commit 922b0375fc93fb1a20c5617e37c389c26bbccb70
Author: Albert Ou <aou@eecs.berkeley.edu>
Date:   Fri Sep 27 16:14:18 2019 -0700

    riscv: Fix memblock reservation for device tree blob

Linux 5.4 or above already contains this commit/fix.

Changes in v6:
- Rebased on https://github.com/alistair23/qemu/commits/riscv-to-apply.next
- Add information about Linux kernel tested
- Squash the Makefile ELF changes into patch 5

Changes in v5:
- Include the generic fw_dynamic.bin in the Makefile for `make install` bisection

Changes in v4:
- Remove old binaries in the Makefile for `make install` bisection

Changes in v3:
- Change fw_jump to fw_dynamic in the make rules
- Change to fw_dynamic.bin for virt & sifive_u
- Change to fw_dynamic.elf for Spike
- Generate fw_dynamic images in the artifacts

Changes in v2:
- new patch: configure: Create symbolic links for pc-bios/*.elf files
- Upgrade OpenSBI to v0.8 release
- Copy the ELF images too in the make rules
- Include ELF images in the artifacts

Bin Meng (6):
  configure: Create symbolic links for pc-bios/*.elf files
  roms/opensbi: Upgrade from v0.7 to v0.8
  roms/Makefile: Build the generic platform for RISC-V OpenSBI firmware
  hw/riscv: Use pre-built bios image of generic platform for virt &
    sifive_u
  hw/riscv: spike: Change the default bios to use generic platform image
  gitlab-ci/opensbi: Update GitLab CI to build generic platform

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


