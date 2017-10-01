Received: from eggs.gnu.org ([2001:4830:134:3::10]:44571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTNF-0001NX-8f
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTNE-0007lh-38
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:48:53 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:44299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTND-0007lL-Uo
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:48:52 -0400
Received: by mail-qt0-x242.google.com with SMTP id o13so3746479qtf.1
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 18:48:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<a795d9122a419eece0e003a95f35e44347a1be84.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9762539c-b1e1-ea4e-3a05-ff2d09c89801@amsat.org>
Date: Sat, 30 Sep 2017 22:48:48 -0300
MIME-Version: 1.0
In-Reply-To: <a795d9122a419eece0e003a95f35e44347a1be84.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 20/47] hw/isa: Replace fprintf(stderr,
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
>      'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N; {s|fprintf(stderr,
> "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
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
>   hw/isa/isa-bus.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
> index 348e0eab9d..0f2e426d02 100644
> --- a/hw/isa/isa-bus.c
> +++ b/hw/isa/isa-bus.c
> @@ -17,6 +17,7 @@
>    * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>    */
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "hw/hw.h"
>   #include "monitor/monitor.h"
> @@ -186,15 +187,15 @@ ISADevice *isa_vga_init(ISABus *bus)
>       case VGA_CIRRUS:
>           return isa_create_simple(bus, "isa-cirrus-vga");
>       case VGA_QXL:
> -        fprintf(stderr, "%s: qxl: no PCI bus\n", __func__);
> +        error_report("%s: qxl: no PCI bus", __func__);
>           return NULL;
>       case VGA_STD:
>           return isa_create_simple(bus, "isa-vga");
>       case VGA_VMWARE:
> -        fprintf(stderr, "%s: vmware_vga: no PCI bus\n", __func__);
> +        error_report("%s: vmware_vga: no PCI bus", __func__);
>           return NULL;
>       case VGA_VIRTIO:
> -        fprintf(stderr, "%s: virtio-vga: no PCI bus\n", __func__);
> +        error_report("%s: virtio-vga: no PCI bus", __func__);
>           return NULL;
>       case VGA_NONE:
>       default:
> 
