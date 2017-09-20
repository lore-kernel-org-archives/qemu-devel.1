Received: from eggs.gnu.org ([2001:4830:134:3::10]:41115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duYvM-00010o-Ox
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duYvL-0002V6-OP
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:55:56 -0400
Date: Wed, 20 Sep 2017 16:32:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920063234.GL5520@umbus.fritz.box>
References: <1505851374-6408-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170920042907.GC5520@umbus.fritz.box>
	<88f39fd3-0ecf-8c37-e159-684c845672fd@ilande.co.uk>
	<20170920060014.GI5520@umbus.fritz.box>
	<b8b0190f-0dd0-dc60-d5cb-fcf356a954d8@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZrCu0B0FMx3UnjE2"
Content-Disposition: inline
In-Reply-To: <b8b0190f-0dd0-dc60-d5cb-fcf356a954d8@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv2] macio: convert pmac_ide_ops from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--ZrCu0B0FMx3UnjE2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 07:28:27AM +0100, Mark Cave-Ayland wrote:
> On 20/09/17 07:00, David Gibson wrote:
>=20
> > On Wed, Sep 20, 2017 at 06:56:37AM +0100, Mark Cave-Ayland wrote:
> >> On 20/09/17 05:29, David Gibson wrote:
> >>
> >>> On Tue, Sep 19, 2017 at 09:02:54PM +0100, Mark Cave-Ayland wrote:
> >>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >>>
> >>> This didn't apply for me.  Can you rebase on top of ppc-for-2.11, ple=
ase.
> >>
> >> (goes and looks)
> >>
> >> Okay looks like the issue is that you're missing "[PATCH 3/8]
> >> ppc/ide/macio: Add missing registers" from your queue - I see you
> >> replied with an applied to ppc-2.11 email so I bet this got dropped on
> >> rebase somewhere.
> >=20
> > Oh, sorry.  Not sure how that happened.
> >=20
> >> Can you try again with that patch added and then let me know if it sti=
ll
> >> doesn't work?
> >=20
> > Uh.. I've lost track of it, I'm afraid.  Can you resend it and the
> > ide_ops one as a series.
>=20
> Done. BTW if possible can you keep them in a similar order, i.e. ensure
> that "ppc/ide/macio: Add missing registers" comes before "ppc: Fix
> OpenPIC model"? (See
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04397.html for
> the full set).

Done.

> This is because in my testing Linux will see the change in OpenPIC model
> and try to access the new macio registers, and so if that patch isn't
> there first then you end up with a hang on boot. Keeping the order will
> help make things much easier for bisection.
>=20
>=20
> ATB,
>=20
> Mark.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZrCu0B0FMx3UnjE2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnCC4IACgkQbDjKyiDZ
s5Kdsw//TAQAqKQUWPLv5NBuSchtdCmp9+SXlxGcUxSQoThxv7aUuxBi4qTA3uk/
elvGlGYtiNhxLpHEjKUzBG/fxZ8e/nfkrgMneyHzOeJn92s3Xewb0LWrk7Sa+sRP
tQakB8IRLf1g4xL/mx3jyTqVSF+25OiQ0szyyAQ3UmL9kZ3JVre1q0TwyiTLdsnh
D6pR28rkqtAVb87G//K8vpd7QWBHgeoxclaJ6qdHxurPEy6Q8qoPx8TTD0zjEXWI
NUpMfDIAR9FkradcEZnHkaL1uz6VwtSTwXE2M7xRg0a4EaiNFRBbPHiOTR+k+LSx
ffzYOiDJHJGGWTq1sNeLoP/8DtqgxX55JYMA4F5GF7Xr4MlKn9o9WjTGk4GlbgV8
Kf3couQQjCBW+9+2A5gUhhOMIv18WGtF4AIsA9meFwLcJi/tgadDMZqyZDjZ5QPT
8Ne0sFiBlL2iuAKI8D9O6Wibgo+1NcaOeYmGVIqJRn+tCpffZXO8dcn/LFwDSwkl
AorSV+/G9AC3hOQrIMzpPQlKEVIfS4Fxlz5pWperjsP7OLw+8xC974sZis0hn9Mv
i6v0ITcF/QKgKt7Hz3gdCBL/cF9XkOw27cYWeN4ooMJz2w6RKUxMh8HebUEwKuCj
4yyISuHrZiTV/AU8P0Avc8mZ6iWDl+Byh5s3zVxE4dCTQVFUbXM=
=3KQy
-----END PGP SIGNATURE-----

--ZrCu0B0FMx3UnjE2--
