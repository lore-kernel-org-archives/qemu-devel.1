Received: from eggs.gnu.org ([2001:4830:134:3::10]:50360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSqLd-0001hU-MV
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 15:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSqLc-00019l-Ri
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 15:52:29 -0400
References: <20170705190404.22449-1-mreitz@redhat.com>
	<20170705190404.22449-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4227ab64-b25b-e497-8898-3d2554ca79e4@redhat.com>
Date: Wed, 5 Jul 2017 14:52:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170705190404.22449-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lwLvUpBlp9dhR0lCpPskgCGrHBUEFTPSv"
Subject: Re: [Qemu-devel] [PATCH v4 3/5] block: qobject_is_equal() in
 bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lwLvUpBlp9dhR0lCpPskgCGrHBUEFTPSv
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <4227ab64-b25b-e497-8898-3d2554ca79e4@redhat.com>
Subject: Re: [PATCH v4 3/5] block: qobject_is_equal() in bdrv_reopen_prepare()
References: <20170705190404.22449-1-mreitz@redhat.com>
 <20170705190404.22449-4-mreitz@redhat.com>
In-Reply-To: <20170705190404.22449-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2017 02:04 PM, Max Reitz wrote:
> Currently, bdrv_reopen_prepare() assumes that all BDS options are
> strings. However, this is not the case if the BDS has been created
> through the json: pseudo-protocol or blockdev-add.
>=20
> Note that the user-invokable reopen command is an HMP command, so you
> can only specify strings there. Therefore, specifying a non-string
> option with the "same" value as it was when originally created will now=

> return an error because the values are supposedly similar (and there is=

> no way for the user to circumvent this but to just not specify the
> option again -- however, this is still strictly better than just
> crashing).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lwLvUpBlp9dhR0lCpPskgCGrHBUEFTPSv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXUNyAAoJEKeha0olJ0NqIOYH/3QXZmBlol0kdMVvOq99/EBK
RCGcnJJUO9rlOvXzM8xLEz8Vfry7VKrVGCR6pmLKwlOk7CMDcgHsfOeT4Ha0QRd0
LNXXe1EAL1EV7quGqJAoTnWda7z1W1lLp1mvdsWzEH3qCHsr4gEyqVl3oMydOe6e
VCipnuySJZPM/8BipA7v5nFeUBLcUufShvqjvNjbzUgU2EgUFkNRCvz2aovWBUiS
9KFO/6OoOFo3WrYe8Fj6YorhsLpjot6aoH4S58f3JO4gtUn+xNFQWVmfxp+Fo3MF
kQ+nFpBsgVqaBB5daXzGRkFgT4J3+7brltg4byPS+54CUQ8ChAhc1fPdMyvOeg0=
=YI6M
-----END PGP SIGNATURE-----

--lwLvUpBlp9dhR0lCpPskgCGrHBUEFTPSv--
