Received: from eggs.gnu.org ([2001:4830:134:3::10]:60014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFi9z-00026J-KL
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eFi9q-00048A-5M
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:02:27 -0500
References: <20171023092945.54532-1-vsementsov@virtuozzo.com>
	<20171117123059.GB4795@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b95aaa97-39d0-fdc1-21a1-2e0ea7acac17@redhat.com>
Date: Fri, 17 Nov 2017 16:01:56 +0100
MIME-Version: 1.0
In-Reply-To: <20171117123059.GB4795@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8d1EGbFmIvtbWs1Exxia2J1wpDtCRGUtH"
Subject: Re: [Qemu-devel] [PATCH] block/snapshot: dirty all dirty bitmaps on
 snapshot-switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8d1EGbFmIvtbWs1Exxia2J1wpDtCRGUtH
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com,
 jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com
Message-ID: <b95aaa97-39d0-fdc1-21a1-2e0ea7acac17@redhat.com>
Subject: Re: [PATCH] block/snapshot: dirty all dirty bitmaps on
 snapshot-switch
References: <20171023092945.54532-1-vsementsov@virtuozzo.com>
 <20171117123059.GB4795@localhost.localdomain>
In-Reply-To: <20171117123059.GB4795@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-17 13:30, Kevin Wolf wrote:
> Am 23.10.2017 um 11:29 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> Snapshot-switch actually changes active state of disk so it should
>> reflect on dirty bitmaps. Otherwise next incremental backup using
>> these bitmaps will be invalid.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>=20
> We discussed this quite a while ago, and I'm still not convinced that
> this approach makes sense.

I think it at least makes more sense than not handling this case at all.

> Can you give just one example of a use case where dirtying the whole
> bitmap while loading a snapshot is the desired behaviour?
>=20
> I think the most useful behaviour would be something where the bitmaps
> themselves are snapshotted, too.

Agreed.

>                                  But for the time being, the easiest an=
d
> safest solution might just be to error out in any snapshot operations
> if any bitmaps are in use.

Sounds OK, too.  I personally don't have an opinion either way.

But in any case, what we did before this patch was definitely wrong so I
consider it an improvement.

Max


--8d1EGbFmIvtbWs1Exxia2J1wpDtCRGUtH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloO+eQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AlgoIAKOKOq/v0mGsXHa3JqDbSmfrkJI/yASc
z7AxmA1UCsVNyNk0M7RGjs3I5o3LNXWZdyOzXpW9ZQju1B3O0ZUSZ9JVSuCqfy42
WTNp/yVWECqynoRUeTSY3hWvYXbM64tOrX+OK7kDCIL+3i2jP5HwOBqDKBOtdNmL
InEfoHnN01GJPz8vTsiB9FN1wbYSD+GKHHPslTP871vz1e3xYZwwA1WqJDt2ebWK
yO8/KGO9VpkyZ8MuzAxFubFqX8B1QMsJJu+XNuYZBdt6Auh5CLhho7NQGpXxbQRQ
+W8qagIVgouhqzEaaPydWVQ65bN3wpqmzhEi0petMp1RMC8hcn30DGI=
=3uaP
-----END PGP SIGNATURE-----

--8d1EGbFmIvtbWs1Exxia2J1wpDtCRGUtH--
