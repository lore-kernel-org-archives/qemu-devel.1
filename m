Received: from eggs.gnu.org ([2001:4830:134:3::10]:42368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxzqE-0005ag-FO
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 14:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dxzqD-00056g-HB
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 14:16:50 -0400
References: <20170929170843.3711-1-mreitz@redhat.com>
	<cf6e8f28-760c-57ae-184b-d9b07c28f0f2@redhat.com>
	<c08cfd7e-c459-8ddf-a81c-fbe31ecfeac3@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a91edbef-e315-0843-ae9d-947e2b67fc86@redhat.com>
Date: Fri, 29 Sep 2017 13:16:40 -0500
MIME-Version: 1.0
In-Reply-To: <c08cfd7e-c459-8ddf-a81c-fbe31ecfeac3@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UHnvIVKUp7eeHK4RKXOi8OQNJMQctDe3R"
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Add test for dataplane
 mirroring
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UHnvIVKUp7eeHK4RKXOi8OQNJMQctDe3R
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Jeff Cody <jcody@redhat.com>
Message-ID: <a91edbef-e315-0843-ae9d-947e2b67fc86@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Add test for dataplane mirroring
References: <20170929170843.3711-1-mreitz@redhat.com>
 <cf6e8f28-760c-57ae-184b-d9b07c28f0f2@redhat.com>
 <c08cfd7e-c459-8ddf-a81c-fbe31ecfeac3@redhat.com>
In-Reply-To: <c08cfd7e-c459-8ddf-a81c-fbe31ecfeac3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/29/2017 01:08 PM, Max Reitz wrote:
> On 2017-09-29 19:33, Eric Blake wrote:
>> On 09/29/2017 12:08 PM, Max Reitz wrote:
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>> v3: Make the test actually pass (the reference output from v2 only
>>>     worked with v1 of the test...)

>>
>> Semantic conflict with Jeff's patches for './check -s' to preserve
>> intermediate files.  Otherwise,
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> True, but as long as v4 of his series is not around, I feel OK to put
> the burden of having to rebase on him. :-)

Indeed - I was pointing it out to Jeff (hence the CC) ;)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UHnvIVKUp7eeHK4RKXOi8OQNJMQctDe3R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnOjggACgkQp6FrSiUn
Q2p7MAgAqwmKnd7VTzV83Cs2Q6Qp7INg6J0XZ5zVdxVPTyER60J5BWBil2L2E/Si
3wyneS2hHWg12SacdX6aKxjFtIQdnwHwXIzuN6Uek+EdzOxn1Tghn3FGsKNXgkyp
WLQsOq2M5uVhk3tgapRrVjXb+eTzfW9v81eyXZg3+YWJRd52zYTU3nRtetIgYJo2
8OltIqYRdgKC/LAZZujyc/ikszyeXzHEJK0t38C+QTJsAYHcnQTK3hGWggUZDhsN
Gjakx9GRPBzJs3x9KaNbm6RIMqF/3VM2TKtTJ5EZcoML7kxCpeB0wCmX5cLAjZG3
GrGoNxRrLK4qxOnqZjy/9fkgDMMW/w==
=QQiC
-----END PGP SIGNATURE-----

--UHnvIVKUp7eeHK4RKXOi8OQNJMQctDe3R--
