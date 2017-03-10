Received: from eggs.gnu.org ([2001:4830:134:3::10]:50171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cm97l-0006FE-OL
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 20:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cm97h-0003rk-HK
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 20:13:41 -0500
Date: Fri, 10 Mar 2017 12:00:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170310010038.GV19967@umbus.fritz.box>
References: <1489084673-31595-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6h64vBu9tReNbGLX"
Content-Disposition: inline
In-Reply-To: <1489084673-31595-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/pnv: Classify the "PowerNV Chip"
 devices as CPU devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--6h64vBu9tReNbGLX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2017 at 07:37:53PM +0100, Thomas Huth wrote:
> The devices that are derived from TYPE_PNV_CHIP currently show up
> as "uncategorized" devices in the help text of "-device ?". Since
> they obviously are related to the CPU, let's put them into the
> CPU category instead.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.10.

> ---
>  hw/ppc/pnv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 09f0d22..b97055c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -722,6 +722,7 @@ static void pnv_chip_class_init(ObjectClass *klass, v=
oid *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> +    set_bit(DEVICE_CATEGORY_CPU, dc->categories);
>      dc->realize =3D pnv_chip_realize;
>      dc->props =3D pnv_chip_properties;
>      dc->desc =3D "PowerNV Chip";

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6h64vBu9tReNbGLX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwfqzAAoJEGw4ysog2bOSXeEP/0t8Pq56hDsY4tuXB5CrqlXe
qaWwErYlWtEktIzuxZzmbSWYjB9xffSr9ica+SddCwIIYRzgb4pTwkk6OX7pTGj5
ps33NPKKWVyHdI78hnMcvKDtJIsQ7elV1kUZnMSVZbGq1QsGsnyOwpCpIH/KL7N7
GWbW6oivzeTJ1M/R5kEb6J3XKoyL7TG2F+yjClh30wPb5ca7qiDaZ40D4WhzGSzl
60vOcXTbkaLxWasdBnYjkQ8tN7JMXb0F/d1ad6PtaaL94I+8kohokC8Llc7maNU2
ijrI35pz6dwutFj61L466f7pes6De5Nko8RfZbyh8KytNj3RVQoIH3CBlULAJaLl
TTBHFR/CMd/sWSqPXLVTsmlHGEgRPR5Wi23JtafOeIwT2htrVw6tdm97K0ikq7T0
+qn46BrWf+5u1fpq3Y22DbcCE6H4gSPtD8SCyeYqRfofVkx0/xMVjc+EUK8HLWDS
0awEugzv2srp2jK6fSPp/FKaat299VyRYsMbk71BxBZUSv6bP10P2+zqc9TpF21/
iawSzvpVPUY2nlIDbP+rCMbD+XNbcVVcQRKPp3X3yZS8fAG3dhjrAuiCAq6btcye
kqUmvKUnQpLBhxWD6cZMqHUB2mbewvbVTclnwFXC6vifwoJlCn0APvUbXNbyaKhy
bXJGkwQzI+V4OUnvB1Cm
=mSOD
-----END PGP SIGNATURE-----

--6h64vBu9tReNbGLX--
