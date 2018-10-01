Received: from eggs.gnu.org ([2001:4830:134:3::10]:54020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g73fN-0004bY-Qx
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:15:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g73fN-0004uR-7V
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:15:37 -0400
References: <20180823154655.40188-1-vsementsov@virtuozzo.com>
	<20180823154655.40188-3-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8e9acf48-7eed-1cdd-d870-d1f3daead591@redhat.com>
Date: Mon, 1 Oct 2018 21:15:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180823154655.40188-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hdSRdtU3fRXvyJv1SkWpyx1f504PJ1qdh"
Subject: Re: [Qemu-devel] [PATCH v3 2/3] scripts: add render_block_graph
 function for QEMUMachine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hdSRdtU3fRXvyJv1SkWpyx1f504PJ1qdh
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com,
 armbru@redhat.com, kwolf@redhat.com, den@openvz.org, jsnow@redhat.com,
 famz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <8e9acf48-7eed-1cdd-d870-d1f3daead591@redhat.com>
Subject: Re: [PATCH v3 2/3] scripts: add render_block_graph function for
 QEMUMachine
References: <20180823154655.40188-1-vsementsov@virtuozzo.com>
 <20180823154655.40188-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180823154655.40188-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.08.18 17:46, Vladimir Sementsov-Ogievskiy wrote:
> Render block nodes graph with help of graphviz. This new function is
> for debugging, so there is no sense to put it into qemu.py as a method
> of QEMUMachine. Let's instead put it separately.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  scripts/render_block_graph.py | 120 ++++++++++++++++++++++++++++++++++=

>  1 file changed, 120 insertions(+)
>  create mode 100755 scripts/render_block_graph.py

Reviewed-by: Max Reitz <mreitz@redhat.com>


--hdSRdtU3fRXvyJv1SkWpyx1f504PJ1qdh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluyckcACgkQ9AfbAGHV
z0BkdQf9FSm59arjwBP0SBPgwVnIxDHCuFt/qNjvBLjCq0VixGR1ZlX8j8+X4nj+
zwt843GzhbluQEl1gUKFxFIQJZlJ0UkyW/emwUJ7VVYfYLD3+Lx4EWewp1LBixrg
MU3aTqKAQv2I2gCEzJg3UXyyTBodfdJKQ8JCVQneEag6ZqBTlzkMiJUkPfDhjY9t
oAtgZZWMI1+TzodRgekxaEz5V0BX/aAsv9lfyyv/Zj/h2VNF4czxqsk5VxvLCeqF
wiRgs6jUYq2xCKYi3kh8SYPfg1ayqL9yZBDE5Lwq5ufqsN65Hx4TvHWhOXf5Gflt
HkOFyHOepsBH57X8fy+VA1tZ+ofB8g==
=JIou
-----END PGP SIGNATURE-----

--hdSRdtU3fRXvyJv1SkWpyx1f504PJ1qdh--
