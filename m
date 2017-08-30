Received: from eggs.gnu.org ([2001:4830:134:3::10]:51353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmv9T-0006OD-E4
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 01:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmv9S-0002wk-Hr
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 01:02:55 -0400
Date: Wed, 30 Aug 2017 15:01:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170830050111.GH3386@umbus.fritz.box>
References: <cover.1503034743.git.sam.bobroff@au1.ibm.com>
	<b1865d81456e774567ab624a5b4ffde47772dd08.1503034743.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y96v7rNg6HAoELs5"
Content-Disposition: inline
In-Reply-To: <b1865d81456e774567ab624a5b4ffde47772dd08.1503034743.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/1] PPC: KVM: Support machine option to
 set VSMT mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org


--y96v7rNg6HAoELs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 03:50:22PM +1000, Sam Bobroff wrote:
> KVM now allows writing to KVM_CAP_PPC_SMT which has previously been
> read only. Doing so causes KVM to act, for that VM, as if the host's
> SMT mode was the given value. This is particularly important on Power
> 9 systems because their default value is 1, but they are able to
> support values up to 8.
>=20
> This patch introduces a way to control this capability via a new
> machine property called VSMT ("Virtual SMT"). If the value is not set
> on the command line a default is chosen that is, when possible,
> compatible with legacy systems.
>=20
> Note that the intialization of KVM_CAP_PPC_SMT has changed slightly
> because it has changed (in KVM) from a global capability to a
> VM-specific one. This won't cause a problem on older KVMs because VM
> capabilities fall back to global ones.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

There are some things that could be tweaked, but I see no reason they
can't be done as followups.

Applied to ppc-for-2.11.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--y96v7rNg6HAoELs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmmRpcACgkQbDjKyiDZ
s5Icwg//XdL8N+kn1+44htYPAyNK4YHWKnL8Zz7cKPzf8c6S59jdK66DK3VaZk/P
AJ5XlRk15rD9RGr/iaNNcp22UMGb2dxI9z2yrEIOj+UOiRpNOkgCdXNM4ehSQXfW
dZk1E6SQGINgMul6pg4AGcPO35Www+cO+vfno5nGJNL2g9uJzSSavyXmoTrMHtC5
DoNZQJ9vUq0db6n/W4PVjQGfXjDY+fCP0pE3aGSA9tDQAOHvzR7bw3cwphgauUvE
0DP8X9kylkQ6LIoAKDpf6iwCbPSSkhpErbgl+khlM+w1mz4oE8jqPOMbvDTa6Mey
KdqtTBr8FmQHiccXbqRHdT9Z9EKbINbFa+QP2+bg1MbTH40/q01I0Gc5nZTEQjHx
4upOQIXCfGuYmWdogmwkrGaPrGQTqSSgZd7Ay7qQ04bj4zPDlZf6WxxJMPw9OOYx
+a2zqqEdHlev5LibbzNlmhCROhWCZi/QGVmYTdpe5z6WuKMx8Z5os1yvqf6ME8KI
u9BAokvktPhfkaFrIdt5HdNpH4JMt5z1AgCzntKxkMtI/e4bToGeh76Uqm/QgqrA
/jKVNAAN3JGB46xSRay9pewbOGhyiBJBwz19bIJCMe3A0ZXQqesE085epATlFA1w
MyUoHv7OWOYb4QbWkoLPMD1lOXoCAoa21pG90vk6Xyv1wjeRQ54=
=IHWz
-----END PGP SIGNATURE-----

--y96v7rNg6HAoELs5--
