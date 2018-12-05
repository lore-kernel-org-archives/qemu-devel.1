Received: from eggs.gnu.org ([2001:4830:134:3::10]:44128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUfon-0007xY-Ql
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUfom-0005cz-8L
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 17:38:57 -0500
Date: Thu, 6 Dec 2018 09:29:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181205222925.GF768@umbus.fritz.box>
References: <20181205205827.19387-1-ehabkost@redhat.com>
	<20181205205827.19387-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Content-Disposition: inline
In-Reply-To: <20181205205827.19387-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 2/5] spapr: Use
 default_machine_opts to set use_hotplug_event_source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 06:58:24PM -0200, Eduardo Habkost wrote:
> Instead of setting use_hotplug_event_source at instance_init
> time, set default_machine_opts on spapr_machine_2_7_class_options()
> to implement equivalent behavior.
>=20
> This will let us eliminate the need for separate instance_init
> functions for each spapr machine-type.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 80d8498867..f6b60e6fbd 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4240,10 +4240,7 @@ static void phb_placement_2_7(sPAPRMachineState *s=
papr, uint32_t index,
> =20
>  static void spapr_machine_2_7_instance_options(MachineState *machine)
>  {
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> -
>      spapr_machine_2_8_instance_options(machine);
> -    spapr->use_hotplug_event_source =3D false;
>  }
> =20
>  static void spapr_machine_2_7_class_options(MachineClass *mc)
> @@ -4252,6 +4249,7 @@ static void spapr_machine_2_7_class_options(Machine=
Class *mc)
> =20
>      spapr_machine_2_8_class_options(mc);
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power7_v2.3");
> +    mc->default_machine_opts =3D "modern-hotplug-events=3Doff";
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_7);
>      smc->phb_placement =3D phb_placement_2_7;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwIUUIACgkQbDjKyiDZ
s5L8hA//aK/MVG92n7nwd4e0a09zuQvWu8abkH1rPFBnLmWR+WrAkyXNE1TuoBT4
hLLEdJB/kx7foKkgUqlN7geUWPfzF3kG+QfxA/IscZ8mulmuenN6ATb/l3xnBEwu
rtqDkgdUCZmbztL/2ta9DDhbmFRUTzhtEaBIUKTllOK9Ezj/hz+leLnMQfNq837X
vkOOb+mEEFH3PS6ve/+LvrIW5Yi8l9QoMbu7KhVfnrMSmQnIrTSV/eTf2Mpivpke
ZLQtQ7DK3xWMvpz0WvTZL6kiQjFG5Pn9oH0TCupPEbGDX7eu7msrozOTH0aegi9l
fP94RPMnmbOkJ9FxrRhSzPRut3rT8TSaJof1bC83z3YtDjRBSnp9Eek+vpWgmJzO
8qz5I0o83d9svzDAjxo5m928FmWXVZ4YdCVokj9eOzxMXCmosFwiyYDj8bPdMPAm
E5x7OnvPcGkqngqS+TSuzaX4kyut5dGE2t67cElJ8sOYKCyz1RU4f516T4CySno8
xyidqyZw8BVSTZko6eH37bn2ivZ5Qcp4LwycISaW6Dndr4/IMWqxpKs3bEpJNGwN
u+0XcRJC6vCnu2Eq4OgJ3JtuWGkuEGPye6n+Me5fWECbRt8keiVlI4fJtezoDbbd
S991ekihmMSWYXdOPaJozd2on3qyueuTDkWwRVadu7nhLaVLcqw=
=jo03
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
