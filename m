Received: from eggs.gnu.org ([209.51.188.92]:53186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gizeH-00028W-5m
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gizeG-0007xW-FP
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:39:17 -0500
References: <20190112014156.6AA447456B3@zero.eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <53460d11-aab1-a811-ff49-f8051252bd64@redhat.com>
Date: Mon, 14 Jan 2019 11:39:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190112014156.6AA447456B3@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] smbus: Remove unneeded include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Trivial <qemu-trivial@nongnu.org>

On 2019-01-12 02:32, BALATON Zoltan wrote:
> The file no longer uses error_report after review so the header is not
> needed either.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> Forgot to delete this when rewriting after review. This
> can be squashed into 7713f5bed in dgibson/qemu/ppc-for-4.0
> 
>  hw/i2c/smbus_eeprom.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index bef24a1ca4..01b9439014 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -23,7 +23,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "qemu/error-report.h"
>  #include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "hw/hw.h"
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
