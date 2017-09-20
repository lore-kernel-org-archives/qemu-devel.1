Received: from eggs.gnu.org ([2001:4830:134:3::10]:43661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dufDz-0004qK-M6
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dufDv-0003HV-FH
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:39:35 -0400
Date: Wed, 20 Sep 2017 22:04:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170920120433.GR5520@umbus.fritz.box>
References: <1505668548-16616-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1505668548-16616-8-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170918224423.GF27153@umbus>
	<67a77fd3-b8a9-6584-694a-fc4679c37102@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gMqNd2jlyJQcupG/"
Content-Disposition: inline
In-Reply-To: <67a77fd3-b8a9-6584-694a-fc4679c37102@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 7/8] openpic: add missing timer fields to
 vmstate_openpic_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, benh@kernel.crashing.org


--gMqNd2jlyJQcupG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2017 at 08:50:49PM +0100, Mark Cave-Ayland wrote:
> On 18/09/17 23:44, David Gibson wrote:
>=20
> > So, adding new things to the migration stream always requires some
> > thought.  The commit message should contain a rationale for why the
> > proposed representation is a good one.  In particular is it one that's
> > unlikely to be difficult if the device changes internal details in
> > future.  When possible it's best to stick to architected documented
> > state of the modelled hardware, though I can see you're probably going
> > to need some extras in this case.
>=20
> Yes, I think that's the case here. Definitely the timer can't be armed
> correctly without origin_time, and if qemu_timer_active isn't present
> and migration occurs with an active timer then a subsequent call to
> openpic_tmr_get_timer() will be incorrect. Does that sound right to
> you?

You'll certainly need some sort of time variable, which could be
expressed in various ways equivalently.  I don't know if you'll need
an explicit extra "active" boolean - are there any openpic registers
which would indicate if a timer is active?  It's generally best to
represent state using documented forms from the hardware whenever
possible.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gMqNd2jlyJQcupG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnCWU8ACgkQbDjKyiDZ
s5LWyA/9FUu6NGc9BwYiHdjkp7iV7VDmg0IwcaHy4Z52FX+69huqluYdfTaW6Shl
mlHVxxqWfQMJcaY6LzkSnL/vYj1BIFgiUwOpam4glXYIPgQ7bbtUE+wwwJYK35v7
mVulYEAOI233lvvG1pziyORVFDJZQIVOUHHBSiq6vFDnOmWLlIjk7Cdo7u0SRVys
5mi34rnimyWhR/H5vEfzi7GykymEU4fq2roqGU8KZsAGhvhQRC6x+pG5WywHScap
yBF/OY6/4Xd8xQ9x9D0rEchCkI6QS2xmnLlK5678eOusgG+5Q3AQUGQ0d0O4R02I
sJKXurHMRCfqcpaWzBm9pXMtU58ErfLZa+iV95yGDJhMgFvNhg5nRl6LMxDRlb5C
t6DyIm4U9vxCyCK6JV7fs31c+M5G7NCyoALxzKss/+UFGDtdYBdbCiZ+rsX2EMY6
m9Xwtx7IBKqQUqv/3MIAzV7oebRdkdFdL0T38tyhQ1OaeHGwAovrwMkouPt/F33x
WXVKAsbOc7uAe6+AWlR4+dgIX42ivYrHHEDf+UMMaWSclfV98kWvjpJBNwC1xgrD
T/iN+PKO2p4bp9Dx/TTArHpryni6YnPBEGNB4SdPtLRu9Zi61GRFyAqISkf4YRI3
jxOpZoImSrpXUj/G3mOy/e7rlqnlZb1ndA8HDRGSI7RlB79tWBM=
=UMsu
-----END PGP SIGNATURE-----

--gMqNd2jlyJQcupG/--
