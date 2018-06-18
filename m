Received: from eggs.gnu.org ([2001:4830:134:3::10]:57944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPi-0002fy-7v
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPe-0001ai-1I
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:52:58 -0400
Date: Mon, 18 Jun 2018 10:39:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618003902.GC25461@umbus.fritz.box>
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <20180615140448.32234-3-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 02/13] pc: rename
 pc_dimm_(plug|unplug|...)* into pc_memory_(plug|unplug|...)*
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


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 04:04:37PM +0200, David Hildenbrand wrote:
> Use a similar naming scheme as spapr. This way, we can go ahead and
> rename e.g. pc_dimm_memory_plug to pc_dimm_plug, which avoids
> confusion.
>=20
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/pc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 622e49d6bc..f9250ffae7 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1674,8 +1674,8 @@ void ioapic_init_gsi(GSIState *gsi_state, const cha=
r *parent_name)
>      }
>  }
> =20
> -static void pc_dimm_plug(HotplugHandler *hotplug_dev,
> -                         DeviceState *dev, Error **errp)
> +static void pc_memory_plug(HotplugHandler *hotplug_dev,
> +                           DeviceState *dev, Error **errp)
>  {
>      HotplugHandlerClass *hhc;
>      Error *local_err =3D NULL;
> @@ -1728,8 +1728,8 @@ out:
>      error_propagate(errp, local_err);
>  }
> =20
> -static void pc_dimm_unplug_request(HotplugHandler *hotplug_dev,
> -                                   DeviceState *dev, Error **errp)
> +static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
> +                                     DeviceState *dev, Error **errp)
>  {
>      HotplugHandlerClass *hhc;
>      Error *local_err =3D NULL;
> @@ -1759,8 +1759,8 @@ out:
>      error_propagate(errp, local_err);
>  }
> =20
> -static void pc_dimm_unplug(HotplugHandler *hotplug_dev,
> -                           DeviceState *dev, Error **errp)
> +static void pc_memory_unplug(HotplugHandler *hotplug_dev,
> +                             DeviceState *dev, Error **errp)
>  {
>      PCMachineState *pcms =3D PC_MACHINE(hotplug_dev);
>      HotplugHandlerClass *hhc;
> @@ -2015,7 +2015,7 @@ static void pc_machine_device_plug_cb(HotplugHandle=
r *hotplug_dev,
>                                        DeviceState *dev, Error **errp)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        pc_dimm_plug(hotplug_dev, dev, errp);
> +        pc_memory_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_plug(hotplug_dev, dev, errp);
>      }
> @@ -2025,7 +2025,7 @@ static void pc_machine_device_unplug_request_cb(Hot=
plugHandler *hotplug_dev,
>                                                  DeviceState *dev, Error =
**errp)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        pc_dimm_unplug_request(hotplug_dev, dev, errp);
> +        pc_memory_unplug_request(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
>      } else {
> @@ -2038,7 +2038,7 @@ static void pc_machine_device_unplug_cb(HotplugHand=
ler *hotplug_dev,
>                                          DeviceState *dev, Error **errp)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        pc_dimm_unplug(hotplug_dev, dev, errp);
> +        pc_memory_unplug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_unplug_cb(hotplug_dev, dev, errp);
>      } else {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsm/yUACgkQbDjKyiDZ
s5J5Dw//ZBDUKYufpz8nAF9ecSfmwO440Nginqn+j+JK6POfhzj205/hhXmdvFpW
G6K8ko/tc6vgQaOloAArJE+oaq/zw9qA8didHsbxwxXeeSZKqjjHKPIuXXzCvRE3
l7EQjrj0qGZdsB3N3c9+O58xWofR6RIzhZeo9ufSEhAZbMvXpUl6Ew2e4goIUlLn
DUo+ijByClB/pooU+t4vDLj+DwrvCCoI1pDoxCpgTqLRo0Os+tF1O89NHsBnwdiS
BXQQ4F6dNvBs+6RwV2NC/C9t6n8JGoBPLfc2WHBbAe4DXJlevfmHmyIUgIQr0/yR
qwNLTsngeaGK8GCHGLy+ANJ+9dsoXqtu4HilZZASy7KbvrY2XmbYQnM/4TzIEtlW
l9sfoXsJ3xLxZFIwPLrDPGGacprPdS+pPdXTD2bfOKFEA2zJqngc2CQHZXPgNTMI
SwM9DYckx1zPpLQ4BVfB0dKlfieviCd3f2o0fejZxgOqIloelPl/XuWXEgVEA1DW
+K/7lBBNFitwZzqaYvONTFbFUKwx/v2eMNKxKJfIbaA7soPaCgA7tuZA64KLCL6O
U1jiMvrkcukRLMvI7dsKfJHqenwnQ9qPT9s96NnWSWoeQyk1XcbmsxvIb3DFzZ6Z
rjFyHn7k31EEU9aFC+ah4yfpY8NgDkhM3SmXnW7KOT9qLIyrTsY=
=gTjd
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
