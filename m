Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1FBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 01:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27060222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 01:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIsw8A0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27060222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUKRn-0001Di-5n
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 21:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kUKR9-0000eB-RU; Sun, 18 Oct 2020 21:58:11 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:34731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kUKR8-0002Bs-4G; Sun, 18 Oct 2020 21:58:11 -0400
Received: by mail-yb1-xb42.google.com with SMTP id o70so7547427ybc.1;
 Sun, 18 Oct 2020 18:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FpZ1UF+lf54rlJAxvV7Z1Wh7VrzUbPpn0uPzdr3tScs=;
 b=VIsw8A0ymNrGBoVxy3lEllpc96HY2SC88s6TtyztmshZFY6d01SeI6bXN1aKz4cDrO
 1uL4HpTLPdn0RdXy7QLv/9GVPFDBObUJPqECailTfbpFGidw5bqcol9FpNc3Q9Wl7PlS
 LPVRl7ZxuoGvXNM0ClbbSCY1QXUxTcW/7CbGxmAt2BgxKqYib1oxq81lkAL37sBS3B/6
 ODDLfHLVPk+r4SFgK69kfaEUEyjc6BsW+5bsGhau+XcJ+UUF+jJkcJXWPXC5mmxq2DLz
 Gq1orpY+rXw7fvQnuvXTtZwIYDc2IzYwNFl9ch3U0jwe/XnfYgUd+2eBRSWyvHmpxAZN
 p/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FpZ1UF+lf54rlJAxvV7Z1Wh7VrzUbPpn0uPzdr3tScs=;
 b=rFKECitmnI/zXphgLxkm1G6KAd3XEEnwUx0o9CHu0s/60Jz1Pe7F2v0fJVP7PUNuXp
 sanSVSs4z42UmmROEmMSWuN9dNJ9LzDQFrtLo/zopd39ZpD3IR5SUPl4srBGAyH8wN6g
 Oo/LQnx+gGeHdfnDqMuQFkgY6m2s8ZAwLCiBkERUElRD9bLnjc3AUg5vzQaAANg2hMhw
 kczDq10XWAJLsFYQp8rPm7etSi4xdy9pB7bxR18LqY2Vyxy3Ubv3oHDcqnkXN8tqLqW0
 TuG7mZm0smy0CVDyep0SpsGUFIXTRakxdft3KAeNx56ld1AONUAQ+MFz48bXmqRYcvqs
 uRNQ==
X-Gm-Message-State: AOAM5301rEyzqM4Vh0MHmhyQUQ/wTseMadK1esIgDdFH4/9GFlpFKFJr
 9XleoPljvDHItdrjs2KPmdldlQvcgWCGt+qjiI4=
X-Google-Smtp-Source: ABdhPJyuFP080uB61Gx1obnE5i9SMrW1L2+Gc1MtXBXsdHokd1Mw9Tx90Yy5EZwnu6jlurM6tBpuuF9SGgYRGLLXo/w=
X-Received: by 2002:a25:328a:: with SMTP id
 y132mr18208024yby.306.1603072687932; 
 Sun, 18 Oct 2020 18:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKODEgnkw4zBbsNK1zQ7qaiKWEAZBpwhnHzEetjgWpxtzQ@mail.gmail.com>
 <20201016171000.21240-1-ivan.griffin@emdalo.com>
In-Reply-To: <20201016171000.21240-1-ivan.griffin@emdalo.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 19 Oct 2020 09:57:55 +0800
Message-ID: <CAEUhbmV5V9gXeyn1Bp-u3L4FGwU_+m0CT-vomL7W8WGY9yt_nQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
To: Ivan Griffin <ivan.griffin@emdalo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
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
Cc: qemu-trivial@nongnu.org, Alistair Francis <alistair23@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Ivan,

On Sat, Oct 17, 2020 at 1:10 AM Ivan Griffin <ivan.griffin@emdalo.com> wrote:
>
> Adding the PolarFire SoC IOSCBCTRL memory region to prevent QEMU
> reporting a STORE/AMO Access Fault.
>
> This region is used by the PolarFire SoC port of U-Boot to
> interact with the FPGA system controller.
>
> Signed-off-by: Ivan Griffin <ivan.griffin@emdalo.com>
> ---
>  hw/riscv/microchip_pfsoc.c         | 10 ++++++++++
>  include/hw/riscv/microchip_pfsoc.h |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 4627179cd3..9aaa276ee2 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -97,6 +97,7 @@ static const struct MemmapEntry {
>      [MICROCHIP_PFSOC_GPIO2] =           { 0x20122000,     0x1000 },
>      [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
>      [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
> +    [MICROCHIP_PFSOC_IOSCB_CTRL] =      { 0x37020000,     0x1000 },
>      [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
>      [MICROCHIP_PFSOC_DRAM] =            { 0x80000000,        0x0 },
>  };
> @@ -341,6 +342,15 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>      create_unimplemented_device("microchip.pfsoc.ioscb.cfg",
>          memmap[MICROCHIP_PFSOC_IOSCB_CFG].base,
>          memmap[MICROCHIP_PFSOC_IOSCB_CFG].size);
> +
> +    /* IOSCBCTRL
> +     *
> +     * These registers are not documented in the official documentation
> +     * but used by the polarfire-soc-bare-meta-library code
> +     */
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

Thank you for the patch!

I am currently adding the DDR controller modeling support to PolarFire
SoC which will cover this memory map. With my patch series, your patch
is no longer needed.

Regards,
Bin

