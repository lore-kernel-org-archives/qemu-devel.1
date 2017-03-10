Received: from eggs.gnu.org ([2001:4830:134:3::10]:49324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cmBBu-0000vF-Ed
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 22:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cmBBt-0007Ox-5S
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 22:26:06 -0500
References: <20170310031521.630-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <033881fe-b3d3-2c3a-48fc-c08691f2c9cb@redhat.com>
Date: Thu, 9 Mar 2017 21:25:54 -0600
MIME-Version: 1.0
In-Reply-To: <20170310031521.630-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pGx2bolePUiuRSHKTMA6qQkUb1N1RadHU"
Subject: Re: [Qemu-devel] [PATCH for-2.9] mirror: Fix backwards mirror_yield
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pGx2bolePUiuRSHKTMA6qQkUb1N1RadHU
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <033881fe-b3d3-2c3a-48fc-c08691f2c9cb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] mirror: Fix backwards mirror_yield
 parameters
References: <20170310031521.630-1-eblake@redhat.com>
In-Reply-To: <20170310031521.630-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding Stefan in cc, as trace maintainer]

On 03/09/2017 09:15 PM, Eric Blake wrote:

Perhaps I should update the subject to mention trace?

> trace-events lists the parameters for mirror_yield consistently
> with other events (cnt just after s, like in mirror_before_sleep;
> in_flight last, like in mirror_yield_in_flight).  But the callers
> were passing parameters in the wrong order, leading to poor trace
> messages, including type truncation when there are more than 4G
> dirty sectors involved.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/mirror.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 4f3a5cb..1c403c5 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -633,7 +633,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlo=
ckJob *s)
>              }
>=20
>              if (s->in_flight >=3D MAX_IN_FLIGHT) {
> -                trace_mirror_yield(s, s->in_flight, s->buf_free_count,=
 -1);
> +                trace_mirror_yield(s, -1, s->buf_free_count, s->in_fli=
ght);
>                  mirror_wait_for_io(s);
>                  continue;
>              }
> @@ -808,7 +808,7 @@ static void coroutine_fn mirror_run(void *opaque)
>              s->common.iostatus =3D=3D BLOCK_DEVICE_IO_STATUS_OK) {
>              if (s->in_flight >=3D MAX_IN_FLIGHT || s->buf_free_count =3D=
=3D 0 ||
>                  (cnt =3D=3D 0 && s->in_flight > 0)) {
> -                trace_mirror_yield(s, s->in_flight, s->buf_free_count,=
 cnt);
> +                trace_mirror_yield(s, cnt, s->buf_free_count, s->in_fl=
ight);
>                  mirror_wait_for_io(s);
>                  continue;
>              } else if (cnt !=3D 0) {
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--pGx2bolePUiuRSHKTMA6qQkUb1N1RadHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYwhzCAAoJEKeha0olJ0NqQN0H/0AOx0glwjcghRCm+StyuZT3
NdpGUKxOsWoxjLCWhhQnnem9cXeaLbCyFD+XFu7ycpoMshlgE4jQMADK+SHwrQbq
7cPFf2qHoflrLvDhRocf0YhH208jzm34fKMhIqz92btRuPCFuDfJhhU95F4VPexs
ssK7cv4m71QSh8TRqOLlGtHinEpHV4DD5uvjK3DDIe3+7s9f8WZim6pBBz7phNlj
4DDOzz6PublSSwd9hgBk+y/TPc8Fk/pfn1aStyFnx0vzYoPLNoegfkHr+eK7tKnN
F/q3C9+wPNuQKFD9IB9zukhB33tbnE/OtimXP5NauqC2xEDLG/rFrcLmpfK8HTQ=
=pJ8d
-----END PGP SIGNATURE-----

--pGx2bolePUiuRSHKTMA6qQkUb1N1RadHU--
