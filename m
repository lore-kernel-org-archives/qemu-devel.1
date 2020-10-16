Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA49C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0AA0207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mU5gXvoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AA0207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTSTZ-0000iy-LX
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kTSS2-0007YG-T3; Fri, 16 Oct 2020 12:19:30 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:41763)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kTSRz-0000Am-Jr; Fri, 16 Oct 2020 12:19:30 -0400
Received: by mail-il1-x144.google.com with SMTP id w17so3260942ilg.8;
 Fri, 16 Oct 2020 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qkFivj9r+yOsnfOuSEPqb+2bwR27VG0SRZccwEwsSEc=;
 b=mU5gXvohRfyJhfrn5CI7lvW8cFFo1kv9voey9kF1+hEvso4IGlGT6nho58uuvBWL2U
 aDWRQxKaViHdQcIIRs5uERSM3cmo/v4fi/1TsaNq5x8TcfhbX8PFDBuCMG4shpEOZU6+
 h094UL9KNTMcIDUULcroTMu7THWmCU2VK68pd82L04rVyWgsZ3NYa0Fc2e95JPxXSO3d
 suYOJVkrEKswa7fQv1OjEjkRWwjgu84lzPl7YMwNH/0WoXvJ0TrVO8ToKuarGnuEUJBU
 8Wo/hDiq/c3AaKtO8BRPX7bhYNf+fyMSwGWqJkzp97qkDCQJPdXhyZGxYtwemDLUTcyf
 BCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qkFivj9r+yOsnfOuSEPqb+2bwR27VG0SRZccwEwsSEc=;
 b=BCL7dyQv0QBegq0+9hiWac7qRLup1Ecmufn3eGOJLCdQbiMSodCgSPaDVQS6OzvViX
 NCkR/tFF3jVLvvSb/Gs5XgYowquiN6WaxlL6cdJ+hBHTOeZz3ZJfBmnhbM9JywOOCXSO
 +b7vgu+VWzwesU7EiXQJ547LcVcAdF2wFGqd5Pk2z1Ee2ysQRreacrWWt0DXReVqGHpI
 WWbFXbq29Ff94PfOIaRNPE6et8p0RE1gpuZBRtFB0gNtL7riWEH5zROdMF/XYdhx7UBT
 mthdVbGx5UufaVu0DU1dkphbv6KrJKxfMOVUdk6zP0IrL4b3e4EiZGAw6gDVyZ6m+nMy
 O6CA==
X-Gm-Message-State: AOAM533+FNMuP8/WyoyRvlZ25MCgCsOlPAzwyHozoeb3Gu9+YLKnRIOd
 +CFJmG/TWQn/cX6X44LyrRCMH+d1mm9Kvb+hsgGoy7t6eoMcLg==
X-Google-Smtp-Source: ABdhPJx9625nyUnHAxpox5wJx2sdydNI8a2CyQt1nhAZ6e9EiscKZfHXlP6LxLHt12yrgJ61gS/NOkzRP3BGfLVkQCo=
X-Received: by 2002:a05:6e02:1241:: with SMTP id
 j1mr3500808ilq.267.1602865164663; 
 Fri, 16 Oct 2020 09:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201016123737.8118-1-ivan.griffin@emdalo.com>
In-Reply-To: <20201016123737.8118-1-ivan.griffin@emdalo.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 16 Oct 2020 09:07:45 -0700
Message-ID: <CAKmqyKNykruYK2AQ05KZyGCGD0rUsqQOVBbnccY+ELATBF=Ozg@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
To: Ivan Griffin <ivan.griffin@emdalo.com>
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 16, 2020 at 8:04 AM Ivan Griffin <ivan.griffin@emdalo.com> wrote:
>
> Adding the PolarFire SoC IOSCBCTRL memory region to prevent QEMU
> reporting a STORE/AMO Access Fault.
>
> This region is used by the PolarFire SoC port of U-Boot to
> interact with the FPGA system controller.
>
> Signed-off-by: Ivan Griffin <ivan.griffin@emdalo.com>
> ---
>  hw/riscv/microchip_pfsoc.c         | 6 ++++++
>  include/hw/riscv/microchip_pfsoc.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 4627179cd3..20e1496e3e 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -97,6 +97,7 @@ static const struct MemmapEntry {
>      [MICROCHIP_PFSOC_GPIO2] =           { 0x20122000,     0x1000 },
>      [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
>      [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
> +    [MICROCHIP_PFSOC_IOSCB_CTRL] =      { 0x37020000,     0x1000 },

I don't see this in the UG0880 "User Guide PolarFire SoC FPGA
Microprocessor Sub-System" memory map.

Where is this documented?

Alistair

>      [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
>      [MICROCHIP_PFSOC_DRAM] =            { 0x80000000,        0x0 },
>  };
> @@ -341,6 +342,11 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>      create_unimplemented_device("microchip.pfsoc.ioscb.cfg",
>          memmap[MICROCHIP_PFSOC_IOSCB_CFG].base,
>          memmap[MICROCHIP_PFSOC_IOSCB_CFG].size);
> +
> +    /* IOSCBCTRL */
> +    create_unimplemented_device("microchip.pfsoc.ioscb.ctrl",
> +        memmap[MICROCHIP_PFSOC_IOSCB_CTRL].base,
> +        memmap[MICROCHIP_PFSOC_IOSCB_CTRL].size);
>  }
>
>  static void microchip_pfsoc_soc_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index 8bfc7e1a85..3f1874b162 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -95,6 +95,7 @@ enum {
>      MICROCHIP_PFSOC_ENVM_CFG,
>      MICROCHIP_PFSOC_ENVM_DATA,
>      MICROCHIP_PFSOC_IOSCB_CFG,
> +    MICROCHIP_PFSOC_IOSCB_CTRL,
>      MICROCHIP_PFSOC_DRAM,
>  };
>
> --
> 2.17.1
>
>

