Received: from eggs.gnu.org ([2001:4830:134:3::10]:36024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyfpX-00052C-PJ
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyfpW-0003Bn-TT
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:34:39 -0400
References: <20170411155226.6395-1-mreitz@redhat.com>
	<20170413132825.GB13387@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <50cc7a90-607a-f10e-f1d8-403e8fe75d77@redhat.com>
Date: Thu, 13 Apr 2017 16:34:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170413132825.GB13387@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UlleCxSl7bs6x4vM1cwqFtNkKoqqaaceI"
Subject: Re: [Qemu-devel] [PATCH for-2.10] Revert "block/io: Comment out
 permission assertions"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UlleCxSl7bs6x4vM1cwqFtNkKoqqaaceI
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <50cc7a90-607a-f10e-f1d8-403e8fe75d77@redhat.com>
Subject: Re: [PATCH for-2.10] Revert "block/io: Comment out permission
 assertions"
References: <20170411155226.6395-1-mreitz@redhat.com>
 <20170413132825.GB13387@stefanha-x1.localdomain>
In-Reply-To: <20170413132825.GB13387@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 13.04.2017 15:28, Stefan Hajnoczi wrote:
> On Tue, Apr 11, 2017 at 05:52:26PM +0200, Max Reitz wrote:
>> This reverts commit e3e0003a8f6570aba1421ef99a0b383a43371a74.
>>
>> This commit was necessary for the 2.9 release because we were unable t=
o
>> fix the underlying issue(s) in time. However, we will be for 2.10.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block.c    |  6 +-----
>>  block/io.c | 12 ++----------
>>  2 files changed, 3 insertions(+), 15 deletions(-)
>=20
> Should we merge a fix before enabling the assertion again?  It's a know=
n
> issue.  Let people using qemu.git live a little and have fun without th=
e
> inevitable SIGABRT coredumps.  We don't benefit if more people encounte=
r
> this crash and duplicate work debugging it.

Yes, we should probably merge the fixes we know about before. But after
that, I'd rather merge this patch as soon as possible so we do have a
chance of getting more reports (if anything else is broken) before the
next freeze. :-)

Max


--UlleCxSl7bs6x4vM1cwqFtNkKoqqaaceI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljvjHASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYtIH/jMsVaBZ6YvgDTE7seUlQSZCXAygm9Bb
2M4qzrg81yFqZVpdNC4E3jhpDLU9MbziI8ghwjYzVql1Ps27Laim8EsordW8nqKb
niT4XM1o6/YJPLsdfnDRoRLDGNHDJoHOOiURxeR6aqg0KCdZhecE0AbVOQJeNgE9
EwH1szOwHbxLl4v4QD1kdpfx9WaVpfLo/LSdfWUk9c44fuib7dZ9vwPt1bId97Ba
SuIGDp1J2sVaZ+y1CqYOoQwBd8VU1WoakGnqtREU4jbuNEu4j1RZDyqKDcaOnYz0
PgRHOv2iDLsHGSY8NvVxgA2/hzK6/QolBTUAnFleUHa8wKN12vlI1/c=
=vDMP
-----END PGP SIGNATURE-----

--UlleCxSl7bs6x4vM1cwqFtNkKoqqaaceI--
