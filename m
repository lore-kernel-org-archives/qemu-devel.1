Received: from eggs.gnu.org ([209.51.188.92]:56594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizqC-0004DK-6H
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizqB-0002cF-Af
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:51:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gizqB-000230-3c
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:51:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so22286030wrp.3
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:51:19 -0800 (PST)
References: <20190112014156.6AA447456B3@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1b5188cc-8b62-671e-65ce-6385110e3e02@redhat.com>
Date: Mon, 14 Jan 2019 11:51:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190112014156.6AA447456B3@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] smbus: Remove unneeded include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

On 1/12/19 2:32 AM, BALATON Zoltan wrote:
> The file no longer uses error_report after review so the header is not
> needed either.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
