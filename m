Received: from eggs.gnu.org ([2001:4830:134:3::10]:41948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4BZQ-000503-Id
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4BZP-0002RV-Mg
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:28:48 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-6-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <90b7a5bf-259b-47ef-d0cf-b64fc93bba47@redhat.com>
Date: Fri, 28 Apr 2017 21:28:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170427014626.11553-6-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QVSG8LCu8eaFc9TGM5uOj84Ax1HajvdxC"
Subject: Re: [Qemu-devel] [PATCH v10 05/17] iotests: Add test 179 to cover
 write zeroes with unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QVSG8LCu8eaFc9TGM5uOj84Ax1HajvdxC
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <90b7a5bf-259b-47ef-d0cf-b64fc93bba47@redhat.com>
Subject: Re: [PATCH v10 05/17] iotests: Add test 179 to cover write zeroes
 with unmap
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-6-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2017 03:46, Eric Blake wrote:
> No tests were covering write zeroes with unmap.  Additionally,
> I needed to prove that my previous patches for correct status
> reporting and write zeroes optimizations actually had an impact.
>=20
> The test works for cluster_size between 8k and 2M (for smaller
> sizes, it fails because our allocation patterns are not contiguous
> with small clusters).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v10: drop any changes to v2 files, rewrite test to work with updates
> earlier in the series, add a blkdebug probe
> v9: new patch
> ---
>  tests/qemu-iotests/179     | 123 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/179.out |  90 +++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 214 insertions(+)
>  create mode 100755 tests/qemu-iotests/179
>  create mode 100644 tests/qemu-iotests/179.out

Can I convince you to write this test in a different way? I really have
a hard time following all of the writes and building a mental image of
how the qcow2 file should look in the end so I can compare it to the map
output.

I'd like it better if you would check the qcow2 file after each group of
write operations, maybe even creating a new image for every such group.
But even just having more qemu-img map calls (and changing nothing else)
would help me a lot.

Max


--QVSG8LCu8eaFc9TGM5uOj84Ax1HajvdxC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDl+cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJQwIALMBb/m/9cxdjnWGStR6n6uhlWd4O7aK
ex6PdBlsDt/fTsOYpwj2M2x5T2lItnsgGiuh9jULHAM2VQZJBcrVcuyNftiaOuKP
XVTnGMA74Z44PD/OEiwJ4YX7CYwaoSdbBsWK8wlTQTnF4oSCaqhYa2AmeyyL1JcL
jxmL4H1nlnAJZORY4++jlY/4DOveWfka6GwCBuPQVd+v1ncwgumOgcgPCrMkPcOt
Co6/f/Q0zIe1+auB8JiPs0HCRcVpuiPJ2MwjY/18opYBFZOlySDDGQCks8NI87rm
uOUSSGkgrqA6gn3rKzim9q/CKrelTqsWWetkt8IkCsStGWmC0EaUvgs=
=87wm
-----END PGP SIGNATURE-----

--QVSG8LCu8eaFc9TGM5uOj84Ax1HajvdxC--
