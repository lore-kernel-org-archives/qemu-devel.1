Received: from eggs.gnu.org ([2001:4830:134:3::10]:51347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtb-0001JL-0f
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtX-0002zw-Tj
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:50 -0400
Date: Tue, 19 Sep 2017 18:46:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919084618.GY27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170919082020.GT27153@umbus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t3Rhqlz/9+3FgEet"
Content-Disposition: inline
In-Reply-To: <20170919082020.GT27153@umbus>
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/21] Guest exploitation of the
 XIVE interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--t3Rhqlz/9+3FgEet
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2017 at 06:20:20PM +1000, David Gibson wrote:
> On Mon, Sep 11, 2017 at 07:12:14PM +0200, C=E9dric Le Goater wrote:
> > On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
> > negotiation process determines whether the guest operates with an
> > interrupt controller using the XICS legacy model, as found on POWER8,
> > or in XIVE exploitation mode, the newer POWER9 interrupt model. This
> > patchset is a proposal to add XIVE support in POWER9 sPAPR machine.
> >=20
> > Follows a model for the XIVE interrupt controller and support for the
> > Hypervisor's calls which are used to configure the interrupt sources
> > and the event/notification queues of the guest. The last patch
> > integrates XIVE in the sPAPR machine.
> >=20
> > Code is here:
>=20
>=20
> An overall comment:
>=20
> I note in several replies here that I think the way XICS objects are
> re-used for XIVE is really ugly, and I think it will make future
> maintenance pretty painful.
>=20
> I'm thinking maybe trying to support the CAS negotiation of interrupt
> controller from day 1 is warping the design.  A better approach might
> be first to implement XIVE only when given a specific machine option -
> guest gets one or the other and can't negotiate.
>=20
> That should allow a more natural XIVE design to emerge, *then* we can
> look at what's necessary to make boot-time negotiation possible.

Actually, it just occurred to me that we might be making life hard for
ourselves by trying to actually switch between full XICS and XIVE
models.  Coudln't we have new machine types always construct the XIVE
infrastructure, but then implement the XICS RTAS and hcalls in terms
of the XIVE virtual hardware.  Since something more or less equivalent
has already been done in both OPAL and the host kernel, I'm guessing
this shouldn't be too hard at this point.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--t3Rhqlz/9+3FgEet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnA2VkACgkQbDjKyiDZ
s5LrKhAAh6hSMzrIie6PSzaGi4e2ASTw6QS5c4BDXB1PgNb0dElwtnibZQBu3B31
Ngn+F/OWTt2li8bWb7lroQNfKatbil/LXmnHvrHivDFMzAwD9nGQomWVSdXDjAPw
4HhaJo9SZGAMuUn7vih/y/Pz6VyGpfNOf0dQa2a9mk0HpPooEvdaMELseT6LOvCh
R/IDxghTe/opZStyUsZznOnP7C9wznBAEC5SML2OrBhMDurQS9tbJPF6pY+lfnj9
hG1+HJqnEMxf8W0o/tJ02GsOBhEvAl1sKY70ArcXTtpID4xFaTf6Nf47U3ZB3ozr
ceVn/tAYrB8jRM+q8LsXH+Ye+bqvVNmmtGZXIrutOS5/NQtF7t68twwRvjhQ9QRg
Mdg7QS7TsQE+XhASzq4QXcScIfux+zYblRDp1fQhMdmiCFLleDZdGTw8NbEgp0sK
B3L3jdxjEi7hh8WA9tfjpnz9t3pnyz3Yv39ZMrHoqklnG7R925v0aKFbHlC+I1Tm
/mZvt0h00X9AhyANQMY3LLIiAVmfPsclLygw7VvA5dnDNZ4HMco1kUltFZBaVZ0d
ViKeF5RTDbO0wN8weLdj4s+ClukZoG+nANOslqix+M9Ggj3Q6ukGVPuIPkzibqeR
ACw/Q5Rke9idEdplqIomSUm1rUlGFFfXSpjY7FfqR26ILuNfFOk=
=MGvI
-----END PGP SIGNATURE-----

--t3Rhqlz/9+3FgEet--
