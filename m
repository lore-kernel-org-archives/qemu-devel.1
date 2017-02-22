Received: from eggs.gnu.org ([2001:4830:134:3::10]:40593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXxp-00052N-7a
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXxo-0006gz-ET
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:32:17 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-24-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <02a68e0c-ec16-2e95-ee3e-7555b3e7e0a5@redhat.com>
Date: Wed, 22 Feb 2017 15:32:05 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-24-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9e4j5UkC67Qi87BxoIBKAQKrQcWgC2H9v"
Subject: Re: [Qemu-devel] [PATCH 23/54] block: Add permissions to
 BlockBackend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9e4j5UkC67Qi87BxoIBKAQKrQcWgC2H9v
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <02a68e0c-ec16-2e95-ee3e-7555b3e7e0a5@redhat.com>
Subject: Re: [PATCH 23/54] block: Add permissions to BlockBackend
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-24-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-24-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> The BlockBackend can now store the permissions that its user requires.
> This is necessary because nodes can be ejected from or inserted into a
> BlockBackend and all of these operations must make sure that the user
> still gets what it requested initially.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c          | 27 +++++++++++++++++++++++++++
>  include/sysemu/block-backend.h |  2 ++
>  2 files changed, 29 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--9e4j5UkC67Qi87BxoIBKAQKrQcWgC2H9v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitoOUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AEUEIAMBPz0MmNYMFEZLbfdcBUXe/Cozis4vY
d5eIiXZ545/mmb42g5D47fKAeQRoqD6nBmlkWMLMF3/0Bph/oAL7IBLn+Hv+easF
5nvgpfEVyVrIr2J1Z8yZY6Alwvu47vnrvrD+zn6s6/Y0Lwfqvd89UX/hfX+UtwJp
vLq/5G4TNAEi1bXVB/+3/do0d04Q5hpLhnT/OXmOuFpjRl3grG7zCxdpgkHexaGG
z7BYgsHjqNOhuOKhLGuhRAOhDbVder90ruao1Awsq6YUn45qIhsXGesXhLqLPf+x
PSLKqJbqNGAG1pW91Idnl6tFfyWzIk430XzB4OXLCAfgPJkH8lA/5QM=
=l5WR
-----END PGP SIGNATURE-----

--9e4j5UkC67Qi87BxoIBKAQKrQcWgC2H9v--
