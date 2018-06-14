Received: from eggs.gnu.org ([2001:4830:134:3::10]:38660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTISU-0000Uy-3o
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTIST-0004Ug-3b
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:57:58 -0400
Date: Thu, 14 Jun 2018 11:35:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614013510.GD3042@umbus.fritz.box>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<c1ca5bce109e674d0cc7ed46bbcaa41863a6319c.1528935420.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
In-Reply-To: <c1ca5bce109e674d0cc7ed46bbcaa41863a6319c.1528935420.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3 7/9] sm501: Implement i2c part for
 reading monitor EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Again needs a commit message expanding on what this is and why it's
useful.

[snip]
>  static const VMStateDescription vmstate_sm501_sysbus =3D {
>      .name =3D TYPE_SYSBUS_SM501,
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_STRUCT(state, SM501SysBusState, 1,
>                         vmstate_sm501_state, SM501State),

Additionally, since you're changing the migration stream, you need to
point out that this is not used in any machine types which support
cross-version migration.

> @@ -1843,8 +1971,8 @@ static void sm501_reset_pci(DeviceState *dev)
> =20
>  static const VMStateDescription vmstate_sm501_pci =3D {
>      .name =3D TYPE_PCI_SM501,
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_PCI_DEVICE(parent_obj, SM501PCIState),
>          VMSTATE_STRUCT(state, SM501PCIState, 1,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlshxk4ACgkQbDjKyiDZ
s5KMYRAAiO41rEpFcYGWjbqfyHmAyVf2WpqnyqSf7TIKMj9Sy7tZNjCOSHWQ0CCs
mOBu2/g6pE6pCrUZCzK0AgRCLrEJBvD9deFsTIIRm/5fdJUXo1DBzk8Y33ZO2B3b
AKCsa9euOdLTDmwxXrx2hYKdg2K7YBBmaBwGlFsGmeivQqWRvYg7ndsVEtccjouK
m3kisCemfYQjR6JilABRukmCy+PV9R80RQECAxCrYO0D6C90YfmCyreA1plBqUP2
HS6xOQyDrYYvyr3HFhiY35fnDZ0OqhzPYwgHDgI1fvWWi+uWX/gCGFKKy6uP+k3X
U32yIqlZjhY9PC+copTB99+bQRH5oQJYBHJDQs8JOK2jo6euwGIiOlfnhKp5NbbC
u3EomU/gSCYYmXNG7fS1aj/o/sTHpg704k9zWGqFnGwX3llNMZ89z2MPTmSPXuPi
JKPKzjYPJ9hCgB319jaK0xK6KEB4WSax0alQhSoLQirh8Xzli+k4riEOQ3MsojgW
BYSvDstPkOde6WTkP/dEProvhEe6B8Mrtv68Msm5bQ3FxyMW0AfQq5Wp7GMJdvWb
2lGyvlVzdc9KPqtmqVgSVC9Zb7n7t0gWScnCBzKk7/Zlu5T/tQaU+XQk0AdD7W0j
5uqwnrY8YA9Yr/O6xWDf+NjcJoCbX31Yqru+ZKGGm2rm1kVaE0o=
=vnSl
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
