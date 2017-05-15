Received: from eggs.gnu.org ([2001:4830:134:3::10]:52722)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dAGdV-0004no-8k
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dAGdS-00033l-3q
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:06:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:62243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dAGdR-00032u-OV
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:06:06 -0400
References: <20170513015449.24061-1-n54@gmx.com>
	<91e1cbd3-88e6-2b7a-c4e4-824c54f34c52@amsat.org>
	<4245846f-2977-6f1b-a5a0-80d92bfe42d4@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <2d7184c3-1523-c470-3930-63a8d0cfe448@gmx.com>
Date: Mon, 15 May 2017 15:57:39 +0200
MIME-Version: 1.0
In-Reply-To: <4245846f-2977-6f1b-a5a0-80d92bfe42d4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o4TCqhMHMTIj6PbgoC0q2kVofMtIjR5nu"
Subject: Re: [Qemu-devel] [PATCH] libvixl: Correct ordering of includes and
 fix NetBSD build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, claudio.fontana@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o4TCqhMHMTIj6PbgoC0q2kVofMtIjR5nu
From: Kamil Rytarowski <n54@gmx.com>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, claudio.fontana@gmail.com
Message-ID: <2d7184c3-1523-c470-3930-63a8d0cfe448@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] libvixl: Correct ordering of includes and
 fix NetBSD build
References: <20170513015449.24061-1-n54@gmx.com>
 <91e1cbd3-88e6-2b7a-c4e4-824c54f34c52@amsat.org>
 <4245846f-2977-6f1b-a5a0-80d92bfe42d4@redhat.com>
In-Reply-To: <4245846f-2977-6f1b-a5a0-80d92bfe42d4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.05.2017 15:57, Eric Blake wrote:
> On 05/13/2017 05:04 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Kamil,
>>
>> I think it is safer to add it in disas/libvixl/Makefile.objs where
>> QEMU_CFLAGS are tuned for libvixl.
>> This way you don't need to modify upstream libvixl.
>>
>=20
> Ah, right. disas/libvixl is one of the directories exempt from our
> normal rules of including osdep.h first (otherwise I would have said
> that including stdint.h first should be the job of osdep.h).
>=20
> But indeed, that's because we are trying to leave libvixl as untouched
> as possible, so if there IS a solution that can be done through
> makefiles rather than direct file editing, it is worth considering.
>=20

http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg03321.html


--o4TCqhMHMTIj6PbgoC0q2kVofMtIjR5nu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZGbPbAAoJEEuzCOmwLnZsPikP/03i0nzYRrFGiISNDU9KmpzH
4iIhLqc7RnnsGZX2csUOeDE+9EH2rGDmyNeCJin/hjCa3sQZgQnh07d3fJRmUShe
I2jNl/7ekoc/+vBOC45ddKLP+ZJ7P5hr4f7JIO4DviPYnOIlmgeR/nWgzuO4X9ab
v+DBq6M0QyJ1tc6iwZ+u9mlwjGQOq65hGWyg0ll+/7II324EXNvBmuuXuuBaOyK2
f1+fNEXVutnSWWB6bSI3PsxtU/LDQ0OL9VG4VB3DAmayK+ADi557I+RUFa94n288
SHQxbAx8fNujzdkviMq3sIZBVaFQoS6zdI0ofXCSFvQ0yeYc6hLO5OyUJFyugGuB
+BesZjULy46iUblJe4QdM3OTRkfwm1oXKJlrXgbAkP1uQooLTMR32MS7yPeFq62Y
pxMR7YcoT/WPzmgJGmyaUXANOKuF/AviWnxY5ErK/yaBmQz8OpBpcsGdbdt+T7bD
CYUIfficxB0QjhDGHMbiqdQcGhtSJpNP5y7PUfKmDHfOkrWH6Ziux6aaPdx7Ugiz
11+S3GFKt66e4zAMUkvjJhvVLhcIfpCaezJEoB0bL+rXxS87Jxdvq//+EGesiMzQ
Mg/nzAtZ/agJo3n7snbP4//QHHrkkrtkcJ69Xu+5ZgHU7l7Xs4lgq1Bom6likfnD
R26WRWVCVXfekYUIvCMu
=59pz
-----END PGP SIGNATURE-----

--o4TCqhMHMTIj6PbgoC0q2kVofMtIjR5nu--
