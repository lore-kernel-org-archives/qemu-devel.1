Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4778CC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3122078D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkqhqyfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3122078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISL6-0002NY-KD
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 03:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kISIv-00007j-R5
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:56:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kISIr-0001xR-Dc
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:56:37 -0400
Received: by mail-wm1-x342.google.com with SMTP id z9so1924112wmk.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 00:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uUN5Clma/6cllCgNKNI/Je4w9Ra/eTBhXnrvzJxWLY4=;
 b=rkqhqyfTY5EcDnocaSCGlPxbWJMzue49W+b8WVQpcpWYi8l7p6WWG409iX7Gu1Aw06
 PnfyB/+8qWTOL+NjoZiZ9A+5FI0X287OnHgmm1EEBBcbsKbYRpstR31mR4EPWDKJPb7D
 0UmrhxrM6ziPgDDYKxvk6GKdj6A+p4tlIx8EiL2TN+7HG1HIFP14yr74JhxX1+762uL1
 pCtsZ8+QK00NRK5YQFESNc97wVs5Fa6jsDAYEIwlJoFWqxBNUmT7NwD0Y8/5i5Lj2fQT
 637Woj0uV5orQVYDtZWXmDX422Le+8qg/OpEWIlDIGmeEXQ22U2nXd42Q5vnCtX5iWa1
 IGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uUN5Clma/6cllCgNKNI/Je4w9Ra/eTBhXnrvzJxWLY4=;
 b=kADMmkmAxMXpSH+egFemX1i6AQUX56ENDcsU1AiwadjWpjYsEP5si3ZmZyJTdwzcQT
 SU+h+iaqx+MllZvtedzu2eTLqDamOfT6tDveELma6/9/EiTQOOUkQb0Kvf+CfkvqzoRp
 4aNtE9CUYf7tuCsgcRrPMwfJuFwo6at0nFLV0tPtwR5Jsjm9nvMSZI4bc6Xk08mRtzx9
 JTbvkrc/cM3l1AHdxRSO7ED13Z1NCXwVs8TcRpA5+t5rOCy6dwjDhVDYwzRIyR/Dzu2P
 3sAEvwpU271Sd+Gbw1VVt7wVcrgt+t3aCZ+bD8nmQtggTN8Qaf8CPqt3h6nXTAgikaCK
 ABLw==
X-Gm-Message-State: AOAM530kkenLcnXxdIz5R3gMZ1okZ8oR0tPkBr9zh3GPOaJajO4Dv3zM
 7hzCSkYvJKnxZXqc8G/JFC4=
X-Google-Smtp-Source: ABdhPJzBC71jjkbBR0qLVaxwY8Sz7T5T8/OF9sZ1007Ob8Tc91ZwM3byzDM9boDt/sr8l77cBdif0g==
X-Received: by 2002:a05:600c:4108:: with SMTP id
 j8mr1574053wmi.116.1600242991354; 
 Wed, 16 Sep 2020 00:56:31 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id c25sm3681405wml.31.2020.09.16.00.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 00:56:30 -0700 (PDT)
Subject: Re: [PATCH V9 6/6] hw/mips: Add Loongson-3 machine support
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
 <1600222344-16808-7-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c3804617-7c65-4082-de76-81e718f6d139@amsat.org>
Date: Wed, 16 Sep 2020 09:56:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600222344-16808-7-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Huacai,

On 9/16/20 4:12 AM, Huacai Chen wrote:
> Add Loongson-3 based machine support, it use liointc as the interrupt
> controler and use GPEX as the pci controller. Currently it can work with
> both TCG and KVM.
> 
> As the machine model is not based on any exiting physical hardware, the
> name of the machine is "loongson3-virt". It may be superseded in future
> by a real machine model. If this happens, then a regular deprecation
> procedure shall occur for "loongson3-virt" machine.

Alternatively you can name it loongson3-virt-5.2 from start.

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

Which produces all the following errors:

