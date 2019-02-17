Received: from eggs.gnu.org ([209.51.188.92]:52483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi7-0008Am-0p
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi5-0005aG-TP
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:02 -0500
Date: Mon, 18 Feb 2019 10:37:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190217233711.GF2765@umbus.fritz.box>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023081228.1011724.12474992370439652538.stgit@bahia.lan>
	<4690ad87-f634-4f3b-a39c-ee61bfc64e75@kaod.org>
	<20190215141824.3549d285@bahia.lan>
	<2237cc20-ffcd-4a9b-944a-392520127432@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f61P+fpdnY2FZS1u"
Content-Disposition: inline
In-Reply-To: <2237cc20-ffcd-4a9b-944a-392520127432@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 05/10] xics: Drop the KVM ICP class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--f61P+fpdnY2FZS1u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 02:35:03PM +0100, C=E9dric Le Goater wrote:
> On 2/15/19 2:18 PM, Greg Kurz wrote:
> > On Fri, 15 Feb 2019 13:55:53 +0100
> > C=E9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >> On 2/15/19 12:40 PM, Greg Kurz wrote:
> >>> The KVM ICP class isn't used anymore. Drop it. =20
> >>
> >> Isn't migration complaining ?  If not,
> >>
> >=20
> > Hm.. no, but why would migration complain ?
>=20
> You are changing the type name of the object being transferred:
>=20
> "icp-kcm" -> "icp"

It's a little more complex than that.  The way migration works, the
state associated with the base class is transferred under the name
"icp" and the state associated with the derived class is transferred
under the name "icp-kvm".

> Isn't that an issue ?

It would be.. except that there is no extra state in the derived
class, which is why we got away with this not-very-good solution at
all in the first place.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--f61P+fpdnY2FZS1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp8CcACgkQbDjKyiDZ
s5JYZRAAtdkuIxdD8j6AFr1UMFwZJ5qv8CHRDKgnbvm//EIsykBVBSEzsmeJWxQA
CVY4brEnXj/xd/2ZuGoLajWzB4WCLpXmVRVCNELta0l9Q2dbT++OjA002Vq7a3O1
4E2QRXmB3zeb9hKuoJgrNee1ghf8vnhWnKa2Y1iJe4G6H82SdusRxBwzkFZ8+gBd
Oqpk+1TP+Ik4rUeYDbEEMb83d0LD4/8dMQasOdFXbj0WA6m8GJy622nNRXvKH3Mw
BdTkdWfX5mDok7RzdC2M9ILOpF2CiAs+FVPcerjEtbGj9zxoTkhtWa1OY6l+Az/k
HaXbvw0Zg6He5N61TEeTmjZKNbPqy0/TYIA7u61j2AF6sGc7Efuc8V0qMhPtqw36
udBSYYoC3XtpBTNEPbnqvJK1OSyftcI2mHF1eu9wAAiSExy58Zgim4os68PxxWHv
EiUxdzh8TK+yQp0J6vRyT7MylINVSs9z8G8E4CZZgQxGB/mShzaQyhCOyAu8UlVG
y+o43VT4YLdjU0xgHv2mBOzMk1RrlXzjz5VYK7EcsTzSKHW3XK+EglD1fcWADLFA
68bHKl6fnHEBGylutQh06hG70v6s06WZ6nqO9Njt7MjmKX+6XrlJX3MgTLEFoY5d
YoelM3+mLOZZ0K3cm44MMmrXXm4Yxi+oCesQ1Rd0jXqBEesAXUE=
=8Rae
-----END PGP SIGNATURE-----

--f61P+fpdnY2FZS1u--
