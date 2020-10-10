Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6817FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 09:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20C8207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 09:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luFGx7KO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20C8207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRAtD-0004Y1-An
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 05:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRAsU-00047K-3M
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:09:22 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRAsQ-0006Nx-NH
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:09:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id t9so12663783wrq.11
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 02:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/H21goF0HTEFoLz5A1tTdx5JCmfcq2hfIiNVS663lPc=;
 b=luFGx7KOK8wnkRq6HVOl+EqodqAW48YVB2Jyp5o0og+lXD0lk1W20sxze4vcCWsq2l
 gyhFKSAu5DEdHCj1LXn+kxBsjHc515sQFsRL5j1ehpGa5QBsoVFYun+UdkhfxOR3ryyZ
 I8Km5RUCh/hJ3sB9Lk6P/pnxres6fDI9VY47XpAbsv2kZ2++Ss+p7IdO8cI7A6NXx2N5
 XG56QRjm5WmKDSkb6e2ndSMuQsVaUvH9WE3meJ7L4RXtJD87bS6VrlDOcjCGovDBH8hU
 hBFz0xE2gqeYJ7xINT8ibiM2FZtPHjpBuU/AKWKE/Aaww/oBFQBSGved+m/fNWgq6XD/
 GU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/H21goF0HTEFoLz5A1tTdx5JCmfcq2hfIiNVS663lPc=;
 b=YiYfGRWZTKWg67aVsNVv1t8IvtbTA67Cf7YE2OzkrqUFNSWfRI7Ko/rWCOykQBn+I9
 mv7lQ7jTY9NeMCjkIT6GN5GgLuRFN9wx3U3RLykhASMjsc0a/RnO5TIM5zm/vf9Upqqh
 +TWlKdRF7E4n7k0iLCP1b5p3aHT77qBR4WDerqxtCJ1Jvwv4FYfQi1oV+xp07SZqUrIu
 EMPnaysOGoxhC96x4XlobudBcE306da2eGpv9Cq7b06W5q8DpER7fJxo+9Nb/Aln5IwK
 7XRvHKijygCWHPAzXRWlSznNLHg56jB7kIkOmxeb2CC40qwKhqPmKdFZ1ztv406mfqYH
 QJPQ==
X-Gm-Message-State: AOAM532YnPatoR8DdRa5TomS0wPOWT7W0HRc8WHcshwCs8e6TfbZxJyW
 dzvDilRxaqXWdIAFvPn6NR4=
X-Google-Smtp-Source: ABdhPJw11U/zot9g8Hs1t7upq8Ai6JL1+Bpv8zGJx3KImsbFJNhdpcbcKAsuw5C+/jhZ1o9CwS8gSA==
X-Received: by 2002:a05:6000:8e:: with SMTP id
 m14mr19083387wrx.400.1602320956481; 
 Sat, 10 Oct 2020 02:09:16 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x81sm15159526wmb.11.2020.10.10.02.09.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 02:09:15 -0700 (PDT)
Subject: Re: [PATCH V13 8/9] hw/mips: Add Loongson-3 machine support
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
 <1602059975-10115-9-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2867f40b-4a43-f2ce-661a-d0fdbd1a2efd@amsat.org>
Date: Sat, 10 Oct 2020 11:09:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602059975-10115-9-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Huacai,

On 10/7/20 10:39 AM, Huacai Chen wrote:
> Add Loongson-3 based machine support, it use liointc as the interrupt
> controler and use GPEX as the pci controller. Currently it can work with
> both TCG and KVM.
> 
> As the machine model is not based on any exiting physical hardware, the
> name of the machine is "loongson3-virt". It may be superseded in future
> by a real machine model. If this happens, then a regular deprecation
> procedure shall occur for "loongson3-virt" machine.
> 
> We now already have a full functional Linux kernel (based on Linux-5.4.x
> LTS, the kvm host side and guest side have both been upstream for Linux-
> 5.9, but Linux-5.9 has not been released yet) here:
> 
> https://github.com/chenhuacai/linux
> 
> Of course the upstream kernel is also usable (though it is "unstable"
> now):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> How to use QEMU/Loongson-3?
> 1, Download kernel source from the above URL;
> 2, Build a kernel with arch/mips/configs/loongson3_defconfig;
> 3, Boot a Loongson-3A4000 host with this kernel (for KVM mode);
> 4, Build QEMU-master with this patchset;
> 5, modprobe kvm (only necessary for KVM mode);
> 6, Use QEMU with TCG:
>         qemu-system-mips64el -M loongson3-virt,accel=tcg -cpu Loongson-3A1000 -kernel <path_to_kernel> -append ...
>     Use QEMU with KVM:
>         qemu-system-mips64el -M loongson3-virt,accel=kvm -cpu Loongson-3A4000 -kernel <path_to_kernel> -append ...
> 
>     The "-cpu" parameter is optional here and QEMU will use the correct type for TCG/KVM automatically.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   default-configs/devices/mips64el-softmmu.mak |   1 +
>   hw/mips/Kconfig                              |  12 +
>   hw/mips/loongson3_bootp.c                    | 162 +++++++
>   hw/mips/loongson3_bootp.h                    | 225 ++++++++++

