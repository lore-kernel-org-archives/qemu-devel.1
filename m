Received: from eggs.gnu.org ([2001:4830:134:3::10]:51174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fp2EB-0004MU-3G
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fp2E9-0002E9-SD
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:05:03 -0400
Date: Mon, 13 Aug 2018 12:04:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180813020451.GK4079@umbus>
References: <20180810124027.10698-1-mark.cave-ayland@ilande.co.uk>
	<20180810125713.GS15372@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tBhgiDt8dP1efIIJ"
Content-Disposition: inline
In-Reply-To: <20180810125713.GS15372@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: ignore suffixes in the bootdevice
 list dependent on machine class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lersek@redhat.com, marcel.apfelbaum@gmail.com, arei.gonglei@huawei.com


--tBhgiDt8dP1efIIJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2018 at 09:57:13AM -0300, Eduardo Habkost wrote:
> On Fri, Aug 10, 2018 at 01:40:27PM +0100, Mark Cave-Ayland wrote:
> > For the older machines (such as Mac and SPARC) the DT nodes representing
> > bootdevices for disk nodes are irregular for mainly historical reasons.
> >=20
> > Since the majority of bootdevice nodes for these machines either do not=
 have a
> > separate disk node or require different (custom) names then it is much =
easier
> > for processing to just disable all suffixes for a particular machine.
> >=20
> > Introduce a new ignore_boot_device_suffixes MachineClass property to co=
ntrol
> > bootdevice suffix generation, defaulting to false in order to preserve
> > compatibility.
> >=20
> > Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> Thanks, I'm queueing this for 3.1:
>   https://github.com/ehabkost/qemu.git machine-for-3.1

Thanks.

Acked-by: David Gibson <david@gibson.dropbear.id.au>


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tBhgiDt8dP1efIIJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltw50MACgkQbDjKyiDZ
s5Kn3xAAmJbxuC0kBBez/Ene5LNFFNTVRJVM/ydIzRr6v/4UiHmeY/89vVoz6jPm
iOBj52xfqfIpGCVA/WE+5yJXcy3IcCUVSyos/lKefG+jeeHHUyyEcVKXbrB53GuH
dCMR5gTndjI2TvMHOnSRE5vsbhR9OlKzh+NRoBK9Kn6aT8iHZQg9KCJCZGLz7Wyh
dzoHaP0tDgbctkL8BNHXrl7LmAZX9aYTL1Bh7NPIXmgnGYIsMVZDrnogDdHIu3au
l7y6xLkLkdSnlvygfnvaB5TnvFuEfsbyvRoj+IaghsymavYXTge//5uKSbVM3R0U
4KX5LlGqXUrn3L+m9DHn/op/Rqu0EV7acgz7ALWW6mJ8KIZsse2fz34Jg75kh2C7
u3bQtBhM2kuzRHPE55v2fv28knPBuFlQpXP4JeclvW4kjw8Wrf2mEsj8221othLC
1Wl94/2PU3fOXDKQtTKmmqwT/F7tjLbQGZz2s4AN4Bbm120kMU8mH9X0bmQPU5gv
HsDTOMHpgcoSpYAzfPrKji0oV4PJovHImFmaVH/KR5mrKe8NcsdHgHQVH+2xYEcV
KyFdNFco3k/+DUrb/B1FyQBTJTrY+E0bGVZFH6ioVrRSGvhH1gBu/p5A82Gv9XwM
Xho92X7qgfP0AA9SsXcH7sWGdfHeGqIIpQuNcm7YpJoVl7uQ5WY=
=HCet
-----END PGP SIGNATURE-----

--tBhgiDt8dP1efIIJ--
