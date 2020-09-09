Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D87C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 01:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F14D20C09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 01:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3aX1UMe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F14D20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFozw-0006ml-5y
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 21:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kFoyy-0006GB-24
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 21:33:08 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:45968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1kFoyv-0002Q5-5Q
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 21:33:07 -0400
Received: by mail-vs1-xe44.google.com with SMTP id a16so414628vsp.12
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 18:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lW8FTa7B7Lqkx4Eu1G5tPIFqAkHi1oJZjJvMuWuabTY=;
 b=J3aX1UMeWemKoJzmr92K5a1nT8aLwLcwnALxvImh/U9XEpGT81vJ/48lTq4OhASder
 +DAw+rgeGrTlwTg+09l9oHDNOuLbawA96ehLWiWoWY3dnvQd0KDR0nN7hOyRnh3PLI4i
 P7PuF/qYz5Jly/NlxXqPxkhqZH8jETXOqzQmR9fOFi06wmt8L3MwMAnQi50AhQSW7RlX
 F0fq5aDodmoS27HbD/h+Lt47QtjO5IHiLxrAKkfyOVYxuU1+akSdjqTEs/hXC01sC+Q9
 oljOjC/k8imUctpzC4efjEI7WVbTkxLYr4rznNnUqhMJ3IuESKDP09xthj43wqHWxv8W
 gHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lW8FTa7B7Lqkx4Eu1G5tPIFqAkHi1oJZjJvMuWuabTY=;
 b=Z2Gkwf+vI/LoPk+63COMoaU+R2Tft92+dZvPbuerh/y9UikP/z6GCT5gNdRyw0X0pU
 iGct/izLPWG4QOT/JxOO+sdJ5uUDc61tbHGJ0fpTGWRq3dx5f+XilNnRT0NBWIZofy1M
 fF2AO0KVENmWz3S5iCPDeh+v0iY/oD2YQBhfpyNiKWldJ6ClpV/L7xCctDNygAs55ns2
 VbmimHT4e7thrqaEzaxsPNa/bTZ0wcqMIe5E16MftYDFO6sjwYDYDrNDa1UTJ8d0DOo0
 eOF9tSuh3XHu8UW9UAf+7zjJiHoK8kNVikWPCDG8mcurMPiKsbwu4cHkk1FjzNxiKaB4
 HNIA==
X-Gm-Message-State: AOAM530+Pl7MkRa3afb2nPyI6ktPNOe/n61DJmTFV2FX+Wsv9rH2gg/X
 /09otp0ueUjauXfkqcexZUDIYa3DwvKvMkkm9Qmgbw==
X-Google-Smtp-Source: ABdhPJydj85D290FKmxOq34ktQTjqDR4iXlFThwfnWvld967xQPFPb6vr/qmaxaDwIZYTxq2lXoeJ4x9W1fEzw7fc1Y=
X-Received: by 2002:a05:6102:525:: with SMTP id
 m5mr1252822vsa.37.1599615183360; 
 Tue, 08 Sep 2020 18:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200825001711.1340443-1-hskinnemoen@google.com>
 <20200908150224.pkuyhpmw33xqhmjn@mozz.bu.edu>
 <d88bc6ae-e07e-700f-d3cc-c093d2d44594@amsat.org>
 <bfb442b4-9700-5591-eeef-00bc6675c89f@amsat.org>
 <CAFQmdRZfmbgUgUh3iryPQs5LfiYpn2cHWPzjBdJKSXANFFtT6g@mail.gmail.com>
In-Reply-To: <CAFQmdRZfmbgUgUh3iryPQs5LfiYpn2cHWPzjBdJKSXANFFtT6g@mail.gmail.com>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Tue, 8 Sep 2020 18:32:51 -0700
Message-ID: <CAFQmdRb1ye0mZjt1PYhqNiGMQMP1iBFWVsEhW5ADWYS5G5qteQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/14] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alexander Bulekov <alxndr@bu.edu>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, 
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, CS20 KFTing <kfting@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e44;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

