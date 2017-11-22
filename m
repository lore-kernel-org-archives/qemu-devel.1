Received: from eggs.gnu.org ([2001:4830:134:3::10]:53550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOl-0002hE-GB
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOk-0002WN-AO
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:31 -0500
Date: Wed, 22 Nov 2017 14:46:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171122034637.GI2380@umbus.fritz.box>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-4-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline
In-Reply-To: <20171120032420.9134-4-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 03/12] e500: note possible bug with host
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 09:24:11PM -0600, Michael Davidsaver wrote:
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

I'm not sure if you're saying you think there is a hardware bug which
we're faithfully emulating, or a software bug.

> ---
>  hw/pci-host/ppce500.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
> index f2d108bc8a..0e2833bd98 100644
> --- a/hw/pci-host/ppce500.c
> +++ b/hw/pci-host/ppce500.c
> @@ -424,6 +424,9 @@ static void e500_pcihost_bridge_realize(PCIDevice *d,=
 Error **errp)
>      MemoryRegion *ccsr_mr =3D sysbus_mmio_get_region(ccsr, 0);
> =20
>      pci_config_set_class(d->config, PCI_CLASS_BRIDGE_PCI);
> +    /* BUG? identifies as PCI_HEADER_TYPE_BRIDGE but uses
> +     * standard device config read/write
> +     */
>      d->config[PCI_HEADER_TYPE] =3D
>          (d->config[PCI_HEADER_TYPE] & PCI_HEADER_TYPE_MULTI_FUNCTION) |
>          PCI_HEADER_TYPE_BRIDGE;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloU8x0ACgkQbDjKyiDZ
s5KiwA//VEwj3qfUnDG6lDS5bk3sfsSx3zzoY3wWH8TCB5CFdvPeeGiBOiZpii1L
qDKQsd1lFJhKkkCKlmFZKzG8Umqw4nysNHI0SmIb5CIId65ogyxGX5ic+scoLFRH
WZuAb/4HvH/7M/TY1opCLQSid/tcfNccfvpNgxZCRVggC43lDREjdErGIwxpVcjp
5zIWYdy8sJn5YZ2Tk0Hv/ypOQyro5DYNQ6SJubejYM7o3pZcbqbyu+V6Yhm5mKLb
2tbjWIkdE/FDno7r6AuPqV/MvAU9RFJFroZFS0Nwfh+wZM1e8cY7ltCkI+EYt5pf
7jzqkU97HtW49m+GIgLLokLqLyqivuMuHvL9Ev/RV3VPNRwOGYcKanM5wPRLDTlA
Je8PnHamenfGThXXtH4d/jg4DU+oYrVzDRaHvNGJwlH377DsKFq51hLhOQ4lpHBe
V39gwybYqhUjphFFCEngTeHMxKr1xJjEfVLxiGsmmhZShCqKNY55QCk437gXPe+x
W02cBS3fmHI7/4IhGDFa8ZEkwkZHcmwodVpzD3abN0szW8h5fb19a5wjGDIc1H4n
ef872G7I9bU8XIaigfEfF0t/QZWJaQsp6Ish14XTkXVsEhbb7fhjvaPlnKUO0yxy
WfUEIHlnZuvW6HoD7G9MZaWsN5llbAUgQZHcggXJ+nzCftXkjwg=
=Uzmr
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
