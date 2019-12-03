Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804ECC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:47:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C722080A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSHxRvId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C722080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icF4z-0004mX-8R
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 15:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1icDoG-00024p-RF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:26:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1icDoA-0001s4-5H
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:26:05 -0500
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30]:33643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1icDo9-0001as-Ox; Tue, 03 Dec 2019 14:26:02 -0500
Received: by mail-io1-xd30.google.com with SMTP id j13so5143160ioe.0;
 Tue, 03 Dec 2019 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q59LGKPX00OXXu/bzLVuRQ5ldPP5Jh7dhrE/xNgoVOQ=;
 b=HSHxRvIdrU8MTCYmztBzFS5Inr8CRYQVV+UFeUzv6GgrZ1Ou3MIBSFNEDe1zS/SIjO
 E3xKb9yQ6cWp0HKrqJmWvSl0qzqzo0kibM0cLuQtbpIEmJWcbaTvJ1kbIeKlBRcBXY4p
 qvf8Y0N6AxVu36ayIVfHl8d+nZT1JQ4sIB3idx7QuqEm5Mt2LG4b+Z63JJCWAsP7uD/3
 vFnJt6Jj4GNlcD9u+mIzNMuvnRS6FT58j6TpNqtwsLmT9ggfJu78sIZ/gmQXI9SlfGw0
 PMjDS1XR1VQ4Cfi7twNeJr7Ool2MEbQFt7rQ+vb6rE4IVoEjT7mfdvdt65gdRyobH9IX
 0Rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q59LGKPX00OXXu/bzLVuRQ5ldPP5Jh7dhrE/xNgoVOQ=;
 b=r00UCbopj3sJiHvjeYWoyF5l3DYARHbIEj14yGanfvzcRRueI88DpDSOhSZliUV+Gc
 tC/PfDXmnji77K8Og4wAkQBQ6VU68XI153EVp8GP/AvEBwHykLbef+PnS2N6xiyJZMGi
 qz0sMdnlBfKfuSFsXhIGC4mS1E1FEfCPiqhWV635Qa6oCDoyOgTgtTEF/9u1blLA8RW4
 VwGPvPfMoA/5baOMhTyhT5fvsaEHzY6R7uqJAo0UVwcBM6Cm0lmzGZp9feBqNohhQPP5
 Fo3XWiXbs/u0jMO0ikPBfhBaJ17LZEOb096sblb4jrU99Sw0kyYUYcgBvrJnQkps1/iZ
 D4ig==
X-Gm-Message-State: APjAAAUHHb8+cg8AxP/9m7xXeX0Aq698h9Je9dBNhh4JqVliyIVOvSbY
 8grKXMY3afk4By0S479hhI6mM+Lushk4wAg+97Q=
X-Google-Smtp-Source: APXvYqwN/Pow0alPHzFAknqyq5/o1P441HsVU6oa5OBU7hyQbN14HMStEYWx7mH3hNGoEY4ZTOF+bbtFITELU+kapMc=
X-Received: by 2002:a6b:d912:: with SMTP id r18mr3435327ioc.306.1575401157295; 
 Tue, 03 Dec 2019 11:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <f54375da-4383-04c5-d57c-3a2f6ff46189@redhat.com>
In-Reply-To: <f54375da-4383-04c5-d57c-3a2f6ff46189@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 3 Dec 2019 20:25:46 +0100
Message-ID: <CAPan3Wri8iHkn7oaoUpjqgB3TZBb5foCQWGDcBnUu29PuiTVTA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005c0a4a0598d1aa1b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d30
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
Cc: b.galvani@gmail.com, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005c0a4a0598d1aa1b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Thanks for your very quick response!
I remember I have seen this error before while working on the patches, in
particular
on the SMP part. I'll try to reproduce this error with the 4.20 sunxi
kernel you used and debug it.

Could it be related to the change I made in patch 0006 for the CP10/CP11
bits?
Basically I needed to add that to get the CPUCFG module working. It is an
interface
that U-Boot uses to reset the secondary cores for PSCI functionality. I use=
d
the arm_set_cpu_on() function there to reset the cores at the desired start
address,
but Im not sure if that function is the right choice. At some point while
rebasing the patches,
I got undefined exceptions which turned out to be because of the CP10/CP11
bits missing.
If I made an obvious mistake there, please let me know and I'll correct it.

Regards,
Niek


On Tue, Dec 3, 2019 at 9:47 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om>
wrote:

