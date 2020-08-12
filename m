Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4580C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 03:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A030D207F7
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 03:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dl6a1c4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A030D207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5hQA-0002pe-Sl
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 23:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1k5hPP-0002It-Nn
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 23:26:35 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:46541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1k5hPL-0006Ip-Kk
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 23:26:35 -0400
Received: by mail-vs1-xe42.google.com with SMTP id b26so373149vsa.13
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 20:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=N9IiGYQwLXK2ffY4YWNIwIlc1nIjAK/bJHiTOG1PQsw=;
 b=Dl6a1c4ytrDTr6tUvZAaGzdhtIflbo7/v1DwRBk0TWtUCaSomIzRVO2s9FBIQubhfp
 Z+FuAl8hB0LAOwPdkt2cFCFOkW9x8ziR8UTE/u57gUFg/1v0qFyoWcLKJ3BXY58EEqBS
 2yIVI9CpLlJYDywVqk8obd6RCXpaZppdnuPhxjq2iOTH6jhad49+Jgr3OHhGYQ9rwmCn
 yDgfJ0C+AYMlj/F0Zg9ld2FOw41cW6/0EVGhQ3NCV1Cc2yxqGc0WdU4L8X57LuolsvbV
 +daRorx9HeH85l8Xvt/KDX6dCUDh5YUb4pE8JrtpftTiS9kmaqY1jO1dTiTccXuJW76y
 mDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=N9IiGYQwLXK2ffY4YWNIwIlc1nIjAK/bJHiTOG1PQsw=;
 b=VKYz86CgrqpiLphoSeaRPw5cZ94kqdl8zb92VH3t6yCALTMRAf1kVu7FRbpEVRHDjb
 LhFXYUFQsmCIY+rQM6TYFOEsECHP26/usOfrJbYKcmwzOEh5k8uY9ksprV82mXPJWgQo
 kKn0CenJtLBOpVeQUdXLaBxUJTKxBz5J/dkLhwbrcagptkGNBfJilMayE/9c230yKYeJ
 rap2BwjT0QCgjMh6mywrgkS9YtIboaVXahliiGPVi98Ss/nUDc3n95T5erpnp1MwuxVc
 5hTt3HagsZdvZSEoLTlskq+VQWMJ+uNQ/axaRCL4aoZHxeuq5G8I4IbwJbHFGu8BtKp2
 stdA==
X-Gm-Message-State: AOAM530CRFH1mjsL0CL5ORASDaiMxAXr6UxcZQ5/FgpWV1d4rzuryZE2
 v41GlTKGYn/cPt0IkJzLzqL3aU3GgLxUWNf2FY+/PA==
X-Google-Smtp-Source: ABdhPJzzN4XufYkYjFDL8jvBFSt4IueIyBIWH1yzaMAsgY4MWNrtaWJ6q/t7gHUcPtZX48ibY+IdZzvc2oAEzZBo8Lg=
X-Received: by 2002:a67:7d50:: with SMTP id y77mr27459061vsc.207.1597202788138; 
 Tue, 11 Aug 2020 20:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200811004607.2133149-1-hskinnemoen@google.com>
 <20200811004607.2133149-14-hskinnemoen@google.com>
 <64f8cd56-306e-4961-488b-36c666894a54@amsat.org>
In-Reply-To: <64f8cd56-306e-4961-488b-36c666894a54@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Tue, 11 Aug 2020 20:26:16 -0700
Message-ID: <CAFQmdRbvSKYJ00tE_79Eh+gW_ge8kEco=1gqFtvMcoJGraozdw@mail.gmail.com>
Subject: Re: [PATCH v7 13/13] tests/acceptance: console boot tests for
 quanta-gsj
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e42;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
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

