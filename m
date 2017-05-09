Received: from eggs.gnu.org ([2001:4830:134:3::10]:48614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8AhK-0007wZ-U6
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8AhJ-0002Fx-VG
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:21:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8AhJ-0002Fi-MM
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:21:25 -0400
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
	<1494356693-13190-3-git-send-email-sstabellini@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dd261ee0-1636-c1ba-f3d1-8064e593d81f@redhat.com>
Date: Tue, 9 May 2017 14:21:23 -0500
MIME-Version: 1.0
In-Reply-To: <1494356693-13190-3-git-send-email-sstabellini@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nJEEOiI3rjrAhMGwJDEhHQiBqKVp5CbAG"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] xen: call qemu_set_cloexec instead
 of fcntl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xen.org, anthony.perard@citrix.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nJEEOiI3rjrAhMGwJDEhHQiBqKVp5CbAG
From: Eric Blake <eblake@redhat.com>
To: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xen.org, anthony.perard@citrix.com, groug@kaod.org,
 aneesh.kumar@linux.vnet.ibm.com
Message-ID: <dd261ee0-1636-c1ba-f3d1-8064e593d81f@redhat.com>
Subject: Re: [PATCH v2 3/3] xen: call qemu_set_cloexec instead of fcntl
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
 <1494356693-13190-3-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1494356693-13190-3-git-send-email-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/09/2017 02:04 PM, Stefano Stabellini wrote:
> Use the common utility function, which contains checks on return values=
,
> instead of manually calling fcntl.
>=20
> CID: 1374831
>=20
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> CC: anthony.perard@citrix.com
> CC: groug@kaod.org
> CC: aneesh.kumar@linux.vnet.ibm.com
> CC: Eric Blake <eblake@redhat.com>
> ---
>  hw/9pfs/xen-9p-backend.c | 2 +-
>  hw/xen/xen_backend.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nJEEOiI3rjrAhMGwJDEhHQiBqKVp5CbAG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZEhazAAoJEKeha0olJ0NqNy8H/jwRLj4Ry+YxxAsOflEcS5Qz
NyHNh60150M3OC21c9o35F/jZX4BQsWDK6nUvQp2Ru2CblYtO3crvhozW0BicW42
K1PdIDASp+C11++ne4VMeD9fB0ol15b6PjPApdW2T0VAKLvNZejA7arAwoOnaoOg
DQLOpoaECTlYEMYHa0FT6AmmhCp/M6xER/HMCDdWS2JVSmN3CimvvtkInxaxi0Gx
r3qdsbJM7g8WHSkku3fAJyyZAhqBwEZJtmUB+1lPyzrhCyZtLdRKPUk5UMpynopa
sfWE2a89qYQHa12kNCOMIRB65KUdNTsuzGWPmFN2206HkmcZVYfsLnMNuNGJOmY=
=1XM0
-----END PGP SIGNATURE-----

--nJEEOiI3rjrAhMGwJDEhHQiBqKVp5CbAG--
