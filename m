Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E689AC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 00:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361C72087D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 00:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q0GbbLRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361C72087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGWY5-0004JW-82
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 20:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kGWXS-0003kB-8E
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 20:03:38 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44]:43824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kGWXO-0006Lb-8U
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 20:03:37 -0400
Received: by mail-vk1-xa44.google.com with SMTP id t189so1987382vka.10
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 17:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ex2ScRsljyOtKd7OP8bfM4hRKTdwRV8x4IggfxFhtoI=;
 b=Q0GbbLRQ3g7w+MPBeAr3OJr4FNRlrgOnezrmSV6z433UMqufSeBaOXP0r5bZ5lHnPS
 zEQ0zpNvoTFWv/7M6wszHOxDjGtBmnSwRBAGytPW+npyrIpTrVruZhA1S3BZ5Na/5dG9
 Ur0kciZQOlEJ8Vn5+U9YnFwxoxKNFPlml/n/L5r0bJ5hLokoO3XRfuwCTVCmdoTVOU+2
 HmT7wWKbO/om6cXO0+otnzwOtz/AfaZLWb8BcjimBOC9y2p2ti/Z9K+WbeGeNTaAkfjH
 BLtcIBtNtVbfYpw2sm3RNXYIruugZQ0gjWwA7ZcOc1IputM5mkKrXAkwxX0g8IYmmYXh
 RC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ex2ScRsljyOtKd7OP8bfM4hRKTdwRV8x4IggfxFhtoI=;
 b=FSij6CwRlGazYgyN8+imkYLnN0KeVRwfyiP7wWozpYztDGAKP++qUEmETzDroOPCDs
 HgclnUX4eKEKrNDaY6eWuXwA8UoTKM2ZKa2S2ucSx6nUEJuJp1LPXpFjiAwnRaTE2KZ2
 LlTyVSv4oAogUxN2clT8Ms+KbpQKSZ9pjbHSnWTe9zZUpw/ijjjrU7Lt7+Bgfj5eMAp/
 FaulRtrGYC1Sd/wANbESPXoLADMl9rE+YYmlj/b4O9Cb4sShn8EAU5UQjgzPtYpm/nCc
 H2Jm31EedMDBlk1LrvUipuOMkkKaIaiyLMJrLx0eOP63Ob7m8aPaZPNs+Ta8hzqF5Q13
 sa7w==
X-Gm-Message-State: AOAM530NVNxKLw3mAOGJ8G9tvQOKlaHxnk0iv/33BskCcRY7byw7MPv5
 D9UA86egRKjDwnTo4tj/MhCxDI0c7S8Z2Vhm6LNZ8w==
X-Google-Smtp-Source: ABdhPJwdJipA1Vok6BQxI0BKh1poi21mK7AlS/dtflqo6pNXkqhFalS8DZ1YJMi9EeXrCdj//WJEQP+nCo0Gc/vO70s=
X-Received: by 2002:a1f:c641:: with SMTP id w62mr6031901vkf.11.1599782612883; 
 Thu, 10 Sep 2020 17:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200825001711.1340443-1-hskinnemoen@google.com>
 <20200908150224.pkuyhpmw33xqhmjn@mozz.bu.edu>
 <d88bc6ae-e07e-700f-d3cc-c093d2d44594@amsat.org>
 <bfb442b4-9700-5591-eeef-00bc6675c89f@amsat.org>
 <CAFQmdRZfmbgUgUh3iryPQs5LfiYpn2cHWPzjBdJKSXANFFtT6g@mail.gmail.com>
 <CAFQmdRb1ye0mZjt1PYhqNiGMQMP1iBFWVsEhW5ADWYS5G5qteQ@mail.gmail.com>
In-Reply-To: <CAFQmdRb1ye0mZjt1PYhqNiGMQMP1iBFWVsEhW5ADWYS5G5qteQ@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Thu, 10 Sep 2020 17:03:21 -0700
Message-ID: <CAFQmdRabaHFPC3X_xmpjt8Vj3DOxS6y4wcanhpPz4S1vokVHTQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alexander Bulekov <alxndr@bu.edu>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, CS20 KFTing <kfting@nuvoton.com>
Content-Type: multipart/alternative; boundary="0000000000005c336605aefe6a4e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a44;
 envelope-from=hskinnemoen@google.com; helo=mail-vk1-xa44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005c336605aefe6a4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2020 at 6:32 PM Havard Skinnemoen <hskinnemoen@google.com>
wrote:

