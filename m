Received: from eggs.gnu.org ([2001:4830:134:3::10]:55691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYGrF-00060h-MZ
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:39:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYGrC-0000nV-4g
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:39:17 -0500
References: <20170126110435.2777-1-berrange@redhat.com>
	<20170126110435.2777-7-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e8734d42-8040-1250-0af0-5234fc1ba948@redhat.com>
Date: Mon, 30 Jan 2017 12:39:04 -0600
MIME-Version: 1.0
In-Reply-To: <20170126110435.2777-7-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rNa6EFtlkXt5TmwD09aQRBO5AWn46UqV5"
Subject: Re: [Qemu-devel] [PATCH v1 6/6] qemu-img: copy *key-secret opts
 when opening newly created files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rNa6EFtlkXt5TmwD09aQRBO5AWn46UqV5
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <e8734d42-8040-1250-0af0-5234fc1ba948@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 6/6] qemu-img: copy *key-secret opts when
 opening newly created files
References: <20170126110435.2777-1-berrange@redhat.com>
 <20170126110435.2777-7-berrange@redhat.com>
In-Reply-To: <20170126110435.2777-7-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2017 05:04 AM, Daniel P. Berrange wrote:
> The qemu-img dd/convert commands will create a image file and
> then try to open it. Historically it has been possible to open
> new files without passing any options. With encrypted files
> though, the *key-secret options are mandatory, so we need to
> provide those options when opening the newlky created file.

s/newlky/newly/

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 47 insertions(+), 4 deletions(-)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rNa6EFtlkXt5TmwD09aQRBO5AWn46UqV5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYj4hIAAoJEKeha0olJ0NquNYH/0KpB0lEeaVmGdh5F1vVCF+g
Pr3uqB0kCoFOxl2fgAJzTOVGwKUqc7HyndZKG6clV+faiJyp8gLsyblyGFUOHfT+
mkrDjaWI4uKxRcyBSldfcYju4ahOFBeOAf1WN+UBF+1yx1c0JRFxf6ISuM1Nc6an
lqQ2ItPLvX2dm/WMctKPGWf3Bq5huqHJSuLQ0rQ5sDwP4N79F+gSuWXfU7PUgGGJ
vH1wmtc/TAYDDL7jb6mT8ytlFgOQJ2yjpOCC26Uf5AujNUDN3cQNojZ7olAWQw32
3aOdFUjEbWI6J8h4o+t6laNOqVNkPB3d1cRwJt2EYQGQo+m8A8gih+gMVYU2HXA=
=Vh5a
-----END PGP SIGNATURE-----

--rNa6EFtlkXt5TmwD09aQRBO5AWn46UqV5--
