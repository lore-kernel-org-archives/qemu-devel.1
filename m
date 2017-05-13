Received: from eggs.gnu.org ([2001:4830:134:3::10]:55047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d9SRc-00086D-TK
	for qemu-devel@nongnu.org; Sat, 13 May 2017 04:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d9SRY-000108-UR
	for qemu-devel@nongnu.org; Sat, 13 May 2017 04:30:32 -0400
Date: Sat, 13 May 2017 17:53:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170513075353.GA13183@umbus.fritz.box>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
	<20170505204746.14116-7-danielhb@linux.vnet.ibm.com>
	<20170512062836.GI12908@umbus.fritz.box>
	<24ecdb76-f525-19e4-5674-1884ffcf2455@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <24ecdb76-f525-19e4-5674-1884ffcf2455@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v9 6/6] migration: spapr:
 migrate pending_events of spapr state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 05:02:44PM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 05/12/2017 03:28 AM, David Gibson wrote:
> > On Fri, May 05, 2017 at 05:47:46PM -0300, Daniel Henrique Barboza wrote:
> > > From: Jianjun Duan <duanj@linux.vnet.ibm.com>
> > >=20
> > > In racing situations between hotplug events and migration operation,
> > > a rtas hotplug event could have not yet be delivered to the source
> > > guest when migration is started. In this case the pending_events of
> > > spapr state need be transmitted to the target so that the hotplug
> > > event can be finished on the target.
> > >=20
> > > All the different fields of the events are encoded as defined by
> > > PAPR. We can migrate them as uint8_t binary stream without any
> > > concerns about data padding or endianess.
> > >=20
> > > pending_events is put in a subsection in the spapr state VMSD to make
> > > sure migration across different versions is not broken.
> > >=20
> > > Signed-off-by: Jianjun Duan <duanj@linux.vnet.ibm.com>
> > > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > This seems like it's probably a good idea, even independent of the
> > hotplug migration stuff.  I suspect there are other races where we
> > could lose a shutdown event or similar if there's a migration.
> Perhaps we can detach this patch (and the ccs_list one) from this
> series and evaluate them separately?

Fine by me for this patch.  Not so much with the ccs one, because
migrating the ccs stuff really doesn't make sense without properly
migrating the rest of the drc state.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFruPAAoJEGw4ysog2bOSMoAQAM/Ng/G22jKiz+47F1HWjAyA
6NGahaLZG2U6ZzBkHibB6arDe+1Cb/+NTY79SAZDIZC/NctTUhv39dhKLsC0FQUH
/lGoLfbAF5SkeZzGpIXusOa3rDz7WiMak6Jh+ZR2clW5tV1k1YTXJ7oRZdyPMSpr
r60hcA52pRlZWzAAl3yNkLRaDqUMFySgUjqpxo491Z9W2o35kmmoKG7gBQkSaSdy
oqqNELX7GaUYqzh9OFMHlofYcp//sHQhlHoGsn3QqmNFgiOtWAVlqwb00nbniDwG
sbWkAifKQMZAkJxuwwqC1SMxDmDtC/g8TtCa+6+viDE0HZJps6yVuWc7PEypzKky
/JKZenuZNUAtcGLQpGQtJG/BSK3nBVkXLtgoFMTTZhTEb1vLBxrPjrhypN4DOXAZ
AjLXVMzkCagowqkx6S7xvW0wsweNIHrraAWGDiK7m17+9USyNWcT0de3m8l/cf/M
9IBURYbzdn1LGCowBJerX0nA6PpICWJj3jI0ph6E5daLNL0HmnGKDwJwNDyQBZUx
DPCxiCe9CZhrtY0t9OArvZYvP6sbDEUXXQnG6Q7UaqfcLTmKf49dArmAHwz4j+Sv
hXKGGmyY9Ra2ZlS1TopMD1HpU+gFeNn+hlHCHpD/4NtMwhzMKnb9H3mUYTeTCHGK
HyhiWANYwJdx4kI5KP+Q
=zsG6
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
