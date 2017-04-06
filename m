Received: from eggs.gnu.org ([2001:4830:134:3::10]:52885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw8X2-0004G9-9X
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cw8X1-0007IU-9X
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 10:37:04 -0400
References: <20170406142527.25835-1-famz@redhat.com>
	<20170406142527.25835-3-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <867ef812-6894-3ee8-0867-3a2ce95b8feb@redhat.com>
Date: Thu, 6 Apr 2017 09:36:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170406142527.25835-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TeNKvNRtFpfHcsW5HQ89hEk52l8lRPQWD"
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/5] mirror: Fix aio context of
 mirror_top_bs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TeNKvNRtFpfHcsW5HQ89hEk52l8lRPQWD
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Ed Swierk <eswierk@skyportsystems.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <867ef812-6894-3ee8-0867-3a2ce95b8feb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/5] mirror: Fix aio context of
 mirror_top_bs
References: <20170406142527.25835-1-famz@redhat.com>
 <20170406142527.25835-3-famz@redhat.com>
In-Reply-To: <20170406142527.25835-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 09:25 AM, Fam Zheng wrote:
> It should be moved to the same context as source, before inserting to t=
he
> graph.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/mirror.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index 9e2fecc..e904fef 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1148,6 +1148,7 @@ static void mirror_start_job(const char *job_id, =
BlockDriverState *bs,
>          return;
>      }
>      mirror_top_bs->total_sectors =3D bs->total_sectors;
> +    bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
> =20
>      /* bdrv_append takes ownership of the mirror_top_bs reference, nee=
d to keep
>       * it alive until block_job_create() even if bs has no parent. */
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--TeNKvNRtFpfHcsW5HQ89hEk52l8lRPQWD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5lKAAAoJEKeha0olJ0NqMkEH/jrDIKaEXQTkjQgOrDy7wVgN
Tq+c4WLPfnbC0zJEsZ2Qe8I1ikZ8l1jsUrl7FVaHfnU+OWIlZLJE7rogt93pr+1Q
hkCbDwByM8mErFuQJ6yaEeC6e/HqwEF8Jh5UwMjJBaPotMgdm1/ZHQu8qDn2q3H1
fX8sJXqzhbl7fQhPm90xdbZTI93VKPIlymMEuB2V2AnWnvYs1AJ/LRRx3Uxm6Hjx
/qcS1+wEWDP0UbbLuQaUFhjrnBpqCxmHo5CbwDjsbMyMAkae9Ku0mvWoDEpUEB5v
mn/OcepOTBiORvMSVY7RpYeHTWiArFOQpAALWGWPxtRWodM5F67jwR+iHGvET1M=
=plrA
-----END PGP SIGNATURE-----

--TeNKvNRtFpfHcsW5HQ89hEk52l8lRPQWD--
