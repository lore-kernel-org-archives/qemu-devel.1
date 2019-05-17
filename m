Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF90C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1B872133D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmpjZ4rA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B872133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRlVo-0000Na-UU
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:39:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hRlUz-0008TF-7U
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hRlUx-0006yB-Kk
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:38:45 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hRlUx-0006ur-B0; Fri, 17 May 2019 18:38:43 -0400
Received: by mail-lj1-x242.google.com with SMTP id e13so7574686ljl.11;
	Fri, 17 May 2019 15:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=x47A39VYZOP+woky4Q+6cPjRDZfu7U8RSR2tnt5LzTQ=;
	b=XmpjZ4rAprbU8vCt1Pa54gKmcOel9oN/o9ByUym0NQwRuACmpv1IrcH8rlVovyRm0y
	QUQG9u3ziVj3H9tJmGJMtmQgfwQUdHNPdu8eFInnluFxOvyulvl6kX1jRtKMF1WQ5Dw+
	Igvh70yZH56zpyQpe9qpgKcYu0Uy2f0umsEyxr8loizJ9Ut7tC7r+id3YXQUEkPYwbEl
	SHnUrSRFsXU1T83M//VrR8e39EbjxC/IntS4MElaUYDGNAYlimQHv1qQDMZ9IHcmDQ2X
	BdQvkjsY5SVSK7IQiAMnxWyntEL+wEbvYjJZicgDn7y4KcsH3x2B14OljficbGZhmjHY
	613Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=x47A39VYZOP+woky4Q+6cPjRDZfu7U8RSR2tnt5LzTQ=;
	b=tyoJAJ9OktK6iOFlivvJlYpmiGXfleXD0kE5TqHyqZVYgKaiQQoprtWCJunluX3wqT
	KZJN9lZqwy1+RaRLayZIsDBqTxMpZtFxEQza8yZWazJtcu4HU/d2IZfqifqZSPlfvRWX
	fstVqTyNyhvdytkMO3yCZYXua1uM+53mzDqn+3QwCg9Ufx1vfPNZdBhFmZAeYqV2H9TM
	dbkPIQPO96wOWNushHDEWdMHly292uw+g8qt9DCH3U3PB7uDnpWVBc/XFC36esyI+H+s
	Crm4imJPBGYGxxUpTOhWH9DOkKURAUgG1hDfzYKfGtKjTM7GMHtYoRH6d+k8QJXjWUMo
	ntCQ==
X-Gm-Message-State: APjAAAUMZYNZ5+g/cfWkdOcLT+EKVM+p+okc6bE0sf8GZpTkv3m6/AFB
	Eh1keRC/gETp5yLz9BkgfSHHMZ61bCuWR9WzwzY=
X-Google-Smtp-Source: APXvYqxomiiqbdka5P0sOBDjfejaNdt16P7EZGFuiEF1SDYqAxE4VPgQguLZgi+4ZNEnGgdOHIv/WcCMgATu3JqvB0U=
X-Received: by 2002:a2e:8909:: with SMTP id d9mr24382247lji.93.1558132721301; 
	Fri, 17 May 2019 15:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190517222342.26394-1-jonathan@fintelia.io>
	<20190517222342.26394-3-jonathan@fintelia.io>
In-Reply-To: <20190517222342.26394-3-jonathan@fintelia.io>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 May 2019 15:36:28 -0700
Message-ID: <CAKmqyKMG6ffhQ5VYgLZ3XVfZ2-E_O9BH6UCanmLJ3awDDUfS_w@mail.gmail.com>
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] target/riscv: Add support for
 -bios "firmware_filename" flag
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Jonathan Behrens <fintelia@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 17, 2019 at 3:25 PM Jonathan Behrens <jonathan@fintelia.io> wrote:
>
> QEMU does not have any default firmware for RISC-V. However, it isn't possible
> to run a normal kernel binary without firmware. Thus it has previously been
> necessary to compile the two together into a single binary to pass with the
> -kernel flag. This patch allows passing separate firmware and kernel binaries by
> passing both the -bios and -kernel flags.

