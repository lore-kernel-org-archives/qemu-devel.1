Received: from eggs.gnu.org ([2001:4830:134:3::10]:38632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcuy5-00015g-TC
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcuy2-000575-OH
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:49:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dcuy2-000567-EO
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:49:46 -0400
Date: Wed, 2 Aug 2017 15:49:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170802144943.GF10101@stefanha-x1.localdomain>
References: <CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
	<20170728133430.GS12364@stefanha-x1.localdomain>
	<CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
	<20170728140623.GQ31495@redhat.com> <87vamclf6w.fsf@frigg.lan>
	<20170801134825.GC22017@stefanha-x1.localdomain>
	<CAFEAcA9KKqyiNfsfjSDVhhE7hMMsAZ==TuSjgtqb6pB=fVF+_w@mail.gmail.com>
	<20170802110400.GI5531@stefanha-x1.localdomain>
	<CAFEAcA82EBmOF3k=fXN4tAAL2=J6s8avUoQGXKrBwchh1rmMCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline
In-Reply-To: <CAFEAcA82EBmOF3k=fXN4tAAL2=J6s8avUoQGXKrBwchh1rmMCQ@mail.gmail.com>
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


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 12:10:14PM +0100, Peter Maydell wrote:
> On 2 August 2017 at 12:04, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > On Tue, Aug 01, 2017 at 02:54:29PM +0100, Peter Maydell wrote:
> >> and I don't need the TCG engine to be a library to do that...
> >
> > You do need TCG APIs if you want TCG-level instrumentation, tuning
> > options, callbacks, etc.
>=20
> I need an API; that doesn't necessarily look like the kind
> of API you want to be able to embed the TCG engine into
> other things, I think.
>=20
> >> I agree that we want to provide something that is at least
> >> closer to a stable API than "just expose trace events",
> >> though.
> >
> > libqemu has at least three parts:
> >
> > 1. VM API (i.e. qemu_init(argc, argv), qemu_run(), qemu_vcpu_get_reg32(=
))
> > 2. TCG engine
> > 3. Device models
> >
> > Like I said in my email, start with what matters for the instrumentation
> > use case (VM API at a minimum to control guest execution).  Other people
> > can flesh out the other parts later, as needed.
> >
> > Other attempts to provide a stable API will be essentially the same
> > thing as libqemu.
>=20
> I don't think this is the case -- you could have a stable
> instrumentation API without it looking anything like
> libqemu. In particular I don't think you need to have
> something that sits at the top level and says 'run'.
>=20
> In particular I think that pulling TCG out of QEMU
> is an enormous and painful undertaking that you just
> don't need to do at all to allow this kind of
> instrumentation API.

Please post an example of the API you'd like.

Stefan

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgeaHAAoJEJykq7OBq3PI4bUH/0Y169iPgjXYfEhIBJWmZ0De
jz3VrYH7dDFOcBOlImZkJjCcmSI0K4fTB4XTuTRNJPXdnfwTkEeLCEARrtNTRC7q
jE5m88bUhezPX61nQtkxnyAySjOfTZU5hagU2hU4r0GOIWIZYtwdBegkmX+i8YZj
m1BGe4DAtOzsD86COj7l5l+AC4mD5hL42pP7ALvNvLKrnfc7r3h8GSZj0OYSqK/l
YAXbtd6r6IxJB4t2C30WBuOT9sRJA0WP2xmrbMQgxUzJ5xIGsvnRhc1wuyt0ulN4
43H/VJ7+GTXpEC0yJjZjHhkpeTZFQTDggmcwdYH0/g3mjBP3mNdhcPpPVBhFNDw=
=BcT2
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
