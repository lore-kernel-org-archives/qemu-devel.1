Received: from eggs.gnu.org ([209.51.188.92]:59946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvw-0003I0-MZ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvv-0005Gx-9O
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:04 -0500
Date: Wed, 13 Feb 2019 15:13:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213041333.GI1884@umbus.fritz.box>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
	<154999593208.690774.9057564435432736364.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mlxBsilMljZ1v4XL"
Content-Disposition: inline
In-Reply-To: <154999593208.690774.9057564435432736364.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v4 15/15] spapr: enable PHB hotplug for
 default pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--mlxBsilMljZ1v4XL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 07:25:32PM +0100, Greg Kurz wrote:
> From: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> The 'dr_phb_enabled' field of that class can be set as part of
> machine-specific init code. It will be used to conditionally
> enable creation of DRC objects and device-tree description to
> facilitate hotplug of PHBs.
>=20
> Since we can't migrate this state to older machine types,
> default the option to true and disable it for older machine
> types.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 06ce0babcb54..4a6b2f7f3f62 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4166,6 +4166,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
>      spapr_caps_add_properties(smc, &error_abort);
>      smc->irq =3D &spapr_irq_xics;
> +    smc->dr_phb_enabled =3D true;
>  }
> =20
>  static const TypeInfo spapr_machine_info =3D {
> @@ -4231,6 +4232,7 @@ static void spapr_machine_3_1_class_options(Machine=
Class *mc)
>      compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>      smc->update_dt_enabled =3D false;
> +    smc->dr_phb_enabled =3D false;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mlxBsilMljZ1v4XL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjmW0ACgkQbDjKyiDZ
s5LvZxAAjc+r9kED2G1AHrN17ED/T0cQdVJ7qcKez4tPDqkx1GWsWhn1ZHlBqPIa
KObf4/rAoB4KkWCBwTV9OED6vHLTeSkm5Z1GePr1t/lZ6qVnqRz6OpZRO0VljmoD
MrfqG7Ui09RBFm7le3m2uvMBFkNmogqFa42VTAvJOiWNwehJ69m8RnPMycz5aujl
WwRQNoo6NUiKoP3cXlyGWdKdhtDMIP3QIsmIQ9iOWjz3uPQi8gnDdXjCy5JZcue/
eYD7TKy0XRvdNuknjL34e1e7I+G5LWMzVk6nWSo7LWBQU8UiRIuNgcjlMRhF6YZL
buqE4HJyeKNjVVgCORKPV21MmBqTm0v7RKizYSwIyRCwFyMtQPLbeyK+5HowAB+k
Kw4sw/y2JAJx7JtFtV7146r9H6Tnk9vDT0Q1bJV4AmtnEuheF20TBt5ZOkBI1tNq
9zWMzU8U8xcr/OvTvlpL1sBYcshUCnWhs/syIKgvASGNrqbpI+1wHpNqpgVxVu2a
rpdZJ48K8T4UHMWpWJ3syo7rXsH+BzNo6Jf6PnCqTxoXLgFY2UqxwZHg8M+UGihC
AjHeENIywAKtHQUHqUqgvHCAQDcfcQ5BqM8znx85qouoLJAVTpUtB8toenGptPFb
4kC58C5XSbiMbc4OpjwRplZ4gVtnvlUst3sFpI0UTc/5yOKqJOk=
=wqe9
-----END PGP SIGNATURE-----

--mlxBsilMljZ1v4XL--
