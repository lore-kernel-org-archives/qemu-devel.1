Received: from eggs.gnu.org ([2001:4830:134:3::10]:40400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMCyl-00064Y-Uo
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMCyi-0005Tl-Ns
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:09:43 -0500
Received: from ozlabs.org ([103.22.144.67]:46979)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1eMCyh-0005SH-PE
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:09:40 -0500
Date: Wed, 6 Dec 2017 00:06:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171205130636.GN3057@umbus.fritz.box>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<151194617493.816.13426298875361921541@bafd83ae6430>
	<20171129091847.GC12220@lemon>
	<20171205064753-mutt-send-email-mst@kernel.org>
	<20171205050558.GA31705@lemon>
	<20171205051151.GF3057@umbus.fritz.box>
	<20171205064635.GB31705@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uMPAU7A2Er6+wvsD"
Content-Disposition: inline
In-Reply-To: <20171205064635.GB31705@lemon>
Subject: Re: [Qemu-devel] [for-2.12 0/7] PCI cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, marcel@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com


--uMPAU7A2Er6+wvsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 02:46:35PM +0800, Fam Zheng wrote:
> On Tue, 12/05 16:11, David Gibson wrote:
> > On Tue, Dec 05, 2017 at 01:05:58PM +0800, Fam Zheng wrote:
> > > On Tue, 12/05 06:49, Michael S. Tsirkin wrote:
> > > > On Wed, Nov 29, 2017 at 05:18:47PM +0800, Fam Zheng wrote:
> > > > > On Wed, 11/29 01:02, no-reply@patchew.org wrote:
> > > > > > /tmp/cc3Czn0R.s: Fatal error: can't write 3947 bytes to section=
 .debug_str of hw/arm/virt-acpi-build.o because: 'No space left on device'
> > > > >=20
> > > > > Hmm, the host is shared and what I have is a normal user account,=
 so there is no
> > > > > control over disk space availability.  Anyway this is completely =
unrelated to
> > > > > this series. Sorry for the noise.
> > > > >=20
> > > > > Fam
> > > >=20
> > > > Could you disable this until you have the time to detect disk full
> > > > errors?  You are training people to ignore this bot, not a good thi=
ng.
> > > >=20
> > >=20
> > > Thanks for the suggestion. I've added a string match to the notificat=
ion
> > > condition. The problem is disk is only one factor, I dream of an AI t=
hat can be
> > > trained to tell which errors are geniune bugs of the patch and which =
are
> > > environment failures... :)
> >=20
> > Another approach would be to have a "known good" build that runs every
> > so often.  If the known good build fails, the bot disables itself (and
> > tells you to investigate).  Obviously there are ways that could not
> > work as well, but it should catch a fair range of spurious failures.
>=20
> Interesting idea, yes. A slightly simplified way is to test the "base" of=
 the
> series and only report errors if the base can pass.

Right.  I think that would catch even more cases, but means doing the
"base" build every time, which might slow things down significantly.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uMPAU7A2Er6+wvsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlommdwACgkQbDjKyiDZ
s5IzDw//ZcR3/U6cW1M6Dur1OqYSh40IHKj9rPDah86q511gw/8Yai/yC8O1vJ25
EIrZdZaju8i+o8fI5349BK28eTnS8lX6eDHFdhwfUtC27FgWG+r+37ut+RKLG3Fb
1fTpDhr8m7R4BKei50hN7NA6CcMGv4OymQPMX+Oop+NBh/ZDVDz/UY4FAeYj8rtz
mnvkXg64dYWDQ/mGO5auyXtXYIooW7UX/CtX9aBdCT+R1xOqnNhsRshWaJ3UUc3I
SeXDWmgDZ2jS1EpgJjf/1FJUlfsScjP8CDy0Worw68y2/mpwsyKXHX7RGdVqDJmg
aA2bipLN72e9SHxo4ZJEOoY9PSQQGs6vL7Jf/kVHPoBC34H9g5wifsI6TemJLnI2
6eEkAKpJqao9yrfbaTAWUXNE/B4jAkkXEXrhNEv8ViCIQLSgSFKJd5CaB74cZijO
b4gpjMFUVX86tgycp2H0Jb/UguFR7zseeixvyndn4vjvcdC6GTxy3wG+743dQ8sN
aBqNwze2aMNe3/brhFPLhYOc7yWwXIb1v4SRmIeIlC9PhRBOMmKoS0FIArJvWNyj
yuit8Rk25JGNxGSjIXdh9Xyh+Vxx53YUMxQGMK2NZC1kkx7chcuMx7Fl9rkn+tfV
NZFWOj1hfhRpKTNzTWh05HjzG6gzZWt7jar5SScWaUNaQw/LqGI=
=LwKj
-----END PGP SIGNATURE-----

--uMPAU7A2Er6+wvsD--
