Received: from eggs.gnu.org ([2001:4830:134:3::10]:39338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dyN4o-0000eW-1W
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 15:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1dyN4j-0004l4-It
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 15:05:25 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1dyN4j-0004jr-AC
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 15:05:21 -0400
Received: by mail-pf0-x244.google.com with SMTP id i23so1845661pfi.2
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 12:05:20 -0700 (PDT)
Date: Sun, 1 Oct 2017 04:05:15 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170930190515.GD2609@lianli.shorne-pla.net>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<9056bbcdb0d8fe7f0dbb1a050cacacb0ed508204.1506730372.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9056bbcdb0d8fe7f0dbb1a050cacacb0ed508204.1506730372.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v2 30/47] hw/openrisc: Replace
 fprintf(stderr, "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, Jia Liu <proljc@gmail.com>
List-ID: <qemu-devel.nongnu.org>

Hi Alistair,

On Fri, Sep 29, 2017 at 05:16:30PM -0700, Alistair Francis wrote:
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
> Cc: Jia Liu <proljc@gmail.com>
> Cc: Stafford Horne <shorne@gmail.com>
> ---
> V2:
>  - Split hw patch into individual directories
> 
>  hw/openrisc/openrisc_sim.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index 86bf2849c4..44a6d115dd 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -19,6 +19,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
> @@ -87,7 +88,7 @@ static void cpu_openrisc_load_kernel(ram_addr_t ram_size,
>          }
>  
>          if (kernel_size < 0) {
> -            fprintf(stderr, "QEMU: couldn't load the kernel '%s'\n",
> +            error_report("QEMU: couldn't load the kernel '%s'",
>                      kernel_filename);
>              exit(1);
>          }

Acked-by: Stafford Horne <shorne@gmail.com>
