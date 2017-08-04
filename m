Received: from eggs.gnu.org ([2001:4830:134:3::10]:41172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddilU-0007eb-NP
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 16:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddilU-0006ZX-1X
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 16:00:08 -0400
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1501597152-25342-9-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4316158c-7775-477f-bc1f-56425872c35f@redhat.com>
Date: Fri, 4 Aug 2017 15:00:00 -0500
MIME-Version: 1.0
In-Reply-To: <1501597152-25342-9-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gL4bghmNk6IpTssl5L88D71FGOKHx6dRm"
Subject: Re: [Qemu-devel] [PATCH v4 08/15] qcow2: set inactive flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gL4bghmNk6IpTssl5L88D71FGOKHx6dRm
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com,
 mreitz@redhat.com
Message-ID: <4316158c-7775-477f-bc1f-56425872c35f@redhat.com>
Subject: Re: [PATCH v4 08/15] qcow2: set inactive flag
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1501597152-25342-9-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501597152-25342-9-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2017 09:19 AM, Anton Nefedov wrote:
> Qcow2State and BlockDriverState flags have to be in sync
>=20
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  block/qcow2.c | 1 +
>  1 file changed, 1 insertion(+)

Is this a bug fix needed for 2.10?

>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 66aa8c2..2a1d2f2 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2138,6 +2138,7 @@ static int qcow2_inactivate(BlockDriverState *bs)=

> =20
>      if (result =3D=3D 0) {
>          qcow2_mark_clean(bs);
> +        s->flags |=3D BDRV_O_INACTIVE;
>      }
> =20
>      return result;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gL4bghmNk6IpTssl5L88D71FGOKHx6dRm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmE0kAACgkQp6FrSiUn
Q2rUQQf/cOXeCOVNk56efZkQcGav+mlz+NNxz3P7/M5CCsS3I+fxv6MFFKp3vVWB
Vg6Vj8WIfbUy2iDm0lLAtoy6VvsIgGu/TCBmkpNSdSctrLj9w2m8sxvz7Rt+lClb
k/8qB0Q/3auPtWiyZjxkPbpn0rB5KowUl+4bi1aAgJlbQe/KS63dFfZGgqVPMIMK
UmX5/0lTuKkm/fqPCP15tVLMLT8zLi0vz2YiOg6icFTIlo5o0qt0iDrbqNt97ahv
/l3zTJBA6lhRHWws0IKvt+7ftMjOTbOEzv4+S49+v2BDMsZnra4ws3U31B1pd0HC
k73BIZdzpwcYysv3aNeBpDBc87ANJg==
=qgZP
-----END PGP SIGNATURE-----

--gL4bghmNk6IpTssl5L88D71FGOKHx6dRm--
