Received: from eggs.gnu.org ([2001:4830:134:3::10]:32969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds2Co-0002EP-BG
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds2Cn-0000xK-8k
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:35:30 -0400
Date: Wed, 13 Sep 2017 17:35:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170913073519.GK7550@umbus.fritz.box>
References: <20170906082748.28520-1-nikunj@linux.vnet.ibm.com>
	<20170909070212.GT2735@umbus.fritz.box>
	<87k2153jnx.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jITzwD3HDGXid3BE"
Content-Disposition: inline
In-Reply-To: <87k2153jnx.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org


--jITzwD3HDGXid3BE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 10:40:10AM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Wed, Sep 06, 2017 at 01:57:48PM +0530, Nikunj A Dadhania wrote:
> >> When the user does not provide the cpu topology, e.g. "-smp 4", machin=
e fails to
> >> initialize 4 cpus. Compute the chip per cores depending on the number =
of chips
> >> and smt threads.
> >>=20
> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> >
> > I don't understand why simply treating smp_cores as cores per chip is w=
rong.
>=20
> We do not have SMT support and when "-smp 4" is passed, smp_cores is
> always set to 1. So only once core with one thread finally show up in
> the guest. Moreover, I see spapr too doing similar thing in
> spapr_init_cpus() with boot_cores_nr.

I'm ok with adding an error if smp_threads > 1, since that won't
work.  Breaking the identity that smp_cores is the number of cores per
socket (which should correspond to one chip) is not ok, though.

I think you're misinterpreting the boot_cores_nr stuff - that's just
about translating the number of initially online vcpus into a number
of initially online cores.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jITzwD3HDGXid3BE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm437YACgkQbDjKyiDZ
s5KcWQ/8C/C01cFTGSzcDK0fW6MJTGssstIboJy+pPHAcqr7N6kGuTlMffhuwb4a
j3+Eqf+owJc0ohj+onUPj5oJ7cwPC3+Xd8TlA3F9I8eYdnCyt82wfhmYDU7MSvft
g/GehzKt6Tkq+7d8zY5wFNcXNt/9Ji8Rfv45DB0JVJL9spUoZV/Cd3WCXG9PLeSW
29X3oKQW7ToTBH+jLw7sqLofo+giPgm8zTpjaK3T8TgzBa5mERMU00JMc8yxdG0w
L06tIwqVdVW4kBebPU0AONZPmhXzorgC9ruLRyGCkHr7wQWcQICCR52kp/CfZAUm
WHnXlm4RoVuMtPOeXd0JaLRQ2w0u0g/Yi5R4stj63nQdbmtaAdSJw88H6suD3lz6
bN22N1LS4+7Pj1Tj1fpIoZOSBRIbWvc0j5RUJXfduS6OOXLoVW8T+CCbO05Ahl1U
RDMjYjhKZlCZPrsDBDTMyuwuo1JCwZH2W1dauzwoWdDseeLFlPJCCn+AW4mbWnGS
2iUDrfTZvA4ID1ohsYr4mlDxyhklG2/BrtnS9TaFRbULXYdFtwB5UaTE1cU6KMUC
tIW3U9mlUOXuq7nDf8T9kBfpKlUcRYORqDTLFnc5ePCY/4digdueHDZtgTyJCDFT
kFJXmBrU/RZlq0scriaWDJPLwmGKlFk17ka3fJjU04rZ7zDiyTA=
=WX7/
-----END PGP SIGNATURE-----

--jITzwD3HDGXid3BE--
