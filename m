Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70CDC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 01:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840CB22B4B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 01:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WItehrSJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840CB22B4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8D0C-0006YW-M0
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 21:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k8Czb-00061i-8n; Tue, 18 Aug 2020 21:34:19 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:45300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k8CzZ-0002AW-7q; Tue, 18 Aug 2020 21:34:18 -0400
Received: by mail-yb1-xb41.google.com with SMTP id x2so12429226ybf.12;
 Tue, 18 Aug 2020 18:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x9v32iJwwCHKnri7jWQl1HJe8M+XkbGwit4e3sHhZBg=;
 b=WItehrSJIFcAJnCzr56ZGcipn/MD0pRPKMKwjzbd1tfU61p5k2EcRYoiPXc1G2GCiu
 MZ1UjcHjZI70jVSsiSLBGLNzSfLH06mFhUeHI6OQQr55pKiC7NpD1W9VIXFmQFe9pukf
 4b8bDKwDlrwd0Fllp/PULgHZleICYuelaGVy+tQD3pOC7wNTytA1Qh1Lx/2vzxfeENHG
 GBvFks/sOSiMbXbFp4lzCbDQ2DoexVneftCwZMXUJffzTC7Lf4eEM6lV9h9nYEiJ5LlC
 AWL5M11HkeIAoj6opr9haSY8DolfqbBvoJmCvkmEyWKs4tKzK618d24E8F146nkqzjz6
 YGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x9v32iJwwCHKnri7jWQl1HJe8M+XkbGwit4e3sHhZBg=;
 b=U3rCIZlBg1IarFCjzNpxpCCB+qUB5MVJGf78/c/ZWsp0XftWwsAbfV+3IdhG91Ovje
 8aYGYSIPQBArdnmgNDJuFRVWimM+OYywBUmQQEc7HxG5G96dTqPL1+31rKNTFV/ToeE4
 eiHVBld6nm81WhPj2tfrlkmb+vLj5bsGVtH5Ef3HeZNLnL1E7BVGLXoaZGXeiMvzqXUu
 7pfY8nJwwab79cxivmSj7lSEkIC69UwLLosdFyhFJGjPbXnyTSOMxD6MPW8+fTHNc3bH
 2RMZbL71KGkhYhwly4WM0KzJDU3mzO+mVQVR02vjs47rlfC1GexaxqN0v05XpX8b6dd1
 polQ==
X-Gm-Message-State: AOAM532vlCiIEaPmHO6/P/LkAAJVxryaZlqd9ApF0ML3gp3KCDB9QrlY
 rVTsdI/3EGYIqxeVQwh4DmAF402MeagX3X3s/T8=
X-Google-Smtp-Source: ABdhPJx27MPsQuv3SAGRRGpd/w1PnASnhNzs4cU2AXYczcDWxUS2tOktN9VtQv8CIhcvDmUdm9sWvfs5sn9m+Y1sZLs=
X-Received: by 2002:a25:f20d:: with SMTP id i13mr30632404ybe.152.1597800854784; 
 Tue, 18 Aug 2020 18:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <CAAhSdy2D=TcENAJDja4r6pnhz0LRi-T+A9k3Btrs_EuB4x0e4w@mail.gmail.com>
 <CAEUhbmV5=B5xKhYqMj1MQb61nt5cNUJG1MXT++C1w1YMYTfLCQ@mail.gmail.com>
 <202949f7-c9d5-4d4d-3ebe-53727f4fa169@microchip.com>
 <CAKmqyKM3nm0rhxgDvWKWfO+4b23ZLSkHW2TzmcVZ_ZFy4L7MRg@mail.gmail.com>
 <d3f61c2c-a489-887e-0143-4d9a1e66e6f2@microchip.com>
 <CAAhSdy32owLO0KytyYsg-zH6JyyfNfGofa4vanqTFJLntPq0=g@mail.gmail.com>
 <1f17cc4c-83f8-a024-ebef-79e28fab9a32@microchip.com>
 <CAAhSdy1MTvjfpHZEAs2YVHXdPBaEMQxUNdP_yc7br0C2p9kfng@mail.gmail.com>
