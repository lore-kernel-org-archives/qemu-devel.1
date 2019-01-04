Received: from eggsout.gnu.org ([209.51.188.92]:53069 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gfXtA-0002HG-Hz
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gfXt8-00035a-9v
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:24:25 -0500
Date: Fri, 4 Jan 2019 23:24:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190104175847.6290-3-philmd@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1901042320490.67917@zero.eik.bme.hu>
References: <20190104175847.6290-1-philmd@redhat.com>
	<20190104175847.6290-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 02/16] hw: Remove unused
 'hw/devices.h' include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-ppc@nongnu.org

On Fri, 4 Jan 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 4a8686f0f5..2122291308 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -32,7 +32,6 @@
> #include "hw/hw.h"
> #include "hw/char/serial.h"
> #include "ui/console.h"
> -#include "hw/devices.h"
> #include "hw/sysbus.h"
> #include "hw/pci/pci.h"
> #include "hw/i2c/i2c.h"

Looks like I forgot to drop this include in ca8a110470

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
