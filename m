Received: from eggs.gnu.org ([2001:4830:134:3::10]:55818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVtER-0001jx-SJ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVtEO-0008EZ-PQ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:38:11 -0400
Date: Thu, 21 Jun 2018 16:34:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180621063453.GF32328@umbus.fritz.box>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-5-david@gibson.dropbear.id.au>
	<d10c36f4-9e4b-0893-25d3-0786def1b463@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
Content-Disposition: inline
In-Reply-To: <d10c36f4-9e4b-0893-25d3-0786def1b463@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 4/9] target/ppc: Add
 kvmppc_hpt_needs_host_contiguous_pages() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, abologna@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 07:56:58AM +0200, C=E9dric Le Goater wrote:
> On 06/18/2018 08:36 AM, David Gibson wrote:
> > KVM HV has a restriction that for HPT mode guests, guest pages must be =
hpa
> > contiguous as well as gpa contiguous.  We have to account for that in
> > various places.  We determine whether we're subject to this restriction
> > from the SMMU information exposed by KVM.
> >=20
> > Planned cleanups to the way we handle this will require knowing whether
> > this restriction is in play in wider parts of the code.  So, expose a
> > helper function which returns it.
> >=20
> > This does mean some redundant calls to kvm_get_smmu_info(), but they'll=
 go
> > away again with future cleanups.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> but this patch is already committed it seems.

Yeah.  I was pretty confident of these earlier cleanups, so I merged
them with just Greg's R-b.  It's 5-9 I'm particularly in need of
review.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsrRwsACgkQbDjKyiDZ
s5JskA//dWl8se6Jfc8ao/jCBM+pVzqa1eE+pwxDcPSdQ3YEMC/8EWyBOAsBL51B
ceU6yjbkA/CJ5al8JTtErcJlhQxG1Dv1VW1heAnOp/tuGVpaL+8kewzvESvZaK5g
04kPbHhjakELD1jzO1tRct3QK64v5Y124wtrpRFQoan0q4dpfevURZfaIir07M77
thXRVLgPWBSZRWgdVadveJlDDva5+GwW8dwH/jon3RjSwtzUJo9TNfyPN3xx4Q+D
3XGB5+NlU/+Xc2AcLvvqtO3HlmeNZ5EutamdKQS51VW0HbE0TGTHrNyCxEnGZBCN
vaeEghRBKOxdNfLHGmHHwtXKgObrJoavgaR+Vz0T9HSGkHC7kjoZ+X3sDc5rjkba
/GVXW19GratvxOVzy7ZNJ2lMNj7fypb4S3Tu8oUN9WOR5IVRTquX4K5dDLC9zk0C
SNC2J49+lG0A11qb5oiMK9EmvSw9IcQaXK0X7YY0iw2Ksdvn5NRAaN6j7wWZ1A9X
R/VSdvbXJFtZ54E7GWCBJcqGxMG23Wl6afeqZtV384GgumxEdNd4Ynjgx5zPGCY3
EWbQkmNCYpBN6t5cDQdAiDYFkASL3YRXbg7LuPf+fMXQoR2G0DZ0pZrDEkMclIW+
Hi+9VGhiHKYEbz2fbr/LvOAls/eRUfh4LHsMeadlp59kMyEyPM4=
=X+3k
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--
