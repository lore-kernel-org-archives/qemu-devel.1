Received: from eggs.gnu.org ([2001:4830:134:3::10]:57458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e440t-0003d6-KZ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e440p-0007Jg-L8
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:56:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e440p-0007J5-Cn
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:56:51 -0400
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<5496a72654fb5c27793708e470ece06fe15ab423.1506730372.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <32b63322-3a95-d677-91e2-91cde82cd9a4@redhat.com>
Date: Mon, 16 Oct 2017 13:56:47 +0200
MIME-Version: 1.0
In-Reply-To: <5496a72654fb5c27793708e470ece06fe15ab423.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 36/47] hw/sh4: Replace fprintf(stderr,
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
Cc: alistair23@gmail.com, Magnus Damm <magnus.damm@gmail.com>, armbru@redhat.com, Aurelien Jarno <aurelien@aurel32.net>

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
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
> V2:
>  - Split hw patch into individual directories
> 
>  hw/sh4/r2d.c    |  9 ++++----
>  hw/sh4/sh7750.c | 64 +++++++++++++++++++++++++++++----------------------------
>  2 files changed, 38 insertions(+), 35 deletions(-)
> 
> diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
> index 16b9ed2db2..a010f559e2 100644
> --- a/hw/sh4/r2d.c
> +++ b/hw/sh4/r2d.c
> @@ -24,6 +24,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
> @@ -319,8 +320,8 @@ static void r2d_init(MachineState *machine)
>                                            SDRAM_BASE + LINUX_LOAD_OFFSET,
>                                            INITRD_LOAD_OFFSET - LINUX_LOAD_OFFSET);
>          if (kernel_size < 0) {
> -          fprintf(stderr, "qemu: could not load kernel '%s'\n", kernel_filename);
> -          exit(1);
> +            error_report("qemu: could not load kernel '%s'", kernel_filename);
> +            exit(1);
>          }
>  
>          /* initialization which should be done by firmware */
> @@ -339,8 +340,8 @@ static void r2d_init(MachineState *machine)
>                                            SDRAM_SIZE - INITRD_LOAD_OFFSET);
>  
>          if (initrd_size < 0) {
> -          fprintf(stderr, "qemu: could not load initrd '%s'\n", initrd_filename);
> -          exit(1);
> +            error_report("qemu: could not load initrd '%s'", initrd_filename);
> +            exit(1);
>          }

Please remove the "qemu:" prefix here as well.

 Thomas
