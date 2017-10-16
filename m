Received: from eggs.gnu.org ([2001:4830:134:3::10]:54768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e43qM-0007D5-IZ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e43qI-00028r-7D
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:46:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e43qH-00028X-UK
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:45:58 -0400
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<2fde01067057065518587b4e2b0208e18235de55.1506730372.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2d05f0f7-97ab-e294-e808-6e125faf0afb@redhat.com>
Date: Mon, 16 Oct 2017 13:45:53 +0200
MIME-Version: 1.0
In-Reply-To: <2fde01067057065518587b4e2b0208e18235de55.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 21/47] hw/lm32: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Michael Walle <michael@walle.cc>, armbru@redhat.com

On 30.09.2017 02:16, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Michael Walle <michael@walle.cc>
> ---
> V2:
>  - Split hw patch into individual directories
> 
>  hw/lm32/lm32_boards.c | 5 +++--
>  hw/lm32/milkymist.c   | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
> index b0bb3ef58a..d739acf476 100644
> --- a/hw/lm32/lm32_boards.c
> +++ b/hw/lm32/lm32_boards.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/sysbus.h"
> @@ -152,7 +153,7 @@ static void lm32_evr_init(MachineState *machine)
>          }
>  
>          if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                      kernel_filename);
>              exit(1);
>          }
> @@ -250,7 +251,7 @@ static void lm32_uclinux_init(MachineState *machine)
>          }
>  
>          if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                      kernel_filename);
>              exit(1);
>          }
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 4db4d2d533..caa6cf4e0f 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/sysbus.h"
> @@ -149,7 +150,7 @@ milkymist_init(MachineState *machine)
>  
>      /* if no kernel is given no valid bios rom is a fatal error */
>      if (!kernel_filename && !dinfo && !bios_filename && !qtest_enabled()) {
> -        fprintf(stderr, "qemu: could not load Milkymist One bios '%s'\n",
> +        error_report("qemu: could not load Milkymist One bios '%s'",
>                  bios_name);
>          exit(1);
>      }
> @@ -188,7 +189,7 @@ milkymist_init(MachineState *machine)
>          }
>  
>          if (kernel_size < 0) {
> -            fprintf(stderr, "qemu: could not load kernel '%s'\n",
> +            error_report("qemu: could not load kernel '%s'",
>                      kernel_filename);
>              exit(1);
>          }
> 

Please remove the "qemu:" prefixes here, too.

 Thomas
