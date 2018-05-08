Received: from eggs.gnu.org ([2001:4830:134:3::10]:46887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGBHe-00014F-NE
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:40:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fGBHd-0003sL-Np
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:40:34 -0400
MIME-Version: 1.0
In-Reply-To: <20180508151035.16774-4-f4bug@amsat.org>
References: <20180508151035.16774-1-f4bug@amsat.org>
	<20180508151035.16774-4-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 May 2018 15:39:59 -0700
Message-ID: <CAKmqyKMwRmmp40xmpe5jC+G8yUAbEuNVgNW_9+zAz7mmOJCNJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] hw/ssi: Remove SSIBus from
 qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, May 8, 2018 at 8:10 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> There are only two files requiring this typedef (strongarm.h
> and hw/arm/pxa.h), let them include "hw/pcmcia.h" directly to
> simplify qemu/typedefs.h.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

I think this is heading in the right direction.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair


> ---
>  hw/arm/strongarm.h      | 1 +
>  include/hw/arm/pxa.h    | 1 +
>  include/hw/ssi/ssi.h    | 1 +
>  include/qemu/typedefs.h | 1 -
>  4 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/strongarm.h b/hw/arm/strongarm.h
> index e98840b461..ae51a1ae34 100644
> --- a/hw/arm/strongarm.h
> +++ b/hw/arm/strongarm.h
> @@ -3,6 +3,7 @@
>
>  #include "exec/memory.h"
>  #include "target/arm/cpu-qom.h"
> +#include "hw/ssi/ssi.h"
>
>  #define SA_CS0          0x00000000
>  #define SA_CS1          0x08000000
> diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
> index f6dfb5c0cf..f184349f02 100644
> --- a/include/hw/arm/pxa.h
> +++ b/include/hw/arm/pxa.h
> @@ -13,6 +13,7 @@
>  #include "exec/memory.h"
>  #include "target/arm/cpu-qom.h"
>  #include "hw/pcmcia.h"
> +#include "hw/ssi/ssi.h"
>
>  /* Interrupt numbers */
>  # define PXA2XX_PIC_SSP3       0
> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
> index 6a0c3c3cdb..bdbf3c51f5 100644
> --- a/include/hw/ssi/ssi.h
> +++ b/include/hw/ssi/ssi.h
> @@ -13,6 +13,7 @@
>
>  #include "hw/qdev.h"
>
> +typedef struct SSIBus SSIBus;
>  typedef struct SSISlave SSISlave;
>  typedef struct SSISlaveClass SSISlaveClass;
>  typedef enum SSICSMode SSICSMode;
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index c7a0159bd2..b4dc63a466 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -106,7 +106,6 @@ typedef struct Range Range;
>  typedef struct SerialState SerialState;
>  typedef struct SHPCDevice SHPCDevice;
>  typedef struct SMBusDevice SMBusDevice;
> -typedef struct SSIBus SSIBus;
>  typedef struct uWireSlave uWireSlave;
>  typedef struct VirtIODevice VirtIODevice;
>  typedef struct Visitor Visitor;
> --
> 2.17.0
>
>
