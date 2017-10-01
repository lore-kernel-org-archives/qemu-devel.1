Received: from eggs.gnu.org ([2001:4830:134:3::10]:53248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTUE-0004pB-7F
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTUC-0000kO-Kt
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:56:06 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:50442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTUC-0000jl-G3
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:56:04 -0400
Received: by mail-qt0-x244.google.com with SMTP id f15so3728518qtf.7
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 18:56:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<3fe4e8e663e8b4d76fea0b37a8279de41f541cc5.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fd598b32-576b-9f53-7d49-6a3f3384e42c@amsat.org>
Date: Sat, 30 Sep 2017 22:56:00 -0300
MIME-Version: 1.0
In-Reply-To: <3fe4e8e663e8b4d76fea0b37a8279de41f541cc5.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/47] hw/core: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On 09/29/2017 09:15 PM, Alistair Francis wrote:
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

> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
> V2:
>   - Split hw patch into individual directories
> 
>   hw/core/loader.c | 31 ++++++++++++++++---------------
>   hw/core/ptimer.c |  7 ++++---
>   2 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 4593061445..95bdcbbe36 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -43,6 +43,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "hw/hw.h"
>   #include "disas/disas.h"
> @@ -82,7 +83,7 @@ int load_image(const char *filename, uint8_t *addr)
>           return -1;
>       size = lseek(fd, 0, SEEK_END);
>       if (size == -1) {
> -        fprintf(stderr, "file %-20s: get size error: %s\n",
> +        error_report("file %-20s: get size error: %s",
>                   filename, strerror(errno));
>           close(fd);
>           return -1;
> @@ -623,7 +624,7 @@ static int load_uboot_image(const char *filename, hwaddr *ep, hwaddr *loadaddr,
>           goto out;
>   
>       if (hdr->ih_type != image_type) {
> -        fprintf(stderr, "Wrong image type %d, expected %d\n", hdr->ih_type,
> +        error_report("Wrong image type %d, expected %d", hdr->ih_type,
>                   image_type);
>           goto out;
>       }
> @@ -670,14 +671,14 @@ static int load_uboot_image(const char *filename, hwaddr *ep, hwaddr *loadaddr,
>           address = *loadaddr;
>           break;
>       default:
> -        fprintf(stderr, "Unsupported u-boot image type %d\n", hdr->ih_type);
> +        error_report("Unsupported u-boot image type %d", hdr->ih_type);
>           goto out;
>       }
>   
>       data = g_malloc(hdr->ih_size);
>   
>       if (read(fd, data, hdr->ih_size) != hdr->ih_size) {
> -        fprintf(stderr, "Error reading file\n");
> +        error_report("Error reading file");
>           goto out;
>       }
>   
> @@ -693,7 +694,7 @@ static int load_uboot_image(const char *filename, hwaddr *ep, hwaddr *loadaddr,
>           bytes = gunzip(data, max_bytes, compressed_data, hdr->ih_size);
>           g_free(compressed_data);
>           if (bytes < 0) {
> -            fprintf(stderr, "Unable to decompress gzipped image!\n");
> +            error_report("Unable to decompress gzipped image!");
>               goto out;
>           }
>           hdr->ih_size = bytes;
> @@ -763,7 +764,7 @@ int load_image_gzipped_buffer(const char *filename, uint64_t max_sz,
>       data = g_malloc(max_sz);
>       bytes = gunzip(data, max_sz, compressed_data, len);
>       if (bytes < 0) {
> -        fprintf(stderr, "%s: unable to decompress gzipped kernel file\n",
> +        error_report("%s: unable to decompress gzipped kernel file",
>                   filename);
>           goto out;
>       }
> @@ -893,8 +894,8 @@ int rom_add_file(const char *file, const char *fw_dir,
>       char devpath[100];
>   
>       if (as && mr) {
> -        fprintf(stderr, "Specifying an Address Space and Memory Region is " \
> -                "not valid when loading a rom\n");
> +        error_report("Specifying an Address Space and Memory Region is " \
> +                     "not valid when loading a rom");
>           /* We haven't allocated anything so we don't need any cleanup */
>           return -1;
>       }
> @@ -909,7 +910,7 @@ int rom_add_file(const char *file, const char *fw_dir,
>   
>       fd = open(rom->path, O_RDONLY | O_BINARY);
>       if (fd == -1) {
> -        fprintf(stderr, "Could not open option rom '%s': %s\n",
> +        error_report("Could not open option rom '%s': %s",
>                   rom->path, strerror(errno));
>           goto err;
>       }
> @@ -921,7 +922,7 @@ int rom_add_file(const char *file, const char *fw_dir,
>       rom->addr     = addr;
>       rom->romsize  = lseek(fd, 0, SEEK_END);
>       if (rom->romsize == -1) {
> -        fprintf(stderr, "rom: file %-20s: get size error: %s\n",
> +        error_report("rom: file %-20s: get size error: %s",
>                   rom->name, strerror(errno));
>           goto err;
>       }
> @@ -931,7 +932,7 @@ int rom_add_file(const char *file, const char *fw_dir,
>       lseek(fd, 0, SEEK_SET);
>       rc = read(fd, rom->data, rom->datasize);
>       if (rc != rom->datasize) {
> -        fprintf(stderr, "rom: file %-20s: read error: rc=%d (expected %zd)\n",
> +        error_report("rom: file %-20s: read error: rc=%d (expected %zd)",
>                   rom->name, rc, rom->datasize);
>           goto err;
>       }
> @@ -1105,10 +1106,10 @@ int rom_check_and_register_reset(void)
>               continue;
>           }
>           if ((addr > rom->addr) && (as == rom->as)) {
> -            fprintf(stderr, "rom: requested regions overlap "
> -                    "(rom %s. free=0x" TARGET_FMT_plx
> -                    ", addr=0x" TARGET_FMT_plx ")\n",
> -                    rom->name, addr, rom->addr);
> +            error_report("rom: requested regions overlap "
> +                         "(rom %s. free=0x" TARGET_FMT_plx
> +                         ", addr=0x" TARGET_FMT_plx ")",
> +                         rom->name, addr, rom->addr);
>               return -1;
>           }
>           addr  = rom->addr;
> diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
> index 7221c68a98..514e177de2 100644
> --- a/hw/core/ptimer.c
> +++ b/hw/core/ptimer.c
> @@ -6,6 +6,7 @@
>    * This code is licensed under the GNU LGPL.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "hw/hw.h"
>   #include "qemu/timer.h"
>   #include "hw/ptimer.h"
> @@ -56,7 +57,7 @@ static void ptimer_reload(ptimer_state *s, int delta_adjust)
>   
>       if (s->period == 0) {
>           if (!qtest_enabled()) {
> -            fprintf(stderr, "Timer with period zero, disabling\n");
> +            error_report("Timer with period zero, disabling");
>           }
>           timer_del(s->timer);
>           s->enabled = 0;
> @@ -89,7 +90,7 @@ static void ptimer_reload(ptimer_state *s, int delta_adjust)
>   
>       if (delta == 0) {
>           if (!qtest_enabled()) {
> -            fprintf(stderr, "Timer with delta zero, disabling\n");
> +            error_report("Timer with delta zero, disabling");
>           }
>           timer_del(s->timer);
>           s->enabled = 0;
> @@ -263,7 +264,7 @@ void ptimer_run(ptimer_state *s, int oneshot)
>   
>       if (was_disabled && s->period == 0) {
>           if (!qtest_enabled()) {
> -            fprintf(stderr, "Timer with period zero, disabling\n");
> +            error_report("Timer with period zero, disabling");
>           }
>           return;
>       }
> 
