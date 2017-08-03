Received: from eggs.gnu.org ([2001:4830:134:3::10]:53337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1ddG8T-0005ey-4m
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1ddG8M-0005JO-Cj
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:25:57 -0400
Date: Thu, 3 Aug 2017 16:24:55 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170803132455.bth53wkxr35imfhd@postretch>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-8-el13635@mail.ntua.gr>
	<20170803080750.GB4456@dhcp-200-186.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4b6ytcqqh3qigvbi"
Content-Disposition: inline
In-Reply-To: <20170803080750.GB4456@dhcp-200-186.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 7/7] block: add throttle block filter
 driver interface tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--4b6ytcqqh3qigvbi
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2017 at 10:07:50AM +0200, Kevin Wolf wrote:
>Am 31.07.2017 um 11:54 hat Manos Pitsidianakis geschrieben:
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>
>I would add at least two more cases:
>
>* Both limits and throttle-group are given in blockdev-add
This exists in the "property changes in ThrottleGroup" section,

>* limits and throttle-group are both missing
this creates an anonymous group with no limits. Should we fail at this=20
case?=20
>
>It would also be nice to test that query-block reflects the new throttle
>group limits correctly when they are changed after the fact.

This belongs to the remove legacy patch, since query-block displays the=20
legacy limits.

--4b6ytcqqh3qigvbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmDJCcACgkQc2J8L2kN
9xALhhAA1qVd4K/cHrwRdtbjrf2/Sgy0c67rPCfIMCQy28SfgF8veoTm6hQY+M5G
E/cHTUoW34etNV6XAJI7IeSu9yPyxJDxE3jnVNZnEGMASOObaEDbOA7JY1uT6FVK
H0u4+Hy2hylosWcJEXjQUe9E6nAOyfkp/TyzMy2vKAjxJZTVa/XwVxieHpBsy5bw
KeB7r6sjeB34DInI2AQ/OxTs0Nif/dLy6nIEAtnqrqrUoEw85CEkg7OUpQR3eZWQ
fXf/gBNQd6aUdjegKIZkiQBy2btw+/Xgt5ayzoaWZkyKvbsJMTerr4vlBUr8ho6o
dVP/iiFsRnLba2npiyYwu0Em6BfE4ylOzDMv8WgHCRoFEO6glgpfsjlNfbFKzDyb
i4OdPwWOrfTSIRwYGGHyr9hRwM1ugBLz70VcOtltY7R1RWNraqjv+KSlm7UeVHNb
Op1r1lVZte/InQPXvb4/P87QU0QYhN1Vd4B9/MnRwTXRLFX6dTzQAtfY9MxeUVSN
5QvsatVKWFSbG9zmQez/VNmH1SGI9XdJ+Gr+Mcxy+V7jJs11zwVUaeHSagjTFGAP
uYDiEYivaWRAfes0VUOgJKymnQtRY0VzZOoslpadWtP1tEA5NIws/ptNW0TZvCO1
IxIO5wsWoVGvQLPD3t4f6mIoIYZmNbN0OFTrkaNsx2ImJq8pjSo=
=L5Dd
-----END PGP SIGNATURE-----

--4b6ytcqqh3qigvbi--
