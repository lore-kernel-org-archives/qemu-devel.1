Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359A8C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03A42064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 13:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03A42064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCkno-0002sF-AF
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 09:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCkhn-0005Vr-Hb
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCkhl-0005C6-BJ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:18:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31409)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCkhl-0005Bl-2z
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:18:09 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E9146796E4
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 13:18:07 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id w10so563185wrl.5
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fDhHJknRHK/kyyBKkQt6AI1V+kYp6hpu6A1rqJMmhkg=;
 b=GyR0+ga8p+qx5XHlAuMeu66S5E9lwO1lNtEN7KeOGKNnm8HY5P79WIoEA1ew1cQU2o
 o4AajVUQW5m/q1gUCd0Tc1tBKQeomtymu1PqcXCH5x/SgjWDFtQrRDJif1Upkhvztnpg
 w55yy1YVvkuRrlMas/ckCzbM2ZH7ur5rnAt7qXs53ZDMuFybpoPhE9rV8W9qPM4NaNgJ
 mcb9TxDos9rzFwQ4xnD8tduFoNBIIHrfa2HTEv0hjuK8R4qY4i6IHNTAk6fOw4h408EP
 BujAvSZl2qnO2cYnDPOkY/EwLXeD29x+F1N66froTFkgzYtiq2/zSG4N9VnhyUuGy5MU
 KvzA==
X-Gm-Message-State: APjAAAVdsir/mYbA2PSGL3AXwAL+xbqNDMDzDtDfcqg/yGvBSqYkpBlM
 vU7eGZqQro92SnuVjoBf+EDx3fq4NKaxYndRf1PTCuNiNzrj7bK6ZCIkYTQ2QpIp1o9a5p5e2yC
 IJvpPIXJ6Owt1pcU=
X-Received: by 2002:a05:6000:1002:: with SMTP id
 a2mr2267899wrx.272.1569331086559; 
 Tue, 24 Sep 2019 06:18:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzYeYS/3ORzLGJwvMHlqBQR8QbDMQ+bO/Rtje0DjTPUvVysDKpvKqwgeW/uDXwzidy06n+sUw==
X-Received: by 2002:a05:6000:1002:: with SMTP id
 a2mr2267875wrx.272.1569331086281; 
 Tue, 24 Sep 2019 06:18:06 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id g73sm1326655wme.10.2019.09.24.06.18.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 06:18:05 -0700 (PDT)
Subject: Re: [PATCH v4 1/8] hw/i386: Factorize PVH related functions
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-2-slp@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1f1e944f-0076-6c96-3da0-ea196e2d21a1@redhat.com>
Date: Tue, 24 Sep 2019 15:18:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924124433.96810-2-slp@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sergio,