> On 12/2/19 10:09 PM, Niek Linnenbank wrote:
> > Dear QEMU developers,
> >
> > Hereby I would like to contribute the following set of patches to QEMU
> > which add support for the Allwinner H3 System on Chip and the
> > Orange Pi PC machine. The following features and devices are supported:
> >
> >   * SMP (Quad Core Cortex A7)
> >   * Generic Interrupt Controller configuration
> >   * SRAM mappings
> >   * Timer device (re-used from Allwinner A10)
> >   * UART
> >   * SD/MMC storage controller
> >   * EMAC ethernet connectivity
> >   * USB 2.0 interfaces
> >   * Clock Control Unit
> >   * System Control module
> >   * Security Identifier device
>
> Awesome!
>
> > Functionality related to graphical output such as HDMI, GPU,
> > Display Engine and audio are not included. Recently released
> > mainline Linux kernels (4.19 up to latest master) and mainline U-Boot
> > are known to work. The SD/MMC code is tested using bonnie++ and
> > various tools such as fsck, dd and fdisk. The EMAC is verified with
> iperf3
> > using -netdev socket.
> >
> > To build a Linux mainline kernel that can be booted by the Orange Pi PC
> > machine, simply configure the kernel using the sunxi_defconfig
> configuration:
> >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make mrproper
> >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make sunxi_defconfig
> >
> > To be able to use USB storage, you need to manually enable the
> corresponding
> > configuration item. Start the kconfig configuration tool:
> >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make menuconfig
> >
> > Navigate to the following item, enable it and save your configuration:
> >   Device Drivers > USB support > USB Mass Storage support
> >
> > Build the Linux kernel with:
> >   $ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -j5
> >
> > To boot the newly build linux kernel in QEMU with the Orange Pi PC
> machine, use:
> >   $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
> >       -kernel /path/to/linux/arch/arm/boot/zImage \
> >       -append 'console=3DttyS0,115200' \
> >       -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb
> >
> > Note that this kernel does not have a root filesystem. You may provide =
it
> > with an official Orange Pi PC image [1] either as an SD card or as
> > USB mass storage. To boot using the Orange Pi PC Debian image on SD car=
d,
> > simply add the -sd argument and provide the proper root=3D kernel
> parameter:
> >   $ qemu-system-arm -M orangepi -m 512 -nic user -nographic \
> >       -kernel /path/to/linux/arch/arm/boot/zImage \
> >       -append 'console=3DttyS0,115200 root=3D/dev/mmcblk0p2' \
> >       -dtb /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb \
> >       -sd OrangePi_pc_debian_stretch_server_linux5.3.5_v1.0.img
> >
> > Alternatively, you can also choose to build and boot a recent buildroot
> [2]
> > using the orangepi_pc_defconfig or Armbian image [3] for Orange Pi PC.
>
> Richard, trying the Armbian image from
> https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/ I get:
>
> $ arm-softmmu/qemu-system-arm -M orangepi -m 512 -nic user \
>    -append 'console=3DttyS0,115200' \
>    -kernel boot/vmlinuz-4.20.7-sunxi \
>    -dtb usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb \
>    -serial stdio -d unimp
> Uncompressing Linux... done, booting the kernel.
> rtc: unimplemented device write (size 4, value 0x16aa0001, offset 0x0)
> rtc: unimplemented device read (size 4, offset 0x0)
> rtc: unimplemented device read (size 4, offset 0x0)
> rtc: unimplemented device read (size 4, offset 0x8)
> qemu-system-arm: target/arm/helper.c:11359: cpu_get_tb_cpu_state:
> Assertion `flags =3D=3D rebuild_hflags_internal(env)' failed.
> Aborted (core dumped)
>
> (gdb) bt
> #0  0x00007f6c1fa2ce35 in raise () at /lib64/libc.so.6
> #1  0x00007f6c1fa17895 in abort () at /lib64/libc.so.6
> #2  0x00007f6c1fa17769 in _nl_load_domain.cold () at /lib64/libc.so.6
> #3  0x00007f6c1fa25566 in annobin_assert.c_end () at /lib64/libc.so.6
> #4  0x00005590657e2685 in cpu_get_tb_cpu_state (env=3D0x5590686899b0,
> pc=3D0x7f6c07ffa718, cs_base=3D0x7f6c07ffa714, pflags=3D0x7f6c07ffa71c) a=
t
> target/arm/helper.c:11359
> #5  0x000055906569f962 in tb_lookup__cpu_state (cpu=3D0x5590686808b0,
> pc=3D0x7f6c07ffa718, cs_base=3D0x7f6c07ffa714, flags=3D0x7f6c07ffa71c,
> cf_mask=3D524288) at include/exec/tb-lookup.h:28
> #6  0x00005590656a084c in tb_find (cpu=3D0x5590686808b0, last_tb=3D0x0,
> tb_exit=3D0, cf_mask=3D524288) at accel/tcg/cpu-exec.c:403
> #7  0x00005590656a114a in cpu_exec (cpu=3D0x5590686808b0) at
> accel/tcg/cpu-exec.c:730
> #8  0x000055906565f6af in tcg_cpu_exec (cpu=3D0x5590686808b0) at cpus.c:1=
473
> #9  0x000055906565ff05 in qemu_tcg_cpu_thread_fn (arg=3D0x5590686808b0) a=
t
> cpus.c:1781
> #10 0x0000559065d54aa6 in qemu_thread_start (args=3D0x5590687d8c20) at
> util/qemu-thread-posix.c:519
> #11 0x00007f6c1fbc54c0 in start_thread () at /lib64/libpthread.so.0
> #12 0x00007f6c1faf1553 in clone () at /lib64/libc.so.6
>
> (gdb) p/x flags
> $1 =3D 0x33600000
>
> (gdb) p/x *env
> $2 =3D {regs =3D {0x0 <repeats 15 times>, 0x40102448}, xregs =3D {0x0 <re=
peats
> 32 times>}, pc =3D 0x0, pstate =3D 0x0, aarch64 =3D 0x0, hflags =3D 0x336=
00000,
> uncached_cpsr =3D 0x1a, spsr =3D 0x0, banked_spsr =3D {0x0, 0x0, 0x0, 0x0=
,
> 0x0, 0x0, 0x0, 0x0},
>    banked_r13 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, banked_r14 =
=3D
> {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, usr_regs =3D {0x0, 0x0, 0x0,
> 0x0, 0x0}, fiq_regs =3D {0x0, 0x0, 0x0, 0x0, 0x0}, CF =3D 0x0, VF =3D 0x0=
, NF
> =3D 0x0, ZF =3D 0x0,
>    QF =3D 0x0, GE =3D 0x0, thumb =3D 0x1, condexec_bits =3D 0x0, btype =
=3D 0x0,
> daif =3D 0x3c0, elr_el =3D {0x0, 0x0, 0x0, 0x0}, sp_el =3D {0x0, 0x0, 0x0=
,
> 0x0}, cp15 =3D {c0_cpuid =3D 0x410fc075, {{_unused_csselr0 =3D 0x0, cssel=
r_ns
> =3D 0x0,
>          _unused_csselr1 =3D 0x0, csselr_s =3D 0x0}, csselr_el =3D {0x0, =
0x0,
> 0x0, 0x0}}, {{_unused_sctlr =3D 0x0, sctlr_ns =3D 0xc50078, hsctlr =3D 0x=
0,
> sctlr_s =3D 0xc50078}, sctlr_el =3D {0x0, 0xc50078, 0x0, 0xc50078}},
> cpacr_el1 =3D 0x0, cptr_el =3D {
>        0x0, 0x0, 0x0, 0x0}, c1_xscaleauxcr =3D 0x0, sder =3D 0x0, nsacr =
=3D
> 0xc00, {{_unused_ttbr0_0 =3D 0x0, ttbr0_ns =3D 0x0, _unused_ttbr0_1 =3D 0=
x0,
> ttbr0_s =3D 0x0}, ttbr0_el =3D {0x0, 0x0, 0x0, 0x0}}, {{_unused_ttbr1_0 =
=3D
> 0x0, ttbr1_ns =3D 0x0,
>          _unused_ttbr1_1 =3D 0x0, ttbr1_s =3D 0x0}, ttbr1_el =3D {0x0, 0x=
0,
> 0x0, 0x0}}, vttbr_el2 =3D 0x0, tcr_el =3D {{raw_tcr =3D 0x0, mask =3D 0x0=
,
> base_mask =3D 0x0}, {raw_tcr =3D 0x0, mask =3D 0x0, base_mask =3D 0xffffc=
000},
> {raw_tcr =3D 0x0, mask =3D 0x0,
>          base_mask =3D 0x0}, {raw_tcr =3D 0x0, mask =3D 0x0, base_mask =
=3D
> 0xffffc000}}, vtcr_el2 =3D {raw_tcr =3D 0x0, mask =3D 0x0, base_mask =3D =
0x0},
> c2_data =3D 0x0, c2_insn =3D 0x0, {{dacr_ns =3D 0x0, dacr_s =3D 0x0},
> {dacr32_el2 =3D 0x0}},
>      pmsav5_data_ap =3D 0x0, pmsav5_insn_ap =3D 0x0, hcr_el2 =3D 0x0, scr=
_el3
> =3D 0x101, {{ifsr_ns =3D 0x0, ifsr_s =3D 0x0}, {ifsr32_el2 =3D 0x0}},
> {{_unused_dfsr =3D 0x0, dfsr_ns =3D 0x0, hsr =3D 0x0, dfsr_s =3D 0x0}, es=
r_el =3D
> {0x0, 0x0, 0x0, 0x0}},
>      c6_region =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0},
> {{_unused_far0 =3D 0x0, dfar_ns =3D 0x0, ifar_ns =3D 0x0, dfar_s =3D 0x0,=
 ifar_s
> =3D 0x0, _unused_far3 =3D 0x0}, far_el =3D {0x0, 0x0, 0x0, 0x0}}, hpfar_e=
l2 =3D
> 0x0, hstr_el2 =3D 0x0, {{
>          _unused_par_0 =3D 0x0, par_ns =3D 0x0, _unused_par_1 =3D 0x0, pa=
r_s =3D
> 0x0}, par_el =3D {0x0, 0x0, 0x0, 0x0}}, c9_insn =3D 0x0, c9_data =3D 0x0,
> c9_pmcr =3D 0x41002000, c9_pmcnten =3D 0x0, c9_pmovsr =3D 0x0, c9_pmusere=
nr =3D
> 0x0, c9_pmselr =3D 0x0,
>      c9_pminten =3D 0x0, {{_unused_mair_0 =3D 0x0, mair0_ns =3D 0x0, mair=
1_ns
> =3D 0x0, _unused_mair_1 =3D 0x0, mair0_s =3D 0x0, mair1_s =3D 0x0}, mair_=
el =3D
> {0x0, 0x0, 0x0, 0x0}}, {{_unused_vbar =3D 0x0, vbar_ns =3D 0x0, hvbar =3D=
 0x0,
> vbar_s =3D 0x0},
>        vbar_el =3D {0x0, 0x0, 0x0, 0x0}}, mvbar =3D 0x0, {fcseidr_ns =3D =
0x0,
> fcseidr_s =3D 0x0}, {{_unused_contextidr_0 =3D 0x0, contextidr_ns =3D 0x0=
,
> _unused_contextidr_1 =3D 0x0, contextidr_s =3D 0x0}, contextidr_el =3D {0=
x0,
> 0x0, 0x0, 0x0}}, {{
>          tpidrurw_ns =3D 0x0, tpidrprw_ns =3D 0x0, htpidr =3D 0x0, _tpidr=
_el3
> =3D 0x0}, tpidr_el =3D {0x0, 0x0, 0x0, 0x0}}, tpidrurw_s =3D 0x0, tpidrpr=
w_s =3D
> 0x0, tpidruro_s =3D 0x0, {tpidruro_ns =3D 0x0, tpidrro_el =3D {0x0}},
> c14_cntfrq =3D 0x3b9aca0,
>      c14_cntkctl =3D 0x0, cnthctl_el2 =3D 0x3, cntvoff_el2 =3D 0x0, c14_t=
imer
> =3D {{cval =3D 0x0, ctl =3D 0x0}, {cval =3D 0x0, ctl =3D 0x0}, {cval =3D =
0x0, ctl =3D
> 0x0}, {cval =3D 0x0, ctl =3D 0x0}}, c15_cpar =3D 0x0, c15_ticonfig =3D 0x=
0,
> c15_i_max =3D 0x0,
>      c15_i_min =3D 0x0, c15_threadid =3D 0x0, c15_config_base_address =3D=
 0x0,
> c15_diagnostic =3D 0x0, c15_power_diagnostic =3D 0x0, c15_power_control =
=3D
> 0x0, dbgbvr =3D {0x0 <repeats 16 times>}, dbgbcr =3D {0x0 <repeats 16
> times>}, dbgwvr =3D {
>        0x0 <repeats 16 times>}, dbgwcr =3D {0x0 <repeats 16 times>},
> mdscr_el1 =3D 0x0, oslsr_el1 =3D 0xa, mdcr_el2 =3D 0x0, mdcr_el3 =3D 0x0,
> c15_ccnt =3D 0x0, c15_ccnt_delta =3D 0x0, c14_pmevcntr =3D {0x0 <repeats =
31
> times>}, c14_pmevcntr_delta =3D {
>        0x0 <repeats 31 times>}, c14_pmevtyper =3D {0x0 <repeats 31
> times>}, pmccfiltr_el0 =3D 0x0, vpidr_el2 =3D 0x410fc075, vmpidr_el2 =3D
> 0x80000001}, v7m =3D {other_sp =3D 0x0, other_ss_msp =3D 0x0, other_ss_ps=
p =3D
> 0x0, vecbase =3D {0x0, 0x0},
>      basepri =3D {0x0, 0x0}, control =3D {0x0, 0x0}, ccr =3D {0x0, 0x0}, =
cfsr
> =3D {0x0, 0x0}, hfsr =3D 0x0, dfsr =3D 0x0, sfsr =3D 0x0, mmfar =3D {0x0,=
 0x0},
> bfar =3D 0x0, sfar =3D 0x0, mpu_ctrl =3D {0x0, 0x0}, exception =3D 0x0, p=
rimask
> =3D {0x0, 0x0},
>      faultmask =3D {0x0, 0x0}, aircr =3D 0x0, secure =3D 0x0, csselr =3D =
{0x0,
> 0x0}, scr =3D {0x0, 0x0}, msplim =3D {0x0, 0x0}, psplim =3D {0x0, 0x0}, f=
pcar
> =3D {0x0, 0x0}, fpccr =3D {0x0, 0x0}, fpdscr =3D {0x0, 0x0}, cpacr =3D {0=
x0,
> 0x0}, nsacr =3D 0x0},
>    exception =3D {syndrome =3D 0x0, fsr =3D 0x0, vaddress =3D 0x0, target=
_el =3D
> 0x0}, serror =3D {pending =3D 0x0, has_esr =3D 0x0, esr =3D 0x0}, irq_lin=
e_state
> =3D 0x0, teecr =3D 0x0, teehbr =3D 0x0, vfp =3D {zregs =3D {{d =3D {0x0, =
0x0}}
> <repeats 32 times>},
>      qc =3D {0x0, 0x0, 0x0, 0x0}, vec_len =3D 0x0, vec_stride =3D 0x0, xr=
egs =3D
> {0x41023075, 0x0, 0x0, 0x0, 0x0, 0x0, 0x11111111, 0x10110222, 0x0, 0x0,
> 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, scratch =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
> 0x0, 0x0},
>      fp_status =3D {float_detect_tininess =3D 0x1, float_rounding_mode =
=3D
> 0x0, float_exception_flags =3D 0x0, floatx80_rounding_precision =3D 0x0,
> flush_to_zero =3D 0x0, flush_inputs_to_zero =3D 0x0, default_nan_mode =3D=
 0x0,
> snan_bit_is_one =3D 0x0},
>      fp_status_f16 =3D {float_detect_tininess =3D 0x1, float_rounding_mod=
e =3D
> 0x0, float_exception_flags =3D 0x0, floatx80_rounding_precision =3D 0x0,
> flush_to_zero =3D 0x0, flush_inputs_to_zero =3D 0x0, default_nan_mode =3D=
 0x0,
>        snan_bit_is_one =3D 0x0}, standard_fp_status =3D
> {float_detect_tininess =3D 0x1, float_rounding_mode =3D 0x0,
> float_exception_flags =3D 0x0, floatx80_rounding_precision =3D 0x0,
> flush_to_zero =3D 0x1, flush_inputs_to_zero =3D 0x1,
>        default_nan_mode =3D 0x1, snan_bit_is_one =3D 0x0}, zcr_el =3D {0x=
0,
> 0x0, 0x0, 0x0}}, exclusive_addr =3D 0xffffffffffffffff, exclusive_val =3D
> 0x0, exclusive_high =3D 0x0, iwmmxt =3D {regs =3D {0x0 <repeats 16 times>=
},
> val =3D 0x0, cregs =3D {
>        0x0 <repeats 16 times>}}, cpu_breakpoint =3D {0x0 <repeats 16
> times>}, cpu_watchpoint =3D {0x0 <repeats 16 times>}, end_reset_fields =
=3D
> {<No data fields>}, features =3D 0xfd38fbe6f3, pmsav7 =3D {drbar =3D 0x0,=
 drsr
> =3D 0x0, dracr =3D 0x0,
>      rnr =3D {0x0, 0x0}}, pmsav8 =3D {rbar =3D {0x0, 0x0}, rlar =3D {0x0,=
 0x0},
> mair0 =3D {0x0, 0x0}, mair1 =3D {0x0, 0x0}}, sau =3D {rbar =3D 0x0, rlar =
=3D 0x0,
> rnr =3D 0x0, ctrl =3D 0x0}, nvic =3D 0x0, boot_info =3D 0x5622af3a17a0,
> gicv3state =3D 0x0}
>
> > [1] http://www.orangepi.org/downloadresources/
> > [2] https://buildroot.org/download.html
> > [3] https://www.armbian.com/orange-pi-pc/
>
>

--=20
Niek Linnenbank

WWW: http://www.nieklinnenbank.nl/
BLOG: http://nieklinnenbank.wordpress.com/
FUN:    http://www.FreeNOS.org/

--0000000000005c0a4a0598d1aa1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div><div>Thanks for your=
 very quick response!</div><div>I remember I have seen this error before wh=
ile working on the patches, in particular</div><div>on the SMP part. I&#39;=
ll try to reproduce this error with the 4.20 sunxi kernel you used and debu=
g it.</div><div> <br></div><div>Could it be related to the change I made in=
 patch 0006 for the CP10/CP11 bits? <br></div><div>Basically I needed to ad=
d that to get the CPUCFG module working. It is an interface</div><div>that =
U-Boot uses to reset the secondary cores for PSCI functionality. I used</di=
v><div>the arm_set_cpu_on() function there to reset the cores at the desire=
d start address,</div><div>but Im not sure if that function is the right ch=
oice. At some point while rebasing the patches,</div><div>I got undefined e=
xceptions which turned out to be because of the CP10/CP11 bits missing.</di=
v><div>If I made an obvious mistake there, please let me know and I&#39;ll =
correct it.<br></div><div><br></div><div>Regards,</div><div>Niek<br></div><=
div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Dec 3, 2019 at 9:47 AM Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 12/2/19 10:09 =
PM, Niek Linnenbank wrote:<br>
&gt; Dear QEMU developers,<br>
&gt; <br>
&gt; Hereby I would like to contribute the following set of patches to QEMU=
<br>
&gt; which add support for the Allwinner H3 System on Chip and the<br>
&gt; Orange Pi PC machine. The following features and devices are supported=
:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* SMP (Quad Core Cortex A7)<br>
&gt;=C2=A0 =C2=A0* Generic Interrupt Controller configuration<br>
&gt;=C2=A0 =C2=A0* SRAM mappings<br>
&gt;=C2=A0 =C2=A0* Timer device (re-used from Allwinner A10)<br>
&gt;=C2=A0 =C2=A0* UART<br>
&gt;=C2=A0 =C2=A0* SD/MMC storage controller<br>
&gt;=C2=A0 =C2=A0* EMAC ethernet connectivity<br>
&gt;=C2=A0 =C2=A0* USB 2.0 interfaces<br>
&gt;=C2=A0 =C2=A0* Clock Control Unit<br>
&gt;=C2=A0 =C2=A0* System Control module<br>
&gt;=C2=A0 =C2=A0* Security Identifier device<br>
<br>
Awesome!<br>
<br>
&gt; Functionality related to graphical output such as HDMI, GPU,<br>
&gt; Display Engine and audio are not included. Recently released<br>
&gt; mainline Linux kernels (4.19 up to latest master) and mainline U-Boot<=
br>
&gt; are known to work. The SD/MMC code is tested using bonnie++ and<br>
&gt; various tools such as fsck, dd and fdisk. The EMAC is verified with ip=
erf3<br>
&gt; using -netdev socket.<br>
&gt; <br>
&gt; To build a Linux mainline kernel that can be booted by the Orange Pi P=
C<br>
&gt; machine, simply configure the kernel using the sunxi_defconfig configu=
ration:<br>
&gt;=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make mrpro=
per<br>
&gt;=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make sunxi=
_defconfig<br>
&gt; <br>
&gt; To be able to use USB storage, you need to manually enable the corresp=
onding<br>
&gt; configuration item. Start the kconfig configuration tool:<br>
&gt;=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make menuc=
onfig<br>
&gt; <br>
&gt; Navigate to the following item, enable it and save your configuration:=
<br>
&gt;=C2=A0 =C2=A0Device Drivers &gt; USB support &gt; USB Mass Storage supp=
ort<br>
&gt; <br>
&gt; Build the Linux kernel with:<br>
&gt;=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -j5<b=
r>
&gt; <br>
&gt; To boot the newly build linux kernel in QEMU with the Orange Pi PC mac=
hine, use:<br>
&gt;=C2=A0 =C2=A0$ qemu-system-arm -M orangepi -m 512 -nic user -nographic =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel /path/to/linux/arch/arm/boot/zImage =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-append &#39;console=3DttyS0,115200&#39; \<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-dtb /path/to/linux/arch/arm/boot/dts/sun8i-=
h3-orangepi-pc.dtb<br>
&gt; <br>
&gt; Note that this kernel does not have a root filesystem. You may provide=
 it<br>
&gt; with an official Orange Pi PC image [1] either as an SD card or as<br>
&gt; USB mass storage. To boot using the Orange Pi PC Debian image on SD ca=
rd,<br>
&gt; simply add the -sd argument and provide the proper root=3D kernel para=
meter:<br>
&gt;=C2=A0 =C2=A0$ qemu-system-arm -M orangepi -m 512 -nic user -nographic =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel /path/to/linux/arch/arm/boot/zImage =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-append &#39;console=3DttyS0,115200 root=3D/=
dev/mmcblk0p2&#39; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-dtb /path/to/linux/arch/arm/boot/dts/sun8i-=
h3-orangepi-pc.dtb \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-sd OrangePi_pc_debian_stretch_server_linux5=
.3.5_v1.0.img<br>
&gt; <br>
&gt; Alternatively, you can also choose to build and boot a recent buildroo=
t [2]<br>
&gt; using the orangepi_pc_defconfig or Armbian image [3] for Orange Pi PC.=
<br>
<br>
Richard, trying the Armbian image from <br>
<a href=3D"https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/" rel=3D"=
noreferrer" target=3D"_blank">https://apt.armbian.com/pool/main/l/linux-4.2=
0.7-sunxi/</a> I get:<br>
<br>
$ arm-softmmu/qemu-system-arm -M orangepi -m 512 -nic user \<br>
=C2=A0 =C2=A0-append &#39;console=3DttyS0,115200&#39; \<br>
=C2=A0 =C2=A0-kernel boot/vmlinuz-4.20.7-sunxi \<br>
=C2=A0 =C2=A0-dtb usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb \<=
br>
=C2=A0 =C2=A0-serial stdio -d unimp<br>
Uncompressing Linux... done, booting the kernel.<br>
rtc: unimplemented device write (size 4, value 0x16aa0001, offset 0x0)<br>
rtc: unimplemented device read (size 4, offset 0x0)<br>
rtc: unimplemented device read (size 4, offset 0x0)<br>
rtc: unimplemented device read (size 4, offset 0x8)<br>
qemu-system-arm: target/arm/helper.c:11359: cpu_get_tb_cpu_state: <br>
Assertion `flags =3D=3D rebuild_hflags_internal(env)&#39; failed.<br>
Aborted (core dumped)<br>
<br>
(gdb) bt<br>
#0=C2=A0 0x00007f6c1fa2ce35 in raise () at /lib64/libc.so.6<br>
#1=C2=A0 0x00007f6c1fa17895 in abort () at /lib64/libc.so.6<br>
#2=C2=A0 0x00007f6c1fa17769 in _nl_load_domain.cold () at /lib64/libc.so.6<=
br>
#3=C2=A0 0x00007f6c1fa25566 in annobin_assert.c_end () at /lib64/libc.so.6<=
br>
#4=C2=A0 0x00005590657e2685 in cpu_get_tb_cpu_state (env=3D0x5590686899b0, =
<br>
pc=3D0x7f6c07ffa718, cs_base=3D0x7f6c07ffa714, pflags=3D0x7f6c07ffa71c) at =
<br>
target/arm/helper.c:11359<br>
#5=C2=A0 0x000055906569f962 in tb_lookup__cpu_state (cpu=3D0x5590686808b0, =
<br>
pc=3D0x7f6c07ffa718, cs_base=3D0x7f6c07ffa714, flags=3D0x7f6c07ffa71c, <br>
cf_mask=3D524288) at include/exec/tb-lookup.h:28<br>
#6=C2=A0 0x00005590656a084c in tb_find (cpu=3D0x5590686808b0, last_tb=3D0x0=
, <br>
tb_exit=3D0, cf_mask=3D524288) at accel/tcg/cpu-exec.c:403<br>
#7=C2=A0 0x00005590656a114a in cpu_exec (cpu=3D0x5590686808b0) at <br>
accel/tcg/cpu-exec.c:730<br>
#8=C2=A0 0x000055906565f6af in tcg_cpu_exec (cpu=3D0x5590686808b0) at cpus.=
c:1473<br>
#9=C2=A0 0x000055906565ff05 in qemu_tcg_cpu_thread_fn (arg=3D0x5590686808b0=
) at <br>
cpus.c:1781<br>
#10 0x0000559065d54aa6 in qemu_thread_start (args=3D0x5590687d8c20) at <br>
util/qemu-thread-posix.c:519<br>
#11 0x00007f6c1fbc54c0 in start_thread () at /lib64/libpthread.so.0<br>
#12 0x00007f6c1faf1553 in clone () at /lib64/libc.so.6<br>
<br>
(gdb) p/x flags<br>
$1 =3D 0x33600000<br>
<br>
(gdb) p/x *env<br>
$2 =3D {regs =3D {0x0 &lt;repeats 15 times&gt;, 0x40102448}, xregs =3D {0x0=
 &lt;repeats <br>
32 times&gt;}, pc =3D 0x0, pstate =3D 0x0, aarch64 =3D 0x0, hflags =3D 0x33=
600000, <br>
uncached_cpsr =3D 0x1a, spsr =3D 0x0, banked_spsr =3D {0x0, 0x0, 0x0, 0x0, =
<br>
0x0, 0x0, 0x0, 0x0},<br>
=C2=A0 =C2=A0banked_r13 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, banke=
d_r14 =3D <br>
{0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, usr_regs =3D {0x0, 0x0, 0x0, <br>
0x0, 0x0}, fiq_regs =3D {0x0, 0x0, 0x0, 0x0, 0x0}, CF =3D 0x0, VF =3D 0x0, =
NF <br>
=3D 0x0, ZF =3D 0x0,<br>
=C2=A0 =C2=A0QF =3D 0x0, GE =3D 0x0, thumb =3D 0x1, condexec_bits =3D 0x0, =
btype =3D 0x0, <br>
daif =3D 0x3c0, elr_el =3D {0x0, 0x0, 0x0, 0x0}, sp_el =3D {0x0, 0x0, 0x0, =
<br>
0x0}, cp15 =3D {c0_cpuid =3D 0x410fc075, {{_unused_csselr0 =3D 0x0, csselr_=
ns <br>
=3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_unused_csselr1 =3D 0x0, csselr_s =3D 0x0=
}, csselr_el =3D {0x0, 0x0, <br>
0x0, 0x0}}, {{_unused_sctlr =3D 0x0, sctlr_ns =3D 0xc50078, hsctlr =3D 0x0,=
 <br>
sctlr_s =3D 0xc50078}, sctlr_el =3D {0x0, 0xc50078, 0x0, 0xc50078}}, <br>
cpacr_el1 =3D 0x0, cptr_el =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0, 0x0, 0x0, 0x0}, c1_xscaleauxcr =3D 0x0, sde=
r =3D 0x0, nsacr =3D <br>
0xc00, {{_unused_ttbr0_0 =3D 0x0, ttbr0_ns =3D 0x0, _unused_ttbr0_1 =3D 0x0=
, <br>
ttbr0_s =3D 0x0}, ttbr0_el =3D {0x0, 0x0, 0x0, 0x0}}, {{_unused_ttbr1_0 =3D=
 <br>
0x0, ttbr1_ns =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_unused_ttbr1_1 =3D 0x0, ttbr1_s =3D 0x0}=
, ttbr1_el =3D {0x0, 0x0, <br>
0x0, 0x0}}, vttbr_el2 =3D 0x0, tcr_el =3D {{raw_tcr =3D 0x0, mask =3D 0x0, =
<br>
base_mask =3D 0x0}, {raw_tcr =3D 0x0, mask =3D 0x0, base_mask =3D 0xffffc00=
0}, <br>
{raw_tcr =3D 0x0, mask =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0base_mask =3D 0x0}, {raw_tcr =3D 0x0, mas=
k =3D 0x0, base_mask =3D <br>
0xffffc000}}, vtcr_el2 =3D {raw_tcr =3D 0x0, mask =3D 0x0, base_mask =3D 0x=
0}, <br>
c2_data =3D 0x0, c2_insn =3D 0x0, {{dacr_ns =3D 0x0, dacr_s =3D 0x0}, <br>
{dacr32_el2 =3D 0x0}},<br>
=C2=A0 =C2=A0 =C2=A0pmsav5_data_ap =3D 0x0, pmsav5_insn_ap =3D 0x0, hcr_el2=
 =3D 0x0, scr_el3 <br>
=3D 0x101, {{ifsr_ns =3D 0x0, ifsr_s =3D 0x0}, {ifsr32_el2 =3D 0x0}}, <br>
{{_unused_dfsr =3D 0x0, dfsr_ns =3D 0x0, hsr =3D 0x0, dfsr_s =3D 0x0}, esr_=
el =3D <br>
{0x0, 0x0, 0x0, 0x0}},<br>
=C2=A0 =C2=A0 =C2=A0c6_region =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0},=
 <br>
{{_unused_far0 =3D 0x0, dfar_ns =3D 0x0, ifar_ns =3D 0x0, dfar_s =3D 0x0, i=
far_s <br>
=3D 0x0, _unused_far3 =3D 0x0}, far_el =3D {0x0, 0x0, 0x0, 0x0}}, hpfar_el2=
 =3D <br>
0x0, hstr_el2 =3D 0x0, {{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_unused_par_0 =3D 0x0, par_ns =3D 0x0, _u=
nused_par_1 =3D 0x0, par_s =3D <br>
0x0}, par_el =3D {0x0, 0x0, 0x0, 0x0}}, c9_insn =3D 0x0, c9_data =3D 0x0, <=
br>
c9_pmcr =3D 0x41002000, c9_pmcnten =3D 0x0, c9_pmovsr =3D 0x0, c9_pmuserenr=
 =3D <br>
0x0, c9_pmselr =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0c9_pminten =3D 0x0, {{_unused_mair_0 =3D 0x0, mair0_ns =
=3D 0x0, mair1_ns <br>
=3D 0x0, _unused_mair_1 =3D 0x0, mair0_s =3D 0x0, mair1_s =3D 0x0}, mair_el=
 =3D <br>
{0x0, 0x0, 0x0, 0x0}}, {{_unused_vbar =3D 0x0, vbar_ns =3D 0x0, hvbar =3D 0=
x0, <br>
vbar_s =3D 0x0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0vbar_el =3D {0x0, 0x0, 0x0, 0x0}}, mvbar =3D 0x0=
, {fcseidr_ns =3D 0x0, <br>
fcseidr_s =3D 0x0}, {{_unused_contextidr_0 =3D 0x0, contextidr_ns =3D 0x0, =
<br>
_unused_contextidr_1 =3D 0x0, contextidr_s =3D 0x0}, contextidr_el =3D {0x0=
, <br>
0x0, 0x0, 0x0}}, {{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tpidrurw_ns =3D 0x0, tpidrprw_ns =3D 0x0,=
 htpidr =3D 0x0, _tpidr_el3 <br>
=3D 0x0}, tpidr_el =3D {0x0, 0x0, 0x0, 0x0}}, tpidrurw_s =3D 0x0, tpidrprw_=
s =3D <br>
0x0, tpidruro_s =3D 0x0, {tpidruro_ns =3D 0x0, tpidrro_el =3D {0x0}}, <br>
c14_cntfrq =3D 0x3b9aca0,<br>
=C2=A0 =C2=A0 =C2=A0c14_cntkctl =3D 0x0, cnthctl_el2 =3D 0x3, cntvoff_el2 =
=3D 0x0, c14_timer <br>
=3D {{cval =3D 0x0, ctl =3D 0x0}, {cval =3D 0x0, ctl =3D 0x0}, {cval =3D 0x=
0, ctl =3D <br>
0x0}, {cval =3D 0x0, ctl =3D 0x0}}, c15_cpar =3D 0x0, c15_ticonfig =3D 0x0,=
 <br>
c15_i_max =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0c15_i_min =3D 0x0, c15_threadid =3D 0x0, c15_config_bas=
e_address =3D 0x0, <br>
c15_diagnostic =3D 0x0, c15_power_diagnostic =3D 0x0, c15_power_control =3D=
 <br>
0x0, dbgbvr =3D {0x0 &lt;repeats 16 times&gt;}, dbgbcr =3D {0x0 &lt;repeats=
 16 <br>
times&gt;}, dbgwvr =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0 &lt;repeats 16 times&gt;}, dbgwcr =3D {0x0 &=
lt;repeats 16 times&gt;}, <br>
mdscr_el1 =3D 0x0, oslsr_el1 =3D 0xa, mdcr_el2 =3D 0x0, mdcr_el3 =3D 0x0, <=
br>
c15_ccnt =3D 0x0, c15_ccnt_delta =3D 0x0, c14_pmevcntr =3D {0x0 &lt;repeats=
 31 <br>
times&gt;}, c14_pmevcntr_delta =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0 &lt;repeats 31 times&gt;}, c14_pmevtyper =3D=
 {0x0 &lt;repeats 31 <br>
times&gt;}, pmccfiltr_el0 =3D 0x0, vpidr_el2 =3D 0x410fc075, vmpidr_el2 =3D=
 <br>
