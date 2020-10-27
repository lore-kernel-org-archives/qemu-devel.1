Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAF4C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DA12072D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNnRSjDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DA12072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPv6-0003fo-H9
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPej-0007AX-1C; Tue, 27 Oct 2020 10:08:58 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPeh-0006IL-4J; Tue, 27 Oct 2020 10:08:56 -0400
Received: by mail-pg1-x541.google.com with SMTP id i26so856426pgl.5;
 Tue, 27 Oct 2020 07:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OVPJ9OkO7wG7zNrQOHCRpGMpBXnhHoydn8Z+MKwMPzM=;
 b=NNnRSjDHvDNF6PvERkRmkUaEC3shqvWQ24rF4vOrV0AqVFdUbKypNJb9KQ/tjnTxd9
 PNEIzveVgwksLyl3HGs97i1wQRw2fqPVbH4RGqKEEqP7qsgL2GwouXYxdfPEYf/XsVDp
 1KDTOFsFZLaR5N8Tz0VA9yQi76rBJTeln/CPMrrhdHsU+h6zBKDUFXh85fq0YCTnx4lo
 iNlgTfYQdOfxm6HYTA6pf+XyDi1/6uCew4E2Jt1auBM80VvG5n3xvdNqPAVzadmRo6Og
 MBUEel+zHGNVeEUaeUkIrTpOyJAaU8RlNn4PEPiv9Wb6qF0RN5R59MQUWyckuDAc0oHH
 hMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OVPJ9OkO7wG7zNrQOHCRpGMpBXnhHoydn8Z+MKwMPzM=;
 b=erfax+iyh62X9F4ulhRFTBB0EGp5zLuEjexgEWkE8I2En98nDNV19G0tye9O9m2yYN
 t8rhx5mdWZ13737FlLwLNq1zh8s1xCPGH0y6r1KYG8Ebj8zsL4vEMlgySzUIHFce5DsH
 zFGkqzdjlcHZaamG7lE2bAbM/+JRXj/XxdKmgHi9iEy7VOIDouxQVDFQVUykwU4M+Nu6
 oodJzZlF6hkoYCtFl34kIu7ycGBJP/gxwHwZ8uRumbnRVC3R+KWUT9rJ5UpR1OHWcOLf
 r5ZOOSqRQdqWrpM0IZMp7JwPC/GLK534ua25fx2NoZQf77kB+7AsF2CBM+aZiXvI40IP
 f/OA==
X-Gm-Message-State: AOAM532Z13w3p6BxF4IjFWkPIFr55d5SiIGy/GwTPvCMjxqXhH8HINlM
 VghCdtYhtNi1atNatO0YPw0=
X-Google-Smtp-Source: ABdhPJynPJ0ZChMLMOQvGZjsMC3pgreGolsKpI/18whJqd42fU6apmpCBwZEDR16ZM4OqgtsYAWI9w==
X-Received: by 2002:a62:8c81:0:b029:164:3789:5478 with SMTP id
 m123-20020a628c810000b029016437895478mr2160178pfd.44.1603807732586; 
 Tue, 27 Oct 2020 07:08:52 -0700 (PDT)
Received: from i9-aorus-gtx1080.localdomain (144.168.56.201.16clouds.com.
 [144.168.56.201])
 by smtp.gmail.com with ESMTPSA id r22sm2540856pfg.51.2020.10.27.07.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 07:08:52 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
X-Google-Original-From: Bin Meng <bin.meng@windriver.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 0/9] hw/riscv: microchip_pfsoc: Support factory HSS boot out
 of the box
Date: Tue, 27 Oct 2020 22:08:31 +0800
Message-Id: <20201027140840.18030-1-bin.meng@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x541.google.com
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

At present the DDR memory controller is not modeled, hence the factory
HSS firmware does not boot out of the box on QEMU. A modified HSS is
required per the instructions on [1].

This series adds the missing DDR memory controller support to PolarFire
SoC, as well as adding various misc models to support the DDR memory
initialization done by HSS.

With this series, the unmodified HSS image can boot on QEMU out of the
box. The latest SD card image [2] released by Microchip was used for
testing which includes the pre-built U-Boot, device tree blob and Linux
kernel for the Icicle Kit. The instructions on [1] have been updated to
include the information on HSS and SD card image.

[1] https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_SoC_Icicle_Kit
[2] ftp://ftpsoc.microsemi.com/outgoing/core-image-minimal-dev-icicle-kit-es-sd-20201009141623.rootfs.wic.gz


Bin Meng (9):
  hw/misc: Add Microchip PolarFire SoC DDR Memory Controller support
  hw/riscv: microchip_pfsoc: Connect DDR memory controller modules
  hw/misc: Add Microchip PolarFire SoC IOSCB module support
  hw/riscv: microchip_pfsoc: Connect the IOSCB module
  hw/misc: Add Microchip PolarFire SoC SYSREG module support
  hw/riscv: microchip_pfsoc: Connect the SYSREG module
  hw/riscv: microchip_pfsoc: Map debug memory
  hw/riscv: microchip_pfsoc: Correct DDR memory map
  hw/riscv: microchip_pfsoc: Hook the I2C1 controller

 MAINTAINERS                         |   6 +
 hw/misc/Kconfig                     |   9 ++
 hw/misc/mchp_pfsoc_dmc.c            | 216 +++++++++++++++++++++++++
 hw/misc/mchp_pfsoc_ioscb.c          | 242 ++++++++++++++++++++++++++++
 hw/misc/mchp_pfsoc_sysreg.c         |  99 ++++++++++++
 hw/misc/meson.build                 |   3 +
 hw/riscv/Kconfig                    |   3 +
 hw/riscv/microchip_pfsoc.c          | 103 ++++++++++--
 include/hw/misc/mchp_pfsoc_dmc.h    |  56 +++++++
 include/hw/misc/mchp_pfsoc_ioscb.h  |  50 ++++++
 include/hw/misc/mchp_pfsoc_sysreg.h |  39 +++++
 include/hw/riscv/microchip_pfsoc.h  |  17 +-
 12 files changed, 828 insertions(+), 15 deletions(-)
 create mode 100644 hw/misc/mchp_pfsoc_dmc.c
 create mode 100644 hw/misc/mchp_pfsoc_ioscb.c
 create mode 100644 hw/misc/mchp_pfsoc_sysreg.c
 create mode 100644 include/hw/misc/mchp_pfsoc_dmc.h
 create mode 100644 include/hw/misc/mchp_pfsoc_ioscb.h
 create mode 100644 include/hw/misc/mchp_pfsoc_sysreg.h

-- 
2.25.1


