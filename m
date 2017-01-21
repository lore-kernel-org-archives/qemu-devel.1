Received: from eggs.gnu.org ([2001:4830:134:3::10]:43804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV1AN-0002Zt-Hf
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cV1AK-0001sb-CW
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 14:17:35 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-15-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3a8c2699-17a7-a2ce-9e52-5c29069b8477@redhat.com>
Date: Sat, 21 Jan 2017 20:17:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-15-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F8TCe8MmcOnL6m4i7JJKrkkmF3kMmtbul"
Subject: Re: [Qemu-devel] [PATCH v1 14/15] block: rip out all traces of
 password prompting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F8TCe8MmcOnL6m4i7JJKrkkmF3kMmtbul
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <3a8c2699-17a7-a2ce-9e52-5c29069b8477@redhat.com>
Subject: Re: [PATCH v1 14/15] block: rip out all traces of password prompting
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-15-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-15-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:28, Daniel P. Berrange wrote:
> Now that qcow & qcow2 are wired up to get encryption keys
> via the QCryptoSecret object, nothing is relying on the
> interactive prompting for passwords. All the code related
> to password prompting can thus be ripped out.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  hmp.c                     | 31 ---------------------
>  include/monitor/monitor.h |  7 -----
>  include/qemu/osdep.h      |  2 --
>  monitor.c                 | 68 ---------------------------------------=
--------
>  qapi-schema.json          | 10 +------
>  qemu-img.c                | 31 ---------------------
>  qemu-io.c                 | 20 --------------
>  qmp.c                     | 12 +--------
>  util/oslib-posix.c        | 66 ---------------------------------------=
------
>  util/oslib-win32.c        | 24 -----------------
>  10 files changed, 2 insertions(+), 269 deletions(-)

Nice. :-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--F8TCe8MmcOnL6m4i7JJKrkkmF3kMmtbul
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliDs74SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AXPMIALapWj2xC/PRK6wrqrfXr0fox059Judp
3gSaqJarY+zjxwr+ZHt4CFdV4wmtlqkCBcj6yWhdv3CtSmAPiCMolpF8mijqgRtF
tSFj73peKHw0OrSYTno7oxYwB8OgffxeOI+5tEp6meFL5FyyKnDjDOzNjdW8lrzX
lBWuVym7Fx4x+n/jWobzljTMh/04dJ/zF/JqhxB97Ppv1uW7MD1dsSYzk15XHzAz
/+OxqlPZpDZCNojpkeCKJJjAMKblVBE1NI3KQZLSmGwrOG7ff/fBwGOgjo1+khG2
80zM+SZ1cwvAVLVoB0SKKGr2bFpW3t7yNOYiWUlq9VrVWgykVJMzxAM=
=c+pd
-----END PGP SIGNATURE-----

--F8TCe8MmcOnL6m4i7JJKrkkmF3kMmtbul--