On 9/24/19 2:44 PM, Sergio Lopez wrote:
> Extract PVH related functions from pc.c, and put them in pvh.c, so
> they can be shared with other components.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  hw/i386/Makefile.objs |   1 +
>  hw/i386/pc.c          | 120 +++++-------------------------------------
>  hw/i386/pvh.c         | 113 +++++++++++++++++++++++++++++++++++++++
>  hw/i386/pvh.h         |  10 ++++
>  4 files changed, 136 insertions(+), 108 deletions(-)
>  create mode 100644 hw/i386/pvh.c
>  create mode 100644 hw/i386/pvh.h
> 
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 5d9c9efd5f..c5f20bbd72 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_KVM) += kvm/
>  obj-y += multiboot.o
> +obj-y += pvh.o
>  obj-y += pc.o
>  obj-$(CONFIG_I440FX) += pc_piix.o
>  obj-$(CONFIG_Q35) += pc_q35.o
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index bad866fe44..10e4ced0c6 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -42,6 +42,7 @@
>  #include "elf.h"
>  #include "migration/vmstate.h"
>  #include "multiboot.h"
> +#include "pvh.h"
>  #include "hw/timer/mc146818rtc.h"
>  #include "hw/dma/i8257.h"
>  #include "hw/timer/i8254.h"
> @@ -116,9 +117,6 @@ static struct e820_entry *e820_table;
>  static unsigned e820_entries;
>  struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
>  
> -/* Physical Address of PVH entry point read from kernel ELF NOTE */
> -static size_t pvh_start_addr;
> -
>  GlobalProperty pc_compat_4_1[] = {};
>  const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
>  
> @@ -1076,109 +1074,6 @@ struct setup_data {
>      uint8_t data[0];
>  } __attribute__((packed));
>  
> -
> -/*
> - * The entry point into the kernel for PVH boot is different from
> - * the native entry point.  The PVH entry is defined by the x86/HVM
> - * direct boot ABI and is available in an ELFNOTE in the kernel binary.
> - *
> - * This function is passed to load_elf() when it is called from
> - * load_elfboot() which then additionally checks for an ELF Note of
> - * type XEN_ELFNOTE_PHYS32_ENTRY and passes it to this function to
> - * parse the PVH entry address from the ELF Note.
> - *
> - * Due to trickery in elf_opts.h, load_elf() is actually available as
> - * load_elf32() or load_elf64() and this routine needs to be able
> - * to deal with being called as 32 or 64 bit.
> - *
> - * The address of the PVH entry point is saved to the 'pvh_start_addr'
> - * global variable.  (although the entry point is 32-bit, the kernel
> - * binary can be either 32-bit or 64-bit).
> - */
> -static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
> -{
> -    size_t *elf_note_data_addr;
> -
> -    /* Check if ELF Note header passed in is valid */
> -    if (arg1 == NULL) {
> -        return 0;
> -    }
> -
> -    if (is64) {
> -        struct elf64_note *nhdr64 = (struct elf64_note *)arg1;
> -        uint64_t nhdr_size64 = sizeof(struct elf64_note);
> -        uint64_t phdr_align = *(uint64_t *)arg2;
> -        uint64_t nhdr_namesz = nhdr64->n_namesz;
> -
> -        elf_note_data_addr =
> -            ((void *)nhdr64) + nhdr_size64 +
> -            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
> -    } else {
> -        struct elf32_note *nhdr32 = (struct elf32_note *)arg1;
> -        uint32_t nhdr_size32 = sizeof(struct elf32_note);
> -        uint32_t phdr_align = *(uint32_t *)arg2;
> -        uint32_t nhdr_namesz = nhdr32->n_namesz;
> -
> -        elf_note_data_addr =
> -            ((void *)nhdr32) + nhdr_size32 +
> -            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
> -    }
> -
> -    pvh_start_addr = *elf_note_data_addr;
> -
> -    return pvh_start_addr;
> -}
> -
> -static bool load_elfboot(const char *kernel_filename,
> -                   int kernel_file_size,
> -                   uint8_t *header,
> -                   size_t pvh_xen_start_addr,
> -                   FWCfgState *fw_cfg)
> -{
> -    uint32_t flags = 0;
> -    uint32_t mh_load_addr = 0;
> -    uint32_t elf_kernel_size = 0;
> -    uint64_t elf_entry;
> -    uint64_t elf_low, elf_high;
> -    int kernel_size;
> -
> -    if (ldl_p(header) != 0x464c457f) {
> -        return false; /* no elfboot */
> -    }
> -
> -    bool elf_is64 = header[EI_CLASS] == ELFCLASS64;
> -    flags = elf_is64 ?
> -        ((Elf64_Ehdr *)header)->e_flags : ((Elf32_Ehdr *)header)->e_flags;
> -
> -    if (flags & 0x00010004) { /* LOAD_ELF_HEADER_HAS_ADDR */
> -        error_report("elfboot unsupported flags = %x", flags);
> -        exit(1);
> -    }
> -
> -    uint64_t elf_note_type = XEN_ELFNOTE_PHYS32_ENTRY;
> -    kernel_size = load_elf(kernel_filename, read_pvh_start_addr,
> -                           NULL, &elf_note_type, &elf_entry,
> -                           &elf_low, &elf_high, 0, I386_ELF_MACHINE,
> -                           0, 0);
> -
> -    if (kernel_size < 0) {
> -        error_report("Error while loading elf kernel");
> -        exit(1);
> -    }
> -    mh_load_addr = elf_low;
> -    elf_kernel_size = elf_high - elf_low;
> -
> -    if (pvh_start_addr == 0) {
> -        error_report("Error loading uncompressed kernel without PVH ELF Note");
> -        exit(1);
> -    }
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, pvh_start_addr);
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
> -    fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, elf_kernel_size);
> -
> -    return true;
> -}
> -
>  static void load_linux(PCMachineState *pcms,
>                         FWCfgState *fw_cfg)
>  {
> @@ -1218,6 +1113,9 @@ static void load_linux(PCMachineState *pcms,
>      if (ldl_p(header+0x202) == 0x53726448) {
>          protocol = lduw_p(header+0x206);
>      } else {
> +        size_t pvh_start_addr;
> +        uint32_t mh_load_addr = 0;
> +        uint32_t elf_kernel_size = 0;
>          /*
>           * This could be a multiboot kernel. If it is, let's stop treating it
>           * like a Linux kernel.
> @@ -1235,10 +1133,16 @@ static void load_linux(PCMachineState *pcms,
>           * If load_elfboot() is successful, populate the fw_cfg info.
>           */
>          if (pcmc->pvh_enabled &&
> -            load_elfboot(kernel_filename, kernel_size,
> -                         header, pvh_start_addr, fw_cfg)) {
> +            pvh_load_elfboot(kernel_filename,
> +                             &mh_load_addr, &elf_kernel_size)) {
>              fclose(f);
>  
> +            pvh_start_addr = pvh_get_start_addr();
> +
> +            fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ENTRY, pvh_start_addr);
> +            fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, mh_load_addr);
> +            fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, elf_kernel_size);
> +
>              fw_cfg_add_i32(fw_cfg, FW_CFG_CMDLINE_SIZE,
>                  strlen(kernel_cmdline) + 1);
>              fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA, kernel_cmdline);
> diff --git a/hw/i386/pvh.c b/hw/i386/pvh.c
> new file mode 100644
> index 0000000000..1c81727811
> --- /dev/null
> +++ b/hw/i386/pvh.c
> @@ -0,0 +1,113 @@
> +/*
> + * PVH Boot Helper
> + *
> + * Copyright (C) 2019 Oracle
> + * Copyright (C) 2019 Red Hat, Inc
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "hw/loader.h"
> +#include "cpu.h"
> +#include "elf.h"
> +#include "pvh.h"
> +
> +static size_t pvh_start_addr;
> +
> +size_t pvh_get_start_addr(void)
> +{
> +    return pvh_start_addr;
> +}
> +
> +/*
> + * The entry point into the kernel for PVH boot is different from
> + * the native entry point.  The PVH entry is defined by the x86/HVM
> + * direct boot ABI and is available in an ELFNOTE in the kernel binary.
> + *
> + * This function is passed to load_elf() when it is called from
> + * load_elfboot() which then additionally checks for an ELF Note of
> + * type XEN_ELFNOTE_PHYS32_ENTRY and passes it to this function to
> + * parse the PVH entry address from the ELF Note.
> + *
> + * Due to trickery in elf_opts.h, load_elf() is actually available as
> + * load_elf32() or load_elf64() and this routine needs to be able
> + * to deal with being called as 32 or 64 bit.
> + *
> + * The address of the PVH entry point is saved to the 'pvh_start_addr'
> + * global variable.  (although the entry point is 32-bit, the kernel
> + * binary can be either 32-bit or 64-bit).
> + */
> +
> +static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
> +{
> +    size_t *elf_note_data_addr;
> +
> +    /* Check if ELF Note header passed in is valid */
> +    if (arg1 == NULL) {
> +        return 0;
> +    }
> +
> +    if (is64) {
> +        struct elf64_note *nhdr64 = (struct elf64_note *)arg1;
> +        uint64_t nhdr_size64 = sizeof(struct elf64_note);
> +        uint64_t phdr_align = *(uint64_t *)arg2;
> +        uint64_t nhdr_namesz = nhdr64->n_namesz;
> +
> +        elf_note_data_addr =
> +            ((void *)nhdr64) + nhdr_size64 +
> +            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
> +    } else {
> +        struct elf32_note *nhdr32 = (struct elf32_note *)arg1;
> +        uint32_t nhdr_size32 = sizeof(struct elf32_note);
> +        uint32_t phdr_align = *(uint32_t *)arg2;
> +        uint32_t nhdr_namesz = nhdr32->n_namesz;
> +
> +        elf_note_data_addr =
> +            ((void *)nhdr32) + nhdr_size32 +
> +            QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
> +    }
> +
> +    pvh_start_addr = *elf_note_data_addr;
> +
> +    return pvh_start_addr;
> +}
> +
> +bool pvh_load_elfboot(const char *kernel_filename,
> +                      uint32_t *mh_load_addr,
> +                      uint32_t *elf_kernel_size)
> +{
> +    uint64_t elf_entry;
> +    uint64_t elf_low, elf_high;
> +    int kernel_size;
> +    uint64_t elf_note_type = XEN_ELFNOTE_PHYS32_ENTRY;
> +
> +    kernel_size = load_elf(kernel_filename, read_pvh_start_addr,
> +                           NULL, &elf_note_type, &elf_entry,
> +                           &elf_low, &elf_high, 0, I386_ELF_MACHINE,
> +                           0, 0);
> +
> +    if (kernel_size < 0) {
> +        error_report("Error while loading elf kernel");
> +        return false;
> +    }
> +
> +    if (pvh_start_addr == 0) {
> +        error_report("Error loading uncompressed kernel without PVH ELF Note");
> +        return false;
> +    }
> +
> +    if (mh_load_addr) {
> +        *mh_load_addr = elf_low;
> +    }
> +
> +    if (elf_kernel_size) {
> +        *elf_kernel_size = elf_high - elf_low;
> +    }
> +
> +    return true;
> +}
> diff --git a/hw/i386/pvh.h b/hw/i386/pvh.h
> new file mode 100644
> index 0000000000..ada67ff6e8
> --- /dev/null
> +++ b/hw/i386/pvh.h
> @@ -0,0 +1,10 @@

License missing.

> +#ifndef HW_I386_PVH_H
> +#define HW_I386_PVH_H
> +
> +size_t pvh_get_start_addr(void);
> +
> +bool pvh_load_elfboot(const char *kernel_filename,
> +                      uint32_t *mh_load_addr,
> +                      uint32_t *elf_kernel_size);

Can you document these functions?

Thanks,

Phil.

> +
> +#endif
> 

