Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D3EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF8320707
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De63d6LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF8320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnjGa-0002b7-Kn
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 09:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnjFo-0002Al-FV
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:46:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jnjFj-0007Pq-5x
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:46:24 -0400
Received: by mail-wr1-x444.google.com with SMTP id v3so13109611wrc.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=89DZslDMsdDmZd79Rr3MJCWiDPqf+lDXmKHiJCnlZDA=;
 b=De63d6LXvlHUsPXsHi/uZZA4W44fIjDhZ31xWd4ixXoXQ/0weAamJFPiPM4TL1FUd0
 9mXtUFJSXP3Jr3IyQnGc/G21goyVMAyXwiruA5lCgdgqFkPaeecJpKyxvoqWCJmwz2oX
 XyN/j8/M18L76BouTue6g3X4VjUc2ifA+JVtYYeaNqevGJSMfhA+gVC+32f+gXTCkA1b
 sdNwLShmj/w7wnRqK7TVa9kcPeh0TMDthRFS8sk5jVtfUPUFmWfBESCuS75Rzr25wDRE
 EX3yvaZ5KiXebedDDm62SPQB9PNSF5sm9BYZPbW8kdpl8ZbP1pMkXJe4jm9yPJ1rHpW6
 /YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=89DZslDMsdDmZd79Rr3MJCWiDPqf+lDXmKHiJCnlZDA=;
 b=V/zn0ixVHNjNKogsXlnKbAKJxOKNvhINv3u791coH/JtyDNoLS1zKh8grVE7Spwd35
 k1j7awT+TGMADI//wC4HSLmb/4+iwHZEAQDSJnhId1oKrGGaD8D91D8OurdeciLteSr/
 an9/E/xpgsg3vRMEYEPyxNu0PJ5o8x4GVXfA5MbGPONHLURzEsAS46zSUiDxf7b9PAT6
 cksZJLhzcZZ1nONSDWx/qIuaRQNXc/S5AwCm8FKWyYTMMSY9n4S628JWd9cNHRVCurg2
 2c0qt0KNn59TR5zjua0xsYbFKwIPwLpPa8fAc3SnvGzPuaMZmxjUvaFIxf1qHjpOV4IK
 7NLA==
X-Gm-Message-State: AOAM531t61mJxl6r3QfV0qVurCuazNjMfAKFO9MV+tyt35eSCYT812lv
 fkMH/Kc+xPSh5ZhTpPQ2l2J+We1NsnDjbVEN3m0=
X-Google-Smtp-Source: ABdhPJwXEg0w4QXBDA0eGFkiXyVURseI+JXubKIZRxLwv9ckHdx0IyNPNIrKTSgK0VUQDxeBuKohsiX/6pn9RQfmyzA=
X-Received: by 2002:adf:e287:: with SMTP id v7mr21691491wri.329.1592919977234; 
 Tue, 23 Jun 2020 06:46:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a7b:c0d7:0:0:0:0:0 with HTTP; Tue, 23 Jun 2020 06:46:16
 -0700 (PDT)
In-Reply-To: <1592914438-30317-4-git-send-email-chenhc@lemote.com>
References: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
 <1592914438-30317-4-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 23 Jun 2020 15:46:16 +0200
Message-ID: <CAHiYmc7FVCu6WTyFfUdz84iBYaL9QtrQ+Mv_nFU6KzzCWbnz=Q@mail.gmail.com>
Subject: Re: [PATCH for-5.1 V5 3/4] hw/mips: Add Loongson-3 machine support
 (with KVM)
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000066141505a8c0951a"
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000066141505a8c0951a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 23. =D1=98=D1=83=D0=BD 2020., Huacai =
Chen <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:

> Add Loongson-3 based machine support, it use i8259 as the interrupt
> controler


>
8259 or LIOINTC?


>
>
> and use GPEX as the pci controller. Currently it can only

work with KVM, but we will add TCG support in future.
>
> As the machine model is not based on any exiting physical hardware, the
> name of the machine is "loongson3-virt". It may be superseded in future
> by a real machine model. If this happens, then a regular deprecation
> procedure shall occur for "loongson3-virt" machine.
>
> We already have a full functional Linux kernel (based on Linux-5.4.x LTS
> but not upstream yet) here:
>
> https://github.com/chenhuacai/linux
>
> How to use QEMU/Loongson-3?
> 1, Download kernel source from the above URL;
> 2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
> 3, Boot the a Loongson-3A4000 host with this kernel;
> 4, Build QEMU-master with this patchset;
> 5, modprobe kvm;
> 6, Use QEMU with TCG (available in future):
>        qemu-system-mips64el -M loongson3-virt,accel=3Dtcg -cpu
> Loongson-3A1000 -kernel <path_to_kernel> -append ...


Hello, Huacai.

Thanks for the new version.

What exacrly is missing in tcg support? Would it work if Loongson EXT is
supported in QEMU?

Warmly,
Aleksandar




