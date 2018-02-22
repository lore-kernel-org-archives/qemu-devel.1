Received: from eggs.gnu.org ([2001:4830:134:3::10]:42894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eorKX-0004n2-Et
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:54:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eorKU-0003Du-D6
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:54:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51062 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1eorKU-0003Df-7U
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:54:34 -0500
References: <20180207225540.31698-1-richard.henderson@linaro.org>
	<20180207225540.31698-20-richard.henderson@linaro.org>
	<ddb804a5-6c00-57c3-03ef-d77daedda511@redhat.com>
	<75fc3d37-b450-a61a-d7cc-a0052b1ad18b@linaro.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1699be51-cec5-204d-ec4b-5110e04909fb@redhat.com>
Date: Thu, 22 Feb 2018 14:54:26 +0100
MIME-Version: 1.0
In-Reply-To: <75fc3d37-b450-a61a-d7cc-a0052b1ad18b@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r6ycn8Cf2Z3Jeg3K7DwH1aG6NEVxSgA1f"
Subject: Re: [Qemu-devel] [PULL 19/20] tcg/i386: Add vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r6ycn8Cf2Z3Jeg3K7DwH1aG6NEVxSgA1f
From: Max Reitz <mreitz@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <1699be51-cec5-204d-ec4b-5110e04909fb@redhat.com>
Subject: Re: [Qemu-devel] [PULL 19/20] tcg/i386: Add vector operations
References: <20180207225540.31698-1-richard.henderson@linaro.org>
 <20180207225540.31698-20-richard.henderson@linaro.org>
 <ddb804a5-6c00-57c3-03ef-d77daedda511@redhat.com>
 <75fc3d37-b450-a61a-d7cc-a0052b1ad18b@linaro.org>
In-Reply-To: <75fc3d37-b450-a61a-d7cc-a0052b1ad18b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 21:22, Richard Henderson wrote:
> On 02/20/2018 08:44 AM, Max Reitz wrote:
>> This patch makes make check with clang -m32 fail for me.  (Interesting=
ly
>> enough, though, clang -m64 and gcc -m32 work fine.)
>=20
> What's really interesting is that gcc -m32 should *not* have worked, bu=
t does.
> I'm not sure why.  The assert is for the missing constraints for INDEX_=
op_dup2_vec.
>=20
> Will fix.

Thanks!

Max


--r6ycn8Cf2Z3Jeg3K7DwH1aG6NEVxSgA1f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqOy5ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/VMH/0CwAm4kiR7BPo2MDe7wkXdJwkxW9Jef
YdF1SvPCWqNCe6F4tQbTemf03ddq2c1Fc8nAwJx4umWBClNGWaXD12e5WI/tB71B
Z2bQFii28aSgVgyzQNF+ZKk/Rb1dQlcb94/PAFE8sRvuPwMjNGjJ62BpU2xwd5tr
QyO8og3HchOsP8P+6EBie7uZ3Ydoh+TSllS87QxBq5ndoJe2NBsPHcJ5Oq8GMWPT
d0oQ2SsE5yLoZ7ghi+9hS17YifKwZJ+DiJjuWMA+UFO/su2m4witFpE9wF365FdT
7yZn/+JA53X7AvsiSzAt3tKSOq23HWQ9W783EVEVf9ZeYoxdrdrgJrQ=
=ZxGz
-----END PGP SIGNATURE-----

--r6ycn8Cf2Z3Jeg3K7DwH1aG6NEVxSgA1f--