> On Tue, Sep 8, 2020 at 12:52 PM Havard Skinnemoen
> <hskinnemoen@google.com> wrote:
> >
> > On Tue, Sep 8, 2020 at 9:58 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org>
> wrote:
> > >
> > > On 9/8/20 5:52 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > > On 9/8/20 5:02 PM, Alexander Bulekov wrote:
> > > >> Hi Havard,
> > > >> I fuzzed the npcm750-evb machine until I hit over 85% coverage ove=
r
> all
> > > >> the new npcm.*\.c files. The only thing I found specific to the ne=
w
> > > >> code, so far:
> > > >>
> > > >> cat << EOF | ./qemu-system-arm -machine npcm750-evb -m 128M -qtest
> stdio
> > > >> write 0xf0009040 0x4 0xc4c4c4c4
> > > >> write 0xf0009040 0x4 0x4
> > > >> EOF
> > > >
> > > > This is an odd test because with -qtest the timer is not running,
> > > > so this can not really happen on real hw.
> > > >
> > > > The fix is:
> > > >
> > > > -    g_assert(t->remaining_ns > 0);
> > > > +    g_assert(qtest_enabled() || t->remaining_ns > 0);
> > >
> > > Alex corrected me on IRC, qtest is irrelevant here.
> > > The problem is he disables the timer twice.
> > >
> > > So maybe something like:
> > >
> > >  static void npcm7xx_timer_pause(NPCM7xxTimer *t)
> > >  {
> > >      int64_t now;
> > >
> > > +    if (!timer_pending(&t->qtimer)) {
> > > +        return;
> > > +    }
> > >      timer_del(&t->qtimer);
> > >      now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > >      t->remaining_ns =3D t->expires_ns - now;
> > >      g_assert(t->remaining_ns > 0);
> > >  }
> >
> > Thanks, that makes sense. I was worried that making the assert
> > conditional on qtest_enabled() might hide real issues.
>
> Hmm, that didn't help, though it might make sense to keep it there anyway=
.
>
> What the test case does is:
>
>   1. Enable the timer (with zero expiration time) and reset it at the sam=
e
> time.
>   2. Disable the timer zero cycles after it was enabled.
>
> It also touches a bunch of other bits (including reserved bits), but
> they should be irrelevant.
>
> I think there are two issues here.
>
> When the Reset bit is set, the Enable bit should be forced to zero.
> This is easy to fix.
>
> If the timer is enabled with zero expiration time, and immediately
> disabled without advancing the virtual time, npcm7xx_timer_pause() is
> called while the timer is active, but t->expires_ns =3D=3D
> qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL). So t->remaining_ns becomes zero
> and triggers the assertion.
>
> If I revert a change that Philippe asked me to do earlier:
>
>     timer_del(&t->qtimer);
>      now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>      t->remaining_ns =3D t->expires_ns - now;
> -    g_assert(t->remaining_ns > 0);
> +    if (t->remaining_ns <=3D 0) {
> +        npcm7xx_timer_reached_zero(t);
> +    }
>  }
>
> it doesn't crash:
>
> $ cat << EOF | ./qemu-system-arm -machine npcm750-evb -m 128M -qtest
> stdio --trace npcm7xx_timer*
> write 0xf0009040 0x4 0xc4c4c4c4
> write 0xf0009040 0x4 0x4
> EOF
> [I 1599613445.620379] OPENED
> [R +0.180771] write 0xf0009040 0x4 0xc4c4c4c4
> 1361079@1599613445.801182:npcm7xx_timer_write /machine/soc/tim[1]
> offset: 0x0040 value 0xc4c4c4c4
> OK
> [S +0.180816] OK
> [R +0.180833] write 0xf0009040 0x4 0x4
> 1361079@1599613445.801220:npcm7xx_timer_write /machine/soc/tim[1]
> offset: 0x0040 value 0x00000000
> 1361079@1599613445.801295:npcm7xx_timer_irq /machine/soc/tim[1] timer 4
> state 0
> OK
> [S +0.180927] OK
> [I +0.181319] CLOSED
> [I +4.003267] CLOSED
>
> Note that the npcm7xx_timer_irq trace event is a sign of the first
> bug, but fixing that might mask the second bug. If we write the same
> pattern, only without the Reset bit, this would be the correct
> behavior (and it still causes the v8 code to crash).
>
> I think this device deserves a qtest. I wonder if we'd trigger the
> assertion if we set a nonzero expiration time, but happen to clear the
> Enable bit on the exact cycle it's supposed to expire. That would be a
> more realistic scenario, as it wouldn't require multiple register
> writes in the same virtual clock cycle.
>

I wrote some qtests, and found several more bugs, but I wasn't able to
trigger this particular failure mode. I was able to reproduce both of the
bugs found by the fuzzer though.

I'll refresh the patch series tonight or tomorrow, and also send the qtest
to Nuvoton (and probably send it to the list within the next few weeks or
so).


