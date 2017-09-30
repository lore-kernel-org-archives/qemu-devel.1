Received: from eggs.gnu.org ([2001:4830:134:3::10]:53535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7eD-0001Em-By
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7eA-0000Jf-6M
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:36:57 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:35151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7e9-0000JE-W6
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:36:54 -0400
Received: by mail-io0-x241.google.com with SMTP id d16so690539ioj.2
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 19:36:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<cb22f944e30ac70b6c6659e7ea7554f49d58b058.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3820402d-51e2-05d3-378b-f3cac097fcd3@amsat.org>
Date: Fri, 29 Sep 2017 23:36:52 -0300
MIME-Version: 1.0
In-Reply-To: <cb22f944e30ac70b6c6659e7ea7554f49d58b058.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 24/47] hw/mips: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: Paul Burton <paul.burton@imgtec.com>, armbru@redhat.com, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Yongbok Kim <yongbok.kim@imgtec.com>, alistair23@gmail.com, Aurelien Jarno <aurelien@aurel32.net>
List-ID: <qemu-devel.nongnu.org>

On 09/29/2017 09:16 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: "Hervé Poussineau" <hpoussin@reactos.org>
> ---
> V2:
>   - Split hw patch into individual directories
> 
>   hw/mips/boston.c        | 4 ++--
>   hw/mips/mips_fulong2e.c | 4 ++--
>   hw/mips/mips_jazz.c     | 4 ++--
>   hw/mips/mips_malta.c    | 4 ++--
>   hw/mips/mips_mipssim.c  | 4 ++--
>   hw/mips/mips_r4k.c      | 6 +++---
>   6 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 776ee283e1..ee82968ea7 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -353,7 +353,7 @@ static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
>   
>       err = fdt_open_into(fdt_orig, fdt, fdt_sz);
>       if (err) {
> -        fprintf(stderr, "unable to open FDT\n");
> +        error_report("unable to open FDT");
>           return NULL;
>       }
>   
> @@ -361,7 +361,7 @@ static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
>               ? machine->kernel_cmdline : " ";
>       err = qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
>       if (err < 0) {
> -        fprintf(stderr, "couldn't set /chosen/bootargs\n");
> +        error_report("couldn't set /chosen/bootargs");
>           return NULL;
>       }
>   
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 75318680e1..34710a466c 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -143,7 +143,7 @@ static int64_t load_kernel (CPUMIPSState *env)
>                                        initrd_offset, ram_size - initrd_offset);
>           }
>           if (initrd_size == (target_ulong) -1) {
> -            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n",
> +            error_report("qemu: could not load initial ram disk '%s'",
>                       loaderparams.initrd_filename);
>               exit(1);
>           }
> @@ -342,7 +342,7 @@ static void mips_fulong2e_init(MachineState *machine)
>   
>       isa_bus = vt82c686b_init(pci_bus, PCI_DEVFN(FULONG2E_VIA_SLOT, 0));
>       if (!isa_bus) {
> -        fprintf(stderr, "vt82c686b_init error\n");
> +        error_report("vt82c686b_init error");
>           exit(1);
>       }
>   
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 7e6626dc88..6c91a940be 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -271,10 +271,10 @@ static void mips_jazz_init(MachineState *machine,
>               sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 4));
>               break;
>           } else if (is_help_option(nd->model)) {
> -            fprintf(stderr, "qemu: Supported NICs: dp83932\n");
> +            error_report("qemu: Supported NICs: dp83932");
>               exit(1);
>           } else {
> -            fprintf(stderr, "qemu: Unsupported NIC: %s\n", nd->model);
> +            error_report("qemu: Unsupported NIC: %s", nd->model);
>               exit(1);
>           }
>       }
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 2adb9bcf89..d457adfa69 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -856,8 +856,8 @@ static int64_t load_kernel (void)
>                                                 ram_size - initrd_offset);
>           }
>           if (initrd_size == (target_ulong) -1) {
> -            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n",
> -                    loaderparams.initrd_filename);
> +            error_report("qemu: could not load initial ram disk '%s'",
> +                         loaderparams.initrd_filename);
>               exit(1);
>           }
>       }
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index a092072e2a..a3d9406610 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -101,8 +101,8 @@ static int64_t load_kernel(void)
>                   initrd_offset, loaderparams.ram_size - initrd_offset);
>           }
>           if (initrd_size == (target_ulong) -1) {
> -            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n",
> -                    loaderparams.initrd_filename);
> +            error_report("qemu: could not load initial ram disk '%s'",
> +                         loaderparams.initrd_filename);
>               exit(1);
>           }
>       }
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 1272d4ef9d..e54ce918a7 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -121,8 +121,8 @@ static int64_t load_kernel(void)
>                                                 ram_size - initrd_offset);
>           }
>           if (initrd_size == (target_ulong) -1) {
> -            fprintf(stderr, "qemu: could not load initial ram disk '%s'\n",
> -                    loaderparams.initrd_filename);
> +            error_report("qemu: could not load initial ram disk '%s'",
> +                         loaderparams.initrd_filename);
>               exit(1);
>           }
>       }
> @@ -246,7 +246,7 @@ void mips_r4k_init(MachineState *machine)
>                                      blk_by_legacy_dinfo(dinfo),
>                                      sector_len, mips_rom / sector_len,
>                                      4, 0, 0, 0, 0, be)) {
> -            fprintf(stderr, "qemu: Error registering flash memory.\n");
> +            error_report("qemu: Error registering flash memory.");
>   	}
>       } else if (!qtest_enabled()) {
>           /* not fatal */
> 
