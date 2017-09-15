Received: from eggs.gnu.org ([2001:4830:134:3::10]:58967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dslmW-0001S2-2D
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dslmU-0004Rg-MV
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:15:24 -0400
Date: Fri, 15 Sep 2017 16:48:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170915064830.GI5250@umbus.fritz.box>
References: <20170906082748.28520-1-nikunj@linux.vnet.ibm.com>
	<20170909070212.GT2735@umbus.fritz.box>
	<87k2153jnx.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170913073519.GK7550@umbus.fritz.box>
	<8760clsw17.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a7XSrSxqzVsaECgU"
Content-Disposition: inline
In-Reply-To: <8760clsw17.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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


--a7XSrSxqzVsaECgU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 10:42:52AM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Mon, Sep 11, 2017 at 10:40:10AM +0530, Nikunj A Dadhania wrote:
> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >>=20
> >> > On Wed, Sep 06, 2017 at 01:57:48PM +0530, Nikunj A Dadhania wrote:
> >> >> When the user does not provide the cpu topology, e.g. "-smp 4", mac=
hine fails to
> >> >> initialize 4 cpus. Compute the chip per cores depending on the numb=
er of chips
> >> >> and smt threads.
> >> >>=20
> >> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> >> >
> >> > I don't understand why simply treating smp_cores as cores per chip i=
s wrong.
> >>=20
> >> We do not have SMT support and when "-smp 4" is passed, smp_cores is
> >> always set to 1. So only once core with one thread finally show up in
> >> the guest. Moreover, I see spapr too doing similar thing in
> >> spapr_init_cpus() with boot_cores_nr.
> >
> > I'm ok with adding an error if smp_threads > 1, since that won't
> > work.  Breaking the identity that smp_cores is the number of cores per
> > socket (which should correspond to one chip) is not ok, though.
> >
> > I think you're misinterpreting the boot_cores_nr stuff - that's just
> > about translating the number of initially online vcpus into a number
> > of initially online cores.
>=20
> I thought, I am doing the same here for PowerNV, number of online cores
> is equal to initial online vcpus / threads per core
>=20
>    int boot_cores_nr =3D smp_cpus / smp_threads;
>=20
> Only difference that I see in PowerNV is that we have multiple chips
> (max 2, at the moment)
>=20
>         cores_per_chip =3D smp_cpus / (smp_threads * pnv->num_chips);

This doesn't make sense to me.  Cores per chip should *always* equal
smp_cores, you shouldn't need another calculation for it.

> And in case user has provided sane smp_cores, we use it.

If smp_cores isn't sane, you should simply reject it, not try to fix
it.  That's just asking for confusion.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a7XSrSxqzVsaECgU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm7d74ACgkQbDjKyiDZ
s5Kd5hAAu3UqG3UyayEA1S2qmnziz/ztlHkwxjX99njSDB142GKFQfnaLUerptjX
WN19iayoTCAns5t7q3wVq8u1FHhrvxa7ryqc4YZy8SVVbgoalytWQ2RmL19XdRbF
KKiteBuRXSs7uR040EeUiXJ4m4rT4BDnK86hCjVtAG9tArz/RqPzu0JCYo2iJnsQ
3cqDNfSFxkLeLOMMdLLU1n0WDxl7XEbgMYzbIf5em+30d4jT3idjgnA3HaMPuPCo
jzs/thAGXgbQnoThQFeB0CSpsh6EMC9jsM2wTdJ0kePy0TsXLKPQVcVEA7D/z5LT
zNE9FxNsmk3QxQr3gnM6eNLsCdIUQlWsDh87r1iJGQrYinlH6/6jK5rBlLkTLQAq
EJryWSztBGO4GSXa+v8N2XISpx6vM4ggOW3HcUJ/rnLPaG9HBc8zu6VfSN/ZeyGs
9XNu6/K5haF2zlKMBFK/58zQB9CWrwBFfU7Mb/S/kt9ydAhRs93Pczjf3KG++hDM
AgGSNKD4shSY/pZlzrTL0Jzq7pgyRTpqzVVdah87qrpFyopC+72TpNqh6KeOaWlF
Uhg/LbPz+h9kxAn97Fk44EREi9GF5NVrZtGikdusaspkVyWT/Xqe3TBhIbXn3vVM
DeWL/OgzswnAVgShv/dSAyZAGINQ7U4OgYSZxuVUajx2MmAbeyc=
=KDmT
-----END PGP SIGNATURE-----

--a7XSrSxqzVsaECgU--
