Received: from eggs.gnu.org ([2001:4830:134:3::10]:36959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsSn8-0002Iu-2G
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsSn7-0006Uf-0O
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:58:46 -0400
References: <20170912203119.24166-1-eblake@redhat.com>
	<20170912203119.24166-12-eblake@redhat.com>
	<8db498fd-6f7f-ee78-da44-8e0087243ef1@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <228fb135-f4d4-9a35-18c9-584dc3354bb5@redhat.com>
Date: Thu, 14 Sep 2017 06:58:33 -0500
MIME-Version: 1.0
In-Reply-To: <8db498fd-6f7f-ee78-da44-8e0087243ef1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="55AVV01I7nL3RV6NqMfaADv2KsstVFx9V"
Subject: Re: [Qemu-devel] [PATCH v7 11/20] dirty-bitmap: Change
 bdrv_dirty_iter_next() to report byte offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--55AVV01I7nL3RV6NqMfaADv2KsstVFx9V
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>,
 qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <228fb135-f4d4-9a35-18c9-584dc3354bb5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 11/20] dirty-bitmap: Change
 bdrv_dirty_iter_next() to report byte offset
References: <20170912203119.24166-1-eblake@redhat.com>
 <20170912203119.24166-12-eblake@redhat.com>
 <8db498fd-6f7f-ee78-da44-8e0087243ef1@redhat.com>
In-Reply-To: <8db498fd-6f7f-ee78-da44-8e0087243ef1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2017 07:15 PM, John Snow wrote:
>=20
>=20
> On 09/12/2017 04:31 PM, Eric Blake wrote:
>> Thanks to recent cleanups, most callers were scaling a return value
>> of sectors into bytes (the exception, in qcow2-bitmap, will be
>> converted to byte-based iteration later).  Update the interface to
>> do the scaling internally instead.
>>
>> In qcow2-bitmap, the code was specifically checking for an error
>> to be -1; it is more robust to treat all negative values as an
>> error, but at the same time it is also easy enough to ensure we
>> return -1 (and not -512) on error.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>=20
> This patch now smells like a bugfix and a separate incremental feature
> enhancement.

There is no bug without this patch; more of a fix to avoid a latent
regression from happening in further changes.  In v6, I (accidentally)
had bdrv_dirty_iter_next() temporarily returning -512 instead of -1 on
failure; changing the qcow2 code to treat all negatives instead of
precisely -1 as error is enough to avoid that regression, but so also is
fixing bdrv_dirty_iter_next() to always return -1 on failure.  This
patch does both, rather than either fix in isolation, but that means we
don't need a backport.

>=20
> Do we need to backport the error-checking to a possible 2.10.1?
>=20
> If no:
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--55AVV01I7nL3RV6NqMfaADv2KsstVFx9V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm6bukACgkQp6FrSiUn
Q2rYfQf8C6RBmZKszJqfwSWtekfhaQ8+J1f2tIUyXEiuo0HzQgFcMf7SHsWIFmu1
gVAceKAEbWWYHzA4wc+keUvaR/RN/1frFLZnRxpvAkEjjjWN9Tdp0wxAm4fpBsm4
JZSyMhDb/PMJs+9IepobDxEkDJkpBhYUcYZCGz3e7aelXi7IV7uiRV8ebiLfByaR
DRVrPhbiyXlBzlxPO0GE3vNcFCSG/fdNUWoF40XIid7wMwZoUHGCogC0cuOoiKc4
dW4JNnxkPiR0LXTD45s7mNcQAzYjST+7XuKbYjg2sIkV6LP8qo8/Ga0Qtr6UciS5
aGO7wO9jotkMNh7CdFwSBEQ6IGbyww==
=wglv
-----END PGP SIGNATURE-----

--55AVV01I7nL3RV6NqMfaADv2KsstVFx9V--
