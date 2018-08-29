Received: from eggs.gnu.org ([2001:4830:134:3::10]:39054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuxB6-0005Yy-LN
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fux3b-0006wf-Hd
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 05:46:36 -0400
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-30-mreitz@redhat.com>
	<w514lfesjim.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <31b34e91-5608-706a-5ee0-3cb330df0136@redhat.com>
Date: Wed, 29 Aug 2018 11:46:28 +0200
MIME-Version: 1.0
In-Reply-To: <w514lfesjim.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6W2VKlVB61yH0hgRd2zlpyWyv2Pgs9phC"
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 29/31] block/null: Generate
 filename even with latency-ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6W2VKlVB61yH0hgRd2zlpyWyv2Pgs9phC
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <31b34e91-5608-706a-5ee0-3cb330df0136@redhat.com>
Subject: Re: [PATCH for-3.1 v10 29/31] block/null: Generate filename even with
 latency-ns
References: <20180809213528.14738-1-mreitz@redhat.com>
 <20180809213528.14738-30-mreitz@redhat.com>
 <w514lfesjim.fsf@maestria.local.igalia.com>
In-Reply-To: <w514lfesjim.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-28 15:33, Alberto Garcia wrote:
> On Thu 09 Aug 2018 11:35:26 PM CEST, Max Reitz wrote:
>> While we cannot represent the latency-ns option in a filename, it is n=
ot
>> a strong option so not being able to should not stop us from generatin=
g
>> a filename nonetheless.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> I thought I had reviewed this one already ?

Hm, maybe I forgot to add your R-b tag?  Or maybe there was some
non-trivial rebase change...  I don't know.

Max


--6W2VKlVB61yH0hgRd2zlpyWyv2Pgs9phC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGa3QACgkQ9AfbAGHV
z0DGUAgAmH2Ft1yEK9k9y/w8w16/dk55rcMqRxP1NfE1r9pEXPooauWgQFdxpF2Y
GoZzP0Nx32SqVQb3RgUGAvX4cGV9SVeFIS07Znr0wKbLf33INe2jCOyfQ+XO89Gk
QaSaeiCTtoTp0oTj7FQyasPO4zNocOEJ87UY793ZUuv9oANuqoWt9TTm1Jyyp+iM
unrW7UhKdf1PuUdQLKWJ2tiuBaFunPcyCeaFPuj3Q+SGwCv9o0ib+lhDiO5wBotr
bLldl8dswwPf4ZvFYxLfJ8sNA6BF6Aa8dYcCvw39+qhtkVkwxClRAX6wMc+ezqC+
7AtvT5aeiGhLqUDBhX1zgDh/zBpCxw==
=sM7g
-----END PGP SIGNATURE-----

--6W2VKlVB61yH0hgRd2zlpyWyv2Pgs9phC--
