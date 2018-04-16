Received: from eggs.gnu.org ([2001:4830:134:3::10]:51080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f7w8z-0004d6-Un
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 00:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f7w8w-0000zw-Px
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 00:53:34 -0400
References: <20180415234307.28132-1-f4bug@amsat.org>
	<20180415234307.28132-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a2d59a3a-0176-6065-68ae-60fee97c2332@redhat.com>
Date: Mon, 16 Apr 2018 06:53:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180415234307.28132-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/41] hw: Clean "hw/devices.h" includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

On 16.04.2018 01:42, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/devices.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/devices.h b/include/hw/devices.h
> index 861ddea8af..0e27feb0c2 100644
> --- a/include/hw/devices.h
> +++ b/include/hw/devices.h
> @@ -1,13 +1,10 @@
>  #ifndef QEMU_DEVICES_H
>  #define QEMU_DEVICES_H
> =20
> -#include "hw/irq.h"
> -
> -/* ??? Not all users of this file can include cpu-common.h.  */
> -struct MemoryRegion;
> -
>  /* Devices that have nowhere better to go.  */
> =20
> +#include "hw/hw.h"
> +
>  /* smc91c111.c */
>  void smc91c111_init(NICInfo *, uint32_t, qemu_irq);

IMHO we should rather get rid of devices.h (in a separate patch series)
and introduce proper small headers =C3=A0 la smc91c111.h for the single
sections in here... Just my 0.02 =E2=82=AC.

 Thomas