In a previous version I asked if you could split the bootp* files
(firmware related) in a previous separate patch to ease the review
of the machine part.

>   hw/mips/loongson3_virt.c                     | 615 +++++++++++++++++++++++++++
>   hw/mips/meson.build                          |   1 +
>   6 files changed, 1016 insertions(+)
[...]

> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> new file mode 100644
> index 0000000..4e573d6
> --- /dev/null
> +++ b/hw/mips/loongson3_virt.c
> @@ -0,0 +1,615 @@
> +/*
> + * Generic Loongson-3 Platform support
> + *
> + * Copyright (c) 2017-2020 Huacai Chen (chenhc@lemote.com)
> + * Copyright (c) 2017-2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <https://www.gnu.org/licenses/>.
> + */
> +
> +/*
> + * Generic virtualized PC Platform based on Loongson-3 CPU (MIPS64R2 with
> + * extensions, 800~2000MHz)
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/units.h"
> +#include "qemu/cutils.h"
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "elf.h"
> +#include "kvm_mips.h"
> +#include "hw/boards.h"
> +#include "hw/char/serial.h"
> +#include "hw/mips/mips.h"
> +#include "hw/mips/cpudevs.h"
> +#include "hw/mips/fw_cfg.h"
> +#include "hw/mips/loongson3_bootp.h"
> +#include "hw/misc/unimp.h"
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
> +#define LOONGSON_MAX_VCPUS      16
> +
> +#define LOONGSON3_BIOSNAME "bios_loongson3.bin"

Where is that file?

> +
> +#define UART_IRQ            0
> +#define RTC_IRQ             1
> +#define PCIE_IRQ_BASE       2
> +
> +const struct MemmapEntry virt_memmap[] = {
> +    [VIRT_LOWMEM] =      { 0x00000000,    0x10000000 },
> +    [VIRT_PM] =          { 0x10080000,         0x100 },
> +    [VIRT_FW_CFG] =      { 0x10080100,         0x100 },
> +    [VIRT_RTC] =         { 0x10081000,        0x1000 },
> +    [VIRT_PCIE_PIO] =    { 0x18000000,       0x80000 },
> +    [VIRT_PCIE_ECAM] =   { 0x1a000000,     0x2000000 },
> +    [VIRT_BIOS_ROM] =    { 0x1fc00000,      0x200000 },
> +    [VIRT_UART] =        { 0x1fe001e0,           0x8 },

See below about this mapping.

> +    [VIRT_LIOINTC] =     { 0x3ff01400,          0x64 },
> +    [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
> +    [VIRT_HIGHMEM] =     { 0x80000000,           0x0 }, /* Variable */
> +};
> +
> +static const struct MemmapEntry loader_memmap[] = {
> +    [LOADER_KERNEL] =    { 0x00000000,     0x4000000 },
> +    [LOADER_INITRD] =    { 0x04000000,           0x0 }, /* Variable */
> +    [LOADER_CMDLINE] =   { 0x0ff00000,      0x100000 },
> +};
> +
> +static const struct MemmapEntry loader_rommap[] = {
> +    [LOADER_BOOTROM] =   { 0x1fc00000,        0x1000 },
> +    [LOADER_PARAM] =     { 0x1fc01000,       0x10000 },
> +};
> +
> +static struct _loaderparams {
> +    uint64_t cpu_freq;
> +    uint64_t ram_size;
> +    const char *kernel_cmdline;
> +    const char *kernel_filename;
> +    const char *initrd_filename;
> +    uint64_t kernel_entry;
> +    uint64_t a0, a1, a2;
> +} loaderparams;
> +
> +static uint64_t loongson3_pm_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void loongson3_pm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
> +{
> +    if (addr != PM_CNTL_MODE) {
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
> +static const MemoryRegionOps loongson3_pm_ops = {
> +    .read  = loongson3_pm_read,
> +    .write = loongson3_pm_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +#define DEF_TCG_FREQ (200 * 1000 * 1000)
> +#define DEF_KVM_FREQ (1600 * 1000 * 1000)
> +
> +static uint64_t get_cpu_freq(void)
> +{
> +#ifdef CONFIG_KVM
> +    int ret;
> +    uint64_t freq;
> +    struct kvm_one_reg freq_reg = {
> +        .id = KVM_REG_MIPS_COUNT_HZ,
> +        .addr = (uintptr_t)(&freq)
> +    };
> +
> +    if (kvm_enabled()) {
> +        ret = kvm_vcpu_ioctl(first_cpu, KVM_GET_ONE_REG, &freq_reg);
> +        if (ret < 0) {
> +            return DEF_KVM_FREQ;
> +        }
> +        return freq * 2;
> +    } else {
> +        /*
> +         * TCG has a default CP0 Timer period 10 ns, which is 100MHz,
> +         * CPU frequency is defined as double of CP0 timer frequency.
> +         */
> +        return DEF_TCG_FREQ;
> +    }
> +#else
> +    return DEF_TCG_FREQ;
> +#endif
> +}
> +
> +static void init_boot_param(void)
> +{
> +    void *p;
> +    struct boot_params *bp;
> +
> +    p = g_malloc0(loader_rommap[LOADER_PARAM].size);
> +    bp = p;
> +
> +    stw_le_p(&bp->efi.smbios.vers, 1);
> +    init_reset_system(&(bp->reset_system));
> +    p += ROUND_UP(sizeof(struct boot_params), 64);
> +    init_loongson_params(&(bp->efi.smbios.lp), p,
> +                         loaderparams.cpu_freq, loaderparams.ram_size);
> +
> +    rom_add_blob_fixed("params_rom", bp,
> +                       loader_rommap[LOADER_PARAM].size,
> +                       loader_rommap[LOADER_PARAM].base);
> +
> +    g_free(bp);
> +
> +    loaderparams.a2 = cpu_mips_phys_to_kseg0(NULL, loader_rommap[LOADER_PARAM].base);
> +}
> +
> +static void init_boot_rom(void)
> +{
> +    const unsigned int boot_code[] = {
> +        0x40086000,   /* mfc0    t0, CP0_STATUS                               */
> +        0x240900E4,   /* li      t1, 0xe4         #set kx, sx, ux, erl        */
> +        0x01094025,   /* or      t0, t0, t1                                   */
> +        0x3C090040,   /* lui     t1, 0x40         #set bev                    */
> +        0x01094025,   /* or      t0, t0, t1                                   */
> +        0x40886000,   /* mtc0    t0, CP0_STATUS                               */
> +        0x00000000,
> +        0x40806800,   /* mtc0    zero, CP0_CAUSE                              */
> +        0x00000000,
> +        0x400A7801,   /* mfc0    t2, $15, 1                                   */
> +        0x314A00FF,   /* andi    t2, 0x0ff                                    */
> +        0x3C089000,   /* dli     t0, 0x900000003ff01000                       */
> +        0x00084438,
> +        0x35083FF0,
> +        0x00084438,
> +        0x35081000,
> +        0x314B0003,   /* andi    t3, t2, 0x3      #local cpuid                */
> +        0x000B5A00,   /* sll     t3, 8                                        */
> +        0x010B4025,   /* or      t0, t0, t3                                   */
> +        0x314C000C,   /* andi    t4, t2, 0xc      #node id                    */
> +        0x000C62BC,   /* dsll    t4, 42                                       */
> +        0x010C4025,   /* or      t0, t0, t4                                   */
> +                      /* WaitForInit:                                         */
> +        0xDD020020,   /* ld      v0, FN_OFF(t0)   #FN_OFF 0x020               */
> +        0x1040FFFE,   /* beqz    v0, WaitForInit                              */
> +        0x00000000,   /* nop                                                  */
> +        0xDD1D0028,   /* ld      sp, SP_OFF(t0)   #FN_OFF 0x028               */
> +        0xDD1C0030,   /* ld      gp, GP_OFF(t0)   #FN_OFF 0x030               */
> +        0xDD050038,   /* ld      a1, A1_OFF(t0)   #FN_OFF 0x038               */
> +        0x00400008,   /* jr      v0               #byebye                     */
> +        0x00000000,   /* nop                                                  */
> +        0x1000FFFF,   /* 1:  b   1b                                           */
> +        0x00000000,   /* nop                                                  */
> +
> +                      /* Reset                                                */
> +        0x3C0C9000,   /* dli     t0, 0x9000000010080010                       */
> +        0x358C0000,
> +        0x000C6438,
> +        0x358C1008,
> +        0x000C6438,
> +        0x358C0010,
> +        0x240D0000,   /* li      t1, 0x00                                     */
> +        0xA18D0000,   /* sb      t1, (t0)                                     */
> +        0x1000FFFF,   /* 1:  b   1b                                           */
> +        0x00000000,   /* nop                                                  */
> +
> +                      /* Shutdown                                             */
> +        0x3C0C9000,   /* dli     t0, 0x9000000010080010                       */
> +        0x358C0000,
> +        0x000C6438,
> +        0x358C1008,
> +        0x000C6438,
> +        0x358C0010,
> +        0x240D00FF,   /* li      t1, 0xff                                     */
> +        0xA18D0000,   /* sb      t1, (t0)                                     */
> +        0x1000FFFF,   /* 1:  b   1b                                           */
> +        0x00000000    /* nop                                                  */
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
> +    hwaddr cfg_addr = virt_memmap[VIRT_FW_CFG].base;
> +
> +    fw_cfg = fw_cfg_init_mem_wide(cfg_addr, cfg_addr + 8, 8, 0, NULL);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)current_machine->smp.cpus);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)current_machine->smp.max_cpus);
> +    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
> +    fw_cfg_add_i32(fw_cfg, FW_CFG_MACHINE_VERSION, 1);
> +    fw_cfg_add_i64(fw_cfg, FW_CFG_CPU_FREQ, get_cpu_freq());
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
> +    int ret = 0;
> +
> +    /* Allocate cmdline_buf for command line. */
> +    cmdline_buf = g_malloc0(loader_memmap[LOADER_CMDLINE].size);
> +    cmdline_vaddr = cpu_mips_phys_to_kseg0(NULL,
> +                                           loader_memmap[LOADER_CMDLINE].base);
> +
> +    /*
> +     * Layout of cmdline_buf looks like this:
> +     * argv[0], argv[1], 0, env[0], env[1], ... env[i], 0,
> +     * argv[0]'s data, argv[1]'s data, env[0]'data, ..., env[i]'s data, 0
> +     */
> +    parg_env = (void *)cmdline_buf;
> +
> +    ret = (3 + 1) * 4;
> +    *parg_env++ = cmdline_vaddr + ret;
> +    ret += (1 + snprintf(cmdline_buf + ret, 256 - ret, "g"));
> +
> +    /* argv1 */
> +    *parg_env++ = cmdline_vaddr + ret;
> +    if (initrd_size > 0)
> +        ret += (1 + snprintf(cmdline_buf + ret, 256 - ret,
> +                "rd_start=0x" TARGET_FMT_lx " rd_size=%li %s",
> +                cpu_mips_phys_to_kseg0(NULL, initrd_offset),
> +                initrd_size, loaderparams.kernel_cmdline));
> +    else
> +        ret += (1 + snprintf(cmdline_buf + ret, 256 - ret, "%s",
> +                loaderparams.kernel_cmdline));
> +
> +    /* argv2 */
> +    *parg_env++ = cmdline_vaddr + 4 * ret;
> +
> +    /* env */
> +    sprintf(memenv, "%d", 256);
> +    sprintf(highmemenv, "%ld", (unsigned long)(loaderparams.ram_size / MiB) - 256);
> +
> +    rom_add_blob_fixed("cmdline", cmdline_buf,
> +                       loader_memmap[LOADER_CMDLINE].size,
> +                       loader_memmap[LOADER_CMDLINE].base);
> +
> +    g_free(cmdline_buf);
> +
> +    loaderparams.a0 = 2;
> +    loaderparams.a1 = cmdline_vaddr;
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
> +    kernel_size = load_elf(loaderparams.kernel_filename, NULL,
> +                           cpu_mips_kseg0_to_phys, NULL,
> +                           (uint64_t *)&kernel_entry,
> +                           (uint64_t *)&kernel_low, (uint64_t *)&kernel_high,
> +                           NULL, 0, EM_MIPS, 1, 0);
> +    if (kernel_size < 0) {
> +        error_report("could not load kernel '%s': %s",
> +                     loaderparams.kernel_filename,
> +                     load_elf_strerror(kernel_size));
> +        exit(1);
> +    }
> +
> +    /* load initrd */
> +    initrd_size = 0;
> +    initrd_offset = 0;
> +    if (loaderparams.initrd_filename) {
> +        initrd_size = get_image_size(loaderparams.initrd_filename);
> +        if (initrd_size > 0) {
> +            initrd_offset = (kernel_high + ~INITRD_PAGE_MASK) &
> +                            INITRD_PAGE_MASK;
> +            initrd_offset = MAX(initrd_offset,
> +                                loader_memmap[LOADER_INITRD].base);
> +
> +            if (initrd_offset + initrd_size > ram_size) {
> +                error_report("memory too small for initial ram disk '%s'",
> +                             loaderparams.initrd_filename);
> +                exit(1);
> +            }
> +
> +            initrd_size = load_image_targphys(loaderparams.initrd_filename,
> +                                              initrd_offset,
> +                                              ram_size - initrd_offset);
> +        }
> +
> +        if (initrd_size == (target_ulong) -1) {
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
> +    MIPSCPU *cpu = opaque;
> +    CPUMIPSState *env = &cpu->env;
> +
> +    cpu_reset(CPU(cpu));
> +
> +    /* Loongson-3 reset stuff */
> +    if (loaderparams.kernel_filename) {
> +        if (cpu == MIPS_CPU(first_cpu)) {
> +            env->active_tc.gpr[4] = loaderparams.a0;
> +            env->active_tc.gpr[5] = loaderparams.a1;
> +            env->active_tc.gpr[6] = loaderparams.a2;
> +            env->active_tc.PC = loaderparams.kernel_entry;
> +        }
> +        env->CP0_Status &= ~((1 << CP0St_BEV) | (1 << CP0St_ERL));
> +    }
> +}
> +
> +static inline void loongson3_virt_devices_init(MachineState *machine, DeviceState *pic)
> +{
> +    int i;
> +    qemu_irq irq;
> +    PCIBus *pci_bus;
> +    DeviceState *dev;
> +    MemoryRegion *pio_alias;
> +    MemoryRegion *mmio_alias, *mmio_reg;
> +    MemoryRegion *ecam_alias, *ecam_reg;
> +
> +    dev = qdev_new(TYPE_GPEX_HOST);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    pci_bus = PCI_HOST_BRIDGE(dev)->bus;
> +
> +    ecam_alias = g_new0(MemoryRegion, 1);
> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> +                             ecam_reg, 0, virt_memmap[VIRT_PCIE_ECAM].size);
> +    memory_region_add_subregion(get_system_memory(),
> +                                virt_memmap[VIRT_PCIE_ECAM].base, ecam_alias);
> +
> +    mmio_alias = g_new0(MemoryRegion, 1);
> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> +                             mmio_reg, virt_memmap[VIRT_PCIE_MMIO].base,
> +                             virt_memmap[VIRT_PCIE_MMIO].size);
> +    memory_region_add_subregion(get_system_memory(),
> +                                virt_memmap[VIRT_PCIE_MMIO].base, mmio_alias);
> +
> +    pio_alias = g_new0(MemoryRegion, 1);
> +    memory_region_init_alias(pio_alias, OBJECT(dev), "pcie-pio",
> +                             get_system_io(), 0, virt_memmap[VIRT_PCIE_PIO].size);
> +    memory_region_add_subregion(get_system_memory(),
> +                                virt_memmap[VIRT_PCIE_PIO].base, pio_alias);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, virt_memmap[VIRT_PCIE_PIO].base);
> +
> +    for (i = 0; i < GPEX_NUM_IRQS; i++) {
> +        irq = qdev_get_gpio_in(pic, PCIE_IRQ_BASE + i);
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
> +    for (i = 0; i < nb_nics; i++) {
> +        NICInfo *nd = &nd_table[i];
> +
> +        if (!nd->model) {
> +            nd->model = g_strdup("virtio");
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
> +    const char *kernel_cmdline = machine->kernel_cmdline;
> +    const char *kernel_filename = machine->kernel_filename;
> +    const char *initrd_filename = machine->initrd_filename;
> +    ram_addr_t ram_size = machine->ram_size;
> +    MemoryRegion *address_space_mem = get_system_memory();
> +    MemoryRegion *ram = g_new(MemoryRegion, 1);
> +    MemoryRegion *bios = g_new(MemoryRegion, 1);
> +    MemoryRegion *iomem = g_new(MemoryRegion, 1);
> +
> +    /* TODO: TCG will support all CPU types */
> +    if (!kvm_enabled()) {
> +        if (!machine->cpu_type) {
> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A1000");
> +        }
> +        if (!strstr(machine->cpu_type, "Loongson-3A1000")) {
> +            error_report("Loongson-3/TCG needs cpu type Loongson-3A1000");
> +            exit(1);
> +        }

IIUC here you need to check machine->smp.cpus is 4 or 8 for the 3A1000.
It would be easier if you model this as a qdev SoC, and this model
cares to create the 4/8 cores (QEMU MIPSCPU).

You defined max_cpu = LOONGSON_MAX_VCPUS = 16, this seems an impossible
configuration for the 3A1000.

> +    } else {
> +        if (!machine->cpu_type) {
> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A4000");
> +        }
> +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
> +            error_report("Loongson-3/KVM needs cpu type Loongson-3A4000");
> +            exit(1);
> +        }

Similar comment, as the 3A4000 is also a quad-core.

> +    }
> +
> +    if (ram_size < 512 * MiB) {
> +        error_report("Loongson-3 machine needs at least 512MB memory");
> +        exit(1);
> +    }
> +
> +    /*
> +     * The whole MMIO range among configure registers doesn't generate
> +     * exception when accessing invalid memory. Create an unimplememted
> +     * device to emulate this feature.
> +     */
> +    create_unimplemented_device("fallback", 0x10000000, 0x30000000);

The secondary crosswise switch description is hard to follow:

* 2.4 Address routing distribution and configuration

According  to  the  default  register  configuration,  CPU [...] 
0x10000000-0x1fffffff  of  CPU  (256M)  is  mapped  to 
0x10000000-0x1fffffff  of  PCI,  and  0x80000000  of  PCIDMA.
In addition, when read access to illegal addresses occurs due to CPU 
guess execution, all 8 address Windows fail to hit, ?

Table 2-9 XBAR level 2 default address configuration
                   base                    high                     owner
0 x0000_0000_1000_0000  0 x0000_0000_2000_0000  Low speed I/O (PCI, etc)

* 14.4 Secondary cross-switch address window

After the address window is configured, the system address 
0x0000_2000_0000 is added-- 0x0000_2FFFF_FFFF  maps  to 
0x0000_0000_0000  -- 0x0000_0FFF_FFFF  of  memory  controller 0.An 
access to 0x0000_2000_0000 at this time will result in the original 
enabledThe value stored at address 0x0000_0000_0000.

But see:

* 14.6.3 Low speed device address window

Here are defined the peripherals in the 0x1c00_0000-0x1ff0_ffff range.

* 15.1 System memory space

IO device, 0x1000_0000 --  0x1FFF_FFFF

* 16 Memory allocation for system X

... divide  the  256M  PCI  space  (0x10000000~0x20000000)  into  two 
parts:  0x10000000~0x17ffffff for mem space and 0x18000000~0x20000000 
for IO space.

I still don't understand what is in the 0x20000000-0x30000000 range.

> +
> +    liointc = qdev_new("loongson.liointc");
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(liointc), &error_fatal);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(liointc), 0, virt_memmap[VIRT_LIOINTC].base);
> +
> +    for (i = 0; i < machine->smp.cpus; i++) {
> +        int ip;
> +
> +        /* init CPUs */
> +        cpu = MIPS_CPU(cpu_create(machine->cpu_type));
> +
> +        /* Init internal devices */
> +        cpu_mips_irq_init_cpu(cpu);
> +        cpu_mips_clock_init(cpu);
> +        qemu_register_reset(main_cpu_reset, cpu);
> +
> +        if (i >= 4) {
> +            continue; /* Only node-0 can be connected to LIOINTC */
> +        }
> +
> +        for (ip = 0; ip < 4 ; ip++) {
> +            int pin = i * 4 + ip;
> +            sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
> +                               pin, cpu->env.irq[ip + 2]);
> +        }
> +    }
> +    env = &MIPS_CPU(first_cpu)->env;
> +
> +    /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x80000000~0x90000000 */
> +    memory_region_init_rom(bios, NULL, "loongson3.bios",
> +                           virt_memmap[VIRT_BIOS_ROM].size, &error_fatal);
> +    memory_region_init_alias(ram, NULL, "loongson3.lowmem",
> +                           machine->ram, 0, virt_memmap[VIRT_LOWMEM].size);
> +    memory_region_init_io(iomem, NULL, &loongson3_pm_ops,
> +                           NULL, "loongson3_pm", virt_memmap[VIRT_PM].size);
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
> +     * We do not support flash operation, just loading bios.bin as raw BIOS.
> +     * Please use -L to set the BIOS path and -bios to set bios name.
> +     */
> +
> +    if (kernel_filename) {
> +        loaderparams.cpu_freq = get_cpu_freq();
> +        loaderparams.ram_size = ram_size;
> +        loaderparams.kernel_filename = kernel_filename;
> +        loaderparams.kernel_cmdline = kernel_cmdline;
> +        loaderparams.initrd_filename = initrd_filename;
> +        loaderparams.kernel_entry = load_kernel(env);
> +
> +        init_boot_rom();
> +        init_boot_param();
> +    } else {
> +        if (bios_name == NULL) {
> +                bios_name = LOONGSON3_BIOSNAME;
> +        }
> +        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> +        if (filename) {
> +            bios_size = load_image_targphys(filename,
> +                                            virt_memmap[VIRT_BIOS_ROM].base,
> +                                            virt_memmap[VIRT_BIOS_ROM].size);
> +            g_free(filename);
> +        } else {
> +            bios_size = -1;
> +        }
> +
> +        if ((bios_size < 0 || bios_size > virt_memmap[VIRT_BIOS_ROM].size) &&
> +            !kernel_filename && !qtest_enabled()) {
> +            error_report("Could not load MIPS bios '%s'", bios_name);
> +            exit(1);
> +        }
> +
> +        fw_conf_init(ram_size);
> +    }
> +
> +    msi_nonbroken = true;
> +    loongson3_virt_devices_init(machine, liointc);
> +
> +    sysbus_create_simple("goldfish_rtc", virt_memmap[VIRT_RTC].base,
> +                         qdev_get_gpio_in(liointc, RTC_IRQ));
> +
> +    serial_mm_init(address_space_mem, virt_memmap[VIRT_UART].base, 0,
> +                   qdev_get_gpio_in(liointc, UART_IRQ), 115200, serial_hd(0),
> +                   DEVICE_NATIVE_ENDIAN);