>    Use QEMU with KVM (available at present):
>        qemu-system-mips64el -M loongson3-virt,accel=3Dkvm -cpu
> Loongson-3A4000 -kernel <path_to_kernel> -append ...
>
>    The "-cpu" parameter is optional here and QEMU will use the correct
> type for TCG/KVM automatically.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  default-configs/mips64el-softmmu.mak |   1 +
>  hw/mips/Kconfig                      |  11 +
>  hw/mips/Makefile.objs                |   1 +
>  hw/mips/loongson3_virt.c             | 969 +++++++++++++++++++++++++++++=
+
> +++++
>  4 files changed, 982 insertions(+)
>  create mode 100644 hw/mips/loongson3_virt.c
>
> diff --git a/default-configs/mips64el-softmmu.mak
> b/default-configs/mips64el-softmmu.mak
> index 9f8a3ef..26c660a 100644
> --- a/default-configs/mips64el-softmmu.mak
> +++ b/default-configs/mips64el-softmmu.mak
> @@ -3,6 +3,7 @@
>  include mips-softmmu-common.mak
>  CONFIG_IDE_VIA=3Dy
>  CONFIG_FULOONG=3Dy
> +CONFIG_LOONGSON3V=3Dy
>  CONFIG_ATI_VGA=3Dy
>  CONFIG_RTL8139_PCI=3Dy
>  CONFIG_JAZZ=3Dy
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index 67d39c5..cc5609b 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -45,6 +45,17 @@ config FULOONG
>      bool
>      select PCI_BONITO
>
> +config LOONGSON3V
> +    bool
> +    select PCKBD
> +    select SERIAL
> +    select GOLDFISH_RTC
> +    select LOONGSON_LIOINTC
> +    select PCI_EXPRESS_GENERIC_BRIDGE
> +    select VIRTIO_VGA
> +    select QXL if SPICE
> +    select MSI_NONBROKEN
> +
>  config MIPS_CPS
>      bool
>      select PTIMER
> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> index 739e2b7..0993852 100644
> --- a/hw/mips/Makefile.objs
> +++ b/hw/mips/Makefile.objs
> @@ -4,5 +4,6 @@ obj-$(CONFIG_MALTA) +=3D gt64xxx_pci.o malta.o
>  obj-$(CONFIG_MIPSSIM) +=3D mipssim.o
>  obj-$(CONFIG_JAZZ) +=3D jazz.o
>  obj-$(CONFIG_FULOONG) +=3D fuloong2e.o
> +obj-$(CONFIG_LOONGSON3V) +=3D loongson3_virt.o
>  obj-$(CONFIG_MIPS_CPS) +=3D cps.o
>  obj-$(CONFIG_MIPS_BOSTON) +=3D boston.o
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> new file mode 100644
> index 0000000..5907772
> --- /dev/null
> +++ b/hw/mips/loongson3_virt.c
> @@ -0,0 +1,969 @@
> +/*
> + * Generic Loongson-3 Platform support
> + *
> + * Copyright (c) 2016-2020 Huacai Chen (chenhc@lemote.com)
> + * This code is licensed under the GNU GPL v2.
> + *
> + * Contributions are licensed under the terms of the GNU GPL,
> + * version 2 or (at your option) any later version.
> + */
> +
> +/*
> + * Generic virtualized PC Platform based on Loongson-3 CPU (MIPS64R2 wit=
h
> + * extensions, 800~2000MHz)
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/units.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "elf.h"
> +#include "kvm_mips.h"
> +#include "hw/boards.h"
> +#include "hw/char/serial.h"
> +#include "hw/mips/mips.h"
> +#include "hw/mips/cpudevs.h"
> +#include "hw/misc/empty_slot.h"
> +#include "hw/intc/i8259.h"
> +#include "hw/loader.h"
> +#include "hw/isa/superio.h"
> +#include "hw/pci/msi.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci/pci_host.h"
> +#include "hw/pci-host/gpex.h"
> +#include "hw/rtc/mc146818rtc.h"
> +#include "hw/usb.h"
> +#include "net/net.h"
> +#include "exec/address-spaces.h"
> +#include "sysemu/kvm.h"
> +#include "sysemu/qtest.h"
> +#include "sysemu/reset.h"
> +#include "sysemu/runstate.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +
> +#define PM_CNTL_MODE          0x10
> +
> +/* Overall MMIO & Memory layout */
> +enum {
> +    VIRT_LOWMEM,
> +    VIRT_PM,
> +    VIRT_FW_CFG,
> +    VIRT_RTC,
> +    VIRT_PCIE_PIO,
> +    VIRT_PCIE_ECAM,
> +    VIRT_BIOS_ROM,
> +    VIRT_UART,
> +    VIRT_LIOINTC,
> +    VIRT_PCIE_MMIO,
> +    VIRT_HIGHMEM
> +};
> +
> +/* Low MEM layout for QEMU kernel loader */
> +enum {
> +    LOADER_KERNEL,
> +    LOADER_INITRD,
> +    LOADER_CMDLINE
> +};
> +
> +/* BIOS ROM layout for QEMU kernel loader */
> +enum {
> +    LOADER_BOOTROM,
> +    LOADER_PARAM,
> +};
> +
> +struct MemmapEntry {
> +    hwaddr base;
> +    hwaddr size;
> +};
> +
> +/* Data for BIOS to identify machine */
> +#define FW_CFG_MACHINE_VERSION  (FW_CFG_ARCH_LOCAL + 0)
> +#define FW_CFG_CPU_FREQ         (FW_CFG_ARCH_LOCAL + 1)
> +
> +/*
> + * LEFI (a UEFI-like interface for BIOS-Kernel boot parameters) data
> structrues
> + * defined at arch/mips/include/asm/mach-loongson64/boot_param.h in
> Linux kernel
> + */
> +struct efi_memory_map_loongson {
> +    uint16_t vers;               /* version of efi_memory_map */
> +    uint32_t nr_map;             /* number of memory_maps */
> +    uint32_t mem_freq;           /* memory frequence */
> +    struct mem_map {
> +        uint32_t node_id;        /* node_id which memory attached to */
> +        uint32_t mem_type;       /* system memory, pci memory, pci io,
> etc. */
> +        uint64_t mem_start;      /* memory map start address */
> +        uint32_t mem_size;       /* each memory_map size, not the total
> size */
> +    } map[128];
> +} __attribute__((packed));
> +
> +enum loongson_cpu_type {
> +    Legacy_2E =3D 0x0,
> +    Legacy_2F =3D 0x1,
> +    Legacy_3A =3D 0x2,
> +    Legacy_3B =3D 0x3,
> +    Legacy_1A =3D 0x4,
> +    Legacy_1B =3D 0x5,
> +    Legacy_2G =3D 0x6,
> +    Legacy_2H =3D 0x7,
> +    Loongson_1A =3D 0x100,
> +    Loongson_1B =3D 0x101,
> +    Loongson_2E =3D 0x200,
> +    Loongson_2F =3D 0x201,
> +    Loongson_2G =3D 0x202,
> +    Loongson_2H =3D 0x203,
> +    Loongson_3A =3D 0x300,
> +    Loongson_3B =3D 0x301
> +};
> +
> +/*
> + * Capability and feature descriptor structure for MIPS CPU
> + */
> +struct efi_cpuinfo_loongson {
> +    uint16_t vers;               /* version of efi_cpuinfo_loongson */
> +    uint32_t processor_id;       /* PRID, e.g. 6305, 6306 */
> +    uint32_t cputype;            /* Loongson_3A/3B, etc. */
> +    uint32_t total_node;         /* num of total numa nodes */
> +    uint16_t cpu_startup_core_id;   /* Boot core id */
> +    uint16_t reserved_cores_mask;
> +    uint32_t cpu_clock_freq;     /* cpu_clock */
> +    uint32_t nr_cpus;
> +    char cpuname[64];
> +} __attribute__((packed));
> +
> +#define MAX_UARTS 64
> +struct uart_device {
> +    uint32_t iotype;
> +    uint32_t uartclk;
> +    uint32_t int_offset;
> +    uint64_t uart_base;
> +} __attribute__((packed));
> +
> +#define MAX_SENSORS 64
> +#define SENSOR_TEMPER  0x00000001
> +#define SENSOR_VOLTAGE 0x00000002
> +#define SENSOR_FAN     0x00000004
> +struct sensor_device {
> +    char name[32];  /* a formal name */
> +    char label[64]; /* a flexible description */
> +    uint32_t type;       /* SENSOR_* */
> +    uint32_t id;         /* instance id of a sensor-class */
> +    uint32_t fan_policy; /* step speed or constant speed */
> +    uint32_t fan_percent;/* only for constant speed policy */
> +    uint64_t base_addr;  /* base address of device registers */
> +} __attribute__((packed));
> +
> +struct system_loongson {
> +    uint16_t vers;               /* version of system_loongson */
> +    uint32_t ccnuma_smp;         /* 0: no numa; 1: has numa */
> +    uint32_t sing_double_channel;/* 1: single; 2: double */
> +    uint32_t nr_uarts;
> +    struct uart_device uarts[MAX_UARTS];
> +    uint32_t nr_sensors;
> +    struct sensor_device sensors[MAX_SENSORS];
> +    char has_ec;
> +    char ec_name[32];
> +    uint64_t ec_base_addr;
> +    char has_tcm;
> +    char tcm_name[32];
> +    uint64_t tcm_base_addr;
> +    uint64_t workarounds;
> +    uint64_t of_dtb_addr; /* NULL if not support */
> +} __attribute__((packed));
> +
> +struct irq_source_routing_table {
> +    uint16_t vers;
> +    uint16_t size;
> +    uint16_t rtr_bus;
> +    uint16_t rtr_devfn;
> +    uint32_t vendor;
> +    uint32_t device;
> +    uint32_t PIC_type;           /* conform use HT or PCI to route to
> CPU-PIC */
> +    uint64_t ht_int_bit;         /* 3A: 1<<24; 3B: 1<<16 */
> +    uint64_t ht_enable;          /* irqs used in this PIC */
> +    uint32_t node_id;            /* node id: 0x0-0; 0x1-1; 0x10-2; 0x11-=
3
> */
> +    uint64_t pci_mem_start_addr;
> +    uint64_t pci_mem_end_addr;
> +    uint64_t pci_io_start_addr;
> +    uint64_t pci_io_end_addr;
> +    uint64_t pci_config_addr;
> +    uint16_t dma_mask_bits;
> +    uint16_t dma_noncoherent;
> +} __attribute__((packed));
> +
> +struct interface_info {
> +    uint16_t vers;               /* version of the specificition */
> +    uint16_t size;
> +    uint8_t  flag;
> +    char description[64];
> +} __attribute__((packed));
> +
> +#define MAX_RESOURCE_NUMBER 128
> +struct resource_loongson {
> +    uint64_t start;              /* resource start address */
> +    uint64_t end;                /* resource end address */
> +    char name[64];
> +    uint32_t flags;
> +};
> +
> +struct archdev_data {};          /* arch specific additions */
> +
> +struct board_devices {
> +    char name[64];               /* hold the device name */
> +    uint32_t num_resources;      /* number of device_resource */
> +    /* for each device's resource */
> +    struct resource_loongson resource[MAX_RESOURCE_NUMBER];
> +    /* arch specific additions */
> +    struct archdev_data archdata;
> +};
> +
> +struct loongson_special_attribute {
> +    uint16_t vers;               /* version of this special */
> +    char special_name[64];       /* special_atribute_name */
> +    uint32_t loongson_special_type; /* type of special device */
> +    /* for each device's resource */
> +    struct resource_loongson resource[MAX_RESOURCE_NUMBER];
> +};
> +
> +struct loongson_params {
> +    uint64_t memory_offset;      /* efi_memory_map_loongson struct offse=
t
> */
> +    uint64_t cpu_offset;         /* efi_cpuinfo_loongson struct offset *=
/
> +    uint64_t system_offset;      /* system_loongson struct offset */
> +    uint64_t irq_offset;         /* irq_source_routing_table struct
> offset */
> +    uint64_t interface_offset;   /* interface_info struct offset */
> +    uint64_t special_offset;     /* loongson_special_attribute struct
> offset */
> +    uint64_t boarddev_table_offset;  /* board_devices offset */
> +};
> +
> +struct smbios_tables {
> +    uint16_t vers;               /* version of smbios */
> +    uint64_t vga_bios;           /* vga_bios address */
> +    struct loongson_params lp;
> +};
> +
> +struct efi_reset_system_t {
> +    uint64_t ResetCold;
> +    uint64_t ResetWarm;
> +    uint64_t ResetType;
> +    uint64_t Shutdown;
> +    uint64_t DoSuspend; /* NULL if not support */
> +};
> +
> +struct efi_loongson {
> +    uint64_t mps;                /* MPS table */
> +    uint64_t acpi;               /* ACPI table (IA64 ext 0.71) */
> +    uint64_t acpi20;             /* ACPI table (ACPI 2.0) */
> +    struct smbios_tables smbios; /* SM BIOS table */
> +    uint64_t sal_systab;         /* SAL system table */
> +    uint64_t boot_info;          /* boot info table */
> +};
> +
> +struct boot_params {
> +    struct efi_loongson efi;
> +    struct efi_reset_system_t reset_system;
> +};
> +
> +#define LOONGSON_MAX_VCPUS      16
> +
> +#define LOONGSON3_BIOSNAME "bios_loongson3.bin"
> +
> +#define UART_IRQ            0
> +#define RTC_IRQ             1
> +#define PCIE_IRQ_BASE       2
> +
> +#define align(x) (((x) + 63) & ~63)
> +
> +static const struct MemmapEntry virt_memmap[] =3D {
> +    [VIRT_LOWMEM] =3D      { 0x00000000,    0x10000000 },
> +    [VIRT_PM] =3D          { 0x10080000,         0x100 },
> +    [VIRT_FW_CFG] =3D      { 0x10080100,         0x100 },
> +    [VIRT_RTC] =3D         { 0x10081000,        0x1000 },
> +    [VIRT_PCIE_PIO] =3D    { 0x18000000,       0xc0000 },
> +    [VIRT_PCIE_ECAM] =3D   { 0x1a000000,     0x2000000 },
> +    [VIRT_BIOS_ROM] =3D    { 0x1fc00000,      0x200000 },
> +    [VIRT_UART] =3D        { 0x1fe001e0,           0x8 },
> +    [VIRT_LIOINTC] =3D     { 0x3ff01400,          0x64 },
> +    [VIRT_PCIE_MMIO] =3D   { 0x40000000,    0x40000000 },
> +    [VIRT_HIGHMEM] =3D     { 0x80000000,           0x0 }, /* Variable */
> +};
> +
> +static const struct MemmapEntry loader_memmap[] =3D {
> +    [LOADER_KERNEL] =3D    { 0x00000000,     0x4000000 },
> +    [LOADER_INITRD] =3D    { 0x04000000,           0x0 }, /* Variable */
> +    [LOADER_CMDLINE] =3D   { 0x0ff00000,      0x100000 },
> +};
> +
> +static const struct MemmapEntry loader_rommap[] =3D {
> +    [LOADER_BOOTROM] =3D   { 0x1fc00000,        0x1000 },
> +    [LOADER_PARAM] =3D     { 0x1fc01000,       0x10000 },
> +};
> +
> +static struct _loaderparams {
> +    uint64_t ram_size;
> +    const char *kernel_cmdline;
> +    const char *kernel_filename;
> +    const char *initrd_filename;
> +    uint64_t kernel_entry;
> +    uint64_t a0, a1, a2;
> +} loaderparams;
> +
> +static uint64_t loongson3_pm_read(void *opaque, hwaddr addr, unsigned
> size)
> +{
> +    return 0;
> +}
> +
> +static void loongson3_pm_write(void *opaque, hwaddr addr, uint64_t val,
> unsigned size)
> +{
> +    if (addr !=3D PM_CNTL_MODE) {
> +        return;
> +    }
> +
> +    switch (val) {
> +    case 0x00:
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        return;
> +    case 0xff:
> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +        return;
> +    default:
> +        return;
> +    }
> +}
> +
> +static const MemoryRegionOps loongson3_pm_ops =3D {
> +    .read  =3D loongson3_pm_read,
> +    .write =3D loongson3_pm_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static struct efi_memory_map_loongson *init_memory_map(void *g_map)
> +{
> +    struct efi_memory_map_loongson *emap =3D g_map;
> +
> +    emap->nr_map =3D 2;
> +    emap->mem_freq =3D 300000000;
> +
> +    emap->map[0].node_id =3D 0;
> +    emap->map[0].mem_type =3D 1;
> +    emap->map[0].mem_start =3D 0x0;
> +    emap->map[0].mem_size =3D (loaderparams.ram_size > 0x10000000
> +                            ? 256 : (loaderparams.ram_size >> 20)) - 16;
> +
> +    emap->map[1].node_id =3D 0;
> +    emap->map[1].mem_type =3D 2;
> +    emap->map[1].mem_start =3D 0x90000000;
> +    emap->map[1].mem_size =3D (loaderparams.ram_size > 0x10000000
> +                            ? (loaderparams.ram_size >> 20) - 256 : 0);
> +
> +    return emap;
> +}
> +
> +#define BUFLEN 1024
> +
> +static uint32_t get_cpu_freq(void)
> +{
> +    int fd =3D 0, freq =3D 0;
> +    char buf[BUFLEN], *buf_p;
> +
> +    fd =3D open("/proc/cpuinfo", O_RDONLY);
> +    if (fd =3D=3D -1) {
> +        fprintf(stderr, "Failed to open /proc/cpuinfo!\n");
> +        return 0;
> +    }
> +
> +    if (read(fd, buf, BUFLEN) < 0) {
> +        close(fd);
> +        fprintf(stderr, "Failed to read /proc/cpuinfo!\n");
> +        return 0;
> +    }
> +    close(fd);
> +
> +    buf_p =3D strstr(buf, "model name");
> +    while (*buf_p !=3D '@') {
> +        buf_p++;
> +    }
> +
> +    buf_p +=3D 2;
> +    memcpy(buf, buf_p, 12);
> +    buf_p =3D buf;
> +    while ((*buf_p >=3D '0') && (*buf_p <=3D '9')) {
> +        buf_p++;
> +    }
> +    *buf_p =3D '\0';
> +
> +    freq =3D atoi(buf);
> +
> +    return freq * 1000 * 1000;
> +}
> +
> +static struct efi_cpuinfo_loongson *init_cpu_info(void
> *g_cpuinfo_loongson)
> +{
> +    struct efi_cpuinfo_loongson *c =3D g_cpuinfo_loongson;
> +
> +    c->cputype =3D Loongson_3A;
> +    c->processor_id =3D MIPS_CPU(first_cpu)->env.CP0_PRid;
> +    c->cpu_clock_freq =3D get_cpu_freq();
> +    if (!c->cpu_clock_freq) {
> +        c->cpu_clock_freq =3D 500000000;
> +    }
> +
> +    c->cpu_startup_core_id =3D 0;
> +    c->nr_cpus =3D current_machine->smp.cpus;
> +    c->total_node =3D (current_machine->smp.cpus + 3) / 4;
> +
> +    return c;
> +}
> +
> +static struct system_loongson *init_system_loongson(void *g_system)
> +{
> +    struct system_loongson *s =3D g_system;
> +
> +    s->ccnuma_smp =3D 0;
> +    s->sing_double_channel =3D 1;
> +    s->nr_uarts =3D 1;
> +    s->uarts[0].iotype =3D 2;
> +    s->uarts[0].int_offset =3D 2;
> +    s->uarts[0].uartclk =3D 25000000; /* Random value */
> +    s->uarts[0].uart_base =3D virt_memmap[VIRT_UART].base;
> +
> +    return s;
> +}
> +
> +static struct irq_source_routing_table *init_irq_source(void
> *g_irq_source)
> +{
> +    struct irq_source_routing_table *irq_info =3D g_irq_source;
> +
> +    irq_info->node_id =3D 0;
> +    irq_info->PIC_type =3D 0;
> +    irq_info->dma_mask_bits =3D 64;
> +    irq_info->pci_mem_start_addr =3D virt_memmap[VIRT_PCIE_MMIO].base;
> +    irq_info->pci_mem_end_addr   =3D virt_memmap[VIRT_PCIE_MMIO].base +
> +                                   virt_memmap[VIRT_PCIE_MMIO].size - 1;
> +    irq_info->pci_io_start_addr  =3D virt_memmap[VIRT_PCIE_PIO].base;
> +
> +    return irq_info;
> +}
> +
> +static struct interface_info *init_interface_info(void *g_interface)
> +{
> +    struct interface_info *interface =3D g_interface;
> +
> +    interface->vers =3D 0x01;
> +    strcpy(interface->description, "UEFI_Version_v1.0");
> +
> +    return interface;
> +}
> +
> +static struct board_devices *board_devices_info(void *g_board)
> +{
> +    struct board_devices *bd =3D g_board;
> +
> +    strcpy(bd->name, "Loongson-3A-VIRT-1w-V1.00-demo");
> +
> +    return bd;
> +}
> +
> +static struct loongson_special_attribute *init_special_info(void
> *g_special)
> +{
> +    struct loongson_special_attribute *special =3D g_special;
> +
> +    strcpy(special->special_name, "2016-08-01");
> +
> +    return special;
> +}
> +
> +static void init_loongson_params(struct loongson_params *lp, void *p)
> +{
> +    lp->memory_offset =3D (unsigned long long)init_memory_map(p)
> +                        - (unsigned long long)lp;
> +    p +=3D align(sizeof(struct efi_memory_map_loongson));
> +
> +    lp->cpu_offset =3D (unsigned long long)init_cpu_info(p)
> +                     - (unsigned long long)lp;
> +    p +=3D align(sizeof(struct efi_cpuinfo_loongson));
> +
> +    lp->system_offset =3D (unsigned long long)init_system_loongson(p)
> +                        - (unsigned long long)lp;
> +    p +=3D align(sizeof(struct system_loongson));
> +
> +    lp->irq_offset =3D (unsigned long long)init_irq_source(p)
> +                     - (unsigned long long)lp;
> +    p +=3D align(sizeof(struct irq_source_routing_table));
> +
> +    lp->interface_offset =3D (unsigned long long)init_interface_info(p)
> +                           - (unsigned long long)lp;
> +    p +=3D align(sizeof(struct interface_info));
> +
> +    lp->boarddev_table_offset =3D (unsigned long long)board_devices_info=
(p)
> +                                - (unsigned long long)lp;
> +    p +=3D align(sizeof(struct board_devices));
> +
> +    lp->special_offset =3D (unsigned long long)init_special_info(p)
> +                         - (unsigned long long)lp;
> +    p +=3D align(sizeof(struct loongson_special_attribute));
> +}
> +
> +static void init_reset_system(struct efi_reset_system_t *reset)
> +{
> +    reset->Shutdown =3D 0xffffffffbfc000a8;
> +    reset->ResetCold =3D 0xffffffffbfc00080;
> +    reset->ResetWarm =3D 0xffffffffbfc00080;
> +}
> +
> +static void init_boot_param(void)
> +{
> +    void *p;
> +    struct boot_params *bp;
> +
> +    p =3D g_malloc0(loader_rommap[LOADER_PARAM].size);
> +    bp =3D p;
> +
> +    bp->efi.smbios.vers =3D 1;
> +    init_reset_system(&(bp->reset_system));
> +    p +=3D align(sizeof(struct boot_params));
> +    init_loongson_params(&(bp->efi.smbios.lp), p);
> +
> +    rom_add_blob_fixed("params_rom", bp,
> +                       loader_rommap[LOADER_PARAM].size,
> +                       loader_rommap[LOADER_PARAM].base);
> +
> +    g_free(bp);
> +
> +    loaderparams.a2 =3D cpu_mips_phys_to_kseg0(NULL,
> +                                             loader_rommap[LOADER_PARAM]=
.
> base);
> +}
> +
> +static void init_boot_rom(void)
> +{
> +    const unsigned int boot_code[] =3D {
> +        0x40086000,   /* mfc0    t0, CP0_STATUS
>      */
> +        0x240900E4,   /* li      t1, 0xe4         #set kx, sx, ux, erl
>     */
> +        0x01094025,   /* or      t0, t0, t1
>      */
> +        0x3C090040,   /* lui     t1, 0x40         #set bev
>     */
> +        0x01094025,   /* or      t0, t0, t1
>      */
> +        0x40886000,   /* mtc0    t0, CP0_STATUS
>      */
> +        0x00000000,
> +        0x40806800,   /* mtc0    zero, CP0_CAUSE
>     */
> +        0x00000000,
> +        0x400A7801,   /* mfc0    t2, $15, 1
>      */
> +        0x314A00FF,   /* andi    t2, 0x0ff
>     */
> +        0x3C089000,   /* dli     t0, 0x900000003ff01000
>      */
> +        0x00084438,
> +        0x35083FF0,
> +        0x00084438,
> +        0x35081000,
> +        0x314B0003,   /* andi    t3, t2, 0x3      #local cpuid
>     */
> +        0x000B5A00,   /* sll     t3, 8
>     */
> +        0x010B4025,   /* or      t0, t0, t3
>      */
> +        0x314C000C,   /* andi    t4, t2, 0xc      #node id
>     */
> +        0x000C62BC,   /* dsll    t4, 42
>      */
> +        0x010C4025,   /* or      t0, t0, t4
>      */
> +                      /* WaitForInit:
>      */
> +        0xDD020020,   /* ld      v0, FN_OFF(t0)   #FN_OFF 0x020
>      */
> +        0x1040FFFE,   /* beqz    v0, WaitForInit
>     */
> +        0x00000000,   /* nop
>     */
> +        0xDD1D0028,   /* ld      sp, SP_OFF(t0)   #FN_OFF 0x028
>      */
> +        0xDD1C0030,   /* ld      gp, GP_OFF(t0)   #FN_OFF 0x030
>      */
> +        0xDD050038,   /* ld      a1, A1_OFF(t0)   #FN_OFF 0x038
>      */
> +        0x00400008,   /* jr      v0               #byebye
>      */
> +        0x00000000,   /* nop
>     */
> +        0x1000FFFF,   /* 1:  b   1b
>      */
> +        0x00000000,   /* nop
>     */
> +
> +                      /* Reset
>     */
> +        0x3C0C9000,   /* dli     t0, 0x9000000010080010
>      */
> +        0x358C0000,
> +        0x000C6438,
> +        0x358C1008,
> +        0x000C6438,
> +        0x358C0010,
> +        0x240D0000,   /* li      t1, 0x00
>      */
> +        0xA18D0000,   /* sb      t1, (t0)
>      */
> +        0x1000FFFF,   /* 1:  b   1b
>      */
> +        0x00000000,   /* nop
>     */
> +
> +                      /* Shutdown
>      */
> +        0x3C0C9000,   /* dli     t0, 0x9000000010080010
>      */
> +        0x358C0000,
> +        0x000C6438,
> +        0x358C1008,
> +        0x000C6438,
> +        0x358C0010,
> +        0x240D00FF,   /* li      t1, 0xff
>      */
> +        0xA18D0000,   /* sb      t1, (t0)
>      */
> +        0x1000FFFF,   /* 1:  b   1b
>      */
> +        0x00000000    /* nop
>     */
> +    };
> +
> +    rom_add_blob_fixed("boot_rom", boot_code, sizeof(boot_code),
> +                        loader_rommap[LOADER_BOOTROM].base);
> +}
> +
> +static void fw_cfg_boot_set(void *opaque, const char *boot_device,
> +                            Error **errp)
> +{
> +    fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]);
> +}
> +
> +static void fw_conf_init(unsigned long ram_size)
> +{
> +    FWCfgState *fw_cfg;
> +    hwaddr cfg_addr =3D virt_memmap[VIRT_FW_CFG].base;
> +
> +    fw_cfg =3D fw_cfg_init_mem_wide(cfg_addr, cfg_addr + 8, 8, 0, NULL);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)current_machine->
> smp.cpus);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_machine->
> smp.max_cpus);
> +    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_MACHINE_VERSION, 1);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_CPU_FREQ, get_cpu_freq());
> +    qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
> +}
> +
> +static int set_prom_cmdline(ram_addr_t initrd_offset, long initrd_size)
> +{
> +    hwaddr cmdline_vaddr;
> +    char memenv[32];
> +    char highmemenv[32];
> +    void *cmdline_buf;
> +    unsigned int *parg_env;
> +    int ret =3D 0;
> +
> +    /* Allocate cmdline_buf for command line. */
> +    cmdline_buf =3D g_malloc0(loader_memmap[LOADER_CMDLINE].size);
> +    cmdline_vaddr =3D cpu_mips_phys_to_kseg0(NULL,
> +                                           loader_memmap[LOADER_CMDLINE]=
.
> base);
> +
> +    /*
> +     * Layout of cmdline_buf looks like this:
> +     * argv[0], argv[1], 0, env[0], env[1], ... env[i], 0,
> +     * argv[0]'s data, argv[1]'s data, env[0]'data, ..., env[i]'s data, =
0
> +     */
> +    parg_env =3D (void *)cmdline_buf;
> +
> +    ret =3D (3 + 1) * 4;
> +    *parg_env++ =3D cmdline_vaddr + ret;
> +    ret +=3D (1 + snprintf(cmdline_buf + ret, 256 - ret, "g"));
> +
> +    /* argv1 */
> +    *parg_env++ =3D cmdline_vaddr + ret;
> +    if (initrd_size > 0)
> +        ret +=3D (1 + snprintf(cmdline_buf + ret, 256 - ret,
> +                "rd_start=3D0x" TARGET_FMT_lx " rd_size=3D%li %s",
> +                cpu_mips_phys_to_kseg0(NULL, initrd_offset),
> +                initrd_size, loaderparams.kernel_cmdline));
> +    else
> +        ret +=3D (1 + snprintf(cmdline_buf + ret, 256 - ret, "%s",
> +                loaderparams.kernel_cmdline));
> +
> +    /* argv2 */
> +    *parg_env++ =3D cmdline_vaddr + 4 * ret;
> +
> +    /* env */
> +    sprintf(memenv, "%ld", loaderparams.ram_size > 0x10000000
> +            ? 256 : (loaderparams.ram_size >> 20));
> +    sprintf(highmemenv, "%ld", loaderparams.ram_size > 0x10000000
> +            ? (loaderparams.ram_size >> 20) - 256 : 0);
> +
> +    rom_add_blob_fixed("cmdline", cmdline_buf,
> +                       loader_memmap[LOADER_CMDLINE].size,
> +                       loader_memmap[LOADER_CMDLINE].base);
> +
> +    g_free(cmdline_buf);
> +
> +    loaderparams.a0 =3D 2;
> +    loaderparams.a1 =3D cmdline_vaddr;
> +
> +    return 0;
> +}
> +
> +static uint64_t load_kernel(CPUMIPSState *env)
> +{
> +    long kernel_size;
> +    ram_addr_t initrd_offset;
> +    uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;
> +
> +    kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
> +                           cpu_mips_kseg0_to_phys, NULL,
> +                           (uint64_t *)&kernel_entry,
> +                           (uint64_t *)&kernel_low, (uint64_t
> *)&kernel_high,
> +                           NULL, 0, EM_MIPS, 1, 0);
> +    if (kernel_size < 0) {
> +        error_report("could not load kernel '%s': %s",
> +                     loaderparams.kernel_filename,
> +                     load_elf_strerror(kernel_size));
> +        exit(1);
> +    }
> +
> +    /* load initrd */
> +    initrd_size =3D 0;
> +    initrd_offset =3D 0;
> +    if (loaderparams.initrd_filename) {
> +        initrd_size =3D get_image_size(loaderparams.initrd_filename);
> +        if (initrd_size > 0) {
> +            initrd_offset =3D (kernel_high + ~INITRD_PAGE_MASK) &
> +                            INITRD_PAGE_MASK;
> +            initrd_offset =3D MAX(initrd_offset,
> +                                loader_memmap[LOADER_INITRD].base);
> +
> +            if (initrd_offset + initrd_size > ram_size) {
> +                error_report("memory too small for initial ram disk '%s'=
",
> +                             loaderparams.initrd_filename);
> +                exit(1);
> +            }
> +
> +            initrd_size =3D load_image_targphys(
> loaderparams.initrd_filename,
> +                                              initrd_offset,
> +                                              ram_size - initrd_offset);
> +        }
> +
> +        if (initrd_size =3D=3D (target_ulong) -1) {
> +            error_report("could not load initial ram disk '%s'",
> +                         loaderparams.initrd_filename);
> +            exit(1);
> +        }
> +    }
> +
> +    /* Setup prom cmdline. */
> +    set_prom_cmdline(initrd_offset, initrd_size);
> +
> +    return kernel_entry;
> +}
> +
> +static void main_cpu_reset(void *opaque)
> +{
> +    MIPSCPU *cpu =3D opaque;
> +    CPUMIPSState *env =3D &cpu->env;
> +
> +    cpu_reset(CPU(cpu));
> +
> +    /* Loongson-3 reset stuff */
> +    if (loaderparams.kernel_filename) {
> +        if (cpu =3D=3D MIPS_CPU(first_cpu)) {
> +            env->active_tc.gpr[4] =3D loaderparams.a0;
> +            env->active_tc.gpr[5] =3D loaderparams.a1;
> +            env->active_tc.gpr[6] =3D loaderparams.a2;
> +            env->active_tc.PC =3D loaderparams.kernel_entry;
> +        }
> +        env->CP0_Status &=3D ~((1 << CP0St_BEV) | (1 << CP0St_ERL));
> +    }
> +}
> +
> +static inline void loongson3_virt_devices_init(MachineState *machine,
> DeviceState *pic)
> +{
> +    int i;
> +    qemu_irq irq;
> +    PCIBus *pci_bus;
> +    DeviceState *dev;
> +    MemoryRegion *pio_alias;
> +    MemoryRegion *mmio_alias, *mmio_reg;
> +    MemoryRegion *ecam_alias, *ecam_reg;
> +
> +    dev =3D qdev_new(TYPE_GPEX_HOST);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    pci_bus =3D PCI_HOST_BRIDGE(dev)->bus;
> +
> +    ecam_alias =3D g_new0(MemoryRegion, 1);
> +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> +                             ecam_reg, 0, virt_memmap[VIRT_PCIE_ECAM].
> size);
> +    memory_region_add_subregion(get_system_memory(),
> +                                virt_memmap[VIRT_PCIE_ECAM].base,
> ecam_alias);
> +
> +    mmio_alias =3D g_new0(MemoryRegion, 1);
> +    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> +                             mmio_reg, virt_memmap[VIRT_PCIE_MMIO].base,
> +                             virt_memmap[VIRT_PCIE_MMIO].size);
> +    memory_region_add_subregion(get_system_memory(),
> +                                virt_memmap[VIRT_PCIE_MMIO].base,
> mmio_alias);
> +
> +    pio_alias =3D g_new0(MemoryRegion, 1);
> +    memory_region_init_alias(pio_alias, OBJECT(dev), "pcie-pio",
> +                             get_system_io(), 0,
> virt_memmap[VIRT_PCIE_PIO].size);
> +    memory_region_add_subregion(get_system_memory(),
> +                                virt_memmap[VIRT_PCIE_PIO].base,
> pio_alias);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, virt_memmap[VIRT_PCIE_PIO].
> base);
> +
> +    for (i =3D 0; i < GPEX_NUM_IRQS; i++) {
> +        irq =3D qdev_get_gpio_in(pic, PCIE_IRQ_BASE + i);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> +        gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ_BASE + i);
> +    }
> +
> +    pci_vga_init(pci_bus);
> +
> +    if (defaults_enabled()) {
> +        pci_create_simple(pci_bus, -1, "pci-ohci");
> +        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> +        usb_create_simple(usb_bus_find(-1), "usb-tablet");
> +    }
> +
> +    for (i =3D 0; i < nb_nics; i++) {
> +        NICInfo *nd =3D &nd_table[i];
> +
> +        if (!nd->model) {
> +            nd->model =3D g_strdup("virtio");
> +        }
> +
> +        pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
> +    }
> +}
> +
> +static void mips_loongson3_virt_init(MachineState *machine)
> +{
> +    int i;
> +    long bios_size;
> +    MIPSCPU *cpu;
> +    CPUMIPSState *env;
> +    DeviceState *liointc;
> +    char *filename;
> +    const char *kernel_cmdline =3D machine->kernel_cmdline;
> +    const char *kernel_filename =3D machine->kernel_filename;
> +    const char *initrd_filename =3D machine->initrd_filename;
> +    ram_addr_t ram_size =3D machine->ram_size;
> +    MemoryRegion *address_space_mem =3D get_system_memory();
> +    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> +    MemoryRegion *bios =3D g_new(MemoryRegion, 1);
> +    MemoryRegion *iomem =3D g_new(MemoryRegion, 1);
> +
> +    /* TODO: TCG will support all CPU types */
> +    if (!kvm_enabled()) {
> +        if (!machine->cpu_type) {
> +            machine->cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-3A1000");
> +        }
> +        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
> +            error_report("Loongson-3/TCG need cpu type Loongson-3A1000")=
;
> +            exit(1);
> +        }
> +    } else {
> +        if (!machine->cpu_type) {
> +            machine->cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-3A4000");
> +        }
> +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
> +            error_report("Loongson-3/KVM need cpu type Loongson-3A4000")=
;
> +            exit(1);
> +        }
> +    }
> +
> +    if (ram_size < 512 * 0x100000) {
> +        error_report("Loongson-3 need at least 512MB memory");
> +        exit(1);
> +    }
> +
> +    /*
> +     * The whole MMIO range among configure registers doesn't generate
> +     * exception when accessing invalid memory. Create an empty slot to
> +     * emulate this feature.
> +     */
> +    empty_slot_init("fallback", 0, 0x80000000);
> +
> +    liointc =3D qdev_new("loongson.liointc");
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(liointc), 0,
> virt_memmap[VIRT_LIOINTC].base);
> +
> +    for (i =3D 0; i < machine->smp.cpus; i++) {
> +        int ip;
> +
> +        /* init CPUs */
> +        cpu =3D MIPS_CPU(cpu_create(machine->cpu_type));
> +
> +        /* Init internal devices */
> +        cpu_mips_irq_init_cpu(cpu);
> +        cpu_mips_clock_init(cpu);
> +        qemu_register_reset(main_cpu_reset, cpu);
> +
> +        if (i >=3D 4) {
> +            continue; /* Only node-0 can be connected to LIOINTC */
> +        }
> +
> +        for (ip =3D 0; ip < 4 ; ip++) {
> +            int pin =3D i * 4 + ip;
> +            sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
> +                               pin, cpu->env.irq[ip + 2]);
> +        }
> +    }
> +    env =3D &MIPS_CPU(first_cpu)->env;
> +
> +    /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of
> 0x80000000~0x90000000 */
> +    memory_region_init_rom(bios, NULL, "loongson3.bios",
> +                           virt_memmap[VIRT_BIOS_ROM].size,
> &error_fatal);
> +    memory_region_init_alias(ram, NULL, "loongson3.lowmem",
> +                           machine->ram, 0, virt_memmap[VIRT_LOWMEM].siz=
e)
> ;
> +    memory_region_init_io(iomem, NULL, &loongson3_pm_ops,
> +                           NULL, "loongson3_pm",
> virt_memmap[VIRT_PM].size);
> +
> +    memory_region_add_subregion(address_space_mem,
> +                      virt_memmap[VIRT_LOWMEM].base, ram);
> +    memory_region_add_subregion(address_space_mem,
> +                      virt_memmap[VIRT_BIOS_ROM].base, bios);
> +    memory_region_add_subregion(address_space_mem,
> +                      virt_memmap[VIRT_HIGHMEM].base, machine->ram);
> +    memory_region_add_subregion(address_space_mem,
> +                      virt_memmap[VIRT_PM].base, iomem);
> +
> +    /*
> +     * We do not support flash operation, just loading bios.bin as raw
> BIOS.
> +     * Please use -L to set the BIOS path and -bios to set bios name.
> +     */
> +
> +    if (kernel_filename) {
> +        loaderparams.ram_size =3D ram_size;
> +        loaderparams.kernel_filename =3D kernel_filename;
> +        loaderparams.kernel_cmdline =3D kernel_cmdline;
> +        loaderparams.initrd_filename =3D initrd_filename;
> +        loaderparams.kernel_entry =3D load_kernel(env);
> +
> +        init_boot_rom();
> +        init_boot_param();
> +    } else {
> +        if (bios_name =3D=3D NULL) {
> +                bios_name =3D LOONGSON3_BIOSNAME;
> +        }
> +        filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +        if (filename) {
> +            bios_size =3D load_image_targphys(filename,
> +                                            virt_memmap[VIRT_BIOS_ROM].
> base,
> +                                            virt_memmap[VIRT_BIOS_ROM].
> size);
> +            g_free(filename);
> +        } else {
> +            bios_size =3D -1;
> +        }
> +
> +        if ((bios_size < 0 || bios_size > virt_memmap[VIRT_BIOS_ROM].siz=
e)
> &&
> +            !kernel_filename && !qtest_enabled()) {
> +            error_report("Could not load MIPS bios '%s'", bios_name);
> +            exit(1);
> +        }
> +
> +        fw_conf_init(ram_size);
> +    }
> +
> +    msi_nonbroken =3D true;
> +    loongson3_virt_devices_init(machine, liointc);
> +
> +    sysbus_create_simple("goldfish_rtc", virt_memmap[VIRT_RTC].base,
> +                         qdev_get_gpio_in(liointc, RTC_IRQ));
> +
> +    if (serial_hd(0)) {
> +        serial_mm_init(address_space_mem, virt_memmap[VIRT_UART].base, 0=
,
> +                       qdev_get_gpio_in(liointc, UART_IRQ), 115200,
> +                       serial_hd(0), DEVICE_NATIVE_ENDIAN);
> +    }
> +}
> +
> +static void mips_loongson3_virt_machine_init(MachineClass *mc)
> +{
> +    mc->desc =3D "Loongson-3 Virtualization Platform";
> +    mc->init =3D mips_loongson3_virt_init;
> +    mc->block_default_type =3D IF_IDE;
> +    mc->max_cpus =3D LOONGSON_MAX_VCPUS;
> +    mc->default_ram_id =3D "loongson3.highram";
> +    /* 1440MB is the requirement of distros for Loongson-3 */
> +    mc->default_ram_size =3D 1440 * MiB;
> +    mc->kvm_type =3D mips_kvm_type;
> +    mc->minimum_page_bits =3D 14;
> +}
> +
> +DEFINE_MACHINE("loongson3-virt", mips_loongson3_virt_machine_init)
> --
> 2.7.0
>
>

