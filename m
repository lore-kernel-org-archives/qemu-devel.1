Received: from eggs.gnu.org ([2001:4830:134:3::10]:36824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVjh-0002xv-3Y
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVje-00021I-2U
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:35:49 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cxVjd-00020x-Ru
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:35:45 -0400
Received: by mail-wr0-x244.google.com with SMTP id l44so940150wrc.2
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:35:45 -0700 (PDT)
Date: Mon, 10 Apr 2017 10:35:42 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410093542.GJ2567@stefanha-x1.localdomain>
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Content-Disposition: inline
In-Reply-To: <20170323173928.14439-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/10] blockjob: strengthen a bit
 test-blockjob-txn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, jsnow@redhat.com


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 06:39:25PM +0100, Paolo Bonzini wrote:
> Unlike test-blockjob-txn, QMP releases the reference to the transaction
> before the jobs finish.  Thus, while working on the next patch,
> qemu-iotest 124 showed a failure that the unit tests did not have.
> Make the unit test just a little nastier, so that it fails too.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/test-blockjob-txn.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY61HuAAoJEJykq7OBq3PIuwwH/jQJKDI4DRJx2geG4JyaIxeR
qcEi+JWYbspY4uMiCy/Hyn3FgQrYfyp8RA/9STUltiXbrb568FhtxJS95Ki3CdEd
h1RQkaRFhH2DIkUVNKefnJgR6x0nr975Dx9DRWmNIU4Y4RQghfH/CpPivhWhm5cC
qsTVOoo9kxVBBy3opAZn6jDm3Yle7Yy+GOJGCE69qoWSv30WSSUtcdvKrrZo3AlA
F/+LIAm3YxzzRv6790scn+VZoubmFVEPjGwbyL8UoEGK+yqYAwR3BeQCsUODoZVB
jLj6moFIqpX266RW9b6tCwIpmi5MCnwkCLoRbLTPoYEcUgdbkLM90qd+m1SRGKU=
=vwll
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--
