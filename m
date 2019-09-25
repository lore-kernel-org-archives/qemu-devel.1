Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BDEC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C06020872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C06020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2nc-0004ll-16
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 04:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iD2mT-0004N6-P6
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iD2mR-0002NG-Ms
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:36:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iD2mR-0002Mu-Dh
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:36:11 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 35B4A2026F
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:36:09 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id t11so1961601wro.10
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 01:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1ohn8p79lNMpElVFDbxHWMU4EUIL4XgXMdtrUXfg+7k=;
 b=JG6ffOhAYH8fbrB5m7mor3Vs8FI4cuyEpMx4v1kDblh3ySwcHKV0/H3s/W9MZZPNYK
 bEUi62s/sXVLQvrt+0dZtk76Ky4PXe6cYXcPdjjo5QXpXBfWy/d4ToOBTbNrtM35Qjis
 q/avr39kxyI49FD4DuS3KXVVDiVPppyMQd/OIYFq5ryAa2idIg2P+sBnxxKn00Ql2rFl
 r2bm0980KMHN25OcC1bD6iB/JDRJVzI/swZjUKsgKLfyOh5tRCNz5WXPKDu6nNns3WRB
 xDyxH2OJDxLVfDu8gFTQx4II5quVg4WPwDogQdLck+woHUpHXvoqt8iBNmF50OTQLgJe
 9MBA==
X-Gm-Message-State: APjAAAWAOwrjFibs7MSbAY9B31gJEXmJL1DjdWR10QDqnw/BR66g2PFu
 FyKiFQURYe/mXXKf34ZnOPoay47rwrrTx8AgskP1kTYIlerkRuFXlqGWRMT2kE2FdGS4+d6CvOW
 0ZShEGTUcUq8COO4=
X-Received: by 2002:a1c:c506:: with SMTP id v6mr5919920wmf.160.1569400567754; 
 Wed, 25 Sep 2019 01:36:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpCqNVXrG3hjMOpKh8aSBmMeHFvgHHy/+Q7TJcuYzW136Pcmxbdef9xeUeLr+rLphmn5UTiQ==
X-Received: by 2002:a1c:c506:: with SMTP id v6mr5919880wmf.160.1569400567384; 
 Wed, 25 Sep 2019 01:36:07 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id a71sm1966476wme.11.2019.09.25.01.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 01:36:06 -0700 (PDT)
Date: Wed, 25 Sep 2019 10:36:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v4 1/8] hw/i386: Factorize PVH related functions
Message-ID: <20190925083604.w77kl2x5umx2rubj@steredhat>
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-2-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924124433.96810-2-slp@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, lersek@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 pbonzini@redhat.com, imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sergio,

On Tue, Sep 24, 2019 at 02:44:26PM +0200, Sergio Lopez wrote:
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

Are we removing the following checks (ELF magic, flags) because they
are superfluous?

Should we mention this in the commit message?

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
> +#ifndef HW_I386_PVH_H
> +#define HW_I386_PVH_H
> +
> +size_t pvh_get_start_addr(void);

What about adding "size_t *pvh_start_addr" to the pvh_load_elfboot()?
Just an idea, I'm not sure if it is better...

> +
> +bool pvh_load_elfboot(const char *kernel_filename,
> +                      uint32_t *mh_load_addr,
> +                      uint32_t *elf_kernel_size);
> +
> +#endif

Thanks,
Stefano

