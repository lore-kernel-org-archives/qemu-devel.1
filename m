Received: from eggs.gnu.org ([2001:4830:134:3::10]:56871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4cxS-0003Zh-6R
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 21:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e4cxR-0007h7-Ae
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 21:15:42 -0400
References: <cover.1508257445.git.jcody@redhat.com>
	<503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e71f2e9e-4dfd-f0d0-e0a3-b38e6c23028e@redhat.com>
Date: Tue, 17 Oct 2017 20:15:29 -0500
MIME-Version: 1.0
In-Reply-To: <503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ewQrQtJrlmE6gxl2WqL84ebSPCoVjjFdp"
Subject: Re: [Qemu-devel] [PATCH v5 03/10] qemu-iotests: automatically clean
 up bash protocol servers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ewQrQtJrlmE6gxl2WqL84ebSPCoVjjFdp
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com,
 kwolf@redhat.com
Message-ID: <e71f2e9e-4dfd-f0d0-e0a3-b38e6c23028e@redhat.com>
Subject: Re: [PATCH v5 03/10] qemu-iotests: automatically clean up bash
 protocol servers
References: <cover.1508257445.git.jcody@redhat.com>
 <503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
In-Reply-To: <503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/17/2017 11:31 AM, Jeff Cody wrote:
> For bash tests, this allows 'check' to reap all launch protocol
> servers / processes, after a test has finished running.

Nice stuff!

>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  tests/qemu-iotests/check     | 13 +++++++
>  tests/qemu-iotests/common.rc | 93 +++++++++++++++++++++++++++++-------=
--------
>  2 files changed, 75 insertions(+), 31 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ewQrQtJrlmE6gxl2WqL84ebSPCoVjjFdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnmqzEACgkQp6FrSiUn
Q2oWIQgAg77Hz1nq1gMbyjrM6Eh8950CQJqKlHSPxQBvg4KWZZRqexR8pyuL0hfa
J29dMD56xZIq24WbHlyFdXTN2k94s6MNVzyCeiMH3mZh+jntBprb+y3FLSnxMG0A
As2kDLqtP2KBneSwyJ1vKVz5W2kOHqGEifKa35xWQOZr8ERTpEcxL9PLLqEJPKaM
LVhbuJNLebGbEaHA0/IKsK7wV0TSbmorapgJn8uMwl9dv4RzDod044AxqEmiXaDA
z9oyw82dYL7mK94g4EUwCtL3QrH6VJbATEtvOirNoYkNjItnAt6N5Blg1Cfg350o
BLxbnwHl7ADLi4U20XyCuw/lZngtvw==
=cQrf
-----END PGP SIGNATURE-----

--ewQrQtJrlmE6gxl2WqL84ebSPCoVjjFdp--
