Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA34DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D5821548
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHgCOS8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D5821548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIJJ-0004m3-S9
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kSIEN-0000Ah-9m
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 07:12:35 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:38647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kSIEJ-0008Ca-FK
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 07:12:34 -0400
Received: by mail-il1-x144.google.com with SMTP id p16so11672085ilq.5
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 04:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JshfDG6F4LCfQy5nZGyislARlPN0nV8iQKhVCAWvP+M=;
 b=QHgCOS8zu8sgWITGrB14oCLZQRpNKWFWNUKcypqxNnEFBJfc798z9ABP3g50jsM+LM
 2WNuyEwIzbe/OHWz287ECgRFqTKkSGZhKCrqEDqVn8OSFL5PrEyWiCZiQoe6SsHnuTS6
 scT2zrOZTYt5IroI2Jwx8x7m0IXrrJtB7yXb5fGbMDAzRJ2v+PfLfCL4mSQvMyoP4k8w
 4Sgpt/tMk8p5bzQ04JZGa19i5pvQi0QwJTUI49lQSV7D6NcruuovaMUU1mU7Uqxvlo+Y
 9oX6Lg3clRh8saoqQg/pfnRTF2Ejn2qPohPWgePZfd4r6ppFDLIIklE4284GLV6XeDl0
 e17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JshfDG6F4LCfQy5nZGyislARlPN0nV8iQKhVCAWvP+M=;
 b=Uitx4bQKkpTdhis2v5M2CRpywnQb9vB/MijrIwZeQx1qtBOXxo2myPAQracgKJVSNx
 v593Dr0ld9v2YkI9BnhG1HRmfddLUZOLGcqTrbjIISkS+lKDFrT36wlpvvAF4lCl6sR/
 N6vprC+bfn6g3lcr4orUkg+0FvStPGyGx/+IR/scfQvwo27H5xN2gFbcpH8K2IQm/kv5
 Yq0xh1xKHiOpzuaTHeeNh7LqQKz2fSJ5TnhjOZz8ems4u+sa+KA266hAt04tVlU9L3K4
 HdhMP0hYwvflIHvjislec7SqVTEJhchGpbM+0kXwDGTmXexFZBBXonTSC7acveuq2TB9
 o8Ow==
X-Gm-Message-State: AOAM533cQJ6BMLbeJVKFZe+hQ5dMwqRZ2W22OBaEFcVzMgRFuO/8c9z8
 DWoW8ZjOnzr0zeLZ1FgENgZkp93z6FJ4hoHCnQE=
X-Google-Smtp-Source: ABdhPJy9n8reYNOrSUXA+wyUsEQNda6lY3FvYuPKktnimZw/1q5+0gQCtQivG7Owgka9RBvewLQgBCgV7UraUJnutsc=
X-Received: by 2002:a92:8e51:: with SMTP id k17mr2582698ilh.270.1602587549532; 
 Tue, 13 Oct 2020 04:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
 <1602059975-10115-9-git-send-email-chenhc@lemote.com>
 <2867f40b-4a43-f2ce-661a-d0fdbd1a2efd@amsat.org>
 <CAAhV-H52M8exRQzi+jfa7x=dU7apQGHcrOQXbgfsG=hxfjj=cQ@mail.gmail.com>
 <8845b268-cd1e-f237-59c1-271c0f65fca3@amsat.org>