> I probably won't add the qtest to the same series, as I'd like someone
> from Nuvoton to get a chance to review it first.
>
> Havard
>
> >
> > This fuzz testing is great, it would have been hard to find this bug
> > without it. Thanks a lot Alex for running it.
> >
> > Havard
> >
> > > >
> > > >>
> > > >> ERROR:../hw/timer/npcm7xx_timer.c:160:npcm7xx_timer_pause:
> assertion failed: (t->remaining_ns > 0)
> > > >> Bail out!
> ERROR:../hw/timer/npcm7xx_timer.c:160:npcm7xx_timer_pause: assertion
> failed: (t->remaining_ns > 0)
> > > >> Aborted
> > > >>
> > > >> I'm doing the same for the quanta-gsj machine, but I'm not sure
> whether
> > > >> it will cover more code, so I'm happy to leave a:
> > > >>
> > > >> Tested-by: Alexander Bulekov <alxndr@bu.edu>
> > > >>
> > > >> for the patches that add new virtual-device code (1-5, 7-12 ?)
> > > >> -Alex
> > > >
> > > > Very nice from you for testing running the fuzzer!
> > > >
> > > > Regards,
> > > >
> > > > Phil.
> > > >
> > > >>
> > > >>
> > > >> On 200824 1716, Havard Skinnemoen via wrote:
> > > >>> I also pushed this and the previous patchsets to my qemu fork on
> github.
> > > >>> The branches are named npcm7xx-v[1-8].
> > > >>>
> > > >>>   https://github.com/hskinnemoen/qemu
> > > >>>
> > > >>> This patch series models enough of the Nuvoton NPCM730 and NPCM75=
0
> SoCs to boot
> > > >>> an OpenBMC image built for quanta-gsj. This includes device model=
s
> for:
> > > >>>
> > > >>>   - Global Configuration Registers
> > > >>>   - Clock Control
> > > >>>   - Timers
> > > >>>   - Fuses
> > > >>>   - Memory Controller
> > > >>>   - Flash Controller
> > > >>>
> > > >>> These modules, along with the existing Cortex A9 CPU cores and
> built-in
> > > >>> peripherals, are integrated into a NPCM730 or NPCM750 SoC, which
> in turn form
> > > >>> the foundation for the quanta-gsj and npcm750-evb machines,
> respectively. The
> > > >>> two SoCs are very similar; the only difference is that NPCM730 is
> missing some
> > > >>> peripherals that NPCM750 has, and which are not considered
> essential for
> > > >>> datacenter use (e.g. graphics controllers). For more information,
> see
> > > >>>
> > > >>> https://www.nuvoton.com/products/cloud-computing/ibmc/
> > > >>>
> > > >>> Both quanta-gsj and npcm750-evb correspond to real boards
> supported by OpenBMC.
> > > >>> At the end of the series, qemu can boot an OpenBMC image built fo=
r
> one of these
> > > >>> boards with some minor modifications.
> > > >>>
> > > >>> The patches in this series were developed by Google and reviewed
> by Nuvoton. We
> > > >>> will be maintaining the machine and peripheral support together.
> > > >>>
> > > >>> The data sheet for these SoCs is not generally available. Please
> let me know if
> > > >>> more comments are needed to understand the device behavior.
> > > >>>
> > > >>> Changes since v7:
> > > >>>
> > > >>>   - Move register enums to .c files throughout, leaving a single
> > > >>>     NPCM7XX_FOO_NR_REGS definition behind in the .h file. A
> QEMU_BUILD_BUG_ON
> > > >>>     should alert anyone accidentally expanding the register enum
> that they need
> > > >>>     to update the corresponding NR_REGS define, which in turn has
> a comment
> > > >>>     reminding them to update the vmstate version_id as well.
> > > >>>   - Skip loading the bootrom if a kernel filename is provided by
> the user.
> > > >>>   - New patch adding a board setup stub to tweak clocks before
> booting directly
> > > >>>     into the kernel.
> > > >>>   - Add stuff to meson files instead of Makefiles.
> > > >>>   - Try to disable the slowest drivers and services to speed up
> the flash boot
> > > >>>     acceptance test a bit. This is somewhat based on the followin=
g
> > > >>>     systemd-analyze blame report:
> > > >>>
> https://gist.github.com/hskinnemoen/475cb0676530cd2cebaa1754cf16ca97
> > > >>>
> > > >>> Changes since v6:
> > > >>>
> > > >>>   - Use size_to_str to report DRAM sizes in npcm7xx_gcr.
> > > >>>   - Simplify the interrupt logic in npcm7xx_timer.
> > > >>>   - Update global bios_name instead of temporary.
> > > >>>   - Add npcm7xx_bootrom to MAINTAINERS and pc-bios/README.
> > > >>>   - Use a predefined name for the gsj boot image in the acceptanc=
e
> test.
> > > >>>
> > > >>> Changes since v5:
> > > >>>
> > > >>>   - Boot ROM included, as a git submodule and a binary blob, and
> loaded by
> > > >>>     default, so the -bios option is usually not necessary anymore=
.
> > > >>>   - Two acceptance tests added (openbmc image boot, and direct
> kernel boot).
> > > >>>   - npcm7xx_load_kernel() moved to SoC code.
> > > >>>   - NPCM7XX_TIMER_REF_HZ definition moved to CLK header.
> > > >>>   - Comments added clarifying available SPI flash chip selects.
> > > >>>   - Error handling adjustments:
> > > >>>       - Errors from CPU and GCR realization are propagated throug=
h
> the SoC
> > > >>>         since they may be triggered by user-configurable
> parameters.
> > > >>>       - Machine init uses error_fatal instead of error_abort for
> SoC
> > > >>>         realization flash init. This makes error messages more
> helpful.
> > > >>>       - Comments added to indicate whether peripherals may fail t=
o
> realize.
> > > >>>       - Use ERRP_GUARD() instead of Error *err when possible.
> > > >>>   - Default CPU type is now set, and attempting to set it to
> anything else
> > > >>>     will fail.
> > > >>>   - Format string fixes (use HWADDR_PRIx, etc.)
> > > >>>   - Simplified memory size encoding and error checking in
> npcm7xx_gcr.
> > > >>>   - Encapsulate non-obvious pointer subtraction into helper
> functions in the
> > > >>>     FIU and TIMER modules.
> > > >>>   - Incorporate review feedback into the FIU module:
> > > >>>       - Add select/deselect trace events.
> > > >>>       - Use npcm7xx_fiu_{de,}select() consistently.
> > > >>>       - Use extract/deposit in more places for consistency.
> > > >>>       - Use -Wimplicit-fallthrough compatible fallthrough comment=
s.
> > > >>>       - Use qdev_init_gpio_out_named instead of sysbus_init_irq
> for chip
> > > >>>         selects.
> > > >>>   - Incorporate review feedback into the TIMER module:
> > > >>>       - Assert that we never pause a timer that has already
> expired, instead of
> > > >>>         trying to handle it. This should be safe since
> QEMU_CLOCK_VIRTUAL is
> > > >>>         stopped while this code is running.
> > > >>>       - Simplify the switch blocks in the read and write handlers=
.
> > > >>>
> > > >>> I made a change to error out if a flash drive was not specified,
> but reverted
> > > >>> it because it caused make check to fail (qom-test). When
> specifying a NULL
> > > >>> block device, the m25p flash device initializes its in-memory
> storage with 0xff
> > > >>> and doesn't attempt to write anything back. This seems correct to
> me.
> > > >>>
> > > >>> Changes since v4:
> > > >>>
> > > >>>   - OTP cleanups suggested by Philippe Mathieu-Daud=C3=A9.
> > > >>>       - Added fuse array definitions based on public Nuvoton
> bootblock code.
> > > >>>       - Moved class structure to .c file since it's only used
> internally.
> > > >>>       - Readability improvements.
> > > >>>   - Split the first patch and folded parts of it into three other
> patches so
> > > >>>     that CONFIG_NPCM7XX is only enabled after the initial NPCM7xx
> machine
> > > >>>     support is added.
> > > >>>   - DRAM init moved to machine init code.
> > > >>>   - Consistently use lower-case hex literals.
> > > >>>   - Switched to fine-grained unimplemented devices, based on
> public bootblock
> > > >>>     source code. Added a tiny SRAM that got left out previously.
> > > >>>   - Simplified error handling in npcm7xx_realize() since the boar=
d
> code will
> > > >>>     abort anyway, and SoCs are not hot-pluggable.
> > > >>>
> > > >>> Changes since v3:
> > > >>>
> > > >>>   - License headers are now GPL v2-or-later throughout.
> > > >>>   - Added vmstate throughout (except the memory controller, which
> doesn't
> > > >>>     really have any state worth saving). Successfully booted a gs=
j
> image
> > > >>>     with two stop/savevm/quit/loadvm cycles along the way.
> > > >>>       - JFFS2 really doesn't like it if I let qemu keep running
> after savevm,
> > > >>>         and then jump back in time with loadvm. I assume this is
> expected.
> > > >>>   - Fixed an error API violation in npcm7xx_realize, removed
> pointless error
> > > >>>     check after object_property_set_link().
> > > >>>   - Switched the OTP device to use an embedded array instead of a
> g_malloc0'd
> > > >>>     one because I couldn't figure out how to set up vmstate for
> the latter.
> > > >>>
> > > >>> Changes since v2:
> > > >>>
> > > >>>   - Simplified the MAINTAINERS entry.
> > > >>>   - Added link to OpenPOWER jenkins for gsj BMC images.
> > > >>>   - Reverted the smpboot change, back to byte swapping.
> > > >>>   - Adapted to upstream API changes:
> > > >>>       - sysbus_init_child_obj -> object_initialize_child
> > > >>>       - object_property_set_bool -> qdev_realize / sysbus_realize
> > > >>>       - ssi_create_slave_no_init -> qdev_new
> > > >>>       - qdev_init_nofail -> qdev_realize_and_unref
> > > >>>       - ssi_auto_connect_slaves removed
> > > >>>   - Moved Boot ROM loading from soc to machine init.
> > > >>>   - Plumbed power-on-straps property from GCR to the machine init
> code so it
> > > >>>     can be properly initialized. Turns out npcm750 memory init
> doesn't work
> > > >>>     without this. npcm730 is fine either way, though I'm not sure
> why.
> > > >>>   - Reworked the flash init code so it looks more like aspeed
> (i.e. the flash
> > > >>>     device gets added even if there's no drive).
> > > >>>
> > > >>> Changes since v1 (requested by reviewers):
> > > >>>
> > > >>>   - Clarify the source of CLK reset values.
> > > >>>   - Made smpboot a constant byte array, eliinated byte swapping.
> > > >>>   - NPCM7xxState now stores an array of ARMCPUs, not pointers to
> ARMCPUs.
> > > >>>   - Clarify why EL3 is disabled.
> > > >>>   - Introduce NPCM7XX_NUM_IRQ constant.
> > > >>>   - Set the number of CPUs according to SoC variant, and disallow
> command line
> > > >>>     overrides (i.e. you can no longer override the number of CPUs
> with the -smp
> > > >>>     parameter). This is trying to follow the spirit of
> > > >>>     https://patchwork.kernel.org/patch/11595407/.
> > > >>>   - Switch register operations to DEVICE_LITTLE_ENDIAN throughout=
.
> > > >>>   - Machine documentation added (new patch).
> > > >>>
> > > >>> Changes since v1 to support flash booting:
> > > >>>
> > > >>>   - GCR reset value changes to get past memory initialization whe=
n
> booting
> > > >>>     from flash (patches 2 and 5):
> > > >>>       - INTCR2 now indicates that the DDR controller is
> initialized.
> > > >>>       - INTCR3 is initialized according to DDR memory size. A
> realize()
> > > >>>     method was implemented to achieve this.
> > > >>>   - Refactor the machine initialization a bit to make it easier t=
o
> drop in
> > > >>>     machine-specific flash initialization (patch 6).
> > > >>>   - Extend the series with additional patches to enable booting
> from flash:
> > > >>>       - Boot ROM (through the -bios option).
> > > >>>       - OTP (fuse) controller.
> > > >>>       - Memory Controller stub (just enough to skip memory
> training).
> > > >>>       - Flash controller.
> > > >>>       - Board-specific flash initialization.
> > > >>>
> > > >>> Thanks for reviewing,
> > > >>>
> > > >>> Havard
> > > >>>
> > > >>> Havard Skinnemoen (14):
> > > >>>   hw/misc: Add NPCM7xx System Global Control Registers device mod=
el
> > > >>>   hw/misc: Add NPCM7xx Clock Controller device model
> > > >>>   hw/timer: Add NPCM7xx Timer device model
> > > >>>   hw/arm: Add NPCM730 and NPCM750 SoC models
> > > >>>   hw/arm: Add two NPCM7xx-based machines
> > > >>>   roms: Add virtual Boot ROM for NPCM7xx SoCs
> > > >>>   hw/arm: Load -bios image as a boot ROM for npcm7xx
> > > >>>   hw/nvram: NPCM7xx OTP device model
> > > >>>   hw/mem: Stubbed out NPCM7xx Memory Controller model
> > > >>>   hw/ssi: NPCM7xx Flash Interface Unit device model
> > > >>>   hw/arm: Wire up BMC boot flash for npcm750-evb and quanta-gsj
> > > >>>   hw/arm/npcm7xx: add board setup stub for CPU and UART clocks
> > > >>>   docs/system: Add Nuvoton machine documentation
> > > >>>   tests/acceptance: console boot tests for quanta-gsj
> > > >>>
> > > >>>  docs/system/arm/nuvoton.rst            |  90 ++++
> > > >>>  docs/system/target-arm.rst             |   1 +
> > > >>>  Makefile                               |   1 +
> > > >>>  default-configs/arm-softmmu.mak        |   1 +
> > > >>>  include/hw/arm/npcm7xx.h               | 112 +++++
> > > >>>  include/hw/mem/npcm7xx_mc.h            |  36 ++
> > > >>>  include/hw/misc/npcm7xx_clk.h          |  48 +++
> > > >>>  include/hw/misc/npcm7xx_gcr.h          |  43 ++
> > > >>>  include/hw/nvram/npcm7xx_otp.h         |  79 ++++
> > > >>>  include/hw/ssi/npcm7xx_fiu.h           |  73 ++++
> > > >>>  include/hw/timer/npcm7xx_timer.h       |  78 ++++
> > > >>>  hw/arm/npcm7xx.c                       | 532
> +++++++++++++++++++++++
> > > >>>  hw/arm/npcm7xx_boards.c                | 197 +++++++++
> > > >>>  hw/mem/npcm7xx_mc.c                    |  84 ++++
> > > >>>  hw/misc/npcm7xx_clk.c                  | 266 ++++++++++++
> > > >>>  hw/misc/npcm7xx_gcr.c                  | 269 ++++++++++++
> > > >>>  hw/nvram/npcm7xx_otp.c                 | 439 +++++++++++++++++++
> > > >>>  hw/ssi/npcm7xx_fiu.c                   | 572
> +++++++++++++++++++++++++
> > > >>>  hw/timer/npcm7xx_timer.c               | 509
> ++++++++++++++++++++++
> > > >>>  .gitmodules                            |   3 +
> > > >>>  MAINTAINERS                            |  10 +
> > > >>>  hw/arm/Kconfig                         |   9 +
> > > >>>  hw/arm/meson.build                     |   1 +
> > > >>>  hw/mem/meson.build                     |   1 +
> > > >>>  hw/misc/meson.build                    |   4 +
> > > >>>  hw/misc/trace-events                   |   8 +
> > > >>>  hw/nvram/meson.build                   |   1 +
> > > >>>  hw/ssi/meson.build                     |   1 +
> > > >>>  hw/ssi/trace-events                    |  11 +
> > > >>>  hw/timer/meson.build                   |   1 +
> > > >>>  hw/timer/trace-events                  |   5 +
> > > >>>  pc-bios/README                         |   6 +
> > > >>>  pc-bios/npcm7xx_bootrom.bin            | Bin 0 -> 768 bytes
> > > >>>  roms/Makefile                          |   7 +
> > > >>>  roms/vbootrom                          |   1 +
> > > >>>  tests/acceptance/boot_linux_console.py |  83 ++++
> > > >>>  36 files changed, 3582 insertions(+)
> > > >>>  create mode 100644 docs/system/arm/nuvoton.rst
> > > >>>  create mode 100644 include/hw/arm/npcm7xx.h
> > > >>>  create mode 100644 include/hw/mem/npcm7xx_mc.h
> > > >>>  create mode 100644 include/hw/misc/npcm7xx_clk.h
> > > >>>  create mode 100644 include/hw/misc/npcm7xx_gcr.h
> > > >>>  create mode 100644 include/hw/nvram/npcm7xx_otp.h
> > > >>>  create mode 100644 include/hw/ssi/npcm7xx_fiu.h
> > > >>>  create mode 100644 include/hw/timer/npcm7xx_timer.h
> > > >>>  create mode 100644 hw/arm/npcm7xx.c
> > > >>>  create mode 100644 hw/arm/npcm7xx_boards.c
> > > >>>  create mode 100644 hw/mem/npcm7xx_mc.c
> > > >>>  create mode 100644 hw/misc/npcm7xx_clk.c
> > > >>>  create mode 100644 hw/misc/npcm7xx_gcr.c
> > > >>>  create mode 100644 hw/nvram/npcm7xx_otp.c
> > > >>>  create mode 100644 hw/ssi/npcm7xx_fiu.c
> > > >>>  create mode 100644 hw/timer/npcm7xx_timer.c
> > > >>>  create mode 100644 pc-bios/npcm7xx_bootrom.bin
> > > >>>  create mode 160000 roms/vbootrom
> > > >>>
> > > >>> --
> > > >>> 2.28.0.297.g1956fa8f8d-goog
> > > >>>
> > > >>>
> > > >>
> > > >
>

--0000000000005c336605aefe6a4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Tue, Sep 8, 2020 at 6:32 PM Havard Ski=
nnemoen &lt;<a href=3D"mailto:hskinnemoen@google.com">hskinnemoen@google.co=
m</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On Tue, Sep 8, 2020 at 12:52 PM Havard Skinnemo=
en<br>
&lt;<a href=3D"mailto:hskinnemoen@google.com" target=3D"_blank" class=3D"cr=
emed">hskinnemoen@google.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Tue, Sep 8, 2020 at 9:58 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:f4bug@amsat.org" target=3D"_blank" class=3D"cremed">f4bug@amsat.=
org</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On 9/8/20 5:52 PM, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; &gt; &gt; On 9/8/20 5:02 PM, Alexander Bulekov wrote:<br>
&gt; &gt; &gt;&gt; Hi Havard,<br>
&gt; &gt; &gt;&gt; I fuzzed the npcm750-evb machine until I hit over 85% co=
verage over all<br>
&gt; &gt; &gt;&gt; the new npcm.*\.c files. The only thing I found specific=
 to the new<br>
&gt; &gt; &gt;&gt; code, so far:<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; cat &lt;&lt; EOF | ./qemu-system-arm -machine npcm750-ev=
b -m 128M -qtest stdio<br>
&gt; &gt; &gt;&gt; write 0xf0009040 0x4 0xc4c4c4c4<br>
&gt; &gt; &gt;&gt; write 0xf0009040 0x4 0x4<br>
&gt; &gt; &gt;&gt; EOF<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This is an odd test because with -qtest the timer is not run=
ning,<br>
&gt; &gt; &gt; so this can not really happen on real hw.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; The fix is:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 g_assert(t-&gt;remaining_ns &gt; 0);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 g_assert(qtest_enabled() || t-&gt;remaining_n=
s &gt; 0);<br>
&gt; &gt;<br>
&gt; &gt; Alex corrected me on IRC, qtest is irrelevant here.<br>
&gt; &gt; The problem is he disables the timer twice.<br>
&gt; &gt;<br>
&gt; &gt; So maybe something like:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void npcm7xx_timer_pause(NPCM7xxTimer *t)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int64_t now;<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 if (!timer_pending(&amp;t-&gt;qtimer)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 timer_del(&amp;t-&gt;qtimer);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 t-&gt;remaining_ns =3D t-&gt;expires_ns - now=
;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_assert(t-&gt;remaining_ns &gt; 0);<br>
&gt; &gt;=C2=A0 }<br>
&gt;<br>
&gt; Thanks, that makes sense. I was worried that making the assert<br>
&gt; conditional on qtest_enabled() might hide real issues.<br>
<br>
Hmm, that didn&#39;t help, though it might make sense to keep it there anyw=
ay.<br>
<br>
What the test case does is:<br>
<br>
=C2=A0 1. Enable the timer (with zero expiration time) and reset it at the =
same time.<br>
=C2=A0 2. Disable the timer zero cycles after it was enabled.<br>
<br>
It also touches a bunch of other bits (including reserved bits), but<br>
they should be irrelevant.<br>
<br>
I think there are two issues here.<br>
<br>
When the Reset bit is set, the Enable bit should be forced to zero.<br>
This is easy to fix.<br>
<br>
If the timer is enabled with zero expiration time, and immediately<br>
disabled without advancing the virtual time, npcm7xx_timer_pause() is<br>
called while the timer is active, but t-&gt;expires_ns =3D=3D<br>
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL). So t-&gt;remaining_ns becomes zero<b=
r>
and triggers the assertion.<br>
<br>
If I revert a change that Philippe asked me to do earlier:<br>
<br>
=C2=A0 =C2=A0 timer_del(&amp;t-&gt;qtimer);<br>
=C2=A0 =C2=A0 =C2=A0now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);<br>
=C2=A0 =C2=A0 =C2=A0t-&gt;remaining_ns =3D t-&gt;expires_ns - now;<br>
-=C2=A0 =C2=A0 g_assert(t-&gt;remaining_ns &gt; 0);<br>
+=C2=A0 =C2=A0 if (t-&gt;remaining_ns &lt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 npcm7xx_timer_reached_zero(t);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
it doesn&#39;t crash:<br>
<br>
$ cat &lt;&lt; EOF | ./qemu-system-arm -machine npcm750-evb -m 128M -qtest<=
br>
stdio --trace npcm7xx_timer*<br>
write 0xf0009040 0x4 0xc4c4c4c4<br>
write 0xf0009040 0x4 0x4<br>
EOF<br>
[I 1599613445.620379] OPENED<br>
[R +0.180771] write 0xf0009040 0x4 0xc4c4c4c4<br>
1361079@1599613445.801182:npcm7xx_timer_write /machine/soc/tim[1]<br>
offset: 0x0040 value 0xc4c4c4c4<br>
OK<br>
[S +0.180816] OK<br>
[R +0.180833] write 0xf0009040 0x4 0x4<br>
1361079@1599613445.801220:npcm7xx_timer_write /machine/soc/tim[1]<br>
offset: 0x0040 value 0x00000000<br>
1361079@1599613445.801295:npcm7xx_timer_irq /machine/soc/tim[1] timer 4 sta=
te 0<br>
OK<br>
[S +0.180927] OK<br>
[I +0.181319] CLOSED<br>
[I +4.003267] CLOSED<br>
<br>
Note that the npcm7xx_timer_irq trace event is a sign of the first<br>
bug, but fixing that might mask the second bug. If we write the same<br>
pattern, only without the Reset bit, this would be the correct<br>
behavior (and it still causes the v8 code to crash).<br>
<br>
I think this device deserves a qtest. I wonder if we&#39;d trigger the<br>
assertion if we set a nonzero expiration time, but happen to clear the<br>
Enable bit on the exact cycle it&#39;s supposed to expire. That would be a<=
br>
more realistic scenario, as it wouldn&#39;t require multiple register<br>
writes in the same virtual clock cycle.<br></blockquote><div><br></div><div=
>I wrote some qtests, and found several more bugs, but I wasn&#39;t able to=
 trigger this particular failure mode. I was able to reproduce both of the =
bugs found by the fuzzer though.</div><div><br></div><div>I&#39;ll refresh =
the patch series tonight or tomorrow, and also send the qtest to Nuvoton (a=
nd probably send it to the list within the next few weeks or so).</div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
I probably won&#39;t add the qtest to the same series, as I&#39;d like some=
one<br>
from Nuvoton to get a chance to review it first.<br>
<br>
Havard<br>
<br>
&gt;<br>
&gt; This fuzz testing is great, it would have been hard to find this bug<b=
r>
&gt; without it. Thanks a lot Alex for running it.<br>
&gt;<br>
&gt; Havard<br>
&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; ERROR:../hw/timer/npcm7xx_timer.c:160:npcm7xx_timer_paus=
e: assertion failed: (t-&gt;remaining_ns &gt; 0)<br>
&gt; &gt; &gt;&gt; Bail out! ERROR:../hw/timer/npcm7xx_timer.c:160:npcm7xx_=
timer_pause: assertion failed: (t-&gt;remaining_ns &gt; 0)<br>
&gt; &gt; &gt;&gt; Aborted<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; I&#39;m doing the same for the quanta-gsj machine, but I=
&#39;m not sure whether<br>
&gt; &gt; &gt;&gt; it will cover more code, so I&#39;m happy to leave a:<br=
>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Tested-by: Alexander Bulekov &lt;<a href=3D"mailto:alxnd=
r@bu.edu" target=3D"_blank" class=3D"cremed">alxndr@bu.edu</a>&gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; for the patches that add new virtual-device code (1-5, 7=
-12 ?)<br>
&gt; &gt; &gt;&gt; -Alex<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Very nice from you for testing running the fuzzer!<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Regards,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Phil.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; On 200824 1716, Havard Skinnemoen via wrote:<br>
&gt; &gt; &gt;&gt;&gt; I also pushed this and the previous patchsets to my =
qemu fork on github.<br>
&gt; &gt; &gt;&gt;&gt; The branches are named npcm7xx-v[1-8].<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0<a href=3D"https://github.com/hskinnemoe=
n/qemu" rel=3D"noreferrer" target=3D"_blank" class=3D"cremed">https://githu=
b.com/hskinnemoen/qemu</a><br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; This patch series models enough of the Nuvoton NPCM7=
30 and NPCM750 SoCs to boot<br>
&gt; &gt; &gt;&gt;&gt; an OpenBMC image built for quanta-gsj. This includes=
 device models for:<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Global Configuration Registers<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Clock Control<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Timers<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Fuses<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Memory Controller<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Flash Controller<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; These modules, along with the existing Cortex A9 CPU=
 cores and built-in<br>
