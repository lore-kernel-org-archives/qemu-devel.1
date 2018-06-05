Received: from eggs.gnu.org ([2001:4830:134:3::10]:50540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ0Tb-0002u4-7P
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ0TX-0001wN-6n
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:09:31 -0400
Date: Tue, 5 Jun 2018 11:09:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180605010914.GG5140@umbus.fritz.box>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Content-Disposition: inline
In-Reply-To: <20180517081527.14410-8-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 07/14] spapr: route all memory devices
 through the machine hotplug handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>


--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 10:15:20AM +0200, David Hildenbrand wrote:
> Necessary to hotplug them cleanly later.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

As for PC, I think it would be nicer to drop the explicit check
against PC_DIMM, since it is covered by MEMORY_DEVICE.

> ---
>  hw/ppc/spapr.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b7c5c95f7a..2f315f963b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3666,6 +3666,7 @@ static HotplugHandler *spapr_get_hotplug_handler(Ma=
chineState *machine,
>                                                   DeviceState *dev)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_MEMORY_DEVICE) ||
>          object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
>          return HOTPLUG_HANDLER(machine);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsV4roACgkQbDjKyiDZ
s5LdLBAAh0soJi69gk3ht2WsoXCIE127tOl1alKuOj96Sb9t9RCDEKcM9hyNqMr1
03T4CcbruNhsv6h5FroJ+wV93D1MP+5CaeiaEY0KM2hV0LPMK8VhqwYJEJQOwvU0
yNDa0iP0idGX0XPEN0LaqY48OXsbDz64tctJ7cck0Kz1qcMtmqVO50E0Bn4Y8TmM
hS+kp1794PFqUjOqGqofss0ZJpXLcq7/nIoWsTdHiBnXqAxqtrrCeE1oLcdNlS8P
jS3v5FRjOX2tPuhVTBweQtYh4VZpDPLnw6VP2+x1cdYrd5KfueumlzaiuK7A9/Q3
0vCFLO79MZ1SAQylfSF9eFJK1LeDXM2N1zNa+2jn5bgm+V6xmFlItQqsN1+J2gTG
azbZ5oZfr97Yqb7LnAOgw+kwadMF4rLji9auxTSu6eogo6Wb4VuQtuhqCzoKlcYv
lNFrYjGyK5TWZWWo/sJIhHk636cOozFWr6FJbySn6BjzoD8Iz91HGQlSM84IURYg
/dDPe10/C96IN8ghlDXZSfIvKcPTBPf9e0Vq31wzpT+zS5iRWFXDutJ9kc739CT8
UdSm9cK/WtNpHIO1m5r5eKIDI6s09er/ZGnKuoR8dWFUT0R/Azrm1qtNscj7dM8M
KeVkG8sPu6zf3o+uDBGmciUNJdvAhpTfaOSNXteFBngtzdSgAEw=
=r8yd
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--
