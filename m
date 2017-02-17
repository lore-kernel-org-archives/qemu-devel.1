Received: from eggs.gnu.org ([2001:4830:134:3::10]:44984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceksb-00006Z-Ht
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceksY-0004L0-Fp
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:55:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ceksY-0004KZ-6y
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:55:26 -0500
References: <1487344340-30471-1-git-send-email-peter.maydell@linaro.org>
	<9d625bc9-4d35-a03b-03ea-4e68e24b2195@redhat.com>
	<CAFEAcA8eNv0qRvULid3ungYGQXxvO3kN6uhBT07OFEHaL0864g@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <416f8017-31db-5833-f74e-67193880edb4@redhat.com>
Date: Fri, 17 Feb 2017 09:55:23 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8eNv0qRvULid3ungYGQXxvO3kN6uhBT07OFEHaL0864g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gPTCbgQdxLej2pepRfBfjvcfldBiGJt0G"
Subject: Re: [Qemu-devel] [PATCH] Makefile: Put VERSION info into
 version.texi rather than using -D
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "patches@linaro.org" <patches@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gPTCbgQdxLej2pepRfBfjvcfldBiGJt0G
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <mlureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "patches@linaro.org" <patches@linaro.org>
Message-ID: <416f8017-31db-5833-f74e-67193880edb4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Makefile: Put VERSION info into version.texi
 rather than using -D
References: <1487344340-30471-1-git-send-email-peter.maydell@linaro.org>
 <9d625bc9-4d35-a03b-03ea-4e68e24b2195@redhat.com>
 <CAFEAcA8eNv0qRvULid3ungYGQXxvO3kN6uhBT07OFEHaL0864g@mail.gmail.com>
In-Reply-To: <CAFEAcA8eNv0qRvULid3ungYGQXxvO3kN6uhBT07OFEHaL0864g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 09:52 AM, Peter Maydell wrote:

>>>  Makefile               | 17 ++++++++++-------
>>>  docs/qemu-ga-ref.texi  |  2 ++
>>>  docs/qemu-qmp-ref.texi |  2 ++
>>>  3 files changed, 14 insertions(+), 7 deletions(-)
>>
>> Missing a change to .gitignore for version.texi.
>=20
> Should be
> --- a/.gitignore
> +++ b/.gitignore
> @@ -107,6 +107,7 @@ docs/qemu-ga-ref.info*
>  docs/qemu-qmp-ref.info*
>  /qemu-ga-qapi.texi
>  /qemu-qapi.texi
> +/version.texi
>  *.tps
>  .stgit-*
>  cscope.*
>=20
> right?

Yes, that looks right.

(Hmm - another file stuck in the top-level directory; a separate patch
might be worth sticking some of these generated .texi files under docs/
instead)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--gPTCbgQdxLej2pepRfBfjvcfldBiGJt0G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpxzrAAoJEKeha0olJ0Nqc9AIAJvm0VjzIoQ5D6QvP1DWhSzo
52ihA0h99P5vcq2c3VgM2dyzUidoXR9rqXxVYSjP45D01j0wNrQ5rBQcwJkJsTdR
2M2JMV9YzC4ijGEChoPlzf6aUqhuYEN7eRsY+AkEFutpqL2Xat+QAIfzqcxpKIq5
dLTxQqiQ/JjE2QIYuZDUMNUVFHWhj1m83lgbSsKxIpSHqN93QTBQ8OrLbA8T/FYA
AjKFqPqeB6Msy12qixP2JhcsZGYfrF+kcXgdxDgDg8M1/EfkM05bkZSI1LXZBzwA
5d22diysQFcfRkvVeEk18/59xY+TqPj3ET5ChS9Xdhcv7hY01uQP06nMA3wFiUI=
=Of5i
-----END PGP SIGNATURE-----

--gPTCbgQdxLej2pepRfBfjvcfldBiGJt0G--
