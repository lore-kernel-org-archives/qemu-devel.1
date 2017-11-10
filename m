Received: from eggs.gnu.org ([2001:4830:134:3::10]:49284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDHfn-0001Fd-GA
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDHfm-0000j8-7g
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:21:15 -0500
References: <20171110221329.24176-1-mreitz@redhat.com>
	<20171110221329.24176-4-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bca02e7e-3a75-0f37-eebd-7b5a948109b6@redhat.com>
Date: Fri, 10 Nov 2017 16:21:05 -0600
MIME-Version: 1.0
In-Reply-To: <20171110221329.24176-4-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3E7AgJUL4PDG2uEXMg9Bl7UdkAFw4SAxW"
Subject: Re: [Qemu-devel] [PATCH for-2.12 3/3] block: Deprecate "backing": ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3E7AgJUL4PDG2uEXMg9Bl7UdkAFw4SAxW
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <bca02e7e-3a75-0f37-eebd-7b5a948109b6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 3/3] block: Deprecate "backing": ""
References: <20171110221329.24176-1-mreitz@redhat.com>
 <20171110221329.24176-4-mreitz@redhat.com>
In-Reply-To: <20171110221329.24176-4-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 04:13 PM, Max Reitz wrote:
> We have a clear replacement, so let's deprecate it.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qapi/block-core.json | 4 ++--
>  block.c              | 4 ++++
>  qemu-doc.texi        | 7 +++++++
>  qemu-options.hx      | 4 ++--
>  4 files changed, 15 insertions(+), 4 deletions(-)

Dan has more details on the proper documentation to tweak when declaring
something deprecated.  So this patch is incomplete, but what you have
makes sense.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3E7AgJUL4PDG2uEXMg9Bl7UdkAFw4SAxW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloGJlEACgkQp6FrSiUn
Q2oYPggAjjphvSe7IN9tLMCsWiMyAyXcdWemGhtPZhV2wSq9ZWUa2UlZUBKdr8lw
VE8YmDINSEf9wfmYE5fOrISITA9U5NcARBdYJMiZM57lNKHi1awypedX6HyOpKBE
qX1QVroZRvf1uuKVeKLcpgi75J/zVsnL1Z/FqXpVvDUEoU0Sk9Mw3qHvakj6GEYx
KCgmj1NZpQHHIZ8QGAT76129sKMs9Rkgt+zDyEpc2h2RsBvZQryEAtG9aB70rBO8
zFilUk5JGWRI6esSOtNb6MLROG9xS9BOSSMQvkolVwUF7Zc4vELaUIPlI6XvZUD1
SV6rs9+vy+rjKdfIS1+W/UFmzYbUEw==
=56OK
-----END PGP SIGNATURE-----

--3E7AgJUL4PDG2uEXMg9Bl7UdkAFw4SAxW--
