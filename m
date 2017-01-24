Received: from eggs.gnu.org ([2001:4830:134:3::10]:51044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cW03n-0004uU-MT
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cW03l-0005VZ-Ja
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 07:18:51 -0500
References: <1485256239-12219-1-git-send-email-kraxel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f92a1ee1-3280-c14e-59a5-ce884e752f06@redhat.com>
Date: Tue, 24 Jan 2017 13:18:46 +0100
MIME-Version: 1.0
In-Reply-To: <1485256239-12219-1-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] console: fix console resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: 1658634@bugs.launchpad.net, qemu stable list <qemu-stable@nongnu.org>

On 01/24/17 12:10, Gerd Hoffmann wrote:
> Only skip surface reallocation in case the old surface was created usin=
g
> qemu_alloc_display (via qemu_create_displaysurface) too, otherwise we
> might end up with a DisplaySurface with the wrong backing storage.
>=20
> Cc: 1658634@bugs.launchpad.net
> Fixes: cd958edb1fae85d0c7d1e1acbff82d22724e8d64
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/ui/console.c b/ui/console.c
> index b9575f2..d573351 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -2121,7 +2121,7 @@ void qemu_console_resize(QemuConsole *s, int widt=
h, int height)
> =20
>      assert(s->console_type =3D=3D GRAPHIC_CONSOLE);
> =20
> -    if (s->surface &&
> +    if (s->surface && (s->surface->flags & QEMU_ALLOCATED_FLAG) &&
>          pixman_image_get_width(s->surface->image) =3D=3D width &&
>          pixman_image_get_height(s->surface->image) =3D=3D height) {
>          return;
>=20

Tested-by: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-stable@nongnu.org

Thanks
Laszlo
