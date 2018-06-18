Received: from eggs.gnu.org ([2001:4830:134:3::10]:57913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPf-0002fU-AA
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPe-0001ax-2p
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:52:55 -0400
Date: Mon, 18 Jun 2018 10:39:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618003937.GD25461@umbus.fritz.box>
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <20180615140448.32234-4-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/13] pc-dimm: rename pc_dimm_memory_*
 to pc_dimm_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 04:04:38PM +0200, David Hildenbrand wrote:
> Let's rename it to make it look more consistent.
>=20
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/pc.c             | 4 ++--
>  hw/mem/pc-dimm.c         | 6 +++---
>  hw/ppc/spapr.c           | 6 +++---
>  include/hw/mem/pc-dimm.h | 6 +++---
>  4 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f9250ffae7..f23133facc 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1713,7 +1713,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_=
dev,
>          goto out;
>      }
> =20
> -    pc_dimm_memory_plug(dev, MACHINE(pcms), align, &local_err);
> +    pc_dimm_plug(dev, MACHINE(pcms), align, &local_err);
>      if (local_err) {
>          goto out;
>      }
> @@ -1773,7 +1773,7 @@ static void pc_memory_unplug(HotplugHandler *hotplu=
g_dev,
>          goto out;
>      }
> =20
> -    pc_dimm_memory_unplug(dev, MACHINE(pcms));
> +    pc_dimm_unplug(dev, MACHINE(pcms));
>      object_unparent(OBJECT(dev));
> =20
>   out:
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 62b34a992e..9e0c83e415 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -27,8 +27,8 @@
>  #include "sysemu/numa.h"
>  #include "trace.h"
> =20
> -void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
> -                         uint64_t align, Error **errp)
> +void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t alig=
n,
> +                  Error **errp)
>  {
>      int slot;
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
> @@ -84,7 +84,7 @@ out:
>      error_propagate(errp, local_err);
>  }
> =20
> -void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine)
> +void pc_dimm_unplug(DeviceState *dev, MachineState *machine)
>  {
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f59999daac..3e5320020f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3153,7 +3153,7 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
>      align =3D memory_region_get_alignment(mr);
>      size =3D memory_region_size(mr);
> =20
> -    pc_dimm_memory_plug(dev, MACHINE(ms), align, &local_err);
> +    pc_dimm_plug(dev, MACHINE(ms), align, &local_err);
>      if (local_err) {
>          goto out;
>      }
> @@ -3176,7 +3176,7 @@ static void spapr_memory_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
>      return;
> =20
>  out_unplug:
> -    pc_dimm_memory_unplug(dev, MACHINE(ms));
> +    pc_dimm_unplug(dev, MACHINE(ms));
>  out:
>      error_propagate(errp, local_err);
>  }
> @@ -3328,7 +3328,7 @@ static void spapr_memory_unplug(HotplugHandler *hot=
plug_dev, DeviceState *dev)
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
>      sPAPRDIMMState *ds =3D spapr_pending_dimm_unplugs_find(spapr, PC_DIM=
M(dev));
> =20
> -    pc_dimm_memory_unplug(dev, MACHINE(hotplug_dev));
> +    pc_dimm_unplug(dev, MACHINE(hotplug_dev));
>      object_unparent(OBJECT(dev));
>      spapr_pending_dimm_unplugs_remove(spapr, ds);
>  }
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 627c8601d9..860343d64f 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -78,7 +78,7 @@ typedef struct PCDIMMDeviceClass {
> =20
>  int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
> =20
> -void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
> -                         uint64_t align, Error **errp);
> -void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine);
> +void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t alig=
n,
> +                  Error **errp);
> +void pc_dimm_unplug(DeviceState *dev, MachineState *machine);
>  #endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsm/0gACgkQbDjKyiDZ
s5JDpw/+JCykr9odvxabugIyZmQoGCvq2u6okpa6uKR8KYNFPwnOkuCatW6nBxcr
jS+WDyDtPCVlIsl35evUifziuq03ZxbrFOedYw3aURFaxly16cnyjnupho+sFJAb
oGOTX9mvZVfZsj4j3cYYzic8mWf0zF254S2uRWOHvS9BfAtxNMmulhJIHXl4EVby
Nt/CLVNFzVx/SbEXeXSOtAlDIbwWCAEWHF0vn6ok1VyBHG/o0wQcNxr8CGUhxhij
kCfa3pIH64K0gqR52QIhDa4GLrNTmKRyaBeqvpCQpuFn68NSZc/jubmxm6n9ZN6f
37bYY02L1KdG45s4Gxf7r7FsaJTKig7XUn/jxOdZA2q3eAxlNvFgWiFCcTKFU2Ii
67+0ky1MpGU18gUhW0p+f4laq7JA514xWf/k+b4UNKowkHX8OgBe5u4bcr148KDY
AIRCp70+MtTBRrfxC49QatsxfQKb3p7dm65pajOLrjLzWD3Sxv1b01KRWgtocSyx
926a/iN4bUPIAjvOTfDe5+nj8+TRUd13PXR+55O3a4BOJC7iMf+93BPNdbYUGagE
TleniX1PpSehTumx+yhZAZUYNASX/RxS129Qky6KVcIFC8YPk2pjFqWtkKwQXBER
Fta1IphO+6tW8HIUkMz0Dtv6Nw7eMTOmneyN8I6+H5FCwjRFzQI=
=Gk59
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