In-Reply-To: <CAAhSdy1MTvjfpHZEAs2YVHXdPBaEMQxUNdP_yc7br0C2p9kfng@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 19 Aug 2020 09:34:03 +0800
Message-ID: <CAEUhbmUWcTxv70yuLMXwniGXB6zkadcpB4YTq=8F9UcXRK72+g@mail.gmail.com>
Subject: Re: [PATCH 00/18] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
To: Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
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
 Alistair Francis <alistair@alistair23.me>, Cyril.Jean@microchip.com,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Bin Meng <bin.meng@windriver.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 18, 2020 at 9:55 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Aug 18, 2020 at 6:39 PM <Cyril.Jean@microchip.com> wrote:
> >
> > On 8/18/20 7:17 AM, Anup Patel wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > >
> > > On Tue, Aug 18, 2020 at 1:23 AM <Cyril.Jean@microchip.com> wrote:
> > >> On 8/17/20 8:28 PM, Alistair Francis wrote:
> > >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > >>>
> > >>> On Mon, Aug 17, 2020 at 11:12 AM via <qemu-devel@nongnu.org> wrote:
> > >>>> Hi Anup,
> > >>>>
> > >>>> On 8/17/20 11:30 AM, Bin Meng wrote:
> > >>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > >>>>>
> > >>>>> Hi Anup,
> > >>>>>
> > >>>>> On Sat, Aug 15, 2020 at 1:44 AM Anup Patel <anup@brainfault.org> wrote:
> > >>>>>> On Fri, Aug 14, 2020 at 10:12 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >>>>>>> From: Bin Meng <bin.meng@windriver.com>
> > >>>>>>>
> > >>>>>>> This adds support for Microchip PolarFire SoC Icicle Kit board.
> > >>>>>>> The Icicle Kit board integrates a PolarFire SoC, with one SiFive's
> > >>>>>>> E51 plus four U54 cores and many on-chip peripherals and an FPGA.
> > >>>>>> Nice Work !!! This is very helpful.
> > >>>>> Thanks!
> > >>>>>
> > >>>>>> The Microchip HSS is quite convoluted. It has:
> > >>>>>> 1. DDR Init
> > >>>>>> 2. Boot device support
> > >>>>>> 3. SBI support using OpenSBI as library
> > >>>>>> 4. Simple TEE support
> > >>>>>>
> > >>>>>> I think point 1) and 2) above should be part of U-Boot SPL.
> > >>>>>> The point 3) can be OpenSBI FW_DYNAMIC.
> > >>>>>>
> > >>>>>> Lastly,for point 4), we are working on a new OpenSBI feature using
> > >>>>>> which we can run independent Secure OS and Non-Secure OS using
> > >>>>>> U-Boot_SPL+OpenSBI (for both SiFive Unleashed and Microchip
> > >>>>>> PolarFire).
> > >>>>>>
> > >>>>>> Do you have plans for adding U-Boot SPL support for this board ??
> > >>>>> + Cyril Jean from Microchip
> > >>>>>
> > >>>>> I will have to leave this question to Cyril to comment.
> > >>>>>
> > >>>> I currently do not have a plan to support U-Boot SPL. The idea of the
> > >>>> HSS is to contain all the silicon specific initialization and
> > >>>> configuration code within the HSS before jumping to U-Boot S-mode. I
> > >>>> would rather keep all this within the HSS for the time being. I would
> > >>>> wait until we reach production silicon before attempting to move this to
> > >>>> U-Boot SPL as the HSS is likely to contain some opaque silicon related
> > >>>> changes for another while.
> > >>> That is unfortunate, a lot of work has gone into making the boot flow
> > >>> simple and easy to use.
> > >>>
> > >>> QEMU now includes OpenSBI by default to make it easy for users to boot
> > >>> Linux. The Icicle Kit board is now the most difficult QEMU board to
> > >>> boot Linux on. Not to mention it makes it hard to impossible to
> > >>> support it in standard tool flows such as meta-riscv.
> > >>>
> > >>> Alistair
> > >> If it is such a problem we can add a U-Boot SPL stage and the HSS can be
> > >> treated as standard SoC ROM code.
> > > It's not mandatory for U-Boot SPL to have stable DRAM calibration settings
> > > from the start itself. The initial U-Boot SPL support for most
> > > platforms (accross
> > > architectures) usually include basic working DRAM calibration settings which
> > > is later on updated with separate patches. Also, we don't need all U-Boot
> > > drivers to be upstreamed in one-go as this can be done in phases.
> > >
> > > The advantage we have with PolarFire SoC Icicle board is that we already
> > > have a U-Boot S-mode. and we believe the OpenSBI generic platform will
> > > work fine for PolarFire SoC Icicle board so the only thing missing right now
> > > is the U-Boot SPL support for OpenSource boot-flow.
> > >
> > > It will certainly accelerate open-source development if we have boot-flow
> > > U-Boot_SPL => OpenSBI (FW_DYNAMIC) => U-Boot_S-mode working
> > > on PolarFire SoC Icicle board. Initially, we just need DRAM, SD/eMMC,
> > > and Serial port support for U-Boot SPL and U-Boot S-mode. Later on,
> > > more patches can add ethernet and other booting device drivers to U-Boot.
> > >
> > > Regarding security services of HSS, we are working on a OpenSBI
> > > feature which will allow HSS security services to run as independent
> > > binary in M-mode (not linked to OpenSBI) and OpenSBI FW_DYNAMIC
> > > will be a separate binary acting as a secure monitor.
> > >
> > > Regards,
> > > Anup
> >
> > What I have in mind is that the external memory will be up and running
> > by the time we get to U-Boot SPL. In the case of PolarFire SoC the ROM
> > code equivalent brings up the DDR memory interface so we do not need to
> > worry about this as part of U-Boot.
>
> Keeping DRAM configuration as part of a separate ROM booting stage prior
> to the U-Boot SPL sounds good to me. This will lead to following boot-flow:
>
> ROM/HSS (M-mode) => U-Boot SPL (M-mode) => OpenSBI (M-mode) => U-Boot S-mode

