Received: from eggs.gnu.org ([2001:4830:134:3::10]:54575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYZvt-0003V5-NW
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dYZvq-0002pN-JQ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:33:37 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dYZvq-0002p9-BG
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:33:34 -0400
Received: by mail-wm0-x231.google.com with SMTP id w126so15715022wme.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 08:33:34 -0700 (PDT)
Date: Fri, 21 Jul 2017 16:33:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170721153331.GL18014@stefanha-x1.localdomain>
References: <87o9so1hl7.fsf@dusky.pond.sub.org>
	<20170717103308.GI7163@stefanha-x1.localdomain>
	<8760epr9vw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bPg9NdpM9EETxvqt"
Content-Disposition: inline
In-Reply-To: <8760epr9vw.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Improving QMP test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <cleber@redhat.com>


--bPg9NdpM9EETxvqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 06:24:19PM +0200, Markus Armbruster wrote:
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > On Thu, Jul 13, 2017 at 05:28:52PM +0200, Markus Armbruster wrote:
> >> What can we do to improve QMP testing?  Sadly, I don't have the master
> >> plan ready.  I can tell people their new code needs to come with tests,
> >> but that won't help much unless subsystem maintainers pick up the habi=
t,
> >> too.  There are a few obvious tests to write for old code, such as a
> >> generic test of query-like commands without arguments and without side
> >> effects, similar to what test-hmp.c does for HMP command info (I hope =
to
> >> get around to that one).  But for much of the old code, we don't even
> >> know where the test coverage holes are.
> >>=20
> >> Ideas anyone?
> >
> > It makes sense for maintainers to ask that new QMP commands come with
> > comprehensive tests.
> >
> > For me the main question is how to begin?  What is the easiest and
> > preferred way to write QMP command test cases?
> >
> > Today the most common approach is a qtest test case that sends commands
> > and verifies that the expected response is returned.  This approach
> > works but we could benefit from a discussion about the alternatives
> > (e.g.  qemu-iotests style shell scripts with output diffing).
>=20
> Output testing style delegates checking ouput to diff.  I rather like it
> when text output is readily available.  It is when testing QMP.  A
> non-trivial example using this style could be useful, as discussing
> ideas tends to be more productive when they come with patches.

Yes, I was considering how many of the Python iotests could be rewritten
comfortably in shell.  It is nice when the test simply executes commands
and the output file shows the entire history of what happened.  Great
for debugging.

Stefan

--bPg9NdpM9EETxvqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZch7LAAoJEJykq7OBq3PIbH8H/A9QCh5YnBF9YoVQipPCk19q
kmYfCQLbg8pk675Xz3pN1R0eKJR1PrskYPs6NlwJudhbQjdjiuk9y8jmniDl+ctP
m/uFN1GqOGZ+Q5go24GbSGAJr9rclJNsqFpjGfg1l3Q2S6dBDsDeVMBuZxRcf8vm
gx7TQt3I9yXGZTC4LbGtuT5Qt3I9BhWAEyqUqWaeuuveaQgeyps8IXKxo6+tniF9
YwHhEBd5TAwI4IgTjqwx2qnhraEIT7Oy2fjqQ2UHJMVvbXJD7xyJeHk+H++3ofNn
df+qWuK+P2jp7Wrjbis+Id97VxyrONwbkosyuA2bxx7hlYmfLTTVl0g9INE42zw=
=SAYB
-----END PGP SIGNATURE-----

--bPg9NdpM9EETxvqt--
