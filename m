Received: from eggs.gnu.org ([209.51.188.92]:46014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqSDf-0000bF-Ps
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 19:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqSDX-0000bd-3u
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 19:34:35 -0500
Date: Mon, 4 Feb 2019 10:50:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190203235020.GA2593@umbus.fritz.box>
References: <1548855399-31273-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <1548855399-31273-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Add support for "-vga cirrus"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 02:36:39PM +0100, Thomas Huth wrote:
> The cirrus VGA card has been enabled in the PPC builds with
> commit 29f9cef39eb1ae55e82c ("ppc: Include vga cirrus card into
> the compiling process") last year. It also works on the pseries
> machine, even SLOF contains support for this card, so we can
> also support this for the "-vga" parameter here.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-4.0.

> ---
>  hw/ppc/spapr.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 71fe552..2323974 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1717,6 +1717,7 @@ static bool spapr_vga_init(PCIBus *pci_bus, Error *=
*errp)
>          return true;
>      case VGA_STD:
>      case VGA_VIRTIO:
> +    case VGA_CIRRUS:
>          return pci_vga_init(pci_bus) !=3D NULL;
>      default:
>          error_setg(errp,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXfjcACgkQbDjKyiDZ
s5ITEw//fLkwEcsp/tMlbUEEFaDek1l+vMmm1BoLC7+ktPimhZZ3jkKdwIwfw/Oo
UNk24zVHG+I7OMnxhdwEH/6k3xwvFlpG1SPmcwRgW48M1e7LmwvPc0IQIlyb+9Gb
O6JERZvV0++P1JoHcc9LedPEBiIG4s76QJGcycUHghiX8rna1pN7nqHyjgNV9bIE
vt8xhiAh1nVFlJdSvn7bzIRRYzwQUZpRmNF8n/N5+WrCS/qmi2Q8Z7ERDxjxvHgr
dIc8AkBFD/+jkFZWq2SYO/w67XKBKiv+KcRWNB7cm6+ag51jleLdFApS2iQXliCZ
xfaIFp8r4mCjK/miyISa6H8J2rW/plW038s6/zg05Wf0r5GIECMHNRSlavn3UEK4
Rby8W8RvFQqGHtpUHLsNbFK642dJrtNyww2Gr+SD+9ZUw55ugdjKQdNDNqKTv8Ln
xI9gntQBT8La7obppMzHmmWDG1Kh4vMRzV1mgjpPRPvNesIBK9mCMN4Sjs7n5htm
o5yhHlzs/tj8Sj/MM7q6+YdJVHja/BqanVUG1C5u0aihCoJSsnyLrjqMnM1xSBWO
j6vDDbE3i+FHvcP6/swRQGrNVQsOWMCKSCtSuujaZZD5SXWuB9arYmHoLXkS0mXJ
oraY4Fat6/HjYG3+pNzcB0HpJXM7UqaM7vlUaSymeArboiFIBZA=
=bWq4
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
