Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A56FC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:31:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C87B0206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxDjgdEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87B0206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7cQh-00026j-W3
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 06:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7cPw-0001R0-Vf; Mon, 17 Aug 2020 06:31:04 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:42042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7cPu-0000aE-Uk; Mon, 17 Aug 2020 06:31:04 -0400
Received: by mail-yb1-xb44.google.com with SMTP id a34so9132994ybj.9;
 Mon, 17 Aug 2020 03:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Oi6Ux/YUAb8P7zAU/pbTMfZtMZ5oTfw55WO7+TbhzYM=;
 b=hxDjgdEFwUGhjxWlSmK5da53QPdru6GYNn7RGEzf/eAwlbeeu4snFsdRh6zc/MUp0d
 Ky9hSzi18TzPnwfYXOwq534XROi9vOALKqD93gTGhDGmjNrZEB0xQgVhQfZCrFrllufC
 UjJWJKESvAC7PvoeL12uKFfpwg1IdRC83wQazmFLZnpynXIvpwQzOv9kuhMKnUXH03r3
 t7WicmRMNqY0eaMszq465YDD+xeWEMGeaZ+4FS4/tPLPctJ+1DvWLIkbknNifbXQt/nd
 gfoYi9iWpoJQjtwE4UE/IMgHUy7XBFK4U9R5PEtfi5oyEPqtZhw7+Dw4/a/G0oUlbMgo
 5wqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Oi6Ux/YUAb8P7zAU/pbTMfZtMZ5oTfw55WO7+TbhzYM=;
 b=qbrVR490IIHLnMVLBeCXHaQsmgeC0oiA45rwmZJ3zykbUtKKYQjK7QvMjCFBomvFUw
 WVBZNexa4bVrBWayFjqzfSdRAEUI3sGMaSmISAMiIgEdya+GuH4qmLbNCwRd49tYkLy5
 YiyGY8TqeaJwPANCCQZSjy20OxuUqj/SWI423+e7dLXA3tfpQ6igH9lFLym4Gsdad7ra
 yD2aBI8LUIyOinczyxusmJ5/pXxqq9lKLy93hnT06Xov4jWb06JcMiN1UP7HfPZdAFTh
 HtbVEunNI4iDqkg/955Y/7vU07HzZBuiLHet7RBkbQRQ2WOThgHp25NvXdxk0YuceOGp
 4AJQ==
X-Gm-Message-State: AOAM530vAAYNqhxz91CBkfuIH8onSjGr5iz6eO17NlcIJgaMW+HomU+z
 jjsjwM9URXYNUVOe87eX8kfIHMQpLavU0haYo2I=
X-Google-Smtp-Source: ABdhPJy8/Nuc2EwTmf3FiN/J6k6l9U+lJGTWiF8jwRO8uaZ7YcqyOBMck07nWAyxRM9tMgTbeBZeP2LqcUSJvQbzeEY=
X-Received: by 2002:a25:8290:: with SMTP id r16mr19034159ybk.122.1597660260868; 
 Mon, 17 Aug 2020 03:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <CAAhSdy2D=TcENAJDja4r6pnhz0LRi-T+A9k3Btrs_EuB4x0e4w@mail.gmail.com>
In-Reply-To: <CAAhSdy2D=TcENAJDja4r6pnhz0LRi-T+A9k3Btrs_EuB4x0e4w@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 17 Aug 2020 18:30:49 +0800
Message-ID: <CAEUhbmV5=B5xKhYqMj1MQb61nt5cNUJG1MXT++C1w1YMYTfLCQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
To: Anup Patel <anup@brainfault.org>, Cyril.Jean@microchip.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, qemu-block@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Bin Meng <bin.meng@windriver.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Anup,

On Sat, Aug 15, 2020 at 1:44 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Fri, Aug 14, 2020 at 10:12 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > This adds support for Microchip PolarFire SoC Icicle Kit board.
> > The Icicle Kit board integrates a PolarFire SoC, with one SiFive's
> > E51 plus four U54 cores and many on-chip peripherals and an FPGA.
>
> Nice Work !!! This is very helpful.

Thanks!

>
> >
> > For more details about Microchip PolarFire Soc, please see:
> > https://www.microsemi.com/product-directory/soc-fpgas/5498-polarfire-soc-fpga
> >
> > The Icicle Kit board information can be found here:
> > https://www.microsemi.com/existing-parts/parts/152514
> >
> > Unlike SiFive FU540, the RISC-V core resect vector is at 0x20220000.
> > The RISC-V CPU and HART codes has been updated to set the core's
> > reset vector based on a configurable property from machine codes.
> >
> > The following perepherals are created as an unimplemented device:
> >
> > - Bus Error Uint 0/1/2/3/4
> > - L2 cache controller
> > - SYSREG
> > - MPUCFG
> > - IOSCBCFG
> > - GPIO
> >
> > The following perepherals are emulated:
> > - SiFive CLINT
> > - SiFive PLIC
> > - PolarFire SoC Multi-Mode UART
> > - PolarFire SoC DMA
> > - Cadence eMMC/SDHCI controller
> > - Cadence Gigabit Ethernet MAC
> >
> > Some bugs in the SD card codes are fixed during the development.
> >
> > The BIOS image used by this machine is hss.bin, aka Hart Software
> > Services, which can be built from:
> > https://github.com/polarfire-soc/hart-software-services
> >
> > To launch this machine:
> > $ qemu-system-riscv64 -M microchip-icicle-kit -smp 5 \
> >     -bios path/to/hss.bin -sd path/to/sdcard.img \
> >     -nic tap,ifname=tap,script=no,model=cadence_gem \
> >     -display none -serial stdio \
> >     -chardev socket,id=serial1,path=serial1.sock,server,wait \
> >     -serial chardev:serial1
>
> Currently, it is fine to use HSS (with OpenSBI v0.6 as a library) but
> this is not aligned with the existing booting flow of many RISC-V
> systems.

Yep, unfortunately this is the case currently.

>
> It will be nice to have standard U-Boot RISC-V boot-flow working
> on Microchip PolarFire SoC:
> U-Boot SPL (BIOS) => FW_DYNAMIC (Generic) => U-Boot S-mode
>

Agreed.

> The Microchip HSS is quite convoluted. It has:
> 1. DDR Init
> 2. Boot device support
> 3. SBI support using OpenSBI as library
> 4. Simple TEE support
>
> I think point 1) and 2) above should be part of U-Boot SPL.
> The point 3) can be OpenSBI FW_DYNAMIC.
>
> Lastly,for point 4), we are working on a new OpenSBI feature using
> which we can run independent Secure OS and Non-Secure OS using
> U-Boot_SPL+OpenSBI (for both SiFive Unleashed and Microchip
> PolarFire).
>
> Do you have plans for adding U-Boot SPL support for this board ??

+ Cyril Jean from Microchip

I will have to leave this question to Cyril to comment.

Regards,
Bin

