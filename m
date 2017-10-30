Received: from eggs.gnu.org ([2001:4830:134:3::10]:36545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e9GQG-0003pi-AE
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e9GQC-0007Qf-2V
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:12:36 -0400
Date: Mon, 30 Oct 2017 21:12:13 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171030201213.GA2911@umbus>
References: <20171026202250.6118-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <20171026202250.6118-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/3] ppc: adding some RTAS calls in
 tests/libqos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2017 at 06:22:47PM -0200, Daniel Henrique Barboza wrote:
> This series implements a few RTAS hypercalls in tests/libqos
> that, used together, implement the DRC state transition described
> in PAPR 2.7+, 13.4.
>=20
> This started as an attempt of implementing hot unplug qtests for the
> sPAPR machine but I've found a few issues that will require more time
> solving:
>=20
> - CPU hot unplug: for some reason the machine freezes after the
> callback is returned.
>=20
> - LMB hot unplug: not supported by the sPAPR machine if not
> set in CAS.
>=20
> I have a feeling that the CPU hot unplug  issue might be related
> with the lack of CAS negotiation step as well, but only way to be
> sure is to further understanding how the CAS negotation interfere
> with the device hot unplug. If needed we'll have to implement the
> client architecture support hypercall as well in the future.
>=20
> Until then, I believe these hypercalls have a value of their own and
> are worth being pushed upstream.

Unfortunately, these changes break the Travis build on MacOS.
>=20
>=20
> Daniel Henrique Barboza (3):
>   tests: adding 'check_exception' RTAS implementation
>   tests: adding 'set_indicator' RTAS call
>   tests: ibm,configure-connector RTAS call implementation
>=20
>  tests/libqos/rtas.c | 105 +++++++++++++++++++++++++
>  tests/libqos/rtas.h |   5 ++
>  tests/rtas-test.c   | 218 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 328 insertions(+)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAln3h5oACgkQbDjKyiDZ
s5JuUBAAk5abdwGutNJMCmQNSXtE9ek2uAzRwLxSw81BbECJRNTx4MtzXbk1LnBo
6SUmLoLaVSyjhUptm1uVnJXo95uXvOQJtC8dkkdHj8I9NWFLux+CQvsz7qwvTPjd
zw/xoREYW9YezLiH9q3tGhx+SO5TiHCn63pipXmx/3puIYickaevpjRWNO80vBC2
JpORDHZshb1jjzRZsGtuvedW5elCyXJP91EL3+pgd0lLkM5GYKqlkkd610QZqkLS
swkDkNdeKjO5ZKpfreEVmGfmvWn2nL2eNeDjA4DS9uZ/rc7cAaCJYTpPMaNHOc8+
Vl64vqX4uE4BVWVijBFmZd5oBEY8PWIb9pgux5MRILW0Go+Grm9GMaUb5PtYEsbh
TX5K13aqJycwH7dVNAVOkAGw3ivEl3x61Yj8Elspz3N84vIoCge7JFLpHgXua8qV
jd0910G3J7wAh1j3/xhUr8xaOz3uEnA48XbjB+Rrc1vJ/cnC0ZKDUijTf27WtucZ
NKm5wbGRXv50BLcQje67jUUQ1qF+3H86V3fmgcGJvCkwe1FCUh26jO5uADEwKdJk
8RZlQykPmeLd816KkxT3C3quXyrv7Y5zznaKTujts7MSMR945CKF4WWfxRxBs8vj
S9DSD5eFWb/yagKIY5QOMP5f3nb+OJNIuMtcrZIFTV8ur2E++ug=
=RnWg
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
