Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC180C2D0BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 08:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648E7206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 08:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FC51Q1e6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648E7206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieb5H-0001Q6-22
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 03:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieb48-0000nF-1m
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:40:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieb44-0001A8-Bb
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:40:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28148
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieb44-000188-3s
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 03:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575967214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DWledyxBV/qImrky/T20NlodGrtuGj8D6uYMVyVqKA=;
 b=FC51Q1e6fv510xE1Sa4FUgtrLT8eVbVQs7hGClEQKRd/XQtXuqUTz0uApl5kguPicKuoF1
 2YtwBv3uy6DRkRbHvy4eV0JhuohGgnbsbS1cH7ENHo99jmTCXPJl33o5RJmKhW/Z5HANJN
 1Lt/SicLSNsNY8KTpvDUakjvPaDGsA4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-fe8Y6u9uNu-FJ2A9wjXXtg-1; Tue, 10 Dec 2019 03:40:12 -0500
Received: by mail-wm1-f69.google.com with SMTP id n4so359198wmd.7
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 00:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4t2oLp4D14b/pveCt5vAfuXzoJK+QIjXU9ZnOhFaUaY=;
 b=lMGFi/8hVxbjceSKXLBLPmM3ZhaqLPDuhDnIVYYxWellqoAxqLXg8qcjCJGgyPQDFg
 /YERYRiGoJgplc+YltA07cmkYQOXaBVO1OqnXOJqwU+1HMDAxhSzaOSrrLA7HHBgEra4
 LlIm1OuBj/Yl5RIjEGLCaB1rsc5hxpGbnXZV5i9lvvpgUuLPUXlGCxDV7Ssowy/tm2Rn
 udK4ezl41YTHtZZ9GrRvJTKGXYP3DSChKCyan1YdokUs4PDRkRoQVF2M+t61ejwn+e3p
 WD8fGLARLO/s9nJwcrmmyljDsvsroyJuK3R2V22+gYEzTPnH6HY9v/fvN/XpUgfahSRv
 Pvhg==
X-Gm-Message-State: APjAAAUGHiiT5Y46oSoWd5zCfRb3qF/2zqfzMfpyQokqgFoYElHRo5NP
 nXm33bWXKHaPM7KFgvctKeE4YLEK2nqF5sNMGd088XnzOLfP2ghpE0H2w5AD0siEgZ6+w9dNYf6
 bGMq+ZIyVuqOFcqY=
X-Received: by 2002:a5d:68c5:: with SMTP id p5mr1800505wrw.193.1575967210867; 
 Tue, 10 Dec 2019 00:40:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHYQd5RAzVEcX1JkeAmeWk59OFwjeyu3lHW1U9yS4bucltjHa4ljSdBWQseHNi8gxD+EHLpA==
X-Received: by 2002:a5d:68c5:: with SMTP id p5mr1800448wrw.193.1575967210416; 
 Tue, 10 Dec 2019 00:40:10 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id f9sm2203201wmb.4.2019.12.10.00.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 00:40:09 -0800 (PST)
Subject: Re: [PATCH 00/10] Add Allwinner H3 SoC and Orange Pi PC Machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <f54375da-4383-04c5-d57c-3a2f6ff46189@redhat.com>
 <CAPan3Wri8iHkn7oaoUpjqgB3TZBb5foCQWGDcBnUu29PuiTVTA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <14e0a506-19c0-ab9d-70b3-700995b2bfa7@redhat.com>
Date: Tue, 10 Dec 2019 09:40:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3Wri8iHkn7oaoUpjqgB3TZBb5foCQWGDcBnUu29PuiTVTA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: fe8Y6u9uNu-FJ2A9wjXXtg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Cc'ing Alex.