&gt; &gt; &gt;&gt;&gt; peripherals, are integrated into a NPCM730 or NPCM75=
0 SoC, which in turn form<br>
&gt; &gt; &gt;&gt;&gt; the foundation for the quanta-gsj and npcm750-evb ma=
chines, respectively. The<br>
&gt; &gt; &gt;&gt;&gt; two SoCs are very similar; the only difference is th=
at NPCM730 is missing some<br>
&gt; &gt; &gt;&gt;&gt; peripherals that NPCM750 has, and which are not cons=
idered essential for<br>
&gt; &gt; &gt;&gt;&gt; datacenter use (e.g. graphics controllers). For more=
 information, see<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; <a href=3D"https://www.nuvoton.com/products/cloud-co=
mputing/ibmc/" rel=3D"noreferrer" target=3D"_blank" class=3D"cremed">https:=
//www.nuvoton.com/products/cloud-computing/ibmc/</a><br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Both quanta-gsj and npcm750-evb correspond to real b=
oards supported by OpenBMC.<br>
&gt; &gt; &gt;&gt;&gt; At the end of the series, qemu can boot an OpenBMC i=
mage built for one of these<br>
&gt; &gt; &gt;&gt;&gt; boards with some minor modifications.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; The patches in this series were developed by Google =
and reviewed by Nuvoton. We<br>
&gt; &gt; &gt;&gt;&gt; will be maintaining the machine and peripheral suppo=
rt together.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; The data sheet for these SoCs is not generally avail=
able. Please let me know if<br>
&gt; &gt; &gt;&gt;&gt; more comments are needed to understand the device be=
havior.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Changes since v7:<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Move register enums to .c files throug=
hout, leaving a single<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0NPCM7XX_FOO_NR_REGS definition be=
hind in the .h file. A QEMU_BUILD_BUG_ON<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0should alert anyone accidentally =
expanding the register enum that they need<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0to update the corresponding NR_RE=
GS define, which in turn has a comment<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0reminding them to update the vmst=
ate version_id as well.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Skip loading the bootrom if a kernel f=
ilename is provided by the user.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- New patch adding a board setup stub to=
 tweak clocks before booting directly<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0into the kernel.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Add stuff to meson files instead of Ma=
