Received: from eggs.gnu.org ([2001:4830:134:3::10]:56470)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dbram-0003Gp-Gy
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 13:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dbraj-00027k-ED
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 13:01:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:59630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dbraj-00027M-3M
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 13:01:21 -0400
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
	<CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
	<cf854184-8bc0-4a9c-b97f-8274abf538bc@amsat.org>
	<20170729135042.GA1139@pks-xps>
	<CAFEAcA_gG=pukiHmhW5kMDu0sUxRL8Yp5H5=XA0gKbTSVuNBpQ@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <192810b2-02a2-fbbc-fc1e-7e9d3d80d7fa@gmx.com>
Date: Sun, 30 Jul 2017 18:51:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_gG=pukiHmhW5kMDu0sUxRL8Yp5H5=XA0gKbTSVuNBpQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C4REDu8qHnRMg7pQ8GGwi94OFk0vVrG7a"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: include <linux/limits.h> for
 XATTR_SIZE_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Patrick Steinhardt <ps@pks.im>
Cc: Alistair Francis <alistair23@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C4REDu8qHnRMg7pQ8GGwi94OFk0vVrG7a
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>, Patrick Steinhardt <ps@pks.im>
Cc: Alistair Francis <alistair23@gmail.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Fam Zheng <famz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Message-ID: <192810b2-02a2-fbbc-fc1e-7e9d3d80d7fa@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] 9pfs: include <linux/limits.h> for
 XATTR_SIZE_MAX
References: <07010a2ad79559c412949f0005dbe3cb03d8416e.1498504812.git.ps@pks.im>
 <CAKmqyKPZ3+ohCvpzbw=MyLpgB5cFKQosBJNsaWcoT=yWp1c9Mw@mail.gmail.com>
 <cf854184-8bc0-4a9c-b97f-8274abf538bc@amsat.org>
 <20170729135042.GA1139@pks-xps>
 <CAFEAcA_gG=pukiHmhW5kMDu0sUxRL8Yp5H5=XA0gKbTSVuNBpQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_gG=pukiHmhW5kMDu0sUxRL8Yp5H5=XA0gKbTSVuNBpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.07.2017 21:34, Peter Maydell wrote:
> On 29 July 2017 at 14:50, Patrick Steinhardt <ps@pks.im> wrote:
>> On Fri, Jul 28, 2017 at 02:20:49PM -0300, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>> This is likely to break on BSD, but now than patchew has a NetBSD job=

>>> you can trigger a build RESENDing this patch.
>=20

I just checked patchew, and there is FreeBSD job. How far are we from
adding more BSDs?


--C4REDu8qHnRMg7pQ8GGwi94OFk0vVrG7a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZfg6pAAoJEEuzCOmwLnZsCMIP/22Qc6VH3g9gf+++hXuNZm1J
M2YbsQmG2OT10mXyPrQ97FuSmXaQR2N4js2y4ZR6cTt3f4YIReC6o+SkePiC0vQz
WAama3wQuQ0YFh5fpj6RXqTFlEdzgBymJtjtGpFge+E7jk9QDEFRqgBtewgbD7fa
0Om3yLM4TrvWzaM8JqNmPc66vXy3dxlcHFITnKDSIdnuVoT6kqXJZvUTinbtytv8
0igj7ZJ1v+u6Y+F2myWkVwrkW+KOGqYIyYmv/c+k+0AIhKdD2EAYD85eM85fdUe5
OX8/DRcNPmDSxW8RR3nWmqmf9jrO33ZTvC256AUcoRg0esRuhALbgeCE5e7SZNFa
E+3/zZ0T0Qz26ij09mWG74C62ZFn0gzS6aN1Z1bI8k5pDcPRixInEWeaeGkxw8PN
gK9zdmXRwkdgw6MPuOtBWHpBNo/lnC+W6PQdDzLaDCqY1hRv+Qw5v059LIZvSwYS
vlvvSwnt9/DNjjKDir1FjNhkB5lSzpJVTebnAmnqsrdZXUgnDR/PCYV48WNqJs0s
ctwZ2ijOShGuttfjUKLXPqx0RwqpwhkQI7YLrpS/Su6AYIZFUXzBU97EYKFMI522
igOMDBl3jYawvVjS3VOfZDaYwi1V3NmUCCZd9dPq1gYIlkZeLoIcfrSsyWE5K98I
bOh7MKlpego12ugdVHXw
=maSX
-----END PGP SIGNATURE-----

--C4REDu8qHnRMg7pQ8GGwi94OFk0vVrG7a--
