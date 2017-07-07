Received: from eggs.gnu.org ([2001:4830:134:3::10]:42695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dTSVM-0003uJ-OK
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dTSVL-0005bv-Rm
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:37:04 -0400
Date: Fri, 7 Jul 2017 13:36:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170707123652.GC18375@stefanha-x1.localdomain>
References: <9307b70e9876c4e9e3c4478524a32a23a3d5dd05.1499368180.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <9307b70e9876c4e9e3c4478524a32a23a3d5dd05.1499368180.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] util/aio-win32: Only select on what
 we are actually waiting for
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, alistair23@gmail.com, edgar.iglesias@xilinx.com, qemu-block@nongnu.org, philippe@mathieu-daude.net, pbonzini@redhat.com


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 01:15:14PM -0700, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> Changes in V2:
>  - Rebase on master
> Changes since RFC:
>  - Include more bitmasks for the select call
>=20
>  util/aio-win32.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZX4BkAAoJEJykq7OBq3PIbboH/iMpHLE/Rlksz4NYbKsKb6qp
sauk/bIf4hKUr72H0ldoJSn3C1o1p8CpSQDF23FhHnFuaKeayCn730U4oPY9SeOB
uhE6bRn6SSqVhed880YC5EeAfWDJwmTYndMLOAb+s5QC5zStp6E/UVzYu9iMjJ7n
zRfXozv1vrW2i14f5XnMCgY7YNwqd+jfubhKHUV2mRh4XJiSCoQTMgJv83BmPU8y
Ip69HY/++hifMkQbJ9orrwe2p4zungOe5mz8QZ9APFGWfYvhas1erYWC1csF42+b
FsfeNF+zg2KZNMINAXTsbviTwSLGZZxVZMw1q6p3P8daHx6EiVbaB0n9NkkjjDs=
=V/MU
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
