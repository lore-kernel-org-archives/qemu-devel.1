Received: from eggs.gnu.org ([209.51.188.92]:56450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1W8Y-0007QQ-Li
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1W8V-0007hw-Ez
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 07:59:06 -0500
References: <20190305234337.18353-1-jsnow@redhat.com>
	<20190305234337.18353-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <28d6183a-f654-de55-36ed-ee0bafb47739@redhat.com>
Date: Wed, 6 Mar 2019 06:58:35 -0600
MIME-Version: 1.0
In-Reply-To: <20190305234337.18353-3-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KXHqV7X9SjAfOyA8zJxsOzKcOxpLcwcYF"
Subject: Re: [Qemu-devel] [PATCH 2/5] block/qcow2-bitmap: Allow bitmap
 flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KXHqV7X9SjAfOyA8zJxsOzKcOxpLcwcYF
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <28d6183a-f654-de55-36ed-ee0bafb47739@redhat.com>
Subject: Re: [PATCH 2/5] block/qcow2-bitmap: Allow bitmap flushing
References: <20190305234337.18353-1-jsnow@redhat.com>
 <20190305234337.18353-3-jsnow@redhat.com>
In-Reply-To: <20190305234337.18353-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/5/19 5:43 PM, John Snow wrote:
> Usually, we only write out bitmaps when we're about to close out the fi=
le,
> so we always remove the bitmaps after to make it easier to determine th=
e
> source of truth for migration purposes.
>=20
> However, there may be times we want to flush bitmap data more aggressiv=
ely,
> like after a truncate event where we need to make the metadata consiste=
nt
> again.

Or, as I've mentioned in other threads, after every
bitmap-add/bitmap-delete operation, so that 'qemu-img info -U' can see
which persistent bitmaps exist. But that's one step further than this
series, so I won't insist on it today.

>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/qcow2.h        |  1 +
>  block/qcow2-bitmap.c | 45 ++++++++++++++++++++++++++++++--------------=

>  2 files changed, 32 insertions(+), 14 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--KXHqV7X9SjAfOyA8zJxsOzKcOxpLcwcYF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlx/w/sACgkQp6FrSiUn
Q2re0wf8Ctr4jUdgZ8h8YrohTQ8kWGX1T1rkx+sFuMgNciimUnCo6sbTXE3IZ62i
IYfu2tKLkgOehDTYo283kRYSeQwbjWZfJ62urFfyvutmp2Wr6P52dXztk35Xb/Dv
BMJFgA0IsmaUPlPQCYn1hzAGFjbpM5qcQpiIwaBmTWrjPAZsDMQQLICrj9WuLns9
Bq0tiiTazWx/sTHZW41i+M4uTyt/Kl+vbL/T7s43SvMFQ7oYhbb06zC26R0iM2U9
mVGN9SG8t2qBKaw2fXauhjXZ0PQI0wQJuZA8m6wkz3/pUPEv/91TAvEDgFNGvhH7
p0gmDtZvKYrcFkSJkKrrICvuTT7MgA==
=/7EM
-----END PGP SIGNATURE-----

--KXHqV7X9SjAfOyA8zJxsOzKcOxpLcwcYF--
