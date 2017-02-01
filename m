Received: from eggs.gnu.org ([2001:4830:134:3::10]:56594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ3l9-0003YS-6a
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ3l6-0000YD-I8
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:52:13 -0500
Date: Thu, 2 Feb 2017 09:30:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201223023.GC13219@umbus.fritz.box>
References: <587D4171.6@linux.intel.com> <587D4329.5020702@linux.intel.com>
	<20170130235210.GA4681@tungsten.ozlabs.ibm.com>
	<CAFEAcA-FPmqw0pt7kT=eHR_osfFbZNhrDdGAb87VxUWD_XXSNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-FPmqw0pt7kT=eHR_osfFbZNhrDdGAb87VxUWD_XXSNw@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu-pcc 2.8.0 linux-user segfaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, =?iso-8859-1?Q?An=EDbal_Lim=F3n?= <anibal.limon@linux.intel.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 03:25:05PM +0000, Peter Maydell wrote:
> On 30 January 2017 at 23:52, Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:
> >> On 01/16/2017 03:56 PM, An=EDbal Lim=F3n wrote:
> >> > I'm trying to upgrade qemu to 2.8.0 in Openembedded-core and segfaul=
ts
> >> > in qemu-ppc when is executing:
>=20
> > I've recently encountered a similar problem and I've posted a fix. If
> > you'd like to try it, it's here:
> >
> > https://lists.gnu.org/archive/html/qemu-ppc/2017-01/msg00413.html
>=20
> Hmm, I missed that patch (it doesn't seem to have made it
> to the qemu-devel list), but it isn't correct, I'm afraid.
> In the patch for handling TARGET_USER_ESIGRETURN you must
> not change the nip register, because we will have just
> set it from the signal context that the guest provided
> to the sigreturn syscall. (The patch as it stands will
> cause us to reexecute an instruction after return from
> a signal handler, which isn't going to go very well).
>=20
> David, can you drop that patch from your ppc queue, please?

Ok, dropped, pending discussion of what the right fix is.

> (I think the change is good otherwise but I couldn't
> seem to find the bit in the ppc linux kernel that
> corresponds to moving the NIP value around.)
>=20
> thanks
> -- PMM
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkmF/AAoJEGw4ysog2bOShG4P/RCz83PjiSh7nnOP8YkTUtlM
K8UaKsl7Ibj+cvCAkj2O48qnAz1IlEZsv4kx/wTek/I2+u9J7MjYBFJRq5O2fsII
rj2IKO4avh2vEYq+aOEUDq/WFBYRAi7Un430AbjJGACHNULiGUaJkA7n4jziIYsA
8kIryA+ZE4vO2o25M1V+9w+bqK04hon8MlJOnCmKw5+fVZaD054qmlOiDZP66g4G
wuzHDwuqj/BPBt6rLobEImzr4LXs5fAXSJcTbGwZ5j01uQCoy6g+xIvV3geedY2c
iDO6hRGg+C8/SG4lcHOHLU+VLcLbyueTcRZJRL1SrQ2WQN4eOcAJZFTkudpN4BT5
CCKk6BuHA4nBSCuH8NfT0SfG+x0EDxiIxWH59pL3L1TsUqEgfRoDRXZt3lA1mACF
Be7UdjC978rpmZHkWSF4xNHR8SPvtpvmK1WAsykFnoohXR8AO4jK+fmkMHOZUSXX
2AIBXENS/Hgz3Opgps0ULvvkYuxXL/5C2qwvFqI5T1JVZY90ZBCCAPdxoHQEDhUn
i4yRUQt98ndVHTGHcBHwwSV5kGbLPs8CjkM0NG35gkb+MhUS4VfAU2Dy+wt88vQX
5SFumqS1F9biJN6p2slFCQZ+IE6/Lx10Tnh+zP7AdxB9pH6yKNyjRCleTermL7E9
kcHGQ2AYZX7C5gF16VKP
=CR3B
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
