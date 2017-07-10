Received: from eggs.gnu.org ([2001:4830:134:3::10]:53128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUXTj-0006VE-RV
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUXTg-0006di-N4
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:07:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dUXTg-0006dI-D7
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:07:48 -0400
Date: Mon, 10 Jul 2017 13:07:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710120744.GC14195@stefanha-x1.localdomain>
References: <1498514681-3059-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
In-Reply-To: <1498514681-3059-1-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH v9 0/7] trace: Optimize per-vCPU TCG
 tracing states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Richard Henderson <rth@twiddle.net>, Laurent Desnogues <laurent.desnogues@gmail.com>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 06:04:34PM -0400, Emilio G. Cota wrote:
> v8: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02335.html
>=20
> Changes from v8:
>=20
> - Rebased on top of the current tracing tree -- the one that includes
>   Lluis' fix (2c321e3c486).
> - Added Lluis' R-b tag.
> - Added perf numbers in the commit log of the last patch (tl;dr: no overh=
ead).
>=20
> Thanks,
>=20
> 		Emilio
>=20
> PS. How to quickly get some linux-user perf numbers:
>=20
> I used dbt-bench[1] for a before/after comparison. I added a script to th=
at
> repo (breakdown.pl, see below) to make it play well with barchart[2].
> Obtaining a comparison bar chart is quite simple:
>=20
> 1. Generate one dbt-bench output file per QEMU checkout, e.g.:
>   $ git checkout orig && make
>   [ orig =3D=3D "before"; new =3D=3D "after" ]
>   $ ./dbt-bench.pl /path/to/qemu/build/qemu-x86_64 > orig.out
>   [ then do the same with orig-disabled, new, etc.]
>   [...]
>   $ ls *.out
>   new-disabled.out  new.out  orig-enabled.out  orig.out
>=20
> 2. Call dbt-bench's breakdown.pl script with the --barchart option, then
>   pipe the output to barchart, and finally pipe to gnuplot:
>   $ ./breakdown.pl --barchart orig.out orig-enabled.out new.out new-disab=
led.out \
>     | ../barchart/barchart.pl --extra-gnuplot=3D'set term dumb 140 30' \
>          --extra-gnuplot=3D'set title "NBench score; higher is better"' \
>     | gnuplot
>=20
> Note that barchart is just a front-end for gnuplot >=3D5, so any valid te=
rm will
> work (e.g. 'set term pngcairo size 1200,500').
>=20
> [1] https://github.com/cota/dbt-bench
> [2] https://github.com/cota/barchart
>=20

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY24QAAoJEJykq7OBq3PIyAYIALhp0bx6GN9PsMsHm0EXIRmW
hAgelLBABZdcfs3DJv4QxVJYyPIetNTmnwa3SQcRvl8GnmFQj7IM0JLl5Bg/u7t8
/ntgVckAAohsyGD+XFabFI/DS91N/+HdUTv4MG0EC7n46eV3P2QR/J45c4EFoWX3
nQYumP3GxWMk61ZG2qVl80T2+3nrfy30kiVw8wLZ+8iHjOJs1oc+9LTtwXpN9Ecy
dGhUpuB0FVLWULYFLGTNB1xqsDpWRIrhhmu4V5gFK2MV4eybSdtf1gYlEJrGLVwL
NMbEAeYkHFq2D4rRQmniSIWRdY8x/RfM0csKhQBEr1hGdxLP68dByIWNgk8hXPA=
=0NWL
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
