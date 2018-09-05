Received: from eggs.gnu.org ([2001:4830:134:3::10]:39928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxVHw-0004xO-HC
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 06:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxVHv-0005ou-Ol
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 06:43:56 -0400
References: <20180904170930.28619-1-jsnow@redhat.com>
	<20180904170930.28619-7-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cd9e2b78-9aa1-b988-fe15-b7f59f8bd5d1@redhat.com>
Date: Wed, 5 Sep 2018 12:43:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180904170930.28619-7-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8MDaaJmMvS7Sa9YoGibchYEm3W8omXeEv"
Subject: Re: [Qemu-devel] [PATCH v4 06/15] block/mirror: conservative
 mirror_exit refactor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8MDaaJmMvS7Sa9YoGibchYEm3W8omXeEv
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Eric Blake <eblake@redhat.com>
Message-ID: <cd9e2b78-9aa1-b988-fe15-b7f59f8bd5d1@redhat.com>
Subject: Re: [PATCH v4 06/15] block/mirror: conservative mirror_exit refactor
References: <20180904170930.28619-1-jsnow@redhat.com>
 <20180904170930.28619-7-jsnow@redhat.com>
In-Reply-To: <20180904170930.28619-7-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-04 19:09, John Snow wrote:
> For purposes of minimum code movement, refactor the mirror_exit
> callback to use the post-finalization callbacks in a trivial way.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

(Although I believe the ?: hunk from the previous patch should be here.
Also note that we have a couple of places that make use of the GNU
extension for "?:" as a binary operator (as in "x ?: y" returns x if
x !=3D 0).  Just in case you find "s->to_replace ?: src" as appealing as =
I
do.)


--8MDaaJmMvS7Sa9YoGibchYEm3W8omXeEv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluPs18ACgkQ9AfbAGHV
z0B2LAf/emB793RBq1YS6pHw9BOdHOi7NCLtfNuv6pXW8y0PNifFvOHTphV+pIIs
U6PLJrXW9HVm5Qgb6nZM2f7Agb6zlTlc4HFVvCGKnlCvVvUj0y8SUg1U7Ys1bGXL
wou8jjBNazEpfBiT1HU8FjX4xUGusTGlPy+FMMMxQ+3F+kQjNiKExXmUm6EKuhF5
xbMjnV/lE2EsFr5AmlwNaNe+wkgPTUPldjIVh2ELp4TZHIZJXITBzhVFxQ5epUDF
98Jl5awx+I/5e6G8okm+ULByE3OJvOKJTENmHGmvJFQ2Ubj9C5GS6X0JD+hUGIAb
I1VqdkIX6BpGkAFzax6Xx6gLaLjbow==
=4lgK
-----END PGP SIGNATURE-----

--8MDaaJmMvS7Sa9YoGibchYEm3W8omXeEv--
