Received: from eggs.gnu.org ([2001:4830:134:3::10]:35266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9Vzy-0000d4-F3
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f9Vzx-00012V-OX
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:22:46 -0400
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-3-mreitz@redhat.com>
	<w51zi1yw0cj.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bdaeb251-037d-97cc-da77-6bec353434fc@redhat.com>
Date: Fri, 20 Apr 2018 15:22:37 +0200
MIME-Version: 1.0
In-Reply-To: <w51zi1yw0cj.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ufyiISuybzoavh6EwUtL633my5yQzKMPi"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/9] block: BLK_PERM_WRITE
 includes ..._UNCHANGED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ufyiISuybzoavh6EwUtL633my5yQzKMPi
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <bdaeb251-037d-97cc-da77-6bec353434fc@redhat.com>
Subject: Re: [Qemu-block] [PATCH 2/9] block: BLK_PERM_WRITE includes
 ..._UNCHANGED
References: <20180416165849.28864-1-mreitz@redhat.com>
 <20180416165849.28864-3-mreitz@redhat.com>
 <w51zi1yw0cj.fsf@maestria.local.igalia.com>
In-Reply-To: <w51zi1yw0cj.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-20 14:04, Alberto Garcia wrote:
> On Mon 16 Apr 2018 06:58:42 PM CEST, Max Reitz wrote:
>> Currently we never actually check whether the WRITE_UNCHANGED
>> permission has been taken for unchanging writes.  But the one check th=
at
>> is commented out checks both WRITE and WRITE_UNCHANGED; and considerin=
g
>> that WRITE_UNCHANGED is already documented as being weaker then WRITE,=

>> we should probably explicitly document WRITE to include WRITE_UNCHANGE=
D.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
> s/then/than/ as Stefan mentioned.

Yep, will fix.


Thanks for reviewing!

Max


--ufyiISuybzoavh6EwUtL633my5yQzKMPi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrZ6Z0ACgkQ9AfbAGHV
z0Bs4Af9Hdsofu1N/Qi7G+jmIzOGPsoSs7AZHJeQtqILYEcU7dwJaZKctnfjScyy
MxRs/oCs+yZfeBPQBQsxCJJrnt7pBieVyilM6GTMXKJkN9swqjv5Jcomh14QeXzq
md5xrNc1XdljwTL473S9OUFCabtIgOMEl0GEQ7j9GekYup/HBV8P/27dvQFPq5qj
JoUwtXC8R/Uy7ypgb7D8+N5HYEADO7VdMLrlONdYwcvm+xdnQkS6wuwzW5Y9V5/Z
bhApOsEAacv7qNF8bo7BQi2EiK77hbqnNsBZUSDIQygbOkZ+U42sTCRQq9CQo5E7
4gzNMwVzK+ASS/yIaZySQguc6PoBFQ==
=Xh8C
-----END PGP SIGNATURE-----

--ufyiISuybzoavh6EwUtL633my5yQzKMPi--
