Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54506C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E4820878
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xcni4zak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E4820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSqB-0002jB-Ba
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXSp2-0001rW-Oi; Tue, 27 Oct 2020 13:31:48 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:40414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kXSp0-0002e8-71; Tue, 27 Oct 2020 13:31:48 -0400
Received: by mail-io1-xd44.google.com with SMTP id r9so2413993ioo.7;
 Tue, 27 Oct 2020 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PT1FEr/VqIwLp4Z5yd/80qY0i7T/ZN4CO95FsozCujc=;
 b=Xcni4zakLFdwevgfriejdhw5XNfjPWeIYEQpWTRHD1Po/XJIZam/XYPgJabCc3T9eU
 P5ziCMji8A/2ROYvXOMCCcr4zVk/y47O7hpPdqyqHZp4anvEeyHOKVKhYlslF/gTzrWL
 BwhUAAlTmnMd6P3oQTmlYEiduD0jiV2Eaze/FvRQwoUi4KGhVzqONnmZEOaaS2CYmjFp
 0h24QpP8+cldSPkRHrmb8aaCWJlfGnChAC6YIhExJGEbqGteeECYRMVrtgLCCjkaBlAs
 sDILh+4PT256U8+FD5eKgqFgq/6p/fLGoOikGMzXSnxCao/PcKRHuQo6UJs30CjRStLt
 H30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PT1FEr/VqIwLp4Z5yd/80qY0i7T/ZN4CO95FsozCujc=;
 b=q3cuCPwTLB5gAIFJETmMdV9exAAuWSRTv0fLlX7gEXiwXoMFAwJAg9gqQgnh2y7A6K
 8RarH7Nh045OQLtryYVAk7QPrzFDCSlPgZ0epdBbgz4oRlB2/TgbHn7pF1rlRCIJPBSe
 QlC2FTpT+CHWWSns4oYuZHsmfyXBydM+/gAXTaQJL/9UmjObGbxBK4CXUZSBYnvOsxbn
 2HxllQ6NQSEThs+P3J+NV7elD9f9ZdAAeCIBeHQ82D3Lw/K3J4piisK1BjovPm3Dg2CU
 pTo3YUguxwo6YV9H5vkJahnHT62StLA+7rrXniSOSRAhpm8tzWIBDlfvdTLm6PwrDhLj
 JSjA==
X-Gm-Message-State: AOAM532MSYiHr2oKjhqKGE37G+j+ulH4Ii2EuSWo1jcLleG+BMNVQKAV
 eMMtWo64+KCc8dtd3qTnnyW6ll4lEIitHM9V998=
X-Google-Smtp-Source: ABdhPJz6Osd3uwkpFaOm5utJoOCxoaEK9ZkTlOGp5sSzcJpZ7FcpCbudXE/97dEpBUowiSeXh+MRueAHFKhzje2WMhk=
X-Received: by 2002:a02:84c3:: with SMTP id f61mr3670030jai.8.1603819904378;
 Tue, 27 Oct 2020 10:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201027141740.18336-1-bmeng.cn@gmail.com>
 <20201027141740.18336-10-bmeng.cn@gmail.com>
In-Reply-To: <20201027141740.18336-10-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Oct 2020 10:19:55 -0700
Message-ID: <CAKmqyKO63H9m-wwp45sGxzEwduv9WtwoY8dvPkMMVhTet=FyOg@mail.gmail.com>
Subject: Re: [RESEND PATCH 9/9] hw/riscv: microchip_pfsoc: Hook the I2C1
 controller
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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

On Tue, Oct 27, 2020 at 7:55 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> The latest SD card image [1] released by Microchip ships a Linux
> kernel with built-in PolarFire SoC I2C driver support. The device
> tree file includes the description for the I2C1 node hence kernel
> tries to probe the I2C1 device during boot.
>
> It is enough to create an unimplemented device for I2C1 to allow
> the kernel to continue booting to the shell.
>
> [1] ftp://ftpsoc.microsemi.com/outgoing/core-image-minimal-dev-icicle-kit-es-sd-20201009141623.rootfs.wic.gz
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
>  hw/riscv/microchip_pfsoc.c         | 6 ++++++
>  include/hw/riscv/microchip_pfsoc.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index c595c9c967..4e878c2836 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -94,6 +94,7 @@ static const struct MemmapEntry {
>      [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART4] =         { 0x20106000,     0x1000 },
> +    [MICROCHIP_PFSOC_I2C1] =            { 0x2010b000,     0x1000 },
>      [MICROCHIP_PFSOC_GEM0] =            { 0x20110000,     0x2000 },
>      [MICROCHIP_PFSOC_GEM1] =            { 0x20112000,     0x2000 },
>      [MICROCHIP_PFSOC_GPIO0] =           { 0x20120000,     0x1000 },
> @@ -324,6 +325,11 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>          qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART4_IRQ),
>          serial_hd(4));
>
> +    /* I2C1 */
> +    create_unimplemented_device("microchip.pfsoc.i2c1",
> +        memmap[MICROCHIP_PFSOC_I2C1].base,
> +        memmap[MICROCHIP_PFSOC_I2C1].size);
> +
>      /* GEMs */
>
>      nd = &nd_table[0];
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index dc05688d94..74ae789c03 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -96,6 +96,7 @@ enum {
>      MICROCHIP_PFSOC_MMUART2,
>      MICROCHIP_PFSOC_MMUART3,
>      MICROCHIP_PFSOC_MMUART4,
> +    MICROCHIP_PFSOC_I2C1,
>      MICROCHIP_PFSOC_GEM0,
>      MICROCHIP_PFSOC_GEM1,
>      MICROCHIP_PFSOC_GPIO0,
> --
> 2.25.1
>
>

