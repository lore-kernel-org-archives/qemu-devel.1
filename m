Received: from eggs.gnu.org ([2001:4830:134:3::10]:56337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYPTs-0000oq-Lw
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 22:51:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cYPTp-0001X8-FO
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 22:51:44 -0500
Date: Tue, 31 Jan 2017 13:46:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170131024655.GH14879@umbus.fritz.box>
References: <1485258485-22844-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U3BNvdZEnlJXqmh+"
Content-Disposition: inline
In-Reply-To: <1485258485-22844-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc/cpu-models: Fix/remove bad CPU
 aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org


--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 12:48:05PM +0100, Thomas Huth wrote:
> There is no CPU model called "7447_v1.2" in our list, so the
> "7447" alias should point to "7447_v1.1" instead. Let's also
> remove the "codename" aliases that point to non-implemented
> CPU models - they are really of no use here.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Merged to ppc-for-2.9, thanks.

> ---
>  target/ppc/cpu-models.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
>=20
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 506dee1..4d3e635 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -1375,19 +1375,15 @@ PowerPCCPUAlias ppc_cpu_aliases[] =3D {
>      { "7445", "7445_v3.2" },
>      { "7455", "7455_v3.2" },
>      { "Apollo6", "7455" },
> -    { "7447", "7447_v1.2" },
> +    { "7447", "7447_v1.1" },
>      { "7457", "7457_v1.2" },
>      { "Apollo7", "7457" },
>      { "7447A", "7447A_v1.2" },
>      { "7457A", "7457A_v1.2" },
>      { "Apollo7PM", "7457A_v1.0" },
>  #if defined(TARGET_PPC64)
> -    { "Trident", "620" },
>      { "POWER3", "630" },
> -    { "Boxer", "POWER3" },
> -    { "Dino",  "POWER3" },
>      { "POWER3+", "631" },
> -    { "POWER5gr", "POWER5" },
>      { "POWER5+", "POWER5+_v2.1" },
>      { "POWER5gs", "POWER5+_v2.1" },
>      { "POWER7", "POWER7_v2.3" },
> @@ -1399,21 +1395,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] =3D {
>      { "970", "970_v2.2" },
>      { "970fx", "970fx_v3.1" },
>      { "970mp", "970mp_v1.1" },
> -    { "Apache", "RS64" },
> -    { "A35",    "RS64" },
> -    { "NorthStar", "RS64-II" },
> -    { "A50",       "RS64-II" },
> -    { "Pulsar", "RS64-III" },
> -    { "IceStar", "RS64-IV" },
> -    { "IStar",   "RS64-IV" },
> -    { "SStar",   "RS64-IV" },
> -#endif
> -    { "RIOS",    "POWER" },
> -    { "RSC",     "POWER" },
> -    { "RSC3308", "POWER" },
> -    { "RSC4608", "POWER" },
> -    { "RSC2", "POWER2" },
> -    { "P2SC", "POWER2" },
> +#endif
> =20
>      /* Generic PowerPCs */
>  #if defined(TARGET_PPC64)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U3BNvdZEnlJXqmh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYj/qeAAoJEGw4ysog2bOSRcQP/33q8vaNytSbtN/FFs9SkGUB
H+7SDTNgUZqKkt1nrah881/0DHJSxtjyM6TiS+KP7sTQtDjazW+GBicPkf0jSnqg
LBCyhJG9MXzCR/0dWZ0GJ5B0wfVf4kO7F48rfTjSPty11nB4GfG+BEVXkHouqUym
iYit9pEIkqL/Wgv59PDcbGwEVphQ+III8OmBsXvHw+hH5qlwOvcUcTcF8iZoQLzv
VtcSbBPlrERLUWSqxQbROgjg9xVbRN1BtcBAuatYFi9srABEu9YShujQrB7k/RUy
gFY1fvBNlMo7MY40qyG044O9h8OkX1vRP8VhkxZBNb938JdZOUT/JVOAPXCOq70j
ic7avLDIX844q7DPm2eYncN6kuWt+mRCwqxMZloBSjia+BXUfJoGs4swdIL85mQD
cGzPO80jA4ToohV+gjtvGVq/BzRb9IpR2nGeljHrfrmY8lO0pBDzA10RE/hqEkQT
cVT2sAfWA4e+NClz+dltOKQZca7DGTp9OUMPj7KyB1ZLkE+8kJ3vZCctrN83IPdt
2VunrdIUqJWV7lhhn2zzN8jOdMD6KM7jDzblWe0xCO8z8MH7NOEWfcDvYwVNtsVi
qBr6NNtgFtjtM5rtFovsJKOHBX0Gvsts9870bn2KjL5tBlN7n6U+Z6EhQsdaGY6x
mL5VOFgyUxbpm2zcqkkg
=0E/A
-----END PGP SIGNATURE-----

--U3BNvdZEnlJXqmh+--
