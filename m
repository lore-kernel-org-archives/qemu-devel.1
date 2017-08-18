Received: from eggs.gnu.org ([2001:4830:134:3::10]:49177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dijPg-0007ha-K8
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dijPd-0004lP-Ec
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:42:20 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dijPd-0004k7-7t
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:42:17 -0400
Received: by mail-wm0-x234.google.com with SMTP id l19so2861052wmi.1
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 08:42:16 -0700 (PDT)
Date: Fri, 18 Aug 2017 16:42:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170818154200.GC17654@stefanha-x1.localdomain>
References: <20170808203935.30021-1-ehabkost@redhat.com>
	<20170808203935.30021-2-ehabkost@redhat.com>
	<87o9rhp3gv.fsf@dusky.pond.sub.org>
	<20170815095607.GF9674@redhat.com>
	<20170815200646.GX3108@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <20170815200646.GX3108@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.11 v2 1/5] qmp-shell: Use optparse
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 05:06:46PM -0300, Eduardo Habkost wrote:
> On Tue, Aug 15, 2017 at 10:56:07AM +0100, Daniel P. Berrange wrote:
> > On Tue, Aug 15, 2017 at 11:47:28AM +0200, Markus Armbruster wrote:
> > > Eduardo Habkost <ehabkost@redhat.com> writes:
> > >=20
> > > > It makes command-line parsing and generation of help text much
> > > > simpler.
> > >=20
> > > There's really no excuse for parsing command line arguments by hand in
> > > Python.
> > >=20
> > > > The optparse module is deprecated since Python 2.7, but argparse
> > > > is not available in Python 2.6 (the minimum Python version
> > > > required for building QEMU).
> > >=20
> > > We have a few uses of argparse in the tree.  Are they okay?
> > >=20
> > > We also use getopt in places.  Perhaps we should pick one way to parse
> > > command lines and stick to it.
> >=20
> > I just came up against this problem with keycodemapdb which I'm adding =
as
> > a submodule to qemu.  I used argparse there because it is the modern
> > recommended API for python >=3D 2.7.   I examined possibilty of using
> > optparse instead, but it lacks key features - in particular the idea
> > of 'subcommands' is entirely missing from optparse.
> >=20
> > The 'argparse' module is part of python core, but is *also* available
> > as a standalone module that is implemented in terms of optparse.
> >=20
> > So, I would suggest that we just copy the 'argparse' module into the
> > QEMU 'scripts/thirdparty' directory.
> >=20
> > Then in any files which need argparse, you can do this
> >=20
> >   try:
> >       import argparse
> >   except:
> >       import os, sys
> >       sys.path.append(os.path.join(os.path.dirname(__file__), "thirdpar=
ty"))
> >       import argparse
>=20
> What about:
>=20
>   try:
>       import argparse
>   except:
>       from thirdparty import argparse
>=20
> (I think we could move all our Python modules [qemu.py, qmp.py]
> to ./scripts/qemu/, so this would become "qemu.thirdparty").
>=20
> >=20
> > so that it tries to use the argparse provided by python, and falls back
> > to pulling in the one in our scripts/thirdparty directory.
> >=20
> > When we finally bump our min python to 2.7, we can simply drop this
> > compat code for the import statement.  This avoids need for us to
> > re-write code to use a deprecated API, with a worse feature set.
>=20
> Sounds good to me.

Sounds good.

Stefan

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZlwrIAAoJEJykq7OBq3PIx3EH/22uyULZCOGC2gHxZuD9C3+i
GW7ngmQtLwLhUdjysqw5TPNrveAVq9Ck3UZeCh1UJeysW1+4fuPuQTCvTBAYCnht
H7oNDbsbyXtcPv5kJao2xdXcXIZdUscJeqjF9Prj8HtxjhIrTrt3nU9d0a+effIr
/HEWG70Uyx4Fk68tX0RginEhLYhOtVu0Zvx+ckmRMU9XcvtAW9gmhPtS1mXTePsW
I8NtD99fXOO5jahbe6puH8j33PqiuoWrCfI6UbBQBoCJ5h9WWo1gqhG93rpxa1YN
xNjAFWTAalSLhgT7woFPQCttMJAMQuKuehqmjO9j6HbXH2rI1QFDdoW+Jhxp1LY=
=dW+p
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
