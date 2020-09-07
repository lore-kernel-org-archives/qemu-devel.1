Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451FFC2BB84
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C4B205CB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osBjK2qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C4B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEKY-0004fI-CY
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kFEJx-00042G-3P; Mon, 07 Sep 2020 06:24:21 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:34140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kFEJv-0002K3-5j; Mon, 07 Sep 2020 06:24:20 -0400
Received: by mail-yb1-xb42.google.com with SMTP id u6so9093714ybf.1;
 Mon, 07 Sep 2020 03:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+tWDOOsjdkNUtA6oKk1HUkDL7Sde311gZREuKt9c2PE=;
 b=osBjK2qdGWemDOHmSepH7A/dPh3hf/g5Pxzyn0uznvnUD+lJIrY9KV6J4Pw6mbEZuR
 1HiHvRrvuyp+uFZFJW9tg7NUUq42r35SmKioZ0fSRzFD7wFXRgNdHngIBrASbiCBwW2b
 vkBQDNdH2psn4sxj5iXUFR4tVPAf11IG3pQ8xyJ7AoMonRszeBIigWjNB81VMx0RZmJf
 1mZCz/AmgSCbpMOAW3d9oNiISdYkBQxtfmXLOgji/Rte/kqEoISFHgHSjYlh1m8ECGIf
 XYZi9oAkgOey9AEWYGJwEGR2Y65gq7Agii+QmXrU2v+1FNAkuDkaewBNzEApDYcwdawN
 EtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+tWDOOsjdkNUtA6oKk1HUkDL7Sde311gZREuKt9c2PE=;
 b=BCrMcLR3dyTXFTjAziAyslhLPjDKynaYuRhtof5PU98nTpJr50kp3UQproRDzHP2ve
 ZvCJ1uHgbS0EQcGdD7KhchShz22TfE7U4P6cn5rELNdb1Cs0I55sCa7FwAV7b82p7gHe
 dheE7pQt3InOKWc9MdwX+2x+ZYSJDrFeGVOwwcOLqf58Q1da1Jz4OaqayWlVuK1+kWOK
 Lf074kJqrqfcsBiPgyx5ysBMDgSfd6FLf7vK2D4E3ADu5FcXYH2KCwDaRNdj7IjQj4oY
 6O/DcadnJQDPcRUJvU2nDSqOj1c2FN2gAoxaq62stMD1KfQBb4yWL47nEsT/saIW1FbC
 dTlQ==
X-Gm-Message-State: AOAM533IY2OOmOC0ZXNgNwDG4/UwpI17U19VCo6i3rTFpukCNU45MA7o
 BtsQRV1nSXv4qdnXUJtg/7OTOGU46rO4HdVJsc8=
X-Google-Smtp-Source: ABdhPJxQ+nng2R8lamJlB/1HY6a+LPnOyJyvAbZgxVUHQ+FQzq0bhnmgiFnQ0qhMd9Mogucj3DyvEO35KYmARy95Ukw=
X-Received: by 2002:a25:cfd2:: with SMTP id f201mr5091035ybg.122.1599474256814; 
 Mon, 07 Sep 2020 03:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <20200906010811.GA1546@vanye>
In-Reply-To: <20200906010811.GA1546@vanye>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 7 Sep 2020 18:24:06 +0800
Message-ID: <CAEUhbmVfSPwO5CHO2G5Vd5fA6NA4dRCp-e_KGJhSO7nYAPmi1w@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
To: Leif Lindholm <leif@nuviainc.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Bin Meng <bin.meng@windriver.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Leif,


On Sun, Sep 6, 2020 at 9:08 AM Leif Lindholm <leif@nuviainc.com> wrote:
>
> On Tue, Sep 01, 2020 at 09:38:55 +0800, Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > This adds support for Microchip PolarFire SoC Icicle Kit board.
> > The Icicle Kit board integrates a PolarFire SoC, with one SiFive's
> > E51 plus four U54 cores and many on-chip peripherals and an FPGA.
> >
> > For more details about Microchip PolarFire SoC, please see:
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
> > - SiFive PDMA
> > - Cadence eMMC/SDHCI controller
> > - Cadence Gigabit Ethernet MAC
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
> I finally got around to building the sd image from
> https://github.com/polarfire-soc/polarfire-soc-buildroot-sdk,
> and I can successfully boot to prompt using that, and the (hacked)
> hss.bin I verified previously - also with this v3.
>

Good to know!

> However, unless I add the "-nic user,model=cadence_gem \" shown in
> https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_SoC_Icicle_Kit
> but not here, I do not have functioning networking. (It is not obvious
> to me why this is needed.)
>

Sorry I don't understand what the issue is?

> > The memory is set to 1 GiB by default to match the hardware.
>
> Which hardware is this?
> https://www.crowdsupply.com/microchip/polarfire-soc-icicle-kit lists
> 2GiB.

It's this same board. But I believe the crowdsupply webpage has the
wrong information. The board I got only has 1GB memory.

>
> > A sanity check on ram size is performed in the machine init routine
> > to prompt user to increase the RAM size to > 1 GiB when less than
> > 1 GiB ram is detected.
>
> There is currently no visible effect in firmware from setting memory size to >
> 1GiB (hss says 1GB, u-boot says 1GB, Linux sees 1GB).
> Are there any plans to address this in future versions?
>

HSS is using hardcoded 1GB memory size and that's why in QEMU the
minimum required memory size is 1GB. Setting less than 1GB size blocks
HSS to load the 2nd stage bootloader U-Boot into the memory. Both
U-Boot and Linux DTS files set the memory size to 1GB, so that's why
both of them see only 1GB. Setting memory >1G does not affect U-Boot
and Linux though. You can however manually edit the U-Boot and Linux
DTS files to have a large RAM size to match QEMU -m option.

Regards,
Bin

