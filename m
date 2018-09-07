Received: from eggs.gnu.org ([2001:4830:134:3::10]:52702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyPyV-0005S3-2m
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyPyU-0005Cb-Ee
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 19:15:39 -0400
References: <20180906130225.5118-1-jsnow@redhat.com>
	<20180906130225.5118-6-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a2da6bb7-06bf-05d1-5695-26884e87d80a@redhat.com>
Date: Sat, 8 Sep 2018 01:15:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180906130225.5118-6-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6vZNAfu0Vx8fAisD4afaRmlFbCX9Rzugn"
Subject: Re: [Qemu-devel] [PATCH v5 05/16] block/mirror: don't install
 backing chain on abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6vZNAfu0Vx8fAisD4afaRmlFbCX9Rzugn
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jtc@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Jeff Cody <jcody@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <a2da6bb7-06bf-05d1-5695-26884e87d80a@redhat.com>
Subject: Re: [PATCH v5 05/16] block/mirror: don't install backing chain on
 abort
References: <20180906130225.5118-1-jsnow@redhat.com>
 <20180906130225.5118-6-jsnow@redhat.com>
In-Reply-To: <20180906130225.5118-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-06 15:02, John Snow wrote:
> In cases where we abort the block/mirror job, there's no point in
> installing the new backing chain before we finish aborting.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--6vZNAfu0Vx8fAisD4afaRmlFbCX9Rzugn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluTBo4ACgkQ9AfbAGHV
z0BB7QgApmy10UdyncAYWfecW+2zNTwdrXuK2eOivZdqtn2ygJwTvcRVuyn8Kxtk
zEi8F5/g4pc+v++Jy+uC39jdrDEGLu053HToNw7TUa/cgSnYSOz/Vqy+w/n+FRLY
WBV3AZEdmeHU/qBxx/yqpH3Hx0KYMh1p4mtpPm/6oQxfFpV27Ec84tGq1VSzNtrR
hTJdvnX/qtvnoFh7L5xNyp9ccMrvZpdDEp0U9Xi9Jr6c85mQBpItfZNwVvljcfkE
/HSVAqBQpUnCFJq4orG9O6obGrDmImaygvqIemgXW8zf+Rmy5LPgxIqPN3j0OxlO
1s22qpWRBXqMgGeR/rxAhZHkK3B33Q==
=vKg9
-----END PGP SIGNATURE-----

--6vZNAfu0Vx8fAisD4afaRmlFbCX9Rzugn--
