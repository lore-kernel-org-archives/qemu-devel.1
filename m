Received: from eggs.gnu.org ([209.51.188.92]:37417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGPrF-0004Kl-Sx
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGPrF-0000xw-14
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:18:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hGPrE-0000wn-NC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:18:48 -0400
References: <20190412163706.3878-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df50204f-3fe0-3908-a7c9-812d3a255b67@redhat.com>
Date: Tue, 16 Apr 2019 17:18:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190412163706.3878-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl: Add missing descriptions to the VGA
 adapters list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>

On 12/04/19 18:37, Philippe Mathieu-Daud=C3=A9 wrote:
> Some VGA adapters do not contain an helpful description,
> this can be confusing:
>=20
>   $ qemu-system-arm -M virt -vga help
>   none
>   std                  standard VGA
>   cirrus               Cirrus VGA (default)
>   vmware               VMWare SVGA
>   xenfb
>=20
> Add a description to the missing adapters:
>=20
>   $ qemu-system-arm -M virt -vga help
>   none                 no graphic card
>   std                  standard VGA
>   cirrus               Cirrus VGA (default)
>   vmware               VMWare SVGA
>   xenfb                Xen paravirtualized framebuffer
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Based-on: <20190412152713.16018-1-marcandre.lureau@redhat.com>
> ---
>  vl.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/vl.c b/vl.c
> index 840c45c00fa..dfeda8bd7fc 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2029,6 +2029,7 @@ typedef struct VGAInterfaceInfo {
>  static const VGAInterfaceInfo vga_interfaces[VGA_TYPE_MAX] =3D {
>      [VGA_NONE] =3D {
>          .opt_name =3D "none",
> +        .name =3D "no graphic card",
>      },
>      [VGA_STD] =3D {
>          .opt_name =3D "std",
> @@ -2067,6 +2068,7 @@ static const VGAInterfaceInfo vga_interfaces[VGA_=
TYPE_MAX] =3D {
>      },
>      [VGA_XENFB] =3D {
>          .opt_name =3D "xenfb",
> +        .name =3D "Xen paravirtualized framebuffer",
>      },
>  };
> =20
>=20

Queued, thanks.

Paolo