On Tue, Sep 8, 2020 at 12:52 PM Havard Skinnemoen
<hskinnemoen@google.com> wrote:
>
> On Tue, Sep 8, 2020 at 9:58 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> >
> > On 9/8/20 5:52 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > > On 9/8/20 5:02 PM, Alexander Bulekov wrote:
> > >> Hi Havard,
> > >> I fuzzed the npcm750-evb machine until I hit over 85% coverage over =
all
> > >> the new npcm.*\.c files. The only thing I found specific to the new
> > >> code, so far:
> > >>
> > >> cat << EOF | ./qemu-system-arm -machine npcm750-evb -m 128M -qtest s=
tdio
> > >> write 0xf0009040 0x4 0xc4c4c4c4
> > >> write 0xf0009040 0x4 0x4
> > >> EOF
> > >
> > > This is an odd test because with -qtest the timer is not running,
> > > so this can not really happen on real hw.
> > >
> > > The fix is:
> > >
> > > -    g_assert(t->remaining_ns > 0);
> > > +    g_assert(qtest_enabled() || t->remaining_ns > 0);
> >
> > Alex corrected me on IRC, qtest is irrelevant here.
> > The problem is he disables the timer twice.
> >
> > So maybe something like:
> >
> >  static void npcm7xx_timer_pause(NPCM7xxTimer *t)
> >  {
> >      int64_t now;
> >
> > +    if (!timer_pending(&t->qtimer)) {
> > +        return;
> > +    }
> >      timer_del(&t->qtimer);
> >      now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> >      t->remaining_ns =3D t->expires_ns - now;
> >      g_assert(t->remaining_ns > 0);
> >  }
>
> Thanks, that makes sense. I was worried that making the assert
> conditional on qtest_enabled() might hide real issues.

Hmm, that didn't help, though it might make sense to keep it there anyway.

What the test case does is:

  1. Enable the timer (with zero expiration time) and reset it at the same =
time.
  2. Disable the timer zero cycles after it was enabled.

It also touches a bunch of other bits (including reserved bits), but
they should be irrelevant.

I think there are two issues here.

When the Reset bit is set, the Enable bit should be forced to zero.
This is easy to fix.

If the timer is enabled with zero expiration time, and immediately
disabled without advancing the virtual time, npcm7xx_timer_pause() is
called while the timer is active, but t->expires_ns =3D=3D
qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL). So t->remaining_ns becomes zero
and triggers the assertion.

If I revert a change that Philippe asked me to do earlier:

    timer_del(&t->qtimer);
     now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     t->remaining_ns =3D t->expires_ns - now;
-    g_assert(t->remaining_ns > 0);
+    if (t->remaining_ns <=3D 0) {
+        npcm7xx_timer_reached_zero(t);
+    }
 }

it doesn't crash:

$ cat << EOF | ./qemu-system-arm -machine npcm750-evb -m 128M -qtest
stdio --trace npcm7xx_timer*
write 0xf0009040 0x4 0xc4c4c4c4
write 0xf0009040 0x4 0x4
EOF
[I 1599613445.620379] OPENED
[R +0.180771] write 0xf0009040 0x4 0xc4c4c4c4
1361079@1599613445.801182:npcm7xx_timer_write /machine/soc/tim[1]
offset: 0x0040 value 0xc4c4c4c4
OK
[S +0.180816] OK
[R +0.180833] write 0xf0009040 0x4 0x4
1361079@1599613445.801220:npcm7xx_timer_write /machine/soc/tim[1]
offset: 0x0040 value 0x00000000
1361079@1599613445.801295:npcm7xx_timer_irq /machine/soc/tim[1] timer 4 sta=
te 0
OK
[S +0.180927] OK
[I +0.181319] CLOSED
[I +4.003267] CLOSED

Note that the npcm7xx_timer_irq trace event is a sign of the first
bug, but fixing that might mask the second bug. If we write the same
pattern, only without the Reset bit, this would be the correct
behavior (and it still causes the v8 code to crash).

I think this device deserves a qtest. I wonder if we'd trigger the
assertion if we set a nonzero expiration time, but happen to clear the
Enable bit on the exact cycle it's supposed to expire. That would be a
more realistic scenario, as it wouldn't require multiple register
writes in the same virtual clock cycle.

I probably won't add the qtest to the same series, as I'd like someone
from Nuvoton to get a chance to review it first.

Havard

>
> This fuzz testing is great, it would have been hard to find this bug
> without it. Thanks a lot Alex for running it.
>
> Havard
>
> > >
> > >>
> > >> ERROR:../hw/timer/npcm7xx_timer.c:160:npcm7xx_timer_pause: assertion=
 failed: (t->remaining_ns > 0)
