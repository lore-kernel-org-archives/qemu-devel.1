Received: from eggs.gnu.org ([209.51.188.92]:42950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gmeNF-0006mU-K0
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gmeND-0005yL-NV
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:44:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gmeNA-0005pX-Cm
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:44:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BB7A37D0F6
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 12:44:32 +0000 (UTC)
Date: Thu, 24 Jan 2019 13:44:28 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20190124124428.GX30040@natto.ory.fergeau.eu>
References: <20190121170434.13592-1-cfergeau@redhat.com>
	<87d0omieea.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bgVZo3zXaTQrZhjg"
Content-Disposition: inline
In-Reply-To: <87d0omieea.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v5] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--bgVZo3zXaTQrZhjg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Jan 24, 2019 at 10:38:37AM +0100, Markus Armbruster wrote:
> Christophe Fergeau <cfergeau@redhat.com> writes:
>=20
> > This commit adds a qemu_init_logging() helper which calls
> > g_log_set_default_handler() so that glib logs (g_log, g_warning, ...)
> > are handled similarly to other QEMU logs. This means they will get a
> > timestamp if timestamps are enabled, and they will go through the
> > monitor if one is configured.
> > This commit also adds a call to qemu_init_logging() to the binaries
> > installed by QEMU.
> > glib debug messages are enabled through G_MESSAGES_DEBUG similarly to
> > glib default log handler.
> >
> > At the moment, this change will mostly impact SPICE logging if your
> > spice version is >=3D 0.14.1. With older spice versions, this is not go=
ing
> > to work as expected, but will not have any ill effect, so this call is
> > not conditional on the SPICE version.
> >
> > Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>
> > Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Do you expect this to go through my tree?

To be honest, I don't know through whose tree this should go.

> Hint: if you do, cc'ing me tends to help ;)
>=20
> scripts/get_maintainer.pl can be your friend.

I ran it, but it returned a few too many names given that it touches
files in various subsystems, I was not sure I should cc: everyone.
Now that I look again, at least "(supporter:Error reporting)" would have
made sense.

Thanks for noticing this patch without the cc: :)

Christophe

--bgVZo3zXaTQrZhjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlxJsywACgkQqdjCFCms
bIJcFw//bakjNQjXuX6UM2EPOR3ZWiGsrF6pRUv33a6K9lxd83LEflBxpvjTkvLJ
T9C/5YxvTVVmTjQRZBThnnhSXwQaS8hyWbA+jVpbbVXfqcCAbvWJ6WXudJKZYMr4
hPXPb34OxZMUzTgAf5Kwvnze2zEJJdTq4AtcVe1D7NIXhJBAILZ0TlUkWGTNGyT6
4OqjlJI+62+ZHvyGXyxeonewuN3fx5GP6UDLmYCQi9EDnbZj0ejT7ZGrTOVOADvV
FSMdSqEFg6eHmYZmFQaurYdapIWjlgGBRDhqOCSku76ycfNqAPxDoTePHRVAw7IB
BXxeV2v/sStkGu+VlqSYsFkPOV1ooYROo786nYfK869kPIlEsZN1RyQ+mNnlAcZS
eO0UJHN2Bz5Zo/vppIu2BRQYq03sHEk01KRS6+/eVwp/GW+1O63kP44rr72OhkXJ
S8XzpqdfbQ2UotnvZGWliprNwGhBzlmUSAJ+UuTXrAbv4gU2VZDYydQTy2feP/9a
rAN3AHqWvC9RY5jX5W7s8tAsoFdUC+yO/IJoA7ydqx6BsALSNeZF0KW8XS8v+1fC
Ul8pJhmJuUj/L2pbcSZm23X5no/yoQt0DNnvyNiDuSULPCDc7qnGfOkegk5Iv/H8
BdzW+3WLvizsGcqmLHqqLbRw2P5DwzZJU7g0vtmvT1ts6+c0p18=
=klRd
-----END PGP SIGNATURE-----

--bgVZo3zXaTQrZhjg--
