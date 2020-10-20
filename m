Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93496C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943DD2225F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcyTDGPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943DD2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmfn-000474-Eh
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kUmew-0003gI-HN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:06:18 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:36376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1kUmer-0007Zn-Me
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 04:06:18 -0400
Received: by mail-io1-xd43.google.com with SMTP id u19so1849377ion.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 01:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DDInzBTDvg7OC8ag34hqmQ11vzrCUHrrixMuGvGyw5U=;
 b=TcyTDGPIFincc0mW58zAXvRip9FbvDKBpJDPFgmbJSdY7/Q7Kov+5eu/HHDyJ7pLRI
 8RBv0Tmr2BDQ18VzOOBNgLgb4/ohibzzFqAvMf8aQ7rgHoS0uw/vHmq5i6Ca5Vrx/sFV
 xlI8MMM2hpgBOXVnuy7YrlhG1acZt+6lRxm037AgNCeaI31ufH9zQ+ZS2Abo3t7PDGb4
 qmXy2SwuMwInpS68GtA7T/E9W0RTf/inz/P2igZEFheR7gu5I8iCA91F5H3YARs3JF6e
 pknM9oUpv8Q4NOp5Ob9x+HMtepjVsu0FThyvZaaQFvrD3E78U0kB1k6I7SakbX26sD0Y
 KPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DDInzBTDvg7OC8ag34hqmQ11vzrCUHrrixMuGvGyw5U=;
 b=S/PQaH49tpl5DbYmUWnm2/S6E3sqvsKWnXZ5sJhygdBOJnmNbLzxCJqtZi+OmySaqz
 ysWArk6Ype1boq0EObfSxH7MvxAr7uug0s8rd3HlFDill22QRf5aajwR2Q4PX9l2K7Kh
 Z25cPzpxiHqfw9C6zqX+tdUFPKHyfRm0mGgpIf1y0lwO4Nb/mU9lLAnD5kGOeMcLgewT
 aWISH/cqGRgckf8Ip/MIKyuMpOioK3lHEqoPaLnrHktlSPHr0IpJm2qushZ19aEi5P+r
 jAjEwfSXtiqz8F4t+7TslhyfX1dZAzzIY/UQbpfPivrtRleTqruxLQ04KflKZTsA0/yX
 ov2Q==
X-Gm-Message-State: AOAM530F8dGlby0NM/lTIKymBcgi5dsjz/2yKRaBx/PR4dpJXtS3HAhJ
 kavqdOsDb3KSs7v00XFqoArLwzb3yyXs16M0ZMI=
X-Google-Smtp-Source: ABdhPJwJpu69FHsnZ+nLcR/N2UM+I7UD36VucJXZB7033uk6Hqt74iN+iAylel6MaEZiaGjIFkcJAF+v+p6DuoYeSlk=
X-Received: by 2002:a02:7817:: with SMTP id p23mr1114769jac.57.1603181172279; 
 Tue, 20 Oct 2020 01:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
 <1602831120-3377-8-git-send-email-chenhc@lemote.com>
 <b84895fb-9425-eb1a-08ce-08b39575c12f@amsat.org>
