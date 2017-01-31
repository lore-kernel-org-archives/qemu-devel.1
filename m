Received: from eggs.gnu.org ([2001:4830:134:3::10]:60500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYhpa-0004G0-O0
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYhpZ-0001fe-QM
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:27:22 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-25-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d7e217d7-2080-ebaa-3d66-f97a64770a31@redhat.com>
Date: Wed, 1 Feb 2017 00:27:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170123121036.4823-25-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gwo4p7WX0vAXSBsfi92ViiQdhGbgxp1uN"
Subject: Re: [Qemu-devel] [PATCH 24/24] qcow2-bitmap: cache bitmap list in
 BDRVQcow2State
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gwo4p7WX0vAXSBsfi92ViiQdhGbgxp1uN
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <d7e217d7-2080-ebaa-3d66-f97a64770a31@redhat.com>
Subject: Re: [PATCH 24/24] qcow2-bitmap: cache bitmap list in BDRVQcow2State
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-25-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-25-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
> Do not reload bitmap list every time it is needed.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 125 ++++++++++++++++++++++++++++++++++---------=
--------
>  block/qcow2.c        |   2 +
>  block/qcow2.h        |   4 ++
>  3 files changed, 89 insertions(+), 42 deletions(-)

Hm, difficult. On a glance, this patch seems alright, and it probably
makes sense. Maybe it would make the code actually a bit easier to
understand if it was squashed into the other patches. But OTOH it would
mean that I would have to start review from scratch for those patches...

So in my opinion this patch makes sense and you should keep it updated,
but I think we should keep it separate from the rest of the series. Get
the first 23 patches in first and then we can merge this on top later on.=


Would that be OK?

Max


--gwo4p7WX0vAXSBsfi92ViiQdhGbgxp1uN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRHU8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AnzAIALX5gGahM/ptv42b79v4qBaO2AM8eNGm
5AOfEgSyQhdUva8FVv4u2Zc7ZD8iJe3hW3turNe+qCyw4uaRQ8BkGwDw/W1WCtSa
2JbqhIgEpqX0gvFyTilxpIEUSA/ghB2pTkzfL51zgdSkZTZlrzycdT9ut5Tf6EFG
ha2+8Ne0Kbj00dW4VFJ1W76B235G0CV6TiE1dKmB6YvFjJJ9J7RGLvLvdNNaUOEO
CY92q5SmKGQ7cL9e9OLNqw+PUFqEDToV+5SykYsHdzOYC2gKr5cIKmInZwZvteLV
ksmFS524kTiI7s3xioM9K/4198zS8jrxqGJv2MqVqKz14nHlKaFpFGQ=
=LX/p
-----END PGP SIGNATURE-----

--gwo4p7WX0vAXSBsfi92ViiQdhGbgxp1uN--
