Received: from eggs.gnu.org ([2001:4830:134:3::10]:52823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8C6O-0006fU-T6
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 17:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8C6O-0007BK-0N
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 17:23:40 -0400
References: <20171023092945.54532-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2f7f97d-5fe9-7ebf-2058-c403775c2df4@redhat.com>
Date: Fri, 27 Oct 2017 23:23:12 +0200
MIME-Version: 1.0
In-Reply-To: <20171023092945.54532-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HTtd3Qvflq2Ax5mkfrNKrlwFF6EEisJU2"
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HTtd3Qvflq2Ax5mkfrNKrlwFF6EEisJU2
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com,
 den@openvz.org, stefanha@redhat.com
Message-ID: <e2f7f97d-5fe9-7ebf-2058-c403775c2df4@redhat.com>
Subject: Re: [PATCH] block/snapshot: dirty all dirty bitmaps on
 snapshot-switch
References: <20171023092945.54532-1-vsementsov@virtuozzo.com>
In-Reply-To: <20171023092945.54532-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/23/2017 11:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> Snapshot-switch actually changes active state of disk so it should
> reflect on dirty bitmaps. Otherwise next incremental backup using
> these bitmaps will be invalid.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/snapshot.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--HTtd3Qvflq2Ax5mkfrNKrlwFF6EEisJU2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnzo8AACgkQp6FrSiUn
Q2r03Af/QL4CygxssgzpiBYuH9kZngVtmnky8iObnDuLTRAyNIa9E/AYQEsUkZ7c
SeQHd3afS13UBEGw1GxrcBwP1oa7Lde3iuRgrtx2qQChbDXV/D6u50Dcr7YIvhxV
EX8IwGt6XEbP9iAd2rPNWUS2FvUpvjjUW8aVkKNYFAp5B8zSkv0SrVXGE3JVESzK
tHUb++xIj9WvK6jf7H8L12xh5/ybF3+YWCdqVZGVczIeotGZenJ/7UQ+OphjIKPx
uB4aJUrIpfqfAAIsJ2mmZpg2Vm3WXtf2kU9teQGukdgTyQqQs71Wf0PTjJ0vemGu
oUPHbREOIF3ZREyab9g1l6RS13xiTA==
=crV1
-----END PGP SIGNATURE-----

--HTtd3Qvflq2Ax5mkfrNKrlwFF6EEisJU2--