In-Reply-To: <b84895fb-9425-eb1a-08ce-08b39575c12f@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Tue, 20 Oct 2020 16:05:58 +0800
Message-ID: <CAAhV-H5rp6t99Ux55vYk3O0eEiKvTE83Xnd3nxm9MOYX-uvMtQ@mail.gmail.com>
Subject: Re: [PATCH V14 7/8] hw/mips: Add Loongson-3 machine support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=chenhuacai@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Sat, Oct 17, 2020 at 11:58 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> On 10/16/20 8:51 AM, Huacai Chen wrote:
> > Add Loongson-3 based machine support, it use liointc as the interrupt
> > controler and use GPEX as the pci controller. Currently it can work wit=
h
> > both TCG and KVM.
> >
> > As the machine model is not based on any exiting physical hardware, the
> > name of the machine is "loongson3-virt". It may be superseded in future
> > by a real machine model. If this happens, then a regular deprecation
> > procedure shall occur for "loongson3-virt" machine.
> >
> > We now already have a full functional Linux kernel (based on Linux-5.4.=
x
> > LTS, the kvm host side and guest side have both been upstream for Linux=
-
> > 5.9, but Linux-5.9 has not been released yet) here:
> >
> > https://github.com/chenhuacai/linux
> >
> > Of course the upstream kernel is also usable (though it is "unstable"
> > now):
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >
> > How to use QEMU/Loongson-3?
> > 1, Download kernel source from the above URL;
> > 2, Build a kernel with arch/mips/configs/loongson3_defconfig;
> > 3, Boot a Loongson-3A4000 host with this kernel (for KVM mode);
> > 4, Build QEMU-master with this patchset;
> > 5, modprobe kvm (only necessary for KVM mode);
> > 6, Use QEMU with TCG:
> >         qemu-system-mips64el -M loongson3-virt,accel=3Dtcg -cpu Loongso=
n-3A1000 -kernel <path_to_kernel> -append ...
> >     Use QEMU with KVM:
> >         qemu-system-mips64el -M loongson3-virt,accel=3Dkvm -cpu Loongso=
n-3A4000 -kernel <path_to_kernel> -append ...
> >
> >     The "-cpu" parameter is optional here and QEMU will use the correct=
 type for TCG/KVM automatically.
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> >   default-configs/devices/mips64el-softmmu.mak |   1 +
> >   hw/mips/Kconfig                              |  12 +
> >   hw/mips/loongson3_virt.c                     | 615 ++++++++++++++++++=
+
> >   hw/mips/meson.build                          |   2 +-
> >   4 files changed, 629 insertions(+), 1 deletion(-)
> >   create mode 100644 hw/mips/loongson3_virt.c
> >
> > diff --git a/default-configs/devices/mips64el-softmmu.mak b/default-con=
figs/devices/mips64el-softmmu.mak
> > index 9f8a3ef156..26c660a05c 100644
> > --- a/default-configs/devices/mips64el-softmmu.mak
> > +++ b/default-configs/devices/mips64el-softmmu.mak
> > @@ -3,6 +3,7 @@
> >   include mips-softmmu-common.mak
> >   CONFIG_IDE_VIA=3Dy
> >   CONFIG_FULOONG=3Dy
> > +CONFIG_LOONGSON3V=3Dy
> >   CONFIG_ATI_VGA=3Dy
> >   CONFIG_RTL8139_PCI=3Dy
> >   CONFIG_JAZZ=3Dy
> > diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> > index 67d39c56a4..6562b346ab 100644
> > --- a/hw/mips/Kconfig
> > +++ b/hw/mips/Kconfig
> > @@ -45,6 +45,18 @@ config FULOONG
> >       bool
> >       select PCI_BONITO
> >
> > +config LOONGSON3V
> > +    bool
> > +    select PCKBD
> > +    select SERIAL
> > +    select GOLDFISH_RTC
> > +    select LOONGSON_LIOINTC
> > +    select PCI_DEVICES
> > +    select PCI_EXPRESS_GENERIC_BRIDGE
> > +    select VIRTIO_VGA
> > +    select QXL if SPICE
> > +    select MSI_NONBROKEN
> > +
> >   config MIPS_CPS
> >       bool
> >       select PTIMER
> > diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> > new file mode 100644
> > index 0000000000..c298a16793
> > --- /dev/null
> > +++ b/hw/mips/loongson3_virt.c
> > @@ -0,0 +1,627 @@
> > +/*
> > + * Generic Loongson-3 Platform support
> > + *
> > + * Copyright (c) 2017-2020 Huacai Chen (chenhc@lemote.com)
> > + * Copyright (c) 2017-2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program. If not, see <https://www.gnu.org/licenses/=
>.
> > + */
> > +
> > +/*
> > + * Generic virtualized PC Platform based on Loongson-3 CPU (MIPS64R2 w=
ith
> > + * extensions, 800~2000MHz)
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu-common.h"
> > +#include "qemu/units.h"
> > +#include "qemu/cutils.h"
> > +#include "qapi/error.h"
> > +#include "cpu.h"
> > +#include "elf.h"
> > +#include "kvm_mips.h"
> > +#include "hw/boards.h"
> > +#include "hw/char/serial.h"
> > +#include "hw/mips/mips.h"
> > +#include "hw/mips/cpudevs.h"
> > +#include "hw/mips/fw_cfg.h"
> > +#include "hw/mips/loongson3_bootp.h"
> > +#include "hw/misc/unimp.h"
> > +#include "hw/intc/i8259.h"
> > +#include "hw/loader.h"
> > +#include "hw/isa/superio.h"
> > +#include "hw/pci/msi.h"
> > +#include "hw/pci/pci.h"
> > +#include "hw/pci/pci_host.h"
> > +#include "hw/pci-host/gpex.h"
> > +#include "hw/rtc/mc146818rtc.h"
> > +#include "hw/usb.h"
> > +#include "net/net.h"
> > +#include "exec/address-spaces.h"
> > +#include "sysemu/kvm.h"
> > +#include "sysemu/qtest.h"
> > +#include "sysemu/reset.h"
> > +#include "sysemu/runstate.h"
> > +#include "qemu/log.h"
> > +#include "qemu/error-report.h"
> > +
> > +#define PM_CNTL_MODE          0x10
> > +
> > +#define LOONGSON_MAX_VCPUS      16
> > +
> > +/*
> > + * Loongson-3's virtual machine BIOS can be obtained here:
> > + * 1, https://github.com/loongson-community/firmware-nonfree
> > + * 2, http://dev.lemote.com:8000/files/firmware/UEFI/KVM/bios_loongson=
3.bin
>
> I'd simply list #2, as it seems the official.
Hmmm, let me remove all mirrors and list #1, #2. because there may be
some trouble to access #2 if you are not in China.

>
> The BIOS is extremly slow (eating 100% of a core) when trying
> to list the devices:
>
> Shell> devices
>       T   D
>       Y C I
>       P F A
> CTRL E G G #P #D #C  Device Name
> =3D=3D=3D=3D =3D =3D =3D =3D=3D =3D=3D =3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> [50sec here]
>    23 R - -  0  1   1
> VenHw(D3987D4B-971A-435F-8CAF-4967EB627241)/Uart(115200,8,N,1)
>    30 R - -  0  1   4 PciRoot(0x0)
>    36 D - -  1  0   0 Primary Console Input Device
>    37 D - -  2  0   0 Primary Console Output Device
>    38 D - -  1  0   0 Primary Standard Error Device
>    66 D - -  1  0   0 PciRoot(0x0)/Pci(0x0,0x0)
>    67 B - -  1  1   1 QEMU Video PCI Adapter
>    68 D - -  1  2   0 Usb Universal Host Controller
>    69 B - -  1  2   1 Virtio Network Device
>
> Is that a known issue?
Yes, it is, the virtual BIOS is a modified UEFI from real hardware, it
try to load many modules such as grub. In current implementation, TCG
has a poor performance if there are lots of memory access.

>
> > + * 3, http://www.anheng.com.cn/loongson/firmware-nonfree/uefi/loongson=
3-virt/bios_loongson3.bin
> > + * 4, http://mirrors.ustc.edu.cn/loongson/firmware-nonfree/uefi/loongs=
on3-virt/bios_loongson3.bin
> > + * 5, http://mirrors.nju.edu.cn/loongson/firmware-nonfree/uefi/loongso=
n3-virt/bios_loongson3.bin
> > + * 6, https://mirrors.tuna.tsinghua.edu.cn/loongson/firmware-nonfree/u=
efi/loongson3-virt/bios_loongson3.bin
> > + * 7, https://mirrors.bfsu.edu.cn/loongson/firmware-nonfree/uefi/loong=
son3-virt/bios_loongson3.bin
> > + * 8, https://mirrors.cloud.tencent.com/loongson/firmware-nonfree/uefi=
/loongson3-virt/bios_loongson3.bin
> > + */
> > +#define LOONGSON3_BIOSNAME "bios_loongson3.bin"
> > +
> > +#define UART_IRQ            0
> > +#define RTC_IRQ             1
> > +#define PCIE_IRQ_BASE       2
> > +
> > +const struct MemmapEntry virt_memmap[] =3D {
> > +    [VIRT_LOWMEM] =3D      { 0x00000000,    0x10000000 },
> > +    [VIRT_PM] =3D          { 0x10080000,         0x100 },
> > +    [VIRT_FW_CFG] =3D      { 0x10080100,         0x100 },
> > +    [VIRT_RTC] =3D         { 0x10081000,        0x1000 },
> > +    [VIRT_PCIE_PIO] =3D    { 0x18000000,       0x80000 },
> > +    [VIRT_PCIE_ECAM] =3D   { 0x1a000000,     0x2000000 },
> > +    [VIRT_BIOS_ROM] =3D    { 0x1fc00000,      0x200000 },
> > +    [VIRT_UART] =3D        { 0x1fe001e0,           0x8 },
> > +    [VIRT_LIOINTC] =3D     { 0x3ff01400,          0x64 },
> > +    [VIRT_PCIE_MMIO] =3D   { 0x40000000,    0x40000000 },
> > +    [VIRT_HIGHMEM] =3D     { 0x80000000,           0x0 }, /* Variable =
*/
> > +};
> > +
> > +static const struct MemmapEntry loader_memmap[] =3D {
> > +    [LOADER_KERNEL] =3D    { 0x00000000,     0x4000000 },
> > +    [LOADER_INITRD] =3D    { 0x04000000,           0x0 }, /* Variable =
*/
> > +    [LOADER_CMDLINE] =3D   { 0x0ff00000,      0x100000 },
> > +};
> > +
> > +static const struct MemmapEntry loader_rommap[] =3D {
> > +    [LOADER_BOOTROM] =3D   { 0x1fc00000,        0x1000 },
> > +    [LOADER_PARAM] =3D     { 0x1fc01000,       0x10000 },
> > +};
> > +
> > +static struct _loaderparams {
> > +    uint64_t cpu_freq;
> > +    uint64_t ram_size;
> > +    const char *kernel_cmdline;
> > +    const char *kernel_filename;
> > +    const char *initrd_filename;
> > +    uint64_t kernel_entry;
> > +    uint64_t a0, a1, a2;
> > +} loaderparams;
> > +
> > +static uint64_t loongson3_pm_read(void *opaque, hwaddr addr, unsigned =
size)
> > +{
> > +    return 0;
> > +}
> > +
> > +static void loongson3_pm_write(void *opaque, hwaddr addr, uint64_t val=
, unsigned size)
> > +{
> > +    if (addr !=3D PM_CNTL_MODE) {
> > +        return;
> > +    }
> > +
> > +    switch (val) {
> > +    case 0x00:
> > +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> > +        return;
> > +    case 0xff:
> > +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > +        return;
> > +    default:
> > +        return;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps loongson3_pm_ops =3D {
> > +    .read  =3D loongson3_pm_read,
> > +    .write =3D loongson3_pm_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +};
> > +
> > +#define DEF_TCG_FREQ (200 * 1000 * 1000)
> > +#define DEF_KVM_FREQ (1600 * 1000 * 1000)
> > +
> > +static uint64_t get_cpu_freq(void)
>
> Please rename get_cpu_freq_hz().
OK.

>
> > +{
> > +#ifdef CONFIG_KVM
> > +    int ret;
> > +    uint64_t freq;
> > +    struct kvm_one_reg freq_reg =3D {
> > +        .id =3D KVM_REG_MIPS_COUNT_HZ,
> > +        .addr =3D (uintptr_t)(&freq)
> > +    };
> > +
> > +    if (kvm_enabled()) {
>
> This is not working as expected... as this returns TRUE
> using TCG on x86.
I will improve this, as you listed below.

>
> > +        ret =3D kvm_vcpu_ioctl(first_cpu, KVM_GET_ONE_REG, &freq_reg);
> > +        if (ret < 0) {
> > +            return DEF_KVM_FREQ;
> > +        }
> > +        return freq * 2;
> > +    } else {
> > +        /*
> > +         * TCG has a default CP0 Timer period 10 ns, which is 100MHz,
> > +         * CPU frequency is defined as double of CP0 timer frequency.
> > +         */
> > +        return DEF_TCG_FREQ;
> > +    }
> > +#else
> > +    return DEF_TCG_FREQ;
> > +#endif
> > +}
> > +
> > +static void init_boot_param(void)
> > +{
> > +    void *p;
> > +    struct boot_params *bp;
> > +
> > +    p =3D g_malloc0(loader_rommap[LOADER_PARAM].size);
> > +    bp =3D p;
> > +
> > +    stw_le_p(&bp->efi.smbios.vers, 1);
> > +    init_reset_system(&(bp->reset_system));
> > +    p +=3D ROUND_UP(sizeof(struct boot_params), 64);
> > +    init_loongson_params(&(bp->efi.smbios.lp), p,
> > +                         loaderparams.cpu_freq, loaderparams.ram_size)=
;
> > +
> > +    rom_add_blob_fixed("params_rom", bp,
> > +                       loader_rommap[LOADER_PARAM].size,
> > +                       loader_rommap[LOADER_PARAM].base);
> > +
> > +    g_free(bp);
> > +
> > +    loaderparams.a2 =3D cpu_mips_phys_to_kseg0(NULL, loader_rommap[LOA=
DER_PARAM].base);
> > +}
> > +
> > +static void init_boot_rom(void)
> > +{
> > +    const unsigned int boot_code[] =3D {
> > +        0x40086000,   /* mfc0    t0, CP0_STATUS                       =
        */
> > +        0x240900E4,   /* li      t1, 0xe4         #set kx, sx, ux, erl=
        */
> > +        0x01094025,   /* or      t0, t0, t1                           =
        */
> > +        0x3C090040,   /* lui     t1, 0x40         #set bev            =
        */
> > +        0x01094025,   /* or      t0, t0, t1                           =
        */
> > +        0x40886000,   /* mtc0    t0, CP0_STATUS                       =
        */
> > +        0x00000000,
> > +        0x40806800,   /* mtc0    zero, CP0_CAUSE                      =
        */
> > +        0x00000000,
> > +        0x400A7801,   /* mfc0    t2, $15, 1                           =
        */
> > +        0x314A00FF,   /* andi    t2, 0x0ff                            =
        */
> > +        0x3C089000,   /* dli     t0, 0x900000003ff01000               =
        */
> > +        0x00084438,
> > +        0x35083FF0,
> > +        0x00084438,
> > +        0x35081000,
> > +        0x314B0003,   /* andi    t3, t2, 0x3      #local cpuid        =
        */
> > +        0x000B5A00,   /* sll     t3, 8                                =
        */
> > +        0x010B4025,   /* or      t0, t0, t3                           =
        */
> > +        0x314C000C,   /* andi    t4, t2, 0xc      #node id            =
        */
> > +        0x000C62BC,   /* dsll    t4, 42                               =
        */
> > +        0x010C4025,   /* or      t0, t0, t4                           =
        */
> > +                      /* WaitForInit:                                 =
        */
> > +        0xDD020020,   /* ld      v0, FN_OFF(t0)   #FN_OFF 0x020       =
        */
> > +        0x1040FFFE,   /* beqz    v0, WaitForInit                      =
        */
> > +        0x00000000,   /* nop                                          =
        */
> > +        0xDD1D0028,   /* ld      sp, SP_OFF(t0)   #FN_OFF 0x028       =
        */
> > +        0xDD1C0030,   /* ld      gp, GP_OFF(t0)   #FN_OFF 0x030       =
        */
> > +        0xDD050038,   /* ld      a1, A1_OFF(t0)   #FN_OFF 0x038       =
        */
> > +        0x00400008,   /* jr      v0               #byebye             =
        */
> > +        0x00000000,   /* nop                                          =
        */
> > +        0x1000FFFF,   /* 1:  b   1b                                   =
        */
> > +        0x00000000,   /* nop                                          =
        */
> > +
> > +                      /* Reset                                        =
        */
> > +        0x3C0C9000,   /* dli     t0, 0x9000000010080010               =
        */
> > +        0x358C0000,
> > +        0x000C6438,
> > +        0x358C1008,
> > +        0x000C6438,
> > +        0x358C0010,
> > +        0x240D0000,   /* li      t1, 0x00                             =
        */
> > +        0xA18D0000,   /* sb      t1, (t0)                             =
        */
> > +        0x1000FFFF,   /* 1:  b   1b                                   =
        */
> > +        0x00000000,   /* nop                                          =
        */
> > +
> > +                      /* Shutdown                                     =
        */
> > +        0x3C0C9000,   /* dli     t0, 0x9000000010080010               =
        */
> > +        0x358C0000,
> > +        0x000C6438,
> > +        0x358C1008,
> > +        0x000C6438,
> > +        0x358C0010,
> > +        0x240D00FF,   /* li      t1, 0xff                             =
        */
> > +        0xA18D0000,   /* sb      t1, (t0)                             =
        */
> > +        0x1000FFFF,   /* 1:  b   1b                                   =
        */
> > +        0x00000000    /* nop                                          =
        */
> > +    };
> > +
> > +    rom_add_blob_fixed("boot_rom", boot_code, sizeof(boot_code),
> > +                        loader_rommap[LOADER_BOOTROM].base);
> > +}
> > +
> > +static void fw_cfg_boot_set(void *opaque, const char *boot_device,
> > +                            Error **errp)
> > +{
> > +    fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
> > +}
> > +
> > +static void fw_conf_init(unsigned long ram_size)
> > +{
> > +    FWCfgState *fw_cfg;
> > +    hwaddr cfg_addr =3D virt_memmap[VIRT_FW_CFG].base;
> > +
> > +    fw_cfg =3D fw_cfg_init_mem_wide(cfg_addr, cfg_addr + 8, 8, 0, NULL=
);
> > +    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)current_machine->=
smp.cpus);
> > +    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_machine-=
>smp.max_cpus);
> > +    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
> > +    fw_cfg_add_i32(fw_cfg, FW_CFG_MACHINE_VERSION, 1);
> > +    fw_cfg_add_i64(fw_cfg, FW_CFG_CPU_FREQ, get_cpu_freq());
> > +    qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
> > +}
> > +
> > +static int set_prom_cmdline(ram_addr_t initrd_offset, long initrd_size=
)
> > +{
> > +    hwaddr cmdline_vaddr;
> > +    char memenv[32];
> > +    char highmemenv[32];
> > +    void *cmdline_buf;
> > +    unsigned int *parg_env;
> > +    int ret =3D 0;
> > +
> > +    /* Allocate cmdline_buf for command line. */
> > +    cmdline_buf =3D g_malloc0(loader_memmap[LOADER_CMDLINE].size);
> > +    cmdline_vaddr =3D cpu_mips_phys_to_kseg0(NULL,
> > +                                           loader_memmap[LOADER_CMDLIN=
E].base);
> > +
> > +    /*
> > +     * Layout of cmdline_buf looks like this:
> > +     * argv[0], argv[1], 0, env[0], env[1], ... env[i], 0,
> > +     * argv[0]'s data, argv[1]'s data, env[0]'data, ..., env[i]'s data=
, 0
> > +     */
> > +    parg_env =3D (void *)cmdline_buf;
> > +
> > +    ret =3D (3 + 1) * 4;
> > +    *parg_env++ =3D cmdline_vaddr + ret;
> > +    ret +=3D (1 + snprintf(cmdline_buf + ret, 256 - ret, "g"));
> > +
> > +    /* argv1 */
> > +    *parg_env++ =3D cmdline_vaddr + ret;
> > +    if (initrd_size > 0)
> > +        ret +=3D (1 + snprintf(cmdline_buf + ret, 256 - ret,
> > +                "rd_start=3D0x" TARGET_FMT_lx " rd_size=3D%li %s",
> > +                cpu_mips_phys_to_kseg0(NULL, initrd_offset),
> > +                initrd_size, loaderparams.kernel_cmdline));
> > +    else
> > +        ret +=3D (1 + snprintf(cmdline_buf + ret, 256 - ret, "%s",
> > +                loaderparams.kernel_cmdline));
> > +
> > +    /* argv2 */
> > +    *parg_env++ =3D cmdline_vaddr + 4 * ret;
> > +
> > +    /* env */
> > +    sprintf(memenv, "%d", 256);
> > +    sprintf(highmemenv, "%ld", (unsigned long)(loaderparams.ram_size /=
 MiB) - 256);
> > +
> > +    rom_add_blob_fixed("cmdline", cmdline_buf,
> > +                       loader_memmap[LOADER_CMDLINE].size,
> > +                       loader_memmap[LOADER_CMDLINE].base);
> > +
> > +    g_free(cmdline_buf);
> > +
> > +    loaderparams.a0 =3D 2;
> > +    loaderparams.a1 =3D cmdline_vaddr;
> > +
> > +    return 0;
> > +}
> > +
> > +static uint64_t load_kernel(CPUMIPSState *env)
> > +{
> > +    long kernel_size;
> > +    ram_addr_t initrd_offset;
> > +    uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;
> > +
> > +    kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
> > +                           cpu_mips_kseg0_to_phys, NULL,
> > +                           (uint64_t *)&kernel_entry,
> > +                           (uint64_t *)&kernel_low, (uint64_t *)&kerne=
l_high,
> > +                           NULL, 0, EM_MIPS, 1, 0);
> > +    if (kernel_size < 0) {
> > +        error_report("could not load kernel '%s': %s",
> > +                     loaderparams.kernel_filename,
> > +                     load_elf_strerror(kernel_size));
> > +        exit(1);
> > +    }
> > +
> > +    /* load initrd */
> > +    initrd_size =3D 0;
> > +    initrd_offset =3D 0;
> > +    if (loaderparams.initrd_filename) {
> > +        initrd_size =3D get_image_size(loaderparams.initrd_filename);
> > +        if (initrd_size > 0) {
> > +            initrd_offset =3D (kernel_high + ~INITRD_PAGE_MASK) &
> > +                            INITRD_PAGE_MASK;
> > +            initrd_offset =3D MAX(initrd_offset,
> > +                                loader_memmap[LOADER_INITRD].base);
>
> Now you can use directly:
>
>             initrd_offset =3D MAX(ROUND_UP(kernel_high, INITRD_PAGE_SIZE)=
,
>                                 loader_memmap[LOADER_INITRD].base);
>
OK.

> > +
> > +            if (initrd_offset + initrd_size > ram_size) {
> > +                error_report("memory too small for initial ram disk '%=
s'",
> > +                             loaderparams.initrd_filename);
> > +                exit(1);
> > +            }
> > +
> > +            initrd_size =3D load_image_targphys(loaderparams.initrd_fi=
lename,
> > +                                              initrd_offset,
> > +                                              ram_size - initrd_offset=
);
> > +        }
> > +
> > +        if (initrd_size =3D=3D (target_ulong) -1) {
> > +            error_report("could not load initial ram disk '%s'",
> > +                         loaderparams.initrd_filename);
> > +            exit(1);
> > +        }
> > +    }
> > +
> > +    /* Setup prom cmdline. */
> > +    set_prom_cmdline(initrd_offset, initrd_size);
> > +
> > +    return kernel_entry;
> > +}
> > +
> > +static void main_cpu_reset(void *opaque)
> > +{
> > +    MIPSCPU *cpu =3D opaque;
> > +    CPUMIPSState *env =3D &cpu->env;
> > +
> > +    cpu_reset(CPU(cpu));
> > +
> > +    /* Loongson-3 reset stuff */
> > +    if (loaderparams.kernel_filename) {
> > +        if (cpu =3D=3D MIPS_CPU(first_cpu)) {
> > +            env->active_tc.gpr[4] =3D loaderparams.a0;
> > +            env->active_tc.gpr[5] =3D loaderparams.a1;
> > +            env->active_tc.gpr[6] =3D loaderparams.a2;
> > +            env->active_tc.PC =3D loaderparams.kernel_entry;
> > +        }
> > +        env->CP0_Status &=3D ~((1 << CP0St_BEV) | (1 << CP0St_ERL));
> > +    }
> > +}
> > +
> > +static inline void loongson3_virt_devices_init(MachineState *machine, =
DeviceState *pic)
> > +{
> > +    int i;
> > +    qemu_irq irq;
> > +    PCIBus *pci_bus;
> > +    DeviceState *dev;
> > +    MemoryRegion *pio_alias;
> > +    MemoryRegion *mmio_alias, *mmio_reg;
> > +    MemoryRegion *ecam_alias, *ecam_reg;
> > +
> > +    dev =3D qdev_new(TYPE_GPEX_HOST);
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> > +    pci_bus =3D PCI_HOST_BRIDGE(dev)->bus;
> > +
> > +    ecam_alias =3D g_new0(MemoryRegion, 1);
> > +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> > +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> > +                             ecam_reg, 0, virt_memmap[VIRT_PCIE_ECAM].=
size);
> > +    memory_region_add_subregion(get_system_memory(),
> > +                                virt_memmap[VIRT_PCIE_ECAM].base, ecam=
_alias);
> > +
> > +    mmio_alias =3D g_new0(MemoryRegion, 1);
> > +    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> > +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> > +                             mmio_reg, virt_memmap[VIRT_PCIE_MMIO].bas=
e,
> > +                             virt_memmap[VIRT_PCIE_MMIO].size);
> > +    memory_region_add_subregion(get_system_memory(),
> > +                                virt_memmap[VIRT_PCIE_MMIO].base, mmio=
_alias);
> > +
> > +    pio_alias =3D g_new0(MemoryRegion, 1);
> > +    memory_region_init_alias(pio_alias, OBJECT(dev), "pcie-pio",
> > +                             get_system_io(), 0, virt_memmap[VIRT_PCIE=
_PIO].size);
> > +    memory_region_add_subregion(get_system_memory(),
> > +                                virt_memmap[VIRT_PCIE_PIO].base, pio_a=
lias);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, virt_memmap[VIRT_PCIE_PIO]=
.base);
> > +
> > +    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> > +        irq =3D qdev_get_gpio_in(pic, PCIE_IRQ_BASE + i);
> > +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> > +        gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ_BASE + i);
> > +    }
> > +
> > +    pci_vga_init(pci_bus);
> > +
> > +    if (defaults_enabled()) {
> > +        pci_create_simple(pci_bus, -1, "pci-ohci");
> > +        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> > +        usb_create_simple(usb_bus_find(-1), "usb-tablet");
> > +    }
> > +
> > +    for (i =3D 0; i < nb_nics; i++) {
> > +        NICInfo *nd =3D &nd_table[i];
> > +
> > +        if (!nd->model) {
> > +            nd->model =3D g_strdup("virtio");
> > +        }
> > +
> > +        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
> > +    }
> > +}
> > +
> > +static void mips_loongson3_virt_init(MachineState *machine)
> > +{
> > +    int i;
> > +    long bios_size;
> > +    MIPSCPU *cpu;
> > +    CPUMIPSState *env;
> > +    DeviceState *liointc;
> > +    char *filename;
> > +    const char *kernel_cmdline =3D machine->kernel_cmdline;
> > +    const char *kernel_filename =3D machine->kernel_filename;
> > +    const char *initrd_filename =3D machine->initrd_filename;
> > +    ram_addr_t ram_size =3D machine->ram_size;
> > +    MemoryRegion *address_space_mem =3D get_system_memory();
> > +    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> > +    MemoryRegion *bios =3D g_new(MemoryRegion, 1);
> > +    MemoryRegion *iomem =3D g_new(MemoryRegion, 1);
> > +
> > +    /* TODO: TCG will support all CPU types */
> > +    if (!kvm_enabled()) {
> > +        if (!machine->cpu_type) {
> > +            machine->cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-3A1000"=
);
> > +        }
> > +        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
> > +            error_report("Loongson-3/TCG needs cpu type Loongson-3A100=
0");
> > +            exit(1);
> > +        }
> > +    } else {
> > +        if (!machine->cpu_type) {
> > +            machine->cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-3A4000"=
);
> > +        }
> > +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
> > +            error_report("Loongson-3/KVM needs cpu type Loongson-3A400=
0");
> > +            exit(1);
> > +        }
> > +    }
> > +
> > +    if (ram_size < 512 * MiB) {
> > +        error_report("Loongson-3 machine needs at least 512MB memory")=
;
> > +        exit(1);
> > +    }
> > +
> > +    /*
> > +     * The whole MMIO range among configure registers doesn't generate
> > +     * exception when accessing invalid memory. Create some unimplemem=
ted
> > +     * devices to emulate this feature.
> > +     */
> > +    create_unimplemented_device("mmio fallback 0", 0x10000000, 256 * M=
iB);
> > +    create_unimplemented_device("mmio fallback 1", 0x30000000, 256 * M=
iB);
>
> The problem using large container to ignore accesses is we have
> no idea what the firmware is trying to do:
>
> mmio fallback 1: unimplemented device write (size 8, offset 0xff01038,
> value 0x980000000e3d1000)
> mmio fallback 1: unimplemented device write (size 8, offset 0xff01020,
> value 0x980000000e720ef8)
We can compute these addresses and find it in Loongson's documents,
this is also need to do for small regions.
And, the address caught by UNIMP devices are always "useless"
addresses for a virtual machine (because useful addresses are catched
by implemented devices).