kefiles.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Try to disable the slowest drivers and=
 services to speed up the flash boot<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0acceptance test a bit. This is so=
mewhat based on the following<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0systemd-analyze blame report:<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://gist.github.co=
m/hskinnemoen/475cb0676530cd2cebaa1754cf16ca97" rel=3D"noreferrer" target=
=3D"_blank" class=3D"cremed">https://gist.github.com/hskinnemoen/475cb06765=
30cd2cebaa1754cf16ca97</a><br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Changes since v6:<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Use size_to_str to report DRAM sizes i=
n npcm7xx_gcr.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Simplify the interrupt logic in npcm7x=
x_timer.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Update global bios_name instead of tem=
porary.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Add npcm7xx_bootrom to MAINTAINERS and=
 pc-bios/README.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Use a predefined name for the gsj boot=
 image in the acceptance test.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Changes since v5:<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Boot ROM included, as a git submodule =
and a binary blob, and loaded by<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0default, so the -bios option is u=
sually not necessary anymore.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Two acceptance tests added (openbmc im=
age boot, and direct kernel boot).<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- npcm7xx_load_kernel() moved to SoC cod=
e.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- NPCM7XX_TIMER_REF_HZ definition moved =
to CLK header.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Comments added clarifying available SP=
I flash chip selects.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Error handling adjustments:<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Errors from CPU and GCR =
realization are propagated through the SoC<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0since they may be t=
riggered by user-configurable parameters.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Machine init uses error_=
fatal instead of error_abort for SoC<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0realization flash i=
nit. This makes error messages more helpful.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Comments added to indica=
te whether peripherals may fail to realize.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Use ERRP_GUARD() instead=
 of Error *err when possible.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Default CPU type is now set, and attem=
