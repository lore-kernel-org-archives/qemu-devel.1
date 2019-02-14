Received: from eggs.gnu.org ([209.51.188.92]:51462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu7HZ-00008C-8n
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu7HR-0007Ks-49
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:01:44 -0500
References: <20190213232356.21034-1-jsnow@redhat.com>
	<20190213232356.21034-7-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a0e65ff-cd50-8a90-ba64-dabe29b1b43c@redhat.com>
Date: Wed, 13 Feb 2019 21:01:15 -0600
MIME-Version: 1.0
In-Reply-To: <20190213232356.21034-7-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="76wb0EENagNUPq7uDpC88utOmNev7aZtd"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] block/dirty-bitmaps: move comment
 block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <fam@euphon.net>, libvir-list@redhat.com, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--76wb0EENagNUPq7uDpC88utOmNev7aZtd
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, vsementsov@virtuozzo.com,
 Fam Zheng <fam@euphon.net>, libvir-list@redhat.com,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <2a0e65ff-cd50-8a90-ba64-dabe29b1b43c@redhat.com>
Subject: Re: [PATCH v2 6/6] block/dirty-bitmaps: move comment block
References: <20190213232356.21034-1-jsnow@redhat.com>
 <20190213232356.21034-7-jsnow@redhat.com>
In-Reply-To: <20190213232356.21034-7-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/13/19 5:23 PM, John Snow wrote:
> Simply move the big status enum comment block to above the status
> function, and document it as being deprecated. The whole confusing
> block can get deleted in three releases time.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/dirty-bitmap.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
>=20

> -/* Called with BQL taken.  */
> +/**
> + * bdrv_dirty_bitmap_status: This API is now deprecated.
> + * Called with BQL taken.
> + *
> + * A BdrvDirtyBitmap can be in four possible user-visible states:
> + * (1) Active:   successor is NULL, and disabled is false: full r/w mo=
de
> + * (2) Disabled: successor is NULL, and disabled is true: qualified r/=
w mode,
> + *               guest writes are dropped, but monitor writes are poss=
ible,
> + *               through commands like merge and clear.
> + * (3) Frozen:   successor is not NULL.
> + *               A frozen bitmap cannot be renamed, deleted, cleared, =
set,
> + *               enabled, merged to, etc. A frozen bitmap can only abd=
icate()
> + *               or reclaim().
> + *               In this state, the anonymous successor bitmap may be =
either
> + *               Active and recording writes from the guest (e.g. back=
up jobs),
> + *               but it can be Disabled and not recording writes.

Pre-existing due to code motion, but you could improve the grammar with
s/but/or/

> + * (4) Locked:   Whether Active or Disabled, the user cannot modify th=
is bitmap
> + *               in any way from the monitor.
> + */

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--76wb0EENagNUPq7uDpC88utOmNev7aZtd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxk2fsACgkQp6FrSiUn
Q2rfMQf/djw3iTbCFm8aESxzcFblKgvg5xt6u4TBeMpQo/CBx0H54Q9JSTMoh1SB
Ync5cnQoz/xpmjap4TfJewE7Iwt/PHl+t3P5XYXWJeKHO0XibMNbjQbblnsLTseu
9XR4TWQbfo51ELYOoIQAqv+5VQD6VywHSW8BFCZrqYY8PMXB9G1EL/AXStM6iI/R
9/QpNeR771HpeKrpNxnoZwzS3BQk1A9Kp6X1zi6P+McIDIBbLQUd/naM9Njgt2F6
LlGUPNENMivY7cZpKRMtRwJKmQJMvFKdbExVlW4igXsj5z8FBeL+LlbRzQygYg4J
C1Y63WlGQYGud8CbzRTo3mzG598ByQ==
=razI
-----END PGP SIGNATURE-----

--76wb0EENagNUPq7uDpC88utOmNev7aZtd--
