Received: from eggs.gnu.org ([2001:4830:134:3::10]:51829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehh7x-00062x-Uh
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehh7w-0006TE-RE
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 14:36:01 -0500
References: <20180202183731.29990-1-armbru@redhat.com>
	<20180202183731.29990-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <11be568a-8c6d-3d45-8c32-dc41ea70c352@redhat.com>
Date: Fri, 2 Feb 2018 13:35:52 -0600
MIME-Version: 1.0
In-Reply-To: <20180202183731.29990-3-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CGw1kQo0fq6QKF1oZjfwCzJcecJx55nuA"
Subject: Re: [Qemu-devel] [PATCH v7 02/15] hw/arm: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alistair.francis@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CGw1kQo0fq6QKF1oZjfwCzJcecJx55nuA
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alistair.francis@xilinx.com
Message-ID: <11be568a-8c6d-3d45-8c32-dc41ea70c352@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 02/15] hw/arm: Replace fprintf(stderr,
 "*\n" with error_report()
References: <20180202183731.29990-1-armbru@redhat.com>
 <20180202183731.29990-3-armbru@redhat.com>
In-Reply-To: <20180202183731.29990-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 12:37 PM, Markus Armbruster wrote:
> From: Alistair Francis <alistair.francis@xilinx.com>
>=20
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then=

> compiler issues where manually fixed.
>=20

>=20
> Some lines where then manually tweaked to pass checkpatch.
>=20
> The 'qemu: ' prefix was manually removed from the hw/arm/boot.c file.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: qemu-arm@nongnu.org
>=20
> Conversions that aren't followed by exit() dropped, because they might
> be inappropriate.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/hw/arm/gumstix.c
> @@ -35,6 +35,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/hw.h"
>  #include "hw/arm/pxa.h"
>  #include "net/net.h"
> @@ -62,8 +63,8 @@ static void connex_init(MachineState *machine)
> =20
>      dinfo =3D drive_get(IF_PFLASH, 0, 0);
>      if (!dinfo && !qtest_enabled()) {
> -        fprintf(stderr, "A flash image must be given with the "
> -                "'pflash' parameter\n");
> +        error_report("A flash image must be given with the "
> +                     "'pflash' parameter");
>          exit(1);
>      }
> =20
> @@ -76,7 +77,7 @@ static void connex_init(MachineState *machine)
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NU=
LL,
>                                 sector_len, connex_rom / sector_len,
>                                 2, 0, 0, 0, 0, be)) {
> -        fprintf(stderr, "qemu: Error registering flash memory.\n");
> +        error_report("Error registering flash memory.");

Do we care about consistency on trailing dots in these conversions?

At any rate, all of these are sane rewrites of existing patterns;
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--CGw1kQo0fq6QKF1oZjfwCzJcecJx55nuA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0vZgACgkQp6FrSiUn
Q2rpOwf/dUEhAAL1i9cw+bW5Uj6njN4qg9Be9hbNIdmXIV6AQLQI1DKRZrjg9It3
isRCe4kOmCtUvCRoqiQvjBI/eRJLqoS+5RtPTyumuyVqOdzOfy+m5oO4ewBIOFd/
3JNT6fvlXj1BE81lfXuBHy57NUi4QFIhKuO/9Gzl6RZ4YHe+GgmMV7cotaaAj3i3
h9BFsS8Smd0aUBQmworWnmDhFkX73d0AhBkhCJJ6PIr+f+BPLLJ1p/hcXZwmP6o3
v1uxw7/lnqCzNEyQa7lzoq9YyyKxoplN1tH3ER6YuG7ezhBJz0ZhxhfcPi4yh6Hl
oiQDgAYeT5naBjD3Nc5UpQzjoooStA==
=9lWO
-----END PGP SIGNATURE-----

--CGw1kQo0fq6QKF1oZjfwCzJcecJx55nuA--