> > >> Bail out! ERROR:../hw/timer/npcm7xx_timer.c:160:npcm7xx_timer_pause:=
 assertion failed: (t->remaining_ns > 0)
> > >> Aborted
> > >>
> > >> I'm doing the same for the quanta-gsj machine, but I'm not sure whet=
her
> > >> it will cover more code, so I'm happy to leave a:
> > >>
> > >> Tested-by: Alexander Bulekov <alxndr@bu.edu>
> > >>
> > >> for the patches that add new virtual-device code (1-5, 7-12 ?)
> > >> -Alex
> > >
> > > Very nice from you for testing running the fuzzer!
> > >
> > > Regards,
> > >
> > > Phil.
> > >
> > >>
> > >>
> > >> On 200824 1716, Havard Skinnemoen via wrote:
> > >>> I also pushed this and the previous patchsets to my qemu fork on gi=
thub.
> > >>> The branches are named npcm7xx-v[1-8].
> > >>>
> > >>>   https://github.com/hskinnemoen/qemu
> > >>>
> > >>> This patch series models enough of the Nuvoton NPCM730 and NPCM750 =
SoCs to boot
> > >>> an OpenBMC image built for quanta-gsj. This includes device models =
for:
> > >>>
> > >>>   - Global Configuration Registers
> > >>>   - Clock Control
> > >>>   - Timers
> > >>>   - Fuses
> > >>>   - Memory Controller
> > >>>   - Flash Controller
> > >>>
> > >>> These modules, along with the existing Cortex A9 CPU cores and buil=
t-in
> > >>> peripherals, are integrated into a NPCM730 or NPCM750 SoC, which in=
 turn form
> > >>> the foundation for the quanta-gsj and npcm750-evb machines, respect=
ively. The
> > >>> two SoCs are very similar; the only difference is that NPCM730 is m=
issing some
> > >>> peripherals that NPCM750 has, and which are not considered essentia=
l for
> > >>> datacenter use (e.g. graphics controllers). For more information, s=
ee
> > >>>
> > >>> https://www.nuvoton.com/products/cloud-computing/ibmc/
> > >>>
> > >>> Both quanta-gsj and npcm750-evb correspond to real boards supported=
 by OpenBMC.
> > >>> At the end of the series, qemu can boot an OpenBMC image built for =
one of these
> > >>> boards with some minor modifications.
> > >>>
> > >>> The patches in this series were developed by Google and reviewed by=
 Nuvoton. We
> > >>> will be maintaining the machine and peripheral support together.
> > >>>
> > >>> The data sheet for these SoCs is not generally available. Please le=
t me know if
> > >>> more comments are needed to understand the device behavior.
> > >>>
> > >>> Changes since v7:
> > >>>
> > >>>   - Move register enums to .c files throughout, leaving a single
> > >>>     NPCM7XX_FOO_NR_REGS definition behind in the .h file. A QEMU_BU=
ILD_BUG_ON
> > >>>     should alert anyone accidentally expanding the register enum th=
at they need
> > >>>     to update the corresponding NR_REGS define, which in turn has a=
 comment
> > >>>     reminding them to update the vmstate version_id as well.
> > >>>   - Skip loading the bootrom if a kernel filename is provided by th=
e user.
> > >>>   - New patch adding a board setup stub to tweak clocks before boot=
ing directly
> > >>>     into the kernel.
> > >>>   - Add stuff to meson files instead of Makefiles.
> > >>>   - Try to disable the slowest drivers and services to speed up the=
 flash boot
