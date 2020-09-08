Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CFAC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14CEB20658
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4VunZOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CEB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjjr-0006UY-3U
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kFjfV-0005Iv-QP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 15:52:41 -0400
Received: from mail-vs1-xe41.google.com ([2607:f8b0:4864:20::e41]:33800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kFjfR-0002yf-OK
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 15:52:41 -0400
Received: by mail-vs1-xe41.google.com with SMTP id c127so22352vsc.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 12:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XxwIBhFvxEXAqLEqWFzxnHhnjoGZurTvoWr4KAbY3uM=;
 b=b4VunZOXvRVyKCCk8X1t9zA4AFU/u39kn+n0u5r7HxRdGWRPKjwq+ZfuPxuNPVEQVd
 4Itbv+voMqX9g5wFZDMiu6gv0hvKZsLodYaZUPTAYvFTMLJ5te8dHWcaIbVEIyN6n9fw
 BfvijlZvfDWH84U3yySOiwRjQMt6wy1CEG8b3XYi5vhnyPcNC/gCmerZ3jx9js1quhrT
 il6xHECtAmPEe/V99e71bqcsLqw07fCnDKayZAC1LfhkbMV5gEXqblZtc1NQmUkbCDtq
 b7i3nXQY0e2hkvutb3XyafgfnjplKqvyMEglajHXlc78Iv9r90/lwAsaD88buBwN/w8B
 9mIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XxwIBhFvxEXAqLEqWFzxnHhnjoGZurTvoWr4KAbY3uM=;
 b=W0AVeCnj1cgUwYjNjJZA8/1E5D0Pnjd/uSQV3nTKhhRBI9QK9Kj7AkJCX1a/fgaf4Y
 DopFerLF85LLWF16tpB5LVzt8ecVcJNUBBD6B9u3y6Nm0vW5KKdlSwYlQz5tweLcxoM7
 RaD9OLvBfBmRcZQkD0BzrSEXguLanIAYtVDu+9vjyNo8mT7JxoG9Qn+AHpQE7GCC/Trt
 kCAazvffATjQL7bJ4dI5XrRvYMfbzR4H5M7RSz6L+6ShqpeFI8x/aricIUZ1yDPeNi4B
 C4CVxEfa8KTl+wQNImVLgwmfGx+ipV4FnrankaCFbxNbYCohVKTxyRkzNQvuUmFljB+d
 K3eg==
X-Gm-Message-State: AOAM533ynwBhLPuH3Grv6bNV5es0G5exjqCYEeCDIxMMeJpfk9WF9Iem
 yeJwy1m9KXRa0nXX/pLG8WNvYQFIHalV4i4sUrJfQg==
X-Google-Smtp-Source: ABdhPJwtY0FyPpQrwOO5vbGBjp8Ud96e4jrJLrV/LFOFygnaY10iv4ZBFIyHZeWKK2NuEJnpdhXQJT069qSvGQU8U8A=
X-Received: by 2002:a67:2903:: with SMTP id p3mr602067vsp.18.1599594754948;
 Tue, 08 Sep 2020 12:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200825001711.1340443-1-hskinnemoen@google.com>
 <20200908150224.pkuyhpmw33xqhmjn@mozz.bu.edu>
 <d88bc6ae-e07e-700f-d3cc-c093d2d44594@amsat.org>
 <bfb442b4-9700-5591-eeef-00bc6675c89f@amsat.org>
In-Reply-To: <bfb442b4-9700-5591-eeef-00bc6675c89f@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Tue, 8 Sep 2020 12:52:23 -0700
Message-ID: <CAFQmdRZfmbgUgUh3iryPQs5LfiYpn2cHWPzjBdJKSXANFFtT6g@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alexander Bulekov <alxndr@bu.edu>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, CS20 KFTing <kfting@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e41;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 8, 2020 at 9:58 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 9/8/20 5:52 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 9/8/20 5:02 PM, Alexander Bulekov wrote:
> >> Hi Havard,
> >> I fuzzed the npcm750-evb machine until I hit over 85% coverage over al=
l
> >> the new npcm.*\.c files. The only thing I found specific to the new
> >> code, so far:
> >>
> >> cat << EOF | ./qemu-system-arm -machine npcm750-evb -m 128M -qtest std=
io
> >> write 0xf0009040 0x4 0xc4c4c4c4
> >> write 0xf0009040 0x4 0x4
> >> EOF
> >
> > This is an odd test because with -qtest the timer is not running,
> > so this can not really happen on real hw.
> >
> > The fix is:
> >
> > -    g_assert(t->remaining_ns > 0);
> > +    g_assert(qtest_enabled() || t->remaining_ns > 0);
>
> Alex corrected me on IRC, qtest is irrelevant here.
> The problem is he disables the timer twice.
>
> So maybe something like:
>
>  static void npcm7xx_timer_pause(NPCM7xxTimer *t)
>  {
>      int64_t now;
>
> +    if (!timer_pending(&t->qtimer)) {
> +        return;
> +    }
>      timer_del(&t->qtimer);
>      now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>      t->remaining_ns =3D t->expires_ns - now;
>      g_assert(t->remaining_ns > 0);
>  }

Thanks, that makes sense. I was worried that making the assert
conditional on qtest_enabled() might hide real issues.

This fuzz testing is great, it would have been hard to find this bug
without it. Thanks a lot Alex for running it.

Havard

> >
> >>
> >> ERROR:../hw/timer/npcm7xx_timer.c:160:npcm7xx_timer_pause: assertion f=
ailed: (t->remaining_ns > 0)
> >> Bail out! ERROR:../hw/timer/npcm7xx_timer.c:160:npcm7xx_timer_pause: a=
ssertion failed: (t->remaining_ns > 0)
> >> Aborted
> >>
> >> I'm doing the same for the quanta-gsj machine, but I'm not sure whethe=
r
> >> it will cover more code, so I'm happy to leave a:
> >>
> >> Tested-by: Alexander Bulekov <alxndr@bu.edu>
> >>
> >> for the patches that add new virtual-device code (1-5, 7-12 ?)
> >> -Alex
> >
> > Very nice from you for testing running the fuzzer!
> >
> > Regards,
> >
> > Phil.
> >
> >>
> >>
> >> On 200824 1716, Havard Skinnemoen via wrote:
> >>> I also pushed this and the previous patchsets to my qemu fork on gith=
ub.
> >>> The branches are named npcm7xx-v[1-8].
> >>>
> >>>   https://github.com/hskinnemoen/qemu
> >>>
> >>> This patch series models enough of the Nuvoton NPCM730 and NPCM750 So=
Cs to boot
> >>> an OpenBMC image built for quanta-gsj. This includes device models fo=
r:
> >>>
> >>>   - Global Configuration Registers
> >>>   - Clock Control
> >>>   - Timers
> >>>   - Fuses
> >>>   - Memory Controller
> >>>   - Flash Controller
> >>>
> >>> These modules, along with the existing Cortex A9 CPU cores and built-=
in
> >>> peripherals, are integrated into a NPCM730 or NPCM750 SoC, which in t=
urn form
> >>> the foundation for the quanta-gsj and npcm750-evb machines, respectiv=
ely. The
> >>> two SoCs are very similar; the only difference is that NPCM730 is mis=
sing some
> >>> peripherals that NPCM750 has, and which are not considered essential =
for
> >>> datacenter use (e.g. graphics controllers). For more information, see
> >>>
> >>> https://www.nuvoton.com/products/cloud-computing/ibmc/
> >>>
> >>> Both quanta-gsj and npcm750-evb correspond to real boards supported b=
y OpenBMC.
> >>> At the end of the series, qemu can boot an OpenBMC image built for on=
e of these
> >>> boards with some minor modifications.
> >>>
> >>> The patches in this series were developed by Google and reviewed by N=
uvoton. We
> >>> will be maintaining the machine and peripheral support together.
> >>>
> >>> The data sheet for these SoCs is not generally available. Please let =
me know if
> >>> more comments are needed to understand the device behavior.
> >>>
> >>> Changes since v7:
> >>>
> >>>   - Move register enums to .c files throughout, leaving a single
> >>>     NPCM7XX_FOO_NR_REGS definition behind in the .h file. A QEMU_BUIL=
D_BUG_ON
> >>>     should alert anyone accidentally expanding the register enum that=
 they need
> >>>     to update the corresponding NR_REGS define, which in turn has a c=
omment
> >>>     reminding them to update the vmstate version_id as well.
> >>>   - Skip loading the bootrom if a kernel filename is provided by the =
user.
> >>>   - New patch adding a board setup stub to tweak clocks before bootin=
g directly
> >>>     into the kernel.
> >>>   - Add stuff to meson files instead of Makefiles.
> >>>   - Try to disable the slowest drivers and services to speed up the f=
lash boot
> >>>     acceptance test a bit. This is somewhat based on the following
> >>>     systemd-analyze blame report:
> >>>     https://gist.github.com/hskinnemoen/475cb0676530cd2cebaa1754cf16c=
a97
> >>>
> >>> Changes since v6:
> >>>
> >>>   - Use size_to_str to report DRAM sizes in npcm7xx_gcr.
> >>>   - Simplify the interrupt logic in npcm7xx_timer.
> >>>   - Update global bios_name instead of temporary.
> >>>   - Add npcm7xx_bootrom to MAINTAINERS and pc-bios/README.
> >>>   - Use a predefined name for the gsj boot image in the acceptance te=
st.
> >>>
> >>> Changes since v5:
> >>>
> >>>   - Boot ROM included, as a git submodule and a binary blob, and load=
ed by
> >>>     default, so the -bios option is usually not necessary anymore.
> >>>   - Two acceptance tests added (openbmc image boot, and direct kernel=
 boot).
> >>>   - npcm7xx_load_kernel() moved to SoC code.
> >>>   - NPCM7XX_TIMER_REF_HZ definition moved to CLK header.
> >>>   - Comments added clarifying available SPI flash chip selects.
> >>>   - Error handling adjustments:
> >>>       - Errors from CPU and GCR realization are propagated through th=
e SoC
> >>>         since they may be triggered by user-configurable parameters.
> >>>       - Machine init uses error_fatal instead of error_abort for SoC
> >>>         realization flash init. This makes error messages more helpfu=
l.
> >>>       - Comments added to indicate whether peripherals may fail to re=
alize.
> >>>       - Use ERRP_GUARD() instead of Error *err when possible.
> >>>   - Default CPU type is now set, and attempting to set it to anything=
 else
> >>>     will fail.
> >>>   - Format string fixes (use HWADDR_PRIx, etc.)
> >>>   - Simplified memory size encoding and error checking in npcm7xx_gcr=
.
> >>>   - Encapsulate non-obvious pointer subtraction into helper functions=
 in the
> >>>     FIU and TIMER modules.
> >>>   - Incorporate review feedback into the FIU module:
> >>>       - Add select/deselect trace events.
> >>>       - Use npcm7xx_fiu_{de,}select() consistently.
> >>>       - Use extract/deposit in more places for consistency.
> >>>       - Use -Wimplicit-fallthrough compatible fallthrough comments.
> >>>       - Use qdev_init_gpio_out_named instead of sysbus_init_irq for c=
hip
> >>>         selects.
> >>>   - Incorporate review feedback into the TIMER module:
> >>>       - Assert that we never pause a timer that has already expired, =
instead of
> >>>         trying to handle it. This should be safe since QEMU_CLOCK_VIR=
TUAL is
> >>>         stopped while this code is running.
> >>>       - Simplify the switch blocks in the read and write handlers.
> >>>
> >>> I made a change to error out if a flash drive was not specified, but =
reverted
> >>> it because it caused make check to fail (qom-test). When specifying a=
 NULL
> >>> block device, the m25p flash device initializes its in-memory storage=
 with 0xff
> >>> and doesn't attempt to write anything back. This seems correct to me.
> >>>
> >>> Changes since v4:
> >>>
> >>>   - OTP cleanups suggested by Philippe Mathieu-Daud=C3=A9.
> >>>       - Added fuse array definitions based on public Nuvoton bootbloc=
k code.
> >>>       - Moved class structure to .c file since it's only used interna=
lly.
> >>>       - Readability improvements.
> >>>   - Split the first patch and folded parts of it into three other pat=
ches so
> >>>     that CONFIG_NPCM7XX is only enabled after the initial NPCM7xx mac=
hine
> >>>     support is added.
> >>>   - DRAM init moved to machine init code.
> >>>   - Consistently use lower-case hex literals.
> >>>   - Switched to fine-grained unimplemented devices, based on public b=
ootblock
> >>>     source code. Added a tiny SRAM that got left out previously.
> >>>   - Simplified error handling in npcm7xx_realize() since the board co=
de will
> >>>     abort anyway, and SoCs are not hot-pluggable.
> >>>
> >>> Changes since v3:
> >>>
> >>>   - License headers are now GPL v2-or-later throughout.
> >>>   - Added vmstate throughout (except the memory controller, which doe=
sn't
> >>>     really have any state worth saving). Successfully booted a gsj im=
age
> >>>     with two stop/savevm/quit/loadvm cycles along the way.
> >>>       - JFFS2 really doesn't like it if I let qemu keep running after=
 savevm,
> >>>         and then jump back in time with loadvm. I assume this is expe=
cted.
> >>>   - Fixed an error API violation in npcm7xx_realize, removed pointles=
s error
> >>>     check after object_property_set_link().
> >>>   - Switched the OTP device to use an embedded array instead of a g_m=
alloc0'd
> >>>     one because I couldn't figure out how to set up vmstate for the l=
atter.
> >>>
> >>> Changes since v2:
> >>>
> >>>   - Simplified the MAINTAINERS entry.
> >>>   - Added link to OpenPOWER jenkins for gsj BMC images.
> >>>   - Reverted the smpboot change, back to byte swapping.
> >>>   - Adapted to upstream API changes:
> >>>       - sysbus_init_child_obj -> object_initialize_child
> >>>       - object_property_set_bool -> qdev_realize / sysbus_realize
> >>>       - ssi_create_slave_no_init -> qdev_new
> >>>       - qdev_init_nofail -> qdev_realize_and_unref
> >>>       - ssi_auto_connect_slaves removed
> >>>   - Moved Boot ROM loading from soc to machine init.
> >>>   - Plumbed power-on-straps property from GCR to the machine init cod=
e so it
> >>>     can be properly initialized. Turns out npcm750 memory init doesn'=
t work
> >>>     without this. npcm730 is fine either way, though I'm not sure why=
.
> >>>   - Reworked the flash init code so it looks more like aspeed (i.e. t=
he flash
> >>>     device gets added even if there's no drive).
> >>>
> >>> Changes since v1 (requested by reviewers):
> >>>
> >>>   - Clarify the source of CLK reset values.
> >>>   - Made smpboot a constant byte array, eliinated byte swapping.
> >>>   - NPCM7xxState now stores an array of ARMCPUs, not pointers to ARMC=
PUs.
> >>>   - Clarify why EL3 is disabled.
> >>>   - Introduce NPCM7XX_NUM_IRQ constant.
> >>>   - Set the number of CPUs according to SoC variant, and disallow com=
mand line
> >>>     overrides (i.e. you can no longer override the number of CPUs wit=
h the -smp
> >>>     parameter). This is trying to follow the spirit of
> >>>     https://patchwork.kernel.org/patch/11595407/.
> >>>   - Switch register operations to DEVICE_LITTLE_ENDIAN throughout.
> >>>   - Machine documentation added (new patch).
> >>>
> >>> Changes since v1 to support flash booting:
> >>>
> >>>   - GCR reset value changes to get past memory initialization when bo=
oting
> >>>     from flash (patches 2 and 5):
> >>>       - INTCR2 now indicates that the DDR controller is initialized.
> >>>       - INTCR3 is initialized according to DDR memory size. A realize=
()
> >>>     method was implemented to achieve this.
> >>>   - Refactor the machine initialization a bit to make it easier to dr=
op in
> >>>     machine-specific flash initialization (patch 6).
> >>>   - Extend the series with additional patches to enable booting from =
flash:
> >>>       - Boot ROM (through the -bios option).
> >>>       - OTP (fuse) controller.
> >>>       - Memory Controller stub (just enough to skip memory training).
> >>>       - Flash controller.
> >>>       - Board-specific flash initialization.
> >>>
> >>> Thanks for reviewing,
> >>>
> >>> Havard
> >>>
> >>> Havard Skinnemoen (14):
> >>>   hw/misc: Add NPCM7xx System Global Control Registers device model
> >>>   hw/misc: Add NPCM7xx Clock Controller device model
> >>>   hw/timer: Add NPCM7xx Timer device model
> >>>   hw/arm: Add NPCM730 and NPCM750 SoC models
> >>>   hw/arm: Add two NPCM7xx-based machines
> >>>   roms: Add virtual Boot ROM for NPCM7xx SoCs
> >>>   hw/arm: Load -bios image as a boot ROM for npcm7xx
> >>>   hw/nvram: NPCM7xx OTP device model
> >>>   hw/mem: Stubbed out NPCM7xx Memory Controller model
> >>>   hw/ssi: NPCM7xx Flash Interface Unit device model
> >>>   hw/arm: Wire up BMC boot flash for npcm750-evb and quanta-gsj
> >>>   hw/arm/npcm7xx: add board setup stub for CPU and UART clocks
> >>>   docs/system: Add Nuvoton machine documentation
> >>>   tests/acceptance: console boot tests for quanta-gsj
> >>>
> >>>  docs/system/arm/nuvoton.rst            |  90 ++++
> >>>  docs/system/target-arm.rst             |   1 +
> >>>  Makefile                               |   1 +
> >>>  default-configs/arm-softmmu.mak        |   1 +
> >>>  include/hw/arm/npcm7xx.h               | 112 +++++
> >>>  include/hw/mem/npcm7xx_mc.h            |  36 ++
> >>>  include/hw/misc/npcm7xx_clk.h          |  48 +++
> >>>  include/hw/misc/npcm7xx_gcr.h          |  43 ++
> >>>  include/hw/nvram/npcm7xx_otp.h         |  79 ++++
> >>>  include/hw/ssi/npcm7xx_fiu.h           |  73 ++++
> >>>  include/hw/timer/npcm7xx_timer.h       |  78 ++++
> >>>  hw/arm/npcm7xx.c                       | 532 +++++++++++++++++++++++
> >>>  hw/arm/npcm7xx_boards.c                | 197 +++++++++
> >>>  hw/mem/npcm7xx_mc.c                    |  84 ++++
> >>>  hw/misc/npcm7xx_clk.c                  | 266 ++++++++++++
> >>>  hw/misc/npcm7xx_gcr.c                  | 269 ++++++++++++
> >>>  hw/nvram/npcm7xx_otp.c                 | 439 +++++++++++++++++++
> >>>  hw/ssi/npcm7xx_fiu.c                   | 572 +++++++++++++++++++++++=
++
> >>>  hw/timer/npcm7xx_timer.c               | 509 ++++++++++++++++++++++
> >>>  .gitmodules                            |   3 +
> >>>  MAINTAINERS                            |  10 +
> >>>  hw/arm/Kconfig                         |   9 +
> >>>  hw/arm/meson.build                     |   1 +
> >>>  hw/mem/meson.build                     |   1 +
> >>>  hw/misc/meson.build                    |   4 +
> >>>  hw/misc/trace-events                   |   8 +
> >>>  hw/nvram/meson.build                   |   1 +
> >>>  hw/ssi/meson.build                     |   1 +
> >>>  hw/ssi/trace-events                    |  11 +
> >>>  hw/timer/meson.build                   |   1 +
> >>>  hw/timer/trace-events                  |   5 +
> >>>  pc-bios/README                         |   6 +
> >>>  pc-bios/npcm7xx_bootrom.bin            | Bin 0 -> 768 bytes
> >>>  roms/Makefile                          |   7 +
> >>>  roms/vbootrom                          |   1 +
> >>>  tests/acceptance/boot_linux_console.py |  83 ++++
> >>>  36 files changed, 3582 insertions(+)
> >>>  create mode 100644 docs/system/arm/nuvoton.rst
> >>>  create mode 100644 include/hw/arm/npcm7xx.h
> >>>  create mode 100644 include/hw/mem/npcm7xx_mc.h
> >>>  create mode 100644 include/hw/misc/npcm7xx_clk.h
> >>>  create mode 100644 include/hw/misc/npcm7xx_gcr.h
> >>>  create mode 100644 include/hw/nvram/npcm7xx_otp.h
> >>>  create mode 100644 include/hw/ssi/npcm7xx_fiu.h
> >>>  create mode 100644 include/hw/timer/npcm7xx_timer.h
> >>>  create mode 100644 hw/arm/npcm7xx.c
> >>>  create mode 100644 hw/arm/npcm7xx_boards.c
> >>>  create mode 100644 hw/mem/npcm7xx_mc.c
> >>>  create mode 100644 hw/misc/npcm7xx_clk.c
> >>>  create mode 100644 hw/misc/npcm7xx_gcr.c
> >>>  create mode 100644 hw/nvram/npcm7xx_otp.c
> >>>  create mode 100644 hw/ssi/npcm7xx_fiu.c
> >>>  create mode 100644 hw/timer/npcm7xx_timer.c
> >>>  create mode 100644 pc-bios/npcm7xx_bootrom.bin
> >>>  create mode 160000 roms/vbootrom
> >>>
> >>> --
> >>> 2.28.0.297.g1956fa8f8d-goog
> >>>
> >>>
> >>
> >