You need to split the SoC part from the machine part.

> +}
> +
> +static void mips_loongson3_virt_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "Loongson-3 Virtualization Platform";
> +    mc->init = mips_loongson3_virt_init;
> +    mc->block_default_type = IF_IDE;

Don't you need min_cpus = 4?

> +    mc->max_cpus = LOONGSON_MAX_VCPUS;
> +    mc->default_ram_id = "loongson3.highram";
> +    mc->default_ram_size = 1600 * MiB;
> +    mc->kvm_type = mips_kvm_type;
> +    mc->minimum_page_bits = 14;
> +}
> +
> +DEFINE_MACHINE("loongson3-virt", mips_loongson3_virt_machine_init)
> diff --git a/hw/mips/meson.build b/hw/mips/meson.build
> index c98391c..72db43c 100644
> --- a/hw/mips/meson.build
> +++ b/hw/mips/meson.build
> @@ -1,6 +1,7 @@
>   mips_ss = ss.source_set()
>   mips_ss.add(files('addr.c', 'mips_int.c', 'fw_cfg.c'))
>   mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
> +mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c', 'loongson3_virt.c'))
>   mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
>   mips_ss.add(when: 'CONFIG_MALTA', if_true: files('gt64xxx_pci.c', 'malta.c'))
>   mips_ss.add(when: 'CONFIG_MIPSSIM', if_true: files('mipssim.c'))
> 

