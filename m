Received: from eggs.gnu.org ([2001:4830:134:3::10]:43218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1casZm-0006dt-7u
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1casZl-0004QN-Bn
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:20:02 -0500
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-7-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9ddd60b-532a-2009-c1cc-edab0ca64458@redhat.com>
Date: Mon, 6 Feb 2017 17:19:51 -0600
MIME-Version: 1.0
In-Reply-To: <20170203154757.36140-7-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2eFATG66EqlQ6t3KjvcXEb0wem1dn2U6I"
Subject: Re: [Qemu-devel] [PATCH 06/18] nbd/client: refactor drop_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2eFATG66EqlQ6t3KjvcXEb0wem1dn2U6I
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, den@virtuozzo.com,
 stefanha@redhat.com
Message-ID: <f9ddd60b-532a-2009-c1cc-edab0ca64458@redhat.com>
Subject: Re: [PATCH 06/18] nbd/client: refactor drop_sync
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
 <20170203154757.36140-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-7-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2017 09:47 AM, Vladimir Sementsov-Ogievskiy wrote:
> Return 0 on success to simplify success checking.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  nbd/client.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)

I'm not sure that this simplifies anything.  You have a net addition in
lines of code, so unless some later patch is improved because of this,
I'm inclined to say this is needless churn.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--2eFATG66EqlQ6t3KjvcXEb0wem1dn2U6I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmQSXAAoJEKeha0olJ0Nq0FsH/R7UAtAUnZ4W513eGaEkfuOO
NhAiXfsxs55XNnIzvzH/uR4DtegQZ66GxOR1XmtQdVMXuEzWWe6pjkl/ZYnvD4SW
jKeYzzzeY0CR5k6iWrhpMCbcVedij68F+63o2ocgNmCvDK0tzuhHr5uGUN2u3h7d
W/wfKioQY/3Lv2PlFJ/svTvwRy8PP16ezpbFDxrbzVhDnFxYf+KawupsZCSZwgXy
5AxGU9o3PNCSMXiiJ7iUtAj6z1xup0ASMe5y283hah3GSr5T5VZ7aHsX+hJ9ajpy
iKgL218dKdMOvtA2X7y47MggdKAqbcLg+p589kOX3lF6qhvCCpcDy4HtymMiVY8=
=obms
-----END PGP SIGNATURE-----

--2eFATG66EqlQ6t3KjvcXEb0wem1dn2U6I--
