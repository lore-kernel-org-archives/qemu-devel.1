Received: from eggs.gnu.org ([2001:4830:134:3::10]:59489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZ0R-0003Xe-HY
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZ0Q-0005X1-LK
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:42:55 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<faadd3224ae4eb688e65d1f363e3056c7554cf26.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <16103b66-aa39-78d5-c6ce-320aa93ccd68@redhat.com>
Date: Tue, 16 Jan 2018 15:42:45 -0600
MIME-Version: 1.0
In-Reply-To: <faadd3224ae4eb688e65d1f363e3056c7554cf26.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QCJUG8Mf8m5UWjKVPTZqu0fguZr3LPfUX"
Subject: Re: [Qemu-devel] [PATCH v2 07/32] qcow2: Remove BDS parameter from
 qcow2_cache_put()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QCJUG8Mf8m5UWjKVPTZqu0fguZr3LPfUX
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <16103b66-aa39-78d5-c6ce-320aa93ccd68@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 07/32] qcow2: Remove BDS parameter from
 qcow2_cache_put()
References: <cover.1513342045.git.berto@igalia.com>
 <faadd3224ae4eb688e65d1f363e3056c7554cf26.1513342045.git.berto@igalia.com>
In-Reply-To: <faadd3224ae4eb688e65d1f363e3056c7554cf26.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to pass it
> to qcow2_cache_get_table_idx(). This is no longer necessary so this
> parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cache.c    |  2 +-
>  block/qcow2-cluster.c  | 28 ++++++++++++++--------------
>  block/qcow2-refcount.c | 30 +++++++++++++++---------------
>  block/qcow2.h          |  2 +-
>  4 files changed, 31 insertions(+), 31 deletions(-)
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QCJUG8Mf8m5UWjKVPTZqu0fguZr3LPfUX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpecdUACgkQp6FrSiUn
Q2qODAf+M91Dgy3kelyXHGylM5AlxK0u1h2BpcAqdHMyjLI63XL0uFwOOyiYH98/
DZAXghEi/QPiuYe7RsGpvj9Qb9kmZ+yyyzJ9jDGY9VgFtNBR82j0pYBGxBe+BFql
xZ0y9YorWH+O0DLB/nzJ5Ry8Wc99SftKMLOXWFPENn8YNT+AECQU3slCCtVH5blw
k58XywzncC84U85kGoDOar3JVc6MNUmmF4YmkBEwjk3SUTwJw5b9E35FxYCqqcWk
jnX1MjkGw3LSaTU+mL3dkJG/AqtqTgy4sqQaxiQ1uorZlpiNXeMYJuaEx8gEkFzv
++4vMWRzTBIA1l1MZFKBhpfjmohyIQ==
=li/B
-----END PGP SIGNATURE-----

--QCJUG8Mf8m5UWjKVPTZqu0fguZr3LPfUX--
