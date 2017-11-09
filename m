Received: from eggs.gnu.org ([2001:4830:134:3::10]:47927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCnRP-0006IF-Mm
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:04:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCnRL-0002q1-58
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:04:23 -0500
References: <20171109013804.14488-1-mreitz@redhat.com>
	<20171109013804.14488-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eac16825-8bb8-61ec-dce8-5cfdd53f0d97@redhat.com>
Date: Thu, 9 Nov 2017 08:03:59 -0600
MIME-Version: 1.0
In-Reply-To: <20171109013804.14488-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PlnN3L6DEBPx8aoLx2OVlRqR2r5nfWlaF"
Subject: Re: [Qemu-devel] [PATCH 1/5] iotests: Make 030 less flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PlnN3L6DEBPx8aoLx2OVlRqR2r5nfWlaF
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <eac16825-8bb8-61ec-dce8-5cfdd53f0d97@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] iotests: Make 030 less flaky
References: <20171109013804.14488-1-mreitz@redhat.com>
 <20171109013804.14488-2-mreitz@redhat.com>
In-Reply-To: <20171109013804.14488-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 07:38 PM, Max Reitz wrote:
> This patch fixes two race conditions in 030:
>=20
> 1. The first is in TestENSPC.test_enospc().  After resuming the job,

s/ENSPC/ENOSPC/

>    querying it to confirm it is no longer paused may fail because in th=
e
>    meantime it might have completed already.  The same was fixed in
>    TestEIO.test_ignore() already (in commit
>    2c3b44da07d341557a8203cc509ea07fe3605e11).
>=20
> 2. The second is in TestSetSpeed.test_set_speed_invalid(): Here, a
>    stream job is started on a drive without any break points, with a
>    block-job-set-speed invoked subsequently.  However, without any brea=
k
>    points, the job might have completed in the meantime (on tmpfs at
>    least); or it might complete before cancel_and_wait() which expects
>    the job to still exist.  This can be fixed like everywhere else by
>    pausing the drive (installing break points) before starting the job
>    and letting cancel_and_wait() resume it.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/030 | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PlnN3L6DEBPx8aoLx2OVlRqR2r5nfWlaF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEYE8ACgkQp6FrSiUn
Q2pK2wf/UJRqPwuQeMOnWuXvOQTnSpZ8iZZSrRHIn9ynfy8Z50C+K97Orm144wcl
HLmvB9Vxxb/Zyfqp65fXxBj096pvyWdCFtItXv47mLaJeXH58Aazv2XsSDDboQ0e
f/7tzlbZo3YU2gYfAVI5lzwrDs0WhZEuojUzqlada4NW+u0ncDNIzIBrxAW47Qcd
LgZWUtRO0Qce6F2AQJxDdKXa65HpFL1xX/DVaXhhYOAApOY7yFK254zjABo4uulA
gY9d3XScKdjAVAov8sreCV9FqJc70aSK46RAmzy+jKTZ53N9DgS6ACdgI42x4Pys
Uqsu8PswNu6szu/52uemGKyxc354eA==
=MN7n
-----END PGP SIGNATURE-----

--PlnN3L6DEBPx8aoLx2OVlRqR2r5nfWlaF--
