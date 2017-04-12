Received: from eggs.gnu.org ([2001:4830:134:3::10]:50977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyIAS-00054F-4S
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyIAO-00018R-6A
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:18:40 -0400
References: <20170411185034.13460-1-eblake@redhat.com>
	<20170411185034.13460-8-eblake@redhat.com>
	<87inmaw20v.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c436e037-5cf7-05ec-c6a8-7f5ea8b832e8@redhat.com>
Date: Wed, 12 Apr 2017 08:18:13 -0500
MIME-Version: 1.0
In-Reply-To: <87inmaw20v.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rTbtMrbn9roAR7q47VfmU67PixKjndJlh"
Subject: Re: [Qemu-devel] [PATCH v4 07/13] block: Use simpler QDict/QList
 scalar insertion macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:blkdebug" <qemu-block@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, Stefan Weil <sw@weilnetz.de>, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rTbtMrbn9roAR7q47VfmU67PixKjndJlh
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Josh Durgin <jdurgin@redhat.com>, Fam Zheng <famz@redhat.com>,
 "open list:blkdebug" <qemu-block@nongnu.org>,
 "Richard W.M. Jones" <rjones@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>,
 Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c436e037-5cf7-05ec-c6a8-7f5ea8b832e8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 07/13] block: Use simpler QDict/QList
 scalar insertion macros
References: <20170411185034.13460-1-eblake@redhat.com>
 <20170411185034.13460-8-eblake@redhat.com>
 <87inmaw20v.fsf@dusky.pond.sub.org>
In-Reply-To: <87inmaw20v.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 01:52 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> We now have macros in place to make it less verbose to add a scalar
>> to QDict and QList, so use them.
>>
>> Patch created mechanically via:
>>   spatch --sp-file scripts/coccinelle/qobject.cocci \
>>     --macro-file scripts/cocci-macro-file.h --dir block --in-place
>> then touched up manually to fix a couple of '?:' back to original spac=
ing.
>>
>> For ease of review, the mechanical work was split by tree location:
>> this only touches files under block/; there are other block-related
>> files (like top-level block.c) that will be fixed in a later global
>> cleanup.
>=20
> I don't like this split.  Splitting out *subsystems* may ease review,
> but this splits out directory block/, which is only a part of the block=

> subsystem.  Explaining this takes you more than three dozen words.  I'd=

> prefer either the whole block subsystem (as defined in MAINTAINERS)
> split out, or no split.
>=20
> I'm willing to accept the split as is anyway if block maintainers are
> okay with it.
>=20
> I'm also willing to squash the three parts on commit.

I'm leaning towards squashing the three into one.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rTbtMrbn9roAR7q47VfmU67PixKjndJlh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7ikVAAoJEKeha0olJ0NqzeoIAI/X+14AXzJMbE/DmuqOA5aW
KMjX31XqBo+nm+Z06cZhe2UoZVJi0GhMh5nzY4WTprdcipiOCxH9+Oa8FW+AJh/f
rjHnMIEkvH6/oNFbRj7vkIGsjQLr+NCmDW2F5dsec1O/pc4EWLOuKrwGCheGCjfr
N6Gb0QNXWjdmMJbDCKD2uWM88h1vhMk3kWdKq8Zb45aKlzeek4OQfb/ZbmDE3Z5d
vSLZnbB/NBLGKdCtDZud2R37zrEml5tDRQopJOi7lFgV7k/6ah2dplZeMRNK/5GW
IjfEfTc2zGpqJwTcb1sm59Dbp2jq1d+3Td7tVLFsUpOm53unEhcCrsvbr1wmay8=
=e397
-----END PGP SIGNATURE-----

--rTbtMrbn9roAR7q47VfmU67PixKjndJlh--
