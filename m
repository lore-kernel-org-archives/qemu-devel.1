Received: from eggs.gnu.org ([209.51.188.92]:46898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1xJ5-0002Zp-3Z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1xJ4-0002D2-Eu
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:59:47 -0500
References: <20190307172401.29451-1-armbru@redhat.com>
	<20190307172401.29451-7-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b779d47-f381-a7e1-961d-a676304abfc2@redhat.com>
Date: Thu, 7 Mar 2019 11:59:34 -0600
MIME-Version: 1.0
In-Reply-To: <20190307172401.29451-7-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YmfUtDzu3uJ2pB9VUVTu7qByHIuy9ZiTp"
Subject: Re: [Qemu-devel] [PATCH v2 06/12] vl: Factor configure_blockdev()
 out of main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org, mst@redhat.com, philmd@redhat.com, mreitz@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, lersek@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YmfUtDzu3uJ2pB9VUVTu7qByHIuy9ZiTp
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 mst@redhat.com, philmd@redhat.com, mreitz@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, lersek@redhat.com
Message-ID: <5b779d47-f381-a7e1-961d-a676304abfc2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/12] vl: Factor configure_blockdev() out
 of main()
References: <20190307172401.29451-1-armbru@redhat.com>
 <20190307172401.29451-7-armbru@redhat.com>
In-Reply-To: <20190307172401.29451-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/7/19 11:23 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>=20
> # Conflicts:
> #	vl.c

How'd you get git to preserve the leading #? Generally, I find conflicts
details useful for cherry-picked backports, but pointless for rebased
patches intended as original upstream material. And git defaults to
stripping lines with leading # when composing a commit message. May be
worth cleaning up before the actual pull request.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--YmfUtDzu3uJ2pB9VUVTu7qByHIuy9ZiTp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBXAcACgkQp6FrSiUn
Q2pLGQf/cI2BTp6d14fav3Bbjs30lDeU7QiEESwWjyl1EH4MQ7XnSJnORBLA/Axh
PK0DuQWdKEeefhWqx0+KqVV9wtvP9/4Oqo+kr/Gd9Gou7XUgsj0ZNVsoSS5Bz8SN
E/U7VSFB/2JE9oH9GjyHd9qeluTgcvFgv54qhNybY93WQw+ipe7AHrBSzs2ApjF/
EkKuYb9ue8ozTTG7Qz0GxQ0kc/Zv/QyuhT6INzF2TRjj8uLXARNEupwafoy3vo7w
ftmjV351FrmtUZO/iV7OQDfSw0J17uqs9ozi3LWvaxDoV5SFzcYDCaCwnCb9mMdI
TG/69kzfJod7supfFFrIvGGNPi3liw==
=u3/o
-----END PGP SIGNATURE-----

--YmfUtDzu3uJ2pB9VUVTu7qByHIuy9ZiTp--
