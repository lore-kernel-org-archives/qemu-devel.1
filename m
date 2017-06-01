Received: from eggs.gnu.org ([2001:4830:134:3::10]:59915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGIh8-00030X-0E
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 01:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGIh7-0005YM-4G
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 01:30:50 -0400
Date: Thu, 1 Jun 2017 15:30:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170601053037.GC13397@umbus.fritz.box>
References: <20170601015218.9299-1-david@gibson.dropbear.id.au>
	<20170601040646.GB27525@in.ibm.com>
	<149629114184.3207.6757927820110284250@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <149629114184.3207.6757927820110284250@loki>
Subject: Re: [Qemu-devel] [PATCH 0/4] spapr:DRC cleanups (part I)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, lvivier@redhat.com, nikunj@linux.vnet.ibm.com, sursingh@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 11:25:41PM -0500, Michael Roth wrote:
> Quoting Bharata B Rao (2017-05-31 23:06:46)
> > On Thu, Jun 01, 2017 at 11:52:14AM +1000, David Gibson wrote:
> > > The code managing DRCs[0] has quite a few things that are more
> > > complicated than they need to be.  In particular the object
> > > representing a DRC has a bunch of method pointers, despite the fact
> > > that there are currently no subclasses, and even if there were the
> > > method implementations would be unlikely to differ.
> >=20
> > So you are getting rid of a few methods. How about other methods ?
> > Specially attach and detach which have incorporated all the logic needed
> > to handle logical and physical DRs into their implementations ?
>=20
> I would avoid any methods that incorporate special-casing for
> physical vs. logical DRCs, since that seems like a good logical
> starting point for moving to 'physical'/'logical' DRC
> sub-classes to help simplify the increasingly complicated
> state-tracking.

Right, I'm looking at making subclasses for each of the DRC types.
Possibly with intermediate subclasses for physical vs. logical, we'll
see how it works out.

> I also don't think we should expose DRC internal fields to
> outside callers (which attach/detach would involve).

Well.. just changing attach/detach to plain functions instead of
methods wouldn't break that.

> This
> series does that to some extent with the RTAS calls, but
> since those are now moved to spapr_drc.c it makes more sense.

Right - the semantics of the RTAS calls are tied closely to the DRC
semantics, so I don't think there's any point considering the RTAS
calls to be "outside" the DRC code itself.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZL6Z9AAoJEGw4ysog2bOSiIIQALySJErP00w6yEMhvzCO4xac
y0lGk0umwb/WdTn4PIXOgxJiqcklzC+Ao9rtmQ6+B18oUN/IfW5H3dKzjomNRIPV
iDcbgf2w5OR6ulLZwinfO+SKxoBX2jlCAdh4CCkV+D2MIDObJa509Hj0Ls5EqAiz
H1bNW+Sxemej2Qur/BvlBjHUWVfyI+hPLELw9xAlz17Nyiw7KvsS56o0iVkd29U8
Msr8J4bVi81pm/OxdbFqs7HvnpxgtsvULqjpYveFscBnWTuHwkT7DVNXGidf3Q1Z
SaxboRFphnFXYTCLg4WfYAO/U35GG2qWsGROrQnS3hXBf1XTHUc/Md+4jckWdm3Z
uV0QmCF5luTlOsVbAgYs9VXJz8J08TRw+9ccb40m30u14UV8Uvmas5idqYY4bcD0
f0Et2UfrXXcXBHDNxCjsnLqkDLrkpk79B5jXM8//dBrx8yvaxRJb4GuA4utrZkbM
6f1ufVeucXU9Ur2Du6UYaEX4LEesmxte+7BhUWPGQk5uqGCy2xjIlewlH8hkE7GP
q7n4g7IOsPlQCTfbKMOtrDvpOAW2GruH7EbEkRRY/l+wCkDjxnFlTC5aDfUM29cY
XUsZN5B7xvsuLlhABjQ95HRjTqxlgP0/HIAvz++RVMwNo9dpKtSq9eG43S0XMvV6
RWzJ2h/SQCS9VLRtXGSz
=JbKp
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