pting to set it to anything else<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0will fail.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Format string fixes (use HWADDR_PRIx, =
etc.)<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Simplified memory size encoding and er=
ror checking in npcm7xx_gcr.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Encapsulate non-obvious pointer subtra=
ction into helper functions in the<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0FIU and TIMER modules.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Incorporate review feedback into the F=
IU module:<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Add select/deselect trac=
e events.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Use npcm7xx_fiu_{de,}sel=
ect() consistently.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Use extract/deposit in m=
ore places for consistency.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Use -Wimplicit-fallthrou=
gh compatible fallthrough comments.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Use qdev_init_gpio_out_n=
amed instead of sysbus_init_irq for chip<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selects.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Incorporate review feedback into the T=
IMER module:<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Assert that we never pau=
se a timer that has already expired, instead of<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trying to handle it=
. This should be safe since QEMU_CLOCK_VIRTUAL is<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stopped while this =
code is running.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Simplify the switch bloc=
ks in the read and write handlers.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; I made a change to error out if a flash drive was no=
t specified, but reverted<br>
&gt; &gt; &gt;&gt;&gt; it because it caused make check to fail (qom-test). =
When specifying a NULL<br>
&gt; &gt; &gt;&gt;&gt; block device, the m25p flash device initializes its =
in-memory storage with 0xff<br>
&gt; &gt; &gt;&gt;&gt; and doesn&#39;t attempt to write anything back. This=
 seems correct to me.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Changes since v4:<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- OTP cleanups suggested by Philippe Mat=
