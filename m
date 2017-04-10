Received: from eggs.gnu.org ([2001:4830:134:3::10]:38521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVsP-0006LB-8S
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVsK-0005C2-DG
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:44:49 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cxVsK-0005An-4x
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:44:44 -0400
Received: by mail-wm0-x244.google.com with SMTP id o81so8615063wmb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:44:43 -0700 (PDT)
Date: Mon, 10 Apr 2017 10:44:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410094440.GL2567@stefanha-x1.localdomain>
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bzq2cJcN05fcPrs+"
Content-Disposition: inline
In-Reply-To: <20170323173928.14439-10-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/10] blockjob: reorganize
 block_job_completed_txn_abort
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


--Bzq2cJcN05fcPrs+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 06:39:27PM +0100, Paolo Bonzini wrote:
> This splits the part that touches job states from the part that invokes
> callbacks.  It will be a bit simpler to understand once job states will
> be protected by a different mutex than the AioContext lock.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c | 165 ++++++++++++++++++++++++++++++++-----------------------=
------
>  1 file changed, 88 insertions(+), 77 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Bzq2cJcN05fcPrs+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY61QIAAoJEJykq7OBq3PIHXYH/A+/fqWs7mjPfY2io3ZVyfDg
xxxho0yh3+JUE3Gquwr5BSt10k0fCoDyE2mm1PsX++FAd8ugzXRQ4Wg1ybUmvgWM
Ty3OiZe3/fCXEz/PF0Oqrdx98cgrI92rkjpytSntCTFbjz1kmS6cS5QFGRo2D4bx
0VK+uOBLwM0hzUz57+3Z0kGcOsoOeXbYYVTjLDwG5jxKtDiUgijhMrHkx42vflnd
JS1djlnpSx2ccL9k1iMwGAZUs3ah1LvUkLOfnHTcU8z4hskOKk1kFlTn4bq6ezCt
9jip1bMGgehC6YapWzheQH56cUN8qvMGFyhOtIHbVAxvIMWyYkt938cbiu2Zggw=
=s24t
-----END PGP SIGNATURE-----

--Bzq2cJcN05fcPrs+--
