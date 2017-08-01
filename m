Received: from eggs.gnu.org ([2001:4830:134:3::10]:55226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcUNK-0001Wh-4C
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dcUNG-0005XT-Rv
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:26:06 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dcUNG-0005Wu-KL
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 06:26:02 -0400
Received: by mail-wm0-x233.google.com with SMTP id m85so10465447wma.0
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 03:26:02 -0700 (PDT)
Date: Tue, 1 Aug 2017 11:25:58 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170801102558.GH13521@stefanha-x1.localdomain>
References: <20170717103308.GI7163@stefanha-x1.localdomain>
	<8760epr9vw.fsf@dusky.pond.sub.org>
	<20170721153331.GL18014@stefanha-x1.localdomain>
	<026a093f-1f79-4af9-a5c9-d540342b472e@redhat.com>
	<8760eiuxu5.fsf@dusky.pond.sub.org>
	<9d4a3015-a3d2-e9d5-2254-0bcb77b37161@redhat.com>
	<871sp2gut9.fsf@dusky.pond.sub.org>
	<20170727091957.GC5117@lemon.lan>
	<20170727100958.GG2555@redhat.com>
	<20170727111652.GI5117@lemon.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xQmOcGOVkeO43v2v"
Content-Disposition: inline
In-Reply-To: <20170727111652.GI5117@lemon.lan>
Subject: Re: [Qemu-devel] Improving QMP test coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Cleber Rosa <cleber@redhat.com>, Amador Pahim <apahim@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>


--xQmOcGOVkeO43v2v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2017 at 07:16:52PM +0800, Fam Zheng wrote:
> On Thu, 07/27 11:09, Daniel P. Berrange wrote:
> > On Thu, Jul 27, 2017 at 05:19:57PM +0800, Fam Zheng wrote:
> > > On Thu, 07/27 10:14, Markus Armbruster wrote:
> > > > This brings some advantages of "verify output with diff" to tests t=
hat
> > > > verify with code.  Improvement if it simplifies the verification co=
de.
> > > >=20
> > > > I'd still prefer *no* verification code (by delegating the job to d=
iff)
> > > > for tests where I can get away wit it.
> > >=20
> > > Python based iotests can be (re)done in such a way that they print ac=
tual logs
> > > (interactions with qtest/monitor, stdout/stderr of QEMU, etc) instead=
 of the
> > > current dot dot dot summary, then we automatically have diff based ve=
rification,
> > > no?
> >=20
> > The python test 149 that I wrote does exactly that. There's no reason w=
hy
> > the others couldn't do the same.
>=20
> Yes, and IMO it should be the default and recommended way.

I agree.  It's something I embarked on but never finished a few years
ago.  I wanted to modify iotests.py to use logging and drop the unittest
framework.

Stefan

--xQmOcGOVkeO43v2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgFc2AAoJEJykq7OBq3PI6bUIAK7d/XiZTKqm37MBKqmljdF2
gLlyrqfTZfCRNvM7qUyd2wN37ZuIFQPPsmG2F6CDyy8Nn2vhEHGWkUxkkNYduDsB
MDyyT8SM5b11TTJUZv8qJtTMqcGYFMCDapFLq50qmE/tUGvw3PXdHPG29qoPzOhG
0zFRa+hS1iV0kVE4iIa00TKFgU3pT5tv19b+Qb0Y7Ypt63RwbFChJWcUMHjF5aMR
8d4LrdFfB7L/LLuMAmWaTIDAVMUmyFqPXA+KdptOLbE9A2Zh0oQCTKoQ0Ql6uu/r
atTs7WGCOXb4ymzKdqXULjSGLcA7Dux0okEIgZgSnDQXvPxYfRKR52qoB6wH4Hg=
=2axf
-----END PGP SIGNATURE-----

--xQmOcGOVkeO43v2v--
