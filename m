Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45EEC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 01:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00ED22202
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 01:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drDiAbTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00ED22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXaWP-00078A-AS
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 21:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXaVK-0006aY-Cz; Tue, 27 Oct 2020 21:43:58 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:41112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXaVI-0005p3-2r; Tue, 27 Oct 2020 21:43:58 -0400
Received: by mail-yb1-xb44.google.com with SMTP id c129so2921598yba.8;
 Tue, 27 Oct 2020 18:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M1V7yTmf01n72tWMAPoF7C/PVSHWxT2o5lfXqxy5Y0w=;
 b=drDiAbTUHIesFv3cMDUl1WWLhH3LkszjSyLyFhiuho1Ze9BaSG0usrrjjPKPCxmT82
 VWKHMm/O621cBy7H+4mjhsYQUoylzUXKxNDJ1Sl5sM3Via5zBrUo8WyIq1+vftSrYWOS
 roiAhUwc1LygHFBCTRdzZymbkOFLyJ2KBjvz5eLLcAKxlBHYxRLRVIOReQ0a7r3o5Nm+
 b4EmLHp1uB/uBYbSm33B6Jl3B/PvB2VSNWMKTK/OxF3j+zASb+f4+nnxJbQ2lRGi/+Xh
 3LGwpoI/Ko+DaUmk8XimvIg/wtAbJYCnRr8x0x3tWtF9uFZvqDzLkrcgd3i65PXWS/j/
 Npjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M1V7yTmf01n72tWMAPoF7C/PVSHWxT2o5lfXqxy5Y0w=;
 b=uB6HcBcvbuU6rJKf3x4WvOPaK5DIlNLpDkjsl2bC7e2BWzHs5XfeeGSn1i3lIZ+Atm
 3XriknSAg5dv26qYD/8FMR842RxV+PGNFwi/3xDU1AU+HFGHHbzdk0sGWdv4jzbGXySN
 LSbHzESfAPRE7XxHoYbIXGVEBvkj7NbsWt8kRrT8xGep81/82n0KJ0hNYOCbEKgN0bTZ
 DDF+1nPDogkwk4PB7ifdDNrFlPGEH/LHRld5mrtm0OFpsYjBknUi+Q88NNOAP+HZztcO
 bmi2427q0p2eFhmi3UlPKpJYjC7nMKX/AqktaMi1hriOJ1AJoQbuHXcvoChhYmu9afxE
 pgog==
X-Gm-Message-State: AOAM533DI9Q3dlS//yOIMjDH6E9nJdacxBqtvnV4aeXIxp468s8tMYU3
 wB3EhsXRfzt5vSs9CLZsr1IqOgG1mtERRHPoLoU=
X-Google-Smtp-Source: ABdhPJzD8sg6kUVWOXrqbIEibHH/UIbA74pZDUl8AH4e/4UbZFuJgW0Bq0nPHKq9a5m0pb2dhfRjDx4zNY91us7I+pY=
X-Received: by 2002:a25:386:: with SMTP id 128mr7131481ybd.122.1603849434625; 
 Tue, 27 Oct 2020 18:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201027141740.18336-1-bmeng.cn@gmail.com>
 <20201027141740.18336-3-bmeng.cn@gmail.com>
 <CAKmqyKMyHCZCLZOqVVZ4n4C0_rAY-WO5-J+Y=dqi0qtZsLXjpw@mail.gmail.com>
In-Reply-To: <CAKmqyKMyHCZCLZOqVVZ4n4C0_rAY-WO5-J+Y=dqi0qtZsLXjpw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 28 Oct 2020 09:43:42 +0800
Message-ID: <CAEUhbmWqoP71uKYRhYdmb=Hxx=FNOYcfL6EkEChn9x1Qq9CddQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/9] hw/riscv: microchip_pfsoc: Connect DDR memory
 controller modules
To: Alistair Francis <alistair23@gmail.com>
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

Hi Alistair,

On Wed, Oct 28, 2020 at 1:49 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Oct 27, 2020 at 7:46 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > Connect DDR SGMII PHY module and CFG module to the PolarFire SoC.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > ---
> >
> >  hw/riscv/Kconfig                   |  1 +
> >  hw/riscv/microchip_pfsoc.c         | 18 ++++++++++++++++++
> >  include/hw/riscv/microchip_pfsoc.h |  5 +++++
> >  3 files changed, 24 insertions(+)
> >
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > index 2df978fe8d..c8e50bde99 100644
> > --- a/hw/riscv/Kconfig
> > +++ b/hw/riscv/Kconfig
> > @@ -4,6 +4,7 @@ config IBEX
> >  config MICROCHIP_PFSOC
> >      bool
> >      select CADENCE_SDHCI
> > +    select MCHP_PFSOC_DMC
> >      select MCHP_PFSOC_MMUART
> >      select MSI_NONBROKEN
> >      select SIFIVE_CLINT
> > diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> > index 4627179cd3..85be2bcde8 100644
> > --- a/hw/riscv/microchip_pfsoc.c
> > +++ b/hw/riscv/microchip_pfsoc.c
> > @@ -15,6 +15,7 @@
> >   * 4) Cadence eMMC/SDHC controller and an SD card connected to it
> >   * 5) SiFive Platform DMA (Direct Memory Access Controller)
> >   * 6) GEM (Gigabit Ethernet MAC Controller)
> > + * 7) DMC (DDR Memory Controller)
> >   *
> >   * This board currently generates devicetree dynamically that indicates at least
> >   * two harts and up to five harts.
> > @@ -85,7 +86,9 @@ static const struct MemmapEntry {
> >      [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
> >      [MICROCHIP_PFSOC_SYSREG] =          { 0x20002000,     0x2000 },
> >      [MICROCHIP_PFSOC_MPUCFG] =          { 0x20005000,     0x1000 },
> > +    [MICROCHIP_PFSOC_DDR_SGMII_PHY] =   { 0x20007000,     0x1000 },
> >      [MICROCHIP_PFSOC_EMMC_SD] =         { 0x20008000,     0x1000 },
> > +    [MICROCHIP_PFSOC_DDR_CFG] =         { 0x20080000,    0x40000 },
>
> Neither of these are documented....

It's documented in the "Register
Map/PF_SoC_RegMap_V1_1/pfsoc_regmap.htm" in
https://www.microsemi.com/document-portal/doc_download/1244581-polarfire-soc-register-map

>
> Maybe just add a single comment above the memory layout clarifying
> that this is not what is documented from the SoC but is instead based
> on what guests do?
>

I can add a link to the Microchip website that documents the memory
map above the memory layout.

> It seems to be a constant problem with this board, unless I am really
> misreading the memory map.
>

Regards,
Bin

