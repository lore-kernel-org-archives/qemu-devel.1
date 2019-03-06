Received: from eggs.gnu.org ([209.51.188.92]:57762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1YU8-0002a8-9q
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1YU7-0007mP-Lm
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:29:32 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-7-jsnow@redhat.com>
	<5d204716-dc54-70ac-8b67-266ce8f44e0e@redhat.com>
	<ce11fd2d-0b28-9b67-2382-506f0bfd8754@redhat.com>
	<15751e4f-6415-219f-036b-26a3515a72ce@redhat.com>
	<93e3f474-0235-7500-b4c7-3a4da17b29dd@redhat.com>
	<eab2ced5-9079-d302-18ec-24eda2ea836d@virtuozzo.com>
	<7c1549db-3a4c-9100-ed7b-5e8bce39081b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c2065cc3-7599-d7a6-17b5-c1362b02b5c2@redhat.com>
Date: Wed, 6 Mar 2019 09:29:25 -0600
MIME-Version: 1.0
In-Reply-To: <7c1549db-3a4c-9100-ed7b-5e8bce39081b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6cOw7EJrrLgI109JUTKOfYbC3P1a6bLeX"
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/dirty-bitmaps: disallow busy
 bitmaps as merge source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6cOw7EJrrLgI109JUTKOfYbC3P1a6bLeX
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <c2065cc3-7599-d7a6-17b5-c1362b02b5c2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/dirty-bitmaps: disallow busy
 bitmaps as merge source
References: <20190301191545.8728-1-jsnow@redhat.com>
 <20190301191545.8728-7-jsnow@redhat.com>
 <5d204716-dc54-70ac-8b67-266ce8f44e0e@redhat.com>
 <ce11fd2d-0b28-9b67-2382-506f0bfd8754@redhat.com>
 <15751e4f-6415-219f-036b-26a3515a72ce@redhat.com>
 <93e3f474-0235-7500-b4c7-3a4da17b29dd@redhat.com>
 <eab2ced5-9079-d302-18ec-24eda2ea836d@virtuozzo.com>
 <7c1549db-3a4c-9100-ed7b-5e8bce39081b@redhat.com>
In-Reply-To: <7c1549db-3a4c-9100-ed7b-5e8bce39081b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/6/19 9:24 AM, John Snow wrote:

>>>
>>> We could always split it back out later, but in basic terms for
>>> permissions and user perspective, "in use" seems robust enough of a
>>> resolution. (It might be safe to read, it might not be, who knows --
>>> it's in use.)
>>
>> I think, if we need some kind of sharing busy bitmaps, it should be tw=
o
>> busy states: one, which allows reads for other users and one that does=
n't.
>>

Indeed, similar to flock having shared (multiple read-only users) and
exclusive (single writer) locks.  So it's nice to know we have a
technical plan for growth, if we have a reason to use that plan.

>=20
> I think that's... hopefully premature. We don't need this NOW do we?

No, we don't need it now.

>=20
> I think this is OK as-is.

It sounds like we are in violent agreement ;)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6cOw7EJrrLgI109JUTKOfYbC3P1a6bLeX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlx/51UACgkQp6FrSiUn
Q2o+ogf/bdSFjOhhgjK09hYinpl9hYSsnBRgjIYPKR6DMbRdeTASavXhS/TSWJp7
hAKl7ps3Px4ZG381djcFfvNyXP1p/coi1Qh9foPKl8u7zfrbWOnd5vjYoNhIjf4J
DXuNWXpLWPKZuafI3ivcBcHdQfs+Et/SIGvS+DxkVOReFkdZ8vE6HjypJny/83A0
udyBfKwstoG/wNEHvTpEk0RrHN3ytzBhjp7uRZtEC6szpgX1t2VxQJC+tQ4sez48
b7rK34mNt4fEg8N2Q24lcbcPrKtdGGVsDdGUT5/FmuMgLhG0aUFQ78vCvnOHH5JY
ypk2Nie+NmsmXGKesI3rZgsFnZNowA==
=2H3i
-----END PGP SIGNATURE-----

--6cOw7EJrrLgI109JUTKOfYbC3P1a6bLeX--