> > >>>     acceptance test a bit. This is somewhat based on the following
> > >>>     systemd-analyze blame report:
> > >>>     https://gist.github.com/hskinnemoen/475cb0676530cd2cebaa1754cf1=
6ca97
> > >>>
> > >>> Changes since v6:
> > >>>
> > >>>   - Use size_to_str to report DRAM sizes in npcm7xx_gcr.
> > >>>   - Simplify the interrupt logic in npcm7xx_timer.
> > >>>   - Update global bios_name instead of temporary.
> > >>>   - Add npcm7xx_bootrom to MAINTAINERS and pc-bios/README.
> > >>>   - Use a predefined name for the gsj boot image in the acceptance =
test.
> > >>>
> > >>> Changes since v5:
> > >>>
> > >>>   - Boot ROM included, as a git submodule and a binary blob, and lo=
aded by
> > >>>     default, so the -bios option is usually not necessary anymore.
> > >>>   - Two acceptance tests added (openbmc image boot, and direct kern=
el boot).
> > >>>   - npcm7xx_load_kernel() moved to SoC code.
> > >>>   - NPCM7XX_TIMER_REF_HZ definition moved to CLK header.
> > >>>   - Comments added clarifying available SPI flash chip selects.
> > >>>   - Error handling adjustments:
> > >>>       - Errors from CPU and GCR realization are propagated through =
the SoC
> > >>>         since they may be triggered by user-configurable parameters=
.
> > >>>       - Machine init uses error_fatal instead of error_abort for So=
C
> > >>>         realization flash init. This makes error messages more help=
ful.
> > >>>       - Comments added to indicate whether peripherals may fail to =
realize.
> > >>>       - Use ERRP_GUARD() instead of Error *err when possible.
> > >>>   - Default CPU type is now set, and attempting to set it to anythi=
ng else
> > >>>     will fail.
> > >>>   - Format string fixes (use HWADDR_PRIx, etc.)
> > >>>   - Simplified memory size encoding and error checking in npcm7xx_g=
cr.
> > >>>   - Encapsulate non-obvious pointer subtraction into helper functio=
ns in the
> > >>>     FIU and TIMER modules.
> > >>>   - Incorporate review feedback into the FIU module:
> > >>>       - Add select/deselect trace events.
> > >>>       - Use npcm7xx_fiu_{de,}select() consistently.
> > >>>       - Use extract/deposit in more places for consistency.
> > >>>       - Use -Wimplicit-fallthrough compatible fallthrough comments.
> > >>>       - Use qdev_init_gpio_out_named instead of sysbus_init_irq for=
 chip
> > >>>         selects.
> > >>>   - Incorporate review feedback into the TIMER module:
> > >>>       - Assert that we never pause a timer that has already expired=
, instead of
> > >>>         trying to handle it. This should be safe since QEMU_CLOCK_V=
IRTUAL is
> > >>>         stopped while this code is running.
> > >>>       - Simplify the switch blocks in the read and write handlers.
> > >>>
> > >>> I made a change to error out if a flash drive was not specified, bu=
t reverted
> > >>> it because it caused make check to fail (qom-test). When specifying=
 a NULL
> > >>> block device, the m25p flash device initializes its in-memory stora=
ge with 0xff
> > >>> and doesn't attempt to write anything back. This seems correct to m=
e.
> > >>>
> > >>> Changes since v4:
> > >>>
> > >>>   - OTP cleanups suggested by Philippe Mathieu-Daud=C3=A9.
> > >>>       - Added fuse array definitions based on public Nuvoton bootbl=
ock code.
> > >>>       - Moved class structure to .c file since it's only used inter=
nally.
> > >>>       - Readability improvements.
> > >>>   - Split the first patch and folded parts of it into three other p=
atches so
> > >>>     that CONFIG_NPCM7XX is only enabled after the initial NPCM7xx m=
achine
> > >>>     support is added.
> > >>>   - DRAM init moved to machine init code.
> > >>>   - Consistently use lower-case hex literals.
> > >>>   - Switched to fine-grained unimplemented devices, based on public=
 bootblock
> > >>>     source code. Added a tiny SRAM that got left out previously.
> > >>>   - Simplified error handling in npcm7xx_realize() since the board =
code will
> > >>>     abort anyway, and SoCs are not hot-pluggable.
> > >>>
> > >>> Changes since v3:
> > >>>
> > >>>   - License headers are now GPL v2-or-later throughout.
> > >>>   - Added vmstate throughout (except the memory controller, which d=
oesn't
> > >>>     really have any state worth saving). Successfully booted a gsj =
image
> > >>>     with two stop/savevm/quit/loadvm cycles along the way.
> > >>>       - JFFS2 really doesn't like it if I let qemu keep running aft=
er savevm,
> > >>>         and then jump back in time with loadvm. I assume this is ex=
pected.
> > >>>   - Fixed an error API violation in npcm7xx_realize, removed pointl=
ess error
> > >>>     check after object_property_set_link().
> > >>>   - Switched the OTP device to use an embedded array instead of a g=
_malloc0'd
> > >>>     one because I couldn't figure out how to set up vmstate for the=
 latter.
