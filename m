Received: from eggs.gnu.org ([209.51.188.92]:53130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hEzNV-0006B3-6c
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hEzNU-00020q-B3
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:50:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hEzNU-0001zw-0n
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:50:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id k17so8135634wrx.10
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 09:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190412163706.3878-1-philmd@redhat.com>
In-Reply-To: <20190412163706.3878-1-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Apr 2019 18:49:58 +0200
Message-ID: <CAJ+F1CLOO=cSAnGsR1vXToEhYCtVSUXypJ4fMmoO-T6yp9NNkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Markus Armbruster <armbru@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Gerd Hoffmann <kraxel@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Fri, Apr 12, 2019 at 6:37 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Some VGA adapters do not contain an helpful description,
> this can be confusing:
>
>   $ qemu-system-arm -M virt -vga help
>   none
>   std                  standard VGA
>   cirrus               Cirrus VGA (default)
>   vmware               VMWare SVGA
>   xenfb
>
> Add a description to the missing adapters:
>
>   $ qemu-system-arm -M virt -vga help
>   none                 no graphic card
>   std                  standard VGA
>   cirrus               Cirrus VGA (default)
>   vmware               VMWare SVGA
>   xenfb                Xen paravirtualized framebuffer
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Based-on: <20190412152713.16018-1-marcandre.lureau@redhat.com>

nice follow up, thanks
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
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
> @@ -2067,6 +2068,7 @@ static const VGAInterfaceInfo vga_interfaces[VGA_TY=
PE_MAX] =3D {
>      },
>      [VGA_XENFB] =3D {
>          .opt_name =3D "xenfb",
> +        .name =3D "Xen paravirtualized framebuffer",
>      },
>  };
>
> --
> 2.20.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
