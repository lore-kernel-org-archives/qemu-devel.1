Received: from eggs.gnu.org ([2001:4830:134:3::10]:60638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6WsB-0003lP-Ko
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6WsA-0007Wv-JQ
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:37:51 -0400
Date: Fri, 5 May 2017 13:23:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170505032306.GN14413@umbus.fritz.box>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-21-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Y142/9l9nQlBiaj"
Content-Disposition: inline
In-Reply-To: <1493816238-33120-21-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 20/24] machine: call machine init from
 wrapper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--4Y142/9l9nQlBiaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2017 at 02:57:14PM +0200, Igor Mammedov wrote:
> add machine_run_board_init() wrapper that calls machine
> init for now but in follow up patches it will be used
> to run generic machine code that should run before
> machine init.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/boards.h | 1 +
>  hw/core/machine.c   | 6 ++++++
>  vl.c                | 2 +-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 1f518a1..0e74484 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -32,6 +32,7 @@ void memory_region_allocate_system_memory(MemoryRegion =
*mr, Object *owner,
>  MachineClass *find_default_machine(void);
>  extern MachineState *current_machine;
> =20
> +void machine_run_board_init(MachineState *machine);
>  bool machine_usb(MachineState *machine);
>  bool machine_kernel_irqchip_allowed(MachineState *machine);
>  bool machine_kernel_irqchip_required(MachineState *machine);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a63f17b..217b4f4 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -648,6 +648,12 @@ bool machine_mem_merge(MachineState *machine)
>      return machine->mem_merge;
>  }
> =20
> +void machine_run_board_init(MachineState *machine)
> +{
> +    MachineClass *machine_class =3D MACHINE_GET_CLASS(machine);
> +    machine_class->init(machine);
> +}
> +
>  static void machine_class_finalize(ObjectClass *klass, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(klass);
> diff --git a/vl.c b/vl.c
> index fe4741d..ac46d6e 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4562,7 +4562,7 @@ int main(int argc, char **argv, char **envp)
>      current_machine->boot_order =3D boot_order;
>      current_machine->cpu_model =3D cpu_model;
> =20
> -    machine_class->init(current_machine);
> +    machine_run_board_init(current_machine);
> =20
>      realtime_init();
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4Y142/9l9nQlBiaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZC/AaAAoJEGw4ysog2bOSv4AP/ih8nLvhqX3v0Mta1ipbgc52
91vfhfXjmSe6Uv2342PrDduQ8iJXxplHeIkNcqdmMlRwUQ+fQgDyCjolu+tH78aK
q6MXPjQ9MPTltPeOq+1jLxynWuTAZ6WTbcCFmDR4TLOWU7aAZXTEx7+Lwoo1p7im
Jeq7YXDM/7p/h9bMDVZd5ktPV4qpm+8jTeO5POURKrP2gthrDlaihWLFvZrkNdb3
Arhs6K/pte3bxW1yThNRgbbLJQo5f6NyXxQGfHNftZxmR2xK3OBFzc4xQEu3XELi
ZXxBEX5neVIr2VaqzzW6ccc+/mKkDrEXp5Zh1Cj8NgO7bVcblAqhY16Bp88BkAoR
kD2tlviUBiD8CVCh+mFHiX/JdrlRH4f34qBNipCcUfPKnatNW7VaS+cSVNNAx7ad
3KAZbA0Jx5EPk3RhLMwJyLihufYhMU8TPneDJM2Y3gM1UQajMsryPJW9s5V1Vn42
/ShK3xoDueiAXqYKHGgBCArVBeLeZ/1xIOmAb0cmM5pfxlJKwTFROs+PCTVlvM7G
bxF5L8qNNn6l+L/g/qkYw8MJ6NaE9iebpSTbdeuo9z/oyvdYf0CUJZhPeEiruW23
iQUWAqh0Gm1AtDHdd4MpzEATIPKVAoBIEK6NhGt3h1P5dyCdJykSHccNZY89Ui+P
x4nwn+NbcWtMeo3H7QBD
=nnjb
-----END PGP SIGNATURE-----

--4Y142/9l9nQlBiaj--
