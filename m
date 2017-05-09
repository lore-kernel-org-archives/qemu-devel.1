Received: from eggs.gnu.org ([2001:4830:134:3::10]:57806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d89jW-0001Kg-Dl
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d89jV-000249-FG
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:19:38 -0400
References: <20170509180946.17046-1-jsnow@redhat.com>
	<0a25ed7b-174f-1860-cef4-d141b5de3d64@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09281d7d-82f1-fdd8-5f03-669f13b2f09d@redhat.com>
Date: Tue, 9 May 2017 13:19:23 -0500
MIME-Version: 1.0
In-Reply-To: <0a25ed7b-174f-1860-cef4-d141b5de3d64@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qCVxH4pms1m7MjlknC0RV66kECWqbAf1P"
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: Check for backing image if
 specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qCVxH4pms1m7MjlknC0RV66kECWqbAf1P
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <09281d7d-82f1-fdd8-5f03-669f13b2f09d@redhat.com>
Subject: Re: [PATCH v2] qemu-img: Check for backing image if specified during
 create
References: <20170509180946.17046-1-jsnow@redhat.com>
 <0a25ed7b-174f-1860-cef4-d141b5de3d64@redhat.com>
In-Reply-To: <0a25ed7b-174f-1860-cef4-d141b5de3d64@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 01:17 PM, Eric Blake wrote:
> On 05/09/2017 01:09 PM, John Snow wrote:
>> Or, rather, force the open of a backing image if one was specified
>> for creation. Using a similar -unsafe option as rebase, allow qemu-img=

>> to ignore the backing file validation if possible.
>>

>> +++ b/qemu-img.c
>> @@ -145,9 +145,11 @@ static void QEMU_NORETURN help(void)
>>             "  'snapshot_id_or_name' is deprecated, use 'snapshot_para=
m'\n"
>>             "    instead\n"
>>             "  '-c' indicates that target image must be compressed (qc=
ow format only)\n"
>> -           "  '-u' enables unsafe rebasing. It is assumed that old an=
d new backing file\n"
>> -           "       match exactly. The image doesn't need a working ba=
cking file before\n"
>> -           "       rebasing in this case (useful for renaming the bac=
king file)\n"
>> +           "  '-u' allows unsafe backing chains. For rebasing, it is =
assumed that old and new\n"
>> +           "       backing file match exactly. The image doesn't need=
 a working backing file\n"
>> +           "       before rebasing in this case (useful for renaming =
the backing file)\n"

Also, a '.' to end this sentence would be nice.

>> +           "       For image creation, allow creating without attempt=
ing to"
>=20
> Missing \n
>=20
> With that fixed,
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qCVxH4pms1m7MjlknC0RV66kECWqbAf1P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEggrAAoJEKeha0olJ0NqkD0H/2XLvbOQoxeTrG1+C/u+dWW9
RdxCSXhLQOHd1bscTZ99KS/TkuWpNGhOp1AFNrejYG8plZgsN5yyCOYIMbpClcny
sSFH4Fz2YusYUboBviuK8SDCd6GwdJ5uGJi3vETk6+9KG+FNowBI3q085VlKiAif
mvlCVBuSjRMk0lwg4p1U+6lOc0V97FTU0HaJvvyi7cTWA9hUor1iVTYf1DrXYuwb
RUueTGpFjpseCVP6Mt3thvu9AvEk7O+99S50A7NpIb37kNNW4h/vpOSMEEkuXCQY
qWK0MZQA2l/fIu4FhZlABlkBqSBdCnvj6bZOB6Ej6q8kktblgj3UAuyIIhcDaDA=
=6dtj
-----END PGP SIGNATURE-----

--qCVxH4pms1m7MjlknC0RV66kECWqbAf1P--
