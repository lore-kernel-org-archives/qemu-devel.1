Received: from eggs.gnu.org ([209.51.188.92]:59423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1Yah-0006Fr-LF
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:36:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1Yag-0004VF-Fr
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:36:19 -0500
References: <20190305234337.18353-1-jsnow@redhat.com>
	<20190305234337.18353-5-jsnow@redhat.com>
	<6c9c5b9b-8093-e993-1027-db692d20e2e1@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c86079d4-08f4-afe6-7a8c-63b01868192c@redhat.com>
Date: Wed, 6 Mar 2019 09:36:09 -0600
MIME-Version: 1.0
In-Reply-To: <6c9c5b9b-8093-e993-1027-db692d20e2e1@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D7o2s2dvX72NIJMQ9fxDS6AP848TbYHQN"
Subject: Re: [Qemu-devel] [PATCH 4/5] block/qcow2-bitmap: Allow resizes with
 persistent bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D7o2s2dvX72NIJMQ9fxDS6AP848TbYHQN
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <c86079d4-08f4-afe6-7a8c-63b01868192c@redhat.com>
Subject: Re: [PATCH 4/5] block/qcow2-bitmap: Allow resizes with persistent
 bitmaps
References: <20190305234337.18353-1-jsnow@redhat.com>
 <20190305234337.18353-5-jsnow@redhat.com>
 <6c9c5b9b-8093-e993-1027-db692d20e2e1@virtuozzo.com>
In-Reply-To: <6c9c5b9b-8093-e993-1027-db692d20e2e1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/6/19 9:33 AM, Vladimir Sementsov-Ogievskiy wrote:

>> +    /* Flush bitmaps */
>> +    if (s->nb_bitmaps) {
>> +        Error *local_err =3D NULL;
>> +
>> +        /* Usually, bitmaps get resized after this call.
>> +         * Force it earlier so we can make the metadata consistent. *=
/
>> +        bdrv_dirty_bitmap_truncate(bs, offset);
>> +        qcow2_flush_persistent_dirty_bitmaps(bs, &local_err);
>> +        if (local_err) {
>> +            ret =3D -EINVAL;
>> +            goto fail;
>> +        }
>> +    }
>=20
> Why to flush after resize? Bitmaps will be IN_USE in the image anyway..=
=2E
>=20
> Could we implement resize without flush first,  it would be one patch +=
 test? And then consider
> flushing in separate?

What happens with migration if we don't flush the new size to disk, so
the on-disk format has a different size than the in-memory version?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--D7o2s2dvX72NIJMQ9fxDS6AP848TbYHQN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlx/6OkACgkQp6FrSiUn
Q2ozTAf/avzI4Ax2zFb+kgNKpZm8ClTlHiHqbevQE03J2EjCWe8jiiMd2/5Jz5xA
epHF2MgLsxKYbsJErkhxM/R8IHXoKUu9uUMrf8kcgVVuJBbheldQ4hLm4Rnb+Nay
jmFlNj8Du3Zo7c6ynW/RuDt/HIVFY8fETIsW+1UbV5PGRn4jMhX7OS4/6HEgKQTN
3A1GFwuDkYEUFBKlOJCpBMukkEDkMKhIrEaUPCMsJ3FPo2Y9Tb5Vbu1EgPWAgOf7
fkIoYTIk/okv3mP+LjD3nreytGa0Q/VjcIMY+QJaA5wHu7R6GmT2rtvTPRNNnp+u
m8jowQ2OeTEr1lc9Nsxb4sSgGzWMPA==
=aIBj
-----END PGP SIGNATURE-----

--D7o2s2dvX72NIJMQ9fxDS6AP848TbYHQN--
