Received: from eggs.gnu.org ([2001:4830:134:3::10]:34576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecEnb-0000j8-2u
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecEnZ-000326-Sc
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:20:26 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:32981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ecEnZ-000314-Aj
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:20:25 -0500
Received: by mail-lf0-x244.google.com with SMTP id t139so13076188lff.0
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 10:20:25 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180118123219.19410-17-f4bug@amsat.org>
References: <20180118123219.19410-1-f4bug@amsat.org>
	<20180118123219.19410-17-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 18 Jan 2018 10:19:53 -0800
Message-ID: <CAKmqyKM-tEKmxoYdUr7iREp+J6kB8Gasq7WLAeF+30kz2n4oQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 16/16] sdhci: throw an error if
 capabilities are incorrectly configured
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Kevin O'Connor <kevin@koconnor.net>, Marcel Apfelbaum <marcel@redhat.com>

On Thu, Jan 18, 2018 at 4:32 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> now than the Exynos4210 uses the 'capareg-reserved' property,
> we can safely report missing capabilities as error, since
> capabilities will only get changed once new SDHCI models
> are added.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 7799382e89..07a7ebcc1e 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -23,7 +23,6 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "hw/hw.h"
>  #include "sysemu/block-backend.h"
> @@ -1208,7 +1207,8 @@ static void sdhci_init_readonly_registers(SDHCIStat=
e *s, Error **errp)
>      } else {
>          capab =3D s->capareg & ~capab;
>          if (capab) {
> -            warn_report("SDHCI: missing capability mask: 0x%" PRIx64, ca=
pab);
> +            error_setg(errp, "missing capability mask: 0x%" PRIx64, capa=
b);
> +            return;
>          }
>      }
>  }
> --
> 2.15.1
>
>
