Received: from eggs.gnu.org ([2001:4830:134:3::10]:34731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIbuK-0006gw-To
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIbuH-0000Jg-KZ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:30:32 -0400
References: <20180515152500.19460-1-f4bug@amsat.org>
	<20180515152500.19460-2-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <788cbadf-111a-a86c-505b-ed0a21f00041@redhat.com>
Date: Tue, 15 May 2018 17:30:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180515152500.19460-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw/isa/superio: Fix inconsistent
 use of Chardev->be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

On 15/05/2018 17:24, Philippe Mathieu-Daud=C3=A9 wrote:
> 4c3119a6e3e and cd9526ab7c0 introduced an incorrect and inconsistent
> use of Chardev->be. Also, this CharBackend member is private and is
> not supposed to be accessible.
>=20
> Fix it by removing the inconsistent check.
>=20
> Cc: qemu-stable@nongnu.org
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/isa/isa-superio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index 76286c81a1..bb88251f95 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -43,7 +43,7 @@ static void isa_superio_realize(DeviceState *dev, Err=
or **errp)
>          if (!k->parallel.is_enabled || k->parallel.is_enabled(sio, i))=
 {
>              /* FIXME use a qdev chardev prop instead of parallel_hds[]=
 */
>              chr =3D parallel_hds[i];
> -            if (chr =3D=3D NULL || chr->be) {
> +            if (chr =3D=3D NULL) {
>                  name =3D g_strdup_printf("discarding-parallel%d", i);
>                  chr =3D qemu_chr_new(name, "null");
>              } else {
> @@ -83,7 +83,7 @@ static void isa_superio_realize(DeviceState *dev, Err=
or **errp)
>          if (!k->serial.is_enabled || k->serial.is_enabled(sio, i)) {
>              /* FIXME use a qdev chardev prop instead of serial_hd() */
>              chr =3D serial_hd(i);
> -            if (chr =3D=3D NULL || chr->be) {
> +            if (chr =3D=3D NULL) {
>                  name =3D g_strdup_printf("discarding-serial%d", i);
>                  chr =3D qemu_chr_new(name, "null");
>              } else {
>=20

Queued, thanks.

Paolo
