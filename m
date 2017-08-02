Received: from eggs.gnu.org ([2001:4830:134:3::10]:38044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcrRe-0005CC-Sy
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 07:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcrRc-0002F5-88
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 07:04:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dcrRb-0002ER-VF
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 07:04:04 -0400
Date: Wed, 2 Aug 2017 12:04:00 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170802110400.GI5531@stefanha-x1.localdomain>
References: <CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
	<CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
	<20170728133430.GS12364@stefanha-x1.localdomain>
	<CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
	<20170728140623.GQ31495@redhat.com> <87vamclf6w.fsf@frigg.lan>
	<20170801134825.GC22017@stefanha-x1.localdomain>
	<CAFEAcA9KKqyiNfsfjSDVhhE7hMMsAZ==TuSjgtqb6pB=fVF+_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OfrWf2Fun5Ae4m0Y"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9KKqyiNfsfjSDVhhE7hMMsAZ==TuSjgtqb6pB=fVF+_w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 00/13] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Alessandro Di Federico <ale+qemu@clearmind.me>, "Daniel P. Berrange" <berrange@redhat.com>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>


--OfrWf2Fun5Ae4m0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2017 at 02:54:29PM +0100, Peter Maydell wrote:
> On 1 August 2017 at 14:48, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > Thanks for sharing the requirements.  A stable API is necessary for
> > providing these features.
> >
> > We're essentially talking about libqemu.  That means QEMU in library
> > form with an API for JIT engine, reverse engineering, instrumentation,
> > etc tasks.
>=20
> > Maintaining libqemu will take ongoing effort and no one has committed.
> > The last discussion about libqemu was here:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg04847.html
>=20
> That thread seems to be focused on trying to extract TCG
> from the rest of QEMU, which definitely isn't a requirement
> for instrumentation, and I would suggest is something
> of a distraction from it.

You are right, it's a different use case.  I just wanted to reference
previous discussion about libqemu.  There have been more in the past for
different use cases.

> I want to be able to say "just
> instrument this setup that QEMU already provides as a
> board model", not have to write a driver that duplicates
> all the work vl.c and our board models do for us today,

Calling qemu_init(argc, argv) and qemu_run() isn't too onerous.  For the
price of that you get an environment where we can offer stable APIs.

> and I don't need the TCG engine to be a library to do that...

You do need TCG APIs if you want TCG-level instrumentation, tuning
options, callbacks, etc.

> I agree that we want to provide something that is at least
> closer to a stable API than "just expose trace events",
> though.

libqemu has at least three parts:

1. VM API (i.e. qemu_init(argc, argv), qemu_run(), qemu_vcpu_get_reg32())
2. TCG engine
3. Device models

Like I said in my email, start with what matters for the instrumentation
use case (VM API at a minimum to control guest execution).  Other people
can flesh out the other parts later, as needed.

Other attempts to provide a stable API will be essentially the same
thing as libqemu.

Stefan

--OfrWf2Fun5Ae4m0Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgbGgAAoJEJykq7OBq3PIYrgH/R9hObn5r1yGjeNZlZBMJHZF
T3Jlr3zvo3gAUBLOpl57z1cqVfc6ub71zjf5kNJMfC5cwCwesn+OPcmARaUqkeiy
35p9poj9nJmsWoYfWN3ho/Dbr9xVf6Oo7CIHdB7Q7dnAvic4G9p21ulcbG5Z3cyK
5iGi6ffXjhBvKtzEWjDi2cxWXsrEc+f8LWm1s+YjPObCjTsWsmhmVkfzxuUFlIQT
//3JiLOtSOWz4EbXKDNtOxt46Ilcqef7VzAtvyOgLGYxGx4RjL5BNH06lhFvs52D
MD2WzArC7rVYmqa8DuZwROX711gs1fR61gOxjV/LVg2nz4zHjw6nyAeOEl1ZWWM=
=Mzju
-----END PGP SIGNATURE-----

--OfrWf2Fun5Ae4m0Y--
