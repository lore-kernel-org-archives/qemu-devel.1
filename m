Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31604C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70BC20720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvhgjR3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70BC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Bsc-0006xI-5W
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 14:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k9Brl-0006Pg-Fv; Fri, 21 Aug 2020 14:34:17 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k9Brh-0001Uo-Ki; Fri, 21 Aug 2020 14:34:16 -0400
Received: by mail-il1-x144.google.com with SMTP id t13so2196371ile.9;
 Fri, 21 Aug 2020 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xY2cZoHLVY9m/I7gbmOoXcPqllngxC+c5eWN9Pv7Abk=;
 b=mvhgjR3BOSpDT8MixyhqoKkZZY3CkDwkugN1xZxAXhJEi3xgyLcQUMsAL5iE3Gq6Mg
 u9iHwncb8eM0V8OPMrjjpUhTPsUFqQFXa5o5aZQFWnMCHNoRpFjUeVlojY453Ax7CbLj
 xysxT1S2jUZ6CacNAPYOK08k2eoy7LPV9IWEymdcWqBq9H1n3jLK6HYx+9Fbiz8nZyZC
 7O6anB/dh5U4gQ8w53CFiziSA/LrRrqXz3QPy8MSxG0lkm9HQRhQzR3gng+FrNGPtRJp
 rmH8mD3Il/8v99hwNM8HqECAuRE1ql1kFSLRRUwfqjXoOxxm+xx7YasBPxdWDp3bf41i
 2a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xY2cZoHLVY9m/I7gbmOoXcPqllngxC+c5eWN9Pv7Abk=;
 b=n/yiM8kpheM/Qex+8rkvGDy73gGFS15eiKhOGQ5VlJgs+bnejvJL3ziA1U54rvTAsK
 rHcSapDsduCzFTkhOqb6+WCSUX51QPYLqjdF24dMHTrPVPi/UwBobwf14Ote8+OSt3Rx
 AggQIIwkvMmLayG18BlIoQpBdaMQHhm5GstQ9+4c1jGC6YzZUHBT/ehi65WZnBKUjBD9
 kpfNYtpbBxuQfUsfnB5amM285MH/jcfDJFMGmZu0QyuzgQ5Nk/EGfejOQyQGjT/TXOh0
 qovihSVmvhZOEkpWm9wcYaQYpFx/gkimUphuyHgIuEAKS0p7bno6/3XG9ZV8Wdw0cKoz
 UBgg==
X-Gm-Message-State: AOAM532QHzh1Pc2Ou7X+4s31+66DGJqk7z4WnfTJPJT1gl28eEb1cZJx
 K1TsZw+LPwQX/JHIahZDMCoJI3onZV2drJny80g=
X-Google-Smtp-Source: ABdhPJxcenQS4oT97mcUVACyvOgX8Sl/y64/2riUqA5ElAL/lNKCHNPOxYYmYH44nXt9fLaSDsvXPob9dcmT6RaT8qo=
X-Received: by 2002:a05:6e02:ed4:: with SMTP id
 i20mr3578160ilk.267.1598034851990; 
 Fri, 21 Aug 2020 11:34:11 -0700 (PDT)
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
 <CAEUhbmUWcTxv70yuLMXwniGXB6zkadcpB4YTq=8F9UcXRK72+g@mail.gmail.com>
 <9d6dd97b-20de-2be1-68eb-6ea2cf5b3ffc@microchip.com>
In-Reply-To: <9d6dd97b-20de-2be1-68eb-6ea2cf5b3ffc@microchip.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 21 Aug 2020 11:23:34 -0700
Message-ID: <CAKmqyKMp70-JzmmyMujpZpk=eL595Cme7edx3ktqHuBoYt8KxQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
To: Cyril.Jean@microchip.com
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <anup@brainfault.org>,
 Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 3:13 AM <Cyril.Jean@microchip.com> wrote:
