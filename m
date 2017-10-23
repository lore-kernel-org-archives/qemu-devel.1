Received: from eggs.gnu.org ([2001:4830:134:3::10]:59012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6YQK-0006iM-3A
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6YQH-0002Qc-0b
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:49:28 -0400
Message-ID: <1508748555.16488.4.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 10:49:15 +0200
In-Reply-To: <1508493233-1166-1-git-send-email-thuth@redhat.com>
References: <1508493233-1166-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/display/sm501: Fix comment in
 sm501_sysbus_class_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 2017-10-20 at 11:53 +0200, Thomas Huth wrote:
> The "cannot_instantiate_with_device_add_yet" flag has been renamed
> to "user_creatable" a while ago.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> =C2=A0hw/display/sm501.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 6eddac9..7f18224 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1758,7 +1758,7 @@ static void sm501_sysbus_class_init(ObjectClass
> *klass, void *data)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dc->reset =3D sm501_reset_sysbus;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dc->vmsd =3D &vmstate_sm501_sysbus;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Note: pointer property "chr-state" may=
 remain null, thus
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* no need for dc->cannot_instantiate_wit=
h_device_add_yet =3D
> true;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* no need for dc->user_creatable =3D fal=
se;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> =C2=A0}
> =C2=A0

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
