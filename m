Received: from eggs.gnu.org ([2001:4830:134:3::10]:58958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgZ6P-0004hA-1W
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgZ6O-0006Bt-4T
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:45:13 -0500
References: <20170220151921.22842-1-berrange@redhat.com>
	<20170220151921.22842-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e8b33201-4e2a-2ad2-b9b8-01b3982902e7@redhat.com>
Date: Wed, 22 Feb 2017 09:45:02 -0600
MIME-Version: 1.0
In-Reply-To: <20170220151921.22842-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XHxs6R7309RoN5HHmsOde58Gh6JAxtqAJ"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qemu-img: introduce
 --target-image-opts for 'convert' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XHxs6R7309RoN5HHmsOde58Gh6JAxtqAJ
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <e8b33201-4e2a-2ad2-b9b8-01b3982902e7@redhat.com>
Subject: Re: [PATCH v3 3/4] qemu-img: introduce --target-image-opts for
 'convert' command
References: <20170220151921.22842-1-berrange@redhat.com>
 <20170220151921.22842-4-berrange@redhat.com>
In-Reply-To: <20170220151921.22842-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/20/2017 09:19 AM, Daniel P. Berrange wrote:
> The '--image-opts' flags indicates whether the source filename
> includes options. The target filename has to remain in the
> plain filename format though, since it needs to be passed to
> bdrv_create().  When using --skip-create though, it would be
> possible to use image-opts syntax. This adds --target-image-opts
> to indicate that the target filename includes options. Currently
> this mandates use of the --skip-create flag too.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img-cmds.hx |  4 +--
>  qemu-img.c       | 84 +++++++++++++++++++++++++++++++++++++++---------=
--------
>  qemu-img.texi    | 12 ++++++--
>  3 files changed, 71 insertions(+), 29 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XHxs6R7309RoN5HHmsOde58Gh6JAxtqAJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrbH/AAoJEKeha0olJ0Nq8LIH+wY1Rg8pAqRAIVZutNh+x+is
XqDnFh4dH6wZm2YJSAMqFcL1rtcL0glZWn2Sl3ZvRRVSFgR/YyyTpbA7OPs4grTc
l4g+Bj0nyo9cK5iS7dHf/CZrYEGMvBM9RiA5EDx12706p68NHzQ8B1pFrcHZSZb0
S3zp5DDmItY0wXcgD0ULLB2b+4DCDLzoyxQ9nzPfcd40Y/RTLU7trBEfBEoBmn+m
Nu3LfaCdlkNzy2mBv/MHFQyWPktbKjt0uainQPdYDd8eZFOSoB/F6f9DqrAJcf9A
lZDX1BpK4Ec+Yi7GOSjz9tLFlWE0Ovohw/zIt1dbl4BmZHndo4c/lCoSz839c5c=
=kmw3
-----END PGP SIGNATURE-----

--XHxs6R7309RoN5HHmsOde58Gh6JAxtqAJ--
