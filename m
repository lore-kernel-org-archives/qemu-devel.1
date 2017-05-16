Received: from eggs.gnu.org ([2001:4830:134:3::10]:60337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAVhj-0003fj-4G
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAVhf-0002Pw-Si
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:11:31 -0400
Date: Tue, 16 May 2017 16:08:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170516060846.GK30022@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484836649.20089.8174753739169885859.stgit@bahia.lan>
	<20170516043555.GE30022@umbus.fritz.box>
	<20170516075605.69ba2b95@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Content-Disposition: inline
In-Reply-To: <20170516075605.69ba2b95@bahia>
Subject: Re: [Qemu-devel] [PATCH 2/6] spapr: fix error path of required
 kernel-irqchip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2017 at 07:56:05AM +0200, Greg Kurz wrote:
> On Tue, 16 May 2017 14:35:55 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, May 15, 2017 at 01:39:26PM +0200, Greg Kurz wrote:
> > > QEMU should exit if the user explicitely asked for kernel-irqchip sup=
port
> > > and "xics-kvm" initialization fails.
> > >=20
> > > The changelog of commit 34f2af3d3edf ("spapr: Clean up misuse of qdev=
_init()
> > > in xics-kvm creation") reads:
> > >=20
> > >     While there, improve the error message when we can't satisfy an
> > >     explicit user request for "xics-kvm", and exit(1) instead of abor=
t().
> > >     Simplify the abort when we can't create "xics".
> > >=20
> > > This patch adds the missing call to exit().
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/ppc/spapr.c |    1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index abfb99b71b7d..f477d7b8a210 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -133,6 +133,7 @@ static void xics_system_init(MachineState *machin=
e, int nr_irqs, Error **errp)
> > >          if (machine_kernel_irqchip_required(machine) && !spapr->ics)=
 {
> > >              error_reportf_err(err,
> > >                                "kernel_irqchip requested but unavaila=
ble: ");
> > > +            exit(EXIT_FAILURE);
> > >          } else {
> > >              error_free(err);
> > >          }
> > >  =20
> >=20
> >=20
> > This doesn't look right.  We have an errp pointer in the caller.  So
> > on failure we should error_propagate(), rather than deciding for
> > ourselves that exiting is the right course of action.
> >=20
>=20
> I generally agree with that but can the caller cope with the fact that
> the user passed -machine accel=3Dkvm,kernel_irqchip=3Don and this cannot
> be satisfied ?

AFAICT the only caller passes &error_fatal, so, yes..

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZGpdrAAoJEGw4ysog2bOSqf8P/31Itcba1P7ikw3h1o4493ea
G3zp/gdhC/JSa2m2uGhXW2H6RKmqM4Hkugoq2sY3ccLad2fe4LUTnMPdIEvDn7D0
NgN4SMrJT/rc5opL0CR0Mlp6rrzf8neUzow9WdZAwmY1qKiwhsAzpgFNOEBeQvo2
RAcu9dcJwCqoaL5RLJF+yb1KumVCbm/ARTYSFZ1+yY95n3+3v1f2JJ9qx/p6BQ+D
0wPgwHWdeglS7/iVfUQcoI8xu/36vss8o/h66s1pyTa8eC1/CZPh51vnZM6450jf
tSLq/UXJlK0IjySavwKct0oHMjNSL8HXArOVaUpXwpvUYaLDqgl4ZlHqJBkhAqml
bf6Ez8iLu49jq7pHVtYUmOA52bwgDmrm/sgtnY1g7cNW4OSRUIas+2JnmbDE6l4E
/bAtPG0L1fGDhnvOTTBqXvIGt1ASVV984b32FXBiOWrIWovnM9c76bvUJEktTXcJ
aeOV1YMffJgqvMq0SP/bItlyzfVNL7evhCR+1gLO7SRWx81pvUq5MVrPy0VqeZrS
me9V1tNSL5ymVYqPNUDjR4qd1b5STFEIsACdmthb5IAs1kjiudLOvER29HepXq9h
H/sEs96/r3BznIv7VGWooUB9iFz9LlwbaOUggCW03CSdQZ+oa0DgqtNQe+nqSgtT
G0hZCzY3O63A08sSUCjh
=U0mk
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--
