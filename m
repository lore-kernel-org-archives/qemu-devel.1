Received: from eggs.gnu.org ([2001:4830:134:3::10]:54900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXQNw-00053I-ES
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXQNs-0006h4-9T
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:09:48 -0400
Date: Tue, 18 Jul 2017 16:50:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170718065055.GG3140@umbus.fritz.box>
References: <20170717041639.16137-1-nikunj@linux.vnet.ibm.com>
	<20170718044619.GC3140@umbus.fritz.box>
	<877ez6e2tm.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Content-Disposition: inline
In-Reply-To: <877ez6e2tm.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: disable decrementer during reset
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


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 10:53:01AM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Mon, Jul 17, 2017 at 09:46:39AM +0530, Nikunj A Dadhania wrote:
> >> Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.
> >>=20
> >> When reset happens, all the CPUs are in halted state. First CPU is bro=
ught out
> >> of reset and secondary CPUs would be initialized by the guest kernel u=
sing a
> >> rtas call start-cpu.
> >>=20
> >> However, in case of TCG, decrementer interrupts keep on coming and wak=
ing the
> >> secondary CPUs up.
> >>=20
> >> These secondary CPUs would see the decrementer interrupt pending, whic=
h makes
> >> cpu::has_work() to bring them out of wait loop and start executing
> >> tcg_exec_cpu().
> >>=20
> >> The problem with this is all the CPUs wake up and start booting SLOF i=
mage,
> >> causing the following exception(4 CPUs TCG VM):
> >
> > Ok, I'm still trying to understand why the behaviour on reboot is
> > different from the first boot.
>=20
> During first boot, the cpu is in the stopped state, so
> cpus.c:cpu_thread_is_idle returns true and CPU remains in halted state
> until rtas start-cpu. Therefore, we never check the cpu_has_work()
>=20
> In case of reboot, all CPUs are resumed after reboot. So we check the
> next condition cpu_has_work() in cpu_thread_is_idle(), where we see a
> DECR interrupt and remove the CPU from halted state as the CPU has
> work.

Ok, so it sounds like we should set stopped on all the secondary CPUs
on reset as well.  What's causing them to be resumed after the reset
at the moment?

> > AFAICT on initial boot, the LPCR will
> > have DEE / PECE3 enabled.  So why aren't we getting the same problem
> > then?
>=20
> Regards
> Nikunj
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlltr88ACgkQbDjKyiDZ
s5KlVRAA0mm9i1Blg0G0Wjv6sRpGnhz98PbDXjqz9nbluTpZLSIT0Yc6pR3/wwMS
RcZeJh1swvyEJe+lcswooH6C5+Ox39Qs/nE8+RaWlhy9MxWuyk4be0iBwF1sDpGu
e9PSl+akSEICbtIuQ5GF2UjTUKURCsA2yGZiYWirljFxa6mR/X9SGWbhIAuRMK8s
t3pMFHfB3RLlDNNv/sb9aTCxgG9JDD2gcOfF2KVbqTfD5retC3+Uc3oOw0m6ykOA
v9+lardTK6wWL4W2DW8qMJKFN6LWMl0t4Y4K2d+kK/i7bf0BHuBYBtBLVdRChwZJ
/c3UJGztSOaabnBsXvk1IoArv2mish666PMg7awND2rWxVgjUODorkk9yI07Bk3W
07CIX1af8dlj79/ZAo4lwdLELwkfvxrX+O4OMd+vAU1HRexAakA6bXfCQVEV5Vdn
KJ1FuitUomXifZS8E9So5sBV6lBEtlCKig7xEdmiPIha584AmQgdtczT3NWkZS3c
AXMOfdN/zwlehspu/nieTjcX8gaNG+8MKDjKavX5GH/D+Etl9eWKUZ462VKIjrw4
yT2VF3R48BrfXpgl66+BMOJkIq6VTPNuRjOJ1m6HV7rfGM79UZcrAzaiU6ohuJkD
AdBYXZLwySng3sTx5LnxXzqfuCIzj7IzEU3Uv3r6jPlmcC3jKg0=
=cTpl
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--
