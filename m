Received: from eggs.gnu.org ([209.51.188.92]:35685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghUZH-0002FA-Ks
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghUZC-0002U4-0p
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:15:52 -0500
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-5-vsementsov@virtuozzo.com>
	<91a97b47-abab-4508-09d5-a12ddd1a4101@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4a689a27-645c-da07-4512-ba4ed7e212cb@redhat.com>
Date: Thu, 10 Jan 2019 01:15:42 -0600
MIME-Version: 1.0
In-Reply-To: <91a97b47-abab-4508-09d5-a12ddd1a4101@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vOkk1BeywDlAKrvxVNOMiZSqoqkGK7QeS"
Subject: Re: [Qemu-devel] [PATCH v5 4/6] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, armbru@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vOkk1BeywDlAKrvxVNOMiZSqoqkGK7QeS
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, armbru@redhat.com,
 mreitz@redhat.com
Message-ID: <4a689a27-645c-da07-4512-ba4ed7e212cb@redhat.com>
Subject: Re: [PATCH v5 4/6] nbd/server: implement dirty bitmap export
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
 <20180609151758.17343-5-vsementsov@virtuozzo.com>
 <91a97b47-abab-4508-09d5-a12ddd1a4101@redhat.com>
In-Reply-To: <91a97b47-abab-4508-09d5-a12ddd1a4101@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/9/19 1:21 PM, Eric Blake wrote:
> Revisiting an older thread:
>=20
> On 6/9/18 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Handle new NBD meta namespace: "qemu", and corresponding queries:
>> "qemu:dirty-bitmap:<export bitmap name>".
>>
>> With new metadata context negotiated, BLOCK_STATUS query will reply
>> with dirty-bitmap data, converted to extents. New public function
>> nbd_export_bitmap selects bitmap to export. For now, only one bitmap
>> may be exported.
>>

>> +    if (bdrv_dirty_bitmap_enabled(bm)) {
>> +        error_setg(errp, "Bitmap '%s' is enabled", bitmap);
>> +        return;
>> +    }
>=20
> Why are we restricting things to only export disabled bitmaps?
>=20
> I can understand the argument that if the image being exported is
> read-only, then an enabled bitmap _that can be changed_ is probably a
> bad idea (it goes against the notion of the export being read only).
> But if we were to allow a writable access to an image, wouldn't we
> expect that writes be reflected into the bitmap, which means permitting=

> an enabled bitmap?

I've now addressed this in my v2 Promote x-nbd-server-add-bitmap to
stable series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--vOkk1BeywDlAKrvxVNOMiZSqoqkGK7QeS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw28R4ACgkQ3g5py3or
ov278wf/QGYgFveU6Jxd0NDP+iYYqcCP3KOeMqU2JGiY7nrrmPvT2wfyMW38P0or
hWZ+3Qo4g10IQvFo2QOer77B3OF+HJEXL+2s+JZuOMLf+hQPcVYg6DI5M+wMGPwp
upcMSBVcFEElqtXL2p1DXPFYy3NfpgIRP/3Kd4V1g+sMkURCc7x3tkMBG87Shyao
ql8EGrXhT3PORJiErR6Jqf4i/D6TyyU4wvhA+mkZ3naPU5leqd/Xu2AKuKO4cauU
YyTJ26CErLj1oVXEqkfV4UqAsyj/QOi4QcSonCblDbFl3vUlxZls8VAXLucAkAoA
JV6XzVsmRIV5km+Vnhwk4IBDJbIHXg==
=OBvK
-----END PGP SIGNATURE-----

--vOkk1BeywDlAKrvxVNOMiZSqoqkGK7QeS--
