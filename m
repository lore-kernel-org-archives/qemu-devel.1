Received: from eggs.gnu.org ([2001:4830:134:3::10]:41835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdEM5-0000DC-SL
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 08:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdEM0-0003TW-Vl
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 08:36:25 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:47054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fdEM0-0003SB-Ol
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 08:36:20 -0400
Received: by mail-wr1-x435.google.com with SMTP id s11-v6so18003538wra.13
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 05:36:20 -0700 (PDT)
Date: Wed, 11 Jul 2018 13:36:12 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711123612.GB31228@stefanha-x1.localdomain>
References: <BN7PR08MB4868C0F99A12534DE079C256C6410@BN7PR08MB4868.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <BN7PR08MB4868C0F99A12534DE079C256C6410@BN7PR08MB4868.namprd08.prod.outlook.com>
Subject: Re: [Qemu-devel] [BUG] checkpatch.pl hangs on
 target/mips/msa_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2018 at 03:35:18PM +0000, Aleksandar Markovic wrote:
> If  checkpatch.pl is applied (using switch "-f") on file target/mips/msa_=
helper.c, it will hang.
>=20
> There is a workaround for this particular file:
>=20
> These lines in msa_helper.c:
>=20
>         uint## BITS ##_t S =3D _S, T =3D _T;                            \
>         uint## BITS ##_t as, at, xs, xt, xd;                        \
>=20
> should be replaced with:
>=20
>         uint## BITS ## _t S =3D _S, T =3D _T;                           \
>         uint## BITS ## _t as, at, xs, xt, xd;                       \
>=20
> (a space is added after the second "##" in each line)
>=20
> The workaround is found by partial deleting and undeleting of the code in=
 msa_helper.c in binary search fashion.
>=20
> This workaround will soon be submitted by me as a patch within a series o=
n misc MIPS issues.
>=20
> I took a look at checkpatch.pl code, and it looks it is fairly complicate=
d to fix the issue, since it happens in the code segment involving intricat=
e logic conditions.

Thanks for figuring this out, Aleksandar.  Not sure if anyone else has
the apetite to fix checkpatch.pl.

Stefan

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRfm8AAoJEJykq7OBq3PId8IH/2Rq+TUYZTrV2GkomVLHTLW6
frlH/vo6AgIKOwcuhWfvV043drF84bGH4zK4NhOrzxvRPc4kW5E/LwEicXDWqQug
vETgFNdtGu+9aC290UPodouogo/qoXXfb9h2fWtaKwzp2kcuYDXXCUpm6VpoCJvS
gTgTFv22SAK4J5SBVRmsGymLk2BnGWliTmJwR1BF49Vz2f+wJY/EKHspa7kVWyac
tywEIiE/q4ELWHrN8tAcMa6bR6AGayQfVFpRbE1PSW/l/H3ArejePqIQfgJDxEbD
e51OZ4EPvBb19RHGwwgsuRU8YLjrpcSa1o9a/I0NWSgszKwnpmS1gn5vO4xIhM8=
=7h/0
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
