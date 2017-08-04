Received: from eggs.gnu.org ([2001:4830:134:3::10]:39748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddeVy-0002ED-Lx
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddeVx-00040B-Nb
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:27:50 -0400
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1501597152-25342-15-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5d6381ca-7d96-b248-1c59-19e29000c628@redhat.com>
Date: Fri, 4 Aug 2017 10:27:36 -0500
MIME-Version: 1.0
In-Reply-To: <1501597152-25342-15-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GPtP5AtuUiIvBn0d53b2IeFtVGiEIbSsw"
Subject: Re: [Qemu-devel] [PATCH v4 14/15] iotest 190: test BDRV_REQ_ALLOCATE
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
--GPtP5AtuUiIvBn0d53b2IeFtVGiEIbSsw
From: Eric Blake <eblake@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com,
 mreitz@redhat.com
Message-ID: <5d6381ca-7d96-b248-1c59-19e29000c628@redhat.com>
Subject: Re: [PATCH v4 14/15] iotest 190: test BDRV_REQ_ALLOCATE
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
 <1501597152-25342-15-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1501597152-25342-15-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2017 09:19 AM, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> ---
>  tests/qemu-iotests/190     | 146 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/190.out |  50 ++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 197 insertions(+)
>  create mode 100755 tests/qemu-iotests/190
>  create mode 100644 tests/qemu-iotests/190.out

190 already exists on mainline, you'll have to choose an available test
id that hasn't been mentioned on-list yet (yeah, our process for
reserving test ids is lousy. Max has already said he doesn't mind fixing
conflicts if it is just a duplicated test number, for qemu-iotests that
he manages)


> +_cleanup()
> +{
> +	_cleanup_test_img
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15

This part won't be needed, if you land after Stefan's patch that adds
per-test directories with the ability to preserve temporary files

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GPtP5AtuUiIvBn0d53b2IeFtVGiEIbSsw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEkmgACgkQp6FrSiUn
Q2pY4Qf8CKvr1/WbYDjMctDohktXv4JZcwcW4uGmsuXaE6g0urobh78S4B5AUvQ8
vOF/hVXtt8K2DRjguqCtxtye1lGPWDSFBzc9R7QNemKOp29BHaQcABs1T3TAsz52
/jPnGixqkZziHIfo9/Uiiv8cxOlucop6HBiJKdinsylKrpE9G4vKWnAtzEpedITd
aeG0/FW43zg+oqEjExT1xK2rn2+PRrvl29+lS0cfqgZfkIT4MDn4/xdwOdhfv66h
T2Cmm55dGaK7hqlOZYSfNSSjb2Hd45eDDUQec+CDJ67IaskezfaNt/ebYyVuvMf9
Z+xOA7jgrIyZAdVGK82bvQPiMYvSDA==
=lr7t
-----END PGP SIGNATURE-----

--GPtP5AtuUiIvBn0d53b2IeFtVGiEIbSsw--
