Received: from eggs.gnu.org ([2001:4830:134:3::10]:56574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNKQR-00064m-N1
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNKQQ-0003ha-Nb
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 10:18:55 -0500
References: <20171206105309.3468-1-kwolf@redhat.com>
	<20171206105309.3468-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <19f1ad69-1e8f-448c-d549-337663bea40d@redhat.com>
Date: Fri, 8 Dec 2017 09:18:38 -0600
MIME-Version: 1.0
In-Reply-To: <20171206105309.3468-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LqRM5fFutvKb5D8WnuICKsAqA89IabqGT"
Subject: Re: [Qemu-devel] [PATCH v2 3/6] test-bdrv-drain: Test BlockDriver
 callbacks for drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LqRM5fFutvKb5D8WnuICKsAqA89IabqGT
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Message-ID: <19f1ad69-1e8f-448c-d549-337663bea40d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] test-bdrv-drain: Test BlockDriver
 callbacks for drain
References: <20171206105309.3468-1-kwolf@redhat.com>
 <20171206105309.3468-4-kwolf@redhat.com>
In-Reply-To: <20171206105309.3468-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 04:53 AM, Kevin Wolf wrote:
> This adds a test case that the BlockDriver callbacks for drain are
> called in bdrv_drained_all_begin/end(), and that both of them are calle=
d
> exactly once.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/test-bdrv-drain.c | 137 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/Makefile.include  |   2 +
>  2 files changed, 139 insertions(+)
>  create mode 100644 tests/test-bdrv-drain.c
>=20

> +static int coroutine_fn bdrv_test_co_preadv(BlockDriverState *bs,
> +                                            uint64_t offset, uint64_t =
bytes,
> +                                            QEMUIOVector *qiov, int fl=
ags)
> +{
> +    /* We want this request to stay until the polling loop in drain wa=
its for
> +     * it to complete. We need to sleep a while as bdrv_drain_invoke()=
 comes
> +     * first and polls its result, too, but it shouldn't accidentally =
complete
> +     * this request yet. */
> +    co_aio_sleep_ns(qemu_get_aio_context(), QEMU_CLOCK_REALTIME, 10000=
0);
> +

Conflicts with patches to remove the first parameter from co_aio_sleep_ns=
():

https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01681.html

Should be an obvious fix for whoever rebases on top of the other, so:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LqRM5fFutvKb5D8WnuICKsAqA89IabqGT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloqrU4ACgkQp6FrSiUn
Q2oTPwf9F642CaaqFQZzBnZc5BYZ+RYdE4HTPTMBOMMAYKnP22J0fOcTekX1qXcn
0Aixnp0CMjDSLPOwURWmRkkOU5XWJkN+57ZOdWxmAyqND0lKo2mdEMIRxiFYIPMW
Qq87PldgrUAzlJDnShK334eOWESt0+Ew9jOl9pRvKraHbEViaSDHfxaz4PVdRCJH
XP7SspHkMOQiqdlc4qymHE0Jdp08UQjpvnGAw8SywCJ9MeePmuw1H386ZVavAmOj
73OdtLd0Jr5qPN2iS6nY76B8M5HOM02sRCBrh9xy3b1+7mNWrud2XOFzEaCAJzk7
pFftJgtPntAq7ifptxSV18/7/R3xOQ==
=wHQB
-----END PGP SIGNATURE-----

--LqRM5fFutvKb5D8WnuICKsAqA89IabqGT--
