Received: from eggs.gnu.org ([2001:4830:134:3::10]:38225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJ91e-0002hO-DC
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 21:20:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJ91b-0001Fv-Aa
	for qemu-devel@nongnu.org; Sun, 26 Nov 2017 21:20:02 -0500
Date: Mon, 27 Nov 2017 12:52:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171127015237.GC11775@umbus.fritz.box>
References: <20171125151610.20547-1-ehabkost@redhat.com>
	<20171125151610.20547-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <20171125151610.20547-5-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/6] spapr: Allow only supported dynamic
 sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2017 at 01:16:08PM -0200, Eduardo Habkost wrote:
> TYPE_SPAPR_PCI_HOST_BRIDGE is the only dynamic sysbus device not
> rejected by ppc_spapr_reset(), so it can be the only entry on the
> allowed list.
>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Again, do you need me to take this through my tree?

> ---
> Changes series v1 -> v2:
> * New patch added to series
> ---
>  hw/ppc/spapr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 82040cc5d1..3c6d6f2cea 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3603,8 +3603,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->default_boot_order =3D "";
>      mc->default_ram_size =3D 512 * M_BYTE;
>      mc->kvm_type =3D spapr_kvm_type;
> -    /*TODO: allow only sysbus devices that really work with this machine=
 */
> -    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDG=
E);
>      mc->pci_allow_0_address =3D true;
>      mc->get_hotplug_handler =3D spapr_get_hotplug_handler;
>      hc->pre_plug =3D spapr_machine_device_pre_plug;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlobb+QACgkQbDjKyiDZ
s5ISUxAA38igwypWfzWMK17/NgLJ4zGLk4OPBO573+cRNNNz2jYE9lfHFT0ryILX
BbUHiYzaVHOg6wl79KCUjQCJ+Dk+KzSPZ2zF3nqwARXgrxcuxV+L5JOAJGnXh9EI
EDoYmd9ZQsgbnOhhSMlYj69Z4+bmlX+SypcSMGxEq8Onzd1KIw8/gCpldHPn1VWd
GJ8uky0tDTQaS4RsBQ6hCghqZWKOjxKwP37Y+23W2mBWZY9EM49+XHyCtT5hQB7K
YHH3o473Xig1SIZZMzY4OXdTJ7wfx+9R/boc1FOoE7PSsZgZ4dwuPQdgY7ej2071
lfrXzCDio5e5wvX1PBkcv8fEPCw43VYKS3LIWUcfNyh97armDYz9RYwZPwo5mEne
s5FMPGGgcK6xJk1FClwKWDyCd9++ZwezwpyPhZotkhuwLNCiJwRBuNt3hiitsl/o
OlmwH3TBIYBPfzpTm2MqVcJUmwapCrnyAtrZYpkf9/AmJFVfkdoxLDG/ta3TiPan
g98Pl5KXX15Ed56QjmAHy+9W1uCJ1Hu61OwYXKMcJoAYY6jpXueBps07T3+k/ngx
shgWzKxqc/ACEAEH6uBx8crAIhEEYFhv86h4rSKh6fgVY6SjlbutQMhjNkuNAgdd
WljTeqjwErmwNKoMb4lvQG9fze2QFcNzNvYXZwAn6AGjdnZFG/E=
=tuLY
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
