Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB307C74A36
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 01:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A7921019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 01:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVHjhm1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A7921019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlNY2-0003Jk-Lm
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 21:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60635)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1hlNWk-0001zx-Is
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1hlNWi-0004EE-Gu
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 21:05:38 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1hlNWi-0004CP-2q; Wed, 10 Jul 2019 21:05:36 -0400
Received: by mail-pf1-x442.google.com with SMTP id b13so1916055pfo.1;
 Wed, 10 Jul 2019 18:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=f80XBbJbHcN6kgaVExKX7kRvX3YoR341wi6elwvIkDk=;
 b=NVHjhm1kEwjaklWIEHTHzJ1cYPFVqf8VqfzFo4t4xQ+H/XWt3E9ZdcidHr5C/L8YiH
 MuDBjGwR2WLLtgyXF4DD1C30vN8+Nfh0JlNgZBWkpa3HthiSBYFm7eZSLeA53PmRE9yF
 EOzGaIm3nZ2h+SnuBhmd6fPSlqxP5SKkFX9Sl1YlV/PI2CQGG+DwWEFZP+EXaPKwxTYQ
 2KLoB3W9jUwCL1dLGZBTu2hPyN+QZF6OkS8Vunh7oDzeOX/KbZjVc8CPYT/CRK+AWFwM
 YL8GHehtZWhXnjg7nl9ste3ytTn1HTUIUdD2CYa6ghTCASrQ2cjB8GcrBa+QDoXPV80d
 ULGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=f80XBbJbHcN6kgaVExKX7kRvX3YoR341wi6elwvIkDk=;
 b=dYOuDOukYr8Ez+ObTmIRxlX02B2e+MgWvE9pFZGixX1gyLTJspa5oW2kvf97NdwoHl
 EDQUErHptVErXXyZUZlluSleJ9ngrYNhInlSU9X5DLiHl2WZ5tiAPYo4e+h45TmmEewe
 UI0U4ptHnEKf+94TkxZFqShfMpg32O69ebWBcIicXCsjP96Unfsz4mDK5NVCjDMV1uZ2
 hq8eybolrz3zJilgD2LT+bAfHIRSJqL9T+PhoqocCSZMHQlElCuRPvz3VSetVg702bfX
 zmEPzYkNvLttBPodxOh6/Ir/3aj3e2q8bcOXgoZ+nDwU2HoOIFRtjDZ7Bms8VdQgC6pt
 kKOw==
X-Gm-Message-State: APjAAAWXNDd2Lx+vg3/ahQ8cSZkVtqHWS36yHCtg0Qa6lJ3qoW4NuTlB
 /+I+R2CeeT+9Zb2JVFDlgC8=
X-Google-Smtp-Source: APXvYqwGyWZ3CH7L4VJxYZgI5MFPf14cAOisKoCyJ31QimswpzEMdDKTMMmSEN/AMSA9hXtkzAbQRg==
X-Received: by 2002:a17:90a:3ac2:: with SMTP id
 b60mr1529442pjc.74.1562807134655; 
 Wed, 10 Jul 2019 18:05:34 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id c98sm3216443pje.1.2019.07.10.18.05.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 18:05:34 -0700 (PDT)
Date: Wed, 10 Jul 2019 18:05:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20190711010533.GC707@roeck-us.net>
References: <cover.1562803960.git.alistair.francis@wdc.com>
 <781401554624dc368c438ef7e077f9d92440fb3a.1562803960.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <781401554624dc368c438ef7e077f9d92440fb3a.1562803960.git.alistair.francis@wdc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/riscv: Load OpenSBI as the
 default firmware
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
Cc: peter.maydell@linaro.org, qemu-riscv@nongnu.org, codyprime@gmail.com,
 anup@brainfault.org, palmer@sifive.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, pbonzini@redhat.com, alistair23@gmail.com,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 10, 2019 at 05:14:07PM -0700, Alistair Francis wrote:
