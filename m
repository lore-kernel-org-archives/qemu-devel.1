Received: from eggs.gnu.org ([2001:4830:134:3::10]:53880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7hO-0002Ru-Ad
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7hN-0003rS-1p
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:40:14 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dy7hM-0003qG-RN
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 22:40:12 -0400
Received: by mail-oi0-x242.google.com with SMTP id n129so595225oia.0
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 19:40:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<4921ec19d0e72aa3dff6eb5c8a93a7f0e9691f60.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f450f237-98be-2423-0bfd-6ff73cca4b02@amsat.org>
Date: Fri, 29 Sep 2017 23:40:11 -0300
MIME-Version: 1.0
In-Reply-To: <4921ec19d0e72aa3dff6eb5c8a93a7f0e9691f60.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 37/47] hw/sparc*: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com, Fabien Chouteau <chouteau@adacore.com>, alistair23@gmail.com, Artyom Tarasenko <atar4qemu@gmail.com>
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

> Cc: Fabien Chouteau <chouteau@adacore.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
> V2:
>   - Split hw patch into individual directories
> 
>   hw/sparc/leon3.c     | 9 +++++----
>   hw/sparc/sun4m.c     | 8 ++++----
>   hw/sparc64/niagara.c | 2 +-
>   hw/sparc64/sun4u.c   | 9 +++++----
>   4 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index ec2816bf94..d434edec92 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -22,6 +22,7 @@
>    * THE SOFTWARE.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "qemu-common.h"
>   #include "cpu.h"
> @@ -172,7 +173,7 @@ static void leon3_generic_hw_init(MachineState *machine)
>       }
>   
>       if (bios_size > prom_size) {
> -        fprintf(stderr, "qemu: could not load prom '%s': file too big\n",
> +        error_report("qemu: could not load prom '%s': file too big",
>                   filename);
>           exit(1);
>       }
> @@ -180,11 +181,11 @@ static void leon3_generic_hw_init(MachineState *machine)
>       if (bios_size > 0) {
>           ret = load_image_targphys(filename, 0x00000000, bios_size);
>           if (ret < 0 || ret > prom_size) {
> -            fprintf(stderr, "qemu: could not load prom '%s'\n", filename);
> +            error_report("qemu: could not load prom '%s'", filename);
>               exit(1);
>           }
>       } else if (kernel_filename == NULL && !qtest_enabled()) {
> -        fprintf(stderr, "Can't read bios image %s\n", filename);
> +        error_report("Can't read bios image %s", filename);
>           exit(1);
>       }
>       g_free(filename);
> @@ -197,7 +198,7 @@ static void leon3_generic_hw_init(MachineState *machine)
>           kernel_size = load_elf(kernel_filename, NULL, NULL, &entry, NULL, NULL,
>                                  1 /* big endian */, EM_SPARC, 0, 0);
>           if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                       kernel_filename);
>               exit(1);
>           }
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index e1bdd4828d..7a2812aaa4 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -261,7 +261,7 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
>                                                 KERNEL_LOAD_ADDR,
>                                                 RAM_size - KERNEL_LOAD_ADDR);
>           if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                       kernel_filename);
>               exit(1);
>           }
> @@ -273,8 +273,8 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
>                                                 INITRD_LOAD_ADDR,
>                                                 RAM_size - INITRD_LOAD_ADDR);
>               if (initrd_size < 0) {
> -                fprintf(stderr, "qemu: could not load initial ram disk '%s'\n",
> -                        initrd_filename);
> +                error_report("qemu: could not load initial ram disk '%s'",
> +                             initrd_filename);
>                   exit(1);
>               }
>           }
> @@ -688,7 +688,7 @@ static void prom_init(hwaddr addr, const char *bios_name)
>           ret = -1;
>       }
>       if (ret < 0 || ret > PROM_SIZE_MAX) {
> -        fprintf(stderr, "qemu: could not load prom '%s'\n", bios_name);
> +        error_report("qemu: could not load prom '%s'", bios_name);
>           exit(1);
>       }
>   }
> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
> index 9a8d6109d4..60799220f3 100644
> --- a/hw/sparc64/niagara.c
> +++ b/hw/sparc64/niagara.c
> @@ -153,7 +153,7 @@ static void niagara_init(MachineState *machine)
>               dinfo->is_default = 1;
>               rom_add_file_fixed(blk_bs(blk)->filename, NIAGARA_VDISK_BASE, -1);
>           } else {
> -            fprintf(stderr, "qemu: could not load ram disk '%s'\n",
> +            error_report("qemu: could not load ram disk '%s'",
>                       blk_bs(blk)->filename);
>               exit(1);
>           }
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index c3280aaf38..070d9b94f9 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -22,6 +22,7 @@
>    * THE SOFTWARE.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "qemu-common.h"
>   #include "cpu.h"
> @@ -165,7 +166,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
>                                                 RAM_size - KERNEL_LOAD_ADDR);
>           }
>           if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                       kernel_filename);
>               exit(1);
>           }
> @@ -178,8 +179,8 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
>                                                  *initrd_addr,
>                                                  RAM_size - *initrd_addr);
>               if ((int)*initrd_size < 0) {
> -                fprintf(stderr, "qemu: could not load initial ram disk '%s'\n",
> -                        initrd_filename);
> +                error_report("qemu: could not load initial ram disk '%s'",
> +                             initrd_filename);
>                   exit(1);
>               }
>           }
> @@ -322,7 +323,7 @@ static void prom_init(hwaddr addr, const char *bios_name)
>           ret = -1;
>       }
>       if (ret < 0 || ret > PROM_SIZE_MAX) {
> -        fprintf(stderr, "qemu: could not load prom '%s'\n", bios_name);
> +        error_report("qemu: could not load prom '%s'", bios_name);
>           exit(1);
>       }
>   }
> 