>
> On 8/19/20 2:34 AM, Bin Meng wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On Tue, Aug 18, 2020 at 9:55 PM Anup Patel <anup@brainfault.org> wrote:
> >> On Tue, Aug 18, 2020 at 6:39 PM <Cyril.Jean@microchip.com> wrote:
> >>> On 8/18/20 7:17 AM, Anup Patel wrote:
> >>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>>
> >>>> On Tue, Aug 18, 2020 at 1:23 AM <Cyril.Jean@microchip.com> wrote:
> >>>>> On 8/17/20 8:28 PM, Alistair Francis wrote:
> >>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>>>>
> >>>>>> On Mon, Aug 17, 2020 at 11:12 AM via <qemu-devel@nongnu.org> wrote:
> >>>>>>> Hi Anup,
> >>>>>>>
> >>>>>>> On 8/17/20 11:30 AM, Bin Meng wrote:
> >>>>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>>>>>>
> >>>>>>>> Hi Anup,
> >>>>>>>>
> >>>>>>>> On Sat, Aug 15, 2020 at 1:44 AM Anup Patel <anup@brainfault.org> wrote:
> >>>>>>>>> On Fri, Aug 14, 2020 at 10:12 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >>>>>>>>>> From: Bin Meng <bin.meng@windriver.com>
> >>>>>>>>>>
> >>>>>>>>>> This adds support for Microchip PolarFire SoC Icicle Kit board.
> >>>>>>>>>> The Icicle Kit board integrates a PolarFire SoC, with one SiFive's
> >>>>>>>>>> E51 plus four U54 cores and many on-chip peripherals and an FPGA.
> >>>>>>>>> Nice Work !!! This is very helpful.
> >>>>>>>> Thanks!
> >>>>>>>>
> >>>>>>>>> The Microchip HSS is quite convoluted. It has:
> >>>>>>>>> 1. DDR Init
> >>>>>>>>> 2. Boot device support
> >>>>>>>>> 3. SBI support using OpenSBI as library
> >>>>>>>>> 4. Simple TEE support
> >>>>>>>>>
> >>>>>>>>> I think point 1) and 2) above should be part of U-Boot SPL.
> >>>>>>>>> The point 3) can be OpenSBI FW_DYNAMIC.
> >>>>>>>>>
> >>>>>>>>> Lastly,for point 4), we are working on a new OpenSBI feature using
> >>>>>>>>> which we can run independent Secure OS and Non-Secure OS using
> >>>>>>>>> U-Boot_SPL+OpenSBI (for both SiFive Unleashed and Microchip
> >>>>>>>>> PolarFire).
> >>>>>>>>>
> >>>>>>>>> Do you have plans for adding U-Boot SPL support for this board ??
> >>>>>>>> + Cyril Jean from Microchip
> >>>>>>>>
> >>>>>>>> I will have to leave this question to Cyril to comment.
> >>>>>>>>
> >>>>>>> I currently do not have a plan to support U-Boot SPL. The idea of the
> >>>>>>> HSS is to contain all the silicon specific initialization and
> >>>>>>> configuration code within the HSS before jumping to U-Boot S-mode. I
> >>>>>>> would rather keep all this within the HSS for the time being. I would
> >>>>>>> wait until we reach production silicon before attempting to move this to
> >>>>>>> U-Boot SPL as the HSS is likely to contain some opaque silicon related
> >>>>>>> changes for another while.
> >>>>>> That is unfortunate, a lot of work has gone into making the boot flow
> >>>>>> simple and easy to use.
> >>>>>>
> >>>>>> QEMU now includes OpenSBI by default to make it easy for users to boot
> >>>>>> Linux. The Icicle Kit board is now the most difficult QEMU board to
> >>>>>> boot Linux on. Not to mention it makes it hard to impossible to
> >>>>>> support it in standard tool flows such as meta-riscv.
> >>>>>>
> >>>>>> Alistair
> >>>>> If it is such a problem we can add a U-Boot SPL stage and the HSS can be
> >>>>> treated as standard SoC ROM code.
> >>>> It's not mandatory for U-Boot SPL to have stable DRAM calibration settings
> >>>> from the start itself. The initial U-Boot SPL support for most
> >>>> platforms (accross
> >>>> architectures) usually include basic working DRAM calibration settings which
> >>>> is later on updated with separate patches. Also, we don't need all U-Boot
> >>>> drivers to be upstreamed in one-go as this can be done in phases.
> >>>>
> >>>> The advantage we have with PolarFire SoC Icicle board is that we already
> >>>> have a U-Boot S-mode. and we believe the OpenSBI generic platform will
> >>>> work fine for PolarFire SoC Icicle board so the only thing missing right now
> >>>> is the U-Boot SPL support for OpenSource boot-flow.
> >>>>
> >>>> It will certainly accelerate open-source development if we have boot-flow
> >>>> U-Boot_SPL => OpenSBI (FW_DYNAMIC) => U-Boot_S-mode working
> >>>> on PolarFire SoC Icicle board. Initially, we just need DRAM, SD/eMMC,
> >>>> and Serial port support for U-Boot SPL and U-Boot S-mode. Later on,
> >>>> more patches can add ethernet and other booting device drivers to U-Boot.
> >>>>
> >>>> Regarding security services of HSS, we are working on a OpenSBI
> >>>> feature which will allow HSS security services to run as independent
> >>>> binary in M-mode (not linked to OpenSBI) and OpenSBI FW_DYNAMIC
> >>>> will be a separate binary acting as a secure monitor.
> >>>>
> >>>> Regards,
> >>>> Anup
> >>> What I have in mind is that the external memory will be up and running
> >>> by the time we get to U-Boot SPL. In the case of PolarFire SoC the ROM
> >>> code equivalent brings up the DDR memory interface so we do not need to
> >>> worry about this as part of U-Boot.
> >> Keeping DRAM configuration as part of a separate ROM booting stage prior
> >> to the U-Boot SPL sounds good to me. This will lead to following boot-flow:
> >>
> >> ROM/HSS (M-mode) => U-Boot SPL (M-mode) => OpenSBI (M-mode) => U-Boot S-mode
> > If we want to keep the HSS, meaning that DDR memory is already
> > initialized, then there is no need to create an additional step of
> > U-Boot SPL phase, because there is no size limitation any more.
> >
> > Right now, the boot workflow on PolarFire is:
> >
> > HSS + OpenSBI (as a library) (M-mode) => U-Boot S-mode
> >
> > It's just not the canonical way because of the HSS and OpenSBI as a library.
> >
> > A canonical way should be:
> >
> > U-Boot SPL (M-mode) => OpenSBI dynamic (M-mode) => U-Boot S-mode
> >
> > So we should be aiming to replace HSS with U-Boot SPL.
> >
> >>> Sounds to me the component that needs to be upstreamed next is the eMMC
> >>> support so that it can be used as part of U-Boot SPL. Correct?
> >> Maybe as a PHASE1 patch series for PolarFire U-Boot support can
> >> target the following:
> >> 1. Minimal U-Boot board support for PolarFire IcIcle Board with
> >> single defconfig to build both U-Boot SPL and U-Boot S-mode
> >> 2. Serial port driver (probably re-use existing driver)
> >> 3. SD and eMMC driver
> >>
> >> Supporting SD booting is highly desirable for PHASE1. At least,
> >> U-Boot SPL, OpenSBI, U-Boot S-mode, and Linux should come
> >> as separate images from SD card. The ROM/HSS can reside and
> >> boot from on-board flash/eMMC.
> >>
> >> Above is my suggestion based on experience with SiFive Unleashed.
> >>
> >> The general idea behind OpenSource boot-flow is to have each
> >> booting stage as a separate binary so that users can selectively
> >> upgrade a particular booting stage without re-compiling/re-flashing
> >> other booting stages.
> >>
> >> Various distros and yocto already support building most of the above
> >> booting stages (U-Boot, OpenSBI, Linux, etc) so we can reuse a lot
> >> of existing work. Eventually, I am confident we will endup moving
> >> more stuff from ROM/HSS to U-Boot SPL for ease in maintenance.
> > Regards,
> > Bin
>
> I am OK with supporting U-Boot SPL as a community boot flow but the HSS
> is not going to disappear completely for many PolarFire SoC deployments.
> We need to have the HSS running on the monitor core after the system has
> booted for various reasons. Some of the current HSS functionalities can
> be migrated at a later time.
>
> The HSS was designed to easily enable and disable features through
> Kconfig which should allow to assign features to different boot stages
> depending on the overall system deployment. Keeping the HSS as ROM code
> capable of starting various early boot stages in either M mode or S mode
> allows us (Microchip engineering and non pure Linux users) to mix
> different operating systems on the same platform and more easily debug
> hardware bring-up.

