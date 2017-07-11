Received: from eggs.gnu.org ([2001:4830:134:3::10]:35376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUsou-0002JX-Eh
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:55:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUsoq-00075g-HS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:55:08 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:34526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dUsoq-00075J-91
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:55:04 -0400
Received: by mail-lf0-x244.google.com with SMTP id g21so13858007lfk.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 03:55:03 -0700 (PDT)
Date: Tue, 11 Jul 2017 11:55:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711105500.GQ17792@stefanha-x1.localdomain>
References: <1498514681-3059-1-git-send-email-cota@braap.org>
	<20170710120744.GC14195@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0pkK7MCEo5hACTvx"
Content-Disposition: inline
In-Reply-To: <20170710120744.GC14195@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Emilio G. Cota" <cota@braap.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>


--0pkK7MCEo5hACTvx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 01:07:44PM +0100, Stefan Hajnoczi wrote:
> On Mon, Jun 26, 2017 at 06:04:34PM -0400, Emilio G. Cota wrote:
> > v8: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02335.html
> >=20
> > Changes from v8:
> >=20
> > - Rebased on top of the current tracing tree -- the one that includes
> >   Lluis' fix (2c321e3c486).
> > - Added Lluis' R-b tag.
> > - Added perf numbers in the commit log of the last patch (tl;dr: no ove=
rhead).
> >=20
> > Thanks,
> >=20
> > 		Emilio
> >=20
> > PS. How to quickly get some linux-user perf numbers:
> >=20
> > I used dbt-bench[1] for a before/after comparison. I added a script to =
that
> > repo (breakdown.pl, see below) to make it play well with barchart[2].
> > Obtaining a comparison bar chart is quite simple:
> >=20
> > 1. Generate one dbt-bench output file per QEMU checkout, e.g.:
> >   $ git checkout orig && make
> >   [ orig =3D=3D "before"; new =3D=3D "after" ]
> >   $ ./dbt-bench.pl /path/to/qemu/build/qemu-x86_64 > orig.out
> >   [ then do the same with orig-disabled, new, etc.]
> >   [...]
> >   $ ls *.out
> >   new-disabled.out  new.out  orig-enabled.out  orig.out
> >=20
> > 2. Call dbt-bench's breakdown.pl script with the --barchart option, then
> >   pipe the output to barchart, and finally pipe to gnuplot:
> >   $ ./breakdown.pl --barchart orig.out orig-enabled.out new.out new-dis=
abled.out \
> >     | ../barchart/barchart.pl --extra-gnuplot=3D'set term dumb 140 30' \
> >          --extra-gnuplot=3D'set title "NBench score; higher is better"'=
 \
> >     | gnuplot
> >=20
> > Note that barchart is just a front-end for gnuplot >=3D5, so any valid =
term will
> > work (e.g. 'set term pngcairo size 1200,500').
> >=20
> > [1] https://github.com/cota/dbt-bench
> > [2] https://github.com/cota/barchart
> >=20
>=20
> Thanks, applied to my tracing tree:
> https://github.com/stefanha/qemu/commits/tracing

By the way, I applied your most recent version of this series today :).

Stefan

--0pkK7MCEo5hACTvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZK6EAAoJEJykq7OBq3PIsUIH/jtFbTQvcX3GhxnGwjryWFS+
YDoFURosezC80LJdqBy8sF9Q5YProMxfPicaSeB4Q0WK6WjExtxzr9b1FDj+dRZ2
DfSCOQROqgaYtIlTVDefYRze/wn65gSRT3hGVw1fHXyUDhBk/PpQvBs3CXTnrjk8
vKG8DD6hiQAY8oy89dWAPQ5/PnNbGV5520b4490vk77EcXt0lLtzLuSkXzON0Cqh
8dQyZv19LOSqVfbst40dIbYT8ZI31+ih3A8bHDZ7jzy3AZ34pYZ480afQJaTTEL9
Cg6AShx5efJMvrz6RvqvFXW+y4ZIqyNQripmFCYjvA2W4BIYM8NgFXvMckcpZs8=
=bI9L
-----END PGP SIGNATURE-----

--0pkK7MCEo5hACTvx--
