Received: from eggs.gnu.org ([2001:4830:134:3::10]:54289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e43oK-0006Ux-BO
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e43oF-0001FV-Dk
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:43:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e43oF-0001Er-6p
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:43:51 -0400
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<4cfb4103300d333ec3e262dfb1b5873db1b6352e.1506730372.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3df71713-4d22-fa3d-66c6-9fd7f8ab570d@redhat.com>
Date: Mon, 16 Oct 2017 13:43:41 +0200
MIME-Version: 1.0
In-Reply-To: <4cfb4103300d333ec3e262dfb1b5873db1b6352e.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 17/47] hw/input: Replace fprintf(stderr,
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
Cc: alistair23@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, armbru@redhat.com

On 30.09.2017 02:15, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
[...]
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index c479f827b6..ff4f03e4c3 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -22,6 +22,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/hw.h"
>  #include "hw/isa/isa.h"
>  #include "hw/i386/pc.h"
> @@ -307,7 +308,7 @@ static void kbd_write_command(void *opaque, hwaddr addr,
>          /* ignore that */
>          break;
>      default:
> -        fprintf(stderr, "qemu: unsupported keyboard cmd=0x%02x\n", (int)val);
> +        error_report("qemu: unsupported keyboard cmd=0x%02x", (int)val);
>          break;

Please drop the "qemu:" prefix from the string now here, too.

 Thomas