--00000000000066141505a8c0951a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 23. =D1=98=D1=83=D0=BD 2020.,=
 Huacai Chen &lt;<a href=3D"mailto:zltjiangshi@gmail.com">zltjiangshi@gmail=
.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Add Loongson-3 based machine supp=
ort, it use i8259 as the interrupt<br>
controler</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote><div>=
<br></div><div>8259 or LIOINTC?</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">and use GPEX as the pci controller. Currentl=
y it can only</blockquote><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
work with KVM, but we will add TCG support in future.<br>
<br>
As the machine model is not based on any exiting physical hardware, the<br>
name of the machine is &quot;loongson3-virt&quot;. It may be superseded in =
future<br>
by a real machine model. If this happens, then a regular deprecation<br>
procedure shall occur for &quot;loongson3-virt&quot; machine.<br>
<br>
We already have a full functional Linux kernel (based on Linux-5.4.x LTS<br=
>
but not upstream yet) here:<br>
<br>
<a href=3D"https://github.com/chenhuacai/linux" target=3D"_blank">https://g=
ithub.com/chenhuacai/<wbr>linux</a><br>
<br>
How to use QEMU/Loongson-3?<br>
1, Download kernel source from the above URL;<br>
2, Build a kernel with arch/mips/configs/loongson3_{<wbr>def,hpc}config;<br=
>
3, Boot the a Loongson-3A4000 host with this kernel;<br>
4, Build QEMU-master with this patchset;<br>
5, modprobe kvm;<br>
6, Use QEMU with TCG (available in future):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-system-mips64el -M loongson3-virt,accel=3Dt=
cg -cpu Loongson-3A1000 -kernel &lt;path_to_kernel&gt; -append ...</blockqu=
ote><div><br></div><div>Hello, Huacai.</div><div><br></div><div>Thanks for =
the new version.</div><div><br></div><div>What exacrly is missing in tcg su=
pport? Would it work if Loongson EXT is supported in QEMU?</div><div><br></=
div><div>Warmly,</div><div>Aleksandar</div><div><br></div><div><br></div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0Use QEMU with KVM (available at present):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-system-mips64el -M loongson3-virt,accel=3Dk=
vm -cpu Loongson-3A4000 -kernel &lt;path_to_kernel&gt; -append ...<br>
<br>
=C2=A0 =C2=A0The &quot;-cpu&quot; parameter is optional here and QEMU will =
use the correct type for TCG/KVM automatically.<br>
<br>
Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@=
lemote.com</a>&gt;<br>
Co-developed-by: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.com"=
>jiaxun.yang@flygoat.com</a>&gt;<br>
---<br>
=C2=A0default-configs/mips64el-<wbr>softmmu.mak |=C2=A0 =C2=A01 +<br>
=C2=A0hw/mips/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +<br>
=C2=A0hw/mips/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/mips/loongson3_virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 969 ++++++++++++++++++++++++++++++<wbr>+++++<br>
=C2=A04 files changed, 982 insertions(+)<br>
=C2=A0create mode 100644 hw/mips/loongson3_virt.c<br>
<br>
diff --git a/default-configs/mips64el-<wbr>softmmu.mak b/default-configs/mi=
ps64el-<wbr>softmmu.mak<br>
index 9f8a3ef..26c660a 100644<br>
--- a/default-configs/mips64el-<wbr>softmmu.mak<br>
+++ b/default-configs/mips64el-<wbr>softmmu.mak<br>
@@ -3,6 +3,7 @@<br>
=C2=A0include mips-softmmu-common.mak<br>
=C2=A0CONFIG_IDE_VIA=3Dy<br>
=C2=A0CONFIG_FULOONG=3Dy<br>
+CONFIG_LOONGSON3V=3Dy<br>
=C2=A0CONFIG_ATI_VGA=3Dy<br>
=C2=A0CONFIG_RTL8139_PCI=3Dy<br>
=C2=A0CONFIG_JAZZ=3Dy<br>
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig<br>
index 67d39c5..cc5609b 100644<br>
--- a/hw/mips/Kconfig<br>
+++ b/hw/mips/Kconfig<br>
@@ -45,6 +45,17 @@ config FULOONG<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
=C2=A0 =C2=A0 =C2=A0select PCI_BONITO<br>
<br>
+config LOONGSON3V<br>
+=C2=A0 =C2=A0 bool<br>
+=C2=A0 =C2=A0 select PCKBD<br>
+=C2=A0 =C2=A0 select SERIAL<br>
+=C2=A0 =C2=A0 select GOLDFISH_RTC<br>
+=C2=A0 =C2=A0 select LOONGSON_LIOINTC<br>
+=C2=A0 =C2=A0 select PCI_EXPRESS_GENERIC_BRIDGE<br>
+=C2=A0 =C2=A0 select VIRTIO_VGA<br>
+=C2=A0 =C2=A0 select QXL if SPICE<br>
+=C2=A0 =C2=A0 select MSI_NONBROKEN<br>
+<br>
=C2=A0config MIPS_CPS<br>
=C2=A0 =C2=A0 =C2=A0bool<br>
=C2=A0 =C2=A0 =C2=A0select PTIMER<br>
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs<br>
index 739e2b7..0993852 100644<br>
--- a/hw/mips/Makefile.objs<br>
+++ b/hw/mips/Makefile.objs<br>
@@ -4,5 +4,6 @@ obj-$(CONFIG_MALTA) +=3D gt64xxx_pci.o malta.o<br>
=C2=A0obj-$(CONFIG_MIPSSIM) +=3D mipssim.o<br>
=C2=A0obj-$(CONFIG_JAZZ) +=3D jazz.o<br>
=C2=A0obj-$(CONFIG_FULOONG) +=3D fuloong2e.o<br>
+obj-$(CONFIG_LOONGSON3V) +=3D loongson3_virt.o<br>
=C2=A0obj-$(CONFIG_MIPS_CPS) +=3D cps.o<br>
=C2=A0obj-$(CONFIG_MIPS_BOSTON) +=3D boston.o<br>
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c<br>
new file mode 100644<br>
index 0000000..5907772<br>
--- /dev/null<br>
+++ b/hw/mips/loongson3_virt.c<br>
@@ -0,0 +1,969 @@<br>
+/*<br>
+ * Generic Loongson-3 Platform support<br>
+ *<br>
+ * Copyright (c) 2016-2020 Huacai Chen (<a href=3D"mailto:chenhc@lemote.co=
m">chenhc@lemote.com</a>)<br>
+ * This code is licensed under the GNU GPL v2.<br>
+ *<br>
+ * Contributions are licensed under the terms of the GNU GPL,<br>
+ * version 2 or (at your option) any later version.<br>
+ */<br>
+<br>
+/*<br>
+ * Generic virtualized PC Platform based on Loongson-3 CPU (MIPS64R2 with<=
br>
+ * extensions, 800~2000MHz)<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu-common.h&quot;<br>
+#include &quot;qemu/units.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;cpu.h&quot;<br>
+#include &quot;elf.h&quot;<br>
+#include &quot;kvm_mips.h&quot;<br>
+#include &quot;hw/boards.h&quot;<br>
+#include &quot;hw/char/serial.h&quot;<br>
+#include &quot;hw/mips/mips.h&quot;<br>
+#include &quot;hw/mips/cpudevs.h&quot;<br>
+#include &quot;hw/misc/empty_slot.h&quot;<br>
+#include &quot;hw/intc/i8259.h&quot;<br>
+#include &quot;hw/loader.h&quot;<br>
+#include &quot;hw/isa/superio.h&quot;<br>
+#include &quot;hw/pci/msi.h&quot;<br>
+#include &quot;hw/pci/pci.h&quot;<br>
+#include &quot;hw/pci/pci_host.h&quot;<br>
+#include &quot;hw/pci-host/gpex.h&quot;<br>
+#include &quot;hw/rtc/mc146818rtc.h&quot;<br>
+#include &quot;hw/usb.h&quot;<br>
+#include &quot;net/net.h&quot;<br>
+#include &quot;exec/address-spaces.h&quot;<br>
+#include &quot;sysemu/kvm.h&quot;<br>
+#include &quot;sysemu/qtest.h&quot;<br>
+#include &quot;sysemu/reset.h&quot;<br>
+#include &quot;sysemu/runstate.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;qemu/error-report.h&quot;<br>
+<br>
+#define PM_CNTL_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10<br>
+<br>
+/* Overall MMIO &amp; Memory layout */<br>
+enum {<br>
+=C2=A0 =C2=A0 VIRT_LOWMEM,<br>
+=C2=A0 =C2=A0 VIRT_PM,<br>
+=C2=A0 =C2=A0 VIRT_FW_CFG,<br>
+=C2=A0 =C2=A0 VIRT_RTC,<br>
+=C2=A0 =C2=A0 VIRT_PCIE_PIO,<br>
+=C2=A0 =C2=A0 VIRT_PCIE_ECAM,<br>
+=C2=A0 =C2=A0 VIRT_BIOS_ROM,<br>
+=C2=A0 =C2=A0 VIRT_UART,<br>
+=C2=A0 =C2=A0 VIRT_LIOINTC,<br>
+=C2=A0 =C2=A0 VIRT_PCIE_MMIO,<br>
+=C2=A0 =C2=A0 VIRT_HIGHMEM<br>
+};<br>
+<br>
+/* Low MEM layout for QEMU kernel loader */<br>
+enum {<br>
+=C2=A0 =C2=A0 LOADER_KERNEL,<br>
+=C2=A0 =C2=A0 LOADER_INITRD,<br>
+=C2=A0 =C2=A0 LOADER_CMDLINE<br>
+};<br>
+<br>
+/* BIOS ROM layout for QEMU kernel loader */<br>
+enum {<br>
+=C2=A0 =C2=A0 LOADER_BOOTROM,<br>
+=C2=A0 =C2=A0 LOADER_PARAM,<br>
+};<br>
+<br>
+struct MemmapEntry {<br>
+=C2=A0 =C2=A0 hwaddr base;<br>
+=C2=A0 =C2=A0 hwaddr size;<br>
+};<br>
+<br>
+/* Data for BIOS to identify machine */<br>
+#define FW_CFG_MACHINE_VERSION=C2=A0 (FW_CFG_ARCH_LOCAL + 0)<br>
+#define FW_CFG_CPU_FREQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(FW_CFG_ARCH_LOCA=
L + 1)<br>
+<br>
+/*<br>
+ * LEFI (a UEFI-like interface for BIOS-Kernel boot parameters) data struc=
trues<br>
+ * defined at arch/mips/include/asm/mach-<wbr>loongson64/boot_param.h in L=
inux kernel<br>
+ */<br>
+struct efi_memory_map_loongson {<br>
+=C2=A0 =C2=A0 uint16_t vers;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* version of efi_memory_map */<br>
+=C2=A0 =C2=A0 uint32_t nr_map;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* number of memory_maps */<br>
+=C2=A0 =C2=A0 uint32_t mem_freq;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* memory frequence */<br>
+=C2=A0 =C2=A0 struct mem_map {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t node_id;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
* node_id which memory attached to */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t mem_type;=C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* system memory, pci memory, pci io, etc. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t mem_start;=C2=A0 =C2=A0 =C2=A0 /* mem=
ory map start address */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t mem_size;=C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* each memory_map size, not the total size */<br>
+=C2=A0 =C2=A0 } map[128];<br>
+} __attribute__((packed));<br>
+<br>
+enum loongson_cpu_type {<br>
+=C2=A0 =C2=A0 Legacy_2E =3D 0x0,<br>
+=C2=A0 =C2=A0 Legacy_2F =3D 0x1,<br>
+=C2=A0 =C2=A0 Legacy_3A =3D 0x2,<br>
+=C2=A0 =C2=A0 Legacy_3B =3D 0x3,<br>
+=C2=A0 =C2=A0 Legacy_1A =3D 0x4,<br>
+=C2=A0 =C2=A0 Legacy_1B =3D 0x5,<br>
+=C2=A0 =C2=A0 Legacy_2G =3D 0x6,<br>
+=C2=A0 =C2=A0 Legacy_2H =3D 0x7,<br>
+=C2=A0 =C2=A0 Loongson_1A =3D 0x100,<br>
+=C2=A0 =C2=A0 Loongson_1B =3D 0x101,<br>
+=C2=A0 =C2=A0 Loongson_2E =3D 0x200,<br>
+=C2=A0 =C2=A0 Loongson_2F =3D 0x201,<br>
+=C2=A0 =C2=A0 Loongson_2G =3D 0x202,<br>
+=C2=A0 =C2=A0 Loongson_2H =3D 0x203,<br>
+=C2=A0 =C2=A0 Loongson_3A =3D 0x300,<br>
+=C2=A0 =C2=A0 Loongson_3B =3D 0x301<br>
+};<br>
+<br>
+/*<br>
+ * Capability and feature descriptor structure for MIPS CPU<br>
+ */<br>
+struct efi_cpuinfo_loongson {<br>
+=C2=A0 =C2=A0 uint16_t vers;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* version of efi_cpuinfo_loongson */<br>
+=C2=A0 =C2=A0 uint32_t processor_id;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* PRID, e.=
g. 6305, 6306 */<br>
+=C2=A0 =C2=A0 uint32_t cputype;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
* Loongson_3A/3B, etc. */<br>
+=C2=A0 =C2=A0 uint32_t total_node;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* num=
 of total numa nodes */<br>
+=C2=A0 =C2=A0 uint16_t cpu_startup_core_id;=C2=A0 =C2=A0/* Boot core id */=
<br>
+=C2=A0 =C2=A0 uint16_t reserved_cores_mask;<br>
+=C2=A0 =C2=A0 uint32_t cpu_clock_freq;=C2=A0 =C2=A0 =C2=A0/* cpu_clock */<=
br>
+=C2=A0 =C2=A0 uint32_t nr_cpus;<br>
+=C2=A0 =C2=A0 char cpuname[64];<br>
+} __attribute__((packed));<br>
+<br>
+#define MAX_UARTS 64<br>
+struct uart_device {<br>
+=C2=A0 =C2=A0 uint32_t iotype;<br>
+=C2=A0 =C2=A0 uint32_t uartclk;<br>
+=C2=A0 =C2=A0 uint32_t int_offset;<br>
+=C2=A0 =C2=A0 uint64_t uart_base;<br>
+} __attribute__((packed));<br>
+<br>
+#define MAX_SENSORS 64<br>
+#define SENSOR_TEMPER=C2=A0 0x00000001<br>
+#define SENSOR_VOLTAGE 0x00000002<br>
+#define SENSOR_FAN=C2=A0 =C2=A0 =C2=A00x00000004<br>
+struct sensor_device {<br>
+=C2=A0 =C2=A0 char name[32];=C2=A0 /* a formal name */<br>
+=C2=A0 =C2=A0 char label[64]; /* a flexible description */<br>
+=C2=A0 =C2=A0 uint32_t type;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* SENSOR_* */<br>
+=C2=A0 =C2=A0 uint32_t id;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* instance id=
 of a sensor-class */<br>
+=C2=A0 =C2=A0 uint32_t fan_policy; /* step speed or constant speed */<br>
+=C2=A0 =C2=A0 uint32_t fan_percent;/* only for constant speed policy */<br=
>
+=C2=A0 =C2=A0 uint64_t base_addr;=C2=A0 /* base address of device register=
s */<br>
+} __attribute__((packed));<br>
+<br>
+struct system_loongson {<br>
+=C2=A0 =C2=A0 uint16_t vers;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* version of system_loongson */<br>
+=C2=A0 =C2=A0 uint32_t ccnuma_smp;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 0: =
no numa; 1: has numa */<br>
+=C2=A0 =C2=A0 uint32_t sing_double_channel;/* 1: single; 2: double */<br>
+=C2=A0 =C2=A0 uint32_t nr_uarts;<br>
+=C2=A0 =C2=A0 struct uart_device uarts[MAX_UARTS];<br>
+=C2=A0 =C2=A0 uint32_t nr_sensors;<br>
+=C2=A0 =C2=A0 struct sensor_device sensors[MAX_SENSORS];<br>
+=C2=A0 =C2=A0 char has_ec;<br>
+=C2=A0 =C2=A0 char ec_name[32];<br>
+=C2=A0 =C2=A0 uint64_t ec_base_addr;<br>
+=C2=A0 =C2=A0 char has_tcm;<br>
+=C2=A0 =C2=A0 char tcm_name[32];<br>
+=C2=A0 =C2=A0 uint64_t tcm_base_addr;<br>
+=C2=A0 =C2=A0 uint64_t workarounds;<br>
+=C2=A0 =C2=A0 uint64_t of_dtb_addr; /* NULL if not support */<br>
+} __attribute__((packed));<br>
+<br>
+struct irq_source_routing_table {<br>
+=C2=A0 =C2=A0 uint16_t vers;<br>
+=C2=A0 =C2=A0 uint16_t size;<br>
+=C2=A0 =C2=A0 uint16_t rtr_bus;<br>
+=C2=A0 =C2=A0 uint16_t rtr_devfn;<br>
+=C2=A0 =C2=A0 uint32_t vendor;<br>
+=C2=A0 =C2=A0 uint32_t device;<br>
+=C2=A0 =C2=A0 uint32_t PIC_type;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* conform use HT or PCI to route to CPU-PIC */<br>
+=C2=A0 =C2=A0 uint64_t ht_int_bit;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 3A:=
 1&lt;&lt;24; 3B: 1&lt;&lt;16 */<br>
+=C2=A0 =C2=A0 uint64_t ht_enable;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* irq=
s used in this PIC */<br>
+=C2=A0 =C2=A0 uint32_t node_id;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /=
* node id: 0x0-0; 0x1-1; 0x10-2; 0x11-3 */<br>
+=C2=A0 =C2=A0 uint64_t pci_mem_start_addr;<br>
+=C2=A0 =C2=A0 uint64_t pci_mem_end_addr;<br>
+=C2=A0 =C2=A0 uint64_t pci_io_start_addr;<br>
+=C2=A0 =C2=A0 uint64_t pci_io_end_addr;<br>
+=C2=A0 =C2=A0 uint64_t pci_config_addr;<br>
+=C2=A0 =C2=A0 uint16_t dma_mask_bits;<br>
+=C2=A0 =C2=A0 uint16_t dma_noncoherent;<br>
+} __attribute__((packed));<br>
+<br>
+struct interface_info {<br>
+=C2=A0 =C2=A0 uint16_t vers;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* version of the specificition */<br>
+=C2=A0 =C2=A0 uint16_t size;<br>
+=C2=A0 =C2=A0 uint8_t=C2=A0 flag;<br>
+=C2=A0 =C2=A0 char description[64];<br>
+} __attribute__((packed));<br>
+<br>
+#define MAX_RESOURCE_NUMBER 128<br>
+struct resource_loongson {<br>
+=C2=A0 =C2=A0 uint64_t start;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* resource start address */<br>
+=C2=A0 =C2=A0 uint64_t end;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* resource end address */<br>
+=C2=A0 =C2=A0 char name[64];<br>
+=C2=A0 =C2=A0 uint32_t flags;<br>
+};<br>
+<br>
+struct archdev_data {};=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* arch specific=
 additions */<br>
