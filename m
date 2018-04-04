Received: from eggs.gnu.org ([2001:4830:134:3::10]:45025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3kX3-0003RJ-Ib
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f3kWz-0004Ku-KO
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:41:05 -0400
References: <20180404150146.23281-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02284d07-59e1-cf58-d955-51ffade51ab5@redhat.com>
Date: Wed, 4 Apr 2018 10:40:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180404150146.23281-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F6uKInhCsqnmr3kRDG6XpFRBz7KOpKm03"
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] qemu-iotests: update 185 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F6uKInhCsqnmr3kRDG6XpFRBz7KOpKm03
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <02284d07-59e1-cf58-d955-51ffade51ab5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v2] qemu-iotests: update 185 output
References: <20180404150146.23281-1-stefanha@redhat.com>
In-Reply-To: <20180404150146.23281-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/04/2018 10:01 AM, Stefan Hajnoczi wrote:
> Commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce
> vm_shutdown()") added a bdrv_drain_all() call.  As a side-effect of the=

> drain operation the block job iterates one more time than before.  The
> 185 output no longer matches and the test is failing now.
>=20
> It may be possible to avoid the superfluous block job iteration, but
> that type of patch is not suitable late in the QEMU 2.12 release cycle.=

>=20
> This patch simply updates the 185 output file.  The new behavior is
> correct, just not optimal, so make the test pass again.
>=20
> Fixes: 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce vm_shut=
down()")
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/185     | 10 ++++++----
>  tests/qemu-iotests/185.out | 12 +++++++-----
>  2 files changed, 13 insertions(+), 9 deletions(-)

> @@ -102,11 +101,14 @@ echo
>  # command to be received (after receiving the command, the rest runs
>  # synchronously, so jobs can arbitrarily continue or complete).
>  #
> +# Jobs present while QEMU is terminating iterate once more due to
> +# bdrv_drain_all().

Do we want to add something like: "FIXME: removing the bdrv_drain_all()
may be desirable in a future patch; and would warrant a change to the
expected output."?  Either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--F6uKInhCsqnmr3kRDG6XpFRBz7KOpKm03
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrE8gAACgkQp6FrSiUn
Q2r61wgAgDkoLuPtIIdjdAXQJFr/a9rT0qa5brblru7nA4vzN0Nbyjh8s3Ac3xfg
hYNBq6dN/SwUPfBUllfNPv11ENeJnFQaZf01IEJd1Drrf2EocqZuZuYCciUjvgT2
FfCMi8dcmD/bXjlVtiD2v/NKFM8Evnb31QjFGOodmgpKg0o1RmewoNt60+bM5/W0
ch3E9oyqpmbxJYDMqkrFv2otWsDRqntCuOjMdCLXKh6xJusyOCRHHlCzwTe0Zf6Z
2EIEvKrCiACop/mdsppiBexb/woHccjjE4uU/7U/MTvbnHqn5wqB/5PocX7CNNet
APjz5ZjGZi4+p4OtBdMPMrJvyZKYAw==
=QXhf
-----END PGP SIGNATURE-----

--F6uKInhCsqnmr3kRDG6XpFRBz7KOpKm03--
