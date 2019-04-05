Received: from eggs.gnu.org ([209.51.188.92]:36657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hCGOx-0004JO-QG
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 00:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hCGOw-0002fW-2n
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 00:24:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hCGOu-0002YU-7F
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 00:24:25 -0400
References: <20190404221238.12468-1-philmd@redhat.com>
	<20190404221238.12468-4-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fc206966-79bf-0582-f9ab-697734771fa9@redhat.com>
Date: Fri, 5 Apr 2019 06:24:15 +0200
MIME-Version: 1.0
In-Reply-To: <20190404221238.12468-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.1 3/4] hw/isa/superio: Support
 chipsets with no Floppy Disk controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>

On 05/04/2019 00.12, Philippe Mathieu-Daud=C3=A9 wrote:
> Not all Super I/O chipsets provide a Floppy Disk Controller.
>=20
> Without this change, using a Super I/O with no FDC would abort QEMU wit=
h:
>=20
>   Initialization of device isa-fdc failed: ISA controller does not supp=
ort DMA
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/isa/isa-superio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index b0761ea1f96..6956f06d529 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -113,7 +113,8 @@ static void isa_superio_realize(DeviceState *dev, E=
rror **errp)
>      }
> =20
>      /* Floppy disc */
> -    if (!k->floppy.is_enabled || k->floppy.is_enabled(s, 0)) {
> +    if (k->floppy.count
> +            && (!k->floppy.is_enabled || k->floppy.is_enabled(s, 0))) =
{
>          isa =3D isa_create(bus, "isa-fdc");
>          d =3D DEVICE(isa);
>          if (k->floppy.get_iobase) {

Reviewed-by: Thomas Huth <thuth@redhat.com>
