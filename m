Received: from eggs.gnu.org ([209.51.188.92]:56058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gixss-0006q6-Sq
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 03:46:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gixss-0001xM-68
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 03:46:14 -0500
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-5-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a6cff6e3-afd1-6c75-5c5d-208a803d7219@redhat.com>
Date: Mon, 14 Jan 2019 09:45:54 +0100
MIME-Version: 1.0
In-Reply-To: <20190111140857.4211-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/15] hw/ide/ahci: Remove
 AllwinnerAHCIState from "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>

On 2019-01-11 15:08, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Files requiring AllwinnerAHCIState already include "hw/ide/ahci.h".
>=20
> To clean "qemu/typedefs.h", move the declaration to "hw/ide/ahci.h"
> (removing the forward declaration).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/ide/ahci.h   | 4 ++--
>  include/qemu/typedefs.h | 1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
> index b7bb2b02d6..b44e3000cf 100644
> --- a/include/hw/ide/ahci.h
> +++ b/include/hw/ide/ahci.h
> @@ -73,13 +73,13 @@ typedef struct SysbusAHCIState {
>  #define ALLWINNER_AHCI_MMIO_OFF  0x80
>  #define ALLWINNER_AHCI_MMIO_SIZE 0x80
> =20
> -struct AllwinnerAHCIState {
> +typedef struct AllwinnerAHCIState {
>      /*< private >*/
>      SysbusAHCIState parent_obj;
>      /*< public >*/
> =20
>      MemoryRegion mmio;
>      uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
> -};
> +} AllwinnerAHCIState;
> =20
>  #endif /* HW_IDE_AHCI_H */
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index c026229573..3a5ca74bd3 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -8,7 +8,6 @@
>  typedef struct AdapterInfo AdapterInfo;
>  typedef struct AddressSpace AddressSpace;
>  typedef struct AioContext AioContext;
> -typedef struct AllwinnerAHCIState AllwinnerAHCIState;
>  typedef struct AudioState AudioState;
>  typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
>  typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
