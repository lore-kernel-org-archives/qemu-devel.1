Received: from eggs.gnu.org ([2001:4830:134:3::10]:59791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLvAB-0007tU-Ma
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 14:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gLvAB-00081c-5U
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 14:12:51 -0500
References: <1541453919-25973-1-git-send-email-Liam.Merwick@oracle.com>
	<1541453919-25973-3-git-send-email-Liam.Merwick@oracle.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f5a910bd-2f23-5778-9845-865cbb8b8191@redhat.com>
Date: Sun, 11 Nov 2018 20:12:23 +0100
MIME-Version: 1.0
In-Reply-To: <1541453919-25973-3-git-send-email-Liam.Merwick@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BHGYfzHMikuUWtbvueAc2LdOj2WF5pQmz"
Subject: Re: [Qemu-devel] [PATCH v5 2/5] block: Null pointer dereference in
 blk_root_get_parent_desc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BHGYfzHMikuUWtbvueAc2LdOj2WF5pQmz
From: Max Reitz <mreitz@redhat.com>
To: Liam Merwick <Liam.Merwick@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 berrange@redhat.com
Message-ID: <f5a910bd-2f23-5778-9845-865cbb8b8191@redhat.com>
Subject: Re: [PATCH v5 2/5] block: Null pointer dereference in
 blk_root_get_parent_desc()
References: <1541453919-25973-1-git-send-email-Liam.Merwick@oracle.com>
 <1541453919-25973-3-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1541453919-25973-3-git-send-email-Liam.Merwick@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.11.18 22:38, Liam Merwick wrote:
> The dev_id returned by the call to blk_get_attached_dev_id() in
> blk_root_get_parent_desc() can be NULL (an internal call to
> object_get_canonical_path may have returned NULL).
>=20
> Instead of just checking this case before before dereferencing,
> adjust blk_get_attached_dev_id() to return the empty string if no
> object path can be found (similar to the case when blk->dev is NULL
> and an empty string is returned).
>=20
> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
> ---
>  block/block-backend.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--BHGYfzHMikuUWtbvueAc2LdOj2WF5pQmz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvofxgACgkQ9AfbAGHV
z0DIPwf+NjkJiGTcNCl1cjl/rDY1vEZgd1IUVTa460WkXZ/iuT831cDsLa3R+oxU
uZQJm9BrH+zsppwWMCvBAO3PSF6SsPrPEtaOi9Ds+ya7CXIVUBgxJXOgNxwhgKkr
r6fuXspEtfSHcWJDcWDaxJgCP++T9SaE2+lzXrGBUkUzy4nkjCzDzdL2xM6ogcGM
s3kw0je8qOpfJ/7j/U0B5dGl5xF44Fnkg1n0d0O9TMZohLDX2I2/7NjFCFAxZLdb
F487TvnCRVEXQuuMRRKlZfP2VYeYUhyq9a54f4w6lAEbWBymSsb6MsPkF5KBoJdn
YEBxmsQbpCrUQ4cHHwq1vb0/6wYLqA==
=x2El
-----END PGP SIGNATURE-----

--BHGYfzHMikuUWtbvueAc2LdOj2WF5pQmz--
