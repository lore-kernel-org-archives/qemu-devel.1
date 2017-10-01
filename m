Received: from eggs.gnu.org ([2001:4830:134:3::10]:46961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTP7-0002lY-2p
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTP6-0002Ba-8f
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:50:49 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:37693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTP6-0002B9-5I
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:50:48 -0400
Received: by mail-qk0-x244.google.com with SMTP id z143so1980926qkb.4
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 18:50:47 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<5ff4b0fa8802bc338be8bb87274444d69f4eb2ba.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b003f936-e378-f14e-8741-6fc153c11d5a@amsat.org>
Date: Sat, 30 Sep 2017 22:50:44 -0300
MIME-Version: 1.0
In-Reply-To: <5ff4b0fa8802bc338be8bb87274444d69f4eb2ba.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 19/47] hw/ipmi: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com
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
> ---
> V2:
>   - Split hw patch into individual directories
> 
>   hw/ipmi/ipmi.c            | 1 +
>   hw/ipmi/ipmi_bmc_extern.c | 5 +++--
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
> index b27babd504..81c62920de 100644
> --- a/hw/ipmi/ipmi.c
> +++ b/hw/ipmi/ipmi.c
> @@ -23,6 +23,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"

Why?

>   #include "hw/hw.h"
>   #include "hw/ipmi/ipmi.h"
>   #include "sysemu/sysemu.h"
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index abab3bba4f..8c0535d3dd 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -28,6 +28,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "qemu/timer.h"
>   #include "chardev/char-fe.h"
> @@ -194,8 +195,8 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
>   
>       if (ibe->outlen) {
>           /* We already have a command queued.  Shouldn't ever happen. */
> -        fprintf(stderr, "IPMI KCS: Got command when not finished with the"
> -                " previous command\n");
> +        error_report("IPMI KCS: Got command when not finished with the"
> +                     " previous command");
>           abort();
>       }
>   

For ipmi_bmc_extern.c:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
