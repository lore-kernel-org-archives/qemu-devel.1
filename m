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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B444C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E1720709
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvC6AEXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E1720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTry-0005HX-7t
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kTTqT-0004dg-73; Fri, 16 Oct 2020 13:48:49 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kTTqR-0003bl-Dr; Fri, 16 Oct 2020 13:48:48 -0400
Received: by mail-io1-xd42.google.com with SMTP id m17so4955387ioo.1;
 Fri, 16 Oct 2020 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gT2hfcXVnuoEGL7argOkM4KGTVL7vjeDNNn/xmhpkVo=;
 b=nvC6AEXSEmHQ1h4sYskDt2cNwzGkD+EXn7i5083le4igl3aKouCqOnQMzrv5FVA36L
 drovp5RFJv1nr9hblmNyOcloR99hO/aC10Zj4apwb9ZIyKCkLyQuqb/7vEVxXBUNwTNG
 WMUeuvh3G6V7EVJLWmee6o3A2V7QVkBzxtJZr+MhR8eDZAOrUdHsdzPfUxMRSoLFdXBl
 4FDxUNJXQ8PqbyywNebhrLs2rKYJOKUzWlJ8xa89hh3v2Jqb69Y1FzgXuBoED67/VH7G
 Usg1X7iF4xXxI6cuGtlUvck9Eo3ZdmPg3EcO7tFfQn+7j10D9OX4gfvSgian5ZuigqFv
 ZKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gT2hfcXVnuoEGL7argOkM4KGTVL7vjeDNNn/xmhpkVo=;
 b=Ho2xAl1xJV+t5WtEKSTL26C/nYskpP1GIAZ0900ylZY1tGuvxE608zoFr56xsjc+eq
 7h86aA7Q/axrijAFV+k9uDjG/8tiJSMUemyef/WzERd1piqI6MpgUUN7javPtOA+Blw+
 TUJDOeheIIkysT33IwYv1POAfwN8GdCWDK5qwzi1oKUZtuvI6lY1b3NvY0fGrFimhQco
 /7UWNrcfeEkpj9HvEo9FFdItZvyHFsFB6e+4M9ZFMWFn2mphAvN9nWc4gS+C2pbfFZ5f
 8XeBsvM05zuqZ+0+xUNDxc/FwvfLLBhOxCWdCBWrtzO2KexP2IVbV317qCJkGLhOjN9q
 Do3A==
X-Gm-Message-State: AOAM533KYdss87ihDwNvPCd9nRIIb4HsExKevbk/SHfuPP0B8KCE6hQ+
 rOgz9ksZn7XMNURGpYd3xl5770eQnz2nhm5YlJM=
X-Google-Smtp-Source: ABdhPJzYIHAWC7yYKwXAPt2bCie6mEFWXwOJMja3DhYUhD7i44XOABxtkbmJ9dGc2wZ6ZTl9cfzMsE+t4TkF9xGTEPc=
X-Received: by 2002:a6b:c9c9:: with SMTP id z192mr3258828iof.175.1602870525589; 
 Fri, 16 Oct 2020 10:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKODEgnkw4zBbsNK1zQ7qaiKWEAZBpwhnHzEetjgWpxtzQ@mail.gmail.com>
 <20201016171000.21240-1-ivan.griffin@emdalo.com>
In-Reply-To: <20201016171000.21240-1-ivan.griffin@emdalo.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 16 Oct 2020 10:37:06 -0700
Message-ID: <CAKmqyKPbw_Pf2DtjU=LYNM4YJhxkaTB7ukbZb56NZDR9BUtzAQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv: microchip_pfsoc: IOSCBCTRL memmap entry
To: Ivan Griffin <ivan.griffin@emdalo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 16, 2020 at 10:10 AM Ivan Griffin <ivan.griffin@emdalo.com> wrote:
>
> Adding the PolarFire SoC IOSCBCTRL memory region to prevent QEMU
> reporting a STORE/AMO Access Fault.
>
> This region is used by the PolarFire SoC port of U-Boot to
> interact with the FPGA system controller.
>
> Signed-off-by: Ivan Griffin <ivan.griffin@emdalo.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

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
>
> --
> 2.17.1
>

