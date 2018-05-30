Received: from eggs.gnu.org ([2001:4830:134:3::10]:35279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO3vs-0004bV-Mf
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO3vr-0004Ub-Ri
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:26:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fO3vr-0004UN-Lp
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:26:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 491CDBB415
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:26:39 +0000 (UTC)
Date: Wed, 30 May 2018 17:26:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530162634.GE5973@stefanha-x1.localdomain>
References: <20180529055755.12404-1-peterx@redhat.com>
	<20180529055755.12404-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
In-Reply-To: <20180529055755.12404-4-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 3/7] monitor: more comments on lock-free
 elements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 01:57:51PM +0800, Peter Xu wrote:
> Add some explicit comments for both Readline and cpu_set/cpu_get helpers
> that they do not need the mon_lock protection.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDtC5AAoJEJykq7OBq3PISJ8H/iuNyuKe4HCRZH5VRHGokJwi
PvG/CYZmczT4xLN4fIpEYm6lZsrbastXgSxRim97RviLjKihpq0c0u7WZRlqpttX
XpRZDyPf0l8knbiiSnbU9RUjl1R1YDx/54iwm7NkV0GqSbQWatbo4gvEqgA6jiZK
3w6Kg3wU5o5E9ZZTiYSGvUTh9bXodQa7Uye3JxJBAjPfQKUpjCa1Jab3XZGevXLA
RO8VQLtWvjBA41NtOPqx4K81v0d0/OrhfNRbM9E+NkK3bbvSDdR7KIIBe20oSpPe
lz0w14gn4GKNSrJEN93bJwQa/3njI23d0Gm6sicAltKY1XJ7lmAakac6tpWSZ3s=
=RwQe
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
