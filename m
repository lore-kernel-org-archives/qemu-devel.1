Received: from eggs.gnu.org ([2001:4830:134:3::10]:53402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWX2D-0001sj-Hy
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eWX2C-00021j-GK
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 19:35:57 -0500
Date: Wed, 3 Jan 2018 11:09:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180103000947.GE24581@umbus.fritz.box>
References: <20171016052004.31397-1-aik@ozlabs.ru>
	<20171016093641.GH2776@umbus.fritz.box>
	<e419ca8a-6e0b-70eb-14da-03a843fa8b92@ozlabs.ru>
	<20171019062440.GY2776@umbus.fritz.box>
	<699e58bf-de22-5341-ecc6-458df7ccbe65@ozlabs.ru>
	<9227196b-789c-e4b2-c9c5-4fd95ed42b4e@ozlabs.ru>
	<20171109063822.GD7732@umbus.fritz.box>
	<d6f4ad92-bd83-b990-4e86-ac89638c44d0@ozlabs.ru>
	<9fabc6c4-9a95-d44e-dc4c-33d91c00fb0c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Content-Disposition: inline
In-Reply-To: <9fabc6c4-9a95-d44e-dc4c-33d91c00fb0c@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v3] RFC: ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Balbir Singh <bsingharora@gmail.com>, Greg Kurz <groug@kaod.org>, slof@lists.ozlabs.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2018 at 05:13:09PM +1100, Alexey Kardashevskiy wrote:
> On 11/12/17 17:20, Alexey Kardashevskiy wrote:
> > On 09/11/17 17:38, David Gibson wrote:
> >> On Tue, Nov 07, 2017 at 06:14:04PM +1100, Alexey Kardashevskiy wrote:
> >>> On 20/10/17 11:46, Alexey Kardashevskiy wrote:
> >>>> On 19/10/17 17:24, David Gibson wrote:
> >>>>> On Tue, Oct 17, 2017 at 04:55:03PM +1100, Alexey Kardashevskiy wrot=
e:
> >>>>>> On 16/10/17 20:36, David Gibson wrote:
> >>>>>>> On Mon, Oct 16, 2017 at 04:20:04PM +1100, Alexey Kardashevskiy
> >>>>>> wrote:
> >>>>> [snip]
> >>>>>>> ||
> >>>>>>>
> >>>>>>> Yeah.. this is all a bit complicated, I'm really thinking about a
> >>>>>>> fdt_fsck() function for libfdt.
> >>>>>>
> >>>>>>
> >>>>>> Oh. So what now? Do as below or wait for libdtc update?
> >>>>>
> >>>>> So I started hacking on this.  It's a bit fiddlier to get right tha=
n I
> >>>>> anticipated.  How about you make a placeholder function to "test" t=
he
> >>>>> tree for now, with a comment that it will be updated once the libfdt
> >>>>> extensions are there.
> >>>>
> >>>> What would the placeholder do? Nothing or my proposed "FDT_CHK" thin=
gy?
> >>>>
> >>>> Are we in a hurry with this one at all, or I can wait till libfdt ge=
ts this
> >>>> fsck()?
> >>>
> >>>
> >>> Ping?
> >>>
> >>> This is not v2.11 material, is it?
> >>
> >> Not at this stage, no.
> >>
> >> I've started looking at writing the fdt_fsck() thing, but got
> >> sidetracked by a bunch of related fixes to safety of handling
> >> corrupted blobs in libfdt.
> >=20
> > Please let me know when I can repost the "
> > ppc/spapr: Receive and store device tree blob from SLOF" again. Thanks.
>=20
>=20
> Still to early to repost?

No.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpMH0oACgkQbDjKyiDZ
s5Ie2g//YUNtN7iqAZy6CNal4s6NpFJNx4xtqXT3DBoBe0Rqz0wczk+ja3INUQT5
ggR70BqIt5ZnipEY49q0mx2LFlTHACyyjg+/WKmyhUbfu0dK/5hX8xjyEACy5jxV
a7P65/0UymD1B3ckoTsKxaLn0dUMvQnAeaCIFhX13VvpDbOfUYGOX0wKxNAaJate
Gw2wn7gKqzZD6+Sxm7xTGvxMiYEj9RvyDUmfcFAtqKIK6ylCj3EUH8lTa8ySc6GU
hhGeMAunMR4Q6G4fmxHtD2d8ez51pT8z37Oq/UukLkMCDNvWTyC86/o8p1OdWSAB
vIcSL1Y1HOmZTf0UYJzkkZH2zk4GlYHTJaFPpESTOmg7AqdY1fwiEq5ngxAuco/V
kItKdnA1L7ewbvl2T4pukkY8nWLMrUXegZMAQKguspxRXUZu5EFE4V6IR9TjlETp
JldEhR24xIOTk+beMMnl0b6E2LpDb3E93SrypzSomTE7ZzjbDWoY2ehViK4bzobs
D97ITQIaw0gRrYv7+lfaHvpfbUSQ7oDS/qb2UnDlErJ6i3Gadpzm1UK29vZi2mMZ
QRHxDJF9W5DAFhTpW95K3FU1aeEBF/B1avnhJbxc6fX2yrorAiBSpd+O9UnI0dAP
XVcy8vWtXV3xR80cdM5Dfp5PbO++tIZ0n2MuZKidG2Elilc7kvs=
=WT73
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--
