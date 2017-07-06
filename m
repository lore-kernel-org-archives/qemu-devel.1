Received: from eggs.gnu.org ([2001:4830:134:3::10]:54590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dTDjR-0005tT-OP
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 16:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dTDjM-0005zr-Ho
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 16:50:37 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:47611
	helo=imgpgp01.kl.imgtec.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Hogan@imgtec.com>)
	id 1dTDjM-0005ss-8U
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 16:50:32 -0400
Date: Thu, 6 Jul 2017 21:50:26 +0100
From: James Hogan <james.hogan@imgtec.com>
Message-ID: <20170706205026.GA32741@jhogan-linux.le.imgtec.org>
References: <cover.bcfb6a7121f5fd92c9ebda9f199ff06cb0d4bc05.1473159543.git-series.james.hogan@imgtec.com>
	<e713111f058685914efa8ce0be14197b151cfa9a.1473159543.git-series.james.hogan@imgtec.com>
	<6785d7db-8866-9f50-b182-24c7ed69e34d@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <6785d7db-8866-9f50-b182-24c7ed69e34d@imgtec.com>
Subject: Re: [Qemu-devel] [PATCH 4/9] target-mips: Check memory permissions
 with mem_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 07, 2016 at 04:48:31PM +0100, Yongbok Kim wrote:
> On 06/09/2016 12:03, James Hogan wrote:
> > diff --git a/target-mips/helper.c b/target-mips/helper.c
> > index 29ebf391cb94..2065fc3ec119 100644
> > --- a/target-mips/helper.c
> > +++ b/target-mips/helper.c

> > @@ -413,11 +413,12 @@ static void raise_mmu_exception(CPUMIPSState *env=
, target_ulong address,
> >  hwaddr mips_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
> >  {
> >      MIPSCPU *cpu =3D MIPS_CPU(cs);
> > +    CPUMIPSState *env =3D &cpu->env;
>=20
> Not really useful change as it is used only once but it is ok.

Its used twice in the code below ...

>=20
> >      hwaddr phys_addr;
> >      int prot;
> > =20
> > -    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0,
> > -                             ACCESS_INT) !=3D 0) {
> > +    if (get_physical_address(env, &phys_addr, &prot, addr, 0, ACCESS_I=
NT,
> > +                             cpu_mmu_index(env, false)) !=3D 0) {

=2E.. though I acknowledge it has marginal value

> Otherwise,
>=20
> Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>

Thanks
James

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlleolcACgkQbAtpk944
dnrzVRAAkVhKL8YrBElU3D0jGXn2yGd0q5YwZ3mmWYargDskNWQpnY83UJhEOHXA
ci53CL/exek7AYtnPtoMNmU59hZRRN9rr4gPPOchVLfJpAlom++xRm/jTJwX+CUZ
H94ClxTJpmAptmIfRMYXzrhGJqaTq2xW7VuzHA+p5qeeGKOvbvyIPGDW1PcESiu9
maAqnJOkwNjn04rf6y/Gcz6ESWuq1blanOCH+V2tBDNtebrtNEMzW4fM0TkvqDGY
z0hI6xqaIHPN9bczpLIByNJIwrgrXYW35X6pP5u74U6TfGeXzQMyzCu89r/z7CVb
I5NFP2w9WlgxfsrOkbKYLlJilYb5VZG3UbdRmL1SouOkRMXho79Uet7Z/4jSiLi4
kgcVB6VDpCmAixgPcZP5LFUJZcza0km/p4iXFsoBXtkWdcY3wo9Pz2AyXrwL3QfH
nR+DbaRqNUVnfGIhHLS12cda6hYpEh6F+7igLya9OrTQD+3Dwb5j+G2xvpS1LtjJ
FiP9WlYzctd4TUixlOOHXG1op4xYkE0vHHOnsUdeC1EgPYxr45hw7A0cPobTont0
LQXSRpW2Ohs6kAq3LXkXBs/1FDp07rOjGE+f8dbJQlTV5FIe360dI0N7E2ztS2sh
fScKNu+MFx+O53wr6ajGXMkqVssc58XiALowzm69DOe4uf3jzeA=
=Shzz
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