In-Reply-To: <8845b268-cd1e-f237-59c1-271c0f65fca3@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Tue, 13 Oct 2020 19:12:17 +0800
Message-ID: <CAAhV-H70JNviSQn_5B-KL8=7=0=1kp+UwPODA95BV_fSowxR6A@mail.gmail.com>
Subject: Re: [PATCH V13 8/9] hw/mips: Add Loongson-3 machine support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=chenhuacai@gmail.com; helo=mail-il1-x144.google.com
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
Cc: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Mon, Oct 12, 2020 at 4:12 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 10/11/20 4:53 AM, Huacai Chen wrote:
> > Hi, Philippe,
> >
> > On Sat, Oct 10, 2020 at 5:09 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> >>
> >> Hi Huacai,
> >>
> >> On 10/7/20 10:39 AM, Huacai Chen wrote:
> >>> Add Loongson-3 based machine support, it use liointc as the interrupt
> >>> controler and use GPEX as the pci controller. Currently it can work w=
ith
> >>> both TCG and KVM.
> >>>
> >>> As the machine model is not based on any exiting physical hardware, t=
he
> >>> name of the machine is "loongson3-virt". It may be superseded in futu=
re
> >>> by a real machine model. If this happens, then a regular deprecation
> >>> procedure shall occur for "loongson3-virt" machine.
> >>>
> >>> We now already have a full functional Linux kernel (based on Linux-5.=
4.x
> >>> LTS, the kvm host side and guest side have both been upstream for Lin=
ux-
> >>> 5.9, but Linux-5.9 has not been released yet) here:
> >>>
> >>> https://github.com/chenhuacai/linux
> >>>
> >>> Of course the upstream kernel is also usable (though it is "unstable"
> >>> now):
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>>
> >>> How to use QEMU/Loongson-3?
> >>> 1, Download kernel source from the above URL;
> >>> 2, Build a kernel with arch/mips/configs/loongson3_defconfig;
> >>> 3, Boot a Loongson-3A4000 host with this kernel (for KVM mode);
> >>> 4, Build QEMU-master with this patchset;
> >>> 5, modprobe kvm (only necessary for KVM mode);
> >>> 6, Use QEMU with TCG:
> >>>          qemu-system-mips64el -M loongson3-virt,accel=3Dtcg -cpu Loon=
gson-3A1000 -kernel <path_to_kernel> -append ...
> >>>      Use QEMU with KVM:
> >>>          qemu-system-mips64el -M loongson3-virt,accel=3Dkvm -cpu Loon=
gson-3A4000 -kernel <path_to_kernel> -append ...
> >>>
> >>>      The "-cpu" parameter is optional here and QEMU will use the corr=
ect type for TCG/KVM automatically.
> >>>
> >>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> >>> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >>> ---
> >>>    default-configs/devices/mips64el-softmmu.mak |   1 +
> >>>    hw/mips/Kconfig                              |  12 +
> >>>    hw/mips/loongson3_bootp.c                    | 162 +++++++
> >>>    hw/mips/loongson3_bootp.h                    | 225 ++++++++++
> >>
> >> In a previous version I asked if you could split the bootp* files
> >> (firmware related) in a previous separate patch to ease the review
> >> of the machine part.
>  >
> > In previous version you told me to split the fw_cfg to a separate
> > patch, but split the efi-related helpers to seprate files (not to a
> > patch). But anyway, I will split them to a patch in the next version.
>
> Sorry if I wasn't clear enough. It is very hard to review a patch
> of more than 1000 lines of C code without loosing focus or missing
> problems. It explains why big patches might stay unreviewed on the
> list. If you can split in smaller logical units, it will be very
> helpful.
>
> Peter Maydell rule of thumb is to keep patch below 200 lines.
> This is a good limit.
>
> >
> >>
> >>>    hw/mips/loongson3_virt.c                     | 615 +++++++++++++++=
++++++++++++
> >>>    hw/mips/meson.build                          |   1 +
> >>>    6 files changed, 1016 insertions(+)
> >> [...]
> >>
> >>> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> >>> new file mode 100644
> >>> index 0000000..4e573d6
> >>> --- /dev/null
> >>> +++ b/hw/mips/loongson3_virt.c
> >>> @@ -0,0 +1,615 @@
> >>> +/*
> >>> + * Generic Loongson-3 Platform support
> >>> + *
> >>> + * Copyright (c) 2017-2020 Huacai Chen (chenhc@lemote.com)
> >>> + * Copyright (c) 2017-2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
> >>> + *
> >>> + * This program is free software: you can redistribute it and/or mod=
ify
> >>> + * it under the terms of the GNU General Public License as published=
 by
> >>> + * the Free Software Foundation, either version 2 of the License, or
> >>> + * (at your option) any later version.
> >>> + *
> >>> + * This program is distributed in the hope that it will be useful,
> >>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> >>> + * GNU General Public License for more details.
> >>> + *
> >>> + * You should have received a copy of the GNU General Public License
> >>> + * along with this program. If not, see <https://www.gnu.org/license=
s/>.
> >>> + */
> >>> +
> >>> +/*
> >>> + * Generic virtualized PC Platform based on Loongson-3 CPU (MIPS64R2=
 with
> >>> + * extensions, 800~2000MHz)
> >>> + */
> >>> +
> >>> +#include "qemu/osdep.h"
> >>> +#include "qemu-common.h"
> >>> +#include "qemu/units.h"
> >>> +#include "qemu/cutils.h"
> >>> +#include "qapi/error.h"
> >>> +#include "cpu.h"
> >>> +#include "elf.h"
> >>> +#include "kvm_mips.h"
> >>> +#include "hw/boards.h"
> >>> +#include "hw/char/serial.h"
> >>> +#include "hw/mips/mips.h"
> >>> +#include "hw/mips/cpudevs.h"
> >>> +#include "hw/mips/fw_cfg.h"
> >>> +#include "hw/mips/loongson3_bootp.h"
> >>> +#include "hw/misc/unimp.h"
> >>> +#include "hw/intc/i8259.h"
> >>> +#include "hw/loader.h"
> >>> +#include "hw/isa/superio.h"
> >>> +#include "hw/pci/msi.h"
> >>> +#include "hw/pci/pci.h"
> >>> +#include "hw/pci/pci_host.h"
> >>> +#include "hw/pci-host/gpex.h"
> >>> +#include "hw/rtc/mc146818rtc.h"
> >>> +#include "hw/usb.h"
> >>> +#include "net/net.h"
> >>> +#include "exec/address-spaces.h"
> >>> +#include "sysemu/kvm.h"
> >>> +#include "sysemu/qtest.h"
> >>> +#include "sysemu/reset.h"
> >>> +#include "sysemu/runstate.h"
> >>> +#include "qemu/log.h"
> >>> +#include "qemu/error-report.h"
> >>> +
> >>> +#define PM_CNTL_MODE          0x10
> >>> +
> >>> +#define LOONGSON_MAX_VCPUS      16
> >>> +
> >>> +#define LOONGSON3_BIOSNAME "bios_loongson3.bin"
> >>
> >> Where is that file?
>  >
> > I don't know the policy of QEMU's binary file, just put that in the
> > roms directory?
>
> If this is a closed source binary, we reference the URL where it can
> be downloaded accepting eventual EULA.
> If it is open source, the project is added as submodule. QEMU then
> provides a link to how to build the firmware, or if there is no such
> documentation, buildsys machinery is added to QEMU to build to it
> (see roms/Makefile).
OK, now the firmware is close-source (maybe open source in future), so
I will put an URL here.

