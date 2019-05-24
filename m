Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B10C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BA9217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+lLiQXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BA9217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54636 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAFA-0000pS-RY
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 09:28:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hUA1N-00083w-BQ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hUA1K-0003hr-AV
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:14:05 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hUA1J-0003fq-U3
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:14:02 -0400
Received: by mail-ot1-x342.google.com with SMTP id t24so8608839otl.12
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ydbGt4w7VHmut++RgvujbiadayyXfAzugBNz13QFk7Q=;
	b=H+lLiQXoWEVk4si2IZ+8vfl7BojobRGbLUl/NCx23DR7RbPoY0srmUyfkKxBVKZOgt
	dCUFJFgu319bgxwM5UuufjmLJ7B2K2CziNBNI0LthuJu8lK8bl/9R9E4WWyI3x2jx+hP
	oJGGGWVv9VhxIHXCszu+x8wLQweL6B3/6fkbe78hlV4THQ6cZS0E1LN73rYguKJKp31Z
	CTIYv0TcY/JDJURHd29+6HTbCwrIEn/op4/yHVn5H3lzKVlmcu9zxBl3wM7GACj6u+r8
	GEpKmHpeB/HL1yxDnDUMLR06b4QVwFd0NmPcvJf1T1qwegnq2NppJf50JKpzclIwH2Ci
	iPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ydbGt4w7VHmut++RgvujbiadayyXfAzugBNz13QFk7Q=;
	b=lVRKfFnnPiD3R5LTPgJ33gtaJigJwpILYAETljZ9CFHayoO/jr2hfMgk26iCl5pgt9
	hwNkiR+MN/CRhu7+vCqEadj7exuGAYR2ul8eRz0V1Iu5V2aZNK/K2yoOVXc5iSbkcaKs
	IntML4tLfQKb5fTP7CJg8Q4eIQwRtfbnYpW4HrdTaC5pcvBHrBc5y0oQhnkgU7RZjSys
	Rwidr2/ft6XQFEwnzNzdfbTheghxxNnVndYL0FUpEzlz5/z02JLoxjjTjPcN+nPhjBWh
	jpNawAAZ5S5dzEszJ2+Rko/zBY7dZd1sFUwdMa6E/Xt2KuU7MiANOZdL69GhSEGFy6X2
	9Q4w==
X-Gm-Message-State: APjAAAXHkAqyQrtKhRDqtgfYwSrhLVLcPhQxXwTk53y33WvgaAtizv1W
	ZbtTvXKTnjvt+75ME9o0HhrZa00duN9atyVmhrg=
X-Google-Smtp-Source: APXvYqyZQBo242scFGGEDPyxg4P8cjiqnZwxnAOcXZzK77w1+e77jsJCdrUCqT7i8c/pDqjqJG0LRXE0V/JYZMPBeDw=
X-Received: by 2002:a9d:6c5a:: with SMTP id g26mr6960800otq.194.1558703640882; 
	Fri, 24 May 2019 06:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190524063553.5339-1-philmd@redhat.com>
	<20190524063553.5339-8-philmd@redhat.com>
In-Reply-To: <20190524063553.5339-8-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 24 May 2019 21:13:24 +0800
Message-ID: <CAKXe6S+SABK+Zx-0mHG7g9MC0Fgopocm9b5i1A37k20YCgOmpQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 07/20] hw/i386/pc: Extract e820 memory
 layout code
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yang Zhong <yang.zhong@intel.com>, Samuel Ortiz <sameo@linux.intel.com>,
	Rob Bradford <robert.bradford@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	"open list:X86" <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B45=E6=
=9C=8824=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=882:41=E5=86=99=E9=81=
=93=EF=BC=9A

> Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>


Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/i386/Makefile.objs        |  2 +-
>  hw/i386/e820_memory_layout.c | 62 +++++++++++++++++++++++++++++
>  hw/i386/e820_memory_layout.h | 76 ++++++++++++++++++++++++++++++++++++
>  hw/i386/pc.c                 | 64 +-----------------------------
>  include/hw/i386/pc.h         | 48 -----------------------
>  target/i386/kvm.c            |  1 +
>  6 files changed, 141 insertions(+), 112 deletions(-)
>  create mode 100644 hw/i386/e820_memory_layout.c
>  create mode 100644 hw/i386/e820_memory_layout.h
>
> diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
> index 5d9c9efd5f..d3374e0831 100644
> --- a/hw/i386/Makefile.objs
> +++ b/hw/i386/Makefile.objs
> @@ -1,5 +1,5 @@
>  obj-$(CONFIG_KVM) +=3D kvm/
> -obj-y +=3D multiboot.o
> +obj-y +=3D e820_memory_layout.o multiboot.o
>  obj-y +=3D pc.o
>  obj-$(CONFIG_I440FX) +=3D pc_piix.o
>  obj-$(CONFIG_Q35) +=3D pc_q35.o
> diff --git a/hw/i386/e820_memory_layout.c b/hw/i386/e820_memory_layout.c
> new file mode 100644
> index 0000000000..b9be08536c
> --- /dev/null
> +++ b/hw/i386/e820_memory_layout.c
> @@ -0,0 +1,62 @@
> +/*
> + * QEMU BIOS e820 routines
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bswap.h"
> +#include "e820_memory_layout.h"
> +
> +static size_t e820_entries;
> +struct e820_table e820_reserve;
> +struct e820_entry *e820_table;
> +
> +ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)
> +{
> +    unsigned int index =3D le32_to_cpu(e820_reserve.count);
> +    uint32_t utype =3D (uint32_t)type;
> +    struct e820_entry *entry;
> +
> +    if (type !=3D E820_RAM) {
> +        /* old FW_CFG_E820_TABLE entry -- reservations only */
> +        if (index >=3D E820_NR_ENTRIES) {
> +            return -EBUSY;
> +        }
> +        entry =3D &e820_reserve.entry[index++];
> +
> +        entry->address =3D cpu_to_le64(address);
> +        entry->length =3D cpu_to_le64(length);
> +        entry->type =3D cpu_to_le32(utype);
> +
> +        e820_reserve.count =3D cpu_to_le32(index);
> +    }
> +
> +    /* new "etc/e820" file -- include ram too */
> +    e820_table =3D g_renew(struct e820_entry, e820_table, e820_entries +=
 1);