Thanks for explaining this.

I have changed the CC list a bit to be a little more targeted.

>
> What I am trying to get at is that we need to balance the QEMU ease of
> use with the ability to bring-up and debug actual hardware. My preferred

Agreed. I don't think anyone has been saying that these changes should
be for QEMU only. All of the changes talked about apply to both the
QEMU model and the hardware.

> approach is to keep all the hardware bring up in one place, the HSS, so
> that you do not have to worry about obscure silicon idiosyncrasies once
> you reach the open source boot flow. Silicon/board bring up

That is a noble goal, but doesn't HSS currently pull in the OpenSBI
library, so it's doing more than just dealing with silicon bugs. As
well as that HSS is not supported by distros, so distros can't build
or ship it. For example OE won't build it in the meta-riscv layer,
meaning that the Icle board just isn't supported. This means the board
misses out on core work, for example it won't be able to utilise the
RISC-V AGL work that has started.

Also, how are users expected to update HSS as bugs and vulnerabilities
are found if it isn't shipped by distros?

> steps/features can be brought out of the HSS into the open source boot
> stages once these steps are mature.
>
> PolarFire SoC is the third family of SoC FPGA I have worked on. So I
> have a fair idea of the amount of pain in front of me to bring the
> entire device family to market :-) We decided early on in the
> architecture of PolarFire SoC that we would make all code executing on
> the RISC-V processors open source and user modifiable. This includes all

