Received: from eggs.gnu.org ([209.51.188.92]:42073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240E-0006Bw-Ih
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h240C-0000to-C8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:08:46 -0500
Date: Fri, 8 Mar 2019 11:14:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308001443.GG7722@umbus.fritz.box>
References: <20190307052137.2780-1-david@gibson.dropbear.id.au>
	<ad194b40-507d-5de1-dc1c-23adb046fac7@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r4jNezHNW2wfBox+"
Content-Disposition: inline
In-Reply-To: <ad194b40-507d-5de1-dc1c-23adb046fac7@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH] spapr: Use CamelCase properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: clg@kaod.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--r4jNezHNW2wfBox+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 04:38:28PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 07/03/2019 16:21, David Gibson wrote:
> > The qemu coding standard is to use CamelCase for type and structure nam=
es,
> > and the pseries code follows that... sort of.  There are quite a lot of
> > places where we bend the rules in order to preserve the capitalization =
of
> > internal acronyms like "PHB", "TCE", "DIMM" and most commonly "sPAPR".
> >=20
> > That was a bad idea - it frequently leads to names ending up with hard =
to
> > read clusters of capital letters, and means they don't catch the eye as
> > type identifiers, which is kind of the point of the CamelCase conventio=
n in
> > the first place.
> >=20
> > In short, keeping type identifiers look like CamelCase is more important
> > than preserving standard capitalization of internal "words".  So, this
> > patch renames a heap of spapr internal type names to a more standard
> > CamelCase.
> >=20
> > In addition to case changes, we also make some other identifier renames:
> >   VIOsPAPR* -> SpaprVio*
> >     The reverse word ordering was only ever used to mitigate the capital
> >     cluster, so revert to the natural ordering.
> >   VIOsPAPRVTYDevice -> SpaprVioVty
> >   VIOsPAPRVLANDevice -> SpaprVioVlan
> >     Brevity, since the "Device" didn't add useful information
> >   sPAPRDRConnector -> SpaprDrc
> >   sPAPRDRConnectorClass -> SpaprDrcClass
> >     Brevity, and makes it clearer this is the same thing as a "DRC"
> >     mentioned in many other places in the code
> >=20
> > This is 100% a mechanical search-and-replace patch. It will, however,
> > conflict with essentially any and all outstanding patches touching the
> > spapr code.
>=20
>=20
> so it would be nice to have the script to fix those outstanding patches
> before reposting.

Sorry, I don't have a script for this.

The patch is equivalent to a scripted replacement, but I didn't
actually make it with a script - I built it up interactively using the
"regexxer" tool.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r4jNezHNW2wfBox+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBs/MACgkQbDjKyiDZ
s5Ki0A//d9338mmYVaj2QDv5iStaAc/rrhvuXlkksTOxwpLiJ6Xl0RIfBBjWeeiy
3VhjF+a1y/vkJxFitPA6XQuBnxsAo1Is8lhWSdYhceLYFhwne1GqEHHhnlqqHB7q
Zl8YIm0ulN70xe5kh4xkjzrWQDWST41dZ7+JygVXAW9RyGkn6bEfNEMDyYLX9jpM
3jOYzpE8mc+xqIgPorCuqXMJriPtERi96NddQDcwjRB+se29wtsvYtB9tKvbeIrW
xnuYuZJU8TMa/6umku8TQ01L+NMuyxODNTk7QdM3Pvq9dsmWD9wSPUELnaj6f+lN
GAlqmisXZS79j0ocE3dWSi4mjVBCp2XTOmBsCcEmPjMr2m4+Be6YcvajiRhH0RNU
PnJKOc0gN6jNRJu2oBKvKraxZoFQbz6mfU1NrNH8RVjyNxSDjTmXOqc3k91R9GAS
i7hnTwxoX8IVpDozCbW6UUMGKnYdrAHG5d5VjTdKOJvD7gGeQr86NfEImD7Agjym
kEF6pTbPloo4rR/EhBMtowwbe/x+o6YF2zze3o8Y8B2q/sVrU61/HSsUPQwuEvAF
3SyVdWE4gKwAwptc60Eesy8yuh+Dt8fI48f7PynpgpWPrzKoGubPbITPD4cZeRrs
z7Qphm8vH+2c0Z99IbRuLOWuFgjsNssAHX8hKNOUUdqPnkbYKZI=
=Nzca
-----END PGP SIGNATURE-----

--r4jNezHNW2wfBox+--