On Tue, Aug 11, 2020 at 1:48 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Hi Havard,
>
> On 8/11/20 2:46 AM, Havard Skinnemoen wrote:
> > This adds two acceptance tests for the quanta-gsj machine.
> >
> > One test downloads a lightly patched openbmc flash image from github an=
d
> > verifies that it boots all the way to the login prompt.
> >
> > The other test downloads a kernel, initrd and dtb built from the same
> > openbmc source and verifies that the kernel detects all CPUs and boots
> > to the point where it can't find the root filesystem (because we have n=
o
> > flash image in this case).
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> > ---
> >  tests/acceptance/boot_linux_console.py | 65 ++++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> > index 73cc69c499..8592f33a41 100644
> > --- a/tests/acceptance/boot_linux_console.py
> > +++ b/tests/acceptance/boot_linux_console.py
> > @@ -569,6 +569,71 @@ class BootLinuxConsole(LinuxKernelTest):
> >                                                  'sda')
> >          # cubieboard's reboot is not functioning; omit reboot test.
> >
> > +    def test_arm_quanta_gsj(self):
> > +        """
> > +        :avocado: tags=3Darch:arm
> > +        :avocado: tags=3Dmachine:quanta-gsj
> > +        """
> > +        # 25 MiB compressed, 32 MiB uncompressed.
> > +        image_url =3D (
> > +                'https://github.com/hskinnemoen/openbmc/releases/downl=
oad/'
> > +                '20200711-gsj-qemu-0/obmc-phosphor-image-gsj.static.mt=
d.gz')
> > +        image_hash =3D '14895e634923345cb5c8776037ff7876df96f6b1'
> > +        image_path_gz =3D self.fetch_asset(image_url, asset_hash=3Dima=
ge_hash)
> > +        image_name =3D 'obmc.mtd'
> > +        image_path =3D os.path.join(self.workdir, image_name)
> > +        archive.gzip_uncompress(image_path_gz, image_path)
> > +
> > +        self.vm.set_console()
> > +        drive_args =3D 'file=3D' + image_path + ',if=3Dmtd,bus=3D0,uni=
t=3D0'
> > +        self.vm.add_args('-drive', drive_args)
> > +        self.vm.launch()
> > +
> > +        self.wait_for_console_pattern('> BootBlock by Nuvoton')
> > +        self.wait_for_console_pattern('>Device: Poleg BMC NPCM730')
> > +        self.wait_for_console_pattern('>Skip DDR init.')
> > +        self.wait_for_console_pattern('U-Boot ')
> > +        self.wait_for_console_pattern('Booting Linux on physical CPU 0=
x0')
>
> Tests timeout using QEMU configured with '--enable-debug
> --extra-cflags=3D-ggdb':
>
> console: Booting Linux on physical CPU 0x0
> console: CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
>
> console: stmmaceth f0802000.eth: DMA HW capability register supported
> console: stmmaceth f0802000.eth: Normal descriptors
> console: stmmaceth f0802000.eth: Ring mode enabled
> console: stmmaceth f0802000.eth: device MAC address 92:f6:8f:80:9f:bb
> INTERRUPTED: Test interrupted by SIGTERM
> Runner error occurred: Timeout reached
> (91.05 s)
>
> My guess is unoptimized build makes guest hashing checks over
> the bitbanged SPI flash emulation takes too long.

Right, flash access is super slow when optimization is turned off.

> Trying with timeout=3D240s:
>
> console: [*     ] (1 of 2) A start job is running for=E2=80=A6dplug all D=
evices
> (44s / no limit)
> console: [**    ] (2 of 2) A start job is running for=E2=80=A6Save Random=
 Seed
> (44s / 10min 13s)
> console: [***   ] (2 of 2) A start job is running for=E2=80=A6Save Random=
 Seed
> (45s / 10min 13s)
> console: [ ***  ] (2 of 2) A start job is running for=E2=80=A6Save Random=
 Seed
> (45s / 10min 13s)
> console: [  *** ] (1 of 2) A start job is running for=E2=80=A6dplug all D=
evices
> (46s / no limit)
> console: [   ***] (1 of 2) A start job is running for=E2=80=A6dplug all D=
evices
> (46s / no limit)
> console: [    **] (1 of 2) A start job is running for=E2=80=A6dplug all D=
evices
> (47s / no limit)
> console: [     *] (2 of 2) A start job is running for=E2=80=A6Save Random=
 Seed
> (47s / 10min 13s)
> console: [    **] (2 of 2) A start job is running for=E2=80=A6Save Random=
 Seed
> (48s / 10min 13s)
> console: [   ***] (2 of 2) A start job is running for=E2=80=A6Save Random=
 Seed
> (48s / 10min 13s)
> console: [  *** ] (1 of 2) A start job is running for=E2=80=A6dplug all D=
evices
> (49s / no limit)
> console: [ ***  ] (1 of 2) A start job is running for=E2=80=A6dplug all D=
evices
> (51s / no limit)
> console: [***   ] (1 of 2) A start job is running for=E2=80=A6dplug all D=
evices
> (53s / no limit)
> console: [**    ] (2 of 2) A start job is running for=E2=80=A6Save Random=
 Seed
> (53s / 10min 13s)
> console: [*     ] (2 of 2) A start job is running for=E2=80=A6Save Random=
 Seed
> (54s / 10min 13s)
> console: [**    ] (2 of 2) A start job is running for=E2=80=A6Save Random=
 Seed
> (55s / 10min 13s)
> console: [***   ] (1 of 2) A start job is running for=E2=80=A6dplug all D=
evices
> (56s / no limit)
> console: [ ***  ] (1 of 2) A start job is running for=E2=80=A6dplug all D=
evices
> (57s / no limit)
> console: [  *** ] (1 of 2) A start job is running for=E2=80=A6dplug all D=
evices
> (57s / no limit)
>
> Maybe you can disable some expensive services for the test purpose?
> See examples of cmdline 'systemd.mask=3D' in test_arm_orangepi_bionic().

I'll try that, thanks!

> Compiled with -O2:
>
> console: [  *** ] A start job is running for Load/Save Random Seed (1s /
> 9min 45s)
> console: [ ***  ] A start job is running for Load/Save Random Seed (1s /
> 9min 45s)
> console: [***   ] A start job is running for Load/Save Random Seed (1s /
> 9min 45s)
> console: [**    ] A start job is running for Load/Save Random Seed (2s /
> 9min 45s)
> console: [*     ] A start job is running for Load/Save Random Seed (2s /
> 9min 45s)
> console: [**    ] A start job is running for Load/Save Random Seed (2s /
> 9min 45s)
> ...
> console: Phosphor OpenBMC (Phosphor OpenBMC Project Reference Distro)
> 0.1.0 gsj ttyS0
> console: gsj login: stmmaceth f0802000.eth eth1: stmmac_open: Cannot
> attach to PHY (error: -22)
> PASS (102.36 s)
>
> It pass but took >90sec.
>
> > +        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket =
0')
>
> BTW Cc'ing Cleber/Wainer because there was an Avocado feature request
> to be able to kick the test timeout watchdog at runtime, so here this
> console pattern would give the test more time to allow success. Not
> sure this is implemented or released yet.
>
> > +        self.wait_for_console_pattern('OpenBMC Project Reference Distr=
o')
> > +        self.wait_for_console_pattern('gsj login:')
> > +
> > +    def test_arm_quanta_gsj_initrd(self):
> > +        """
> > +        :avocado: tags=3Darch:arm
> > +        :avocado: tags=3Dmachine:quanta-gsj
> > +        """
> > +        initrd_url =3D (
> > +                'https://github.com/hskinnemoen/openbmc/releases/downl=
oad/'
> > +                '20200711-gsj-qemu-0/obmc-phosphor-initramfs-gsj.cpio.=
xz')
> > +        initrd_hash =3D '98fefe5d7e56727b1eb17d5c00311b1b5c945300'
> > +        initrd_path =3D self.fetch_asset(initrd_url, asset_hash=3Dinit=
rd_hash)
> > +        kernel_url =3D (
> > +                'https://github.com/hskinnemoen/openbmc/releases/downl=
oad/'
> > +                '20200711-gsj-qemu-0/uImage-gsj.bin')
> > +        kernel_hash =3D 'fa67b2f141d56d39b3c54305c0e8a899c99eb2c7'
> > +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkern=
el_hash)
> > +        dtb_url =3D (
> > +                'https://github.com/hskinnemoen/openbmc/releases/downl=
oad/'
> > +                '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb')
> > +        dtb_hash =3D '18315f7006d7b688d8312d5c727eecd819aa36a4'
> > +        dtb_path =3D self.fetch_asset(dtb_url, asset_hash=3Ddtb_hash)
> > +
> > +        self.vm.set_console()
> > +        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> > +                               'console=3DttyS0,115200n8 '
> > +                               'earlycon=3Duart8250,mmio32,0xf0001000'=
)
> > +        self.vm.add_args('-kernel', kernel_path,
> > +                         '-initrd', initrd_path,
> > +                         '-dtb', dtb_path,
> > +                         '-append', kernel_command_line)
> > +        self.vm.launch()
> > +
> > +        self.wait_for_console_pattern('Booting Linux on physical CPU 0=
x0')
> > +        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket =
0')
>
> Similarly:
>
> console: RPC: Registered named UNIX socket transport module.
> console: RPC: Registered udp transport module.
> console: RPC: Registered tcp transport module.
> console: RPC: Registered tcp NFSv4.1 backchannel transport module.
> console: Trying to unpack rootfs image as initramfs...
> INTERRUPTED: Test interrupted by SIGTERM
> Runner error occurred: Timeout reached
> (90.85 s)
>
> Trying with timeout=3D240s:
>
> console: npcm7xx-ehci: EHCI npcm7xx driver
> console: npcm7xx-ehci f0806000.usb: EHCI Host Controller
> console: npcm7xx-ehci f0806000.usb: new USB bus registered, assigned bus
> number 1
> console: npcm7xx-ehci f0806000.usb: can't setup: -110
> console: npcm7xx-ehci f0806000.usb: USB bus 1 deregistered
> console: npcm7xx-ehci f0806000.usb: init fail, -110
> console: npcm7xx-ehci: probe of f0806000.usb failed with error -110
> console: rcu: INFO: rcu_sched self-detected stall on CPU
> console: rcu:   0-....: (2131 ticks this GP) idle=3D1fe/1/0x40000002
> softirq=3D2485/2487 fqs=3D105
> console: (t=3D2100 jiffies g=3D3217 q=3D8)
> console: NMI backtrace for cpu 0
> console: CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 5.4.32-7dc9442-dirty-8978043 #1
> console: Hardware name: NPCM7XX Chip family
> console: Backtrace:
> console: [<b0107c4c>] (dump_backtrace) from [<b010823c>]
> (show_stack+0x20/0x24)
> console: r7:00000000 r6:600f0193 r5:00000000 r4:b0b5b1b8
> console: [<b010821c>] (show_stack) from [<b077b230>] (dump_stack+0x94/0xa=
8)
> console: [<b077b19c>] (dump_stack) from [<b0782d78>]
> (nmi_cpu_backtrace+0xc8/0xcc)
> console: r7:00000000 r6:00000000 r5:00000000 r4:00000000
> console: [<b0782cb0>] (nmi_cpu_backtrace) from [<b0782e0c>]
> (nmi_trigger_cpumask_backtrace+0x90/0x130)
> console: r5:b0b06d58 r4:b0109454
> console: [<b0782d7c>] (nmi_trigger_cpumask_backtrace) from [<b010a578>]
> (arch_trigger_cpumask_backtrace+0x20/0x24)
> console: r9:800f0193 r8:b0800948 r7:b0b03e2c r6:b0b03ed0 r5:b0b0e080
> r4:00000000
> console: [<b010a558>] (arch_trigger_cpumask_backtrace) from [<b0188584>]
> (rcu_dump_cpu_stacks+0x98/0xdc)
> console: [<b01884ec>] (rcu_dump_cpu_stacks) from [<b01869d0>]
> (print_cpu_stall+0x104/0x19c)
> console: r10:b0a78ab8 r9:b0b03e2c r8:b0b03f00 r7:b0b0e080 r6:b0b042b0
> r5:00000008
> console: r4:b0b02d00 r3:00025cd3
> console: [<b01868cc>] (print_cpu_stall) from [<b0186e0c>]
> (check_cpu_stall+0x138/0x238)
> console: r9:00000000 r8:cf08c000 r7:b0b0e080 r6:00025cd3 r5:b0b03ec0
> r4:b0b0e080
> console: [<b0186cd4>] (check_cpu_stall) from [<b0186f3c>]
> (rcu_pending+0x30/0xac)
> console: r9:00000000 r8:cf08c000 r7:b0b0e080 r6:1f13e000 r5:cfbc1700
> r4:b0a83700
> console: [<b0186f0c>] (rcu_pending) from [<b0187764>]
> (rcu_sched_clock_irq+0x174/0x20c)
> console: r7:cf0907c0 r6:00000000 r5:b0a83779 r4:b0b5f050
> console: [<b01875f0>] (rcu_sched_clock_irq) from [<b018ecf0>]
> (update_process_times+0x70/0x98)
> console: r7:cf0907c0 r6:1f13e000 r5:00000000 r4:cfbbb340
> console: [<b018ec80>] (update_process_times) from [<b019f10c>]
> (tick_periodic+0xc4/0xcc)
> console: r7:cf0907c0 r6:cfbc4700 r5:7fffffff r4:b0b02d40
> console: [<b019f048>] (tick_periodic) from [<b019f1bc>]
> (tick_handle_periodic+0x38/0x9c)
> console: r5:7fffffff r4:ffffffff
> console: [<b019f184>] (tick_handle_periodic) from [<b010af04>]
> (twd_handler+0x40/0x48)
> console: r9:cf0bbde0 r8:cf08c000 r7:cf0907c0 r6:00000010 r5:b0b04504
> r4:00000001
> console: [<b010aec4>] (twd_handler) from [<b017666c>]
> (handle_percpu_devid_irq+0x10c/0x278)
> console: r5:b0b04504 r4:cf08aa00
> console: [<b0176560>] (handle_percpu_devid_irq) from [<b016fd34>]
> (__handle_domain_irq+0xb8/0xcc)
> console: r10:b0a78ab8 r9:cf0bbde0 r8:cf08c000 r7:00000001 r6:00000000
> r5:00000000
> console: r4:b0a82b88 r3:b0176560
> console: [<b016fc7c>] (__handle_domain_irq) from [<b0102234>]
> (gic_handle_irq+0x6c/0xa0)
> console: r9:cf0bbde0 r8:d0803100 r7:d0802100 r6:d080210c r5:b0b37db4
> r4:b0b04504
> console: [<b01021c8>] (gic_handle_irq) from [<b0101a8c>]
> (__irq_svc+0x6c/0x90)
> console: Exception stack(0xcf0bbde0 to 0xcf0bbe28)
> console: bde0: cf1b8e10 b0b4576c 00000002 00000354 00000000 b0b4576c
> b04b3be8 b0b3dd20
> console: be00: b0a00510 b0a53854 b0a78ab8 cf0bbe5c cf0bbe08 cf0bbe30
> b04b0c14 b04b3be8
> console: be20: a00f0013 ffffffff
> console: r9:cf0ba000 r8:b0a00510 r7:cf0bbe14 r6:ffffffff r5:a00f0013
> r4:b04b3be8
> console: [<b04b0ba4>] (bus_for_each_dev) from [<b04b2748>]
> (driver_attach+0x2c/0x30)
> console: r6:00000000 r5:cb640200 r4:b0b4576c
> console: [<b04b271c>] (driver_attach) from [<b04b213c>]
> (bus_add_driver+0x128/0x214)
> console: [<b04b2014>] (bus_add_driver) from [<b04b4940>]
> (driver_register+0xdc/0x118)
> console: r7:00000000 r6:ffffe000 r5:00000000 r4:b0b4576c
> console: [<b04b4864>] (driver_register) from [<b04b5c04>]
> (__platform_driver_register+0x50/0x58)
> console: r5:b0a2e408 r4:b0b3dd20
> console: [<b04b5bb4>] (__platform_driver_register) from [<b0a2e45c>]
> (ehci_npcm7xx_init+0x54/0x60)
> console: r5:b0a2e408 r4:00000000
> console: [<b0a2e408>] (ehci_npcm7xx_init) from [<b0102d80>]
> (do_one_initcall+0xd0/0x260)
> console: r5:b0a2e408 r4:b0b5eb00
> console: [<b0102cb0>] (do_one_initcall) from [<b0a01280>]
> (kernel_init_freeable+0x15c/0x1f4)
> console: r7:b09bbb4c r6:b0a53834 r5:b0b72700 r4:00000007
> console: [<b0a01124>] (kernel_init_freeable) from [<b0794f8c>]
> (kernel_init+0x18/0x120)
> console: r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000
> r5:b0794f74
> console: r4:00000000
> console: [<b0794f74>] (kernel_init) from [<b01010e8>]
> (ret_from_fork+0x14/0x2c)
> console: Exception stack(0xcf0bbfb0 to 0xcf0bbff8)
> console: bfa0:                                     00000000 00000000
> 00000000 00000000
> console: bfc0: 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000
> console: bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> console: r5:b0794f74 r4:00000000
> ...
> console: rcu: INFO: rcu_sched self-detected stall on CPU
> console: rcu:   1-....: (18 ticks this GP) idle=3D92e/1/0x40000002
> softirq=3D2723/2723 fqs=3D111
> console: (t=3D2106 jiffies g=3D3257 q=3D1)
> console: NMI backtrace for cpu 1
> console: CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted
> 5.4.32-7dc9442-dirty-8978043 #1
> console: Hardware name: NPCM7XX Chip family
> console: Workqueue: events regulator_init_complete_work_function
> console: Backtrace:
> console: [<b0107c4c>] (dump_backtrace) from [<b010823c>]
> (show_stack+0x20/0x24)
> console: r7:00000000 r6:600f0193 r5:00000000 r4:b0b5b1b8
> console: [<b010821c>] (show_stack) from [<b077b230>] (dump_stack+0x94/0xa=
8)
> console: [<b077b19c>] (dump_stack) from [<b0782d78>]
> (nmi_cpu_backtrace+0xc8/0xcc)
> console: r7:00000000 r6:00000001 r5:00000000 r4:00000001
> console: [<b0782cb0>] (nmi_cpu_backtrace) from [<b0782e0c>]
> (nmi_trigger_cpumask_backtrace+0x90/0x130)
> console: r5:b0b06d58 r4:b0109454
> console: [<b0782d7c>] (nmi_trigger_cpumask_backtrace) from [<b010a578>]
> (arch_trigger_cpumask_backtrace+0x20/0x24)
> console: r9:800f0193 r8:b0800948 r7:b0b03e2c r6:b0b03ed0 r5:b0b0e080
> r4:00000001
> console: [<b010a558>] (arch_trigger_cpumask_backtrace) from [<b0188584>]
> (rcu_dump_cpu_stacks+0x98/0xdc)
> console: [<b01884ec>] (rcu_dump_cpu_stacks) from [<b01869d0>]
> (print_cpu_stall+0x104/0x19c)
> console: r10:00000000 r9:b0b03e2c r8:b0b03f00 r7:b0b0e080 r6:b0b042b0
> r5:00000001
> console: r4:b0b02d00 r3:0002a7f6
> console: [<b01868cc>] (print_cpu_stall) from [<b0186e0c>]
> (check_cpu_stall+0x138/0x238)
> console: r9:00000001 r8:cf08c000 r7:b0b0e080 r6:0002a7ef r5:b0b03ec0
> r4:b0b0e080
> console: [<b0186cd4>] (check_cpu_stall) from [<b0186f3c>]
> (rcu_pending+0x30/0xac)
> console: r9:00000001 r8:cf08c000 r7:b0b0e080 r6:1f150000 r5:cfbd3700
> r4:b0a83700
> console: [<b0186f0c>] (rcu_pending) from [<b0187764>]
> (rcu_sched_clock_irq+0x174/0x20c)
> console: r7:cf0907c0 r6:00000000 r5:b0a83779 r4:b0b5f050
> console: [<b01875f0>] (rcu_sched_clock_irq) from [<b018ecf0>]
> (update_process_times+0x70/0x98)
> console: r7:cf0907c0 r6:1f150000 r5:00000000 r4:cfbcd340
> console: [<b018ec80>] (update_process_times) from [<b019f10c>]
> (tick_periodic+0xc4/0xcc)
> console: r7:cf0907c0 r6:cfbd6700 r5:7fffffff r4:ffffffff
> console: [<b019f048>] (tick_periodic) from [<b019f1bc>]
> (tick_handle_periodic+0x38/0x9c)
> console: r5:7fffffff r4:ffffffff
> console: [<b019f184>] (tick_handle_periodic) from [<b010af04>]
> (twd_handler+0x40/0x48)
> console: r9:cf101eb8 r8:cf08c000 r7:cf0907c0 r6:00000010 r5:b0b04504
> r4:00000001
> console: [<b010aec4>] (twd_handler) from [<b017666c>]
> (handle_percpu_devid_irq+0x10c/0x278)
> console: r5:b0b04504 r4:cf08aa00
> console: [<b0176560>] (handle_percpu_devid_irq) from [<b016fd34>]
> (__handle_domain_irq+0xb8/0xcc)
> console: r10:00000000 r9:cf101eb8 r8:cf08c000 r7:00000001 r6:00000000
> r5:00000000
> console: r4:b0a82b88 r3:b0176560
> console: [<b016fc7c>] (__handle_domain_irq) from [<b0102234>]
> (gic_handle_irq+0x6c/0xa0)
> console: r9:cf101eb8 r8:d0803100 r7:d0802100 r6:d080210c r5:b0b37db4
> r4:b0b04504
> console: [<b01021c8>] (gic_handle_irq) from [<b0101a8c>]
> (__irq_svc+0x6c/0x90)
> console: Exception stack(0xcf101eb8 to 0xcf101f00)
> console: 1ea0:
> b0b38e5c cf007264
> console: 1ec0: b0b54cc4 b046a4ac b0b38e5c cf006600 cfbd2c00 cfbd5f00
> 00000000 b0b5ec90
> console: 1ee0: 00000000 cf101f44 00007374 cf101f08 b0136778 b046a4ac
> 600f0113 ffffffff
> console: r9:cf100000 r8:00000000 r7:cf101eec r6:ffffffff r5:600f0113
> r4:b046a4ac
> console: [<b0136444>] (process_one_work) from [<b0136c54>]
> (worker_thread+0x2d0/0x4e4)
> console: r10:cfbd2c00 r9:b0b02d00 r8:cf100000 r7:cfbd2c18 r6:cf006614
> r5:cfbd2c00
> console: r4:cf006600
> console: [<b0136984>] (worker_thread) from [<b013c8d0>]
> (kthread+0x150/0x158)
> console: r10:cf0d851c r9:b0136984 r8:cf006600 r7:cf100000 r6:cf0bbd7c
> r5:cf0d8580
> console: r4:cf0d8500
> console: [<b013c780>] (kthread) from [<b01010e8>] (ret_from_fork+0x14/0x2=
c)
> console: Exception stack(0xcf101fb0 to 0xcf101ff8)
> console: 1fa0:                                     00000000 00000000
> 00000000 00000000
> console: 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000
> console: 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> console: r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000
> r5:b013c780
> console: r4:cf0d8580 r3:00000001
> console: Run /init as init process
> console: rcu: INFO: rcu_sched self-detected stall on CPU
> console: rcu:   1-....: (2120 ticks this GP) idle=3Dab2/1/0x40000002
> softirq=3D3079/3079 fqs=3D78
> console: (t=3D2107 jiffies g=3D3741 q=3D0)
> console: NMI backtrace for cpu 1
> console: CPU: 1 PID: 138 Comm: mount Not tainted
> 5.4.32-7dc9442-dirty-8978043 #1
> console: Hardware name: NPCM7XX Chip family
> console: Backtrace:
> console: [<b0107c4c>] (dump_backtrace) from [<b010823c>]
> (show_stack+0x20/0x24)
> console: r7:00000000 r6:600d0193 r5:00000000 r4:b0b5b1b8
> console: [<b010821c>] (show_stack) from [<b077b230>] (dump_stack+0x94/0xa=
8)
> console: [<b077b19c>] (dump_stack) from [<b0782d78>]
> (nmi_cpu_backtrace+0xc8/0xcc)
> console: r7:00000000 r6:00000001 r5:00000000 r4:00000001
> console: [<b0782cb0>] (nmi_cpu_backtrace) from [<b0782e0c>]
> (nmi_trigger_cpumask_backtrace+0x90/0x130)
> console: r5:b0b06d58 r4:b0109454
> console: [<b0782d7c>] (nmi_trigger_cpumask_backtrace) from [<b010a578>]
> (arch_trigger_cpumask_backtrace+0x20/0x24)
> console: r9:800d0193 r8:b0800948 r7:b0b03e2c r6:b0b03ed0 r5:b0b0e080
> r4:00000001
> console: [<b010a558>] (arch_trigger_cpumask_backtrace) from [<b0188584>]
> (rcu_dump_cpu_stacks+0x98/0xdc)
> console: [<b01884ec>] (rcu_dump_cpu_stacks) from [<b01869d0>]
> (print_cpu_stall+0x104/0x19c)
> console: r10:00000015 r9:b0b03e2c r8:b0b03f00 r7:b0b0e080 r6:b0b042b0
> r5:00000000
> console: r4:b0b02d00 r3:0003301a
> console: [<b01868cc>] (print_cpu_stall) from [<b0186e0c>]
> (check_cpu_stall+0x138/0x238)
> console: r9:00000001 r8:cf08c000 r7:b0b0e080 r6:00033011 r5:b0b03ec0
> r4:b0b0e080
> console: [<b0186cd4>] (check_cpu_stall) from [<b0186f3c>]
> (rcu_pending+0x30/0xac)
> console: r9:00000001 r8:cf08c000 r7:b0b0e080 r6:1f150000 r5:cfbd3700
> r4:b0a83700
> console: [<b0186f0c>] (rcu_pending) from [<b0187764>]
> (rcu_sched_clock_irq+0x174/0x20c)
> console: r7:cf0907c0 r6:00000000 r5:b0a83779 r4:b0b5f050
> console: [<b01875f0>] (rcu_sched_clock_irq) from [<b018ecf0>]
> (update_process_times+0x70/0x98)
> console: r7:cf0907c0 r6:1f150000 r5:00000000 r4:cfbcd340
> console: [<b018ec80>] (update_process_times) from [<b019f10c>]
> (tick_periodic+0xc4/0xcc)
> console: r7:cf0907c0 r6:cfbd6700 r5:7fffffff r4:ffffffff
> console: [<b019f048>] (tick_periodic) from [<b019f1bc>]
> (tick_handle_periodic+0x38/0x9c)
> console: r5:7fffffff r4:ffffffff
> console: [<b019f184>] (tick_handle_periodic) from [<b010af04>]
> (twd_handler+0x40/0x48)
> console: r9:cb7c7ed0 r8:cf08c000 r7:cf0907c0 r6:00000010 r5:b0b04504
> r4:00000001
> console: [<b010aec4>] (twd_handler) from [<b017666c>]
> (handle_percpu_devid_irq+0x10c/0x278)
> console: r5:b0b04504 r4:cf08aa00
> console: [<b0176560>] (handle_percpu_devid_irq) from [<b016fd34>]
> (__handle_domain_irq+0xb8/0xcc)
> console: r10:00000015 r9:cb7c7ed0 r8:cf08c000 r7:00000001 r6:00000000
> r5:00000000
> console: r4:b0a82b88 r3:b0176560
> console: [<b016fc7c>] (__handle_domain_irq) from [<b0102234>]
> (gic_handle_irq+0x6c/0xa0)
> console: r9:cb7c7ed0 r8:d0803100 r7:d0802100 r6:d080210c r5:b0b37db4
> r4:b0b04504
> console: [<b01021c8>] (gic_handle_irq) from [<b0101a8c>]
> (__irq_svc+0x6c/0x90)
> console: Exception stack(0xcb7c7ed0 to 0xcb7c7f18)
> console: 7ec0:                                     00000000 aeffffff
> 00000000 00000055
> console: 7ee0: 0000021c cb7c6000 cb7c0de4 000b21a0 00008004 cb7c6000
> 00000015 cb7c7f3c
> console: 7f00: 00000051 cb7c7f20 b0278a5c b0278a60 000d0013 ffffffff
> console: r9:cb7c6000 r8:00008004 r7:cb7c7f04 r6:ffffffff r5:000d0013
> r4:b0278a60
> console: [<b02789dc>] (exact_copy_from_user) from [<b027dc60>]
> (copy_mount_options+0x58/0xa0)
> console: r7:aea22fa9 r6:cb7c0000 r5:000b11a0 r4:00001000
> console: [<b027dc08>] (copy_mount_options) from [<b027e538>]
> (ksys_mount+0x74/0xc4)
> console: r7:aea22fa9 r6:cb77db00 r5:00008004 r4:cb77d240
> console: [<b027e4c4>] (ksys_mount) from [<b027e5ac>] (sys_mount+0x24/0x2c=
)
> console: r8:b0101204 r7:00000015 r6:000974dc r5:00008004 r4:000b11a0
> console: [<b027e588>] (sys_mount) from [<b0101000>]
> (ret_fast_syscall+0x0/0x54)
> console: Exception stack(0xcb7c7fa8 to 0xcb7c7ff0)
> console: 7fa0:                   000b11a0 00008004 aea22fa3 aea22fa9
> aea22fb0 00008004
> console: 7fc0: 000b11a0 00008004 000974dc 00000015 000b11a0 00000000
> 00000000 000af65c
> console: 7fe0: 000af4e0 aea22bb8 0004f3e0 49fe8330
> INTERRUPTED: Test interrupted by SIGTERM
> Runner error occurred: Timeout reached
> (240.45 s)
>
> Is that expected?

I'm not sure why it only happens when running direct kernel boot with
unoptimized qemu, but it seems a little happier if I enable a few more
peripherals that I have queued up (sd, ehci, ohci and rng), though not
enough.

It still stalls for an awfully long time on "console: Run /init as
init process" though. I'm not sure what it's doing there. With -O2 it
only takes a couple of seconds to move on.

Adding set -x to the top of /init give me this:
https://gist.github.com/hskinnemoen/d48982b791dd8389e41468c9a3fbffbe

The blkid invocations seem to take a lot of time (e.g. there was an
NMI backtrace while running blkid /dev/mtdblock6). Perhaps it takes
especially long when there's no valid filesystem in the flash?


> Compiled with -O2 it works much better:
>
> console: Give root password for system maintenance
> PASS (11.71 s)
>
> > +        self.wait_for_console_pattern(
> > +                'Give root password for system maintenance')
> > +
> >      def test_arm_orangepi(self):
> >          """
> >          :avocado: tags=3Darch:arm
> >
>

