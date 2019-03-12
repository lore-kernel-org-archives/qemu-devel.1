Received: from eggs.gnu.org ([209.51.188.92]:57807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h3YBA-0002xu-TS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h3YB9-0005Cr-LP
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:34:12 -0400
Date: Tue, 12 Mar 2019 11:26:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190312002654.GA3303@umbus.fritz.box>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
	<CAFEAcA--XHtUhOzSdNBDOVXbEceHkWSFiBcgNMTr5B-zz2fajA@mail.gmail.com>
	<87zhq1ofrd.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <87zhq1ofrd.fsf@zen.linaroharston>
Subject: Re: [Qemu-devel] [PULL 00/60] ppc-for-4.0 queue 20190310
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 10:40:54AM +0000, Alex Benn=E9e wrote:
>=20
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> > On Sun, 10 Mar 2019 at 08:27, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> >>
> >> The following changes since commit f5b4c31030f45293bb45174457227684348=
29d91:
> >>
> >>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-reque=
st' into staging (2019-03-09 17:35:48 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>   git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190310
> >>
> >> for you to fetch changes up to 08d020471fcd41cb020fc9987ed1945eefcc880=
5:
> >>
> >>   spapr: Use CamelCase properly (2019-03-10 14:35:44 +1100)
> >>
> >> ----------------------------------------------------------------
> >> ppc patch queue for 2019-03-10
> >>
> >> Here's a final pull request before the 4.0 soft freeze.  Changes
> >> include:
> >>   * A Great Renaming to use camel case properly in spapr code
> >>   * Optimization of some vector instructions
> >>   * Support for POWER9 cpus in the powernv machine
> >>   * Fixes a regression from the last pull request in handling VSX
> >>     instructions with mixed operands from the FPR and VMX parts of the
> >>     register array
> >>   * Optimization hack to avoid scanning all the (empty) entries on a
> >>     new IOMMU window
> >>   * Add FSL I2C controller model for E500
> >>   * Support for KVM acceleration of the H_PAGE_INIT hypercall on spapr
> >>   * Update u-boot image for E500
> >>   * Enable Specre/Meltdown mitigations by default on the new machine t=
ype
> >>   * Enable large decrementer support for POWER9
> >>
> >> Plus a number of assorted bugfixes and cleanups.
> >>
> >
> > Hi. This pullreq generates a pile of new 'warning' messages
> > during 'make check':
> >
> > MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> > QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64
> > QTEST_QEMU_IMG=3Dqemu-img tests/
> > boot-serial-test -m=3Dquick -k --tap < /dev/null |
> > ./scripts/tap-driver.pl --test-name=3D"boot-serial-test"
> > PASS 1 boot-serial-test /ppc64/boot-serial/ppce500
> > PASS 2 boot-serial-test /ppc64/boot-serial/40p
> > PASS 3 boot-serial-test /ppc64/boot-serial/mac99
> > qemu-system-ppc64: warning: TCG doesn't support requested feature,
> > cap-cfpc=3Dworkaround
> > qemu-system-ppc64: warning: TCG doesn't support requested feature,
> > cap-sbbc=3Dworkaround
> > qemu-system-ppc64: warning: TCG doesn't support requested feature,
> > cap-ibs=3Dworkaround
> > PASS 4 boot-serial-test /ppc64/boot-serial/pseries
> > PASS 5 boot-serial-test /ppc64/boot-serial/powernv
> > PASS 6 boot-serial-test /ppc64/boot-serial/sam460ex
> >
> > and similarly during the boot-pxe-test.
> >
> > Could you silence these, please?
>=20
> FWIW this PR contains fixes that will finally get the gitlab CI green so
> I look forward to v2 getting merged ;-)

Huh.  I knew about the travis CI and the shippable CI, but not the
gitlab one.  How do I see that?  It was surprisingly non-obvious from
the gitlab qemu project page.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyG/MsACgkQbDjKyiDZ
s5JuPxAAlA6lykiS32K0eNTQQUJJSpWdnytRM4o8x0SG3xPg0wQZ6E8F1y4cJVUh
P/SIZzG96bIpoPZr2AThm67NWE+5R/0JBRdi4sf1+3Cg1fY3ghVs5BY3G8Q1rcKJ
as1irQ0LUTPHdxo6R/D6fK2EOzZ/sY0JI5Zg8BePTkzNuEJ/EZXDx91SrTWPLEnD
fzfqt0MBrFZHmgk2z+asCfYDsa8nAOIeMDjgW54I8k4DncYaeaVZIvGqhgn3ew5E
fU5Ztd2C1/3DGLXyODIo6O2Bpy3VioQPW/v/3XTCXLnMsCP3uD1K0tvCFkW8YKkB
RSJksooYycI+6+grFmEROWu66QEQL0xgNdFQd6vNh8WV/FeDKxgZ1Cra942+THnt
5DVZ5vMd69vHdt/cYXsvkYYuz9ULD9MtMHYiuq8Z/qXd0PPd5/MWCEqwPg5gv3W1
TwQQTnXg7OeMrvg03g0qbuLsBqt4bEx/rG7GKNE7wxh/pfGSL/WwatrC/7qXRcp8
disPmfMcoEiIfJIjODdID216eL/mZ6Uzp+pgB6sVUIVblHNUqtUg4M1M7NfCMS4n
mmoMvuSB+w4eQAJayUMNMNmfGb+vPXogiJ05IXYr8RCMa/0TNJSI6MBtkfp264vx
oSjQzRRvUOjy1hgSRmx94fo3eIw14JYK3hGHd9dphA4J+L6q8SU=
=PDYK
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
