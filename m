Received: from eggs.gnu.org ([2001:4830:134:3::10]:40231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYOr-0002lE-Sn
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYOq-0002NW-SJ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:47:09 -0400
Date: Tue, 12 Jun 2018 11:08:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612010857.GO2737@umbus.fritz.box>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XVTPT6MZt3zd/C+/"
Content-Disposition: inline
In-Reply-To: <20180611121655.19616-7-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 06/11] pc-dimm: don't allow to access
 "size" before the device was realized
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


--XVTPT6MZt3zd/C+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 02:16:50PM +0200, David Hildenbrand wrote:
> "size" should not be queried before the device was realized. Let' make
> that explicit.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/mem/pc-dimm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 86fbcf2d0c..5294734529 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -166,6 +166,12 @@ static void pc_dimm_get_size(Object *obj, Visitor *v=
, const char *name,
>      PCDIMMDevice *dimm =3D PC_DIMM(obj);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(obj);
> =20
> +    if (!DEVICE(obj)->realized) {
> +        error_setg(errp, "Property \"%s\" not accessible before realized=
",
> +                   name);
> +        return;
> +    }
> +
>      mr =3D ddc->get_memory_region(dimm, errp);
>      if (!mr) {
>          return;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XVTPT6MZt3zd/C+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfHSgACgkQbDjKyiDZ
s5J8Yg//bjvEfmY4TpJiAty0hZ98Zsf8CTjbjgNQ6UwiS3sjjq9h42auptw50LfE
5pzFGJrIeOwZQnt7yYLosU+QMelGTx/SUJdBPTh/8WwZc578MPQQSZGDiDsVeL+t
sL6FNRE9aDUouBfj88CPb4zkFFHEr0QIENIoI54kpP+oUgMek1TpIV2m1xCPtyGD
ChFPM6BXk6vZUJ3X6r9u+V0g8aFZjO3RluWc5LvRk5rlXLUjEE95DEclk4SAOKpO
OdmG0+5vJ6s/1aZN2IDmef+Mmzo+oOmvdm11oMdDJ6g0SGknOl50c3vEvL2Ei4uV
D6CxzM1afNoMc84J0JsoAat2y4WoomQYBS2O0odC/pgeOOVWeBQlmx4rLWtFsk7L
1in5EKvEXW20nN2nvTckV54YoV5norZ4EaNUqWShZo79vROZBYolHl1IFLsD7MW9
Utj6E1h5fLZnN8z6KX9UboncZlECiumhVEgmjiKGQTPM+69Whqa5o0IspLGa8Kjy
35SlcTNpIbIOqMgayvK9Ze4qJ/nzzoGZ7v79Uq+9F1oGq+cChlZSyuQGUO9SOGiQ
X0IOBp1Wx7YYBX3KqfA1q21mvTuil79thBy8LhbRE8ahDDNbygQ9Kd0pK6KNjQu1
Q0aH9ZcQRQsXMilWfBkpU0DAuDdOO/89fLtexNCRKWs+r346w94=
=KbWB
-----END PGP SIGNATURE-----

--XVTPT6MZt3zd/C+/--
