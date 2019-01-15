Received: from eggs.gnu.org ([209.51.188.92]:40133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjPgz-0001lG-2I
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gjPgt-0001At-5r
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:27:48 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gjPgs-0001AJ-VI
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 09:27:43 -0500
Received: by mail-wr1-x442.google.com with SMTP id q18so3164343wrx.9
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 06:27:42 -0800 (PST)
Date: Tue, 15 Jan 2019 14:27:39 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190115142739.GD29056@stefanha-x1.localdomain>
References: <1547546927-18006-1-git-send-email-dimastep@yandex-team.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <1547546927-18006-1-git-send-email-dimastep@yandex-team.ru>
Subject: Re: [Qemu-devel] [PATCH v1] virtio: add checks for the size of the
 indirect table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dima Stepanov <dimastep@yandex-team.ru>
Cc: mst@redhat.com, qemu-devel@nongnu.org, wrfsh@yandex-team.ru


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 01:08:47PM +0300, Dima Stepanov wrote:
> The virtqueue_pop() and virtqueue_get_avail_bytes() routines can use the
> INDIRECT table to get the data. It is possible to create a packet which
> will lead to the assert message like:
>   include/exec/memory.h:1995: void
>   address_space_read_cached(MemoryRegionCache *, hwaddr, void *, int):
>   Assertion `addr < cache->len && len <=3D cache->len - addr' failed.
>   Aborted
> To do it the first descriptor should have a link to the INDIRECT table
> and set the size of it to 0. It doesn't look good that the guest should
> be able to trigger the assert in qemu. Add additional check for the size
> of the INDIRECT table, which should not be 0.
>=20
> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> ---
>  hw/virtio/virtio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPe3bAAoJEJykq7OBq3PIrIsIAJdUHSq7JQX5oBueFpK8vpV2
yVWJjH8uBvI+dC/5RaEWqn752bO3ARfPpDY6U9qJzPu/P2qlmAFKgGdWRVzuF8UP
1U37vN3ot04MTKvQf4MGC2vTrVBWeWBxqnoJJIiUwAoEtUbW+EMeRcP/owaK/OBq
j3zQg/qC7/YPfKl6/iZNCfVq7Mz8+1WYRejqU74AE0vFRuD6bFdb8SRXytbUGo37
UyHz489DgyS+S+vT1XleDBNuMGeI2XMmwfZdLz7Tmq9SiOcKx3U7oCjI8/4AKdWT
hOXpiXqcT7lxSLx9JIO8CaLj2ZzANspNGzKiJ6kP8ttuBBVfjs5RCDI7H3NOq4w=
=Lg49
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
