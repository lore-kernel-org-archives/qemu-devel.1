Received: from eggs.gnu.org ([2001:4830:134:3::10]:59140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1f80p6-0001rP-Rq
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1f80p5-0004kc-ID
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:53:20 -0400
References: <20180415234307.28132-1-f4bug@amsat.org>
	<20180415234307.28132-42-f4bug@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <7924489e-fac9-b4aa-18a5-c2a0d7e0960d@redhat.com>
Date: Mon, 16 Apr 2018 12:53:16 +0300
MIME-Version: 1.0
In-Reply-To: <20180415234307.28132-42-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 41/41] cutils: Do not include
 "qemu/units.h" directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 16/04/2018 2:43, Philippe Mathieu-Daud=C3=A9 wrote:
> All files using "qemu/units.h" definitions already include it directly,
> we can now remove it from "qemu/cutils.h".
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/qemu/cutils.h | 1 -
>  hw/core/machine.c     | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 056e6629bb..cdb0f0db75 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -2,7 +2,6 @@
>  #define QEMU_CUTILS_H
> =20
>  #include "qemu/fprintf-fn.h"
> -#include "qemu/units.h"
> =20
>  /**
>   * pstrcpy:
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 2040177664..8f70c5ad94 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -19,7 +19,7 @@
>  #include "sysemu/sysemu.h"
>  #include "sysemu/numa.h"
>  #include "qemu/error-report.h"
> -#include "qemu/cutils.h"
> +#include "qemu/units.h"
>  #include "sysemu/qtest.h"
> =20
>  static char *machine_get_accel(Object *obj, Error **errp)
>=20

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
