Received: from eggs.gnu.org ([2001:4830:134:3::10]:36311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fTNRS-0000wm-33
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fTNRN-0004Lf-4R
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:17:14 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fTNRM-0004LV-SX
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:17:09 -0400
Received: by mail-wm0-x242.google.com with SMTP id v131-v6so10189902wma.1
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 01:17:08 -0700 (PDT)
Date: Thu, 14 Jun 2018 09:17:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180614081705.GA12035@stefanha-x1.localdomain>
References: <20180612204632.28780-1-jusual@mail.ru>
	<20180613140505.GS24528@stefanha-x1.localdomain>
	<9047ab62-0bf7-d473-e4c3-562f33c68349@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <9047ab62-0bf7-d473-e4c3-562f33c68349@mail.ru>
Subject: Re: [Qemu-devel] [PATCH] target/arm: Allow ARMv6-M Thumb2
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, Steffen =?iso-8859-1?Q?G=F6rtz?= <mail@steffen-goertz.de>, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 08:10:23PM +0300, Julia Suvorova via Qemu-devel wro=
te:
> On 13.06.2018 17:05, Stefan Hajnoczi wrote:
> > On Tue, Jun 12, 2018 at 11:46:32PM +0300, Julia Suvorova wrote:
> > > ARMv6-M supports 6 Thumb2 instructions. This patch checks for these
> > > instructions and allows their execution.
> > > Like Thumb2 cores, ARMv6-M always interprets BL instruction as 32-bit.
> > >=20
> > > This patch is required for future Cortex-M0 support.
> > >=20
> > > Signed-off-by: Julia Suvorova <jusual@mail.ru>
> > > ---
> > >   target/arm/translate.c | 35 ++++++++++++++++++++++++++++++-----
> > >   1 file changed, 30 insertions(+), 5 deletions(-)
> >=20
> > Does make the undefined instruction test case that I recently posted
> > pass (including all commented out instructions that weren't working
> > yet)?
> >=20
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >=20
>=20
> Yes, test with all instructions is passed.

Great, I have sent a v2 of that patch.  It now also includes the 6 valid
32-bit instructions to prove that your patch has enabled them.

Stefan

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbIiSBAAoJEJykq7OBq3PIZnwIAIXepul5mHLE8tl+9776q6xy
eyEI0S0JwR/cHnMMRPzItKI2cKddwVloDGQ53+NFdXmaFdnpaR4eHMvBAhPmBdwN
liEFfQbZ1nzCeDTHKpaSqDrRBMHQMmspGazdgoR6kpNnKV88cinvoTb/DvfvQZIf
noXHENBqAtFswbpt//xVwNZ1XtF+h7ee/XrWJ1N3ldahPV1ASuOe9bsoCaS3Q2Ht
7iWDGPA7xZoB91YkZ+r8Z5pQ8ti5x+4+qku5Oyffz9o4PB85zL0z5UushSRKqX33
HF0j5ULRjjK16Ldt85kpMJm+um3VC+xc81oi52c4vmF3hvefDy15cWKkGOG4HZ8=
=lyyH
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