hieu-Daud=C3=A9.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Added fuse array definit=
ions based on public Nuvoton bootblock code.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Moved class structure to=
 .c file since it&#39;s only used internally.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Readability improvements=
.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Split the first patch and folded parts=
 of it into three other patches so<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0that CONFIG_NPCM7XX is only enabl=
ed after the initial NPCM7xx machine<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0support is added.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- DRAM init moved to machine init code.<=
br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Consistently use lower-case hex litera=
ls.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Switched to fine-grained unimplemented=
 devices, based on public bootblock<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0source code. Added a tiny SRAM th=
at got left out previously.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Simplified error handling in npcm7xx_r=
ealize() since the board code will<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0abort anyway, and SoCs are not ho=
t-pluggable.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Changes since v3:<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- License headers are now GPL v2-or-late=
r throughout.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Added vmstate throughout (except the m=
emory controller, which doesn&#39;t<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0really have any state worth savin=
g). Successfully booted a gsj image<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0with two stop/savevm/quit/loadvm =
cycles along the way.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- JFFS2 really doesn&#39;t=
 like it if I let qemu keep running after savevm,<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and then jump back =
in time with loadvm. I assume this is expected.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Fixed an error API violation in npcm7x=
x_realize, removed pointless error<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0check after object_property_set_l=
ink().<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Switched the OTP device to use an embe=
dded array instead of a g_malloc0&#39;d<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0one because I couldn&#39;t figure=
 out how to set up vmstate for the latter.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Changes since v2:<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Simplified the MAINTAINERS entry.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Added link to OpenPOWER jenkins for gs=
j BMC images.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Reverted the smpboot change, back to b=
yte swapping.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Adapted to upstream API changes:<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- sysbus_init_child_obj -&=
gt; object_initialize_child<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- object_property_set_bool=
 -&gt; qdev_realize / sysbus_realize<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- ssi_create_slave_no_init=
 -&gt; qdev_new<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- qdev_init_nofail -&gt; q=
