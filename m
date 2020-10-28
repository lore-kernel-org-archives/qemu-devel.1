Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC416C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E362481F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTE0SvbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E362481F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXsHV-0003fe-4a
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 16:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXsGc-0003CE-Ge; Wed, 28 Oct 2020 16:41:58 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:33480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXsGa-0002U0-I8; Wed, 28 Oct 2020 16:41:58 -0400
Received: by mail-il1-x144.google.com with SMTP id f16so848206ilr.0;
 Wed, 28 Oct 2020 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u6c1IvoLU1jJNSxai7R5+aEhshY9g0/9xRcDZ6WYzTg=;
 b=ZTE0SvbEQ3HInXFAxUjyXve4siCm2UeS+FgeeF1uKC7EJpXKb4REqpQBepVtFK2SJs
 nuSP88klMVQIiplO74pFKVRUK1E2wcMhW+VaQxmOmDhHwE35gDndpVCyOVLS1mX5N+8m
 Ltw3xChHcUyKrvfVMlRApwgKnxpDn+9Nq9TBhqnTSlZfdl2IT7K0flUwIUIN+GDpYUOF
 QKo2jHzrqc9o5DMJF/d0RMYcPw4cqut21XdRmjv27KRx9H1Snl4vAzrcf86gFfW8sqcX
 F1uAo0z7gj82Leo35VsEHoFZmTZFw9lKO34H1rMpjNKnTG5X2TJ9HI9VS6wQy2U1POUD
 cXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u6c1IvoLU1jJNSxai7R5+aEhshY9g0/9xRcDZ6WYzTg=;
 b=O8WH3RRlzQRhPMeJkydjvbJ3dV95TrYY3TsIiCWj12zvDysKBoXMx3MOSMPtlUrzl5
 6tE2QK+g3rCMIjVMqSKeR/VYdeLtSTc9hq6E+M9cll80OU2T0/Q7rekpGYKitoN9y4+o
 skbbe/b4nATSXpb7XDEue+KfL9Awp+B+dgwdfH00pZ4P4+6OyMtHhNFTHLyAfyHB15r2
 AegfGS8V7j+Cm2EHbxgaOW92EIkI/nxYXgh3FkB9Cs62sxKh8EOCayu0QoV/pfi1+i6W
 LpVCfsFlQqT5hg2zRnLrb1TM/ge9qOmy8mGfRp+sqF+HolmOOSX6LcJv6HbG/ty83get
 gcCw==
X-Gm-Message-State: AOAM531744xmLPapITUo+5gKItD1/fnWT1969rYh/0gF3NJw5AJ61dwF
 tvWrIQUS2kqB2rMl9PoPbR5UooTVdPqLuB+k6Tw=
X-Google-Smtp-Source: ABdhPJxMQR+2dGyIHO82nsbZwJHWIIIhwchhZyVa7fZlWRX2JjUfUgNxForkM0quaCKaIu2zgXTZQmYT1LVA025gtO8=
X-Received: by 2002:a05:6e02:c:: with SMTP id h12mr737929ilr.177.1603917713603; 
 Wed, 28 Oct 2020 13:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 28 Oct 2020 13:30:02 -0700
Message-ID: <CAKmqyKP42vEZvLHM4r=XQSa-DttHcJNBw0uCgUZwBvBsc8kijw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] hw/riscv: microchip_pfsoc: Support factory HSS
 boot out of the box
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <anup.patel@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Ivan Griffin <ivan.griffin@emdalo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 27, 2020 at 10:31 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> At present the DDR memory controller is not modeled, hence the factory
> HSS firmware does not boot out of the box on QEMU. A modified HSS is
> required per the instructions on [1].
>
> This series adds the missing DDR memory controller support to PolarFire
> SoC, as well as adding various misc models to support the DDR memory
> initialization done by HSS.
>
> With this series, the unmodified HSS image can boot on QEMU out of the
> box. The latest SD card image [2] released by Microchip was used for
> testing which includes the pre-built U-Boot, device tree blob and Linux
> kernel. The instructions on [1] have been updated to latest information.
>
> [1] https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_SoC_Icicle_Kit
> [2] ftp://ftpsoc.microsemi.com/outgoing/core-image-minimal-dev-icicle-kit-es-sd-20201009141623.rootfs.wic.gz
>
> Changes in v2:
> - new patch: Document where to look at the PolarFire SoC memory maps
> - change to map the reserved memory at address 0 instead of debug memory
> - Increase the default memory size to 2 GiB
>
> Bin Meng (10):
>   hw/riscv: microchip_pfsoc: Document where to look at the SoC memory
>     maps
>   hw/misc: Add Microchip PolarFire SoC DDR Memory Controller support
>   hw/riscv: microchip_pfsoc: Connect DDR memory controller modules
>   hw/misc: Add Microchip PolarFire SoC IOSCB module support
>   hw/riscv: microchip_pfsoc: Connect the IOSCB module
>   hw/misc: Add Microchip PolarFire SoC SYSREG module support
>   hw/riscv: microchip_pfsoc: Connect the SYSREG module
>   hw/riscv: microchip_pfsoc: Map the reserved memory at address 0
>   hw/riscv: microchip_pfsoc: Correct DDR memory map
>   hw/riscv: microchip_pfsoc: Hook the I2C1 controller

Thanks!

Applied to riscv-to-apply.next

Alistair


>
>  MAINTAINERS                         |   6 +
>  hw/misc/Kconfig                     |   9 ++
>  hw/misc/mchp_pfsoc_dmc.c            | 216 ++++++++++++++++++++++++++++++++
>  hw/misc/mchp_pfsoc_ioscb.c          | 242 ++++++++++++++++++++++++++++++++++++
>  hw/misc/mchp_pfsoc_sysreg.c         |  99 +++++++++++++++
>  hw/misc/meson.build                 |   3 +
>  hw/riscv/Kconfig                    |   3 +
>  hw/riscv/microchip_pfsoc.c          | 123 +++++++++++++++---
>  include/hw/misc/mchp_pfsoc_dmc.h    |  56 +++++++++
>  include/hw/misc/mchp_pfsoc_ioscb.h  |  50 ++++++++
>  include/hw/misc/mchp_pfsoc_sysreg.h |  39 ++++++
>  include/hw/riscv/microchip_pfsoc.h  |  18 ++-
>  12 files changed, 847 insertions(+), 17 deletions(-)
>  create mode 100644 hw/misc/mchp_pfsoc_dmc.c
>  create mode 100644 hw/misc/mchp_pfsoc_ioscb.c
>  create mode 100644 hw/misc/mchp_pfsoc_sysreg.c
>  create mode 100644 include/hw/misc/mchp_pfsoc_dmc.h
>  create mode 100644 include/hw/misc/mchp_pfsoc_ioscb.h
>  create mode 100644 include/hw/misc/mchp_pfsoc_sysreg.h
>
> --
> 2.7.4
>
>

