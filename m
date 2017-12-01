Received: from eggs.gnu.org ([2001:4830:134:3::10]:52529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKw7K-0001lq-4J
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 19:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKw7F-0004uX-VM
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 19:57:18 -0500
Date: Fri, 1 Dec 2017 23:37:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171201123713.GA2130@umbus.fritz.box>
References: <1512127449-11114-1-git-send-email-s1seetee@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <1512127449-11114-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1] spapr.c: Update qemu's maxcpus for
 pseries machine.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2017 at 04:54:09PM +0530, Seeteena Thoufeek wrote:
> Need to adjust the max cpus supported number from error message since
> it was conflicting with KVM's.
>=20
> Steps to Reproduce:
> 1.boot up with
> "-smp 64,maxcpus=3D102464,cores=3D8,threads=3D1,sockets=3D8"
>=20
> qemu-kvm: Number of SMP CPUs requested (102464) exceeds max CPUs
> supported by machine 'pseries-rhel7.4.0alt' (1024)
>=20
> 2. On KVM machine it shows
>=20
> boot up with
> "-m 6G,maxmem=3D300G,slots=3D256 -smp 64,maxcpus=3D1024,cores=3D8,threads=
=3D1
> ,sockets=3D128"
>=20
> Number of hotpluggable cpus requested (1024) exceeds the maximum cpus
>  supported by KVM (240)
>=20
> It seemed that 1024 was useless since KVM only support 240 so far.
> Hence,we need to adjust it to an reasonable value 240.
>=20
> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>

This has been written without adequate thought and investigation.

First, in upstream code there's nothing wrong with having different
limits in qemu and kernel - the can both vary depending on various
factors.  Secondly, the 240 limit doesn't come from the kernel
upstream - only in RHEL.

Third, it doesn't even come from the kernel in RHEL - the downstream
qemu lies about the kernel limit.

I'm in the process of fixing this correctly, I expect to have
something on Monday.

> ---
>  hw/ppc/spapr.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9efddea..c753254 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3691,6 +3691,7 @@ static const TypeInfo spapr_machine_info =3D {
>          if (latest) {                                                \
>              mc->alias =3D "pseries";                                   \
>              mc->is_default =3D 1;                                      \
> +            mc->max_cpus =3D 240;                                      \
>          }                                                            \
>      }                                                                \
>      static void spapr_machine_##suffix##_instance_init(Object *obj)  \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlohTPYACgkQbDjKyiDZ
s5LephAA2Eg/1fhQBp59jFPu9aFtBTb/M+wKdvEoHP9uWA6of80zMoDcBcF5Xw+K
ID4t1Q4wPuEiikj5p14CXDJizOUlm4HHNoN4k4jIGG6I/ipd2zaqZdWadjK/ptYB
LqdHD2PCCdeu9Uphi2qsoA89Y/X00Jt1kIcSROQwsY3xhYR9X48DI+KXWEnxdyzZ
xL1uIgQ0SIoL2cgSrvou2AFoAmI6i1UBBsx6HvpZq0EPhlt9DAVS51ymwpbk4yb6
SaujqLCwrjXDytnBre9z73KwjaqNdM7Cimkl+zUvavMheCrYKXKpFgqFPRuabwkF
Iq5dcyfKsHnGyqfDUHBXLjTQoyDhPYrgFW8XjbFJQ8nXmU2IKfuhtfaFmmOiZuJt
jrgRchrHAB4bclAcJI6SCutqZt3BeY1cmlvA1WFKh74/YjrugU9YHIUU9drJz8AF
UMxd7n7no/aYxy9qk5+zGRlDVO1e4Ia9DmB26dh++647KWTKm5rUpzK0eFqpEB5B
FvkBKxhhNvOCxgwEb+UuI99h3I5k4ZpqFxH0gaSsV9KCUgQfl7es3rAAuxuI/r+F
5MgMDIYnaCw9lttnpRqP+TCdcJCAbnAvlUkXTUpB2pv24CDbN+EsDX6mZUCN/R7/
Jyk8NjeVOd1nBMiT7RfPzvyOtsKgfsPJUvkt37z9YRd5P8dPtm8=
=4vbO
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
