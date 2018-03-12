Received: from eggs.gnu.org ([2001:4830:134:3::10]:57356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evUkl-0002Ja-6a
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evUkk-0004lk-3c
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:13:07 -0400
References: <20180312211156.452139-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1ac1ca19-8f5f-0c6e-f676-699720fba303@redhat.com>
Date: Mon, 12 Mar 2018 22:12:58 +0100
MIME-Version: 1.0
In-Reply-To: <20180312211156.452139-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RfX0xAC3t951d9nq1ZkCvIYDqvra4qEKr"
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix stuck NBD process on 33
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, anton.nefedov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RfX0xAC3t951d9nq1ZkCvIYDqvra4qEKr
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, anton.nefedov@virtuozzo.com,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <1ac1ca19-8f5f-0c6e-f676-699720fba303@redhat.com>
Subject: Re: [PATCH] iotests: Fix stuck NBD process on 33
References: <20180312211156.452139-1-eblake@redhat.com>
In-Reply-To: <20180312211156.452139-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-12 22:11, Eric Blake wrote:
> Commit afe35cde6 added additional actions to test 33, but forgot
> to reset the image between tests.  As a result, './check -nbd 33'
> fails because the qemu-nbd process from the first half is still
> occupying the port, preventing the second half from starting a
> new qemu-nbd process.  Worse, the failure leaves a rogue qemu-nbd
> process behind even after the test fails, which causes knock-on
> failures to later tests that also want to start qemu-nbd.
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> I'll take this through my NBD queue (pull request within the next 16
> hours), as obviously I want to test that the other patches on that
> queue can get past the iotests for NBD :)
>=20
>  tests/qemu-iotests/033 | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--RfX0xAC3t951d9nq1ZkCvIYDqvra4qEKr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqm7VoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AoWYH/AqWFPc6ag6auatfsQo7GDdd2hcDAPB8
U3/2UD+RdN2mDpMnZaUKCqMlMXwSnKqWh0EqFuF1EPVXZsN8V+8H2IjGBh3Y2jrv
y0ZR+83ycsbFRi1sCPdz1p4GkyT7Jg+tmg3yslyttXamikFINrTMZCtYuGBPmld/
kIOvItSCGOs5nX/Hh4AG9Bys1Awm7x5ZqEHOsvM9VLy919mm7ISyqrxQ3aiXXgp4
B4/uBmWfLreIsq7Fn6CYiEw3SFQSGHtlzvzTTh+bGnBc6u4yTDgl23UTH8vB2LvM
7yEg0K6d/74wFKH0NqyRQLUiXzQr6OEpRZBo7USjlkucvc6l/Rv4SQw=
=h0QQ
-----END PGP SIGNATURE-----

--RfX0xAC3t951d9nq1ZkCvIYDqvra4qEKr--
