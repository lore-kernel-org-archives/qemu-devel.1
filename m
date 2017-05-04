Received: from eggs.gnu.org ([2001:4830:134:3::10]:60660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6ELI-0000hR-Pz
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6ELD-0007Zx-TB
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:50:40 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6ELD-0007Z7-Mk
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:50:35 -0400
Received: by mail-wm0-x243.google.com with SMTP id d79so2455452wmi.2
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 03:50:35 -0700 (PDT)
Date: Thu, 4 May 2017 11:50:32 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504105032.GA32376@stefanha-x1.localdomain>
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20170419144219.20371-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] blockjob: separate monitor and
 blockjob APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 04:42:13PM +0200, Paolo Bonzini wrote:
> We have two different headers for block job operations, blockjob.h
> and blockjob_int.h.  The former contains APIs called by the monitor,
> the latter contains APIs called by the block job drivers and the
> block layer itself.
>=20
> Keep the two APIs separate in the blockjob.c file too.  This will
> be useful when transitioning away from the AioContext lock, because
> there will be locking policies for the two categories, too---the
> monitor will have to call new block_job_lock/unlock APIs, while blockjob
> APIs will take care of this for the users.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: move blockjob_create in the blockjob_int.h category,
>         rewrite commit message [John]
>=20
>  blockjob.c | 390 ++++++++++++++++++++++++++++++++-----------------------=
------
>  1 file changed, 205 insertions(+), 185 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCwd4AAoJEJykq7OBq3PIZqcH/iVXkicJxUMCYQfnr5jIUgXR
cK9Ujb69fHnQkPUmjpj/ohSsPtvIG7/zMZA+6rrS3xbLP7/T08eHOPo/2kx1r8/5
DhSeKTROtQyXKPnx0EVHqrc5pfWdSZw8s1T2VcqFaV1TYpG300ztQWIljYgfTuHt
lykKdpeTtaZDLh+o+aXkubCT6nqbJBaXRohOrERBKsfcI5cPRoz3UeKsD8RQCRwZ
avS2z6JAh60bHsdvrRbPz6hp+bfeIA9msNnG4p1Is5e0y2WBil0pfpYEM/WWN50g
ZGuFx/ZdMGXPwecJkZFdaPhMgvtMtgpp37cvV3ZLX67U7bhg1e8Du7AOdePTrsE=
=uF5b
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
