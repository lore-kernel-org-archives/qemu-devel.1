Received: from eggs.gnu.org ([2001:4830:134:3::10]:44892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzRJ-0008JL-Uu
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVzRI-0001UB-Uk
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:11:21 -0400
References: <20170711160814.20941-1-mreitz@redhat.com>
	<20170711160814.20941-51-mreitz@redhat.com>
	<CAFEAcA90jG=vzGX0xKQh5ZkDsnNw6mMQb5QDip7+sAqd8HVTSA@mail.gmail.com>
	<32291ebe-8c5f-eddf-3cd3-6bcf75deb56d@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2e1c845-f8e4-0723-acbe-e30a7db837ae@redhat.com>
Date: Fri, 14 Jul 2017 07:11:11 -0500
MIME-Version: 1.0
In-Reply-To: <32291ebe-8c5f-eddf-3cd3-6bcf75deb56d@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lffrIfvJVIcMx0BiAVRJmQ9MgCWjArM8H"
Subject: Re: [Qemu-devel] [PULL 50/85] qcow2: add
 .bdrv_remove_persistent_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lffrIfvJVIcMx0BiAVRJmQ9MgCWjArM8H
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Message-ID: <e2e1c845-f8e4-0723-acbe-e30a7db837ae@redhat.com>
Subject: Re: [Qemu-devel] [PULL 50/85] qcow2: add
 .bdrv_remove_persistent_dirty_bitmap
References: <20170711160814.20941-1-mreitz@redhat.com>
 <20170711160814.20941-51-mreitz@redhat.com>
 <CAFEAcA90jG=vzGX0xKQh5ZkDsnNw6mMQb5QDip7+sAqd8HVTSA@mail.gmail.com>
 <32291ebe-8c5f-eddf-3cd3-6bcf75deb56d@virtuozzo.com>
In-Reply-To: <32291ebe-8c5f-eddf-3cd3-6bcf75deb56d@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/14/2017 07:04 AM, Vladimir Sementsov-Ogievskiy wrote:
> 14.07.2017 13:42, Peter Maydell wrote:
>> On 11 July 2017 at 17:07, Max Reitz <mreitz@redhat.com> wrote:
>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>

>> Probably the best fix for this is to make bitmap_free() do
>> nothing when handed NULL.
>=20
> Agree, my stupid omission. Can this be fixed in flight? Just squash int=
o
> commit "qcow2: add bitmaps extension"

Your commit has already landed on master (commit 469c71e), so you'll
need to resubmit this as a new patch in a top-level thread. But given
the simplicity, feel free to add:

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 8448bec46d..39dfe16fc0 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -487,6 +487,10 @@ static inline void bitmap_directory_to_be(uint8_t
> *dir, size_t size)
>=20
>  static void bitmap_free(Qcow2Bitmap *bm)
>  {
> +    if (bm =3D=3D NULL) {
> +        return;
> +    }
> +
>      g_free(bm->name);
>      g_free(bm);
>  }
> //
>=20
>>
>> thanks
>> -- PMM
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lffrIfvJVIcMx0BiAVRJmQ9MgCWjArM8H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZaLTfAAoJEKeha0olJ0NqZpkIAJOnDPQG0nLyOOj/TRkWwaru
2ayvCGRBqDMe3k4Apw1hhxc/esa+5Kmzb8CW0Vk+oEeKXe+thakKimSU9aeHet4j
pK3Tdeykx3l7laL8Y8Dvv0FoYDePyeugPqUncbLIQtpEyeJTKnOi40DMPTT9Ok+0
wXN3b3oHEB5BQpx/WRr9QXKtO71OwxmrXC2o2dS0f70jNgJqjRpvO7gucSyXujQ9
GJAhOLsRj/j5jpSVwoRBVabgYjAkXD9g7XQPAxKdIycc0dEjwJJ8XZ4qfdlJnv8t
5CSJgfACVlGHhxPDRq1TMjvJuD0EpG3gL7Jj8xGkSR54VLeOtLcAsyND76j5mL0=
=GaO2
-----END PGP SIGNATURE-----

--lffrIfvJVIcMx0BiAVRJmQ9MgCWjArM8H--