> > >>>
> > >>> Changes since v2:
> > >>>
> > >>>   - Simplified the MAINTAINERS entry.
> > >>>   - Added link to OpenPOWER jenkins for gsj BMC images.
> > >>>   - Reverted the smpboot change, back to byte swapping.
> > >>>   - Adapted to upstream API changes:
> > >>>       - sysbus_init_child_obj -> object_initialize_child
> > >>>       - object_property_set_bool -> qdev_realize / sysbus_realize
> > >>>       - ssi_create_slave_no_init -> qdev_new
> > >>>       - qdev_init_nofail -> qdev_realize_and_unref
> > >>>       - ssi_auto_connect_slaves removed
> > >>>   - Moved Boot ROM loading from soc to machine init.
> > >>>   - Plumbed power-on-straps property from GCR to the machine init c=
ode so it
> > >>>     can be properly initialized. Turns out npcm750 memory init does=
n't work
> > >>>     without this. npcm730 is fine either way, though I'm not sure w=
hy.
> > >>>   - Reworked the flash init code so it looks more like aspeed (i.e.=
 the flash
> > >>>     device gets added even if there's no drive).
> > >>>
> > >>> Changes since v1 (requested by reviewers):
> > >>>
> > >>>   - Clarify the source of CLK reset values.
> > >>>   - Made smpboot a constant byte array, eliinated byte swapping.
> > >>>   - NPCM7xxState now stores an array of ARMCPUs, not pointers to AR=
MCPUs.
> > >>>   - Clarify why EL3 is disabled.
> > >>>   - Introduce NPCM7XX_NUM_IRQ constant.
> > >>>   - Set the number of CPUs according to SoC variant, and disallow c=
ommand line
> > >>>     overrides (i.e. you can no longer override the number of CPUs w=
ith the -smp
> > >>>     parameter). This is trying to follow the spirit of
> > >>>     https://patchwork.kernel.org/patch/11595407/.
> > >>>   - Switch register operations to DEVICE_LITTLE_ENDIAN throughout.
> > >>>   - Machine documentation added (new patch).
> > >>>
> > >>> Changes since v1 to support flash booting:
> > >>>
> > >>>   - GCR reset value changes to get past memory initialization when =
booting
> > >>>     from flash (patches 2 and 5):
> > >>>       - INTCR2 now indicates that the DDR controller is initialized=
.
> > >>>       - INTCR3 is initialized according to DDR memory size. A reali=
ze()
> > >>>     method was implemented to achieve this.
> > >>>   - Refactor the machine initialization a bit to make it easier to =
drop in
> > >>>     machine-specific flash initialization (patch 6).
> > >>>   - Extend the series with additional patches to enable booting fro=
m flash:
> > >>>       - Boot ROM (through the -bios option).
> > >>>       - OTP (fuse) controller.
> > >>>       - Memory Controller stub (just enough to skip memory training=
).
> > >>>       - Flash controller.
> > >>>       - Board-specific flash initialization.
> > >>>
> > >>> Thanks for reviewing,
> > >>>
> > >>> Havard
> > >>>
> > >>> Havard Skinnemoen (14):
> > >>>   hw/misc: Add NPCM7xx System Global Control Registers device model
> > >>>   hw/misc: Add NPCM7xx Clock Controller device model
> > >>>   hw/timer: Add NPCM7xx Timer device model
> > >>>   hw/arm: Add NPCM730 and NPCM750 SoC models
> > >>>   hw/arm: Add two NPCM7xx-based machines
> > >>>   roms: Add virtual Boot ROM for NPCM7xx SoCs
> > >>>   hw/arm: Load -bios image as a boot ROM for npcm7xx
> > >>>   hw/nvram: NPCM7xx OTP device model
> > >>>   hw/mem: Stubbed out NPCM7xx Memory Controller model
> > >>>   hw/ssi: NPCM7xx Flash Interface Unit device model
> > >>>   hw/arm: Wire up BMC boot flash for npcm750-evb and quanta-gsj
> > >>>   hw/arm/npcm7xx: add board setup stub for CPU and UART clocks
> > >>>   docs/system: Add Nuvoton machine documentation
> > >>>   tests/acceptance: console boot tests for quanta-gsj
> > >>>
> > >>>  docs/system/arm/nuvoton.rst            |  90 ++++
> > >>>  docs/system/target-arm.rst             |   1 +
> > >>>  Makefile                               |   1 +
> > >>>  default-configs/arm-softmmu.mak        |   1 +
> > >>>  include/hw/arm/npcm7xx.h               | 112 +++++
> > >>>  include/hw/mem/npcm7xx_mc.h            |  36 ++
> > >>>  include/hw/misc/npcm7xx_clk.h          |  48 +++
> > >>>  include/hw/misc/npcm7xx_gcr.h          |  43 ++
> > >>>  include/hw/nvram/npcm7xx_otp.h         |  79 ++++
> > >>>  include/hw/ssi/npcm7xx_fiu.h           |  73 ++++
> > >>>  include/hw/timer/npcm7xx_timer.h       |  78 ++++
> > >>>  hw/arm/npcm7xx.c                       | 532 +++++++++++++++++++++=
++
> > >>>  hw/arm/npcm7xx_boards.c                | 197 +++++++++
> > >>>  hw/mem/npcm7xx_mc.c                    |  84 ++++
> > >>>  hw/misc/npcm7xx_clk.c                  | 266 ++++++++++++
> > >>>  hw/misc/npcm7xx_gcr.c                  | 269 ++++++++++++
> > >>>  hw/nvram/npcm7xx_otp.c                 | 439 +++++++++++++++++++
> > >>>  hw/ssi/npcm7xx_fiu.c                   | 572 +++++++++++++++++++++=
++++
> > >>>  hw/timer/npcm7xx_timer.c               | 509 +++++++++++++++++++++=
+
> > >>>  .gitmodules                            |   3 +
> > >>>  MAINTAINERS                            |  10 +
> > >>>  hw/arm/Kconfig                         |   9 +
> > >>>  hw/arm/meson.build                     |   1 +
> > >>>  hw/mem/meson.build                     |   1 +
> > >>>  hw/misc/meson.build                    |   4 +
> > >>>  hw/misc/trace-events                   |   8 +
> > >>>  hw/nvram/meson.build                   |   1 +
> > >>>  hw/ssi/meson.build                     |   1 +
> > >>>  hw/ssi/trace-events                    |  11 +
> > >>>  hw/timer/meson.build                   |   1 +
> > >>>  hw/timer/trace-events                  |   5 +
> > >>>  pc-bios/README                         |   6 +
> > >>>  pc-bios/npcm7xx_bootrom.bin            | Bin 0 -> 768 bytes
> > >>>  roms/Makefile                          |   7 +
> > >>>  roms/vbootrom                          |   1 +
> > >>>  tests/acceptance/boot_linux_console.py |  83 ++++
> > >>>  36 files changed, 3582 insertions(+)
> > >>>  create mode 100644 docs/system/arm/nuvoton.rst
> > >>>  create mode 100644 include/hw/arm/npcm7xx.h
> > >>>  create mode 100644 include/hw/mem/npcm7xx_mc.h
> > >>>  create mode 100644 include/hw/misc/npcm7xx_clk.h
> > >>>  create mode 100644 include/hw/misc/npcm7xx_gcr.h
> > >>>  create mode 100644 include/hw/nvram/npcm7xx_otp.h
> > >>>  create mode 100644 include/hw/ssi/npcm7xx_fiu.h
> > >>>  create mode 100644 include/hw/timer/npcm7xx_timer.h
> > >>>  create mode 100644 hw/arm/npcm7xx.c
> > >>>  create mode 100644 hw/arm/npcm7xx_boards.c
> > >>>  create mode 100644 hw/mem/npcm7xx_mc.c
> > >>>  create mode 100644 hw/misc/npcm7xx_clk.c
> > >>>  create mode 100644 hw/misc/npcm7xx_gcr.c
> > >>>  create mode 100644 hw/nvram/npcm7xx_otp.c
> > >>>  create mode 100644 hw/ssi/npcm7xx_fiu.c
> > >>>  create mode 100644 hw/timer/npcm7xx_timer.c
> > >>>  create mode 100644 pc-bios/npcm7xx_bootrom.bin
> > >>>  create mode 160000 roms/vbootrom
> > >>>
> > >>> --
> > >>> 2.28.0.297.g1956fa8f8d-goog
> > >>>
> > >>>
> > >>
> > >

