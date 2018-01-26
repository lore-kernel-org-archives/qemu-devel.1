Received: from eggs.gnu.org ([2001:4830:134:3::10]:44605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef9tG-0006zn-2j
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ef9tF-0003Pm-61
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:42:22 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<4a4cf18c47fbbd1147fb8e425d23157bb205e0fe.1516978645.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3d8c283-91ff-0c8e-e4be-6151fb054452@redhat.com>
Date: Fri, 26 Jan 2018 13:42:15 -0600
MIME-Version: 1.0
In-Reply-To: <4a4cf18c47fbbd1147fb8e425d23157bb205e0fe.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2dPKUZnSKTfdVNcydL1pyxhdvtkMb3iqY"
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2dPKUZnSKTfdVNcydL1pyxhdvtkMb3iqY
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <b3d8c283-91ff-0c8e-e4be-6151fb054452@redhat.com>
Subject: Re: [PATCH v3 29/39] qcow2: Prepare expand_zero_clusters_in_l1() for
 adding L2 slice support
References: <cover.1516978645.git.berto@igalia.com>
 <4a4cf18c47fbbd1147fb8e425d23157bb205e0fe.1516978645.git.berto@igalia.com>
In-Reply-To: <4a4cf18c47fbbd1147fb8e425d23157bb205e0fe.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2018 08:59 AM, Alberto Garcia wrote:
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

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2dPKUZnSKTfdVNcydL1pyxhdvtkMb3iqY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlprhJcACgkQp6FrSiUn
Q2pffAf/WS+ipOvVIOhhEGQQYUkghJ6apXj53FNQ0Xk19mKEjD/oCDgZnLtQD41a
I2jDWVaXYqcP3bjBkpfrnnrg8mSGIj/wpJomCOeuT5TpywK1VbowZRqTBj9Dp3jQ
b2YYrpnTqNhwzfEIzOGaGtOyqUoBQRQVZeU4i624rHG5lWWLeotKTfPhset/+4iw
UKnq9ikMBlI6X9Ppfi9ZwNBAytpw3zbizURo+ZAi5gAmE3v9xGoBc1WFy7nczbPr
wgSis+bk64CbJOI+o2SsklDvqK2BCxmKvC2AX2b5L7zf+Y1pWB4KhVYGmi6x4Uwl
+zwXe72IJOVs9XyVp94DPXsrrLrPIg==
=2c05
-----END PGP SIGNATURE-----

--2dPKUZnSKTfdVNcydL1pyxhdvtkMb3iqY--
