Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140FBC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813862076E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI/4msW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813862076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXe4O-0006uT-4N
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 01:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2T-00055f-62; Wed, 28 Oct 2020 01:30:25 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34907)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2P-0000Us-Jh; Wed, 28 Oct 2020 01:30:24 -0400
Received: by mail-pf1-x443.google.com with SMTP id b3so2267403pfo.2;
 Tue, 27 Oct 2020 22:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=TLWIsfr4FaM5nXF+op3w7nuDFZ1SxdX/s8ubotqbaz0=;
 b=BI/4msW8tFjGpTBWUkRhF/eYNVTh5i26ZVn22aCkJ1dvo2auVjEDrHtCsXXJaNtyid
 1cMZpoQDvJANWE4pftKGHKhk+zMcOiyMZ0l7/6pEL12sPeUcuipLxKhSIT2pZPC/NGsb
 EaQ3qTHJvT9eor6Vrb6NwSpwcv98e0jCQ5MRnscdbYpShzNXSkLbAmDEs8nZcKPN7TYX
 D86FcsvCBP27tuYM8uxMBKPr/XluPxec2YLHOdFywRamHlExnAnOsQynjfi1rm2bXFu2
 1lHqTDeMrFc+hEctpbOiUnBYVYdn6qlWeg+ESIY2IxamI7tEgYTA4RWhDwh5Ayube20b
 hDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=TLWIsfr4FaM5nXF+op3w7nuDFZ1SxdX/s8ubotqbaz0=;
 b=PHo0LnpCVWWMlFvl3v9cK4Jr2vQt8NueNrXoXp79ejBdVx9YRe0HVNAccFPPTzqLBz
 xcUTgCK7Gs5pAPaP7ZTIi+58s5BHNFfZ/gL8miY6YdM+zHDsH/tkkfnZDK1UIThwTMa3
 9dro+J4fzKKrkX5xeioXLRyid14QNr2Ucph727mZAAWAlMftn/9gmd/Lrt1rt92LM09R
 515ThOTznoS1czxxwa4pvd5RbxwCFT5Vg63w83tYCroPFlzWOoUjSDwcPXeKyp2rSrRz
 fwKS23/F8vJ32jo3cxqLIIyLSGTmbBFb8l8MTkCSN6KcmiIWO4Q8BRAMsAAsDxNV+xgW
 X1TQ==
X-Gm-Message-State: AOAM530O5qtkPSLfjbmCib+myYsUawqklny/9l/LjbsbLW9ek/ubXEL8
 +p4BfmkGvAUet6JIVRt7JS0=
X-Google-Smtp-Source: ABdhPJzg5fiOfAW/JUafccrYn+/LcsVg3gyu58Sa3ODFRhHreggK/o5Mx7MXeUYTfiResm5TAjT+Yw==
X-Received: by 2002:aa7:808a:0:b029:160:167d:d332 with SMTP id
 v10-20020aa7808a0000b0290160167dd332mr6085234pff.1.1603863019738; 
 Tue, 27 Oct 2020 22:30:19 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 9sm5031887pjs.1.2020.10.27.22.30.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 22:30:19 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 00/10] hw/riscv: microchip_pfsoc: Support factory HSS boot
 out of the box
Date: Wed, 28 Oct 2020 13:30:00 +0800
Message-Id: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x443.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>, Atish Patra <atish.patra@wdc.com>,
 Anup Patel <anup.patel@wdc.com>, Ivan Griffin <ivan.griffin@emdalo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

At present the DDR memory controller is not modeled, hence the factory
HSS firmware does not boot out of the box on QEMU. A modified HSS is
required per the instructions on [1].

This series adds the missing DDR memory controller support to PolarFire
SoC, as well as adding various misc models to support the DDR memory
initialization done by HSS.

With this series, the unmodified HSS image can boot on QEMU out of the
box. The latest SD card image [2] released by Microchip was used for
testing which includes the pre-built U-Boot, device tree blob and Linux
kernel. The instructions on [1] have been updated to latest information.

[1] https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_SoC_Icicle_Kit
[2] ftp://ftpsoc.microsemi.com/outgoing/core-image-minimal-dev-icicle-kit-es-sd-20201009141623.rootfs.wic.gz

Changes in v2:
- new patch: Document where to look at the PolarFire SoC memory maps
- change to map the reserved memory at address 0 instead of debug memory
- Increase the default memory size to 2 GiB

Bin Meng (10):
  hw/riscv: microchip_pfsoc: Document where to look at the SoC memory
    maps
  hw/misc: Add Microchip PolarFire SoC DDR Memory Controller support
  hw/riscv: microchip_pfsoc: Connect DDR memory controller modules
  hw/misc: Add Microchip PolarFire SoC IOSCB module support
  hw/riscv: microchip_pfsoc: Connect the IOSCB module
  hw/misc: Add Microchip PolarFire SoC SYSREG module support
  hw/riscv: microchip_pfsoc: Connect the SYSREG module
  hw/riscv: microchip_pfsoc: Map the reserved memory at address 0
  hw/riscv: microchip_pfsoc: Correct DDR memory map
  hw/riscv: microchip_pfsoc: Hook the I2C1 controller

 MAINTAINERS                         |   6 +
 hw/misc/Kconfig                     |   9 ++
 hw/misc/mchp_pfsoc_dmc.c            | 216 ++++++++++++++++++++++++++++++++
 hw/misc/mchp_pfsoc_ioscb.c          | 242 ++++++++++++++++++++++++++++++++++++
 hw/misc/mchp_pfsoc_sysreg.c         |  99 +++++++++++++++
 hw/misc/meson.build                 |   3 +
 hw/riscv/Kconfig                    |   3 +
 hw/riscv/microchip_pfsoc.c          | 123 +++++++++++++++---
 include/hw/misc/mchp_pfsoc_dmc.h    |  56 +++++++++
 include/hw/misc/mchp_pfsoc_ioscb.h  |  50 ++++++++
 include/hw/misc/mchp_pfsoc_sysreg.h |  39 ++++++
 include/hw/riscv/microchip_pfsoc.h  |  18 ++-
 12 files changed, 847 insertions(+), 17 deletions(-)
 create mode 100644 hw/misc/mchp_pfsoc_dmc.c
 create mode 100644 hw/misc/mchp_pfsoc_ioscb.c
 create mode 100644 hw/misc/mchp_pfsoc_sysreg.c
 create mode 100644 include/hw/misc/mchp_pfsoc_dmc.h
 create mode 100644 include/hw/misc/mchp_pfsoc_ioscb.h
 create mode 100644 include/hw/misc/mchp_pfsoc_sysreg.h

-- 
2.7.4