>
> > +
> > +    liointc =3D qdev_new("loongson.liointc");
> > +    sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
> > +
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(liointc), 0, virt_memmap[VIRT_LIOIN=
TC].base);
> > +
> > +    serial_mm_init(address_space_mem, virt_memmap[VIRT_UART].base, 0,
> > +                   qdev_get_gpio_in(liointc, UART_IRQ), 115200, serial=
_hd(0),
> > +                   DEVICE_NATIVE_ENDIAN);
> > +
> > +    sysbus_create_simple("goldfish_rtc", virt_memmap[VIRT_RTC].base,
> > +                         qdev_get_gpio_in(liointc, RTC_IRQ));
> > +
> > +    for (i =3D 0; i < machine->smp.cpus; i++) {
> > +        int ip;
> > +
> > +        /* init CPUs */
> > +        cpu =3D MIPS_CPU(cpu_create(machine->cpu_type));
> > +
> > +        /* Init internal devices */
> > +        cpu_mips_irq_init_cpu(cpu);
> > +        cpu_mips_clock_init(cpu);
> > +        qemu_register_reset(main_cpu_reset, cpu);
> > +
> > +        if (i >=3D 4) {
> > +            continue; /* Only node-0 can be connected to LIOINTC */
> > +        }
> > +
> > +        for (ip =3D 0; ip < 4 ; ip++) {
> > +            int pin =3D i * 4 + ip;
> > +            sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
> > +                               pin, cpu->env.irq[ip + 2]);
> > +        }
> > +    }
> > +    env =3D &MIPS_CPU(first_cpu)->env;
> > +
> > +    /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x80000000=
~0x90000000 */
> > +    memory_region_init_rom(bios, NULL, "loongson3.bios",
> > +                           virt_memmap[VIRT_BIOS_ROM].size, &error_fat=
al);
> > +    memory_region_init_alias(ram, NULL, "loongson3.lowmem",
> > +                           machine->ram, 0, virt_memmap[VIRT_LOWMEM].s=
ize);
> > +    memory_region_init_io(iomem, NULL, &loongson3_pm_ops,
> > +                           NULL, "loongson3_pm", virt_memmap[VIRT_PM].=
size);
> > +
> > +    memory_region_add_subregion(address_space_mem,
> > +                      virt_memmap[VIRT_LOWMEM].base, ram);
> > +    memory_region_add_subregion(address_space_mem,
> > +                      virt_memmap[VIRT_BIOS_ROM].base, bios);
> > +    memory_region_add_subregion(address_space_mem,
> > +                      virt_memmap[VIRT_HIGHMEM].base, machine->ram);
> > +    memory_region_add_subregion(address_space_mem,
> > +                      virt_memmap[VIRT_PM].base, iomem);
> > +
> > +    /*
> > +     * We do not support flash operation, just loading bios.bin as raw=
 BIOS.
> > +     * Please use -L to set the BIOS path and -bios to set bios name.
> > +     */
> > +
> > +    if (kernel_filename) {
> > +        loaderparams.cpu_freq =3D get_cpu_freq();
> > +        loaderparams.ram_size =3D ram_size;
> > +        loaderparams.kernel_filename =3D kernel_filename;
> > +        loaderparams.kernel_cmdline =3D kernel_cmdline;
> > +        loaderparams.initrd_filename =3D initrd_filename;
> > +        loaderparams.kernel_entry =3D load_kernel(env);
> > +
> > +        init_boot_rom();
> > +        init_boot_param();
> > +    } else {
> > +        if (bios_name =3D=3D NULL) {
> > +                bios_name =3D LOONGSON3_BIOSNAME;
> > +        }
> > +        filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> > +        if (filename) {
> > +            bios_size =3D load_image_targphys(filename,
> > +                                            virt_memmap[VIRT_BIOS_ROM]=
.base,
> > +                                            virt_memmap[VIRT_BIOS_ROM]=
.size);
> > +            g_free(filename);
> > +        } else {
> > +            bios_size =3D -1;
> > +        }
> > +
> > +        if ((bios_size < 0 || bios_size > virt_memmap[VIRT_BIOS_ROM].s=
ize) &&
> > +            !kernel_filename && !qtest_enabled()) {
> > +            error_report("Could not load MIPS bios '%s'", bios_name);
> > +            exit(1);
> > +        }
> > +
> > +        fw_conf_init(ram_size);
> > +    }
> > +
> > +    msi_nonbroken =3D true;
> > +    loongson3_virt_devices_init(machine, liointc);
> > +}
> > +
> > +static void mips_loongson3_virt_machine_init(MachineClass *mc)
> > +{
> > +    mc->desc =3D "Loongson-3 Virtualization Platform";
> > +    mc->init =3D mips_loongson3_virt_init;
> > +    mc->block_default_type =3D IF_IDE;
> > +    mc->max_cpus =3D LOONGSON_MAX_VCPUS;
> > +    mc->default_ram_id =3D "loongson3.highram";
> > +    mc->default_ram_size =3D 1600 * MiB;
> > +    mc->kvm_type =3D mips_kvm_type;
> > +    mc->minimum_page_bits =3D 14;
> > +}
>
> I tested on top of mips-next using:
>
> -- >8 --
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index 6a42808015d..2f1fa2e72ea 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -31,6 +31,7 @@
>   #include "cpu.h"
>   #include "elf.h"
>   #include "kvm_mips.h"
> +#include "hw/clock.h"
>   #include "hw/boards.h"
>   #include "hw/char/serial.h"
>   #include "hw/mips/mips.h"
> @@ -141,9 +142,6 @@ static const MemoryRegionOps loongson3_pm_ops =3D {
>       .endianness =3D DEVICE_NATIVE_ENDIAN,
>   };
>
> -#define DEF_TCG_FREQ (200 * 1000 * 1000)
> -#define DEF_KVM_FREQ (1600 * 1000 * 1000)
> -
>   static uint64_t get_cpu_freq(void)
>   {
>   #ifdef CONFIG_KVM
> @@ -156,20 +154,12 @@ static uint64_t get_cpu_freq(void)
>
>       if (kvm_enabled()) {
>           ret =3D kvm_vcpu_ioctl(first_cpu, KVM_GET_ONE_REG, &freq_reg);
> -        if (ret < 0) {
> -            return DEF_KVM_FREQ;
> +        if (ret >=3D 0) {
> +            return freq * 2;
>           }
> -        return freq * 2;
> -    } else {
> -        /*
> -         * TCG has a default CP0 Timer period 10 ns, which is 100MHz,
> -         * CPU frequency is defined as double of CP0 timer frequency.
> -         */
> -        return DEF_TCG_FREQ;
>       }
> -#else
> -    return DEF_TCG_FREQ;
>   #endif
> +    return 1600 * 1000 * 1000;
>   }
>
>   static void init_boot_param(void)
> @@ -471,6 +461,7 @@ static void mips_loongson3_virt_init(MachineState
> *machine)
>   {
>       int i;
>       long bios_size;
> +    Clock *cpuclk;
>       MIPSCPU *cpu;
>       CPUMIPSState *env;
>       DeviceState *liointc;
> @@ -528,11 +519,14 @@ static void mips_loongson3_virt_init(MachineState
> *machine)
>       sysbus_create_simple("goldfish_rtc", virt_memmap[VIRT_RTC].base,
>                            qdev_get_gpio_in(liointc, RTC_IRQ));
>
> +    cpuclk =3D clock_new(OBJECT(machine), "cpu-refclk");
> +    clock_set_hz(cpuclk, get_cpu_freq());
> +
>       for (i =3D 0; i < machine->smp.cpus; i++) {
>           int ip;
>
>           /* init CPUs */
> -        cpu =3D MIPS_CPU(cpu_create(machine->cpu_type));
> +        cpu =3D mips_cpu_create_with_clock(machine->cpu_type, cpuclk);
>
>           /* Init internal devices */
>           cpu_mips_irq_init_cpu(cpu);
> ---

Huacai

