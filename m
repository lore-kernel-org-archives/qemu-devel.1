Received: from eggs.gnu.org ([2001:4830:134:3::10]:36208)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1etVZD-0004NK-0o
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1etVZ7-0000mK-C8
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:40:59 -0500
Received: from mout.gmx.net ([212.227.15.19]:56683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1etVZ7-0000m3-1k
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 04:40:53 -0500
References: <23118.27370.136663.284087@guava.gson.org>
	<143c7064-8a4d-6f78-6d50-ed10096ddd3b@gmx.com>
	<5b3a1a64-2960-d120-08f4-e32227df2712@amsat.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <be9f3093-fa6e-ec5b-4bba-4f0e1ef74342@gmx.com>
Date: Wed, 7 Mar 2018 10:42:03 +0100
MIME-Version: 1.0
In-Reply-To: <5b3a1a64-2960-d120-08f4-e32227df2712@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3JRvCgSMmp5IJOTqGFwiTepSojx30Xh2l"
Subject: Re: [Qemu-devel] [PATCH] slirp: disable Nagle in outgoing
 connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Andreas Gustafsson <gson@gson.org>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3JRvCgSMmp5IJOTqGFwiTepSojx30Xh2l
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andreas Gustafsson <gson@gson.org>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <be9f3093-fa6e-ec5b-4bba-4f0e1ef74342@gmx.com>
Subject: Re: [Qemu-devel] [PATCH] slirp: disable Nagle in outgoing connections
References: <23118.27370.136663.284087@guava.gson.org>
 <143c7064-8a4d-6f78-6d50-ed10096ddd3b@gmx.com>
 <5b3a1a64-2960-d120-08f4-e32227df2712@amsat.org>
In-Reply-To: <5b3a1a64-2960-d120-08f4-e32227df2712@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.03.2018 10:38, Philippe Mathieu-Daud=C3=A9 wrote:
> On 03/07/2018 06:13 AM, Kamil Rytarowski wrote:
>> This patch is correct. LLDB expects 1sec for reply, GDB by default 2.
>>
>> Debuggers use this option to disable Nagle algorithm in order to quick=
ly
>> transfer messages between gdb-server and gdb-client. It's also fairy
>> portable across systems.
>>
>> On 04.01.2018 18:56, Andreas Gustafsson wrote:
>>> slirp: disable Nagle in outgoing connections
>>>
>>> When setting up an outgoing user mode networking TCP connection,
>>> disable the Nagle algorithm in the host-side connection.  Either the
>>> guest is already doing Nagle, in which case there is no point in doin=
g
>>> it twice, or it has chosen to disable it, in which case we should
>>> respect that choice.
>>>
>>> This change speeds up GDB remote debugging over TCP over user mode
>>> networking (with GDB runing on the guest) by multiple orders of
>>> magnitude, and has been part of the local patches applied by pkgsrc
>>> since 2012 with no reported ill effects.
>>>
>>> Signed-off-by: Andreas Gustafsson <gson@gson.org>
>>
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>=20
> I suppose you meant "Reviewed-by: Kamil Rytarowski <n54@gmx.com>"
>=20

Correct!

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>


--3JRvCgSMmp5IJOTqGFwiTepSojx30Xh2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlqfs+sMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsG+QP/i9QcdVG0TA3L2f456J5S6i9YBCeEHlNqNyKzBGl
tedqKJtkAXwFu8QjVz8LrOhzEP7uPKYIWMBgJGJOojXVIFRW7ytQ1jbtP/PfvT7B
jZ6EC5Jc+d50kPgIHRXFrZ5eJ3h0G5z7hHKMXxKBFK8iBUbiZfCprdbOtt0Qc7hl
teIQLLjEXZAHs+jU0whZYU5wIZYZjkvtVQo/Jg0Z4jsmTPK+BoDkfdGqCQ4BW1Wi
DVlsuhYif7l6EBzEt7OmsBAwXpiNpumu6Z/elOwZoAMWddydFxyVN0kKpp0U2T+j
hvcsVtxpKGfVnKsPqYOtK1qeQIGzPzM9Ci1+bS+q2EoiEecAVc2tgBSbybj7HfZr
o3ELjc0daC1P7Hm2DR2jbtruT9apAhcfDX/kBfQDlZVJP4Z2kZX0tiLP41EBkD2f
3CHgIxM8b0ghM5TWzu6blsqFQWTjtcjkMzjAC7vCgdjBtForaAqQgKFqmnDixqkO
+to6+sXkBC8yvpGHxNGMkt2UptKBCLHYmeBuenxlkUzeWWbCQqiPxJYAe3IMGbZJ
ZXIxhqunrqrfab2a63hjTUFqX500JsyPK3kqzATcxf21mZTAj+PxE8R/oBAt3arq
emF6XfZT6BTdDFRTgL5HupNRv8+mXwjYe7CnoL8uyJpzlFqOhUulwqKS3wZJ9gcd
M6It
=xpWV
-----END PGP SIGNATURE-----

--3JRvCgSMmp5IJOTqGFwiTepSojx30Xh2l--
