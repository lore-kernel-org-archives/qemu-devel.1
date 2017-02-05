Received: from eggs.gnu.org ([2001:4830:134:3::10]:33663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caY3e-00012g-C2
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caY3b-000594-8l
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:25:30 -0500
Date: Mon, 6 Feb 2017 10:46:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170205234610.GB17644@umbus.fritz.box>
References: <1486047755-93584-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <1486047755-93584-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] spapr: fix cpu core hotunplug call flow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2017 at 04:02:32PM +0100, Igor Mammedov wrote:
> Make cpu core hotunplug use the same (expected)
> unplug_request/unplug call flow like spapr memory unplug
> and mem/cpu unplug on x86.
>=20
> While doing it separate internal cpu core handling and
> machine wiring code and move machine related callbacks
> close to related machine code in spapr.c.
>=20
> Series applies on top of tags/ppc-for-2.9-20170202 pull req.
>=20
> repo for testing:
>   git@github.com:imammedo/qemu.git spapr_cpu_unplug_cleanup
>=20
> CC: David Gibson <david@gibson.dropbear.id.au> (supporter:sPAPR)
> CC: Alexander Graf <agraf@suse.de> (supporter:sPAPR)
> CC: qemu-ppc@nongnu.org=20
> CC: Bharata B Rao <bharata@linux.vnet.ibm.com>

Merged to ppc-for-2.9.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYl7lBAAoJEGw4ysog2bOSBwUQAKw9/hKKWsIo/QnmlhlZ9S/M
UyJak+ztLniSYiNmZVkIScQUNJIS/Q47nc8QoxfisB7x0NaUmJbziT//JCmgE0U2
BsYiMiIr0iqpDygznOb9KzoN53VJ48Z88yWVh+WugChysD1VkFoJ5hIA5Ik5zbbK
EsZzeI2OjDWaD4BRIne1VOBD2frG7K+iF+8UTm0Rji4i9hpdyZXhFgQsYQN8RPqN
/XOUt3dh3unEivX6Z8tGKg0ki+HSLQwAyNyA+vTrdaQMkOK4gjeXEpZmJCTL1+GA
7Ppt+0/bPvm2b6HVDdcUdGE5niufTnteyTFrrTS74JDzwa60fcsdmi83VgA/X92f
LMBxUPH1Uo0Z9W9aBlYIgIIsh2MJW2iYNhGHc7vhlTtfyhCtWdRw0TB8G9NO2tDQ
mJnfwkQgwYFpxN/60/uQXuQwgeZUgm4rPSCISIYs/+wF9xXuZkx9ZfZpNqZgm7Ga
SuILWL+uPL4+jAV8++8BpUk9pjVrzGRaAD+e/qxO1EPgCZhFht1tItaUMElpluoX
kpZYz4be4C1tr/CieaNuk+nh0S9rxe3Ce2DFgnzn7OFOqwXI7Vtnf8z4EmStcoft
wJL0WPDviEufINbTeYP9kDbynbUXsXuKPJzdJ5fmSTQjziB+NL71fSa6YQP5Gara
HOL1HcaSxlN5Ku7HrjYz
=yMbB
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
