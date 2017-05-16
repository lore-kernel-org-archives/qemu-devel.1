Received: from eggs.gnu.org ([2001:4830:134:3::10]:51561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAf1n-00060z-MP
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAf1j-0005Z0-1U
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:08:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAf1i-0005XS-Nx
	for qemu-devel@nongnu.org; Tue, 16 May 2017 12:08:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82A8E7246E
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 16:08:40 +0000 (UTC)
References: <20170516111123.17692-1-quintela@redhat.com>
	<20170516111123.17692-3-quintela@redhat.com>
	<87shk4g9yb.fsf@dusky.pond.sub.org> <87o9usdg6e.fsf@secure.mitica>
	<87h90kbxmd.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09f00bd1-df05-c6b3-8423-cb790feddcc2@redhat.com>
Date: Tue, 16 May 2017 11:08:35 -0500
MIME-Version: 1.0
In-Reply-To: <87h90kbxmd.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1rC367lEgREvaAPQrhQ4idb9vlHRcngXb"
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: Create block capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1rC367lEgREvaAPQrhQ4idb9vlHRcngXb
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com
Message-ID: <09f00bd1-df05-c6b3-8423-cb790feddcc2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: Create block capability
References: <20170516111123.17692-1-quintela@redhat.com>
 <20170516111123.17692-3-quintela@redhat.com>
 <87shk4g9yb.fsf@dusky.pond.sub.org> <87o9usdg6e.fsf@secure.mitica>
 <87h90kbxmd.fsf@dusky.pond.sub.org>
In-Reply-To: <87h90kbxmd.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/16/2017 11:00 AM, Markus Armbruster wrote:

>>>>  #          periodic mode. (Since 2.8)
>>>>  #
>>>> +# @block-incremental: enable block incremental migration (Since 2.1=
0)
>>>> +#
>>>
>>> What's "block incremental migration" and why should I care?
>>
>> This is good, I will try.
>>
>> "block incremental migration assumes that we have a base image in both=

>> sides, and then we continue writting in one of the sides.  This way we=

>> need to only migrate the changes since the previous state where it was=

>> the same in both sides".
>>
>> I am not sure what to put there, really.
>=20
> Well, to suggest something, I'd first have to figure out WTF incrementa=
l
> block migration does.  Your text helps me some, but not enough.  What
> exactly is being migrated, and what exactly is assumed to be shared
> between source and destination?
>=20
> Block migration is scandalously underdocumented.

If I have:

base <- active

on the source, then:

block migration without incremental creates:

active

on the destination (the entire disk contents are migrated).  Conversely,
block migration WITH incremental assumes that I have pre-created 'base'
on the destination (easy to do, since base is read-only so it can be
copied prior to starting the migration), and the migration results in:

base <- active

on the destination, where only the contents of active were transferred
by qemu.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1rC367lEgREvaAPQrhQ4idb9vlHRcngXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGyQEAAoJEKeha0olJ0NqrNwH/3NkzoKlNF5odccKgQ5rVO/p
WX0uAxrFeVdJbEUv4ij2YzaOat9oRFyUIawG4KNaFOI+99h2eEHlFznwisK08hdO
/LAKmSgpWFzCTXMzRlETpNLTGu0BN6coS3soqBlVk1S3tfKD7uAmukskR3cPBe8u
50MDxBW647XkfiQ9fttztdcn33ciOMl09dTmJutnVR0dG2LiDBquDbBlpha6OLjY
3wNu3wKewDi69S3XO8CoJM3cKi4UKtmrla9LzHwqoUOn/XrD7yLJzSRLfI0K4HT1
fBOEIwRarWn5nGC8PDR1AC0BXT24r/vTUedeaokHB8KtYUImd7irq77Flh+Rq7o=
=yhm5
-----END PGP SIGNATURE-----

--1rC367lEgREvaAPQrhQ4idb9vlHRcngXb--
