Received: from eggs.gnu.org ([2001:4830:134:3::10]:57082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5NqV-00021p-4o
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5NqR-0005KX-WE
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:19:39 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:51451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e5NqR-0005KC-Qs
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 23:19:35 -0400
Received: by mail-qk0-x243.google.com with SMTP id 17so12842784qkq.8
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 20:19:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<bae98934f0a01e7ed6e4b77fc5e8b65ed70344d1.1508390588.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bf6c95fd-ba3e-ad9d-0154-1372eefa5ef8@amsat.org>
Date: Fri, 20 Oct 2017 00:19:21 -0300
MIME-Version: 1.0
In-Reply-To: <bae98934f0a01e7ed6e4b77fc5e8b65ed70344d1.1508390588.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 10/46] hw/cris: Replace fprintf(stderr,
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
Cc: alistair23@gmail.com, armbru@redhat.com

On 10/19/2017 01:16 PM, Alistair Francis wrote:
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
> "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Is this a Reviewed-by tag?

Anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> V2:
>  - Split hw patch into individual directories
> 
>  hw/cris/axis_dev88.c | 3 ++-
>  hw/cris/boot.c       | 6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
> index 5eb552bce2..d121836b69 100644
> --- a/hw/cris/axis_dev88.c
> +++ b/hw/cris/axis_dev88.c
> @@ -23,6 +23,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
> @@ -349,7 +350,7 @@ void axisdev88_init(MachineState *machine)
>          li.cmdline = kernel_cmdline;
>          cris_load_image(cpu, &li);
>      } else if (!qtest_enabled()) {
> -        fprintf(stderr, "Kernel image must be specified\n");
> +        error_report("Kernel image must be specified");
>          exit(1);
>      }
>  }
> diff --git a/hw/cris/boot.c b/hw/cris/boot.c
> index f896ed7f86..fda0a039b8 100644
> --- a/hw/cris/boot.c
> +++ b/hw/cris/boot.c
> @@ -23,6 +23,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/hw.h"
> @@ -86,14 +87,13 @@ void cris_load_image(CRISCPU *cpu, struct cris_load_info *li)
>      }
>  
>      if (image_size < 0) {
> -        fprintf(stderr, "qemu: could not load kernel '%s'\n",
> -                li->image_filename);
> +        error_report("could not load kernel '%s'", li->image_filename);
>          exit(1);
>      }
>  
>      if (li->cmdline && (kcmdline_len = strlen(li->cmdline))) {
>          if (kcmdline_len > 256) {
> -            fprintf(stderr, "Too long CRIS kernel cmdline (max 256)\n");
> +            error_report("Too long CRIS kernel cmdline (max 256)");
>              exit(1);
>          }
>          pstrcpy_targphys("cmdline", 0x40000000, 256, li->cmdline);
> 
