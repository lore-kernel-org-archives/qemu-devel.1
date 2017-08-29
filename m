Received: from eggs.gnu.org ([2001:4830:134:3::10]:50590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmVm7-0007k1-8F
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 21:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmVm4-0000zE-7L
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 21:57:07 -0400
Date: Tue, 29 Aug 2017 11:40:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170829014030.GD2578@umbus.fritz.box>
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
	<20170824025448.GA27401@fergus.ozlabs.ibm.com>
	<20170828175356.GB26893@ram.oc3035372033.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
In-Reply-To: <20170828175356.GB26893@ram.oc3035372033.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: Add ibm,
 processor-storage-keys property to CPU DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Paul Mackerras <paulus@ozlabs.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Michael Ellerman <mpe@ellerman.id.au>


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2017 at 10:53:56AM -0700, Ram Pai wrote:
> On Thu, Aug 24, 2017 at 12:54:48PM +1000, Paul Mackerras wrote:
> >=20
> > We could either have two u16 fields for the number of keys for data
> > and instruction, or we could have a u32 field for the number of keys
> > and a separate bit in the flags field to indicate that instruction
> > keys are supported.  Which would be preferable?
>=20
> the second choice is more confusion-proof; to me atleast.
>=20
> The first choice gives a illusion that there are 'x' number of data keys
> and 'y' number of instruction keys; which is not exactly true.

Ah.. can you elaborate?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmkxgsACgkQbDjKyiDZ
s5LNdg//Wj4N5VELWev6/ISiIslnLFP1n+sEoEYtVarf6KN6oBpMm0sng7u9DiwT
LNag+1h29ZfZxH6otflX5RjRiPcSy/hqICk9qGNoKDgpLMxq8WEsrCDymZR2aVqZ
wnBdh7MHMkNW3x0q81SiBFGmlyIJmC+pdXiNAAG+ItY502+MI+AhVpaqZeogsCMM
Md/l27Umd/M6UKLq13M+T8/i+DIUZZbjvKUVGBDyGTXLJeNunOiFKo/1YTj92qkW
zmkzVFWfN7J+ohhqhmE8SnIws/UU8bwvutcVdiaD7mx9qG6s5DnDFAHgjqMTqe2I
2xL+ZTjKW0mNq4FPFr5yxE+ToPAq/mGL8ldpOGNRx42uPpeTuSlUA0OtiMOdkoAl
7od/LoSZIpjgTkOrGHiYtsSowrZ9MzTAwJJtGHrFTPyDp+11jfrzhSN6tvLpwCF+
xHepMqAqVF3/HFmNmbC4cv8E8cZBL+SNnhGbZDEgs1V2SdiT6Wn7y1hkrEsNXDrw
szfNp20go2NBcgGmvHvnWT9ifWKrWcsudna4lAKOOuDYu9B4J3tFch12YRHBvQPk
I4z7GyEWuZKIHEE5IHeyn2xJzRWVAiFo0Km5p/yClZPTSear0/mwT3skczwxKmla
f0M9rVsprrTJKQtyPp1fChoRZ2A1uY+TH3zv81L4QBHyzWBQ+lw=
=X/kI
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--
