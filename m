Received: from eggs.gnu.org ([2001:4830:134:3::10]:43425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZaGS-0002cx-RS
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZaGR-000847-KZ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:07:00 -0400
Date: Mon, 24 Jul 2017 11:06:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170724100646.GA12009@stefanha-x1.localdomain>
References: <20170721093416.17816-1-stefanha@redhat.com>
	<fb720b66-8b5f-bd84-2cb6-aa7d7d14b2db@redhat.com>
	<20170721155146.GN18014@stefanha-x1.localdomain>
	<0fd1f1b7-12e8-fc0b-96ce-4b3eee5b08af@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <0fd1f1b7-12e8-fc0b-96ce-4b3eee5b08af@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add a "how to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 23, 2017 at 11:18:50AM -0300, Philippe Mathieu-Daud=E9 wrote:
> On 07/21/2017 12:51 PM, Stefan Hajnoczi wrote:
> > On Fri, Jul 21, 2017 at 07:16:34AM -0500, Eric Blake wrote:
> > > On 07/21/2017 04:34 AM, Stefan Hajnoczi wrote:
> > > > There is not much getting started documentation for qemu-iotests.  =
This
> > > > patch explains how to create a new test and covers the overall test=
ing
> > > > approach.
> > > >=20
> > > > Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > ---
> > >=20
> > > > +3. Assign groups to the test
> > > > +
> > > > +Add your test to the ./group file.  This file is the index of test=
s and assigns
> > > > +them to functional groups like "rw" for read-write tests.  Most te=
sts belong to
> > > > +the "rw" and "auto" groups.  "auto" means the test runs when ./che=
ck is invoked
> > > > +without a -g argument.
> > > > +
> > > > +Consider adding your test to the "quick" group if it executes quic=
kly (<1s).
> > >=20
> > > We have several tests going up to 5s (and I have a patch pending to
> > > remove two tests that took longer) - I think 1s is a bit on the short
> > > end for still classifying a test as quick.
> >=20
> > I'm happy to accept any number blessed by Kevin.  I do think that 1
> > second is a safe maximum and no one should get in trouble for adding a
> > test that takes 1 second to the "quick" group.
> >=20
> > > > +This group is run by "make check-block" and is often included as p=
art of build
> > > > +tests in continuous integration systems.
> > >=20
> > > It would still be nice to have 'make check' run 'make check-block'...
> > > but that's independent of this patch.
> >=20
> > Yes, there is a separate discussion about that on the list right now.
> > Hopefully it will be added back.
> >=20
> > > > +Once you are happy with the test output it can be used as the gold=
en master
> > > > +with "mv <test-number>.out.bad <test-number>.out".  Rerun the test=
 to verify
> > > > +that it passes.
> > > > +
> > > > +Congratulations, you've created a new test!
> > >=20
> > > Maybe a reminder to 'git add' the new files, then submit the patch?
> >=20
> > I thought about this too but decided not to get into the git and patch
> > submission business.  I carefully worded it to be about "creating" tests
> > rather than "adding" them to qemu.git because I wanted to limit the
> > scope of this README :).
>=20
> Maybe something tiny like:
>=20
>   Congratulations, you've created a new test!
>=20
>   To share your test to upstream QEMU (highly recommended!) just follow
>   these recommendations: http://wiki.qemu.org/Contribute/SubmitAPatch

Sounds good.

Kevin: Any thoughts on this patch?

Stefan

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZdca1AAoJEJykq7OBq3PIlxwH/iB24CxO3oU977TOs8bZ4zg+
CE2zHd58x9AYhTFYcfaR6sIWoKdsILmX2mkyKOz9WlhDk04KqLBDActhmYToMIVm
rBP6jE0lsHFQEQVuB/u00D3szb6L2OQEqZg7uIBeUDm2KFgVgKUErvipieqclwcz
ybu2rZCc3xSlHlElt86jyHqhRn3ErnZ60jQz1REzOy0XFfdyqZ9MHA6Mez7gZXke
FXjXhp7JgroQQb532XThD3fxHfnHscvflcCS3Xcf5S6srU5VHO7LZ1jKbWkV01rY
KkLF6PrOo2a6bCgKRxeRwtkKQYkyKzXDFELFDFOn1ihZPepreQTJ8x3Xs1zpIms=
=CMBv
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
