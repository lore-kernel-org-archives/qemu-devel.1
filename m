Received: from eggs.gnu.org ([2001:4830:134:3::10]:60185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGUWv-00027V-ET
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 14:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dGUWu-0002Gv-Gd
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 14:09:05 -0400
References: <20170601172734.9039-1-berrange@redhat.com>
	<20170601172734.9039-20-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e26777b2-1d57-d179-28e1-12b0f988e111@redhat.com>
Date: Thu, 1 Jun 2017 13:08:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170601172734.9039-20-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NsC12pH7TXHX7TXLm7Whb00lv8ObWH5P3"
Subject: Re: [Qemu-devel] [PATCH v8 19/20] qcow2: report encryption specific
 image information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NsC12pH7TXHX7TXLm7Whb00lv8ObWH5P3
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <e26777b2-1d57-d179-28e1-12b0f988e111@redhat.com>
Subject: Re: [PATCH v8 19/20] qcow2: report encryption specific image
 information
References: <20170601172734.9039-1-berrange@redhat.com>
 <20170601172734.9039-20-berrange@redhat.com>
In-Reply-To: <20170601172734.9039-20-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2017 12:27 PM, Daniel P. Berrange wrote:
> Currently 'qemu-img info' reports a simple "encrypted: yes"
> field. This is not very useful now that qcow2 can support
> multiple encryption formats. Users want to know which format
> is in use and some data related to it.
>=20

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/qcow2.c        | 32 +++++++++++++++++++++++++++++++-
>  qapi/block-core.json | 27 ++++++++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NsC12pH7TXHX7TXLm7Whb00lv8ObWH5P3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZMFg5AAoJEKeha0olJ0Nquf0IAJsz7os9t64W/ThXkTqoh2RY
ahnoqYfsFKFNbd8mVhjPWJMmwxj2JgxCceJvi5G/0IQWlDjbMb1+8QDg/JUcvXjO
LqQZWYNTv+5Pz4vSizWpEEmFyMVF1xW9CltMhGhp0XWHorptszmLvkrJgiHNv/io
bb0lMj75b4MRZNkQXlgM001+3VEdyV3juiR6CykIi8uGJXC5GcR0xHfmfVWcb9Wz
6H2FHHsxsGKX0Mu+D9xW8dz2tgR3maiy+oM61luTfhUZwydIfwhEFV9xoXfmZiLr
Zk/kQt2H8KvPjDMM9YQ/Mwbo1SYyCLklDZNmgfNt5xTMQyRBD8j/YW8mdNmXZEI=
=VIjC
-----END PGP SIGNATURE-----

--NsC12pH7TXHX7TXLm7Whb00lv8ObWH5P3--
