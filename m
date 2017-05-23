Received: from eggs.gnu.org ([2001:4830:134:3::10]:46374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDArU-0002ly-HG
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDArQ-000852-Gw
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDArQ-00084N-7h
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:32:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4723764DA9
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 14:32:30 +0000 (UTC)
References: <20170522213636.11550-1-eblake@redhat.com>
	<87efvghsql.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <76e4af58-9642-d1c5-39a8-f39c6c6d0240@redhat.com>
Date: Tue, 23 May 2017 09:32:24 -0500
MIME-Version: 1.0
In-Reply-To: <87efvghsql.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="m7FEarURU3PqEeORDJviS0KgF7jf9RrE3"
Subject: Re: [Qemu-devel] [PATCH] qapi: Fix some blockdev-add documentation
 regressions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m7FEarURU3PqEeORDJviS0KgF7jf9RrE3
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Message-ID: <76e4af58-9642-d1c5-39a8-f39c6c6d0240@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qapi: Fix some blockdev-add documentation
 regressions
References: <20170522213636.11550-1-eblake@redhat.com>
 <87efvghsql.fsf@dusky.pond.sub.org>
In-Reply-To: <87efvghsql.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 03:39 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> In the process of getting rid of docs/qmp-commands.txt, we
>> managed to regress on any text that changed after the point
>> where the move was first branched and when the move actually
>> occurred.  For example, commit 3282eca for blockdev-snapshot
>> re-added the extra "options" layer which had been cleaned up
>> in commit 0153d2f.
>>
>> While I didn't audit for all such regressions, I did scrub
>> for all bogus uses of nested "options".
>=20
> I figure anything that changed in qmp-commands.txt between the first
> base of Marc-Andr=C3=A9's work and its merge into master is at risk.
>=20
> I don't know the exact first base.  "[PATCH 00/30] Move qapi
> documentation to schema (part 1/5)" was posted on 2016-09-13.  Septembe=
r
> 2016 looks like a fair guess.  With a bit of extra margin:

Thanks for the audit!

>=20
> Please throw in a fix for the remaining regression of 'eject'.  Whether=

> you squash it into this one or keep it separate is up to you.  For this=

> part:
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

I'll post a v2, since I have another pending doc patch that hasn't been
reviewed yet, and since your audit means I need to update my commit
message anyway.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--m7FEarURU3PqEeORDJviS0KgF7jf9RrE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJEf4AAoJEKeha0olJ0NqRsUH/R/f27HBQuTjUjmIZN0sTtEi
ttkNydYUJd1MEriK/B+1urIzb8H3fuIYhkcy+dVOKgXqH/5ljBts7JQAXcpzbREi
ppklzvgo3YylCntjjpJdWswvskJk7eI1ohpxjMrLSsAtN42PfkERSFOYQ4S9ux2F
ie10r9+0EoCmuXojB8aYhmx3SltD5ZyJk2TbQedWkhpnms6SKgmLyt1sP7zuCnwt
v3glUN5EyL9BnpPhXit+IqFnCaR4J+LTY9flH++jsLBlmvdDoNePcanrnv6B0uMW
Qnheo6WYnIfvgYpJM/GGeDZ7JL3M3OAc0HXtGaPGqTEC+nBwoFR3vGnHEa+mHPY=
=By8E
-----END PGP SIGNATURE-----

--m7FEarURU3PqEeORDJviS0KgF7jf9RrE3--
