Received: from eggs.gnu.org ([2001:4830:134:3::10]:44241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwM2X-00061x-V5
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwM2T-00045c-0H
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:34:45 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-7-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5ed69cad-69b8-888d-39e6-e99004cbe053@redhat.com>
Date: Mon, 25 Sep 2017 07:34:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170922160111.31885-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 29/34] hw/net/e1000e: use TYPE_PCI_E1000E
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 22.09.2017 18:01, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/net/pci.h | 1 +
>  hw/net/e1000e.c      | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/net/pci.h b/include/hw/net/pci.h
> index b24b5257a5..92111f86f3 100644
> --- a/include/hw/net/pci.h
> +++ b/include/hw/net/pci.h
> @@ -14,6 +14,7 @@
>  #include "hw/pci/pci_bus.h"
> =20
>  #define TYPE_PCI_E1000      "e1000"
> +#define TYPE_PCI_E1000E     "e1000e"
> =20
>  PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
>                                 const char *default_model,
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index 6c42b4478c..494f8cced6 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -40,6 +40,7 @@
>  #include "sysemu/sysemu.h"
>  #include "hw/pci/msi.h"
>  #include "hw/pci/msix.h"
> +#include "hw/net/pci.h"
> =20
>  #include "hw/net/e1000_regs.h"
> =20
> @@ -49,8 +50,7 @@
>  #include "trace.h"
>  #include "qapi/error.h"
> =20
> -#define TYPE_E1000E "e1000e"
> -#define E1000E(obj) OBJECT_CHECK(E1000EState, (obj), TYPE_E1000E)
> +#define E1000E(obj) OBJECT_CHECK(E1000EState, (obj), TYPE_PCI_E1000E)
> =20
>  typedef struct E1000EState {
>      PCIDevice parent_obj;
> @@ -703,7 +703,7 @@ static void e1000e_instance_init(Object *obj)
>  }
> =20
>  static const TypeInfo e1000e_info =3D {
> -    .name =3D TYPE_E1000E,
> +    .name =3D   TYPE_PCI_E1000E,
>      .parent =3D TYPE_PCI_DEVICE,
>      .instance_size =3D sizeof(E1000EState),
>      .class_init =3D e1000e_class_init,
>=20

That seems unnecessary to me, since it's not used anywhere outside of
e1000e.c. I'd suggest to drop this patch.

 Thomas
