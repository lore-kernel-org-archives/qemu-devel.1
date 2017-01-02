Received: from eggs.gnu.org ([2001:4830:134:3::10]:38985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cO4cL-0003fp-GL
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cO4cK-0004Xp-FI
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:33:45 -0500
Received: from mx3-phx2.redhat.com ([209.132.183.24]:44579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cO4cK-0004X7-6n
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 10:33:44 -0500
Date: Mon, 2 Jan 2017 10:33:44 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1355639361.20389.1483371224179.JavaMail.zimbra@redhat.com>
In-Reply-To: <f13d65f5-e9bc-e8e6-8a5f-954d0412f218@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-6-marcandre.lureau@redhat.com>
	<f13d65f5-e9bc-e8e6-8a5f-954d0412f218@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/54] char: fold single-user functions in
 caller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com



----- Original Message -----
> On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> > This shorten a bit the code.
>=20
> Grammar:
> This shortens the code a bit.
>=20
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qemu-char.c | 97
> >  ++++++++++++++++++++-----------------------------------------
> >  1 file changed, 31 insertions(+), 66 deletions(-)
> >=20
>=20
> >      name =3D g_strdup_printf("chardev-udp-%s", chr->label);
> >      qio_channel_set_name(QIO_CHANNEL(sioc), name);
> >      g_free(name);
> > =20
> > +    s =3D g_new0(NetCharDriver, 1);
> > +    s->ioc =3D QIO_CHANNEL(sioc);
> > +    s->bufcnt =3D 0;
> > +    s->bufptr =3D 0;
> > +    chr->opaque =3D s;
> > +    /* be isn't opened until we get a connection */
> > +    *be_opened =3D false;
>=20
> The assignments to 0 and false are redundant with the g_new0(), if you
> want to drop them for even more code reduction.
>=20

thanks, done

> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>=20
>=20
