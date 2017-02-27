Received: from eggs.gnu.org ([2001:4830:134:3::10]:56398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciRba-00075j-Oh
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciRbZ-0002l7-Mk
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:09:10 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-49-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2162d5ff-baa1-3c5a-5180-23ac21d83b85@redhat.com>
Date: Mon, 27 Feb 2017 14:09:02 -0600
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-49-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1qMLfmT6Eovgm2JhUThxKKgceAGnt0VDs"
Subject: Re: [Qemu-devel] [PATCH 48/54] nbd/server: Use real permissions for
 NBD exports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1qMLfmT6Eovgm2JhUThxKKgceAGnt0VDs
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Message-ID: <2162d5ff-baa1-3c5a-5180-23ac21d83b85@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 48/54] nbd/server: Use real permissions for
 NBD exports
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-49-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-49-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 08:58 AM, Kevin Wolf wrote:
> NBD can't cope with device size changes, so resize must be forbidden,
> but otherwise we can tolerate anything. Depending on whether the export=

> is writable or not, we only require consistent reads and writes.

Well, there is a proposal for NBD to grow an extension to support
resizes, but nothing that will land in time for qemu 2.9 :)

>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  nbd/server.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--1qMLfmT6Eovgm2JhUThxKKgceAGnt0VDs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtIdeAAoJEKeha0olJ0NqbsQH/0MNrgqw4UTWw03/P4M6Gxri
YodEG9hPOBgFApZ0XIQRy+NdYFkdhqCE8CNkBLzB2+VwwoJ0Y5FChexQbeFc7MZh
QgnlrW3/nuALqDZ42KOBi5jiLYvT1wdPH46KVr9XAK0zEBk/8WnMVJQcYT0kQDE2
jZjJHR27umS0rtOfO5dwrBhvFeJEIMcbZ5GgnPM54Ddc0fkJj4CY6BM7jT8PR1xL
YvqwHk3mq/fKVfL87c5E+wHohSYF41/7W+q14IYOIr3JTxRn/kc0cC6MP93Mw2oJ
vIdolFmzf65pt3gaVDlAbyTtb3RbfOyQA2g0Gl/sL17w8m8lWkqQ+jFqmpJwhyk=
=Z7BK
-----END PGP SIGNATURE-----

--1qMLfmT6Eovgm2JhUThxKKgceAGnt0VDs--
