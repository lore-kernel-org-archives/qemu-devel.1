Received: from eggs.gnu.org ([209.51.188.92]:34072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDRtt-0003zT-7V
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDRts-00087B-6A
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:53:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDRtr-00086e-TJ
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 06:53:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so15802694wrd.3
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 03:53:15 -0700 (PDT)
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-6-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8adaa89a-9e0d-a5ab-36c9-ea60d056885e@redhat.com>
Date: Mon, 8 Apr 2019 12:53:13 +0200
MIME-Version: 1.0
In-Reply-To: <20190408083627.7479-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/15] mips/boston: Report errors with
 error_report(), not error_printf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

On 4/8/19 10:36 AM, Markus Armbruster wrote:
> Cc: Paul Burton <pburton@wavecomp.com>
> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/mips/boston.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index e5bab3cadc..a8b29f62f5 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -528,21 +528,21 @@ static void boston_mach_init(MachineState *machine)
>          fw_size = load_image_targphys(machine->firmware,
>                                        0x1fc00000, 4 * MiB);
>          if (fw_size == -1) {
> -            error_printf("unable to load firmware image '%s'\n",
> +            error_report("unable to load firmware image '%s'",
>                            machine->firmware);
>              exit(1);
>          }
>      } else if (machine->kernel_filename) {
>          fit_err = load_fit(&boston_fit_loader, machine->kernel_filename, s);
>          if (fit_err) {
> -            error_printf("unable to load FIT image\n");
> +            error_report("unable to load FIT image");
>              exit(1);
>          }
>  
>          gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000,
>                       s->kernel_entry, s->fdt_base, is_64b);
>      } else if (!qtest_enabled()) {
> -        error_printf("Please provide either a -kernel or -bios argument\n");
> +        error_report("Please provide either a -kernel or -bios argument");
>          exit(1);
>      }
>  }
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
