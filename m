Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGgcn-0008DJ-IL
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGgcm-0000rx-51
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 03:03:57 -0400
Date: Fri, 2 Jun 2017 13:35:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170602033541.GM13397@umbus.fritz.box>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601040646.GB27525@in.ibm.com>
	<149629114184.3207.6757927820110284250@loki>
	<20170601053037.GC13397@umbus.fritz.box>
	<d8d8aa98-46de-ae2e-1da9-25e9a53fd89b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="um2V5WpqCyd73IVb"
Content-Disposition: inline
In-Reply-To: <d8d8aa98-46de-ae2e-1da9-25e9a53fd89b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/4] spapr:DRC cleanups (part I)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, lvivier@redhat.com, sursingh@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--um2V5WpqCyd73IVb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 12:41:40PM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 06/01/2017 02:30 AM, David Gibson wrote:
> > On Wed, May 31, 2017 at 11:25:41PM -0500, Michael Roth wrote:
> > > Quoting Bharata B Rao (2017-05-31 23:06:46)
> > > > On Thu, Jun 01, 2017 at 11:52:14AM +1000, David Gibson wrote:
> > > > > The code managing DRCs[0] has quite a few things that are more
> > > > > complicated than they need to be.  In particular the object
> > > > > representing a DRC has a bunch of method pointers, despite the fa=
ct
> > > > > that there are currently no subclasses, and even if there were the
> > > > > method implementations would be unlikely to differ.
> > > > So you are getting rid of a few methods. How about other methods ?
> > > > Specially attach and detach which have incorporated all the logic n=
eeded
> > > > to handle logical and physical DRs into their implementations ?
> > > I would avoid any methods that incorporate special-casing for
> > > physical vs. logical DRCs, since that seems like a good logical
> > > starting point for moving to 'physical'/'logical' DRC
> > > sub-classes to help simplify the increasingly complicated
> > > state-tracking.
> > Right, I'm looking at making subclasses for each of the DRC types.
> > Possibly with intermediate subclasses for physical vs. logical, we'll
> > see how it works out.
>=20
> Back in the DRC migration patch series I talked with Mike about refactori=
ng
> the DRC code in such fashion (physical DRC and logical DRC). But first I
> would
> implement some kind of unit testing in this code to avoid breaking too mu=
ch
> stuff during this refactoring.

So, I'd love to have good unit tests, but everything takes time.

> I am not sure about the effort to implementing unit test in the
> current DRC code.  This series is simplifying the DRC code, making
> it more minimalist and possibly easier to be tested. In the end it
> would be a first step towards unit testing.

=2E.and as you say, extra complexity in the code makes testing and
reliability harder.

>=20
> However, there is the issue of backward compatibility. I fear this DRC
> refactoring
> of Logical/Physical DRC would be too drastic to maintain such compatibili=
ty
> (assuming that it is not already broken). If this refactor goes live only=
 in
> 2.11 then
> we will have a hard time to migrate from 2.11 to 2.10.

Right such a rework could break migration.

> All that said, I believe we can live without unit testing for a little
> longer and if
> we're going for this Physical/DRC refactoring, we need to push it for 2.1=
0.
> We can
> think about unit test later with the refactored code. Feel free to send to
> me any
> unfinished/beta DRC refactoring code you might be working on and want
> tested. I can help in the refactoring too, just let me know.

So like you I think getting it into 2.10 would be a good idea, before
we have any released version with DRC migration to break.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--um2V5WpqCyd73IVb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMN0NAAoJEGw4ysog2bOSLscP/3DWRgFG010ngzbRpBDtq0nv
i3xVA/DjO4s3pnWnoGWPl28e2IQWz0mRws4bNQSfhVWQRMNHHJ443/JFkI/Zqji+
qDFPybaj8gxygnLTbWfEBk4/zfRtklKzPMmKBOApVWTIkCYdeZ0AVlt8FtduSTJz
Nb56ZMwMhhANw2k9LiUA5mP9ia0MQKETy8OJSS0xTt82YXCOQw5xKKxhKXp0nO3T
m6bIgWj3WlmWCP50GcuE41blXdNfQP/BHoV2v2MaKRwlnvKwdhyLMtRv29IlANCp
EgBN2DKfM+eeIIczJ361zrWuTvm1nTABnt+i9pX3TF9PU1nvJrDgaWDIvG10xLeA
4ZJacphHB5/xMtxRe5tMnq6oPwxCco8g5Q3jYqRMHWNFvMW26zDEJiJIa9+qdjOj
OWHPZ9vRJpLwm8mrMBTmJjyqqr8jgPwCmUCIZOjMe9THT8Fu7O8MydR3qUUu49aQ
Bt8RwDbf+j2wbpZ6jQdbOx54ezgA9YgvnPQnt0qjaEj9tf6I9qsL2nfrLw3k3saB
TTlDsGF6JcEBE2LZ8NCC1eCM8R9S0glVTHOYWeOq0yoa8GrloLRnRsigcgvTEZ1z
oqix6LF0aTQdoIWKOJYEoFJ8ZpT1GU/W/71FEuM9S8L5/8BcPs8OYfCitsltxatE
cbaDKH3ZRiNn2/34LVrr
=uN13
-----END PGP SIGNATURE-----

--um2V5WpqCyd73IVb--
