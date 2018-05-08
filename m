Received: from eggs.gnu.org ([2001:4830:134:3::10]:42005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fGAud-0004RM-VW
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fGAuc-0002RW-S5
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:16:47 -0400
References: <20180508151035.16774-1-f4bug@amsat.org>
	<20180508151035.16774-5-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <af242f4e-7a71-c219-a24b-6360c5657bfa@redhat.com>
Date: Tue, 8 May 2018 18:16:35 -0400
MIME-Version: 1.0
In-Reply-To: <20180508151035.16774-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] hw/ide/ahci: Remove
 AllwinnerAHCIState from qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org



On 05/08/2018 11:10 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Files requiring AllwinnerAHCIState already include "hw/ide/ahci.h".
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
> index b4dc63a466..6baadfbd49 100644
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

Hm, sure; I suppose we don't need QEMU-wide definitions of these sorts
of things.

Acked-by: John Snow <jsnow@redhat.com>
