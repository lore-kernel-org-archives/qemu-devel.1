Received: from eggs.gnu.org ([2001:4830:134:3::10]:51207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAK8K-0004Ke-PI
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAK8J-0004Sv-T2
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:50:12 -0400
References: <20170515164712.6643-1-berrange@redhat.com>
	<20170515164712.6643-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23660e71-cb56-3dea-0c22-8f143058b8d7@redhat.com>
Date: Mon, 15 May 2017 12:49:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170515164712.6643-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DbHNLktof6c61d9TGmOQwQrfoIDUESBOt"
Subject: Re: [Qemu-devel] [PATCH v10 3/4] qemu-img: introduce
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DbHNLktof6c61d9TGmOQwQrfoIDUESBOt
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <23660e71-cb56-3dea-0c22-8f143058b8d7@redhat.com>
Subject: Re: [PATCH v10 3/4] qemu-img: introduce --target-image-opts for
 'convert' command
References: <20170515164712.6643-1-berrange@redhat.com>
 <20170515164712.6643-4-berrange@redhat.com>
In-Reply-To: <20170515164712.6643-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2017 11:47 AM, Daniel P. Berrange wrote:
> The '--image-opts' flag indicates whether the source filename
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
>  qemu-img.c       | 84 ++++++++++++++++++++++++++++++++++++++----------=
--------
>  qemu-img.texi    | 12 ++++++--
>  3 files changed, 69 insertions(+), 31 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DbHNLktof6c61d9TGmOQwQrfoIDUESBOt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGepHAAoJEKeha0olJ0NqgLMH/3MhSFjpsfoeB6pQ7p7V+N5r
Os1RE+Z1nFdjs6WC3S6C8JL5sROm3Nh9JpUd3huQqWGZPyTZfCcBLdVt38WHulYo
JePp8RjcrPoULSfXldVuldmDOsdt3OGJcBxFMCRyyW8T1eF8ZSGaMi1jL/BDQ1KL
9ElSC8mZi1QBCmYQ1yoqD1GMOxi0e31lzEX/mZ7teMGu2bvfyWntH6YjpKsodjQZ
5s2hR48IAQ43XfcoPrOQyd5Aim0SEMHhytWA5EnQn4nzLS8zDbGGqqsLC92wTrhI
O0pnoHk0lUtOWLXIl8r2UYHPmaQ9fHlmWiD8+PdblhvjJ4O3/EdjvBfha/jHai8=
=+sqC
-----END PGP SIGNATURE-----

--DbHNLktof6c61d9TGmOQwQrfoIDUESBOt--
