Received: from eggs.gnu.org ([2001:4830:134:3::10]:60729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAe4m-0006mL-JJ
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAe4g-0001XM-VE
	for qemu-devel@nongnu.org; Tue, 16 May 2017 11:07:52 -0400
Date: Tue, 16 May 2017 16:07:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516150731.GO8498@stefanha-x1.localdomain>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-18-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yLaBmHMi4cq+C/u4"
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-18-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/18] block: introduce block_account_one_io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--yLaBmHMi4cq+C/u4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:42:07PM +0200, Paolo Bonzini wrote:
> This is the common code to account operations that produced actual I/O.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: new, to hoist qemu_clock_get_ns out of the
>                 "if (!stats->account_failed)" case.  Failed operations
>                 are not a fast path, so getting the current time
>                 unconditionally is not an issue. [Stefan]
>=20
>  block/accounting.c | 50 +++++++++++++++++++++---------------------------=
--
>  1 file changed, 21 insertions(+), 29 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--yLaBmHMi4cq+C/u4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGxWzAAoJEJykq7OBq3PINvwIAMTaa46Wce1pw1jC2O5I4REr
O9hzklE70MXSG8Jk5EYStl2cmKNA8kvcPRZtR5fCtLHs4yx4E7mGQYGkDfGfNfqZ
9qDwA0PhN/tPy8qxVyCFQuSlRc5Ph582w9RiualW/XPABX9KmdxbfLUpfA+vMl5E
tb06o1ISwI7T5ADEpve5dNk3CRro8MGObpTYm/Jo7QqH2/2enuYMRgShLMrDPWjP
o4ZjCpfvIbsSsYmB3+zS2YM2UdXTjoUZiPwEhbz5nkMMjErCWdt6DOSEqRkAIFVE
EdtuVRQVz83IfSDzqcduCccGleDAZk3+nlOUY27ZQlDP9XXIW1dT/nhZlBc9iyk=
=f0pj
-----END PGP SIGNATURE-----

--yLaBmHMi4cq+C/u4--
