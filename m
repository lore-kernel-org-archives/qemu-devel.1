Received: from eggs.gnu.org ([2001:4830:134:3::10]:54868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dj4n0-0002Vj-Pm
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 10:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dj4mz-00030d-RB
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 10:31:50 -0400
Date: Sat, 19 Aug 2017 17:29:47 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170819142947.e5xqkmfe6kssot3f@postretch>
References: <cover.1502979710.git.berto@igalia.com>
	<427228619067b0a029d2ae7706a3743a6da38128.1502979710.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ydkuinabld37qako"
Content-Disposition: inline
In-Reply-To: <427228619067b0a029d2ae7706a3743a6da38128.1502979710.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] throttle: Fix wrong variable name in
 the header documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--ydkuinabld37qako
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2017 at 05:28:12PM +0300, Alberto Garcia wrote:
>The level of the burst bucket is stored in bkt.burst_level, not
>bkt.burst_lenght.

s/lenght/length, otherwise:

Reviewed-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>
>Signed-off-by: Alberto Garcia <berto@igalia.com>
>---
> include/qemu/throttle.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
>index d056008c18..66a8ac10a4 100644
>--- a/include/qemu/throttle.h
>+++ b/include/qemu/throttle.h
>@@ -63,7 +63,7 @@ typedef enum {
>  * - The bkt.avg rate does not apply until the bucket is full,
>  *   allowing the user to do bursts until then. The I/O limit during
>  *   bursts is bkt.max. To enforce this limit we keep an additional
>- *   bucket in bkt.burst_length that leaks at a rate of bkt.max units
>+ *   bucket in bkt.burst_level that leaks at a rate of bkt.max units
>  *   per second.
>  *
>  * - Because of all of the above, the user can perform I/O at a
>--=20
>2.11.0
>
>

--ydkuinabld37qako
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmYS1sACgkQc2J8L2kN
9xASnQ/9GWtUCEAyGsv85iohLec9LT0iZqSyVQkZs3nkb6X3o1nPjS/dGcG43cqd
8vBmOQZ8AewUPhkQOzalmQjIvzFk7XTjKF2tLXBYH8F/ORo3wixguBuum22kZw4l
JTZ7Qq//B+kUyi6ZSy3Egu5AvsVcVxyTXZBAP7hUdz+9ZL2YNZUlf0LChQkhPJPj
cCLWWoe6bfSLsBWUqcqF93VeHr1mWR1wg4kCxcyxf6l8l02RFkivBpSYlBGXVOay
Li8jlnxU/EsTVwgc3pfCZnFV+hcZcYmi04fwlU3QCBhpafA5fNq7G/owcD4a0yRu
H5lfr1tgFsG1uxbgoHh3Sdodm0EVMZgEszEtVBxv/gC/7plD0MzoUa4Xc3hbiEl5
J83MZgyUemzvRTC+r38m92IeluzMWxCxjSV849j3ha2t/CSHbgUg2IEGj1wdyC5h
Ufzh23KaV2jSykL5djxKzQ1/soNoBwP3fbt91b3xZigr7Mcb/ek5Jskg6tAL6X5s
vER3CRHsM+DW7O5voQesBbf3yj9MzRJWSjXzdvp00J27cRASuB2sghWe+te99FUj
Psz+cxMXhU5mbaOTBE3HMStY9DCZARALzltv/sLf1nIvq3kngUgF6lCxjKMCT+xO
EdeWWtvAWGf5ngJLwc3eeszXPHcNmpE0bdWwWM+QBnXUDplxkLI=
=KSkT
-----END PGP SIGNATURE-----

--ydkuinabld37qako--