Awesome!!! That is so great to hear.

> code typically hidden away in your typical SoC ROM code. This is why

Again, this is just awesome!

> PolarFire SoC has on-chip flash memory used to store the HSS and why the
> HSS should be thought as including ROM code. The current Icicle Kit uses

If we could change it to be more like a traditional ROM in terms of
features then that would be really helpful. In that case we wouldn't
need it for QEMU and only use it for hardware. It would only handle
basic hardware boot up and then hand it over to U-Boot SPL/OpenSBI.

> engineering samples from the first device in the PolarFire SoC family.
> So we are really at the beginning of the process of validating very
> early boot steps on a significant number of devices. I do not want to
> expose the open source community to the pain of bringing up a family of
> devices because of the decision to open source all code. So I am asking

I understand what you mean. In saying that it is usually easiest to
start with the goal of upstreaming and then work towards that. That
way all of the architectures decisions are made in that context. Maybe
at first you have a fork while everything is in flux, but then it's
really helpful to have the work upstreamed.

I think we have all seen too many "open source" projects that just
fork everything, dump their code and never contribute back.
Unfortunately when that happens we end up with duplicate work and
frustrated engineers. As well as that the original project misses out
on all the advantages of open source as they aren't benefiting from
others work as well.

> you to not rush in trying to migrate components from the HSS to a later
> boot stage just yet. It can be done but based on experience I think that
> now is not the right time yet.

The open source focus is great to hear. I think we are all really glad
that MicroChip is doing this. It's a great first step, but it doesn't
end there.

Alistair

>
> Regards,
>
> Cyril.
>