hw/mips/loongson3_virt.c: In function 'get_cpu_freq':
hw/mips/loongson3_virt.c:372:12: error: variable 'freq_reg' has
initializer but incomplete type
     struct kvm_one_reg freq_reg = {
            ^
hw/mips/loongson3_virt.c:373:9: error: unknown field 'id' specified in
initializer
         .id = KVM_REG_MIPS_COUNT_HZ,
         ^
hw/mips/loongson3_virt.c:373:15: error: 'KVM_REG_MIPS_COUNT_HZ'
undeclared (first use in this function)
         .id = KVM_REG_MIPS_COUNT_HZ,
               ^
hw/mips/loongson3_virt.c:373:15: note: each undeclared identifier is
reported only once for each function it appears in
hw/mips/loongson3_virt.c:373:15: error: excess elements in struct
initializer [-Werror]
hw/mips/loongson3_virt.c:373:15: note: (near initialization for 'freq_reg')
hw/mips/loongson3_virt.c:374:9: error: unknown field 'addr' specified in
initializer
         .addr = (uintptr_t)(&freq)
         ^
hw/mips/loongson3_virt.c:374:17: error: excess elements in struct
initializer [-Werror]
         .addr = (uintptr_t)(&freq)
                 ^
hw/mips/loongson3_virt.c:374:17: note: (near initialization for 'freq_reg')
hw/mips/loongson3_virt.c:372:24: error: storage size of 'freq_reg' isn't
known
     struct kvm_one_reg freq_reg = {
                        ^
hw/mips/loongson3_virt.c:380:41: error: 'KVM_GET_ONE_REG' undeclared
(first use in this function)
         ret = kvm_vcpu_ioctl(first_cpu, KVM_GET_ONE_REG, &freq_reg);
                                         ^
hw/mips/loongson3_virt.c:372:24: error: unused variable 'freq_reg'
[-Werror=unused-variable]
     struct kvm_one_reg freq_reg = {
                        ^
hw/mips/loongson3_virt.c: In function 'init_loongson_params':
hw/mips/loongson3_virt.c:467:25: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
     lp->memory_offset = (unsigned long long)init_memory_map(p)
                         ^
hw/mips/loongson3_virt.c:468:27: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
                         - (unsigned long long)lp;
                           ^
hw/mips/loongson3_virt.c:471:22: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
     lp->cpu_offset = (unsigned long long)init_cpu_info(p)
                      ^
hw/mips/loongson3_virt.c:472:24: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
                      - (unsigned long long)lp;
                        ^
hw/mips/loongson3_virt.c:475:25: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
     lp->system_offset = (unsigned long long)init_system_loongson(p)
                         ^
hw/mips/loongson3_virt.c:476:27: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
                         - (unsigned long long)lp;
                           ^
hw/mips/loongson3_virt.c:479:22: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
     lp->irq_offset = (unsigned long long)init_irq_source(p)
                      ^
hw/mips/loongson3_virt.c:480:24: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
                      - (unsigned long long)lp;
                        ^
hw/mips/loongson3_virt.c:483:28: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
     lp->interface_offset = (unsigned long long)init_interface_info(p)
                            ^
hw/mips/loongson3_virt.c:484:30: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
                            - (unsigned long long)lp;
                              ^
hw/mips/loongson3_virt.c:487:33: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
     lp->boarddev_table_offset = (unsigned long long)board_devices_info(p)
                                 ^
hw/mips/loongson3_virt.c:488:35: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
                                 - (unsigned long long)lp;
                                   ^
hw/mips/loongson3_virt.c:491:26: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
     lp->special_offset = (unsigned long long)init_special_info(p)
                          ^
hw/mips/loongson3_virt.c:492:28: error: cast from pointer to integer of
different size [-Werror=pointer-to-int-cast]
                          - (unsigned long long)lp;
                            ^
hw/mips/loongson3_virt.c: In function 'set_prom_cmdline':
hw/mips/loongson3_virt.c:652:21: error: format '%ld' expects argument of
type 'long int', but argument 3 has type 'uint64_t {aka long long
unsigned int}' [-Werror=format=]
     sprintf(memenv, "%ld", loaderparams.ram_size > 0x10000000
                     ^
hw/mips/loongson3_virt.c:654:25: error: format '%ld' expects argument of
type 'long int', but argument 3 has type 'uint64_t {aka long long
unsigned int}' [-Werror=format=]
     sprintf(highmemenv, "%ld", loaderparams.ram_size > 0x10000000
                         ^
cc1: all warnings being treated as errors
Makefile.ninja:2459: recipe for target
'libqemu-mips64el-softmmu.fa.p/hw_mips_loongson3_virt.c.obj' failed
make: *** [libqemu-mips64el-softmmu.fa.p/hw_mips_loongson3_virt.c.obj]
Error 1

Anyway I'll keep reviewing this patch.

> 5, modprobe kvm (only necessary for KVM mode);
> 6, Use QEMU with TCG:
>        qemu-system-mips64el -M loongson3-virt,accel=tcg -cpu Loongson-3A1000 -kernel <path_to_kernel> -append ...
>    Use QEMU with KVM:
>        qemu-system-mips64el -M loongson3-virt,accel=kvm -cpu Loongson-3A4000 -kernel <path_to_kernel> -append ...
> 
>    The "-cpu" parameter is optional here and QEMU will use the correct type for TCG/KVM automatically.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  default-configs/mips64el-softmmu.mak |   1 +
>  hw/mips/Kconfig                      |  11 +
>  hw/mips/fw_cfg.c                     |  35 ++
>  hw/mips/fw_cfg.h                     |  19 +
>  hw/mips/loongson3_virt.c             | 956 +++++++++++++++++++++++++++++++++++
>  hw/mips/meson.build                  |   3 +-
>  6 files changed, 1024 insertions(+), 1 deletion(-)
>  create mode 100644 hw/mips/fw_cfg.c
>  create mode 100644 hw/mips/fw_cfg.h
>  create mode 100644 hw/mips/loongson3_virt.c
> 
> diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
> index 9f8a3ef..26c660a 100644
> --- a/default-configs/mips64el-softmmu.mak
> +++ b/default-configs/mips64el-softmmu.mak
> @@ -3,6 +3,7 @@
>  include mips-softmmu-common.mak
>  CONFIG_IDE_VIA=y
>  CONFIG_FULOONG=y
> +CONFIG_LOONGSON3V=y
>  CONFIG_ATI_VGA=y
>  CONFIG_RTL8139_PCI=y
>  CONFIG_JAZZ=y
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
> diff --git a/hw/mips/fw_cfg.c b/hw/mips/fw_cfg.c
> new file mode 100644
> index 0000000..67c4a74
> --- /dev/null
> +++ b/hw/mips/fw_cfg.c
> @@ -0,0 +1,35 @@
> +/*
> + * QEMU fw_cfg helpers (MIPS specific)
> + *
> + * Copyright (c) 2020 Lemote, Inc.
> + *
> + * Author:
> + *   Huacai Chen (chenhc@lemote.com)
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/mips/fw_cfg.h"
> +#include "hw/nvram/fw_cfg.h"
> +
> +const char *fw_cfg_arch_key_name(uint16_t key)
> +{
> +    static const struct {
> +        uint16_t key;
> +        const char *name;
> +    } fw_cfg_arch_wellknown_keys[] = {
> +        {FW_CFG_MACHINE_VERSION, "machine_version"},
> +        {FW_CFG_CPU_FREQ, "cpu_frequency"},
> +    };
> +
> +    for (size_t i = 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i++) {
> +        if (fw_cfg_arch_wellknown_keys[i].key == key) {
> +            return fw_cfg_arch_wellknown_keys[i].name;
> +        }
> +    }
> +    return NULL;
> +}
> diff --git a/hw/mips/fw_cfg.h b/hw/mips/fw_cfg.h
> new file mode 100644
> index 0000000..e317d5b
> --- /dev/null
> +++ b/hw/mips/fw_cfg.h
> @@ -0,0 +1,19 @@
> +/*
> + * QEMU fw_cfg helpers (MIPS specific)
> + *
> + * Copyright (c) 2020 Huacai Chen
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +
> +#ifndef HW_MIPS_FW_CFG_H
> +#define HW_MIPS_FW_CFG_H
> +
> +#include "hw/boards.h"
> +#include "hw/nvram/fw_cfg.h"
> +
> +/* Data for BIOS to identify machine */
> +#define FW_CFG_MACHINE_VERSION  (FW_CFG_ARCH_LOCAL + 0)
> +#define FW_CFG_CPU_FREQ         (FW_CFG_ARCH_LOCAL + 1)
> +
> +#endif

Please keep the fw_cfg changes in a separate patch.

> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> new file mode 100644
> index 0000000..14d3024
> --- /dev/null
> +++ b/hw/mips/loongson3_virt.c
> @@ -0,0 +1,956 @@
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
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "elf.h"
> +#include "kvm_mips.h"
> +#include "hw/boards.h"
> +#include "hw/char/serial.h"
> +#include "hw/mips/mips.h"
> +#include "hw/mips/cpudevs.h"
> +#include "hw/mips/fw_cfg.h"
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
> +/*
> + * LEFI (a UEFI-like interface for BIOS-Kernel boot parameters) data structrues
> + * defined at arch/mips/include/asm/mach-loongson64/boot_param.h in Linux kernel
> + */
> +struct efi_memory_map_loongson {
> +    uint16_t vers;               /* version of efi_memory_map */
> +    uint32_t nr_map;             /* number of memory_maps */
> +    uint32_t mem_freq;           /* memory frequence */
> +    struct mem_map {
> +        uint32_t node_id;        /* node_id which memory attached to */
> +        uint32_t mem_type;       /* system memory, pci memory, pci io, etc. */
> +        uint64_t mem_start;      /* memory map start address */
> +        uint32_t mem_size;       /* each memory_map size, not the total size */
> +    } map[128];
> +} __attribute__((packed));

QEMU_PACKED

> +
> +enum loongson_cpu_type {
> +    Legacy_2E = 0x0,
> +    Legacy_2F = 0x1,
> +    Legacy_3A = 0x2,
> +    Legacy_3B = 0x3,
> +    Legacy_1A = 0x4,
> +    Legacy_1B = 0x5,
> +    Legacy_2G = 0x6,
> +    Legacy_2H = 0x7,
> +    Loongson_1A = 0x100,
> +    Loongson_1B = 0x101,
> +    Loongson_2E = 0x200,
> +    Loongson_2F = 0x201,
> +    Loongson_2G = 0x202,
> +    Loongson_2H = 0x203,
> +    Loongson_3A = 0x300,
> +    Loongson_3B = 0x301
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
> +    uint32_t PIC_type;           /* conform use HT or PCI to route to CPU-PIC */
> +    uint64_t ht_int_bit;         /* 3A: 1<<24; 3B: 1<<16 */
> +    uint64_t ht_enable;          /* irqs used in this PIC */
> +    uint32_t node_id;            /* node id: 0x0-0; 0x1-1; 0x10-2; 0x11-3 */
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
> +    uint64_t memory_offset;      /* efi_memory_map_loongson struct offset */
> +    uint64_t cpu_offset;         /* efi_cpuinfo_loongson struct offset */
> +    uint64_t system_offset;      /* system_loongson struct offset */
> +    uint64_t irq_offset;         /* irq_source_routing_table struct offset */
> +    uint64_t interface_offset;   /* interface_info struct offset */
> +    uint64_t special_offset;     /* loongson_special_attribute struct offset */
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

What about moving most of this declarations in a "loongson_efi.h"
local header?

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
> +static const struct MemmapEntry virt_memmap[] = {
> +    [VIRT_LOWMEM] =      { 0x00000000,    0x10000000 },
> +    [VIRT_PM] =          { 0x10080000,         0x100 },
> +    [VIRT_FW_CFG] =      { 0x10080100,         0x100 },
> +    [VIRT_RTC] =         { 0x10081000,        0x1000 },
> +    [VIRT_PCIE_PIO] =    { 0x18000000,       0x80000 },
> +    [VIRT_PCIE_ECAM] =   { 0x1a000000,     0x2000000 },
> +    [VIRT_BIOS_ROM] =    { 0x1fc00000,      0x200000 },
> +    [VIRT_UART] =        { 0x1fe001e0,           0x8 },
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
> +static struct efi_memory_map_loongson *init_memory_map(void *g_map)
> +{
> +    struct efi_memory_map_loongson *emap = g_map;
> +
> +    emap->nr_map = 2;
> +    emap->mem_freq = 300000000;
> +
> +    emap->map[0].node_id = 0;
> +    emap->map[0].mem_type = 1;
> +    emap->map[0].mem_start = 0x0;
> +    emap->map[0].mem_size = 240;
> +
> +    emap->map[1].node_id = 0;
> +    emap->map[1].mem_type = 2;
> +    emap->map[1].mem_start = 0x90000000;
> +    emap->map[1].mem_size = (loaderparams.ram_size / MiB) - 256;
> +
> +    return emap;
> +}
> +
> +static uint64_t get_cpu_freq(void)
> +{
> +    int ret;
> +    uint64_t freq;
> +    struct kvm_one_reg freq_reg = {
> +        .id = KVM_REG_MIPS_COUNT_HZ,
> +        .addr = (uintptr_t)(&freq)
> +    };
> +
> +    if (!kvm_enabled()) {
> +        return 200 * 1000 * 1000;

You earlier commented:
"Loongson-3 CPU (MIPS64R2 with extensions, 800~2000MHz"

Why not use 800 here?

> +    } else {
> +        ret = kvm_vcpu_ioctl(first_cpu, KVM_GET_ONE_REG, &freq_reg);
> +        if (ret < 0) {
> +            return 1600 * 1000 * 1000;
> +        }
> +        return (freq * 2);
> +    }
> +}
> +
> +static struct efi_cpuinfo_loongson *init_cpu_info(void *g_cpuinfo_loongson)
> +{
> +    struct efi_cpuinfo_loongson *c = g_cpuinfo_loongson;
> +
> +    c->cputype = Loongson_3A;
> +    c->processor_id = MIPS_CPU(first_cpu)->env.CP0_PRid;
> +    if (loaderparams.cpu_freq > UINT_MAX) {
> +        c->cpu_clock_freq = UINT_MAX;
> +    } else {
> +        c->cpu_clock_freq = loaderparams.cpu_freq;
> +    }
> +
> +    c->cpu_startup_core_id = 0;
> +    c->nr_cpus = current_machine->smp.cpus;
> +    c->total_node = (current_machine->smp.cpus + 3) / 4;
> +
> +    return c;
> +}
> +
> +static struct system_loongson *init_system_loongson(void *g_system)
> +{
> +    struct system_loongson *s = g_system;
> +
> +    s->ccnuma_smp = 0;
> +    s->sing_double_channel = 1;
> +    s->nr_uarts = 1;
> +    s->uarts[0].iotype = 2;
> +    s->uarts[0].int_offset = 2;
> +    s->uarts[0].uartclk = 25000000; /* Random value */
> +    s->uarts[0].uart_base = virt_memmap[VIRT_UART].base;
> +
> +    return s;
> +}
> +
> +static struct irq_source_routing_table *init_irq_source(void *g_irq_source)
> +{
> +    struct irq_source_routing_table *irq_info = g_irq_source;
> +
> +    irq_info->node_id = 0;
> +    irq_info->PIC_type = 0;
> +    irq_info->dma_mask_bits = 64;
> +    irq_info->pci_mem_start_addr = virt_memmap[VIRT_PCIE_MMIO].base;
> +    irq_info->pci_mem_end_addr   = virt_memmap[VIRT_PCIE_MMIO].base +
> +                                   virt_memmap[VIRT_PCIE_MMIO].size - 1;
> +    irq_info->pci_io_start_addr  = virt_memmap[VIRT_PCIE_PIO].base;
> +
> +    return irq_info;
> +}
> +
> +static struct interface_info *init_interface_info(void *g_interface)
> +{
> +    struct interface_info *interface = g_interface;
> +
> +    interface->vers = 0x01;
> +    strcpy(interface->description, "UEFI_Version_v1.0");
> +
> +    return interface;
> +}
> +
> +static struct board_devices *board_devices_info(void *g_board)
> +{
> +    struct board_devices *bd = g_board;
> +
> +    strcpy(bd->name, "Loongson-3A-VIRT-1w-V1.00-demo");
> +
> +    return bd;
> +}
> +
> +static struct loongson_special_attribute *init_special_info(void *g_special)
> +{
> +    struct loongson_special_attribute *special = g_special;
> +
> +    strcpy(special->special_name, "2017-05-01");

strpadcpy?

> +
> +    return special;
> +}
> +
> +static void init_loongson_params(struct loongson_params *lp, void *p)
> +{
> +    lp->memory_offset = (unsigned long long)init_memory_map(p)
> +                        - (unsigned long long)lp;
> +    p += align(sizeof(struct efi_memory_map_loongson));

       p += ROUND_UP(sizeof(struct efi_memory_map_loongson), 64);

or use QEMU_ALIGN_PTR_UP()?

> +
> +    lp->cpu_offset = (unsigned long long)init_cpu_info(p)
> +                     - (unsigned long long)lp;
> +    p += align(sizeof(struct efi_cpuinfo_loongson));
> +
> +    lp->system_offset = (unsigned long long)init_system_loongson(p)
> +                        - (unsigned long long)lp;
> +    p += align(sizeof(struct system_loongson));
> +
> +    lp->irq_offset = (unsigned long long)init_irq_source(p)
> +                     - (unsigned long long)lp;
> +    p += align(sizeof(struct irq_source_routing_table));
> +
> +    lp->interface_offset = (unsigned long long)init_interface_info(p)
> +                           - (unsigned long long)lp;
> +    p += align(sizeof(struct interface_info));
> +
> +    lp->boarddev_table_offset = (unsigned long long)board_devices_info(p)
> +                                - (unsigned long long)lp;
> +    p += align(sizeof(struct board_devices));
> +
> +    lp->special_offset = (unsigned long long)init_special_info(p)
> +                         - (unsigned long long)lp;
> +    p += align(sizeof(struct loongson_special_attribute));
> +}
> +
> +static void init_reset_system(struct efi_reset_system_t *reset)
> +{
> +    reset->Shutdown = 0xffffffffbfc000a8;
> +    reset->ResetCold = 0xffffffffbfc00080;
> +    reset->ResetWarm = 0xffffffffbfc00080;
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
> +    bp->efi.smbios.vers = 1;
> +    init_reset_system(&(bp->reset_system));
> +    p += align(sizeof(struct boot_params));
> +    init_loongson_params(&(bp->efi.smbios.lp), p);
> +
> +    rom_add_blob_fixed("params_rom", bp,
> +                       loader_rommap[LOADER_PARAM].size,
> +                       loader_rommap[LOADER_PARAM].base);
> +
> +    g_free(bp);
> +
> +    loaderparams.a2 = cpu_mips_phys_to_kseg0(NULL,
> +                                             loader_rommap[LOADER_PARAM].base);
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
> +    sprintf(memenv, "%ld", loaderparams.ram_size > 0x10000000
> +            ? 256 : (loaderparams.ram_size >> 20));

Please use 256 * MiB and MiB.

(I'm not sure why you check this, since you enforce 512M min).

> +    sprintf(highmemenv, "%ld", loaderparams.ram_size > 0x10000000
> +            ? (loaderparams.ram_size >> 20) - 256 : 0);
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
> +            error_report("Loongson-3/TCG need cpu type Loongson-3A1000");
> +            exit(1);
> +        }
> +    } else {
> +        if (!machine->cpu_type) {
> +            machine->cpu_type = MIPS_CPU_TYPE_NAME("Loongson-3A4000");
> +        }
> +        if (!strstr(machine->cpu_type, "Loongson-3A4000")) {
> +            error_report("Loongson-3/KVM need cpu type Loongson-3A4000");
> +            exit(1);
> +        }
> +    }
> +
> +    if (ram_size < 512 * MiB) {
> +        error_report("Loongson-3 need at least 512MB memory");

Typo "needs", but why?

> +        exit(1);
> +    }
> +
> +    /*
> +     * The whole MMIO range among configure registers doesn't generate
> +     * exception when accessing invalid memory. Create an empty slot to
> +     * emulate this feature.
> +     */
> +    empty_slot_init("fallback", 0, 0x80000000);

Again, this doesn't look correct (no comment in my previous review).

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
> +}
> +
> +static void mips_loongson3_virt_machine_init(MachineClass *mc)
> +{
> +    mc->desc = "Loongson-3 Virtualization Platform";
> +    mc->init = mips_loongson3_virt_init;
> +    mc->block_default_type = IF_IDE;
> +    mc->max_cpus = LOONGSON_MAX_VCPUS;
> +    mc->default_ram_id = "loongson3.highram";
> +    mc->default_ram_size = 1600 * MiB;
> +    mc->kvm_type = mips_kvm_type;
> +    mc->minimum_page_bits = 14;
> +}
> +
> +DEFINE_MACHINE("loongson3-virt", mips_loongson3_virt_machine_init)
> diff --git a/hw/mips/meson.build b/hw/mips/meson.build
> index 46294b7..32c8b95 100644
> --- a/hw/mips/meson.build
> +++ b/hw/mips/meson.build
> @@ -1,6 +1,7 @@
>  mips_ss = ss.source_set()
> -mips_ss.add(files('addr.c', 'mips_int.c'))
> +mips_ss.add(files('addr.c', 'mips_int.c', 'fw_cfg.c'))
>  mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
> +mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_virt.c'))
>  mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
>  mips_ss.add(when: 'CONFIG_MALTA', if_true: files('gt64xxx_pci.c', 'malta.c'))
>  mips_ss.add(when: 'CONFIG_MIPSSIM', if_true: files('mipssim.c'))
> 

