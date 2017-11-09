Received: from eggs.gnu.org ([2001:4830:134:3::10]:40050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCcbB-0003d2-3O
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 21:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCcbA-0007bu-Dj
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 21:29:45 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
	<f3216f23f78da16fcf77a9757d2323d03afc08a3.1510181732.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2880236a-851c-dd78-9b1e-155b278a6717@amsat.org>
Date: Wed, 8 Nov 2017 23:29:33 -0300
MIME-Version: 1.0
In-Reply-To: <f3216f23f78da16fcf77a9757d2323d03afc08a3.1510181732.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 31/45] hw/ppc: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>
Cc: alistair23@gmail.com, qemu-ppc@nongnu.org, armbru@redhat.com

Cc'ing Alexander to ask him about the mpc8544ds.

On 11/08/2017 07:58 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
[...]
> diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
> index ce1254b5d4..3a2c49e3fd 100644
> --- a/hw/ppc/mpc8544_guts.c
> +++ b/hw/ppc/mpc8544_guts.c
> @@ -18,6 +18,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "hw/hw.h"
> @@ -83,7 +84,7 @@ static uint64_t mpc8544_guts_read(void *opaque, hwaddr addr,
>          value = env->spr[SPR_E500_SVR];
>          break;
>      default:
> -        fprintf(stderr, "guts: Unknown register read: %x\n", (int)addr);
> +        error_report("guts: Unknown register read: %x", (int)addr);

Alexander: Should this be reported as UNIMP or GUEST_ERROR?

>          break;
>      }
>  
> @@ -102,7 +103,7 @@ static void mpc8544_guts_write(void *opaque, hwaddr addr,
>          }
>          break;
>      default:
> -        fprintf(stderr, "guts: Unknown register write: %x = %x\n",
> +        error_report("guts: Unknown register write: %x = %x",
>                  (int)addr, (unsigned)value);
>          break;
>      }

Thanks,

Phil.
