Received: from eggs.gnu.org ([209.51.188.92]:33863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guJDV-0000R6-P8
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1guJDT-0000ov-RE
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:46:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1guJDQ-0000kL-A7
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:46:22 -0500
References: <20190213234907.24173-1-jsnow@redhat.com>
	<20190213234907.24173-4-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6202dabc-0079-90cb-8b7a-39f8ae6c817c@redhat.com>
Date: Thu, 14 Feb 2019 09:46:17 -0600
MIME-Version: 1.0
In-Reply-To: <20190213234907.24173-4-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I7iTSe8TTqrbgdb3KXarQqx9gjoBqUe98"
Subject: Re: [Qemu-devel] [PULL 3/3] blockdev: acquire aio_context for
 bitmap add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I7iTSe8TTqrbgdb3KXarQqx9gjoBqUe98
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <6202dabc-0079-90cb-8b7a-39f8ae6c817c@redhat.com>
Subject: Re: [Qemu-devel] [PULL 3/3] blockdev: acquire aio_context for bitmap
 add/remove
References: <20190213234907.24173-1-jsnow@redhat.com>
 <20190213234907.24173-4-jsnow@redhat.com>
In-Reply-To: <20190213234907.24173-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/13/19 5:49 PM, John Snow wrote:
> When bitmaps are persistent, they may incur a disk read or write when b=
itmaps
> are added or removed. For configurations like virtio-dataplane, failing=
 to
> acquire this lock will abort QEMU when disk IO occurs.
>=20
> We used to acquire aio_context as part of the bitmap lookup, so re-intr=
oduce
> the lock for just the cases that have an IO penalty. Commit 2119882c re=
moved
> these locks, and I failed to notice this when we committed fd5ae4cc, so=
 this
> has been broken since persistent bitmaps were introduced.
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1672010
> Reported-By: Aihua Liang <aliang@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Message-id: 20190213195501.7790-2-jsnow@redhat.com
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)

>      bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, name, errp);
>      if (bitmap =3D=3D NULL) {
> -        return;
> +        goto out

Embarrassing enough that I missed this syntax error in spite of my R-b,
but even more embarrassing that we have a pull request that has
obviously not been compiled. At least patchew called it out.

We're not in enough of a rush to need this PR to land this week, so I
won't try to post a v2 on your behalf, but will instead wait for your
return next week.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--I7iTSe8TTqrbgdb3KXarQqx9gjoBqUe98
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxljUkACgkQp6FrSiUn
Q2p/SwgAj8L1ejx39ldjCDy2svtf+9tZ2bfsb2aWh1vdWwINWIPcA4OfpPG3R8Wv
ZVkrxmdQOuLNB8yYwmf6nBAX50P0oGGIfvHL08fq1F4iA5OdqbE9HFAuJdPlSDsx
H5kwdEMF29akF2Q8FfApG7uir6oiJY7C1AFaBbNIKlPEEjSpY9VXRx3aVDSLzEsj
SuYNEILQpJfdQ6FeNHrWtHd+IUV7VcQSOtS8lsYi1rb+4oTSGMgwDNbrrezOdgyQ
sk+ygCk+i2AHtX2C0emJYTAXJjGFYmrhiWJddV6pzHdepxzvDQhgsB+PswsKJNK2
BMBv0dXTKNpHQ81uflOw1xV0eBrqYQ==
=//j3
-----END PGP SIGNATURE-----

--I7iTSe8TTqrbgdb3KXarQqx9gjoBqUe98--
