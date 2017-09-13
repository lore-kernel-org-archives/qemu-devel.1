Received: from eggs.gnu.org ([2001:4830:134:3::10]:46349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds0wv-0001sP-4s
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 02:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds0wt-0007GR-PN
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 02:15:01 -0400
Date: Wed, 13 Sep 2017 16:02:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170913060203.GG7550@umbus.fritz.box>
References: <1505054255-2990-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505054255-2990-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170911095059.101e0cfc@bahia.lan> <20170911093032.GA2857@work-vm>
	<20170911104854.GB2784@umbus.fritz.box>
	<20170912162100.GD2225@work-vm>
	<1bb6a27d-89a5-2e70-6976-74ab24430ec4@ilande.co.uk>
	<4f0cb74a-ae00-5921-291c-49c9acdb3e02@ilande.co.uk>
	<d7dd9adf-4727-aeb5-b8ad-ac8c22c2f4bf@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sClP8c1IaQxyux9v"
Content-Disposition: inline
In-Reply-To: <d7dd9adf-4727-aeb5-b8ad-ac8c22c2f4bf@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] ppc: add CPU IRQ state to
 PPC VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, lvivier@redhat.com, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--sClP8c1IaQxyux9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2017 at 12:23:13PM +1000, Alexey Kardashevskiy wrote:
> On 13/09/17 02:46, Mark Cave-Ayland wrote:
> > On 12/09/17 17:41, Mark Cave-Ayland wrote:
> >=20
> >> The commit message mentions that prior to the conversion some CPU state
> >> was missing but it doesn't mention anything about dropping existing
> >> fields as part of the conversion process so I suspect that this was an
> >> accidental side-effect.
> >=20
> > Actually I've clicked send a little too early here since re-reading the
> > last paragraph of a90db15 I can see the inference here: "Exactly what
> > needs to be saved in what configurations has been more carefully
> > examined, too".
> >=20
> > Alexey - do you recall from your analysis why these fields were no
> > longer deemed necessary, and how your TCG tests were configured?
>=20
> I most certainly did not do analysis (my bad. sorry) - I took the patch
> from David as he left the team, fixed to compile and pushed away. I am al=
so
> very suspicions we did not try migrating TCG or anything but pseries. My
> guest that things did not break (if they did not which I am not sure abou=
t,
> for the TCG case) because the interrupt controller (XICS) or the
> pseries-guest took care of resending an interrupt which does not seem to =
be
> the case for mac99.

Right, that's probably true.  The main point, though, is that these
fields were dropped a *long* time ago, when migration was barely
working to begin with.  In particular I'm pretty sure most of the
non-pseries platforms were already pretty broken for migration
(amongst other things).

Polishing the mac platforms up to working again, including migration,
is a reasonable goal.  But it can't be at the expense of pseries,
which is already working, used in production, and much better tested
than mac99 or g3beige ever were.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sClP8c1IaQxyux9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm4ydsACgkQbDjKyiDZ
s5Ku4RAAr4fV3v+q0OLgDBgUMcBa0QbXJyXOh/mk3rD1WNcEooQWwIee9pyhZlTX
SH5rfAdlaudl870o9ztKFFqx5dxJZKe54HyQD6N+dyul8WgT2TUPHPb46njUsnk/
jNWlv1dFZggdCUCAlxT7OoBI6yqlmnkUn4BJVg198sL3kfXv4iyb5GBeN2Q3FVHS
7MrmhqtcO6Vs92/rUOUqZJa0FRRwdRfsGCzFnlqzYhducBwQzlGpuRm4sU4V9xnj
oms4fY4OhIYgs9bOLhXJQTKgbhGmPqz4nWA1WVAOq/u1Xe0qscvSs46VsIVOvJ+T
V3q5Li71MVYKGa+M1R5rVrrTZ4riNmnnC2B6hgWCbyE7rQKEzdz6n0e9s0tlwr73
1ZoQcQFhDYAGH/EzeeMRIReGg4RbsJ/8l+Gr8J/gjLMmg7NAHf4xf2kiCKnemAiU
DTv/8mOwKNtkqkWKqlbT9VH+t+pXoHtDfj+G5mccUgcO4IFOOOiu+V9pxSVPv0zS
a4wV1+RAIqx7M6xFmZb3mTwKxEvDe5r64HyDzshPK5CEg2IleHHwa1gXX7k2Lri6
it1DXRxQrgFdCMx9KVDPibmHZhYHQHCYTSknhdP3hbctuNg8cJrPoxtUAI0Vm591
Q5uytB80wLsQjSZWjQjx3EjeMG4KiuSrofmObWlQjMeJgZtvJQI=
=YV/v
-----END PGP SIGNATURE-----

--sClP8c1IaQxyux9v--
