Received: from eggs.gnu.org ([209.51.188.92]:35315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hCGFR-0001xn-FH
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 00:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hCGFQ-00045b-Ig
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 00:14:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hCGFP-00040R-RH
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 00:14:36 -0400
References: <20190404221238.12468-1-philmd@redhat.com>
	<20190404221238.12468-2-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ef95f30c-38e0-d7bd-533f-d8b9831bc62a@redhat.com>
Date: Fri, 5 Apr 2019 06:14:26 +0200
MIME-Version: 1.0
In-Reply-To: <20190404221238.12468-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.1 1/4] hw/isa/superio: Rename a
 variable
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
> This patch is purely cosmetic. No functional change.
> This will ease the next patch where we re-indent an if() statement.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/isa/isa-superio.c | 69 ++++++++++++++++++++++----------------------
>  1 file changed, 34 insertions(+), 35 deletions(-)
>=20
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index d54463bf035..c6845eaf578 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -22,8 +22,8 @@
> =20
>  static void isa_superio_realize(DeviceState *dev, Error **errp)
>  {
> -    ISASuperIODevice *sio =3D ISA_SUPERIO(dev);
> -    ISASuperIOClass *k =3D ISA_SUPERIO_GET_CLASS(sio);
> +    ISASuperIODevice *s =3D ISA_SUPERIO(dev);
> +    ISASuperIOClass *k =3D ISA_SUPERIO_GET_CLASS(s);

Sorry, but I have to say that I normally really don't like single-letter
variable names. They are much harder to search for, and way less
self-describing.

If you get problems with the line length in a later patch, what about
refactoring the related code into a separate function? So that you'd
only have something like this in the realize function:

    for (i =3D 0, j =3D 0; i < bus_count; i++, j +=3D MAX_IDE_DEVS) {
        if (!k->ide.is_enabled || k->ide.is_enabled(s, j)) {
            isa_superio_init_ide(...);
        }
    }

 Thomas
