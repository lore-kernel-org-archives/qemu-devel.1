Received: from eggs.gnu.org ([2001:4830:134:3::10]:44015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTMn-00013G-O0
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTMk-0007Hu-V9
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:48:25 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTMk-0007Hb-Q5
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:48:22 -0400
Received: by mail-qk0-x241.google.com with SMTP id w63so398423qkd.2
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 18:48:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<2fde01067057065518587b4e2b0208e18235de55.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <de0f1046-ffa9-5ad4-d704-e6f1dc40d473@amsat.org>
Date: Sat, 30 Sep 2017 22:48:18 -0300
MIME-Version: 1.0
In-Reply-To: <2fde01067057065518587b4e2b0208e18235de55.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 21/47] hw/lm32: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Michael Walle <michael@walle.cc>, armbru@redhat.com
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

> Cc: Michael Walle <michael@walle.cc>
> ---
> V2:
>   - Split hw patch into individual directories
> 
>   hw/lm32/lm32_boards.c | 5 +++--
>   hw/lm32/milkymist.c   | 5 +++--
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
> index b0bb3ef58a..d739acf476 100644
> --- a/hw/lm32/lm32_boards.c
> +++ b/hw/lm32/lm32_boards.c
> @@ -18,6 +18,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qemu-common.h"
>   #include "cpu.h"
>   #include "hw/sysbus.h"
> @@ -152,7 +153,7 @@ static void lm32_evr_init(MachineState *machine)
>           }
>   
>           if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                       kernel_filename);
>               exit(1);
>           }
> @@ -250,7 +251,7 @@ static void lm32_uclinux_init(MachineState *machine)
>           }
>   
>           if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                       kernel_filename);
>               exit(1);
>           }
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 4db4d2d533..caa6cf4e0f 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -18,6 +18,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qemu-common.h"
>   #include "cpu.h"
>   #include "hw/sysbus.h"
> @@ -149,7 +150,7 @@ milkymist_init(MachineState *machine)
>   
>       /* if no kernel is given no valid bios rom is a fatal error */
>       if (!kernel_filename && !dinfo && !bios_filename && !qtest_enabled()) {
> -        fprintf(stderr, "qemu: could not load Milkymist One bios '%s'\n",
> +        error_report("qemu: could not load Milkymist One bios '%s'",
>                   bios_name);
>           exit(1);
>       }
> @@ -188,7 +189,7 @@ milkymist_init(MachineState *machine)
>           }
>   
>           if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                       kernel_filename);
>               exit(1);
>           }
> 
