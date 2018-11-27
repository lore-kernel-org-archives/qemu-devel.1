Received: from eggs.gnu.org ([208.118.235.92]:52536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gRZVc-0005FZ-9F
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:18:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gRZVP-00036Y-4m
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:18:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gRZVO-00035g-UC
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:18:07 -0500
Date: Tue, 27 Nov 2018 09:18:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181127091804.GA9360@stefanha-x1.localdomain>
References: <20181127084143.1113-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20181127084143.1113-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.1] vfio-helpers: Fix
 qemu_vfio_open_pci() crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, coli@redhat.com, fam@euphon.net, pbonzini@redhat.com


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 09:41:43AM +0100, Markus Armbruster wrote:
> qemu_vfio_open_common() initializes s->lock only after passing s to
> qemu_vfio_dma_map() via qemu_vfio_init_ramblock().
> qemu_vfio_dma_map() tries to lock the uninitialized lock and crashes.
>=20
> Fix by initializing s->lock first.
>=20
> RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=3D1645840
> Fixes: 418026ca43bc2626db092d7558258f9594366f28
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> Compile-tested only, as I lack suitable hardware.  Cong Li (cc'ed) is
> going to test it for real.  It looks obvious enough to me to put it
> into -rc3 without waiting for the test results.  We can also wait and
> put it into -rc4.
>=20
>  util/vfio-helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb/QvMAAoJEJykq7OBq3PIUrcIAIftGs93uKSYq0/ptsUkjJfm
lnebCHhYqBi6UNxDAFXrus/RBC5OhiQjeB+2sjDLzoOlCGV/Bov+v0zpBbaXX8MN
XYAVoey/X3i4fZYBn2c5bJrFCR/OyvPbIHmukmvMi2mxAxHBl8pZp2GnuBPLm5Ph
EzsNPnW1zsLJUnG5DugKCzwF3jTy8Ro3mPH1M8AZUFM0HoPimuhTZpdjFbhRTf2+
MCsE12c+Ocek2YIUlJulV6cc4GNPJscc3pMPGT3FtqpMV4C9Bx1pbXisNm7yWFR4
QzK2871q2k5fovPxP5mayMVL0/ahiZWQAN4ehclptHjBAmW/VNpzDqCkABTNzv4=
=zaNo
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