>
> >
> >>
> >>> +
> >>> +#define UART_IRQ            0
> >>> +#define RTC_IRQ             1
> >>> +#define PCIE_IRQ_BASE       2
> >>> +
> >>> +const struct MemmapEntry virt_memmap[] =3D {
> >>> +    [VIRT_LOWMEM] =3D      { 0x00000000,    0x10000000 },
> >>> +    [VIRT_PM] =3D          { 0x10080000,         0x100 },
> >>> +    [VIRT_FW_CFG] =3D      { 0x10080100,         0x100 },
> >>> +    [VIRT_RTC] =3D         { 0x10081000,        0x1000 },
> >>> +    [VIRT_PCIE_PIO] =3D    { 0x18000000,       0x80000 },
> >>> +    [VIRT_PCIE_ECAM] =3D   { 0x1a000000,     0x2000000 },
> >>> +    [VIRT_BIOS_ROM] =3D    { 0x1fc00000,      0x200000 },
> >>> +    [VIRT_UART] =3D        { 0x1fe001e0,           0x8 },
> >>
> >> See below about this mapping.
> >>
> >>> +    [VIRT_LIOINTC] =3D     { 0x3ff01400,          0x64 },
> >>> +    [VIRT_PCIE_MMIO] =3D   { 0x40000000,    0x40000000 },
> >>> +    [VIRT_HIGHMEM] =3D     { 0x80000000,           0x0 }, /* Variabl=
e */
> >>> +};
> >>> +
> >>> +static const struct MemmapEntry loader_memmap[] =3D {
> >>> +    [LOADER_KERNEL] =3D    { 0x00000000,     0x4000000 },
> >>> +    [LOADER_INITRD] =3D    { 0x04000000,           0x0 }, /* Variabl=
e */
> >>> +    [LOADER_CMDLINE] =3D   { 0x0ff00000,      0x100000 },
> >>> +};
> >>> +
> >>> +static const struct MemmapEntry loader_rommap[] =3D {
> >>> +    [LOADER_BOOTROM] =3D   { 0x1fc00000,        0x1000 },
> >>> +    [LOADER_PARAM] =3D     { 0x1fc01000,       0x10000 },
> >>> +};
> >>> +
> >>> +static struct _loaderparams {
> >>> +    uint64_t cpu_freq;
> >>> +    uint64_t ram_size;
> >>> +    const char *kernel_cmdline;
> >>> +    const char *kernel_filename;
> >>> +    const char *initrd_filename;
> >>> +    uint64_t kernel_entry;
> >>> +    uint64_t a0, a1, a2;
> >>> +} loaderparams;
> >>> +
> >>> +static uint64_t loongson3_pm_read(void *opaque, hwaddr addr, unsigne=
d size)
> >>> +{
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +static void loongson3_pm_write(void *opaque, hwaddr addr, uint64_t v=
al, unsigned size)
> >>> +{
> >>> +    if (addr !=3D PM_CNTL_MODE) {
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    switch (val) {
> >>> +    case 0x00:
> >>> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> >>> +        return;
> >>> +    case 0xff:
> >>> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> >>> +        return;
> >>> +    default:
> >>> +        return;
> >>> +    }
> >>> +}
> >>> +
> >>> +static const MemoryRegionOps loongson3_pm_ops =3D {
> >>> +    .read  =3D loongson3_pm_read,
> >>> +    .write =3D loongson3_pm_write,
> >>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> >>> +};
> >>> +
> >>> +#define DEF_TCG_FREQ (200 * 1000 * 1000)
> >>> +#define DEF_KVM_FREQ (1600 * 1000 * 1000)
> >>> +
> >>> +static uint64_t get_cpu_freq(void)
> >>> +{
> >>> +#ifdef CONFIG_KVM
> >>> +    int ret;
> >>> +    uint64_t freq;
> >>> +    struct kvm_one_reg freq_reg =3D {
> >>> +        .id =3D KVM_REG_MIPS_COUNT_HZ,
> >>> +        .addr =3D (uintptr_t)(&freq)
> >>> +    };
> >>> +
> >>> +    if (kvm_enabled()) {
> >>> +        ret =3D kvm_vcpu_ioctl(first_cpu, KVM_GET_ONE_REG, &freq_reg=
);
> >>> +        if (ret < 0) {
> >>> +            return DEF_KVM_FREQ;
> >>> +        }
> >>> +        return freq * 2;
> >>> +    } else {
> >>> +        /*
> >>> +         * TCG has a default CP0 Timer period 10 ns, which is 100MHz=
,
> >>> +         * CPU frequency is defined as double of CP0 timer frequency=
.
> >>> +         */
> >>> +        return DEF_TCG_FREQ;
> >>> +    }
> >>> +#else
> >>> +    return DEF_TCG_FREQ;
> >>> +#endif
> >>> +}
> >>> +
> >>> +static void init_boot_param(void)
> >>> +{
> >>> +    void *p;
> >>> +    struct boot_params *bp;
> >>> +
> >>> +    p =3D g_malloc0(loader_rommap[LOADER_PARAM].size);
> >>> +    bp =3D p;
> >>> +
> >>> +    stw_le_p(&bp->efi.smbios.vers, 1);
> >>> +    init_reset_system(&(bp->reset_system));
> >>> +    p +=3D ROUND_UP(sizeof(struct boot_params), 64);
> >>> +    init_loongson_params(&(bp->efi.smbios.lp), p,
> >>> +                         loaderparams.cpu_freq, loaderparams.ram_siz=
e);
> >>> +
> >>> +    rom_add_blob_fixed("params_rom", bp,
> >>> +                       loader_rommap[LOADER_PARAM].size,
> >>> +                       loader_rommap[LOADER_PARAM].base);
> >>> +
> >>> +    g_free(bp);
> >>> +
> >>> +    loaderparams.a2 =3D cpu_mips_phys_to_kseg0(NULL, loader_rommap[L=
OADER_PARAM].base);
> >>> +}
> >>> +
> >>> +static void init_boot_rom(void)
> >>> +{
> >>> +    const unsigned int boot_code[] =3D {
> >>> +        0x40086000,   /* mfc0    t0, CP0_STATUS                     =
          */
> >>> +        0x240900E4,   /* li      t1, 0xe4         #set kx, sx, ux, e=
rl        */
> >>> +        0x01094025,   /* or      t0, t0, t1                         =
          */
> >>> +        0x3C090040,   /* lui     t1, 0x40         #set bev          =
          */
> >>> +        0x01094025,   /* or      t0, t0, t1                         =
          */
> >>> +        0x40886000,   /* mtc0    t0, CP0_STATUS                     =
          */
> >>> +        0x00000000,
> >>> +        0x40806800,   /* mtc0    zero, CP0_CAUSE                    =
          */
> >>> +        0x00000000,
> >>> +        0x400A7801,   /* mfc0    t2, $15, 1                         =
          */
> >>> +        0x314A00FF,   /* andi    t2, 0x0ff                          =
          */
> >>> +        0x3C089000,   /* dli     t0, 0x900000003ff01000             =
          */
> >>> +        0x00084438,
> >>> +        0x35083FF0,
> >>> +        0x00084438,
> >>> +        0x35081000,
> >>> +        0x314B0003,   /* andi    t3, t2, 0x3      #local cpuid      =
          */
> >>> +        0x000B5A00,   /* sll     t3, 8                              =
          */
> >>> +        0x010B4025,   /* or      t0, t0, t3                         =
          */
> >>> +        0x314C000C,   /* andi    t4, t2, 0xc      #node id          =
          */
> >>> +        0x000C62BC,   /* dsll    t4, 42                             =
          */
> >>> +        0x010C4025,   /* or      t0, t0, t4                         =
          */
> >>> +                      /* WaitForInit:                               =
          */
> >>> +        0xDD020020,   /* ld      v0, FN_OFF(t0)   #FN_OFF 0x020     =
          */
> >>> +        0x1040FFFE,   /* beqz    v0, WaitForInit                    =
          */
> >>> +        0x00000000,   /* nop                                        =
          */
> >>> +        0xDD1D0028,   /* ld      sp, SP_OFF(t0)   #FN_OFF 0x028     =
          */
> >>> +        0xDD1C0030,   /* ld      gp, GP_OFF(t0)   #FN_OFF 0x030     =
          */
> >>> +        0xDD050038,   /* ld      a1, A1_OFF(t0)   #FN_OFF 0x038     =
          */
> >>> +        0x00400008,   /* jr      v0               #byebye           =
          */
> >>> +        0x00000000,   /* nop                                        =
          */
> >>> +        0x1000FFFF,   /* 1:  b   1b                                 =
          */
> >>> +        0x00000000,   /* nop                                        =
          */
> >>> +
> >>> +                      /* Reset                                      =
          */
> >>> +        0x3C0C9000,   /* dli     t0, 0x9000000010080010             =
          */
> >>> +        0x358C0000,
> >>> +        0x000C6438,
> >>> +        0x358C1008,
> >>> +        0x000C6438,
> >>> +        0x358C0010,
> >>> +        0x240D0000,   /* li      t1, 0x00                           =
          */
> >>> +        0xA18D0000,   /* sb      t1, (t0)                           =
          */
> >>> +        0x1000FFFF,   /* 1:  b   1b                                 =
          */
> >>> +        0x00000000,   /* nop                                        =
          */
> >>> +
> >>> +                      /* Shutdown                                   =
          */
> >>> +        0x3C0C9000,   /* dli     t0, 0x9000000010080010             =
          */
> >>> +        0x358C0000,
> >>> +        0x000C6438,
> >>> +        0x358C1008,
> >>> +        0x000C6438,
> >>> +        0x358C0010,
> >>> +        0x240D00FF,   /* li      t1, 0xff                           =
          */
> >>> +        0xA18D0000,   /* sb      t1, (t0)                           =
          */
> >>> +        0x1000FFFF,   /* 1:  b   1b                                 =
          */
> >>> +        0x00000000    /* nop                                        =
          */
> >>> +    };
> >>> +
> >>> +    rom_add_blob_fixed("boot_rom", boot_code, sizeof(boot_code),
> >>> +                        loader_rommap[LOADER_BOOTROM].base);
> >>> +}
> >>> +
> >>> +static void fw_cfg_boot_set(void *opaque, const char *boot_device,
> >>> +                            Error **errp)
> >>> +{
> >>> +    fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
> >>> +}
> >>> +
> >>> +static void fw_conf_init(unsigned long ram_size)
> >>> +{
> >>> +    FWCfgState *fw_cfg;
> >>> +    hwaddr cfg_addr =3D virt_memmap[VIRT_FW_CFG].base;
> >>> +
> >>> +    fw_cfg =3D fw_cfg_init_mem_wide(cfg_addr, cfg_addr + 8, 8, 0, NU=
LL);
> >>> +    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)current_machine=
->smp.cpus);
> >>> +    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_machin=
e->smp.max_cpus);
> >>> +    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
> >>> +    fw_cfg_add_i32(fw_cfg, FW_CFG_MACHINE_VERSION, 1);
> >>> +    fw_cfg_add_i64(fw_cfg, FW_CFG_CPU_FREQ, get_cpu_freq());
> >>> +    qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
> >>> +}
> >>> +
> >>> +static int set_prom_cmdline(ram_addr_t initrd_offset, long initrd_si=
ze)
> >>> +{
> >>> +    hwaddr cmdline_vaddr;
> >>> +    char memenv[32];
> >>> +    char highmemenv[32];
> >>> +    void *cmdline_buf;
> >>> +    unsigned int *parg_env;
> >>> +    int ret =3D 0;
> >>> +
> >>> +    /* Allocate cmdline_buf for command line. */
> >>> +    cmdline_buf =3D g_malloc0(loader_memmap[LOADER_CMDLINE].size);
> >>> +    cmdline_vaddr =3D cpu_mips_phys_to_kseg0(NULL,
> >>> +                                           loader_memmap[LOADER_CMDL=
INE].base);
> >>> +
> >>> +    /*
> >>> +     * Layout of cmdline_buf looks like this:
> >>> +     * argv[0], argv[1], 0, env[0], env[1], ... env[i], 0,
> >>> +     * argv[0]'s data, argv[1]'s data, env[0]'data, ..., env[i]'s da=
ta, 0
> >>> +     */
> >>> +    parg_env =3D (void *)cmdline_buf;
> >>> +
> >>> +    ret =3D (3 + 1) * 4;
> >>> +    *parg_env++ =3D cmdline_vaddr + ret;
> >>> +    ret +=3D (1 + snprintf(cmdline_buf + ret, 256 - ret, "g"));
> >>> +
> >>> +    /* argv1 */
> >>> +    *parg_env++ =3D cmdline_vaddr + ret;
> >>> +    if (initrd_size > 0)
> >>> +        ret +=3D (1 + snprintf(cmdline_buf + ret, 256 - ret,
> >>> +                "rd_start=3D0x" TARGET_FMT_lx " rd_size=3D%li %s",
> >>> +                cpu_mips_phys_to_kseg0(NULL, initrd_offset),
> >>> +                initrd_size, loaderparams.kernel_cmdline));
> >>> +    else
> >>> +        ret +=3D (1 + snprintf(cmdline_buf + ret, 256 - ret, "%s",
> >>> +                loaderparams.kernel_cmdline));
> >>> +
> >>> +    /* argv2 */
> >>> +    *parg_env++ =3D cmdline_vaddr + 4 * ret;
> >>> +
> >>> +    /* env */
> >>> +    sprintf(memenv, "%d", 256);
> >>> +    sprintf(highmemenv, "%ld", (unsigned long)(loaderparams.ram_size=
 / MiB) - 256);
> >>> +
> >>> +    rom_add_blob_fixed("cmdline", cmdline_buf,
> >>> +                       loader_memmap[LOADER_CMDLINE].size,
> >>> +                       loader_memmap[LOADER_CMDLINE].base);
> >>> +
> >>> +    g_free(cmdline_buf);
> >>> +
> >>> +    loaderparams.a0 =3D 2;
> >>> +    loaderparams.a1 =3D cmdline_vaddr;
> >>> +
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +static uint64_t load_kernel(CPUMIPSState *env)
> >>> +{
> >>> +    long kernel_size;
> >>> +    ram_addr_t initrd_offset;
> >>> +    uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;
> >>> +
> >>> +    kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
> >>> +                           cpu_mips_kseg0_to_phys, NULL,
> >>> +                           (uint64_t *)&kernel_entry,
> >>> +                           (uint64_t *)&kernel_low, (uint64_t *)&ker=
nel_high,
> >>> +                           NULL, 0, EM_MIPS, 1, 0);
> >>> +    if (kernel_size < 0) {
> >>> +        error_report("could not load kernel '%s': %s",
> >>> +                     loaderparams.kernel_filename,
> >>> +                     load_elf_strerror(kernel_size));
> >>> +        exit(1);
> >>> +    }
> >>> +
> >>> +    /* load initrd */
> >>> +    initrd_size =3D 0;
> >>> +    initrd_offset =3D 0;
> >>> +    if (loaderparams.initrd_filename) {
> >>> +        initrd_size =3D get_image_size(loaderparams.initrd_filename)=
;
> >>> +        if (initrd_size > 0) {
> >>> +            initrd_offset =3D (kernel_high + ~INITRD_PAGE_MASK) &
> >>> +                            INITRD_PAGE_MASK;
> >>> +            initrd_offset =3D MAX(initrd_offset,
> >>> +                                loader_memmap[LOADER_INITRD].base);
> >>> +
> >>> +            if (initrd_offset + initrd_size > ram_size) {
> >>> +                error_report("memory too small for initial ram disk =
'%s'",
> >>> +                             loaderparams.initrd_filename);
> >>> +                exit(1);
> >>> +            }
> >>> +
> >>> +            initrd_size =3D load_image_targphys(loaderparams.initrd_=
filename,
> >>> +                                              initrd_offset,
> >>> +                                              ram_size - initrd_offs=
et);
> >>> +        }
> >>> +
> >>> +        if (initrd_size =3D=3D (target_ulong) -1) {
> >>> +            error_report("could not load initial ram disk '%s'",
> >>> +                         loaderparams.initrd_filename);
> >>> +            exit(1);
> >>> +        }
> >>> +    }
> >>> +
> >>> +    /* Setup prom cmdline. */
> >>> +    set_prom_cmdline(initrd_offset, initrd_size);
> >>> +
> >>> +    return kernel_entry;
> >>> +}
> >>> +
> >>> +static void main_cpu_reset(void *opaque)
> >>> +{
> >>> +    MIPSCPU *cpu =3D opaque;
> >>> +    CPUMIPSState *env =3D &cpu->env;
> >>> +
> >>> +    cpu_reset(CPU(cpu));
> >>> +
> >>> +    /* Loongson-3 reset stuff */
> >>> +    if (loaderparams.kernel_filename) {
> >>> +        if (cpu =3D=3D MIPS_CPU(first_cpu)) {
> >>> +            env->active_tc.gpr[4] =3D loaderparams.a0;
> >>> +            env->active_tc.gpr[5] =3D loaderparams.a1;
> >>> +            env->active_tc.gpr[6] =3D loaderparams.a2;
> >>> +            env->active_tc.PC =3D loaderparams.kernel_entry;
> >>> +        }
> >>> +        env->CP0_Status &=3D ~((1 << CP0St_BEV) | (1 << CP0St_ERL));
> >>> +    }
> >>> +}
> >>> +
> >>> +static inline void loongson3_virt_devices_init(MachineState *machine=
, DeviceState *pic)
> >>> +{
> >>> +    int i;
> >>> +    qemu_irq irq;
> >>> +    PCIBus *pci_bus;
> >>> +    DeviceState *dev;
> >>> +    MemoryRegion *pio_alias;
> >>> +    MemoryRegion *mmio_alias, *mmio_reg;
> >>> +    MemoryRegion *ecam_alias, *ecam_reg;
> >>> +
> >>> +    dev =3D qdev_new(TYPE_GPEX_HOST);
> >>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> >>> +    pci_bus =3D PCI_HOST_BRIDGE(dev)->bus;
> >>> +
> >>> +    ecam_alias =3D g_new0(MemoryRegion, 1);
> >>> +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> >>> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> >>> +                             ecam_reg, 0, virt_memmap[VIRT_PCIE_ECAM=
].size);
> >>> +    memory_region_add_subregion(get_system_memory(),
> >>> +                                virt_memmap[VIRT_PCIE_ECAM].base, ec=
am_alias);
> >>> +
> >>> +    mmio_alias =3D g_new0(MemoryRegion, 1);
> >>> +    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> >>> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> >>> +                             mmio_reg, virt_memmap[VIRT_PCIE_MMIO].b=
ase,
> >>> +                             virt_memmap[VIRT_PCIE_MMIO].size);
> >>> +    memory_region_add_subregion(get_system_memory(),
> >>> +                                virt_memmap[VIRT_PCIE_MMIO].base, mm=
io_alias);
> >>> +
> >>> +    pio_alias =3D g_new0(MemoryRegion, 1);
> >>> +    memory_region_init_alias(pio_alias, OBJECT(dev), "pcie-pio",
> >>> +                             get_system_io(), 0, virt_memmap[VIRT_PC=
IE_PIO].size);
> >>> +    memory_region_add_subregion(get_system_memory(),
> >>> +                                virt_memmap[VIRT_PCIE_PIO].base, pio=
_alias);
> >>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, virt_memmap[VIRT_PCIE_PI=
O].base);
> >>> +
> >>> +    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> >>> +        irq =3D qdev_get_gpio_in(pic, PCIE_IRQ_BASE + i);
> >>> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> >>> +        gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ_BASE + i);
> >>> +    }
> >>> +
> >>> +    pci_vga_init(pci_bus);
> >>> +
> >>> +    if (defaults_enabled()) {
> >>> +        pci_create_simple(pci_bus, -1, "pci-ohci");
> >>> +        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> >>> +        usb_create_simple(usb_bus_find(-1), "usb-tablet");
> >>> +    }
> >>> +
> >>> +    for (i =3D 0; i < nb_nics; i++) {
> >>> +        NICInfo *nd =3D &nd_table[i];
> >>> +
> >>> +        if (!nd->model) {
> >>> +            nd->model =3D g_strdup("virtio");
> >>> +        }
> >>> +
> >>> +        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
> >>> +    }
> >>> +}
> >>> +
> >>> +static void mips_loongson3_virt_init(MachineState *machine)
> >>> +{
> >>> +    int i;
> >>> +    long bios_size;
> >>> +    MIPSCPU *cpu;
> >>> +    CPUMIPSState *env;
> >>> +    DeviceState *liointc;
> >>> +    char *filename;
> >>> +    const char *kernel_cmdline =3D machine->kernel_cmdline;
> >>> +    const char *kernel_filename =3D machine->kernel_filename;
> >>> +    const char *initrd_filename =3D machine->initrd_filename;
> >>> +    ram_addr_t ram_size =3D machine->ram_size;
> >>> +    MemoryRegion *address_space_mem =3D get_system_memory();
> >>> +    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> >>> +    MemoryRegion *bios =3D g_new(MemoryRegion, 1);
> >>> +    MemoryRegion *iomem =3D g_new(MemoryRegion, 1);
> >>> +
> >>> +    /* TODO: TCG will support all CPU types */
> >>> +    if (!kvm_enabled()) {
> >>> +        if (!machine->cpu_type) {
> >>> +            machine->cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-3A100=
0");
> >>> +        }
> >>> +        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
> >>> +            error_report("Loongson-3/TCG needs cpu type Loongson-3A1=
000");
> >>> +            exit(1);
> >>> +        }
> >>
> >> IIUC here you need to check machine->smp.cpus is 4 or 8 for the 3A1000=
.
> >> It would be easier if you model this as a qdev SoC, and this model
> >> cares to create the 4/8 cores (QEMU MIPSCPU).
> >>
> >> You defined max_cpu =3D LOONGSON_MAX_VCPUS =3D 16, this seems an impos=
sible
> >> configuration for the 3A1000.
>  >
> > There are 4 cores in a SoC, but Loongson-3 support multi-sockets, more
> > than 4 vcpus will be treated as multi-sockets automatically in guests.
> > And current linux kernel also handle the case that only boot part of 4
> > cores in a socket.
>
> What I want to avoid is user booting the machine with 3 or 5 vCPUs,
> then complain booting Linux isn't working. It is simpler to check
> the number of vCPUs matches the hardware possibilities.
The upstream kernel can boot 3 or 5 cores on real hardware (reserve
several cores via boot parameters), so in virtual machine there is
also no problems to boot 3 or 5 vCPUs.

>
> >
> >>
> >>> +    } else {
> >>> +        if (!machine->cpu_type) {
> >>> +            machine->cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-3A400=
0");
> >>> +        }
> >>> +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
> >>> +            error_report("Loongson-3/KVM needs cpu type Loongson-3A4=
000");
> >>> +            exit(1);
> >>> +        }
> >>
> >> Similar comment, as the 3A4000 is also a quad-core.
> >>
> >>> +    }
> >>> +
> >>> +    if (ram_size < 512 * MiB) {
> >>> +        error_report("Loongson-3 machine needs at least 512MB memory=
");
> >>> +        exit(1);
> >>> +    }
> >>> +
> >>> +    /*
> >>> +     * The whole MMIO range among configure registers doesn't genera=
te
> >>> +     * exception when accessing invalid memory. Create an unimplemem=
ted
> >>> +     * device to emulate this feature.
> >>> +     */
> >>> +    create_unimplemented_device("fallback", 0x10000000, 0x30000000);
> >>
> >> The secondary crosswise switch description is hard to follow:
> >>
> >> * 2.4 Address routing distribution and configuration
> >>
> >> According  to  the  default  register  configuration,  CPU [...]
> >> 0x10000000-0x1fffffff  of  CPU  (256M)  is  mapped  to
> >> 0x10000000-0x1fffffff  of  PCI,  and  0x80000000  of  PCIDMA.
> >> In addition, when read access to illegal addresses occurs due to CPU
> >> guess execution, all 8 address Windows fail to hit, ?
> >>
> >> Table 2-9 XBAR level 2 default address configuration
> >>                     base                    high                     o=
wner
> >> 0 x0000_0000_1000_0000  0 x0000_0000_2000_0000  Low speed I/O (PCI, et=
c)
> >>
> >> * 14.4 Secondary cross-switch address window
> >>
> >> After the address window is configured, the system address
> >> 0x0000_2000_0000 is added-- 0x0000_2FFFF_FFFF  maps  to
> >> 0x0000_0000_0000  -- 0x0000_0FFF_FFFF  of  memory  controller 0.An
> >> access to 0x0000_2000_0000 at this time will result in the original
> >> enabledThe value stored at address 0x0000_0000_0000.
> >>
> >> But see:
> >>
> >> * 14.6.3 Low speed device address window
> >>
> >> Here are defined the peripherals in the 0x1c00_0000-0x1ff0_ffff range.
> >>
> >> * 15.1 System memory space
> >>
> >> IO device, 0x1000_0000 --  0x1FFF_FFFF
> >>
> >> * 16 Memory allocation for system X
> >>
> >> ... divide  the  256M  PCI  space  (0x10000000~0x20000000)  into  two
> >> parts:  0x10000000~0x17ffffff for mem space and 0x18000000~0x20000000
> >> for IO space.
> >>
> >> I still don't understand what is in the 0x20000000-0x30000000 range.
> > Loongson's user manual is a little confusing, as a native Chinese I
> > also feel uncomfortable sometimes. :)
> > Generally speaking, Loongson-3's address space is configurable via
> > address windows, and the recommended configurations is like this:
> > 0x00000000-0x10000000   Low RAM
> > 0x10000000-0x40000000   ROM and MMIO Registers (such as BIOS_ROM at
> > 0x1fc00000, UART at 0x1fe001e0, LIOINTC at 0x3ff00140)
> > 0x40000000-0x80000000  PCI MEM
> > 0x80000000-TOM             High RAM
>
> Having a "fallback" region catching everything is not very helpful
> when debugging. Listing each unimplemented peripheral is more useful:
>
>    create_unimplemented_device("LPC MEM", 0x1c000000, 32 * MiB);
>    ...
>    create_unimplemented_device("UART1",   0x1fe001e8, 8);
>    create_unimplemented_device("SPI",     0x1fe001f0, 16);
>    create_unimplemented_device("LPC IO",  0x1ff00000, 64 * KiB);
>    ...
Catch everything here is because both host and guest use the same
kernel now, and there is some code try to access some address regions
which doesn't exist on virtual machine.

>
> >
> > PCI DMA of 0x10000000-0x1fffffff is a legacy region from
> > Loongson-2E/2F, and be cancelled in Loongson-3's configuration.
> > In real hardware, there should be a default "big enough" address
> > window to catch illegal address, return 0 for read access.
> > Yes, there is "nothing" in 0x20000000-0x30000000, because it is
> > undocumented which means "reserved for internal usage".
>
> If it is reserved, then the guest shouldn't be trying to use it...
OK, this will be improved, but create_uniplemented_device() for every
small region seems not good (see above).

>
> >>
> >>> +
> >>> +    liointc =3D qdev_new("loongson.liointc");
> >>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
> >>> +
> >>> +    sysbus_mmio_map(SYS_BUS_DEVICE(liointc), 0, virt_memmap[VIRT_LIO=
INTC].base);
> >>> +
> >>> +    for (i =3D 0; i < machine->smp.cpus; i++) {
> >>> +        int ip;
> >>> +
> >>> +        /* init CPUs */
> >>> +        cpu =3D MIPS_CPU(cpu_create(machine->cpu_type));
> >>> +
> >>> +        /* Init internal devices */
> >>> +        cpu_mips_irq_init_cpu(cpu);
> >>> +        cpu_mips_clock_init(cpu);
> >>> +        qemu_register_reset(main_cpu_reset, cpu);
> >>> +
> >>> +        if (i >=3D 4) {
> >>> +            continue; /* Only node-0 can be connected to LIOINTC */
> >>> +        }
> >>> +
> >>> +        for (ip =3D 0; ip < 4 ; ip++) {
> >>> +            int pin =3D i * 4 + ip;
> >>> +            sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
> >>> +                               pin, cpu->env.irq[ip + 2]);
> >>> +        }
> >>> +    }
> >>> +    env =3D &MIPS_CPU(first_cpu)->env;
> >>> +
> >>> +    /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x800000=
00~0x90000000 */
> >>> +    memory_region_init_rom(bios, NULL, "loongson3.bios",
> >>> +                           virt_memmap[VIRT_BIOS_ROM].size, &error_f=
atal);
> >>> +    memory_region_init_alias(ram, NULL, "loongson3.lowmem",
> >>> +                           machine->ram, 0, virt_memmap[VIRT_LOWMEM]=
.size);
> >>> +    memory_region_init_io(iomem, NULL, &loongson3_pm_ops,
> >>> +                           NULL, "loongson3_pm", virt_memmap[VIRT_PM=
].size);
> >>> +
> >>> +    memory_region_add_subregion(address_space_mem,
> >>> +                      virt_memmap[VIRT_LOWMEM].base, ram);
> >>> +    memory_region_add_subregion(address_space_mem,
> >>> +                      virt_memmap[VIRT_BIOS_ROM].base, bios);
> >>> +    memory_region_add_subregion(address_space_mem,
> >>> +                      virt_memmap[VIRT_HIGHMEM].base, machine->ram);
> >>> +    memory_region_add_subregion(address_space_mem,
> >>> +                      virt_memmap[VIRT_PM].base, iomem);
> >>> +
> >>> +    /*
> >>> +     * We do not support flash operation, just loading bios.bin as r=
aw BIOS.
> >>> +     * Please use -L to set the BIOS path and -bios to set bios name=
.
> >>> +     */
> >>> +
> >>> +    if (kernel_filename) {
> >>> +        loaderparams.cpu_freq =3D get_cpu_freq();
> >>> +        loaderparams.ram_size =3D ram_size;
> >>> +        loaderparams.kernel_filename =3D kernel_filename;
> >>> +        loaderparams.kernel_cmdline =3D kernel_cmdline;
> >>> +        loaderparams.initrd_filename =3D initrd_filename;
> >>> +        loaderparams.kernel_entry =3D load_kernel(env);
> >>> +
> >>> +        init_boot_rom();
> >>> +        init_boot_param();
> >>> +    } else {
> >>> +        if (bios_name =3D=3D NULL) {
> >>> +                bios_name =3D LOONGSON3_BIOSNAME;
> >>> +        }
> >>> +        filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> >>> +        if (filename) {
> >>> +            bios_size =3D load_image_targphys(filename,
> >>> +                                            virt_memmap[VIRT_BIOS_RO=
M].base,
> >>> +                                            virt_memmap[VIRT_BIOS_RO=
M].size);
> >>> +            g_free(filename);
> >>> +        } else {
> >>> +            bios_size =3D -1;
> >>> +        }
> >>> +
> >>> +        if ((bios_size < 0 || bios_size > virt_memmap[VIRT_BIOS_ROM]=
.size) &&
> >>> +            !kernel_filename && !qtest_enabled()) {
> >>> +            error_report("Could not load MIPS bios '%s'", bios_name)=
;
> >>> +            exit(1);
> >>> +        }
> >>> +
> >>> +        fw_conf_init(ram_size);
> >>> +    }
> >>> +
> >>> +    msi_nonbroken =3D true;
> >>> +    loongson3_virt_devices_init(machine, liointc);
> >>> +
> >>> +    sysbus_create_simple("goldfish_rtc", virt_memmap[VIRT_RTC].base,
> >>> +                         qdev_get_gpio_in(liointc, RTC_IRQ));
> >>> +
> >>> +    serial_mm_init(address_space_mem, virt_memmap[VIRT_UART].base, 0=
,
> >>> +                   qdev_get_gpio_in(liointc, UART_IRQ), 115200, seri=
al_hd(0),
> >>> +                   DEVICE_NATIVE_ENDIAN);
> >>
> >> You need to split the SoC part from the machine part.
> > What do you mean? UART is SoC part and put it near LIOINTC?
>
> I understand the 3A4000 is a system-on-chip (SoC) with various
> peripherals (INTC, HT Bus, UART/SPI/I2C Ctrl, GPIO, Temp Sensors,
> DDR/ECC Ctrl, ...). Then the Godson-3 is the CPU unit,
> embedding the various GS464V cores.
>
> Maybe as:
>
>   +-------------------Machine-----------------+
>   |                                           |
>   | +--------------Loongson-3------------+    |
>   | |                                    |    |
>   | |  +------+Godson+3+----+  +----+    |    |
>   | |  |                    |  |TEMP|    |    |
>   | |  | +------+  +------+ |  +----+    |    |
>   | |  | |GS464V|  |GS464V| |            |    |
>   | |  | |=3D1vCPU|  |=3D1vCPU| |    +-------+    |
>   | |  | +------+  +------+ |    |       |    |
>   | |  |                    |    | GPIO  |    |
>   | |  | +------+  +------+ |    |       |    |
>   | |  | |GS464V|  |GS464V| |    +-------+    |
>   | |  | |=3D1vCPU|  |=3D1vCPU| |            |    |
>   | |  | +------+  +------+ |    +-------+    |
>   | |  |                    |    |       |    |
>   | |  +--------------------+    | LINTC |    |
>   | |                            |       |    |
>   | |                            +-------+    |
>   | |                                    |    |
>   | | +------+  +-----+  +-----+ +-----+ |    |
>   | | | UART |  | SPI |  | I2C | | ... | |    |
>   | +------------------------------------+    |
>   |                                           |
>   | +-------------+               +-------+   |
>   | |    DRAM     |               | FLASH |   |
>   | +-------------+               +-------+   |
>   +-------------------------------------------+
>
> QEMU tries to model each block as QOM.
>
> Anyway if you are happy with the current state,
> this can be improved later.
>
> >
> >>
> >>> +}
> >>> +
> >>> +static void mips_loongson3_virt_machine_init(MachineClass *mc)
> >>> +{
> >>> +    mc->desc =3D "Loongson-3 Virtualization Platform";
> >>> +    mc->init =3D mips_loongson3_virt_init;
> >>> +    mc->block_default_type =3D IF_IDE;
> >>
> >> Don't you need min_cpus =3D 4?
> > I think this is needn't.
>
> Well, you can not have a GS464V with 1 vCPU.
It is possible to boot a guest with 1 vCPU. :)