dev_realize_and_unref<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- ssi_auto_connect_slaves =
removed<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Moved Boot ROM loading from soc to mac=
hine init.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Plumbed power-on-straps property from =
GCR to the machine init code so it<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0can be properly initialized. Turn=
s out npcm750 memory init doesn&#39;t work<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0without this. npcm730 is fine eit=
her way, though I&#39;m not sure why.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Reworked the flash init code so it loo=
ks more like aspeed (i.e. the flash<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0device gets added even if there&#=
39;s no drive).<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Changes since v1 (requested by reviewers):<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Clarify the source of CLK reset values=
.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Made smpboot a constant byte array, el=
iinated byte swapping.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- NPCM7xxState now stores an array of AR=
MCPUs, not pointers to ARMCPUs.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Clarify why EL3 is disabled.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Introduce NPCM7XX_NUM_IRQ constant.<br=
>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Set the number of CPUs according to So=
C variant, and disallow command line<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0overrides (i.e. you can no longer=
 override the number of CPUs with the -smp<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0parameter). This is trying to fol=
low the spirit of<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"https://patchwork.kern=
el.org/patch/11595407/" rel=3D"noreferrer" target=3D"_blank" class=3D"creme=
d">https://patchwork.kernel.org/patch/11595407/</a>.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Switch register operations to DEVICE_L=
ITTLE_ENDIAN throughout.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Machine documentation added (new patch=
).<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Changes since v1 to support flash booting:<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- GCR reset value changes to get past me=
mory initialization when booting<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0from flash (patches 2 and 5):<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- INTCR2 now indicates tha=
t the DDR controller is initialized.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- INTCR3 is initialized ac=
cording to DDR memory size. A realize()<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0method was implemented to achieve=
 this.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Refactor the machine initialization a =
bit to make it easier to drop in<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0machine-specific flash initializa=
tion (patch 6).<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0- Extend the series with additional patc=
hes to enable booting from flash:<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Boot ROM (through the -b=
ios option).<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- OTP (fuse) controller.<b=
r>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Memory Controller stub (=
just enough to skip memory training).<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Flash controller.<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0- Board-specific flash ini=
tialization.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Thanks for reviewing,<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Havard<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Havard Skinnemoen (14):<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0hw/misc: Add NPCM7xx System Global Contr=
ol Registers device model<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0hw/misc: Add NPCM7xx Clock Controller de=
vice model<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0hw/timer: Add NPCM7xx Timer device model=
<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0hw/arm: Add NPCM730 and NPCM750 SoC mode=
ls<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0hw/arm: Add two NPCM7xx-based machines<b=
r>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0roms: Add virtual Boot ROM for NPCM7xx S=
oCs<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0hw/arm: Load -bios image as a boot ROM f=
or npcm7xx<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0hw/nvram: NPCM7xx OTP device model<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0hw/mem: Stubbed out NPCM7xx Memory Contr=
oller model<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0hw/ssi: NPCM7xx Flash Interface Unit dev=
ice model<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0hw/arm: Wire up BMC boot flash for npcm7=
50-evb and quanta-gsj<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0hw/arm/npcm7xx: add board setup stub for=
 CPU and UART clocks<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0docs/system: Add Nuvoton machine documen=
tation<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 =C2=A0tests/acceptance: console boot tests for=
 quanta-gsj<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 docs/system/arm/nuvoton.rst=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 90 ++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 docs/system/target-arm.rst=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A01 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 default-configs/arm-softmmu.mak=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 include/hw/arm/npcm7xx.h=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 112 +++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 include/hw/mem/npcm7xx_mc.h=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 36 ++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 include/hw/misc/npcm7xx_clk.h=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 48 +++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 include/hw/misc/npcm7xx_gcr.h=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 43 ++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 include/hw/nvram/npcm7xx_otp.h=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 79 ++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 include/hw/ssi/npcm7xx_fiu.h=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 73 ++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 include/hw/timer/npcm7xx_timer.h=C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 78 ++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/arm/npcm7xx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 532 ++++++++++++++=
+++++++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/arm/npcm7xx_boards.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 197 +++++++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/mem/npcm7xx_mc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 84 ++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/misc/npcm7xx_clk.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 266 ++++++++++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/misc/npcm7xx_gcr.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 269 ++++++++++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/nvram/npcm7xx_otp.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 439 +++++++++++++++++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/ssi/npcm7xx_fiu.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 572 ++++++++++++++++++++++++=
+<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/timer/npcm7xx_timer.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 509 ++++++++++++++++++++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 .gitmodules=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A03 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +=
<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09 =
+<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/arm/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/mem/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/misc/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A04 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/nvram/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/ssi/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/ssi/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/timer/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 hw/timer/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 pc-bios/README=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 =
+<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 pc-bios/npcm7xx_bootrom.bin=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | Bin 0 -&gt; 768 bytes<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 roms/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07=
 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 roms/vbootrom=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01=
 +<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 tests/acceptance/boot_linux_console.py |=C2=A0=
 83 ++++<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 36 files changed, 3582 insertions(+)<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 docs/system/arm/nuvoton.rst=
<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 include/hw/arm/npcm7xx.h<br=
>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 include/hw/mem/npcm7xx_mc.h=
<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 include/hw/misc/npcm7xx_clk=
.h<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 include/hw/misc/npcm7xx_gcr=
.h<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 include/hw/nvram/npcm7xx_ot=
p.h<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 include/hw/ssi/npcm7xx_fiu.=
h<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 include/hw/timer/npcm7xx_ti=
mer.h<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 hw/arm/npcm7xx.c<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 hw/arm/npcm7xx_boards.c<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 hw/mem/npcm7xx_mc.c<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 hw/misc/npcm7xx_clk.c<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 hw/misc/npcm7xx_gcr.c<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 hw/nvram/npcm7xx_otp.c<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 hw/ssi/npcm7xx_fiu.c<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 hw/timer/npcm7xx_timer.c<br=
>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 100644 pc-bios/npcm7xx_bootrom.bin=
<br>
&gt; &gt; &gt;&gt;&gt;=C2=A0 create mode 160000 roms/vbootrom<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; --<br>
&gt; &gt; &gt;&gt;&gt; 2.28.0.297.g1956fa8f8d-goog<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;<br>
</blockquote></div></div>

--0000000000005c336605aefe6a4e--

