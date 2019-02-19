Received: from eggs.gnu.org ([209.51.188.92]:36296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gw5dZ-0004N6-Rr
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gw5dV-0002PB-Kw
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:40:39 -0500
Date: Tue, 19 Feb 2019 16:36:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190219053641.GC9345@umbus.fritz.box>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023078871.1011724.3083923389814185598.stgit@bahia.lan>
	<20190217231455.GB2765@umbus.fritz.box>
	<03af3e28-3fdb-50e9-295a-09dededf5af5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZQ93ZA/51YEIDw4/"
Content-Disposition: inline
In-Reply-To: <03af3e28-3fdb-50e9-295a-09dededf5af5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/10] xics: Explicitely call KVM ICP
 methods from the common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org


--ZQ93ZA/51YEIDw4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 02:10:41PM -0600, Eric Blake wrote:
> On 2/17/19 5:14 PM, David Gibson wrote:
>=20
> In the subject line: s/Explicitely/Explicitly/

I'm afraid I already sent that to Peter.  If the pull request gets
bounced I'll fix it up, otherwise, too bad.

>=20
> > On Fri, Feb 15, 2019 at 12:39:48PM +0100, Greg Kurz wrote:
> >> The pre_save(), post_load() and synchronize_state() methods of the
> >> ICPStateClass type are really KVM only things. Make that obvious
> >> by dropping the indirections and directly calling the KVM functions
> >> instead.
> >>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZQ93ZA/51YEIDw4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxrlekACgkQbDjKyiDZ
s5KOQw/+JmlxiPYLiJKv0GFHKP2KnKuMSR6iNOTeCxzq9D4R6g2RLiF1TH83KfXE
hFU/htr6xBEZfae+dRzW7qEYY7a/uCwrFwicL27HppXfiSwYwytkIQAXbpAfHB7y
+ZCf2r73IzmpQ9Hg4Y/vpSMExjiecpPc+Cby3ZFtPQgDd3QtoPdOihNfK158YX1e
bMyGCbWtR+BpPHml3ba/Vztj43c+wNra3ez8pZXSix/RoWF9ruX0zMxKW35+4xip
9CccRuwbVshBNHJyY89bIJRgFw98dHBmfd9M1c5J+ObyJGeHtNOAX7YY+mtMsFyn
BuB5aRronX45h08UjYlvZfn/fE8ZguAsOlGs0EucrcHtFIbCfhmdK0uZVA/+7gAb
Ot2qPoTCh9M63ENiCeuytJNdneWXwOVVmh5IB7NWWMUbz58okr5uNLu5IFHJonUe
/cDZZzYfbzQVTQUAOQFAMwMrZyKS9AuChp7c2ljr+0u2vYh5Mi9r8ExvXIBf3rRL
/S0RReOde+r6+zMLIYWLjHEwkGTWEzljpQg+3GWmvz2wUQiIvRta1EUcs/diKELd
Pd5HCMv4c57SvzZK1W4FJYv3IBk0ioJW4xc96XTDeR7vZ7oRxzPd+my5ebconhTW
f7bvUWta/VgIIv58wJKfjwRlaLBbzmdJ7P0I2yveE8fVc5Y+baw=
=rLq1
-----END PGP SIGNATURE-----

--ZQ93ZA/51YEIDw4/--
