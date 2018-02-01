Received: from eggs.gnu.org ([208.118.235.92]:49236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKis-0006fF-Vu
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKho-0004un-NB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:40:38 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<4a4cf18c47fbbd1147fb8e425d23157bb205e0fe.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d4cb2b59-9996-0ce7-880d-b4447b2fb565@redhat.com>
Date: Thu, 1 Feb 2018 20:34:26 +0100
MIME-Version: 1.0
In-Reply-To: <4a4cf18c47fbbd1147fb8e425d23157bb205e0fe.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Nt6r5hL8h4NNIjZ5poPHUvVeUrpvGUkay"
Subject: Re: [Qemu-devel] [PATCH v3 29/39] qcow2: Prepare
 expand_zero_clusters_in_l1() for adding L2 slice support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nt6r5hL8h4NNIjZ5poPHUvVeUrpvGUkay
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <d4cb2b59-9996-0ce7-880d-b4447b2fb565@redhat.com>
Subject: Re: [PATCH v3 29/39] qcow2: Prepare expand_zero_clusters_in_l1() for
 adding L2 slice support
References: <cover.1516978645.git.berto@igalia.com>
 <4a4cf18c47fbbd1147fb8e425d23157bb205e0fe.1516978645.git.berto@igalia.com>
In-Reply-To: <4a4cf18c47fbbd1147fb8e425d23157bb205e0fe.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> Adding support for L2 slices to expand_zero_clusters_in_l1() needs
> (among other things) an extra loop that iterates over all slices of
> each L2 table.
>=20
> Putting all changes in one patch would make it hard to read because
> all semantic changes would be mixed with pure indentation changes.
>=20
> To make things easier this patch simply creates a new block and
> changes the indentation of all lines of code inside it. Thus, all
> modifications in this patch are cosmetic. There are no semantic
> changes and no variables are renamed yet. The next patch will take
> care of that.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 187 ++++++++++++++++++++++++++----------------=
--------
>  1 file changed, 96 insertions(+), 91 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Nt6r5hL8h4NNIjZ5poPHUvVeUrpvGUkay
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpza8ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AZkAH/R+ckJADSBnmqKwgA3TRuumgZKvuSte4
wcBw2w3JSi0sZINi1KyNYnS8Ju6kc51+hnv6VIQI+6edB7UfFT6cyT9STryOx1ah
B34BJmAu31IS6i85K7L6ymh2m0HdbVGhl+4fXV59ir2EMw6bkhmdOXuqojUUInFu
muT/Xbi4GMMTVjTn7U6J7LZKKftqDG4/jzHh6U+QV3nPgXtLBgIgHpV7QgJd+7jm
tdWuBMIttZ2HKSETRi5f1NszJrVSZB43uuraY3OKHZlPcku+7pen7Swv7JjxyVIL
wFlYWYiPw1yO3vEXlMOXsx9UjZ2on5eqt6k0Ix/7N755Ss3Ozhl5HsU=
=ifti
-----END PGP SIGNATURE-----

--Nt6r5hL8h4NNIjZ5poPHUvVeUrpvGUkay--
