Received: from eggs.gnu.org ([2001:4830:134:3::10]:42155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1edy19-0006YU-KU
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1edy16-0004P0-G7
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:49:35 -0500
Received: from ozlabs.org ([103.22.144.67]:38557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1edy16-0004MC-1S
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 07:49:32 -0500
Date: Tue, 23 Jan 2018 23:49:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180123124922.GB14832@umbus>
References: <20180119050906.18930-1-aik@ozlabs.ru>
	<20180119051926.GI30352@umbus.fritz.box>
	<6a3fac69-c1e5-36cf-4781-5bb82b890efa@ozlabs.ru>
	<1516372482.3278.29.camel@redhat.com>
	<1516702111.31897.2.camel@redhat.com>
	<20180123112025.GI11419@umbus>
	<1516709019.31897.4.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <1516709019.31897.4.camel@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH qemu] qmp: Add qom-list-properties to
 list QOM object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2018 at 01:03:39PM +0100, Andrea Bolognani wrote:
> On Tue, 2018-01-23 at 22:20 +1100, David Gibson wrote:
> > > David, I know you're busy with linux.conf.au, but it would be
> > > really helpful if you could carve out five minutes to look over
> > > Alexey's proposal again, with my reply above in mind, and let us
> > > know whether it looks a reasonable design. Doesn't have to be a
> > > review, just a quick feedback on the high-level idea.
> >=20
> > It looks ok, I think, but I don't think I'm really the right person to
> > ask.  I do wonder if creating a throwaway instance could cause
> > trouble, especially for something like machine that might well have
> > gotten away with having global side-effects in the past.  I think we
> > need to talk with someone who knows more about qom and qapi - Markus
> > seems the obvious choice.
>=20
> Good point. CC'ing Markus to try and grab his attention :)

It's also occurred to me that making a spapr specific approach to this
might not be quite as horrible as I initially thought.  The
capabilities table is global (and immutable) so coding up a
"get-spapr-caps" qapi entry point which encodes the stuff there into
json giving the names and allowed values of each cap would be fairly
straightforward.

Accurately retreiving default values would be trickier, not sure if
that's important or not.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpnL1IACgkQbDjKyiDZ
s5I0kxAAxSPszHokllGMYvCZCFyXPnvMRCKz1LjfONmSMA7WUAtE6cyZkGy1aatf
sCVkAT/7ucqLZsRU4aqqCGtyFFkatFUs/Mzg4PKP0qWLDi4xX3X3RXlVCIqA6DDl
UWApqJc4nadFRzwIe1UJON9V7qhTO6S+sRQikqxtVRbiIJT+SqddfE9x5waUczt4
v5HGYMNAnH02nMq/PIq8UwoaITTu14xnQGEvs8+cWrsUEySEEq0R0xHnqcHdKcEG
B/4SJaD9vyGRbkeOruHQopVB/k47cGJIz0oMK8BJgNmeZWD5E3zAxDbKrrXH/Hjj
Vy9BA+wN3jJ3+ZGPnOAxKQyHXsMz12lePt6QGb+XLMBi9+OKcVyokpz9VUO75o7H
vqv8LWjVkTu13w/lo/Z/MYamZINjin0A/MU/v3osB5o1kg7HQlSdy4lyXXT+4nFV
v100Qu5Nc1EL1dq0GYQf+IbRHmnrgcG9ZPLIGMD1f9bbqodZMsm0gziHxvlRyUfm
ysj6rc6PSMRIbSnED0NtxnvnLjwsQGnlJ6UODt9q8LAFBvXoaN6oU7De3vaPHBpD
vGaRyhX5mU48YhR5Ybf/4T7VDsWJXbrkNSR1oY4YjCfC6O6lBnH1hnuJXaIKJOVa
Hrk5ROVmucyiooNnhaTh12g4Ki3PCY/MhreE1EQp8noFEAT1zBk=
=qH4V
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