If we want to keep the HSS, meaning that DDR memory is already
initialized, then there is no need to create an additional step of
U-Boot SPL phase, because there is no size limitation any more.

Right now, the boot workflow on PolarFire is:

HSS + OpenSBI (as a library) (M-mode) => U-Boot S-mode

It's just not the canonical way because of the HSS and OpenSBI as a library.

A canonical way should be:

U-Boot SPL (M-mode) => OpenSBI dynamic (M-mode) => U-Boot S-mode

So we should be aiming to replace HSS with U-Boot SPL.

>
> >
> > Sounds to me the component that needs to be upstreamed next is the eMMC
> > support so that it can be used as part of U-Boot SPL. Correct?
>
> Maybe as a PHASE1 patch series for PolarFire U-Boot support can
> target the following:
> 1. Minimal U-Boot board support for PolarFire IcIcle Board with
> single defconfig to build both U-Boot SPL and U-Boot S-mode
> 2. Serial port driver (probably re-use existing driver)
> 3. SD and eMMC driver
>
> Supporting SD booting is highly desirable for PHASE1. At least,
> U-Boot SPL, OpenSBI, U-Boot S-mode, and Linux should come
> as separate images from SD card. The ROM/HSS can reside and
> boot from on-board flash/eMMC.
>
> Above is my suggestion based on experience with SiFive Unleashed.
>
> The general idea behind OpenSource boot-flow is to have each
> booting stage as a separate binary so that users can selectively
> upgrade a particular booting stage without re-compiling/re-flashing
> other booting stages.
>
> Various distros and yocto already support building most of the above
> booting stages (U-Boot, OpenSBI, Linux, etc) so we can reuse a lot
> of existing work. Eventually, I am confident we will endup moving
> more stuff from ROM/HSS to U-Boot SPL for ease in maintenance.

Regards,
Bin

