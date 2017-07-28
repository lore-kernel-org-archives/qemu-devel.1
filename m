Received: from eggs.gnu.org ([2001:4830:134:3::10]:35973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db5X6-0002ln-O7
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1db5X3-0006St-PJ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:42:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1db5X3-0006Rj-GF
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:42:21 -0400
Date: Fri, 28 Jul 2017 14:42:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170728134218.GT12364@stefanha-x1.localdomain>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<87o9s88sb4.fsf@frigg.lan>
	<20170726112210.GD18489@stefanha-x1.localdomain>
	<871sp34bbc.fsf@frigg.lan>
	<20170727103253.GE10129@stefanha-x1.localdomain>
	<CAFEAcA-Da7ZV7SL41TShqiy=icgo_nJXJxBqRr=RO+M23JsrGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dBMBt2YGaTHbdllf"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Da7ZV7SL41TShqiy=icgo_nJXJxBqRr=RO+M23JsrGg@mail.gmail.com>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>


--dBMBt2YGaTHbdllf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 11:40:17AM +0100, Peter Maydell wrote:
> On 27 July 2017 at 11:32, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > On Wed, Jul 26, 2017 at 03:44:39PM +0300, Llu=EDs Vilanova wrote:
> >> And why exactly is this a threat? Because it can be used to "extend" Q=
EMU
> >> without touching its sources? Is this a realistic threat? (it's a rath=
er brittle
> >> way to do it, so I'm not sure it's practical)
> >
> > Unfortunately it is a problem.  I recently came across a product that
> > was using LD_PRELOAD=3D to "integrate" with QEMU.  People really abuse
> > these interfaces instead of integrating their features cleanly into
> > QEMU.
>=20
> ...if people who want to do this kind of thing already can and
> do use LD_PRELOAD for it, I don't think we should worry too much
> about trying to make the instrumentation plugin API bulletproof
> against similar abuse.
>=20
> > I see the use cases that Peter has been describing and am sure we can
> > come up with good solutions.  What I care about is that it doesn't allow
> > loading a .so that connects to arbitrary trace events.
>=20
> That said, I agree that we don't really need an arbitrary-trace-event
> setup here, and we should probably design our API so that it isn't
> handing the trace plugin hooks pointers into QEMU's internals.
> We want an API that makes it easy for people to do things based on
> changes of the guest binary's state (registers, insns, etc etc)
> and which makes it hard for them to accidentally trip themselves up
> (eg by prodding around in QEMU internal data structures).
> This will have the secondary benefit that it's unlikely that future
> changes to QEMU will break plugin code.
>=20
> >> As a side note, I find instrumentation to be most useful for guest cod=
e events,
> >> which mostly contain non-pointer values (except for the CPUState*).
>=20
> For instance we definitely should not be passing a CPUState* to
> any plugin function.

The gdbstub protocol has relevant features for accessing guest memory,
registers, etc.  Perhaps a set of QEMU-specific events can be added
(e.g. tb generated) so it's possible to instrument and control the
guest from an instrumentation program (written in any language).

Perhaps there is a fundamental reason why this isn't possible due to the
protocol design, because using gdbstub halts all vcpus, etc.  I don't
know.

Do you think this is an interesting direction?  It definitely seems like
a powerful approach though performance would be less than running native
code inside the QEMU process.

Stefan

--dBMBt2YGaTHbdllf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZez86AAoJEJykq7OBq3PI65sH+gO86XMBqeJQp5kfx5dKvkwS
+MTDZEqEHNUk5lwoK27DeA1nt3ALEdShC+kHKc1fkOqyA8XSLMzsWL35deQEsc82
5kqKBxGB74MpTaeqpmJnqFe3BD93L+TeOXNY1n+7G1CW/ni5wk1H7ywFumn9WHmS
7tbUSL/Ir992RjtJfr3dPPL/gugPEAewWMbKUh9WAp33fy9SLH3RurTYTzl7PSiD
gQlTEf/9XLtMzDMRagw2ghgs4ThY88ynvlzBHHDDJYKtruWln5G70rgDxKQbm6D9
/9oBxH6B78r2e6iTP0duhHP0lQhR1MpwJgzZhGAfxRASVNtdSj9+qcNOG20xW50=
=z/4J
-----END PGP SIGNATURE-----

--dBMBt2YGaTHbdllf--