+<br>
+struct board_devices {<br>
+=C2=A0 =C2=A0 char name[64];=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* hold the device name */<br>
+=C2=A0 =C2=A0 uint32_t num_resources;=C2=A0 =C2=A0 =C2=A0 /* number of dev=
ice_resource */<br>
+=C2=A0 =C2=A0 /* for each device&#39;s resource */<br>
+=C2=A0 =C2=A0 struct resource_loongson resource[MAX_RESOURCE_NUMBER];<br>
+=C2=A0 =C2=A0 /* arch specific additions */<br>
+=C2=A0 =C2=A0 struct archdev_data archdata;<br>
+};<br>
+<br>
+struct loongson_special_attribute {<br>
+=C2=A0 =C2=A0 uint16_t vers;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* version of this special */<br>
+=C2=A0 =C2=A0 char special_name[64];=C2=A0 =C2=A0 =C2=A0 =C2=A0/* special_=
atribute_name */<br>
+=C2=A0 =C2=A0 uint32_t loongson_special_type; /* type of special device */=
<br>
+=C2=A0 =C2=A0 /* for each device&#39;s resource */<br>
+=C2=A0 =C2=A0 struct resource_loongson resource[MAX_RESOURCE_NUMBER];<br>
+};<br>
+<br>
+struct loongson_params {<br>
+=C2=A0 =C2=A0 uint64_t memory_offset;=C2=A0 =C2=A0 =C2=A0 /* efi_memory_ma=
p_loongson struct offset */<br>
+=C2=A0 =C2=A0 uint64_t cpu_offset;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* efi=
_cpuinfo_loongson struct offset */<br>
+=C2=A0 =C2=A0 uint64_t system_offset;=C2=A0 =C2=A0 =C2=A0 /* system_loongs=
on struct offset */<br>
+=C2=A0 =C2=A0 uint64_t irq_offset;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* irq=
_source_routing_table struct offset */<br>
+=C2=A0 =C2=A0 uint64_t interface_offset;=C2=A0 =C2=A0/* interface_info str=
uct offset */<br>
+=C2=A0 =C2=A0 uint64_t special_offset;=C2=A0 =C2=A0 =C2=A0/* loongson_spec=
ial_attribute struct offset */<br>
+=C2=A0 =C2=A0 uint64_t boarddev_table_offset;=C2=A0 /* board_devices offse=
t */<br>
+};<br>
+<br>
+struct smbios_tables {<br>
+=C2=A0 =C2=A0 uint16_t vers;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* version of smbios */<br>
+=C2=A0 =C2=A0 uint64_t vga_bios;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* vga_bios address */<br>
+=C2=A0 =C2=A0 struct loongson_params lp;<br>
+};<br>
+<br>
+struct efi_reset_system_t {<br>
+=C2=A0 =C2=A0 uint64_t ResetCold;<br>
+=C2=A0 =C2=A0 uint64_t ResetWarm;<br>
+=C2=A0 =C2=A0 uint64_t ResetType;<br>
+=C2=A0 =C2=A0 uint64_t Shutdown;<br>
+=C2=A0 =C2=A0 uint64_t DoSuspend; /* NULL if not support */<br>
+};<br>
+<br>
+struct efi_loongson {<br>
+=C2=A0 =C2=A0 uint64_t mps;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* MPS table */<br>
+=C2=A0 =C2=A0 uint64_t acpi;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* ACPI table (IA64 ext 0.71) */<br>
+=C2=A0 =C2=A0 uint64_t acpi20;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* ACPI table (ACPI 2.0) */<br>
+=C2=A0 =C2=A0 struct smbios_tables smbios; /* SM BIOS table */<br>
+=C2=A0 =C2=A0 uint64_t sal_systab;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* SAL=
 system table */<br>
+=C2=A0 =C2=A0 uint64_t boot_info;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* boo=
t info table */<br>
+};<br>
+<br>
+struct boot_params {<br>
+=C2=A0 =C2=A0 struct efi_loongson efi;<br>
+=C2=A0 =C2=A0 struct efi_reset_system_t reset_system;<br>
+};<br>
+<br>
+#define LOONGSON_MAX_VCPUS=C2=A0 =C2=A0 =C2=A0 16<br>
+<br>
+#define LOONGSON3_BIOSNAME &quot;bios_loongson3.bin&quot;<br>
+<br>
+#define UART_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
+#define RTC_IRQ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
+#define PCIE_IRQ_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
+<br>
+#define align(x) (((x) + 63) &amp; ~63)<br>
+<br>
+static const struct MemmapEntry virt_memmap[] =3D {<br>
+=C2=A0 =C2=A0 [VIRT_LOWMEM] =3D=C2=A0 =C2=A0 =C2=A0 { 0x00000000,=C2=A0 =
=C2=A0 0x10000000 },<br>
+=C2=A0 =C2=A0 [VIRT_PM] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x10080000=
,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x100 },<br>
+=C2=A0 =C2=A0 [VIRT_FW_CFG] =3D=C2=A0 =C2=A0 =C2=A0 { 0x10080100,=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x100 },<br>
+=C2=A0 =C2=A0 [VIRT_RTC] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ 0x10081000=
,=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1000 },<br>
+=C2=A0 =C2=A0 [VIRT_PCIE_PIO] =3D=C2=A0 =C2=A0 { 0x18000000,=C2=A0 =C2=A0 =
=C2=A0 =C2=A00xc0000 },<br>
+=C2=A0 =C2=A0 [VIRT_PCIE_ECAM] =3D=C2=A0 =C2=A0{ 0x1a000000,=C2=A0 =C2=A0 =
=C2=A00x2000000 },<br>
+=C2=A0 =C2=A0 [VIRT_BIOS_ROM] =3D=C2=A0 =C2=A0 { 0x1fc00000,=C2=A0 =C2=A0 =
=C2=A0 0x200000 },<br>
+=C2=A0 =C2=A0 [VIRT_UART] =3D=C2=A0 =C2=A0 =C2=A0 =C2=A0 { 0x1fe001e0,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x8 },<br>
+=C2=A0 =C2=A0 [VIRT_LIOINTC] =3D=C2=A0 =C2=A0 =C2=A0{ 0x3ff01400,=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x64 },<br>
+=C2=A0 =C2=A0 [VIRT_PCIE_MMIO] =3D=C2=A0 =C2=A0{ 0x40000000,=C2=A0 =C2=A0 =
0x40000000 },<br>
+=C2=A0 =C2=A0 [VIRT_HIGHMEM] =3D=C2=A0 =C2=A0 =C2=A0{ 0x80000000,=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0 }, /* Variable */<br>
+};<br>
+<br>
+static const struct MemmapEntry loader_memmap[] =3D {<br>
+=C2=A0 =C2=A0 [LOADER_KERNEL] =3D=C2=A0 =C2=A0 { 0x00000000,=C2=A0 =C2=A0 =
=C2=A00x4000000 },<br>
+=C2=A0 =C2=A0 [LOADER_INITRD] =3D=C2=A0 =C2=A0 { 0x04000000,=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A00x0 }, /* Variable */<br>
+=C2=A0 =C2=A0 [LOADER_CMDLINE] =3D=C2=A0 =C2=A0{ 0x0ff00000,=C2=A0 =C2=A0 =
=C2=A0 0x100000 },<br>
+};<br>
+<br>
+static const struct MemmapEntry loader_rommap[] =3D {<br>
+=C2=A0 =C2=A0 [LOADER_BOOTROM] =3D=C2=A0 =C2=A0{ 0x1fc00000,=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 0x1000 },<br>
+=C2=A0 =C2=A0 [LOADER_PARAM] =3D=C2=A0 =C2=A0 =C2=A0{ 0x1fc01000,=C2=A0 =
=C2=A0 =C2=A0 =C2=A00x10000 },<br>
+};<br>
+<br>
+static struct _loaderparams {<br>
+=C2=A0 =C2=A0 uint64_t ram_size;<br>
+=C2=A0 =C2=A0 const char *kernel_cmdline;<br>
+=C2=A0 =C2=A0 const char *kernel_filename;<br>
+=C2=A0 =C2=A0 const char *initrd_filename;<br>
+=C2=A0 =C2=A0 uint64_t kernel_entry;<br>
+=C2=A0 =C2=A0 uint64_t a0, a1, a2;<br>
+} loaderparams;<br>
+<br>
+static uint64_t loongson3_pm_read(void *opaque, hwaddr addr, unsigned size=
)<br>
+{<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static void loongson3_pm_write(void *opaque, hwaddr addr, uint64_t val, un=
signed size)<br>
+{<br>
+=C2=A0 =C2=A0 if (addr !=3D PM_CNTL_MODE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 switch (val) {<br>
+=C2=A0 =C2=A0 case 0x00:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_reset_request(<wbr>SHUTDOWN_CAUSE_=
GUEST_RESET);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 case 0xff:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_system_shutdown_request(<wbr>SHUTDOWN_CAU=
SE_GUEST_SHUTDOWN)<wbr>;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static const MemoryRegionOps loongson3_pm_ops =3D {<br>
+=C2=A0 =C2=A0 .read=C2=A0 =3D loongson3_pm_read,<br>
+=C2=A0 =C2=A0 .write =3D loongson3_pm_write,<br>
+=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
+};<br>
+<br>
+static struct efi_memory_map_loongson *init_memory_map(void *g_map)<br>
+{<br>
+=C2=A0 =C2=A0 struct efi_memory_map_loongson *emap =3D g_map;<br>
+<br>
+=C2=A0 =C2=A0 emap-&gt;nr_map =3D 2;<br>
+=C2=A0 =C2=A0 emap-&gt;mem_freq =3D 300000000;<br>
+<br>
+=C2=A0 =C2=A0 emap-&gt;map[0].node_id =3D 0;<br>
+=C2=A0 =C2=A0 emap-&gt;map[0].mem_type =3D 1;<br>
+=C2=A0 =C2=A0 emap-&gt;map[0].mem_start =3D 0x0;<br>
+=C2=A0 =C2=A0 emap-&gt;map[0].mem_size =3D (loaderparams.ram_size &gt; 0x1=
0000000<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ? 256 : (loaderparams.ram_size &gt;&gt; 20)) - 16;=
<br>
+<br>
+=C2=A0 =C2=A0 emap-&gt;map[1].node_id =3D 0;<br>
+=C2=A0 =C2=A0 emap-&gt;map[1].mem_type =3D 2;<br>
+=C2=A0 =C2=A0 emap-&gt;map[1].mem_start =3D 0x90000000;<br>
+=C2=A0 =C2=A0 emap-&gt;map[1].mem_size =3D (loaderparams.ram_size &gt; 0x1=
0000000<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ? (loaderparams.ram_size &gt;&gt; 20) - 256 : 0);<=
br>
+<br>
+=C2=A0 =C2=A0 return emap;<br>
+}<br>
+<br>
+#define BUFLEN 1024<br>
+<br>
+static uint32_t get_cpu_freq(void)<br>
+{<br>
+=C2=A0 =C2=A0 int fd =3D 0, freq =3D 0;<br>
+=C2=A0 =C2=A0 char buf[BUFLEN], *buf_p;<br>
+<br>
+=C2=A0 =C2=A0 fd =3D open(&quot;/proc/cpuinfo&quot;, O_RDONLY);<br>
+=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Failed to open /proc/cpu=
info!\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (read(fd, buf, BUFLEN) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Failed to read /proc/cpu=
info!\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 close(fd);<br>
+<br>
+=C2=A0 =C2=A0 buf_p =3D strstr(buf, &quot;model name&quot;);<br>
+=C2=A0 =C2=A0 while (*buf_p !=3D &#39;@&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_p++;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 buf_p +=3D 2;<br>
+=C2=A0 =C2=A0 memcpy(buf, buf_p, 12);<br>
+=C2=A0 =C2=A0 buf_p =3D buf;<br>
+=C2=A0 =C2=A0 while ((*buf_p &gt;=3D &#39;0&#39;) &amp;&amp; (*buf_p &lt;=
=3D &#39;9&#39;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf_p++;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 *buf_p =3D &#39;\0&#39;;<br>
+<br>
+=C2=A0 =C2=A0 freq =3D atoi(buf);<br>
+<br>
+=C2=A0 =C2=A0 return freq * 1000 * 1000;<br>
+}<br>
+<br>
+static struct efi_cpuinfo_loongson *init_cpu_info(void *g_cpuinfo_loongson=
)<br>
+{<br>
+=C2=A0 =C2=A0 struct efi_cpuinfo_loongson *c =3D g_cpuinfo_loongson;<br>
+<br>
+=C2=A0 =C2=A0 c-&gt;cputype =3D Loongson_3A;<br>
+=C2=A0 =C2=A0 c-&gt;processor_id =3D MIPS_CPU(first_cpu)-&gt;env.CP0_<wbr>=
PRid;<br>
+=C2=A0 =C2=A0 c-&gt;cpu_clock_freq =3D get_cpu_freq();<br>
+=C2=A0 =C2=A0 if (!c-&gt;cpu_clock_freq) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c-&gt;cpu_clock_freq =3D 500000000;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 c-&gt;cpu_startup_core_id =3D 0;<br>
+=C2=A0 =C2=A0 c-&gt;nr_cpus =3D current_machine-&gt;smp.cpus;<br>
+=C2=A0 =C2=A0 c-&gt;total_node =3D (current_machine-&gt;smp.cpus + 3) / 4;=
<br>
+<br>
+=C2=A0 =C2=A0 return c;<br>
+}<br>
+<br>
+static struct system_loongson *init_system_loongson(void *g_system)<br>
+{<br>
+=C2=A0 =C2=A0 struct system_loongson *s =3D g_system;<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;ccnuma_smp =3D 0;<br>
+=C2=A0 =C2=A0 s-&gt;sing_double_channel =3D 1;<br>
+=C2=A0 =C2=A0 s-&gt;nr_uarts =3D 1;<br>
+=C2=A0 =C2=A0 s-&gt;uarts[0].iotype =3D 2;<br>
+=C2=A0 =C2=A0 s-&gt;uarts[0].int_offset =3D 2;<br>
+=C2=A0 =C2=A0 s-&gt;uarts[0].uartclk =3D 25000000; /* Random value */<br>
+=C2=A0 =C2=A0 s-&gt;uarts[0].uart_base =3D virt_memmap[VIRT_UART].base;<br=
>
+<br>
+=C2=A0 =C2=A0 return s;<br>
+}<br>
+<br>
+static struct irq_source_routing_table *init_irq_source(void *g_irq_source=
)<br>
+{<br>
+=C2=A0 =C2=A0 struct irq_source_routing_table *irq_info =3D g_irq_source;<=
br>
+<br>
+=C2=A0 =C2=A0 irq_info-&gt;node_id =3D 0;<br>
+=C2=A0 =C2=A0 irq_info-&gt;PIC_type =3D 0;<br>
+=C2=A0 =C2=A0 irq_info-&gt;dma_mask_bits =3D 64;<br>
+=C2=A0 =C2=A0 irq_info-&gt;pci_mem_start_addr =3D virt_memmap[VIRT_PCIE_MM=
IO].<wbr>base;<br>
+=C2=A0 =C2=A0 irq_info-&gt;pci_mem_end_addr=C2=A0 =C2=A0=3D virt_memmap[VI=
RT_PCIE_MMIO].<wbr>base +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virt_memmap[VIRT_PCIE_M=
MIO].<wbr>size - 1;<br>
+=C2=A0 =C2=A0 irq_info-&gt;pci_io_start_addr=C2=A0 =3D virt_memmap[VIRT_PC=
IE_PIO].<wbr>base;<br>
+<br>
+=C2=A0 =C2=A0 return irq_info;<br>
+}<br>
+<br>
+static struct interface_info *init_interface_info(void *g_interface)<br>
+{<br>
+=C2=A0 =C2=A0 struct interface_info *interface =3D g_interface;<br>
+<br>
+=C2=A0 =C2=A0 interface-&gt;vers =3D 0x01;<br>
+=C2=A0 =C2=A0 strcpy(interface-&gt;description, &quot;UEFI_Version_v1.0&qu=
ot;);<br>
+<br>
+=C2=A0 =C2=A0 return interface;<br>
+}<br>
+<br>
+static struct board_devices *board_devices_info(void *g_board)<br>
+{<br>
+=C2=A0 =C2=A0 struct board_devices *bd =3D g_board;<br>
+<br>
+=C2=A0 =C2=A0 strcpy(bd-&gt;name, &quot;Loongson-3A-VIRT-1w-V1.00-<wbr>dem=
o&quot;);<br>
+<br>
+=C2=A0 =C2=A0 return bd;<br>
+}<br>
+<br>
+static struct loongson_special_attribute *init_special_info(void *g_specia=
l)<br>
+{<br>
+=C2=A0 =C2=A0 struct loongson_special_attribute *special =3D g_special;<br=
>
+<br>
+=C2=A0 =C2=A0 strcpy(special-&gt;special_name, &quot;2016-08-01&quot;);<br=
>
+<br>
+=C2=A0 =C2=A0 return special;<br>
+}<br>
+<br>
+static void init_loongson_params(struct loongson_params *lp, void *p)<br>
+{<br>
+=C2=A0 =C2=A0 lp-&gt;memory_offset =3D (unsigned long long)init_memory_map=
(p)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 - (unsigned long long)lp;<br>
+=C2=A0 =C2=A0 p +=3D align(sizeof(struct efi_memory_map_loongson));<br>
+<br>
+=C2=A0 =C2=A0 lp-&gt;cpu_offset =3D (unsigned long long)init_cpu_info(p)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0- (unsigned long long)lp;<br>
+=C2=A0 =C2=A0 p +=3D align(sizeof(struct efi_cpuinfo_loongson));<br>
+<br>
+=C2=A0 =C2=A0 lp-&gt;system_offset =3D (unsigned long long)init_system_loo=
ngson(p)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 - (unsigned long long)lp;<br>
+=C2=A0 =C2=A0 p +=3D align(sizeof(struct system_loongson));<br>
+<br>
+=C2=A0 =C2=A0 lp-&gt;irq_offset =3D (unsigned long long)init_irq_source(p)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0- (unsigned long long)lp;<br>
+=C2=A0 =C2=A0 p +=3D align(sizeof(struct irq_source_routing_table));<br>
+<br>
+=C2=A0 =C2=A0 lp-&gt;interface_offset =3D (unsigned long long)init_interfa=
ce_info(p)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0- (unsigned long long)lp;<br>
+=C2=A0 =C2=A0 p +=3D align(sizeof(struct interface_info));<br>
+<br>
+=C2=A0 =C2=A0 lp-&gt;boarddev_table_offset =3D (unsigned long long)board_d=
evices_info(p)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - (unsigned long long)lp;<br>
+=C2=A0 =C2=A0 p +=3D align(sizeof(struct board_devices));<br>
+<br>
+=C2=A0 =C2=A0 lp-&gt;special_offset =3D (unsigned long long)init_special_i=
nfo(p)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0- (unsigned long long)lp;<br>
+=C2=A0 =C2=A0 p +=3D align(sizeof(struct loongson_special_attribute));<br>
+}<br>
+<br>
+static void init_reset_system(struct efi_reset_system_t *reset)<br>
+{<br>
+=C2=A0 =C2=A0 reset-&gt;Shutdown =3D 0xffffffffbfc000a8;<br>
+=C2=A0 =C2=A0 reset-&gt;ResetCold =3D 0xffffffffbfc00080;<br>
+=C2=A0 =C2=A0 reset-&gt;ResetWarm =3D 0xffffffffbfc00080;<br>
+}<br>
+<br>
+static void init_boot_param(void)<br>
+{<br>
+=C2=A0 =C2=A0 void *p;<br>
+=C2=A0 =C2=A0 struct boot_params *bp;<br>
+<br>
+=C2=A0 =C2=A0 p =3D g_malloc0(loader_rommap[<wbr>LOADER_PARAM].size);<br>
+=C2=A0 =C2=A0 bp =3D p;<br>
+<br>
+=C2=A0 =C2=A0 bp-&gt;efi.smbios.vers =3D 1;<br>
+=C2=A0 =C2=A0 init_reset_system(&amp;(bp-&gt;reset_<wbr>system));<br>
+=C2=A0 =C2=A0 p +=3D align(sizeof(struct boot_params));<br>
+=C2=A0 =C2=A0 init_loongson_params(&amp;(bp-&gt;<wbr>efi.smbios.lp), p);<b=
r>
+<br>
+=C2=A0 =C2=A0 rom_add_blob_fixed(&quot;params_<wbr>rom&quot;, bp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0loader_rommap[LOADER_PARAM].<wbr>size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0loader_rommap[LOADER_PARAM].<wbr>base);<br>
+<br>
+=C2=A0 =C2=A0 g_free(bp);<br>
+<br>
+=C2=A0 =C2=A0 loaderparams.a2 =3D cpu_mips_phys_to_kseg0(NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0loader_rommap[LOADER_PARAM].<wbr>base);<br>
+}<br>
+<br>
+static void init_boot_rom(void)<br>
+{<br>
+=C2=A0 =C2=A0 const unsigned int boot_code[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x40086000,=C2=A0 =C2=A0/* mfc0=C2=A0 =C2=A0 t=
0, CP0_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x240900E4,=C2=A0 =C2=A0/* li=C2=A0 =C2=A0 =C2=
=A0 t1, 0xe4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#set kx, sx, ux, erl=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01094025,=C2=A0 =C2=A0/* or=C2=A0 =C2=A0 =C2=
=A0 t0, t0, t1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3C090040,=C2=A0 =C2=A0/* lui=C2=A0 =C2=A0 =
=C2=A0t1, 0x40=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#set bev=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01094025,=C2=A0 =C2=A0/* or=C2=A0 =C2=A0 =C2=
=A0 t0, t0, t1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x40886000,=C2=A0 =C2=A0/* mtc0=C2=A0 =C2=A0 t=
0, CP0_STATUS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x40806800,=C2=A0 =C2=A0/* mtc0=C2=A0 =C2=A0 z=
ero, CP0_CAUSE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x400A7801,=C2=A0 =C2=A0/* mfc0=C2=A0 =C2=A0 t=
2, $15, 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x314A00FF,=C2=A0 =C2=A0/* andi=C2=A0 =C2=A0 t=
2, 0x0ff=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3C089000,=C2=A0 =C2=A0/* dli=C2=A0 =C2=A0 =
=C2=A0t0, 0x900000003ff01000=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00084438,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x35083FF0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00084438,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x35081000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x314B0003,=C2=A0 =C2=A0/* andi=C2=A0 =C2=A0 t=
3, t2, 0x3=C2=A0 =C2=A0 =C2=A0 #local cpuid=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000B5A00,=C2=A0 =C2=A0/* sll=C2=A0 =C2=A0 =
=C2=A0t3, 8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x010B4025,=C2=A0 =C2=A0/* or=C2=A0 =C2=A0 =C2=
=A0 t0, t0, t3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x314C000C,=C2=A0 =C2=A0/* andi=C2=A0 =C2=A0 t=
4, t2, 0xc=C2=A0 =C2=A0 =C2=A0 #node id=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000C62BC,=C2=A0 =C2=A0/* dsll=C2=A0 =C2=A0 t=
4, 42=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x010C4025,=C2=A0 =C2=A0/* or=C2=A0 =C2=A0 =C2=
=A0 t0, t0, t4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* WaitForInit:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xDD020020,=C2=A0 =C2=A0/* ld=C2=A0 =C2=A0 =C2=
=A0 v0, FN_OFF(t0)=C2=A0 =C2=A0#FN_OFF 0x020=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1040FFFE,=C2=A0 =C2=A0/* beqz=C2=A0 =C2=A0 v=
0, WaitForInit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000000,=C2=A0 =C2=A0/* nop=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xDD1D0028,=C2=A0 =C2=A0/* ld=C2=A0 =C2=A0 =C2=
=A0 sp, SP_OFF(t0)=C2=A0 =C2=A0#FN_OFF 0x028=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xDD1C0030,=C2=A0 =C2=A0/* ld=C2=A0 =C2=A0 =C2=
=A0 gp, GP_OFF(t0)=C2=A0 =C2=A0#FN_OFF 0x030=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xDD050038,=C2=A0 =C2=A0/* ld=C2=A0 =C2=A0 =C2=
=A0 a1, A1_OFF(t0)=C2=A0 =C2=A0#FN_OFF 0x038=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00400008,=C2=A0 =C2=A0/* jr=C2=A0 =C2=A0 =C2=
=A0 v0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#byebye=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000000,=C2=A0 =C2=A0/* nop=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1000FFFF,=C2=A0 =C2=A0/* 1:=C2=A0 b=C2=A0 =
=C2=A01b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000000,=C2=A0 =C2=A0/* nop=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 */<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Reset=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3C0C9000,=C2=A0 =C2=A0/* dli=C2=A0 =C2=A0 =
=C2=A0t0, 0x9000000010080010=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x358C0000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000C6438,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x358C1008,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000C6438,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x358C0010,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x240D0000,=C2=A0 =C2=A0/* li=C2=A0 =C2=A0 =C2=
=A0 t1, 0x00=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xA18D0000,=C2=A0 =C2=A0/* sb=C2=A0 =C2=A0 =C2=
=A0 t1, (t0)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1000FFFF,=C2=A0 =C2=A0/* 1:=C2=A0 b=C2=A0 =
=C2=A01b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000000,=C2=A0 =C2=A0/* nop=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 */<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Shutdown=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3C0C9000,=C2=A0 =C2=A0/* dli=C2=A0 =C2=A0 =
=C2=A0t0, 0x9000000010080010=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x358C0000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000C6438,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x358C1008,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000C6438,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x358C0010,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x240D00FF,=C2=A0 =C2=A0/* li=C2=A0 =C2=A0 =C2=
=A0 t1, 0xff=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xA18D0000,=C2=A0 =C2=A0/* sb=C2=A0 =C2=A0 =C2=
=A0 t1, (t0)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1000FFFF,=C2=A0 =C2=A0/* 1:=C2=A0 b=C2=A0 =
=C2=A01b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00000000=C2=A0 =C2=A0 /* nop=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 };<br>
+<br>
+=C2=A0 =C2=A0 rom_add_blob_fixed(&quot;boot_rom&quot;, boot_code, sizeof(b=
oot_code),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 loader_rommap[LOADER_BOOTROM].<wbr>base);<br>
+}<br>
+<br>
+static void fw_cfg_boot_set(void *opaque, const char *boot_device,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 fw_cfg_modify_i16(opaque, FW_CFG_BOOT_DEVICE, boot_device[0]=
);<br>
+}<br>
+<br>
+static void fw_conf_init(unsigned long ram_size)<br>
+{<br>
+=C2=A0 =C2=A0 FWCfgState *fw_cfg;<br>
+=C2=A0 =C2=A0 hwaddr cfg_addr =3D virt_memmap[VIRT_FW_CFG].base;<br>
+<br>
+=C2=A0 =C2=A0 fw_cfg =3D fw_cfg_init_mem_wide(cfg_addr, cfg_addr + 8, 8, 0=
, NULL);<br>
+=C2=A0 =C2=A0 fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)current_mac=
hine-&gt;<wbr>smp.cpus);<br>
+=C2=A0 =C2=A0 fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_ma=
chine-&gt;<wbr>smp.max_cpus);<br>
+=C2=A0 =C2=A0 fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);=
<br>
+=C2=A0 =C2=A0 fw_cfg_add_i32(fw_cfg, FW_CFG_MACHINE_VERSION, 1);<br>
+=C2=A0 =C2=A0 fw_cfg_add_i32(fw_cfg, FW_CFG_CPU_FREQ, get_cpu_freq());<br>
+=C2=A0 =C2=A0 qemu_register_boot_set(fw_cfg_<wbr>boot_set, fw_cfg);<br>
+}<br>
+<br>
+static int set_prom_cmdline(ram_addr_t initrd_offset, long initrd_size)<br=
>
+{<br>
+=C2=A0 =C2=A0 hwaddr cmdline_vaddr;<br>
+=C2=A0 =C2=A0 char memenv[32];<br>
+=C2=A0 =C2=A0 char highmemenv[32];<br>
+=C2=A0 =C2=A0 void *cmdline_buf;<br>
+=C2=A0 =C2=A0 unsigned int *parg_env;<br>
+=C2=A0 =C2=A0 int ret =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 /* Allocate cmdline_buf for command line. */<br>
+=C2=A0 =C2=A0 cmdline_buf =3D g_malloc0(loader_memmap[<wbr>LOADER_CMDLINE]=
.size);<br>
+=C2=A0 =C2=A0 cmdline_vaddr =3D cpu_mips_phys_to_kseg0(NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0loader_memmap[LOADER_CMDLINE].<wbr>base);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Layout of cmdline_buf looks like this:<br>
+=C2=A0 =C2=A0 =C2=A0* argv[0], argv[1], 0, env[0], env[1], ... env[i], 0,<=
br>
+=C2=A0 =C2=A0 =C2=A0* argv[0]&#39;s data, argv[1]&#39;s data, env[0]&#39;d=
ata, ..., env[i]&#39;s data, 0<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 parg_env =3D (void *)cmdline_buf;<br>
+<br>
+=C2=A0 =C2=A0 ret =3D (3 + 1) * 4;<br>
+=C2=A0 =C2=A0 *parg_env++ =3D cmdline_vaddr + ret;<br>
+=C2=A0 =C2=A0 ret +=3D (1 + snprintf(cmdline_buf + ret, 256 - ret, &quot;g=
&quot;));<br>
+<br>
+=C2=A0 =C2=A0 /* argv1 */<br>
+=C2=A0 =C2=A0 *parg_env++ =3D cmdline_vaddr + ret;<br>
+=C2=A0 =C2=A0 if (initrd_size &gt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D (1 + snprintf(cmdline_buf + ret, 256 =
- ret,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rd_start=3D0=
x&quot; TARGET_FMT_lx &quot; rd_size=3D%li %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mips_phys_to_k=
seg0(NULL, initrd_offset),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_size, loade=
rparams.kernel_cmdline));<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D (1 + snprintf(cmdline_buf + ret, 256 =
- ret, &quot;%s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loaderparams.kerne=
l_cmdline));<br>
+<br>
+=C2=A0 =C2=A0 /* argv2 */<br>
+=C2=A0 =C2=A0 *parg_env++ =3D cmdline_vaddr + 4 * ret;<br>
+<br>
+=C2=A0 =C2=A0 /* env */<br>
+=C2=A0 =C2=A0 sprintf(memenv, &quot;%ld&quot;, loaderparams.ram_size &gt; =
0x10000000<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? 256 : (loaderparams.ram_size &=
gt;&gt; 20));<br>
+=C2=A0 =C2=A0 sprintf(highmemenv, &quot;%ld&quot;, loaderparams.ram_size &=
gt; 0x10000000<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ? (loaderparams.ram_size &gt;&gt=
; 20) - 256 : 0);<br>
+<br>
+=C2=A0 =C2=A0 rom_add_blob_fixed(&quot;cmdline&quot;, cmdline_buf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0loader_memmap[LOADER_CMDLINE].<wbr>size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0loader_memmap[LOADER_CMDLINE].<wbr>base);<br>
+<br>
+=C2=A0 =C2=A0 g_free(cmdline_buf);<br>
+<br>
+=C2=A0 =C2=A0 loaderparams.a0 =3D 2;<br>
+=C2=A0 =C2=A0 loaderparams.a1 =3D cmdline_vaddr;<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static uint64_t load_kernel(CPUMIPSState *env)<br>
+{<br>
+=C2=A0 =C2=A0 long kernel_size;<br>
+=C2=A0 =C2=A0 ram_addr_t initrd_offset;<br>
+=C2=A0 =C2=A0 uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;=
<br>
+<br>
+=C2=A0 =C2=A0 kernel_size =3D load_elf(loaderparams.kernel_<wbr>filename, =
NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0cpu_mips_kseg0_to_phys, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_entry,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(uint64_t *)&amp;kernel_low, (uint64_t *)&amp;kerne=
l_high,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL, 0, EM_MIPS, 1, 0);<br>
+=C2=A0 =C2=A0 if (kernel_size &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;could not load kernel &#39;=
%s&#39;: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0loaderparams.kernel_filename,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0load_elf_strerror(kernel_size)<wbr>);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* load initrd */<br>
+=C2=A0 =C2=A0 initrd_size =3D 0;<br>
+=C2=A0 =C2=A0 initrd_offset =3D 0;<br>
+=C2=A0 =C2=A0 if (loaderparams.initrd_filename) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_size =3D get_image_size(loaderparams.<w=
br>initrd_filename);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (initrd_size &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_offset =3D (kernel_high +=
 ~INITRD_PAGE_MASK) &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 INITRD_PAGE_MASK;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_offset =3D MAX(initrd_off=
set,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loader_memmap[LOADER_INITRD].<wbr>ba=
se);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (initrd_offset + initrd_size =
&gt; ram_size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot=
;memory too small for initial ram disk &#39;%s&#39;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loaderparams.initrd_filename);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_size =3D load_image_targp=
hys(<wbr>loaderparams.initrd_filename,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 initrd_offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ram_size - initrd_offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (initrd_size =3D=3D (target_ulong) -1) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;could not loa=
d initial ram disk &#39;%s&#39;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0loaderparams.initrd_filename);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Setup prom cmdline. */<br>
+=C2=A0 =C2=A0 set_prom_cmdline(initrd_<wbr>offset, initrd_size);<br>
+<br>
+=C2=A0 =C2=A0 return kernel_entry;<br>
+}<br>
+<br>
+static void main_cpu_reset(void *opaque)<br>
+{<br>
+=C2=A0 =C2=A0 MIPSCPU *cpu =3D opaque;<br>
+=C2=A0 =C2=A0 CPUMIPSState *env =3D &amp;cpu-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 cpu_reset(CPU(cpu));<br>
+<br>
+=C2=A0 =C2=A0 /* Loongson-3 reset stuff */<br>
+=C2=A0 =C2=A0 if (loaderparams.kernel_filename) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu =3D=3D MIPS_CPU(first_cpu)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;active_tc.gpr[4] =3D loa=
derparams.a0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;active_tc.gpr[5] =3D loa=
derparams.a1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;active_tc.gpr[6] =3D loa=
derparams.a2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;active_tc.PC =3D loaderp=
arams.kernel_entry;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_Status &amp;=3D ~((1 &lt;&lt; CP0S=
t_BEV) | (1 &lt;&lt; CP0St_ERL));<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static inline void loongson3_virt_devices_init(<wbr>MachineState *machine,=
 DeviceState *pic)<br>
+{<br>
+=C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 qemu_irq irq;<br>
+=C2=A0 =C2=A0 PCIBus *pci_bus;<br>
+=C2=A0 =C2=A0 DeviceState *dev;<br>
+=C2=A0 =C2=A0 MemoryRegion *pio_alias;<br>
+=C2=A0 =C2=A0 MemoryRegion *mmio_alias, *mmio_reg;<br>
+=C2=A0 =C2=A0 MemoryRegion *ecam_alias, *ecam_reg;<br>
+<br>
+=C2=A0 =C2=A0 dev =3D qdev_new(TYPE_GPEX_HOST);<br>
+=C2=A0 =C2=A0 sysbus_realize_and_unref(SYS_<wbr>BUS_DEVICE(dev), &amp;erro=
r_fatal);<br>
+=C2=A0 =C2=A0 pci_bus =3D PCI_HOST_BRIDGE(dev)-&gt;bus;<br>
+<br>
+=C2=A0 =C2=A0 ecam_alias =3D g_new0(MemoryRegion, 1);<br>
+=C2=A0 =C2=A0 ecam_reg =3D sysbus_mmio_get_region(SYS_<wbr>BUS_DEVICE(dev)=
, 0);<br>
+=C2=A0 =C2=A0 memory_region_init_alias(ecam_<wbr>alias, OBJECT(dev), &quot=
;pcie-ecam&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ecam_reg, 0, virt_memmap[VIRT_PCIE_ECAM].<wb=
r>size);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>get_system_memory(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virt_memmap[VIRT_PCIE_ECAM].<wbr>bas=
e, ecam_alias);<br>
+<br>
+=C2=A0 =C2=A0 mmio_alias =3D g_new0(MemoryRegion, 1);<br>
+=C2=A0 =C2=A0 mmio_reg =3D sysbus_mmio_get_region(SYS_<wbr>BUS_DEVICE(dev)=
, 1);<br>
+=C2=A0 =C2=A0 memory_region_init_alias(mmio_<wbr>alias, OBJECT(dev), &quot=
;pcie-mmio&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmio_reg, virt_memmap[VIRT_PCIE_MMIO].<wbr>b=
ase,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virt_memmap[VIRT_PCIE_MMIO].<wbr>size);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>get_system_memory(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virt_memmap[VIRT_PCIE_MMIO].<wbr>bas=
e, mmio_alias);<br>
+<br>
+=C2=A0 =C2=A0 pio_alias =3D g_new0(MemoryRegion, 1);<br>
+=C2=A0 =C2=A0 memory_region_init_alias(pio_<wbr>alias, OBJECT(dev), &quot;=
pcie-pio&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_system_io(), 0, virt_memmap[VIRT_PCIE_PI=
O].<wbr>size);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>get_system_memory(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virt_memmap[VIRT_PCIE_PIO].<wbr>base=
, pio_alias);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_<wbr>DEVICE(dev), 2, virt_memmap[VIR=
T_PCIE_PIO].<wbr>base);<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; GPEX_NUM_IRQS; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 irq =3D qdev_get_gpio_in(pic, PCIE_IRQ_BASE + =
i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_<wbr>DEVICE(dev), i=
, irq);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpex_set_irq_num(GPEX_HOST(<wbr>dev), i, PCIE_=
IRQ_BASE + i);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 pci_vga_init(pci_bus);<br>
+<br>
+=C2=A0 =C2=A0 if (defaults_enabled()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_create_simple(pci_bus, -1, &quot;pci-ohci&=
quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_create_simple(usb_bus_<wbr>find(-1), &quot=
;usb-kbd&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 usb_create_simple(usb_bus_<wbr>find(-1), &quot=
;usb-tablet&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; nb_nics; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NICInfo *nd =3D &amp;nd_table[i];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!nd-&gt;model) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nd-&gt;model =3D g_strdup(&quot;=
virtio&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_nic_init_nofail(nd, pci_bus, nd-&gt;model,=
 NULL);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void mips_loongson3_virt_init(<wbr>MachineState *machine)<br>
+{<br>
+=C2=A0 =C2=A0 int i;<br>
+=C2=A0 =C2=A0 long bios_size;<br>
+=C2=A0 =C2=A0 MIPSCPU *cpu;<br>
+=C2=A0 =C2=A0 CPUMIPSState *env;<br>
+=C2=A0 =C2=A0 DeviceState *liointc;<br>
+=C2=A0 =C2=A0 char *filename;<br>
+=C2=A0 =C2=A0 const char *kernel_cmdline =3D machine-&gt;kernel_cmdline;<b=
r>
+=C2=A0 =C2=A0 const char *kernel_filename =3D machine-&gt;kernel_filename;=
<br>
+=C2=A0 =C2=A0 const char *initrd_filename =3D machine-&gt;initrd_filename;=
<br>
+=C2=A0 =C2=A0 ram_addr_t ram_size =3D machine-&gt;ram_size;<br>
+=C2=A0 =C2=A0 MemoryRegion *address_space_mem =3D get_system_memory();<br>
+=C2=A0 =C2=A0 MemoryRegion *ram =3D g_new(MemoryRegion, 1);<br>
+=C2=A0 =C2=A0 MemoryRegion *bios =3D g_new(MemoryRegion, 1);<br>
+=C2=A0 =C2=A0 MemoryRegion *iomem =3D g_new(MemoryRegion, 1);<br>
+<br>
+=C2=A0 =C2=A0 /* TODO: TCG will support all CPU types */<br>
+=C2=A0 =C2=A0 if (!kvm_enabled()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!machine-&gt;cpu_type) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 machine-&gt;cpu_type =3D MIPS_CP=
U_TYPE_NAME(&quot;Loongson-<wbr>3A1000&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strstr(machine-&gt;cpu_type, &quot;Loongs=
on-3A1000&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Loongson-3/TC=
G need cpu type Loongson-3A1000&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!machine-&gt;cpu_type) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 machine-&gt;cpu_type =3D MIPS_CP=
U_TYPE_NAME(&quot;Loongson-<wbr>3A4000&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!strstr(machine-&gt;cpu_type, &quot;Loongs=
on-3A4000&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Loongson-3/KV=
M need cpu type Loongson-3A4000&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ram_size &lt; 512 * 0x100000) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Loongson-3 need at least 51=
2MB memory&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* The whole MMIO range among configure registers doesn=
&#39;t generate<br>
+=C2=A0 =C2=A0 =C2=A0* exception when accessing invalid memory. Create an e=
mpty slot to<br>
+=C2=A0 =C2=A0 =C2=A0* emulate this feature.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 empty_slot_init(&quot;fallback&quot;, 0, 0x80000000);<br>
+<br>
+=C2=A0 =C2=A0 liointc =3D qdev_new(&quot;loongson.liointc&quot;);<br>
+=C2=A0 =C2=A0 sysbus_realize_and_unref(SYS_<wbr>BUS_DEVICE(liointc), &amp;=
error_fatal);<br>
+<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_<wbr>DEVICE(liointc), 0, virt_memmap=
[VIRT_LIOINTC].<wbr>base);<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; machine-&gt;smp.cpus; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ip;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* init CPUs */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu =3D MIPS_CPU(cpu_create(machine-&gt;<wbr>c=
pu_type));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Init internal devices */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mips_irq_init_cpu(cpu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mips_clock_init(cpu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_register_reset(main_cpu_<wbr>reset, cpu);=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt;=3D 4) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue; /* Only node-0 can be =
connected to LIOINTC */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (ip =3D 0; ip &lt; 4 ; ip++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int pin =3D i * 4 + ip;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_<wbr>=
DEVICE(liointc),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pin, cpu-&gt;env.irq[ip + 2]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 env =3D &amp;MIPS_CPU(first_cpu)-&gt;env;<br>
+<br>
+=C2=A0 =C2=A0 /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x80=
000000~0x90000000 */<br>
+=C2=A0 =C2=A0 memory_region_init_rom(bios, NULL, &quot;loongson3.bios&quot=
;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0virt_memmap[VIRT_BIOS_ROM].<wbr>size, &amp;error_fa=
tal);<br>
+=C2=A0 =C2=A0 memory_region_init_alias(ram, NULL, &quot;loongson3.lowmem&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0machine-&gt;ram, 0, virt_memmap[VIRT_LOWMEM].size)<=
wbr>;<br>
+=C2=A0 =C2=A0 memory_region_init_io(iomem, NULL, &amp;loongson3_pm_ops,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL, &quot;loongson3_pm&quot;, virt_memmap[VIRT_PM=
].size);<br>
+<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>address_space_mem,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 virt_memmap[VIRT_LOWMEM].base, ram);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>address_space_mem,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 virt_memmap[VIRT_BIOS_ROM].<wbr>base, bios);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>address_space_mem,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 virt_memmap[VIRT_HIGHMEM].<wbr>base, machine-&gt;ram);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(<wbr>address_space_mem,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 virt_memmap[VIRT_PM].base, iomem);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* We do not support flash operation, just loading bios=
.bin as raw BIOS.<br>
+=C2=A0 =C2=A0 =C2=A0* Please use -L to set the BIOS path and -bios to set =
bios name.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+<br>
+=C2=A0 =C2=A0 if (kernel_filename) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 loaderparams.ram_size =3D ram_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 loaderparams.kernel_filename =3D kernel_filena=
me;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 loaderparams.kernel_cmdline =3D kernel_cmdline=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 loaderparams.initrd_filename =3D initrd_filena=
me;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 loaderparams.kernel_entry =3D load_kernel(env)=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 init_boot_rom();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 init_boot_param();<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bios_name =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bios_name =3D LOON=
GSON3_BIOSNAME;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 filename =3D qemu_find_file(QEMU_FILE_TYPE_<wb=
r>BIOS, bios_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (filename) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bios_size =3D load_image_targphy=
s(filename,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 virt_memmap[VIRT_BIOS_ROM].<wbr>base,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 virt_memmap[VIRT_BIOS_ROM].<wbr>size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(filename);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bios_size =3D -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((bios_size &lt; 0 || bios_size &gt; virt_m=
emmap[VIRT_BIOS_ROM].<wbr>size) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !kernel_filename &amp;&amp; !qte=
st_enabled()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Could not loa=
d MIPS bios &#39;%s&#39;&quot;, bios_name);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fw_conf_init(ram_size);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 msi_nonbroken =3D true;<br>
+=C2=A0 =C2=A0 loongson3_virt_devices_init(<wbr>machine, liointc);<br>
+<br>
+=C2=A0 =C2=A0 sysbus_create_simple(&quot;<wbr>goldfish_rtc&quot;, virt_mem=
map[VIRT_RTC].base,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0qdev_get_gpio_in(liointc, RTC_IRQ));<br>
+<br>
+=C2=A0 =C2=A0 if (serial_hd(0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 serial_mm_init(address_space_<wbr>mem, virt_me=
mmap[VIRT_UART].base, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qdev_get_gpio_in(liointc, UART_IRQ), 115200,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0serial_hd(0), DEVICE_NATIVE_ENDIAN);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void mips_loongson3_virt_machine_<wbr>init(MachineClass *mc)<br>
+{<br>
+=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;Loongson-3 Virtualization Platform&quo=
t;;<br>
+=C2=A0 =C2=A0 mc-&gt;init =3D mips_loongson3_virt_init;<br>
+=C2=A0 =C2=A0 mc-&gt;block_default_type =3D IF_IDE;<br>
+=C2=A0 =C2=A0 mc-&gt;max_cpus =3D LOONGSON_MAX_VCPUS;<br>
+=C2=A0 =C2=A0 mc-&gt;default_ram_id =3D &quot;loongson3.highram&quot;;<br>
+=C2=A0 =C2=A0 /* 1440MB is the requirement of distros for Loongson-3 */<br=
>
+=C2=A0 =C2=A0 mc-&gt;default_ram_size =3D 1440 * MiB;<br>
+=C2=A0 =C2=A0 mc-&gt;kvm_type =3D mips_kvm_type;<br>
+=C2=A0 =C2=A0 mc-&gt;minimum_page_bits =3D 14;<br>
+}<br>
+<br>
+DEFINE_MACHINE(&quot;loongson3-<wbr>virt&quot;, mips_loongson3_virt_machin=
e_<wbr>init)<br>
-- <br>
2.7.0<br>
<br>
</blockquote>

--00000000000066141505a8c0951a--