> +    e820_table[e820_entries].address =3D cpu_to_le64(address);
> +    e820_table[e820_entries].length =3D cpu_to_le64(length);
> +    e820_table[e820_entries].type =3D cpu_to_le32(utype);
> +    e820_entries++;
> +
> +    return e820_entries;
> +}
> +
> +size_t e820_get_num_entries(void)
> +{
> +    return e820_entries;
> +}
> +
> +bool e820_get_entry(unsigned int idx, E820Type type,
> +                    uint64_t *address, uint64_t *length)
> +{
> +    uint32_t utype =3D (uint32_t)type;
> +    if (idx < e820_entries && e820_table[idx].type =3D=3D cpu_to_le32(ut=
ype))
> {
> +        *address =3D le64_to_cpu(e820_table[idx].address);
> +        *length =3D le64_to_cpu(e820_table[idx].length);
> +        return true;
> +    }
> +    return false;
> +}
> diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
> new file mode 100644
> index 0000000000..64e88e4772
> --- /dev/null
> +++ b/hw/i386/e820_memory_layout.h
> @@ -0,0 +1,76 @@
> +/*
> + * QEMU BIOS e820 routines
> + *
> + * Copyright (c) 2003-2004 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: MIT
> + */
> +
> +#ifndef HW_I386_E820_H
> +#define HW_I386_E820_H
> +
> +/**
> + * E820Type: Type of the e820 address range.
> + */
> +typedef enum {
> +    E820_RAM        =3D 1,
> +    E820_RESERVED   =3D 2,
> +    E820_ACPI       =3D 3,
> +    E820_NVS        =3D 4,
> +    E820_UNUSABLE   =3D 5
> +} E820Type;
> +
> +#define E820_NR_ENTRIES 16
> +
> +struct e820_entry {
> +    uint64_t address;
> +    uint64_t length;
> +    uint32_t type;
> +} QEMU_PACKED __attribute((__aligned__(4)));
> +
> +struct e820_table {
> +    uint32_t count;
> +    struct e820_entry entry[E820_NR_ENTRIES];
> +} QEMU_PACKED __attribute((__aligned__(4)));
> +
> +extern struct e820_table e820_reserve;
> +extern struct e820_entry *e820_table;
> +
> +/**
> + * e820_add_entry: Add an #e820_entry to the @e820_table.
> + *
> + * Returns the number of entries of the e820_table on success,
> + *         or a negative errno otherwise.
> + *
> + * @address: The base address of the structure which the BIOS is to fill
> in.
> + * @length: The length in bytes of the structure passed to the BIOS.
> + * @type: The #E820Type of the address range.
> + */
> +ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)=
;
> +
> +/**
> + * e820_get_num_entries: The number of entries of the @e820_table.
> + *
> + * Returns the number of entries of the e820_table.
> + */
> +size_t e820_get_num_entries(void);
> +
> +/**
> + * e820_get_entry: Get the address/length of an #e820_entry.
> + *
> + * If the #e820_entry stored at @index is of #E820Type @type, fills
> @address
> + * and @length with the #e820_entry values and return @true.
> + * Return @false otherwise.
> + *
> + * @index: The index of the #e820_entry to get values.
> + * @type: The @E820Type of the address range expected.
> + * @address: Pointer to the base address of the #e820_entry structure to
> + *           be filled.
> + * @length: Pointer to the length (in bytes) of the #e820_entry structur=
e
> + *          to be filled.
> + * @return: true if the entry was found, false otherwise.
> + */
> +bool e820_get_entry(unsigned int index, E820Type type,
> +                    uint64_t *address, uint64_t *length);
> +
> +#endif
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2e195049a5..fc22779ac1 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -78,6 +78,7 @@
>  #include "hw/i386/intel_iommu.h"
>  #include "hw/net/ne2000-isa.h"
>  #include "standard-headers/asm-x86/bootparam.h"
> +#include "e820_memory_layout.h"
>
>  /* debug PC/ISA interrupts */
>  //#define DEBUG_IRQ
> @@ -89,22 +90,6 @@
>  #define DPRINTF(fmt, ...)
>  #endif
>
> -#define E820_NR_ENTRIES                16
> -
> -struct e820_entry {
> -    uint64_t address;
> -    uint64_t length;
> -    uint32_t type;
> -} QEMU_PACKED __attribute((__aligned__(4)));
> -
> -struct e820_table {
> -    uint32_t count;
> -    struct e820_entry entry[E820_NR_ENTRIES];
> -} QEMU_PACKED __attribute((__aligned__(4)));
> -
> -static struct e820_table e820_reserve;
> -static struct e820_entry *e820_table;
> -static size_t e820_entries;
>  struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
>
>  /* Physical Address of PVH entry point read from kernel ELF NOTE */
> @@ -868,53 +853,6 @@ static void handle_a20_line_change(void *opaque, int
> irq, int level)
>      x86_cpu_set_a20(cpu, level);
>  }
>
> -ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)
> -{
> -    unsigned int index =3D le32_to_cpu(e820_reserve.count);
> -    uint32_t utype =3D (uint32_t)type;
> -    struct e820_entry *entry;
> -
> -    if (type !=3D E820_RAM) {
> -        /* old FW_CFG_E820_TABLE entry -- reservations only */
> -        if (index >=3D E820_NR_ENTRIES) {
> -            return -EBUSY;
> -        }
> -        entry =3D &e820_reserve.entry[index++];
> -
> -        entry->address =3D cpu_to_le64(address);
> -        entry->length =3D cpu_to_le64(length);
> -        entry->type =3D cpu_to_le32(utype);
> -
> -        e820_reserve.count =3D cpu_to_le32(index);
> -    }
> -
> -    /* new "etc/e820" file -- include ram too */
> -    e820_table =3D g_renew(struct e820_entry, e820_table, e820_entries +=
 1);
> -    e820_table[e820_entries].address =3D cpu_to_le64(address);
> -    e820_table[e820_entries].length =3D cpu_to_le64(length);
> -    e820_table[e820_entries].type =3D cpu_to_le32(utype);
> -    e820_entries++;
> -
> -    return e820_entries;
> -}
> -
> -size_t e820_get_num_entries(void)
> -{
> -    return e820_entries;
> -}
> -
> -bool e820_get_entry(unsigned int idx, E820Type type,
> -                    uint64_t *address, uint64_t *length)
> -{
> -    uint32_t utype =3D (uint32_t)type;
> -    if (idx < e820_entries && e820_table[idx].type =3D=3D cpu_to_le32(ut=
ype))
> {
> -        *address =3D le64_to_cpu(e820_table[idx].address);
> -        *length =3D le64_to_cpu(e820_table[idx].length);
> -        return true;
> -    }
> -    return false;
> -}
> -
>  /* Enables contiguous-apic-ID mode, for compatibility */
>  static bool compat_apic_id_mode;
>
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 95bf3278f2..0f1bf667ae 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -282,54 +282,6 @@ void pc_system_firmware_init(PCMachineState *pcms,
> MemoryRegion *rom_memory);
>  void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
>                         const CPUArchIdList *apic_ids, GArray *entry);
>
> -/**
> - * E820Type: Type of the e820 address range.
> - */
> -typedef enum {
> -    E820_RAM        =3D 1,
> -    E820_RESERVED   =3D 2,
> -    E820_ACPI       =3D 3,
> -    E820_NVS        =3D 4,
> -    E820_UNUSABLE   =3D 5
> -} E820Type;
> -
> -/**
> - * e820_add_entry: Add an #e820_entry to the @e820_table.
> - *
> - * Returns the number of entries of the e820_table on success,
> - *         or a negative errno otherwise.
> - *
> - * @address: The base address of the structure which the BIOS is to fill
> in.
> - * @length: The length in bytes of the structure passed to the BIOS.
> - * @type: The #E820Type of the address range.
> - */
> -ssize_t e820_add_entry(uint64_t address, uint64_t length, E820Type type)=
;
> -
> -/**
> - * e820_get_num_entries: The number of entries of the @e820_table.
> - *
> - * Returns the number of entries of the e820_table.
> - */
> -size_t e820_get_num_entries(void);
> -
> -/**
> - * e820_get_entry: Get the address/length of an #e820_entry.
> - *
> - * If the #e820_entry stored at @index is of #E820Type @type, fills
> @address
> - * and @length with the #e820_entry values and return @true.
> - * Return @false otherwise.
> - *
> - * @index: The index of the #e820_entry to get values.
> - * @type: The @E820Type of the address range expected.
> - * @address: Pointer to the base address of the #e820_entry structure to
> - *           be filled.
> - * @length: Pointer to the length (in bytes) of the #e820_entry structur=
e
> - *          to be filled.
> - * @return: true if the entry was found, false otherwise.
> - */
> -bool e820_get_entry(unsigned int index, E820Type type,
> -                    uint64_t *address, uint64_t *length);
> -
>  extern GlobalProperty pc_compat_4_0[];
>  extern const size_t pc_compat_4_0_len;
>
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 3b29ce5c0d..dbf890005e 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -39,6 +39,7 @@
>  #include "hw/i386/apic-msidef.h"
>  #include "hw/i386/intel_iommu.h"
>  #include "hw/i386/x86-iommu.h"
> +#include "hw/i386/e820_memory_layout.h"
>
>  #include "hw/pci/pci.h"
>  #include "hw/pci/msi.h"
> --
> 2.20.1
>
>
