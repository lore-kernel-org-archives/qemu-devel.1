Received: from eggs.gnu.org ([2001:4830:134:3::10]:45800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkiIT-0006DH-5n
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkiIS-0005Io-3R
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:55:05 -0400
Date: Thu, 24 Aug 2017 12:51:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170824025151.GA5379@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ab632ef70b02efb2257d9e2f08b45b097ebacb3a.1503249785.git.balaton@eik.bme.hu>
	<20170823041644.GP5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708231217070.76247@zero.eik.bme.hu>
	<8fe81d01-0a39-02cc-c7d8-59437c4f94ac@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pMHZerOf5PT7gmN5"
Content-Disposition: inline
In-Reply-To: <8fe81d01-0a39-02cc-c7d8-59437c4f94ac@free.fr>
Subject: Re: [Qemu-devel] [PATCH 15/15] ppc: Add aCube Sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Fran=E7ois?= Revol <revol@free.fr>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--pMHZerOf5PT7gmN5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 01:43:56PM +0200, Fran=E7ois Revol wrote:
> Le 23/08/2017 =E0 13:12, BALATON Zoltan a =E9crit :
> >> What's the connection with mips_malta?
> >=20
> > The board's firmware wants to see SPD EEPROMs of the connected memory
> > while initialising the memory controller. This is why we need to
> > implement SDRAM controller, I2C and SPD EEPROMs. MIPS malta board had
> > already SPD EEPROM implementation so this is based on that. The comment
> > just indicates where this code comes from.
>=20
> Indeed, and I copy-pasted from elsewhere for this.
>=20
> >>> +        fprintf(stderr, "qemu: Error registering flash memory.\n");
> >>
> >> Use error_report() instead, please.
>=20
> I guess this didn't exist back when I started writing it...

Probably not.

> >>> +/* Create reset TLB entries for BookE, mapping only the flash
> >>> memory.  */
> >>> +static void mmubooke_create_initial_mapping_uboot(CPUPPCState *env)
> >>> +{
> >>> +    ppcemb_tlb_t *tlb =3D &env->tlb.tlbe[0];
> >>> +
> >>> +    /* on reset the flash is mapped by a shadow TLB,
> >>> +     * but since we don't implement them we need to use
> >>> +     * the same values U-Boot will use to avoid a fault.
> >>> +     */
> >>
> >> Usually the reset state of the MMU is handled in the cpu code rather
> >> than the board code.  Is there a specific reason you need it in the
> >> board code here?
> >=20
> > I'm not sure, probably lack of a better place. The ppc440_bamboo board
> > this is based on has it the same way in the board code. Maybe this could
> > be cleaned up when someone wants to QOMify the SoC models sometimes.
>=20
> Thing is, the code allows both booting with U-Boot and with a kernel
> directly, and the MMU mapping differ in those cases.
>=20
> Maybe the CPU reset should use the U-Boot setup and the kernel boot
> would just overwrite it?

Yes.  Basically the CPU reset should do what real hardware does - and
I'd expect u-boot to be written to work with that.  The kernel, on the
other hand will expect whatever mappings come out of u-boot (or
another bootloader).  Long term, I think you want to always use the
hardware setup and actually run the guest firmware to set up the
mappings the kernel expects.  For early development where it's useful
to be able to boot into a kernel without firmware, faking the right
mappings in the board code is perfectly reasonable.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pMHZerOf5PT7gmN5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmeP0cACgkQbDjKyiDZ
s5IcUg//Rgl0zMnhNMLdCIFDhYFEGVNsNVBjHcXU1GbRbW10Bhfl2SAbMQX71hCB
jw5bDgE9PDjzGOp/SfL2hl0s/MTFxJVj9PR0qNl5v/Xt5Ya55Rg690PrD2m2FmAm
IEWd4nY3uwWypazlS8/Tpxr/0rdnm7uGFzR50N52hjhQOSEIaQmiy5fCwle+HitW
ylScSFabr7J6uuP3NwEki2UsxG/5jmt5+Zc4Mv+3CESC/PLUgVVyAeMomTjkUyCn
bzWP926kqfDMYOWTd/x3UppWqAJS90sYFVesv8Hsp07bfMDT6rOmWERxe+W04xNv
lsgCCWlLeabOCPNJa1ZW7LgnxEOwm/KV3k2//I7Xy2sV72/Wr+pFQDybuv7K3a5k
EQl7G05LxdWFKch2UJFafok2aAJ3cqRv0iaqMs+emduytH8jG88zUqSajpq35p7b
E6rqW7G/LSdso0vcUQVH/ykv5547b2moEdlDbp05rZAvdWW+JVKKJsQUPqRieKvI
CwYqchXdnHSHzi4o/b7uM//VCYZHf6E2Tu6/VcY1ahNZFKmwD0HO+vTmVhswO9vo
5DehDu1y6n6IvVUjXS6AJg78QpUkfQp7x76CYDsBtQttWzp7zb2ASHUPJA3ptpOv
/7Dp9+i8HFDmpvQRVUOPG4L9KOtM5p5lWJ1JdDLUxv+RxDE2S0I=
=Wfo8
-----END PGP SIGNATURE-----

--pMHZerOf5PT7gmN5--
