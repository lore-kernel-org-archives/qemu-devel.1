Received: from eggs.gnu.org ([2001:4830:134:3::10]:57943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPi-0002fw-7h
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUiPe-0001ab-0z
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 20:52:58 -0400
Date: Mon, 18 Jun 2018 10:41:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618004146.GE25461@umbus.fritz.box>
References: <20180615140448.32234-1-david@redhat.com>
	<20180615140448.32234-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
In-Reply-To: <20180615140448.32234-5-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/13] pc-dimm: remove
 pc_dimm_get_free_slot() from header
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


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 04:04:39PM +0200, David Hildenbrand wrote:
> Not used outside of pc-dimm.c and there shouldn't be other users. If
> other devices (e.g. memory devices) ever have to also use slots, then we
> will have to factor this out.
>=20
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/pc-dimm.c         | 4 +++-
>  include/hw/mem/pc-dimm.h | 2 --
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 9e0c83e415..7387963cf1 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -27,6 +27,8 @@
>  #include "sysemu/numa.h"
>  #include "trace.h"
> =20
> +static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error *=
*errp);
> +
>  void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t alig=
n,
>                    Error **errp)
>  {
> @@ -111,7 +113,7 @@ static int pc_dimm_slot2bitmap(Object *obj, void *opa=
que)
>      return 0;
>  }
> =20
> -int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp)
> +static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error *=
*errp)
>  {
>      unsigned long *bitmap;
>      int slot =3D 0;
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 860343d64f..cf71247630 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -76,8 +76,6 @@ typedef struct PCDIMMDeviceClass {
>      MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm);
>  } PCDIMMDeviceClass;
> =20
> -int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
> -
>  void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t alig=
n,
>                    Error **errp);
>  void pc_dimm_unplug(DeviceState *dev, MachineState *machine);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PPYy/fEw/8QCHSq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsm/8oACgkQbDjKyiDZ
s5J50Q/+P5p4aZfwOPTdvS44jICIcPN/ta9R4z3k0iki3wzxh7HN2vdjyKjkKfHA
Pj/vi7tH/bRlpmZPuq5F8BeL/AmUn/99cWT6jhnsUEYLfOCkvOwdPzP68UPRWjAP
Ub6qyk4HWTuBPTgAOPLlVh4tJ0oN1b+HJmaDibQ8lXcSJazJ/6odD+y7VTdWomdM
kdywgh0+a11E+VEHvASmFNdN6d7gdaxQY9lTWWN8HCXUd44RbhBsuo8xWpLXQRml
7TNYBmwJpkJMiGgrUhpiape0WtavUbMIgA1sPZ4gjQd8JuYqz6tc+ad5ourNmS2I
Y8IGBkmY8sUanyhdYO4JMC2ZjEplf3e1mxh4Hg3v1C5pL6PM6ssCIheSLmZRPIwE
MTUWCxZNlVv7OUwbrWOZf+v4C3ISM2edvUaUyycOTQprb4QgJRcX8Td01tO8ZJBu
430FVcKTEADahqWVp5gGGOxS/zLnc+pZKXvSocrE45M1dJ5i0OTyguo2O98QN82f
UQrW5/dpkCegNssddUVcXz0wc3Lfb9XmEn9+TRT9VDSbi3qBiU6R3tFa8+tdHEIi
DfW4/hozYOttN1mH/cFDcZqUQJhP9vNXF6Di250t1wYB4r5rN+Q4LFtPOspm6oe1
jN0nRpTZiWTU5e+I8W2CxNHPSa5Tx+gPn0bWSVUN2MsZUwoYP70=
=i3AY
-----END PGP SIGNATURE-----

--PPYy/fEw/8QCHSq3--
