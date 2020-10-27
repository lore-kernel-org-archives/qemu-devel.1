Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D04C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01E021556
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWzd1L/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01E021556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQFx-00046B-LO
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPnl-0002JD-OD; Tue, 27 Oct 2020 10:18:18 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPni-0007eN-Oa; Tue, 27 Oct 2020 10:18:17 -0400
Received: by mail-pg1-x541.google.com with SMTP id n16so854604pgv.13;
 Tue, 27 Oct 2020 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x9cl4uYK8Gli03xlQ9Mpn2VGnBsqDExS9meYipuvMLk=;
 b=CWzd1L/xtRXBBPIGM/+SnYIORCV6nQyV1iIav6U04N5+btIm6KqJ3gUcOGKY1n1FiS
 WdI7DwNxPM+oQ95auiGgDofJhV5th+gf5TfjaWnzRbNOywvg6XW4EejRvK9z00VUqKnE
 fDefNJY2tD5qwUyy287zsa1H01mLv0wlv1codhymWb8C5ZeI/9IGTfqMQFzUphoV1Rk2
 n/8qZ6iB+YBT2SurcQTlN6V0gfF7B/uscNjbRG446T/HURGhVaistwWcNYQvLfWaFZXR
 1OmUGH6KNRUi7aw+S7VyFZ++8YmWS3f6O50qQgEAWkSt6ZKACrHW9hBwfIIaQbCaZHqc
 3R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=x9cl4uYK8Gli03xlQ9Mpn2VGnBsqDExS9meYipuvMLk=;
 b=cbgXkpCdcFWbWHDuhEevkT++zbF45C8nrg8xwwp0AqEa+LTnYbEiuCVxH1xpXk5Iqz
 yCokDL/4VexJsKdJ5Ydk+J5blc9bkqyeXXy/cOT0ynvHbP86Urayo/lZPMohXa7VNgDA
 IO1SZsWfWmx28mwHTbC+7yGkOxMplyjEOEkOTHV+sLO+nKHlCxPey72SiVCyv91/1JwE
 8twvSBB3MClNviBE+qCCcBSfK56Bg6lYHUsvqRKbLQdXc3kpAipamX5gGiPERRK6aYc+
 1/1JYZSmKqWoNnlQRA9rshVSLPpkMBQ0ArGWj8Pfbi1ISYQCrLPQlHlymILRonbO/bvX
 4BQQ==
X-Gm-Message-State: AOAM530jAVG8V4JXGx2RP4D4vKi/Vn8ACDBueX6fQWArkaeGzTLvnGnC
 TlToIIjmYyEaMfduJlR3vLg=
X-Google-Smtp-Source: ABdhPJwIBdT7VoAlkpgVQuv2D9phfyKc5psMfYePWJf1QKUuKMSagX8mDlpcQGuJ932ifM3zd2R+nw==
X-Received: by 2002:aa7:9811:0:b029:15d:2c0e:e947 with SMTP id
 e17-20020aa798110000b029015d2c0ee947mr2548388pfl.76.1603808292726; 
 Tue, 27 Oct 2020 07:18:12 -0700 (PDT)
Received: from i9-aorus-gtx1080.localdomain (144.168.56.201.16clouds.com.
 [144.168.56.201])
 by smtp.gmail.com with ESMTPSA id mn15sm1600297pjb.21.2020.10.27.07.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 07:18:12 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [RESEND PATCH 0/9] hw/riscv: microchip_pfsoc: Support factory HSS
 boot out of the box
Date: Tue, 27 Oct 2020 22:17:31 +0800
Message-Id: <20201027141740.18336-1-bmeng.cn@gmail.com>
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


