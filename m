Received: from eggs.gnu.org ([209.51.188.92]:42759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grOC7-0001ej-W1
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grOC7-0007Nr-4f
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:28:55 -0500
References: <1549448589-381285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1549448589-381285-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebfe71e6-6425-282b-56c4-fb87a90e1910@redhat.com>
Date: Wed, 6 Feb 2019 08:28:16 -0600
MIME-Version: 1.0
In-Reply-To: <1549448589-381285-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yZR2FcJA6SAdhvRF6SSKOdkCfQdWfHEyW"
Subject: Re: [Qemu-devel] [PATCH v13 3/3] qcow2: list of bitmaps new test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yZR2FcJA6SAdhvRF6SSKOdkCfQdWfHEyW
From: Eric Blake <eblake@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com,
 berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
Message-ID: <ebfe71e6-6425-282b-56c4-fb87a90e1910@redhat.com>
Subject: Re: [PATCH v13 3/3] qcow2: list of bitmaps new test 242
References: <1549448589-381285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1549448589-381285-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1549448589-381285-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 4:23 AM, Andrey Shinkevich wrote:
> A new test file 242 added to the qemu-iotests set. It checks
> the format of qcow2 specific information for the new added
> section that lists details of bitmaps.
>=20
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> +log('Unset the unknown bitmap flag \'{}\' in the bitmap directory entr=
y:\n'
> +    .format(hex(bitmap_flag_unknown)))
> +img_info_log(disk)
> diff --git a/tests/qemu-iotests/242.out b/tests/qemu-iotests/242.out

That output results in:

> new file mode 100644
> index 0000000..cf2b310
> --- /dev/null
> +++ b/tests/qemu-iotests/242.out
> @@ -0,0 +1,167 @@

> +    refcount bits: 16
> +    corrupt: false
> +
> diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group

an empty blank line at the end of the test, which scripts/checkpatch.pl
complains about.  Easy fix, though, so no need to respin v14.

> index 0f1c3f9..32acdd7 100644
> --- a/tests/qemu-iotests/group
> +++ b/tests/qemu-iotests/group
> @@ -235,3 +235,4 @@
>  235 auto quick
>  236 auto quick
>  238 auto quick
> +242 rw auto quick
>=20

Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--yZR2FcJA6SAdhvRF6SSKOdkCfQdWfHEyW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxa7wAACgkQp6FrSiUn
Q2pFLQgAkSAlwLEppIkaIK9GL0ZPR93yxtAuZjGacR1wFcSVeEWhjeMVQLo5g/ri
layJoGM7iEk3HON8xlu5bTiey2IRPVI5CStfF2x1pTNElwT7G+K8SVI6hocJZlRs
6CdzXcEOmfcXvnq317/x4I20lE3dNP4Cd92KzxtsSmqTf6Uw8AK1I9A3cNVc3XRi
LorBDnKIBS2Ft1aO3ey2Grcva/eRG1AGlLlXnIlGoMyrlKKkCaNsMHvnTYxsk1ID
e3x9F91J2unTw6RAD1yrMMbjafd7Z8XV4yC5uSNR7GXKPkox92GnshljDl9ovXQm
mlPlM332/hA/3oV/aumOg0oAu7tIVw==
=09iR
-----END PGP SIGNATURE-----

--yZR2FcJA6SAdhvRF6SSKOdkCfQdWfHEyW--
