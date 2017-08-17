Received: from eggs.gnu.org ([2001:4830:134:3::10]:57274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diMrV-0008CD-Cq
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diMrU-00042n-7i
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 11:37:33 -0400
Date: Fri, 18 Aug 2017 01:09:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170817150905.GJ5509@umbus.fritz.box>
References: <1502979556-31791-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YrQNB5Deg1WGKZi3"
Content-Disposition: inline
In-Reply-To: <1502979556-31791-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr_iommu: Fix crash when
 removing the "spapr-tce-table" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--YrQNB5Deg1WGKZi3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2017 at 04:19:16PM +0200, Thomas Huth wrote:
> QEMU currently aborts unexpectedly when the user tries to add and
> remove a "spapr-tce-table" device:
>=20
> $ qemu-system-ppc64 -nographic -S -nodefaults -monitor stdio
> QEMU 2.9.92 monitor - type 'help' for more information
> (qemu) device_add spapr-tce-table,id=3Dx
> (qemu) device_del x
> **
> ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctr=
l)
> Aborted (core dumped)
>=20
> The device should not be accessable for the users at all, it's just
> used internally, so mark it with user_creatable =3D false.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.10.

> ---
>  hw/ppc/spapr_iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index e614621..ed2d535 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -618,6 +618,8 @@ static void spapr_tce_table_class_init(ObjectClass *k=
lass, void *data)
>      dc->init =3D spapr_tce_table_realize;
>      dc->reset =3D spapr_tce_reset;
>      dc->unrealize =3D spapr_tce_table_unrealize;
> +    /* Reason: This is just an internal device for handling the hypercal=
ls */
> +    dc->user_creatable =3D false;
> =20
>      QLIST_INIT(&spapr_tce_tables);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YrQNB5Deg1WGKZi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmVsY8ACgkQbDjKyiDZ
s5Kd/g//fRFtU/ayRpNQJVqjDzSCF4Q9GCHvQoQu/ykBSK1OwaOxK5FVVJ2jm+cj
HN0ERAxZ7OqtutO+4JsDIAHvbXienglYAZs6/E13i1WRN3EMpdt1kxFjK9gPoIY5
F4Y9NPxGGYQK7TUuENLfiSXbK2UwUWov/+byKwgNeoGPBWI6UZQpJysUhc5MRD7Z
1MMMvE/TIT6qGVhEBAFCAkPlLbgMRB5aUKO1l2UUn0uzNRhrP26uEdZYP9ifUXmI
YOGT+3/PB0s9LItZYR8BO7rghFGy8CxGvtPdxlFmvcNbL65sgOvG5nSHnrkNVpwm
FtcJ3AKJp+/+T2hE+AYJLxiKmdHjvGlAjJFA1XHPbSVB6vcCSVA4vqPUTYK0Cuai
zF3kRUIl16wOajXMzHK9uphJvYbYJuaB5udKKObTUG+FFLdkZJC/El3sV/SPhF1k
6T1WDF6UWBi3XpUzL0rOavxfzUFZv+mY9fZTi4DiYPqcE4rs1L1BoqQY3QSs8iex
xRfbdWtZep68Vvzg/WVUQFNrahKIywuu5MPpZFUZZN3g/lDePf5Wr8wFPalQW5pB
Q93vceVEh2YE9xVuu59FpSjvQNAmFopBSOlns8GLp8Qjz63eFAlvLHEpo2PlC7pT
WUs9VmiWt7BBa9IThUB8sigH6vyuSgaRPMa9hR2fcit0OHUk4Ys=
=zLLB
-----END PGP SIGNATURE-----

--YrQNB5Deg1WGKZi3--