0x80000001}, v7m =3D {other_sp =3D 0x0, other_ss_msp =3D 0x0, other_ss_psp =
=3D <br>
0x0, vecbase =3D {0x0, 0x0},<br>
=C2=A0 =C2=A0 =C2=A0basepri =3D {0x0, 0x0}, control =3D {0x0, 0x0}, ccr =3D=
 {0x0, 0x0}, cfsr <br>
=3D {0x0, 0x0}, hfsr =3D 0x0, dfsr =3D 0x0, sfsr =3D 0x0, mmfar =3D {0x0, 0=
x0}, <br>
bfar =3D 0x0, sfar =3D 0x0, mpu_ctrl =3D {0x0, 0x0}, exception =3D 0x0, pri=
mask <br>
=3D {0x0, 0x0},<br>
=C2=A0 =C2=A0 =C2=A0faultmask =3D {0x0, 0x0}, aircr =3D 0x0, secure =3D 0x0=
, csselr =3D {0x0, <br>
0x0}, scr =3D {0x0, 0x0}, msplim =3D {0x0, 0x0}, psplim =3D {0x0, 0x0}, fpc=
ar <br>
=3D {0x0, 0x0}, fpccr =3D {0x0, 0x0}, fpdscr =3D {0x0, 0x0}, cpacr =3D {0x0=
, <br>
0x0}, nsacr =3D 0x0},<br>
=C2=A0 =C2=A0exception =3D {syndrome =3D 0x0, fsr =3D 0x0, vaddress =3D 0x0=
, target_el =3D <br>
0x0}, serror =3D {pending =3D 0x0, has_esr =3D 0x0, esr =3D 0x0}, irq_line_=
state <br>
=3D 0x0, teecr =3D 0x0, teehbr =3D 0x0, vfp =3D {zregs =3D {{d =3D {0x0, 0x=
0}} <br>
&lt;repeats 32 times&gt;},<br>
=C2=A0 =C2=A0 =C2=A0qc =3D {0x0, 0x0, 0x0, 0x0}, vec_len =3D 0x0, vec_strid=
e =3D 0x0, xregs =3D <br>
{0x41023075, 0x0, 0x0, 0x0, 0x0, 0x0, 0x11111111, 0x10110222, 0x0, 0x0, <br=
>
0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, scratch =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, <=
br>
0x0, 0x0},<br>
=C2=A0 =C2=A0 =C2=A0fp_status =3D {float_detect_tininess =3D 0x1, float_rou=
nding_mode =3D <br>
0x0, float_exception_flags =3D 0x0, floatx80_rounding_precision =3D 0x0, <b=
r>
flush_to_zero =3D 0x0, flush_inputs_to_zero =3D 0x0, default_nan_mode =3D 0=
x0, <br>
snan_bit_is_one =3D 0x0},<br>
=C2=A0 =C2=A0 =C2=A0fp_status_f16 =3D {float_detect_tininess =3D 0x1, float=
_rounding_mode =3D <br>
0x0, float_exception_flags =3D 0x0, floatx80_rounding_precision =3D 0x0, <b=
r>
flush_to_zero =3D 0x0, flush_inputs_to_zero =3D 0x0, default_nan_mode =3D 0=
x0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0snan_bit_is_one =3D 0x0}, standard_fp_status =3D=
 <br>
{float_detect_tininess =3D 0x1, float_rounding_mode =3D 0x0, <br>
float_exception_flags =3D 0x0, floatx80_rounding_precision =3D 0x0, <br>
flush_to_zero =3D 0x1, flush_inputs_to_zero =3D 0x1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0default_nan_mode =3D 0x1, snan_bit_is_one =3D 0x=
0}, zcr_el =3D {0x0, <br>
0x0, 0x0, 0x0}}, exclusive_addr =3D 0xffffffffffffffff, exclusive_val =3D <=
br>
0x0, exclusive_high =3D 0x0, iwmmxt =3D {regs =3D {0x0 &lt;repeats 16 times=
&gt;}, <br>
val =3D 0x0, cregs =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0 &lt;repeats 16 times&gt;}}, cpu_breakpoint =
=3D {0x0 &lt;repeats 16 <br>
times&gt;}, cpu_watchpoint =3D {0x0 &lt;repeats 16 times&gt;}, end_reset_fi=
elds =3D <br>
{&lt;No data fields&gt;}, features =3D 0xfd38fbe6f3, pmsav7 =3D {drbar =3D =
0x0, drsr <br>
=3D 0x0, dracr =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0rnr =3D {0x0, 0x0}}, pmsav8 =3D {rbar =3D {0x0, 0x0}, r=
lar =3D {0x0, 0x0}, <br>
mair0 =3D {0x0, 0x0}, mair1 =3D {0x0, 0x0}}, sau =3D {rbar =3D 0x0, rlar =
=3D 0x0, <br>
rnr =3D 0x0, ctrl =3D 0x0}, nvic =3D 0x0, boot_info =3D 0x5622af3a17a0, <br=
>
gicv3state =3D 0x0}<br>
<br>
&gt; [1] <a href=3D"http://www.orangepi.org/downloadresources/" rel=3D"nore=
ferrer" target=3D"_blank">http://www.orangepi.org/downloadresources/</a><br=
>
&gt; [2] <a href=3D"https://buildroot.org/download.html" rel=3D"noreferrer"=
 target=3D"_blank">https://buildroot.org/download.html</a><br>
&gt; [3] <a href=3D"https://www.armbian.com/orange-pi-pc/" rel=3D"noreferre=
r" target=3D"_blank">https://www.armbian.com/orange-pi-pc/</a><br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Niek Linnenbank<br><br>WWW: <a href=3D"http://www.nieklinne=
nbank.nl/" target=3D"_blank">http://www.nieklinnenbank.nl/</a><br>BLOG: <a =
href=3D"http://nieklinnenbank.wordpress.com/" target=3D"_blank">http://niek=
linnenbank.wordpress.com/</a><br>FUN:=C2=A0 =C2=A0 <a href=3D"http://www.Fr=
eeNOS.org/" target=3D"_blank">http://www.FreeNOS.org/</a><br></div>

--0000000000005c0a4a0598d1aa1b--

