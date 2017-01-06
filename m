Received: from eggs.gnu.org ([2001:4830:134:3::10]:46547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPcwZ-0003Vt-Sm
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPcwW-0002sd-OP
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:25:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPcwW-0002rd-FX
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 17:25:00 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0A498E223
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 22:25:00 +0000 (UTC)
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-18-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebaba364-a2b4-a745-d7e1-95260d2484df@redhat.com>
Date: Fri, 6 Jan 2017 16:24:58 -0600
MIME-Version: 1.0
In-Reply-To: <20170105165329.17227-18-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aQDR70IWXUDjb7C7eMvcWQoDixweQBH6i"
Subject: Re: [Qemu-devel] [PATCH 17/20] gtk: overwrite the console.c char
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aQDR70IWXUDjb7C7eMvcWQoDixweQBH6i
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <ebaba364-a2b4-a745-d7e1-95260d2484df@redhat.com>
Subject: Re: [PATCH 17/20] gtk: overwrite the console.c char driver
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
 <20170105165329.17227-18-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> Instead of registering a vc handler to allocate the Gtk VC Chardev,
> overwrite the console.c char driver.
>=20
> A later patch, when switching to QOM, will register a default console v=
c
> QOM class if none has been registered before.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  include/sysemu/char.h |  4 +---
>  ui/console.c          | 24 +++++++-----------------
>  ui/gtk.c              | 30 +++++++++++++++++++++---------
>  3 files changed, 29 insertions(+), 29 deletions(-)
>=20

> =20
> +static const CharDriver gd_vc_driver =3D {
> +    .instance_size =3D sizeof(VCChardev),
> +    .kind =3D CHARDEV_BACKEND_KIND_VC,
> +    .parse =3D qemu_chr_parse_vc, .create =3D vc_init,

Might be worth a tweak to split this to two lines.  Either way, R-b stand=
s.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--aQDR70IWXUDjb7C7eMvcWQoDixweQBH6i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYcBk6AAoJEKeha0olJ0NqnnAIAI+Zkg4UH/3NP78WAAHPZdsp
O0mg40n20Pjgx3S4bXnh4fWCZTD0VeZshJzrBn+kXeS79pLamfj/8cU5uSRmXbdj
+XkVb0d5zu1Kv+rhQT+BT3NFcOEsPzpvgJ/dR8FWVSrYj0Oz6S6lXIH89aoQTwqY
64vpA28BFScS7HTEUVhEh8kHIbEagCS+oIPxhBActgSl6uK2lWoZ4m5fsTVpYlCT
P9prub5bYc0YarQGUYMSMvKdSNBN0+P8Fj+R1mclbADjyMrxw/nFKcNNpaaLOuLT
qF7EN3ai895cvq8URb5VoRhFilvW4xttkXQmv2KMwzm6CthXHSHtZFeKnCu8ZBk=
=7TAz
-----END PGP SIGNATURE-----

--aQDR70IWXUDjb7C7eMvcWQoDixweQBH6i--