>
> >
> >>
> >>> +    mc->max_cpus =3D LOONGSON_MAX_VCPUS;
> >>> +    mc->default_ram_id =3D "loongson3.highram";
> >>> +    mc->default_ram_size =3D 1600 * MiB;
> >>> +    mc->kvm_type =3D mips_kvm_type;
> >>> +    mc->minimum_page_bits =3D 14;
> >>> +}
> >>> +
> >>> +DEFINE_MACHINE("loongson3-virt", mips_loongson3_virt_machine_init)
> >>> diff --git a/hw/mips/meson.build b/hw/mips/meson.build
> >>> index c98391c..72db43c 100644
> >>> --- a/hw/mips/meson.build
> >>> +++ b/hw/mips/meson.build
> >>> @@ -1,6 +1,7 @@
> >>>    mips_ss =3D ss.source_set()
> >>>    mips_ss.add(files('addr.c', 'mips_int.c', 'fw_cfg.c'))
> >>>    mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
> >>> +mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_boo=
tp.c', 'loongson3_virt.c'))
> >>>    mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
> >>>    mips_ss.add(when: 'CONFIG_MALTA', if_true: files('gt64xxx_pci.c', =
'malta.c'))
> >>>    mips_ss.add(when: 'CONFIG_MIPSSIM', if_true: files('mipssim.c'))
> >>>
> > Huacai
> >
Huacai

