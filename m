Received: from eggs.gnu.org ([2001:4830:134:3::10]:33362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gWN3J-0001d8-W9
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gWN3G-0000b7-Pb
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:00:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gWN3E-0000Uh-K1
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:00:54 -0500
References: <20181207165103.3992-1-philmd@redhat.com>
	<20181207165103.3992-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0f7d8556-168d-491d-433b-801837afb0dc@redhat.com>
Date: Mon, 10 Dec 2018 16:00:33 +0100
MIME-Version: 1.0
In-Reply-To: <20181207165103.3992-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/smbios: Restrict access to
 "smbios_ipmi.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 12/07/18 17:51, Philippe Mathieu-Daud=C3=A9 wrote:
> All the consumers of "smbios_ipmi.h" are located in hw/smbios/.

I tried to verify this statement by grepping the tree for
"smbios_ipmi.h". There were zero hits. Please use the more precise
pathname "hw/smbios/ipmi.h". (I can't suggest just "ipmi.h", because
that isn't unique.)

With this update:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks,
Laszlo

> There is no need to have this include publicly exposed,
> reduce the visibility by moving it in hw/smbios/.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/smbios/smbios.c                                  | 2 +-
>  include/hw/smbios/ipmi.h =3D> hw/smbios/smbios_ipmi.h | 0
>  hw/smbios/smbios_type_38-stub.c                     | 2 +-
>  hw/smbios/smbios_type_38.c                          | 2 +-
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename include/hw/smbios/ipmi.h =3D> hw/smbios/smbios_ipmi.h (100%)
>=20
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 920939454e..30bd4731cf 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -28,7 +28,7 @@
>  #include "hw/loader.h"
>  #include "exec/cpu-common.h"
>  #include "smbios_build.h"
> -#include "hw/smbios/ipmi.h"
> +#include "smbios_ipmi.h"
> =20
>  /* legacy structures and constants for <=3D 2.0 machines */
>  struct smbios_header {
> diff --git a/include/hw/smbios/ipmi.h b/hw/smbios/smbios_ipmi.h
> similarity index 100%
> rename from include/hw/smbios/ipmi.h
> rename to hw/smbios/smbios_ipmi.h
> diff --git a/hw/smbios/smbios_type_38-stub.c b/hw/smbios/smbios_type_38=
-stub.c
> index 5b83c9b1f1..fc4516bc8a 100644
> --- a/hw/smbios/smbios_type_38-stub.c
> +++ b/hw/smbios/smbios_type_38-stub.c
> @@ -8,7 +8,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> -#include "hw/smbios/ipmi.h"
> +#include "smbios_ipmi.h"
> =20
>  void smbios_build_type_38_table(void)
>  {
> diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
> index 56e8609c00..d84e87d608 100644
> --- a/hw/smbios/smbios_type_38.c
> +++ b/hw/smbios/smbios_type_38.c
> @@ -9,10 +9,10 @@
> =20
>  #include "qemu/osdep.h"
>  #include "hw/ipmi/ipmi.h"
> -#include "hw/smbios/ipmi.h"
>  #include "hw/smbios/smbios.h"
>  #include "qemu/error-report.h"
>  #include "smbios_build.h"
> +#include "smbios_ipmi.h"
> =20
>  /* SMBIOS type 38 - IPMI */
>  struct smbios_type_38 {
>=20
