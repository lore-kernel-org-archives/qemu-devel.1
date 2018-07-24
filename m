Received: from eggs.gnu.org ([2001:4830:134:3::10]:46690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fhmDW-0003v5-N6
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 21:34:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fhmDS-0005tT-Mk
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 21:34:22 -0400
Date: Tue, 24 Jul 2018 11:29:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180724012948.GE6830@umbus.fritz.box>
References: <20180628083633.12413-1-clg@kaod.org>
	<20180628083633.12413-2-clg@kaod.org>
	<20180718061230.GE2102@umbus.fritz.box>
	<16c7eb37-ddd4-17aa-c5cb-ffe05cc13c15@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Content-Disposition: inline
In-Reply-To: <16c7eb37-ddd4-17aa-c5cb-ffe05cc13c15@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2018 at 11:37:06PM +0200, C=E9dric Le Goater wrote:
> On 07/18/2018 08:12 AM, David Gibson wrote:
> >> +static void pnv_phb3_get_phb_id(Object *obj, Visitor *v, const char *=
name,
> >> +                              void *opaque, Error **errp)
> >> +{
> >> +    Property *prop =3D opaque;
> >> +    uint32_t *ptr =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> >> +
> >> +    visit_type_uint32(v, name, ptr, errp);
> >> +}
> >> +
> >> +static void pnv_phb3_set_phb_id(Object *obj, Visitor *v, const char *=
name,
> >> +                              void *opaque, Error **errp)
> >> +{
> >> +    PnvPHB3 *phb =3D PNV_PHB3(obj);
> >> +    uint32_t phb_id;
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    visit_type_uint32(v, name, &phb_id, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * Limit to a maximum of 6 PHBs per chip
> >> +     */
> >> +    if (phb_id >=3D PNV8_CHIP_PHB3_MAX) {
> >> +        error_setg(errp, "invalid PHB index: '%d'", phb_id);
> >> +        return;
> >> +    }
> >> +
> >> +    phb->phb_id =3D phb_id;
> >> +}
> >> +
> >> +static const PropertyInfo pnv_phb3_phb_id_propinfo =3D {
> >> +    .name =3D "irq",
> >> +    .get =3D pnv_phb3_get_phb_id,
> >> +    .set =3D pnv_phb3_set_phb_id,
> >> +};
> > Can't you use a static DeviceProps style property for this, which is a
> > bit simpler?
>=20
> yes but we will need these ops for user creatable devices. This is where
> we will check the chip id.

Why?  Can't we check that during realize()?  That's a common pattern
for static properties.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltWgQkACgkQbDjKyiDZ
s5KPzRAAhWSTict/GE3eJMrkvMVVuf03Bo5QoTpK1Q6yoSNs7z9Ju3iXTN9NibH0
2K9qGFr+3bqJe1IS0NwcPAl3tqCrmvm3hMk96PGVr64vM/6KRdgpOb1Run1C2aDz
cpc8L2lZ17BZmV0HAI2HXaYgj5Btkl3Ge69p7H/qBY48LilOE/AsF30RHDhe/Ld/
zdhUJIpp5vQc4KoDhLSk1RP+cl/Jf5/CYt4et9fWC1BpK48L2i9g8/Ji9cINe3iA
imsIXS0s7KEVKObOl7a+S78d54R7RfQ5R/QHhAOUqz5p1ryheiyeIiTTedpM7zTe
5fuo+/hhlHbWA6uOjBAnm6IxQb65ddFp/xbpY7G+4B0ulGgF4T08TXubODKY92NK
WfMkR2PsEHSPD7sjM8H6VrUMEpXDhn/sgiKbxYwgF0HvhntJVp2aIGEhSy9ykecN
KaGcaiJ1nbimL/hP+B1re94qFa5PACN/HHWdB63SGjIygdvsduYWGeYYKZvNNkSA
/ajmrDY00Ra3tThr8/QEoTXAxV0l5eTkOftYycidjl0lokGvRCSvt4wAJ7IapYG0
nJuGQWSxUlmZqbnwr6bbZJFuMrdLS9UGkXgodiSM1MLzJ6m8DrSNErOLB2dXSPN7
+MSff3CABE1worWy+MtJNlhMQmNklhmDRp7BSGAa01qhvhECobM=
=jpmY
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--
