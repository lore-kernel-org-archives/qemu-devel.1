Received: from eggs.gnu.org ([2001:4830:134:3::10]:52743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ci7lM-0001qj-Tb
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ci7lL-0006zK-TJ
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 17:57:56 -0500
Date: Mon, 27 Feb 2017 09:46:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170226224643.GG17615@umbus.fritz.box>
References: <20170222063348.32176-38-david@gibson.dropbear.id.au>
	<1487761555-93223-1-git-send-email-imammedo@redhat.com>
	<20170224130357.GF17615@umbus.fritz.box>
	<20170224142921.495f6871@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HkfZ6fDZyisrdUtK"
Content-Disposition: inline
In-Reply-To: <20170224142921.495f6871@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 37/43] spapr: reuse machine->possible_cpus
 instead of cores[]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, peter.maydell@linaro.org


--HkfZ6fDZyisrdUtK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 02:29:21PM +0100, Igor Mammedov wrote:
> On Sat, 25 Feb 2017 00:03:57 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Feb 22, 2017 at 12:05:55PM +0100, Igor Mammedov wrote:
> > > Replace SPAPR specific cores[] array with generic
> > > machine->possible_cpus and store core objects there.
> > > It makes cores bookkeeping similar to x86 cpus and
> > > will allow to unify similar code.
> > > It would allow to replace cpu_index based NUMA node
> > > mapping with property based one (for -device created
> > > cores) since possible_cpus carries board defined
> > > topology/layout.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > Acked-by: David Gibson <david@gibson.dropbear.id.au>
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au> =20
> >=20
> > Sorry Igor, Peter has applied the original version.  Can you resend
> > these updates as deltas against the applied versions of the patches.
> >=20
> > > ---
> > > v3:
> > >   - drop "// TODO" comment as todo is completed in next patch anyway
> > >     fixes checkpatch error wrt // comment
> there is no need for patches on top as the next applied patch
> 38/43 removed c++ style comment as part of removed
> spapr_query_hotpluggable_cpus().

Ok, good to hear.  What about the other update patch you posted?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HkfZ6fDZyisrdUtK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYs1rQAAoJEGw4ysog2bOSyz8QAOcmCIctnE9GS3Bagh08B6WO
o9Hwr050DSsbHn5cgj6jPfs8KagVb53TykFjQ7MdH0t8zT9AIsdRTd3Ml3VnUUof
8uGfiOc2pKwRPA/J4GUuV5/DBVJBqiPOr7KqmIBbaVcRk8G1/yAABfA3JRxmYHh7
QO+9KWHkp2f+8oXdta57fxJ37MIMH26zzgzq/9lMO4L07t8M2BDDffAX9ftfOa7R
EIzncZyvoM6SXJVdSB9VhFTfyHdu81dL2NXIjJgZChPkCBCsWH5Djm2D1E/9FAs7
tytcWyDF2YfOWbhzaGT6DdgT0hb9Gk5JuCV6+xPHKwPjd2spGO195DuURp6fo2h7
R2PXxaxQxfzp5+KZaNL25gPAJJtN3HXVJKWPlUxb8sfa5hBWcTIwihb3rn+r7pFI
tCigA2R59w7rsAPoYtH2JFDIhtXMFaHu6peqQY6dqL5Y4yxHS/jwuhb0yLt3CM1L
PzOxi+270ZZUafwIZ4IusFcu68jxUIrkoU4UcVBwH+3kDUXpwhfhU/Cl55ID0rRh
gB19zYgIAGxOesbRzg9Gdt7H7BkfIz+a8D4sO1NyAUVacsN3AidrNeoP8EhTOI3Z
OqL1ovTXHoIQ7ENGJA6Os/6U42mlkq02TtDiRBqyrhNF/YRmv/ja4l8OETe2T0wq
qVVeukuDHe8XoVeOlmXB
=/a+M
-----END PGP SIGNATURE-----

--HkfZ6fDZyisrdUtK--
