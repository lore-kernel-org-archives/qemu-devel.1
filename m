Received: from eggs.gnu.org ([209.51.188.92]:46532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grjQY-0001aY-Nh
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:09:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1grjQX-0003rU-SI
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:09:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1grjQX-0003qe-Ig
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 08:09:13 -0500
References: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
	<20190207114913.2c5f2c5b.cohuck@redhat.com>
	<6c5ac94e-065f-e66a-2df2-5d8ac81c76e1@debian.org>
	<ffb48b9f-fc99-0766-925c-4f79c692cba7@redhat.com>
	<1a3f847e-a371-eacb-8be6-678bb3c20b05@debian.org>
	<951bf77e-f953-48aa-9e2e-3f7c66bb9db2@redhat.com>
	<78990142-121a-f84d-811b-60ec503f394b@linaro.org>
	<175f1e54-4517-d815-f6ac-566be14bfc3a@debian.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aca8026e-4463-a09e-d9bd-2df0791d1fb9@redhat.com>
Date: Thu, 7 Feb 2019 14:09:00 +0100
MIME-Version: 1.0
In-Reply-To: <175f1e54-4517-d815-f6ac-566be14bfc3a@debian.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="MHC3Lsh6painQNpwT8FqRmOrHNO0MabLj"
Subject: Re: [Qemu-devel] [Bug 1815024] [NEW] SIGILL on instruction "stck"
 under qemu-s390x in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Giovanni Mascellani <gio@debian.org>, Richard Henderson <richard.henderson@linaro.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Bug 1815024 <1815024@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MHC3Lsh6painQNpwT8FqRmOrHNO0MabLj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2019-02-07 14:00, Giovanni Mascellani wrote:
> Hi,
>=20
> Il 07/02/19 13:15, Richard Henderson ha scritto:
>> See also
>>
>>   https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg06734.html
>>
>> which I never followed up on the review changes requested.
>=20
> I can confirm that both patches (Thomas' and Richard's) work for me.
> Although they produce rather different results:
>=20
>  Thomas' patch:   around 6346926678828662276
>  Richard's patch: around 9048173079139739571
>=20
> They also appear to grow at different speeds, if I am not mistaken. I
> have no idea of what is correct, because I do not know s390x.

Both are wrong. I missed to add the TOD_UNIX_EPOCH offset, and Richard
missed to use the time2tod() conversion.

Anyway, I yield to Richard's patches since he posted his patches first
(unless he does not have any spare time to work on it at all, then I
could have another look).

 Thomas


--MHC3Lsh6painQNpwT8FqRmOrHNO0MabLj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcXC3yAAoJEC7Z13T+cC21jjYP/iGEaaGSIUsav6lmI34RlVWu
IQz8VDUf7MGqW7r/7UT3ykVzM3iaVNjgpKk8tuboinQUYXtPgekf+0qwsDpmH8+0
Wk/x7UkJvg8950T9QDjQfi8lw41DthvI43zN03rurebgvsPhPRVemo2a67Otya7N
5oC6d1XEPTDjZtnUJEEuQpjmX0oNs/GvoeMDuQ+cUlo4TlrUIdbkXq+GKawVVUvx
q1hyhhBOz5aI3adhaIjbp+ZKN3+4hdxFrLgpu9DSsgusv76uVTOk3+/u3ltYuD9Q
QqrJrgCvop9RVl6CHVPyM4EdojGyHquy/bWiQbLjfesFx9L9NxaiDtz3LkwXfADI
CvKfAB/VPhiqmHOwfjGHv68CavEDIReNe1hAmYpmXFqvXe7DU4d/XmGmldjin+O+
0TXrMIJblltbNx8rOAOC9JsQ0QTGI+xXrNw4wJKnFti4N7rcM2CaBWw9WpASaQQJ
gp1pJVjGeRpHW/6LYnuXTVjwRv6Ew7Cj6/qyxyRbNXjlxYLkks8xhBoCJuHqMd2G
O9Elmu6fadklJU4U+q3qdzavkiE6Cb/7gWD2/ByzZ8M4+mJu8iwJVORiCuaBz4fN
0JIWnt8RHQKEO3Ro9prgvBesV5vtIXoXic0CQ2SoXVPzymVr5QZ9LW8UTCzgrn28
jwGL20V62oTfhgPNWkIE
=eeAa
-----END PGP SIGNATURE-----

--MHC3Lsh6painQNpwT8FqRmOrHNO0MabLj--
