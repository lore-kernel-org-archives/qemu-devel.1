Received: from eggs.gnu.org ([2001:4830:134:3::10]:49244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QAW-00055k-Sq
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QAW-0000HM-1Q
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:09:16 -0400
Date: Fri, 20 Apr 2018 15:09:06 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420070906.GB15181@stefanha-x1.localdomain>
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <20180411163940.2523-4-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 03/19] block: Remove
 'recursive' parameter from bdrv_drain_invoke()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 06:39:24PM +0200, Kevin Wolf wrote:
> All callers pass false for the 'recursive' parameter now. Remove it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/io.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2ZISAAoJEJykq7OBq3PIprAIAIQX6gEUJne99PaVzJ51xkGi
WUpKz2iF1jR0T3VcJMkg+EvOYvkSKxSlc6EsgYG4D5uvWz6CRXfCpslSdvahnl+C
gQOORDRz1AmPiLPH/MeYjMEBjaOkCifBSxg5hPFIIDwgWBIYGeY2s5gs6qDAjchd
23guDrx5X4CrpuActVEk4YMKk3T1y4lWcWCiDnEey9i0LhOY8UZ3EYlJNHAA9b7S
J2aTy/3YrLx1ynHl3lzLKPsQQgNr2H6icLSuYBOYAu25Z62TOjVGowi8eS/Iabd6
2tOzJPg5PpLpSoXhmobWfg0IlSfWFbB9SmsUgaMaFQ2MM0MotJCPzj2XJSIP3AI=
=zgEM
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
