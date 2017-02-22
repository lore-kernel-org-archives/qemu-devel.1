Received: from eggs.gnu.org ([2001:4830:134:3::10]:56816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXB1-0000z6-QK
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXB0-000139-VJ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:41:51 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-12-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <51bd801b-b2df-6cba-1b1f-eb2909b96bf8@redhat.com>
Date: Wed, 22 Feb 2017 14:41:41 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-12-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qEqLKu1dK1aL0OetkXnfCX25613Kv95fr"
Subject: Re: [Qemu-devel] [PATCH 11/54] tests: Use opened block node for
 block job tests
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
--qEqLKu1dK1aL0OetkXnfCX25613Kv95fr
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <51bd801b-b2df-6cba-1b1f-eb2909b96bf8@redhat.com>
Subject: Re: [PATCH 11/54] tests: Use opened block node for block job tests
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-12-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-12-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> blk_insert_bs() and block job related functions will soon require an
> opened block node (permission calculations will involve the block
> driver), so let our tests be consistent with the real users in this
> respect.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/test-blockjob-txn.c | 6 +++++-
>  tests/test-blockjob.c     | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--qEqLKu1dK1aL0OetkXnfCX25613Kv95fr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitlRUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AfkAIALr4tSEK83GOLEgZgK6B9SMVYfa+p0Xo
wbCk3nYtGc1u++G/W5A5aIjvmT3DkxjCsypI1pbCQALSFxNlbuURSOwgOQtS/iKX
UzaF/URb0U+GR3JI+LF6MLvn6g2V3BZldKRtcSYjD/zvzrgpCuLF65b83uFrer+l
/lFtEfyw0TZNybJn/fDdTbQhcvhJGc7fObvt+0LRFmP1FOnvW/ckWKfCzxVk8uyx
2dxwXT4yvOlzEmvVamBTthesO6TpIGvqAt011q6zJzhBFzyOV8fywwVdTVTUfxX6
ZHyBPqW5HoGcXE6UR+IRSeId5kuyYVRuoNfSNE02QdXNKRqMOvuM4KA=
=PGW4
-----END PGP SIGNATURE-----

--qEqLKu1dK1aL0OetkXnfCX25613Kv95fr--