> If the user hasn't specified a firmware to load (with -bios) or
> specified no bios (with -bios none) then load OpenSBI by default. This
> allows users to boot a RISC-V kernel with just -kernel.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> Tested-by: Bin Meng <bmeng.cn@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  hw/riscv/boot.c         | 54 +++++++++++++++++++++++++++++++++++++++++
>  hw/riscv/sifive_u.c     |  7 +++---
>  hw/riscv/virt.c         | 11 ++++++---
>  include/hw/riscv/boot.h |  3 +++
>  qemu-deprecated.texi    | 20 +++++++++++++++
>  5 files changed, 89 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index ff023f42d0..5dee63011b 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu-common.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"
>  #include "exec/cpu-defs.h"
> @@ -32,6 +33,59 @@
>  # define KERNEL_BOOT_ADDRESS 0x80200000
>  #endif
>  
> +void riscv_find_and_load_firmware(MachineState *machine,
> +                                  const char *default_machine_firmware,
> +                                  hwaddr firmware_load_addr)
> +{
> +    char *firmware_filename;
> +
> +    if (!machine->firmware) {
> +        /*
> +         * The user didn't specify -bios.
> +         * At the moment we default to loading nothing when this hapens.
> +         * In the future this defaul will change to loading the prebuilt
> +         * OpenSBI firmware. Let's warn the user and then continue.
> +        */
> +        warn_report("No -bios option specified. Not loading a firmware.");
> +        warn_report("This default will change in QEMU 4.3. Please use the " \
> +                    "-bios option to aviod breakages when this happens.");
> +        warn_report("See QEMU's deprecation documentation for details");
> +        return;
> +    }
> +
> +    if (!strcmp(machine->firmware, "default")) {
> +        /*
> +         * The user has specified "-bios default". That means we are going to
> +         * load the OpenSBI binary included in the QEMU source.
> +         *
> +         * We can't load the binary by default as it will break existing users
> +         * as users are already loading their own firmware.
> +         *
> +         * Let's try to get everyone to specify the -bios option at all times,
> +         * so then in the future we can make "-bios default" the default option
> +         * if no -bios option is set without breaking anything.
> +         */
> +        firmware_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
> +                                           default_machine_firmware);
> +        if (firmware_filename == NULL) {
> +            error_report("Unable to load the default RISC-V firmware \"%s\"",
> +                         default_machine_firmware);
> +            exit(1);
> +        }
> +    } else {
> +        firmware_filename = machine->firmware;
> +    }
> +
> +    if (strcmp(firmware_filename, "none")) {
> +        /* If not "none" load the firmware */
> +        riscv_load_firmware(firmware_filename, firmware_load_addr);
> +    }
> +
> +    if (!strcmp(machine->firmware, "default")) {
> +        g_free(firmware_filename);
> +    }
> +}
> +
>  target_ulong riscv_load_firmware(const char *firmware_filename,
>                                   hwaddr firmware_load_addr)
>  {
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index ca53a9290d..71b8083c05 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -49,6 +49,8 @@
>  
>  #include <libfdt.h>
>  
> +#define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
> +
>  static const struct MemmapEntry {
>      hwaddr base;
>      hwaddr size;
> @@ -269,9 +271,8 @@ static void riscv_sifive_u_init(MachineState *machine)
>      /* create device tree */
>      create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
>  
> -    if (machine->firmware) {
> -        riscv_load_firmware(machine->firmware, memmap[SIFIVE_U_DRAM].base);
> -    }
> +    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> +                                 memmap[SIFIVE_U_DRAM].base);
>  
>      if (machine->kernel_filename) {
>          riscv_load_kernel(machine->kernel_filename);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ecdc77d728..25faf3b417 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -44,6 +44,12 @@
>  
>  #include <libfdt.h>
>  
> +#if defined(TARGET_RISCV32)
> +# define BIOS_FILENAME "opensbi-riscv32-virt-fw_jump.bin"
> +#else
> +# define BIOS_FILENAME "opensbi-riscv64-virt-fw_jump.bin"
> +#endif
> +
>  static const struct MemmapEntry {
>      hwaddr base;
>      hwaddr size;
> @@ -399,9 +405,8 @@ static void riscv_virt_board_init(MachineState *machine)
>      memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
>                                  mask_rom);
>  
> -    if (machine->firmware) {
> -        riscv_load_firmware(machine->firmware, memmap[VIRT_DRAM].base);
> -    }
> +    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> +                                 memmap[VIRT_DRAM].base);
>  
>      if (machine->kernel_filename) {
>          uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index daa179b600..d56f2ae3eb 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -20,6 +20,9 @@
>  #ifndef RISCV_BOOT_H
>  #define RISCV_BOOT_H
>  
> +void riscv_find_and_load_firmware(MachineState *machine,
> +                                  const char *default_machine_firmware,
> +                                  hwaddr firmware_load_addr);
>  target_ulong riscv_load_firmware(const char *firmware_filename,
>                                   hwaddr firmware_load_addr);
>  target_ulong riscv_load_kernel(const char *kernel_filename);
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index c90b08d553..fff07bb2a3 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -121,6 +121,26 @@ the backing storage specified with @option{-mem-path} can actually provide
>  the guest RAM configured with @option{-m} and QEMU will fail to start up if
>  RAM allocation is unsuccessful.
>  
> +@subsection RISC-V -bios (since 4.1)
> +
> +QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for the
> +RISC-V virt machine and sifive_u machine.
> +
> +QEMU 4.1 has no changes to the default behaviour to avoid breakages. This
> +default will change in a future QEMU release, so please prepare now. All users
> +of the virt or sifive_u machine must change their command line usage.
> +
> +QEMU 4.1 has three options, please migrate to one of these three:
> + 1. ``-bios none`` - This is the current default behavior if no -bios option
> +      is included. QEMU will not automatically load any firmware. It is up
> +      to the user to load all the images they need.
> + 2. ``-bios default`` - In a future QEMU release this will become the default
> +      behaviour if no -bios option is specified. This option will load the
> +      default OpenSBI firmware automatically. The firmware is included with
> +      the QEMU release and no user interaction is required. All a user needs
> +      to do is specify the kernel they want to boot with the -kernel option
> + 3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmwrae.
> +
>  @section QEMU Machine Protocol (QMP) commands
>  
>  @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
> -- 
> 2.22.0
> 