I've never been fully convinced of this, why not just use the generic loader?

This does match other architectures though so it's fine to go in. I
think you will also get better in_asm output with this as well, which
is something the loader doesn't give you.

>
> This is based on a previously proposed patch by Michael Clark:
> https://patchwork.kernel.org/patch/10419975/
>
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
> ---
>  hw/riscv/virt.c | 66 ++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 55 insertions(+), 11 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 87cc08016b..d7b1792b58 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -62,6 +62,40 @@ static const struct MemmapEntry {
>      [VIRT_PCIE_ECAM] =   { 0x30000000,    0x10000000 },
>  };
>
> +
> +static target_ulong load_firmware_and_kernel(const char *firmware_filename,
> +                                             const char *kernel_filename,
> +                                             uint64_t mem_size,
> +                                             uint64_t* kernel_start,
> +                                             uint64_t* kernel_end)
> +{
> +    uint64_t firmware_entry, firmware_end;
> +    int size;
> +
> +    if (load_elf(firmware_filename, NULL, NULL, NULL,
> +                 &firmware_entry, NULL, &firmware_end,
> +                 0, EM_RISCV, 1, 0) < 0) {
> +        error_report("could not load firmware '%s'", firmware_filename);
> +        exit(1);
> +    }
> +
> +    /* align kernel load address to the megapage after the firmware */
> +#if defined(TARGET_RISCV32)
> +    *kernel_start = (firmware_end + 0x3fffff) & ~0x3fffff;
> +#else
> +    *kernel_start = (firmware_end + 0x1fffff) & ~0x1fffff;
> +#endif
> +
> +    size = load_image_targphys(kernel_filename, *kernel_start,
> +                               mem_size - *kernel_start);
> +    if (size == -1) {
> +        error_report("could not load kernel '%s'", kernel_filename);
> +        exit(1);
> +    }
> +    *kernel_end = *kernel_start + size;
> +    return firmware_entry;
> +}

This should be in a generic boot.c file and support added to all RISC-V boards.

Alistair

> +
>  static target_ulong load_kernel(const char *kernel_filename)
>  {
>      uint64_t kernel_entry;
> @@ -423,19 +457,29 @@ static void riscv_virt_board_init(MachineState *machine)
>                                  mask_rom);
>
>      uint64_t entry = memmap[VIRT_DRAM].base;
> -    if (machine->kernel_filename) {
> +    if (machine->firmware && machine->kernel_filename) {
> +        uint64_t kernel_start, kernel_end;
> +        entry = load_firmware_and_kernel(machine->firmware,
> +                                         machine->kernel_filename,
> +                                         machine->ram_size, &kernel_start,
> +                                         &kernel_end);
> +
> +        qemu_fdt_setprop_cells(fdt, "/chosen", "riscv,kernel-end",
> +                               kernel_end >> 32, kernel_end);
> +        qemu_fdt_setprop_cells(fdt, "/chosen", "riscv,kernel-start",
> +                               kernel_start >> 32, kernel_start);
> +    } else if (machine->kernel_filename) {
>          entry = load_kernel(machine->kernel_filename);
> +    }
>
> -        if (machine->initrd_filename) {
> -            uint64_t start;
> -            uint64_t end = load_initrd(machine->initrd_filename,
> -                                       memmap[VIRT_DRAM].base, machine->ram_size,
> -                                       &start);
> -            qemu_fdt_setprop_cell(fdt, "/chosen",
> -                                  "linux,initrd-start", start);
> -            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
> -                                  end);
> -        }
> +    if (machine->kernel_filename && machine->initrd_filename) {
> +        uint64_t start;
> +        uint64_t end = load_initrd(machine->initrd_filename,
> +                                   memmap[VIRT_DRAM].base, machine->ram_size,
> +                                   &start);
> +
> +        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start", start);
> +        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end", end);
>      }
>
>      /* reset vector */
> --
> 2.20.1
>

