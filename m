Received: from eggs.gnu.org ([2001:4830:134:3::10]:55487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgLpT-00081Z-4U
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 20:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgLpQ-0008Gs-HK
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 20:34:51 -0500
Date: Wed, 22 Feb 2017 12:11:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170222011129.GD12577@umbus.fritz.box>
References: <1487715299-21102-1-git-send-email-kraxel@redhat.com>
	<1487715299-21102-4-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <1487715299-21102-4-git-send-email-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/9] ppc: use ppc_graphic_* defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "open list:New World" <qemu-ppc@nongnu.org>


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2017 at 11:14:53PM +0100, Gerd Hoffmann wrote:
> This switches over ppc to use the new ppc_graphic_* defines.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Of course, the idea of a per-arch, rather than per-machine, default
graphics size is nuts, but this change doesn't make it any worse than
it already is.

> ---
>  hw/ppc/mac_newworld.c |  6 +++---
>  hw/ppc/mac_oldworld.c |  6 +++---
>  hw/ppc/prep.c         | 10 +++++-----
>  hw/ppc/spapr.c        |  6 +++---
>  4 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 2bfdb64..4722277 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -482,9 +482,9 @@ static void ppc_core99_init(MachineState *machine)
>      fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ppc_boot_device);
> =20
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, ppc_graphic_width);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, ppc_graphic_height);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, ppc_graphic_depth);
> =20
>      fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_IS_KVM, kvm_enabled());
>      if (kvm_enabled()) {
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 56282c5..a79f011 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -335,9 +335,9 @@ static void ppc_heathrow_init(MachineState *machine)
>      fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_BOOT_DEVICE, ppc_boot_device);
> =20
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, ppc_graphic_width);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, ppc_graphic_height);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, ppc_graphic_depth);
> =20
>      fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_IS_KVM, kvm_enabled());
>      if (kvm_enabled()) {
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index ca7959c..82bf6b5 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -677,7 +677,7 @@ static void ppc_prep_init(MachineState *machine)
>                           initrd_base, initrd_size,
>                           /* XXX: need an option to load a NVRAM image */
>                           0,
> -                         graphic_width, graphic_height, graphic_depth);
> +                         ppc_graphic_width, ppc_graphic_height, ppc_grap=
hic_depth);
>  }
> =20
>  static void prep_machine_init(MachineClass *mc)
> @@ -861,9 +861,9 @@ static void ibm_40p_init(MachineState *machine)
>      fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
>      fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, ARCH_PREP);
> =20
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
> -    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, ppc_graphic_width);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, ppc_graphic_height);
> +    fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, ppc_graphic_depth);
> =20
>      fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_IS_KVM, kvm_enabled());
>      if (kvm_enabled()) {
> @@ -891,7 +891,7 @@ static void ibm_40p_init(MachineState *machine)
>                               initrd_base, initrd_size,
>                               /* XXX: need an option to load a NVRAM imag=
e */
>                               0,
> -                             graphic_width, graphic_height, graphic_dept=
h);
> +                             ppc_graphic_width, ppc_graphic_height, ppc_=
graphic_depth);
>      }
>  }
> =20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e465d7a..ba8f81e 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -824,9 +824,9 @@ static void spapr_dt_chosen(sPAPRMachineState *spapr,=
 void *fdt)
>      if (boot_menu) {
>          _FDT((fdt_setprop_cell(fdt, chosen, "qemu,boot-menu", boot_menu)=
));
>      }
> -    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-width", graphic_wid=
th));
> -    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-height", graphic_he=
ight));
> -    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-depth", graphic_dep=
th));
> +    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-width", ppc_graphic=
_width));
> +    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-height", ppc_graphi=
c_height));
> +    _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-depth", ppc_graphic=
_depth));
> =20
>      if (cb && bootlist) {
>          int i;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrOU+AAoJEGw4ysog2bOSGjIQAKoR9DnlHZiLhPtfIbnZi8Wu
4UqfIHwYuihZIUMgxgh76Yhf3+Aqj6d9rDBaosTbmoSMS2NGc60uMgJ0xEVkdcSR
sR/JHoO0goQ+RTFbIrlwqSgRGIT8N6h9/h8/BJo12m8RXvDAhz7tKxEX/IvJltSD
hKqWvpurMVIiICZwbsS75dRYqVHXr8EkVKfGw6OvFjJWmFZa6/ZdPX5kTk9CwKAM
dq1c+BCvVvv5AptRfsOOOoS/REq3CKT2qHb6ykMmqfgwcgTb0GvaY+7sVhsuZrRO
LwgHKN7AOrVHMZ1W1OvKijltGwkAv7pS52+R8mSOOzqFvQ6M5vY1Hj65yGMn42TP
0ef0KaM6BHThD5KfwHGRyZympCU6xSDjXHYsKQsUmq0jatyphljSGaJQjo0YZEcj
d14Aj8yN9JH5YdARshUXMJ+8kv6dn3yiCnt5agnhz+eTqq+IPvZINSU5Hdovlnmx
1k4w0vvhR8wznXGVeuC390/G2hV+puxXUYeEAPV4VZ5x6HFrmpfM7annOeQ/haBE
ryCnGmwkZw98iUXiYQZt6Ot7Hjz2ZQXy6LJPSGsABbM6PWSYO1xOh9K+QIWv6eKg
pUoPGiKFNMfApaLdM8O5ahd5l4IzW4zZt31hx32zfV6SM7OrlXH3WsnnhTsvDbeb
1i9MJdzlxp7a9bHsXKYc
=Z1Q+
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
