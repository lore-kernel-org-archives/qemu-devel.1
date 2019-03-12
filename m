Received: from eggs.gnu.org ([209.51.188.92]:57805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h3YBA-0002xt-Ox
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h3YB9-0005Ci-KK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:34:12 -0400
Date: Tue, 12 Mar 2019 11:44:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190312004422.GB3303@umbus.fritz.box>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
	<CAFEAcA--XHtUhOzSdNBDOVXbEceHkWSFiBcgNMTr5B-zz2fajA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <CAFEAcA--XHtUhOzSdNBDOVXbEceHkWSFiBcgNMTr5B-zz2fajA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/60] ppc-for-4.0 queue 20190310
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2019 at 04:06:38PM +0000, Peter Maydell wrote:
> On Sun, 10 Mar 2019 at 08:27, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> >
> > The following changes since commit f5b4c31030f45293bb451744572276843482=
9d91:
> >
> >   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-reques=
t' into staging (2019-03-09 17:35:48 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190310
> >
> > for you to fetch changes up to 08d020471fcd41cb020fc9987ed1945eefcc8805:
> >
> >   spapr: Use CamelCase properly (2019-03-10 14:35:44 +1100)
> >
> > ----------------------------------------------------------------
> > ppc patch queue for 2019-03-10
> >
> > Here's a final pull request before the 4.0 soft freeze.  Changes
> > include:
> >   * A Great Renaming to use camel case properly in spapr code
> >   * Optimization of some vector instructions
> >   * Support for POWER9 cpus in the powernv machine
> >   * Fixes a regression from the last pull request in handling VSX
> >     instructions with mixed operands from the FPR and VMX parts of the
> >     register array
> >   * Optimization hack to avoid scanning all the (empty) entries on a
> >     new IOMMU window
> >   * Add FSL I2C controller model for E500
> >   * Support for KVM acceleration of the H_PAGE_INIT hypercall on spapr
> >   * Update u-boot image for E500
> >   * Enable Specre/Meltdown mitigations by default on the new machine ty=
pe
> >   * Enable large decrementer support for POWER9
> >
> > Plus a number of assorted bugfixes and cleanups.
> >
>=20
> Hi. This pullreq generates a pile of new 'warning' messages
> during 'make check':
>=20
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64
> QTEST_QEMU_IMG=3Dqemu-img tests/
> boot-serial-test -m=3Dquick -k --tap < /dev/null |
> ./scripts/tap-driver.pl --test-name=3D"boot-serial-test"
> PASS 1 boot-serial-test /ppc64/boot-serial/ppce500
> PASS 2 boot-serial-test /ppc64/boot-serial/40p
> PASS 3 boot-serial-test /ppc64/boot-serial/mac99
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-cfpc=3Dworkaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-sbbc=3Dworkaround
> qemu-system-ppc64: warning: TCG doesn't support requested feature,
> cap-ibs=3Dworkaround
> PASS 4 boot-serial-test /ppc64/boot-serial/pseries
> PASS 5 boot-serial-test /ppc64/boot-serial/powernv
> PASS 6 boot-serial-test /ppc64/boot-serial/sam460ex
>=20
> and similarly during the boot-pxe-test.
>=20
> Could you silence these, please?

Ok, done.  As a rule these warnings are there intentionally for TCG -
we want to enable Spectre/Meltdown mitigations by default, but no-one
really knows if and how to implement them for TCG.

But I can and have suppressed the warnings for the qtest case.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyHAOYACgkQbDjKyiDZ
s5LZUw/+KiwR/7ZIZv7wfKSKIBbQ1k9SP2V6W7dE6vH4G62DBM9H+juXROV2gJ27
2roD30GFem1uBHUr4jL8Vb9LtSufAph6hkshR0ts6BnujR+h7+IGV6RG/yQwM+/4
91mp3nDkiQmAK4IEt0j8oWOz/d+SVtxl+ZBNfZNd57LDasGjVp9T5D/US1UNIq3S
V9dpAt6wA/ZCEvcJW72+huaP3ymkQZRWrH7H1U2ccgfoCg2Mln3TqnpCaufVbbiY
TzW8ePm6/XnppTliMtxAfTCT7JwDqWAc2cBWeOWS7CIyDc3WyMWv8JOHFWd62QUB
tm8V08TRmwg0tQzjam8Qu1IKrkI3Ok2oM+CfUYfOKtuyvj0auR9MGrVjjqSvS/f3
4Pwi/g3jiuEdex0FA8n4WQeqFXzyZsjXyItSsSe19iOLj14OtUFVVSPq+Ha9pwaR
omvWDv3MZuBGECMNOxKYi0tgZlS5DYQM7pPYNb8GfPiuTgC1YqRK2zr1SY0i67nQ
lwdSQPuWUHQ2RF2dwfCaDoeOaDpdLHDbGZnX7XRDRsThkFcZ8RUd26S5rnCk7LfU
44Gs2ONGpB4VZ3ezMxJrvltbWXwzLdGE+Eek41WY/NSfPNKk+AV4Qozj1egGDTEo
26h5sOSLZNvNH5Knc7J+4cLqx2sThEgqiN4Nh16UHB/dfcjs4Ag=
=zQxO
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
