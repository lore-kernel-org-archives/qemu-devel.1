Received: from eggs.gnu.org ([2001:4830:134:3::10]:40530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyRox-0000UK-Qy
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 19:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyRow-0000J3-Ud
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 19:37:07 -0400
References: <20170412174920.8744-1-eblake@redhat.com>
	<20170412174920.8744-4-eblake@redhat.com>
	<bdff9bc8-a521-ddd6-3c71-bb97976b75ec@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <44a88413-bbe0-c67f-8700-d3777888647c@redhat.com>
Date: Wed, 12 Apr 2017 18:36:54 -0500
MIME-Version: 1.0
In-Reply-To: <bdff9bc8-a521-ddd6-3c71-bb97976b75ec@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CiUOqdkn9Gf8U3CgBBEoum8JfNgRJJSGw"
Subject: Re: [Qemu-devel] [PATCH 03/12] dirty-bitmap: Drop unused functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CiUOqdkn9Gf8U3CgBBEoum8JfNgRJJSGw
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <44a88413-bbe0-c67f-8700-d3777888647c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/12] dirty-bitmap: Drop unused functions
References: <20170412174920.8744-1-eblake@redhat.com>
 <20170412174920.8744-4-eblake@redhat.com>
 <bdff9bc8-a521-ddd6-3c71-bb97976b75ec@redhat.com>
In-Reply-To: <bdff9bc8-a521-ddd6-3c71-bb97976b75ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 05:47 PM, John Snow wrote:
>=20
>=20
> On 04/12/2017 01:49 PM, Eric Blake wrote:
>> We had several functions that no one was using, and which used
>> sector-based interfaces.  I'm trying to convert towards byte-based
>> interfaces, so it's easier to just drop the unused functions:
>>
>> bdrv_dirty_bitmap_size
>> bdrv_dirty_bitmap_get_meta
>> bdrv_dirty_bitmap_reset_meta
>> bdrv_dirty_bitmap_meta_granularity
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  include/block/dirty-bitmap.h |  8 --------
>>  block/dirty-bitmap.c         | 34 ----------------------------------
>>  2 files changed, 42 deletions(-)
>>

>=20
> I think it's likely Vladimir is or at least was relying on some of thes=
e
> for his migration and persistence series.
>=20
> Might be nice to let him chime in to see how much of a hassle this is.

Then let's add him in cc ;)

I'm okay if these functions stay because they have a user, but it would
also be nice if they were properly byte-based (like everything else in
dirty-bitmap at the end of my series).  So even if we remove them here,
we can revert the removal, and re-add them but with a sane interface.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CiUOqdkn9Gf8U3CgBBEoum8JfNgRJJSGw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7roWAAoJEKeha0olJ0NqUpcH/i7MGXqQfnjnzePnR6mJQI71
drlutT9LcyyE7rZF2mtDySIlyISAQNeUsUTbXnxCa9K7FUbUr8rlmnbAXmSxIL0Z
2a8hAOyuZ019CWa/DwVsxSZRvNABt7IyUEYCMpBJhxrl6mqw1DK9sdRtuqF7h0Xt
BJJBFIn4nIPtwIYCJUf9zoKstHd/7WvFkqTgCZgYYBh7mveFxQRlT4BAm2Tfp7Lm
tLFe+Kca6rewJMXrn3yh2Z3EnCO7twn2TdcilcG7HTWSmg5PGt2buzvLAsvhdwUF
Lt071UghMx+6zdfyDc2lO77jWK5rEfgCmPOstsNMDPhI1DkuWFuLiWsZo2O4fUI=
=WgVv
-----END PGP SIGNATURE-----

--CiUOqdkn9Gf8U3CgBBEoum8JfNgRJJSGw--
