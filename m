Received: from eggs.gnu.org ([2001:4830:134:3::10]:33857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTDL-0005PQ-L9
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTDI-0003oU-3P
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:38:39 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTDH-0003nv-Tv
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:38:36 -0400
Received: by mail-qk0-x243.google.com with SMTP id a128so296374qkc.1
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 18:38:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<81f75ef14938cf64c69be23757a52eb1b585d406.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4ff06509-bb63-f86a-66bb-31a2920df3c0@amsat.org>
Date: Sat, 30 Sep 2017 22:38:31 -0300
MIME-Version: 1.0
In-Reply-To: <81f75ef14938cf64c69be23757a52eb1b585d406.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 38/47] hw/ssi: Replace fprintf(stderr,
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

> ---
> V2:
>   - Split hw patch into individual directories
> 
>   hw/ssi/omap_spi.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ssi/omap_spi.c b/hw/ssi/omap_spi.c
> index 34163e5646..98242d1e8b 100644
> --- a/hw/ssi/omap_spi.c
> +++ b/hw/ssi/omap_spi.c
> @@ -20,6 +20,7 @@
>    * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "hw/hw.h"
>   #include "hw/arm/omap.h"
>   
> @@ -295,9 +296,9 @@ static void omap_mcspi_write(void *opaque, hwaddr addr,
>           if ((value ^ s->ch[ch].config) & (3 << 14))	/* DMAR | DMAW */
>               omap_mcspi_dmarequest_update(s->ch + ch);
>           if (((value >> 12) & 3) == 3)			/* TRM */
> -            fprintf(stderr, "%s: invalid TRM value (3)\n", __func__);
> +            error_report("%s: invalid TRM value (3)", __func__);
>           if (((value >> 7) & 0x1f) < 3)			/* WL */
> -            fprintf(stderr, "%s: invalid WL value (%" PRIx64 ")\n",
> +            error_report("%s: invalid WL value (%" PRIx64 ")",
>                               __func__, (value >> 7) & 0x1f);
>           s->ch[ch].config = value & 0x7fffff;
>           break;
> 
