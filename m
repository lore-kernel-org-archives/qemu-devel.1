Received: from eggs.gnu.org ([2001:4830:134:3::10]:40279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OPF-0004Vs-N1
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0OPE-0008Dq-TP
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:54:53 -0400
Date: Fri, 6 Oct 2017 19:42:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006084235.GZ3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-22-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GjiSaFH9IIUbbImY"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-22-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 21/23] ppc: pnv: define core types
 statically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--GjiSaFH9IIUbbImY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:48PM +0200, Igor Mammedov wrote:
> pnv core type definition doesn't have any fields that
> require it to be defined at runtime. So replace code
> that fills in TypeInfo at runtime with static TypeInfo
> array that does the same at complie time.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GjiSaFH9IIUbbImY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXQfoACgkQbDjKyiDZ
s5JasQ/8CpEjL6kdKTLWsWD1Oh5lz6vKE628wBTllCgJbl0tYtDFYtwSMpV/1GhL
GngGxErbmUhJ/yurdGKR7U8DOLwffHLnoZkrd2QP4Ga9pUsbdU9ha4LeSZFRjud7
n4MDnCBpyrJSAIf2BOttXjnFZVmsfV7W+SYd2PV27I+htamq/O7pjuple25IwPG1
ROaK4prNt6YGVslHPvbl7hye/AjnWhydU9zorXh7nIomg5ilT++zh7f6v+jPY+k6
uB2V0wqik4L4+isH19pA1Ww0w88HsGZM6hOBHiLdv0d4Mch2M2JBa2FpDJFIgisf
S/6fYLRIY+b3QBHbjoqtRhpVTfc06ckVJB9e/mlTI9iKnzVSTkuKqYNpkVBoG0Np
MtOM1Md9t/F0ZBXFmj74pyg1E7/GgFgH8fmQTyb9QgGN5hlWD0N3hO/d/7DVi6A5
NEgeODa8wcOg+hmYv4bVudUZe5tgnEzaE41x1wKzTy/rhfBk2NGLl8abRChtliQG
B2ePR4sLsHN4J8vCJtDwE/Nv5258fekFtMlLTcmaffftptzdMyq0tVbyYD7Wg9rE
ZxCxVbV9OWRiE2eislsDv9GOfhhailMdC6I47X0cmzZu3SWFxXrDvYqnrFvhOJZT
mSUR1vAD2m78UL/yq8WKfFlnP8pIDpOhZhJLhqBBTFrrSgFnH8A=
=UxZw
-----END PGP SIGNATURE-----

--GjiSaFH9IIUbbImY--
