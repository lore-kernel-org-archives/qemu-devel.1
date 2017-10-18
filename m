Received: from eggs.gnu.org ([2001:4830:134:3::10]:57032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4nR1-0003YC-S6
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4nQx-0007Nz-V0
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:26:55 -0400
References: <20171017164426.25277-1-f4bug@amsat.org>
	<20171017164426.25277-36-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <05c9a669-da17-9894-62d9-43c3d9defb17@redhat.com>
Date: Wed, 18 Oct 2017 14:26:42 +0200
MIME-Version: 1.0
In-Reply-To: <20171017164426.25277-36-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 35/42] hw/display/vga: "vga.h" only
 contains registers defs, rename it "vga_regs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 17.10.2017 18:44, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/display/{vga.h =3D> vga_regs.h} | 0
>  hw/display/vga.c                 | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename hw/display/{vga.h =3D> vga_regs.h} (100%)
>=20
> diff --git a/hw/display/vga.h b/hw/display/vga_regs.h
> similarity index 100%
> rename from hw/display/vga.h
> rename to hw/display/vga_regs.h
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index ed24ef7076..35696b6fdd 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -24,11 +24,11 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/hw.h"
> -#include "vga.h"
>  #include "ui/console.h"
>  #include "hw/i386/pc.h"
>  #include "hw/pci/pci.h"
>  #include "vga_int.h"
> +#include "vga_regs.h"
>  #include "ui/pixel_ops.h"
>  #include "qemu/timer.h"
>  #include "hw/xen/xen.h"
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