On 12/3/19 8:25 PM, Niek Linnenbank wrote:
> Hi Philippe,
>=20
> Thanks for your very quick response!
> I remember I have seen this error before while working on the patches,=20
> in particular
> on the SMP part. I'll try to reproduce this error with the 4.20 sunxi=20
> kernel you used and debug it.
>=20
> Could it be related to the change I made in patch 0006 for the CP10/CP11=
=20
> bits?
> Basically I needed to add that to get the CPUCFG module working. It is=20
> an interface
> that U-Boot uses to reset the secondary cores for PSCI functionality. I u=
sed
> the arm_set_cpu_on() function there to reset the cores at the desired=20
> start address,
> but Im not sure if that function is the right choice. At some point=20
> while rebasing the patches,
> I got undefined exceptions which turned out to be because of the=20
> CP10/CP11 bits missing.
> If I made an obvious mistake there, please let me know and I'll correct i=
t.
>=20
> Regards,
> Niek
>=20
>=20
> On Tue, Dec 3, 2019 at 9:47 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     On 12/2/19 10:09 PM, Niek Linnenbank wrote:
>      > Dear QEMU developers,
>      >
>      > Hereby I would like to contribute the following set of patches to
>     QEMU
>      > which add support for the Allwinner H3 System on Chip and the
>      > Orange Pi PC machine. The following features and devices are
>     supported:
>      >
>      >=C2=A0 =C2=A0* SMP (Quad Core Cortex A7)
>      >=C2=A0 =C2=A0* Generic Interrupt Controller configuration
>      >=C2=A0 =C2=A0* SRAM mappings
>      >=C2=A0 =C2=A0* Timer device (re-used from Allwinner A10)
>      >=C2=A0 =C2=A0* UART
>      >=C2=A0 =C2=A0* SD/MMC storage controller
>      >=C2=A0 =C2=A0* EMAC ethernet connectivity
>      >=C2=A0 =C2=A0* USB 2.0 interfaces
>      >=C2=A0 =C2=A0* Clock Control Unit
>      >=C2=A0 =C2=A0* System Control module
>      >=C2=A0 =C2=A0* Security Identifier device
>=20
>     Awesome!
>=20
>      > Functionality related to graphical output such as HDMI, GPU,
>      > Display Engine and audio are not included. Recently released
>      > mainline Linux kernels (4.19 up to latest master) and mainline U-B=
oot
>      > are known to work. The SD/MMC code is tested using bonnie++ and
>      > various tools such as fsck, dd and fdisk. The EMAC is verified
>     with iperf3
>      > using -netdev socket.
>      >
>      > To build a Linux mainline kernel that can be booted by the Orange
>     Pi PC
>      > machine, simply configure the kernel using the sunxi_defconfig
>     configuration:
>      >=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make m=
rproper
>      >=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make s=
unxi_defconfig
>      >
>      > To be able to use USB storage, you need to manually enable the
>     corresponding
>      > configuration item. Start the kconfig configuration tool:
>      >=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make m=
enuconfig
>      >
>      > Navigate to the following item, enable it and save your
>     configuration:
>      >=C2=A0 =C2=A0Device Drivers > USB support > USB Mass Storage suppor=
t
>      >
>      > Build the Linux kernel with:
>      >=C2=A0 =C2=A0$ ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabi- make -=
j5
>      >
>      > To boot the newly build linux kernel in QEMU with the Orange Pi
>     PC machine, use:
>      >=C2=A0 =C2=A0$ qemu-system-arm -M orangepi -m 512 -nic user -nograp=
hic \
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel /path/to/linux/arch/arm/boot/zIm=
age \
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0-append 'console=3DttyS0,115200' \
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0-dtb /path/to/linux/arch/arm/boot/dts/su=
n8i-h3-orangepi-pc.dtb
>      >
>      > Note that this kernel does not have a root filesystem. You may
>     provide it
>      > with an official Orange Pi PC image [1] either as an SD card or as
>      > USB mass storage. To boot using the Orange Pi PC Debian image on
>     SD card,
>      > simply add the -sd argument and provide the proper root=3D kernel
>     parameter:
>      >=C2=A0 =C2=A0$ qemu-system-arm -M orangepi -m 512 -nic user -nograp=
hic \
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0-kernel /path/to/linux/arch/arm/boot/zIm=
age \
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0-append 'console=3DttyS0,115200 root=3D/=
dev/mmcblk0p2' \
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0-dtb
>     /path/to/linux/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dtb \
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0-sd OrangePi_pc_debian_stretch_server_li=
nux5.3.5_v1.0.img
>      >
>      > Alternatively, you can also choose to build and boot a recent
>     buildroot [2]
>      > using the orangepi_pc_defconfig or Armbian image [3] for Orange
>     Pi PC.
>=20
>     Richard, trying the Armbian image from
>     https://apt.armbian.com/pool/main/l/linux-4.20.7-sunxi/ I get:
>=20
>     $ arm-softmmu/qemu-system-arm -M orangepi -m 512 -nic user \
>      =C2=A0 =C2=A0-append 'console=3DttyS0,115200' \
>      =C2=A0 =C2=A0-kernel boot/vmlinuz-4.20.7-sunxi \
>      =C2=A0 =C2=A0-dtb usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc=
.dtb \
>      =C2=A0 =C2=A0-serial stdio -d unimp
>     Uncompressing Linux... done, booting the kernel.
>     rtc: unimplemented device write (size 4, value 0x16aa0001, offset 0x0=
)
>     rtc: unimplemented device read (size 4, offset 0x0)
>     rtc: unimplemented device read (size 4, offset 0x0)
>     rtc: unimplemented device read (size 4, offset 0x8)
>     qemu-system-arm: target/arm/helper.c:11359: cpu_get_tb_cpu_state:
>     Assertion `flags =3D=3D rebuild_hflags_internal(env)' failed.
>     Aborted (core dumped)

To have ELF debug info I built a Linux kernel around v5.5-rc1 (commit=20
2f13437b8) with:

$ make ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnu- sunxi_defconfig zImage

Then I applied Alex patch and mine on top of your series:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg663850.html
https://www.mail-archive.com/qemu-devel@nongnu.org/msg663843.html

Running with -d in_asm,cpu:

----------------
IN:
0xc0102128:  e281c018  add      ip, r1, #0x18
0xc010212c:  e8ac6ff0  stm      ip!, {r4, r5, r6, r7, r8, sb, sl, fp,=20
sp, lr}
0xc0102130:  e592405c  ldr      r4, [r2, #0x5c]
0xc0102134:  e5925060  ldr      r5, [r2, #0x60]
0xc0102138:  ee1d7f50  mrc      p15, #0, r7, c13, c0, #2
0xc010213c:  ee0d4f70  mcr      p15, #0, r4, c13, c0, #3

R00=3Dc0a07c40 R01=3Dc0a00000 R02=3Dc685a000 R03=3D00000000
R04=3Dc6ea7cc0 R05=3Dc0a07c40 R06=3Dc68405c0 R07=3Dc0958cc0
R08=3D00000000 R09=3D0654f000 R10=3Dc0701e8c R11=3Dc0a01f94
R12=3D00000000 R13=3Dc0a01f50 R14=3Dc06df2fc R15=3Dc0102128
PSR=3D600000d3 -ZC- A NS svc32
----------------
IN:
0xc0102140:  ee0d5f50  mcr      p15, #0, r5, c13, c0, #2

R00=3Dc0a07c40 R01=3Dc0a00000 R02=3Dc685a000 R03=3D00000000
R04=3D00000000 R05=3D00000000 R06=3Dc68405c0 R07=3D00000000
R08=3D00000000 R09=3D0654f000 R10=3Dc0701e8c R11=3Dc0a01f94
R12=3Dc0a00040 R13=3Dc0a01f50 R14=3Dc06df2fc R15=3Dc0102140
PSR=3D600000d3 -ZC- A NS svc32
----------------
TCG hflags mismatch (current:0x33600000 rebuilt:0x20200040)
Aborted (core dumped)

(gdb) disas __switch_to
Dump of assembler code for function __switch_to:
    0xc0102128 <+0>:     add     r12, r1, #24
    0xc010212c <+4>:     stmia   r12!, {r4, r5, r6, r7, r8, r9, r10,=20
r11, sp, lr}
    0xc0102130 <+8>:     ldr     r4, [r2, #92]   ; 0x5c
    0xc0102134 <+12>:    ldr     r5, [r2, #96]   ; 0x60
    0xc0102138 <+16>:    mrc     15, 0, r7, cr13, cr0, {2}
    0xc010213c <+20>:    mcr     15, 0, r4, cr13, cr0, {3}
    0xc0102140 <+24>:    mcr     15, 0, r5, cr13, cr0, {2}
    0xc0102144 <+28>:    str     r7, [r1, #96]   ; 0x60
    0xc0102148 <+32>:    mov     r5, r0
    0xc010214c <+36>:    add     r4, r2, #24
    0xc0102150 <+40>:    ldr     r0, [pc, #12]   ; 0xc0102164
    0xc0102154 <+44>:    mov     r1, #2
    0xc0102158 <+48>:    bl      0xc013e348 <atomic_notifier_call_chain>
    0xc010215c <+52>:    mov     r0, r5
    0xc0102160 <+56>:    ldm     r4, {r4, r5, r6, r7, r8, r9, r10, r11,=20
sp, pc}
(gdb) x/10i 0xc06df2f0 - 12
    0xc06df2e4 <__schedule+532>: mov     r0, r5
    0xc06df2e8 <__schedule+536>: bic     r3, r3, #3
    0xc06df2ec <__schedule+540>: str     r3, [r4, #1376] ; 0x560
    0xc06df2f0 <__schedule+544>: ldr     r2, [r6, #4]
    0xc06df2f4 <__schedule+548>: ldr     r1, [r5, #4]
    0xc06df2f8 <__schedule+552>: bl      0xc0102128 <__switch_to>
    0xc06df2fc <__schedule+556>: bl      0xc0141f00 <finish_task_switch>
    0xc06df300 <__schedule+560>: mov     r4, r0
    0xc06df304 <__schedule+564>: ldr     r3, [r4, #1452] ; 0x5ac
    0xc06df308 <__schedule+568>: cmp     r3, #0

Note from patch #1:

CPU is cortex-a7 with:

     object_property_set_bool(cpuobj,
                              true, "has_el3", NULL);
     object_property_set_bool(cpuobj,
                              true, "has_el2", NULL);

>=20
>     (gdb) bt
>     #0=C2=A0 0x00007f6c1fa2ce35 in raise () at /lib64/libc.so.6
>     #1=C2=A0 0x00007f6c1fa17895 in abort () at /lib64/libc.so.6
>     #2=C2=A0 0x00007f6c1fa17769 in _nl_load_domain.cold () at /lib64/libc=
.so.6
>     #3=C2=A0 0x00007f6c1fa25566 in annobin_assert.c_end () at /lib64/libc=
.so.6
>     #4=C2=A0 0x00005590657e2685 in cpu_get_tb_cpu_state (env=3D0x55906868=
99b0,
>     pc=3D0x7f6c07ffa718, cs_base=3D0x7f6c07ffa714, pflags=3D0x7f6c07ffa71=
c) at
>     target/arm/helper.c:11359
>     #5=C2=A0 0x000055906569f962 in tb_lookup__cpu_state (cpu=3D0x55906868=
08b0,
>     pc=3D0x7f6c07ffa718, cs_base=3D0x7f6c07ffa714, flags=3D0x7f6c07ffa71c=
,
>     cf_mask=3D524288) at include/exec/tb-lookup.h:28
>     #6=C2=A0 0x00005590656a084c in tb_find (cpu=3D0x5590686808b0, last_tb=
=3D0x0,
>     tb_exit=3D0, cf_mask=3D524288) at accel/tcg/cpu-exec.c:403
>     #7=C2=A0 0x00005590656a114a in cpu_exec (cpu=3D0x5590686808b0) at
>     accel/tcg/cpu-exec.c:730
>     #8=C2=A0 0x000055906565f6af in tcg_cpu_exec (cpu=3D0x5590686808b0) at
>     cpus.c:1473
>     #9=C2=A0 0x000055906565ff05 in qemu_tcg_cpu_thread_fn
>     (arg=3D0x5590686808b0) at
>     cpus.c:1781
>     #10 0x0000559065d54aa6 in qemu_thread_start (args=3D0x5590687d8c20) a=
t
>     util/qemu-thread-posix.c:519
>     #11 0x00007f6c1fbc54c0 in start_thread () at /lib64/libpthread.so.0
>     #12 0x00007f6c1faf1553 in clone () at /lib64/libc.so.6
>=20
>     (gdb) p/x flags
>     $1 =3D 0x33600000
>=20
>     (gdb) p/x *env
>     $2 =3D {regs =3D {0x0 <repeats 15 times>, 0x40102448}, xregs =3D {0x0
>     <repeats
>     32 times>}, pc =3D 0x0, pstate =3D 0x0, aarch64 =3D 0x0, hflags =3D 0=
x33600000,
>     uncached_cpsr =3D 0x1a, spsr =3D 0x0, banked_spsr =3D {0x0, 0x0, 0x0,=
 0x0,
>     0x0, 0x0, 0x0, 0x0},
>      =C2=A0 =C2=A0banked_r13 =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}=
, banked_r14 =3D
>     {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, usr_regs =3D {0x0, 0x0, 0x0=
,
>     0x0, 0x0}, fiq_regs =3D {0x0, 0x0, 0x0, 0x0, 0x0}, CF =3D 0x0, VF =3D=
 0x0, NF
>     =3D 0x0, ZF =3D 0x0,
>      =C2=A0 =C2=A0QF =3D 0x0, GE =3D 0x0, thumb =3D 0x1, condexec_bits =
=3D 0x0, btype =3D 0x0,
>     daif =3D 0x3c0, elr_el =3D {0x0, 0x0, 0x0, 0x0}, sp_el =3D {0x0, 0x0,=
 0x0,
>     0x0}, cp15 =3D {c0_cpuid =3D 0x410fc075, {{_unused_csselr0 =3D 0x0, c=
sselr_ns
>     =3D 0x0,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_unused_csselr1 =3D 0x0, csselr_s =
=3D 0x0}, csselr_el =3D {0x0,
>     0x0,
>     0x0, 0x0}}, {{_unused_sctlr =3D 0x0, sctlr_ns =3D 0xc50078, hsctlr =
=3D 0x0,
>     sctlr_s =3D 0xc50078}, sctlr_el =3D {0x0, 0xc50078, 0x0, 0xc50078}},
>     cpacr_el1 =3D 0x0, cptr_el =3D {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A00x0, 0x0, 0x0, 0x0}, c1_xscaleauxcr =3D 0=
x0, sder =3D 0x0, nsacr =3D
>     0xc00, {{_unused_ttbr0_0 =3D 0x0, ttbr0_ns =3D 0x0, _unused_ttbr0_1 =
=3D 0x0,
>     ttbr0_s =3D 0x0}, ttbr0_el =3D {0x0, 0x0, 0x0, 0x0}}, {{_unused_ttbr1=
_0 =3D
>     0x0, ttbr1_ns =3D 0x0,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_unused_ttbr1_1 =3D 0x0, ttbr1_s =
=3D 0x0}, ttbr1_el =3D {0x0, 0x0,
>     0x0, 0x0}}, vttbr_el2 =3D 0x0, tcr_el =3D {{raw_tcr =3D 0x0, mask =3D=
 0x0,
>     base_mask =3D 0x0}, {raw_tcr =3D 0x0, mask =3D 0x0, base_mask =3D 0xf=
fffc000},
>     {raw_tcr =3D 0x0, mask =3D 0x0,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0base_mask =3D 0x0}, {raw_tcr =3D 0=
x0, mask =3D 0x0, base_mask =3D
>     0xffffc000}}, vtcr_el2 =3D {raw_tcr =3D 0x0, mask =3D 0x0, base_mask =
=3D 0x0},
>     c2_data =3D 0x0, c2_insn =3D 0x0, {{dacr_ns =3D 0x0, dacr_s =3D 0x0},
>     {dacr32_el2 =3D 0x0}},
>      =C2=A0 =C2=A0 =C2=A0pmsav5_data_ap =3D 0x0, pmsav5_insn_ap =3D 0x0, =
hcr_el2 =3D 0x0,
>     scr_el3
>     =3D 0x101, {{ifsr_ns =3D 0x0, ifsr_s =3D 0x0}, {ifsr32_el2 =3D 0x0}},
>     {{_unused_dfsr =3D 0x0, dfsr_ns =3D 0x0, hsr =3D 0x0, dfsr_s =3D 0x0}=
, esr_el =3D
>     {0x0, 0x0, 0x0, 0x0}},
>      =C2=A0 =C2=A0 =C2=A0c6_region =3D {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0=
, 0x0},
>     {{_unused_far0 =3D 0x0, dfar_ns =3D 0x0, ifar_ns =3D 0x0, dfar_s =3D =
0x0,
>     ifar_s
>     =3D 0x0, _unused_far3 =3D 0x0}, far_el =3D {0x0, 0x0, 0x0, 0x0}}, hpf=
ar_el2 =3D
>     0x0, hstr_el2 =3D 0x0, {{
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_unused_par_0 =3D 0x0, par_ns =3D =
0x0, _unused_par_1 =3D 0x0,
>     par_s =3D
>     0x0}, par_el =3D {0x0, 0x0, 0x0, 0x0}}, c9_insn =3D 0x0, c9_data =3D =
0x0,
>     c9_pmcr =3D 0x41002000, c9_pmcnten =3D 0x0, c9_pmovsr =3D 0x0, c9_pmu=
serenr =3D
>     0x0, c9_pmselr =3D 0x0,
>      =C2=A0 =C2=A0 =C2=A0c9_pminten =3D 0x0, {{_unused_mair_0 =3D 0x0, ma=
ir0_ns =3D 0x0,
>     mair1_ns
>     =3D 0x0, _unused_mair_1 =3D 0x0, mair0_s =3D 0x0, mair1_s =3D 0x0}, m=
air_el =3D
>     {0x0, 0x0, 0x0, 0x0}}, {{_unused_vbar =3D 0x0, vbar_ns =3D 0x0, hvbar=
 =3D
>     0x0,
>     vbar_s =3D 0x0},
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0vbar_el =3D {0x0, 0x0, 0x0, 0x0}}, mvbar =
=3D 0x0, {fcseidr_ns =3D
>     0x0,
>     fcseidr_s =3D 0x0}, {{_unused_contextidr_0 =3D 0x0, contextidr_ns =3D=
 0x0,
>     _unused_contextidr_1 =3D 0x0, contextidr_s =3D 0x0}, contextidr_el =
=3D {0x0,
>     0x0, 0x0, 0x0}}, {{
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tpidrurw_ns =3D 0x0, tpidrprw_ns =
=3D 0x0, htpidr =3D 0x0,
>     _tpidr_el3
>     =3D 0x0}, tpidr_el =3D {0x0, 0x0, 0x0, 0x0}}, tpidrurw_s =3D 0x0,
>     tpidrprw_s =3D
>     0x0, tpidruro_s =3D 0x0, {tpidruro_ns =3D 0x0, tpidrro_el =3D {0x0}},
>     c14_cntfrq =3D 0x3b9aca0,
>      =C2=A0 =C2=A0 =C2=A0c14_cntkctl =3D 0x0, cnthctl_el2 =3D 0x3, cntvof=
f_el2 =3D 0x0,
>     c14_timer
>     =3D {{cval =3D 0x0, ctl =3D 0x0}, {cval =3D 0x0, ctl =3D 0x0}, {cval =
=3D 0x0, ctl =3D
>     0x0}, {cval =3D 0x0, ctl =3D 0x0}}, c15_cpar =3D 0x0, c15_ticonfig =
=3D 0x0,
>     c15_i_max =3D 0x0,
>      =C2=A0 =C2=A0 =C2=A0c15_i_min =3D 0x0, c15_threadid =3D 0x0, c15_con=
fig_base_address =3D
>     0x0,
>     c15_diagnostic =3D 0x0, c15_power_diagnostic =3D 0x0, c15_power_contr=
ol =3D
>     0x0, dbgbvr =3D {0x0 <repeats 16 times>}, dbgbcr =3D {0x0 <repeats 16
>     times>}, dbgwvr =3D {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A00x0 <repeats 16 times>}, dbgwcr =3D {0x0 =
<repeats 16 times>},
>     mdscr_el1 =3D 0x0, oslsr_el1 =3D 0xa, mdcr_el2 =3D 0x0, mdcr_el3 =3D =
0x0,
>     c15_ccnt =3D 0x0, c15_ccnt_delta =3D 0x0, c14_pmevcntr =3D {0x0 <repe=
ats 31
>     times>}, c14_pmevcntr_delta =3D {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A00x0 <repeats 31 times>}, c14_pmevtyper =
=3D {0x0 <repeats 31
>     times>}, pmccfiltr_el0 =3D 0x0, vpidr_el2 =3D 0x410fc075, vmpidr_el2 =
=3D
>     0x80000001}, v7m =3D {other_sp =3D 0x0, other_ss_msp =3D 0x0, other_s=
s_psp =3D
>     0x0, vecbase =3D {0x0, 0x0},
>      =C2=A0 =C2=A0 =C2=A0basepri =3D {0x0, 0x0}, control =3D {0x0, 0x0}, =
ccr =3D {0x0, 0x0},
>     cfsr
>     =3D {0x0, 0x0}, hfsr =3D 0x0, dfsr =3D 0x0, sfsr =3D 0x0, mmfar =3D {=
0x0, 0x0},
>     bfar =3D 0x0, sfar =3D 0x0, mpu_ctrl =3D {0x0, 0x0}, exception =3D 0x=
0, primask
>     =3D {0x0, 0x0},
>      =C2=A0 =C2=A0 =C2=A0faultmask =3D {0x0, 0x0}, aircr =3D 0x0, secure =
=3D 0x0, csselr =3D {0x0,
>     0x0}, scr =3D {0x0, 0x0}, msplim =3D {0x0, 0x0}, psplim =3D {0x0, 0x0=
}, fpcar
>     =3D {0x0, 0x0}, fpccr =3D {0x0, 0x0}, fpdscr =3D {0x0, 0x0}, cpacr =
=3D {0x0,
>     0x0}, nsacr =3D 0x0},
>      =C2=A0 =C2=A0exception =3D {syndrome =3D 0x0, fsr =3D 0x0, vaddress =
=3D 0x0, target_el =3D
>     0x0}, serror =3D {pending =3D 0x0, has_esr =3D 0x0, esr =3D 0x0},
>     irq_line_state
>     =3D 0x0, teecr =3D 0x0, teehbr =3D 0x0, vfp =3D {zregs =3D {{d =3D {0=
x0, 0x0}}
>     <repeats 32 times>},
>      =C2=A0 =C2=A0 =C2=A0qc =3D {0x0, 0x0, 0x0, 0x0}, vec_len =3D 0x0, ve=
c_stride =3D 0x0,
>     xregs =3D
>     {0x41023075, 0x0, 0x0, 0x0, 0x0, 0x0, 0x11111111, 0x10110222, 0x0, 0x=
0,
>     0x0, 0x0, 0x0, 0x0, 0x0, 0x0}, scratch =3D {0x0, 0x0, 0x0, 0x0, 0x0, =
0x0,
>     0x0, 0x0},
>      =C2=A0 =C2=A0 =C2=A0fp_status =3D {float_detect_tininess =3D 0x1, fl=
oat_rounding_mode =3D
>     0x0, float_exception_flags =3D 0x0, floatx80_rounding_precision =3D 0=
x0,
>     flush_to_zero =3D 0x0, flush_inputs_to_zero =3D 0x0, default_nan_mode=
 =3D
>     0x0,
>     snan_bit_is_one =3D 0x0},
>      =C2=A0 =C2=A0 =C2=A0fp_status_f16 =3D {float_detect_tininess =3D 0x1=
,
>     float_rounding_mode =3D
>     0x0, float_exception_flags =3D 0x0, floatx80_rounding_precision =3D 0=
x0,
>     flush_to_zero =3D 0x0, flush_inputs_to_zero =3D 0x0, default_nan_mode=
 =3D 0x0,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0snan_bit_is_one =3D 0x0}, standard_fp_sta=
tus =3D
>     {float_detect_tininess =3D 0x1, float_rounding_mode =3D 0x0,
>     float_exception_flags =3D 0x0, floatx80_rounding_precision =3D 0x0,
>     flush_to_zero =3D 0x1, flush_inputs_to_zero =3D 0x1,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0default_nan_mode =3D 0x1, snan_bit_is_one=
 =3D 0x0}, zcr_el =3D {0x0,
>     0x0, 0x0, 0x0}}, exclusive_addr =3D 0xffffffffffffffff, exclusive_val=
 =3D
>     0x0, exclusive_high =3D 0x0, iwmmxt =3D {regs =3D {0x0 <repeats 16 ti=
mes>},
>     val =3D 0x0, cregs =3D {
>      =C2=A0 =C2=A0 =C2=A0 =C2=A00x0 <repeats 16 times>}}, cpu_breakpoint =
=3D {0x0 <repeats 16
>     times>}, cpu_watchpoint =3D {0x0 <repeats 16 times>}, end_reset_field=
s =3D
>     {<No data fields>}, features =3D 0xfd38fbe6f3, pmsav7 =3D {drbar =3D =
0x0,
>     drsr
>     =3D 0x0, dracr =3D 0x0,
>      =C2=A0 =C2=A0 =C2=A0rnr =3D {0x0, 0x0}}, pmsav8 =3D {rbar =3D {0x0, =
0x0}, rlar =3D {0x0,
>     0x0},
>     mair0 =3D {0x0, 0x0}, mair1 =3D {0x0, 0x0}}, sau =3D {rbar =3D 0x0, r=
lar =3D 0x0,
>     rnr =3D 0x0, ctrl =3D 0x0}, nvic =3D 0x0, boot_info =3D 0x5622af3a17a=
0,
>     gicv3state =3D 0x0}
>=20
>      > [1] http://www.orangepi.org/downloadresources/
>      > [2] https://buildroot.org/download.html
>      > [3] https://www.armbian.com/orange-pi-pc/
>=20
>=20
>=20
> --=20
> Niek Linnenbank
>=20
> WWW: http://www.nieklinnenbank.nl/
> BLOG: http://nieklinnenbank.wordpress.com/
> FUN: http://www.FreeNOS.org/


