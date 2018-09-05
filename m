Received: from eggs.gnu.org ([2001:4830:134:3::10]:35688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxXYv-0000FO-UI
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:09:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fxXYt-0007KK-Sj
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 09:09:37 -0400
References: <20180904170930.28619-1-jsnow@redhat.com>
	<20180904170930.28619-7-jsnow@redhat.com>
	<cd9e2b78-9aa1-b988-fe15-b7f59f8bd5d1@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a84c5441-a2be-e680-2b78-a9c0251d0aa7@redhat.com>
Date: Wed, 5 Sep 2018 09:09:19 -0400
MIME-Version: 1.0
In-Reply-To: <cd9e2b78-9aa1-b988-fe15-b7f59f8bd5d1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rV0tvtjTbWVoxMShC6UDpUvG6jAfZL239"
Subject: Re: [Qemu-devel] [PATCH v4 06/15] block/mirror: conservative
 mirror_exit refactor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rV0tvtjTbWVoxMShC6UDpUvG6jAfZL239
From: John Snow <jsnow@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Eric Blake <eblake@redhat.com>
Message-ID: <a84c5441-a2be-e680-2b78-a9c0251d0aa7@redhat.com>
Subject: Re: [PATCH v4 06/15] block/mirror: conservative mirror_exit refactor
References: <20180904170930.28619-1-jsnow@redhat.com>
 <20180904170930.28619-7-jsnow@redhat.com>
 <cd9e2b78-9aa1-b988-fe15-b7f59f8bd5d1@redhat.com>
In-Reply-To: <cd9e2b78-9aa1-b988-fe15-b7f59f8bd5d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/05/2018 06:43 AM, Max Reitz wrote:
> On 2018-09-04 19:09, John Snow wrote:
>> For purposes of minimum code movement, refactor the mirror_exit
>> callback to use the post-finalization callbacks in a trivial way.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  block/mirror.c | 34 +++++++++++++++++++++++++++-------
>>  1 file changed, 27 insertions(+), 7 deletions(-)
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> (Although I believe the ?: hunk from the previous patch should be here.=

> Also note that we have a couple of places that make use of the GNU
> extension for "?:" as a binary operator (as in "x ?: y" returns x if
> x !=3D 0).  Just in case you find "s->to_replace ?: src" as appealing a=
s I
> do.)
>=20

Ah, I wasn't sure that was OK to use. Meh, since I goofed up the last
patch I'll use that version.


--rV0tvtjTbWVoxMShC6UDpUvG6jAfZL239
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+ber27ys35W+dsvQfe+BBqr8OQ4FAluP1YUACgkQfe+BBqr8
OQ6rnRAAlWXAdf7KrQEjaTH9scalRYtq2JWsdT7jsGj7pE+ne5JMbDk98R9kj1K7
r7vtnksOE1vHJ9HWTi6hdVKrKv1yrNFxELWGpAAAKh/4iyCoIv7AVMf7VxKWypgj
SnKHPjDeczkUjqrnjkCLVlxCPHGbGbp3ukVgZf6jlKC63e3iOe3tI9OR72pA/C6+
Frc/lrfsI3yaZcrA1onlVDBqjMXezQxgdnlIv8JsVw+IhnaJWbiuQrLByUJZI4aT
X9fjPiwLKQ0WFF3lqmIjOsMTLQU4CLbW+TaMdh6TBY0HbsUcHbR0hqPJ9D2hXZqK
1vya2A2SFI3/Tz9f3j+u5wJhd1x/pUAtq8ujL2TSoACu/dxMpALj/3+5asJclK8g
kxO3GA9EcUY+2HdfNwQQ2PxfehQQzNLg7BnZeOMefIf8SUXyYxrSPV5lVavA0/R7
Psm+dgpVyFh4VWG96Srd/QQTizCUk9t/MjeQX+Jdzr+eNEgNS4xMslqomhGDIMIt
jzOxq+8gioN1b81Z3jDbFDPGBsUxsGBuRN5cPGuXfEePUloAKqu/zUkhxIt7i2Jl
da4kr04o9cozNbf0gA5/X6/OjBlwaBugOZDhKx+C5vvhPkVhrOGTUcgUfO4InpF0
fp1g2IkWFWdZQ3XEL38bZGl7oqEYbks3GJWZuo7TIdaemnw1zvg=
=vJ6B
-----END PGP SIGNATURE-----

--rV0tvtjTbWVoxMShC6UDpUvG6jAfZL239--
