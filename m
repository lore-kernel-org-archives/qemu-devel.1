Received: from eggs.gnu.org ([2001:4830:134:3::10]:59026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dYaDd-0000RA-Di
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dYaDb-000373-Vy
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:51:57 -0400
Date: Fri, 21 Jul 2017 16:51:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170721155146.GN18014@stefanha-x1.localdomain>
References: <20170721093416.17816-1-stefanha@redhat.com>
	<fb720b66-8b5f-bd84-2cb6-aa7d7d14b2db@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CaPKgh3XHpq3rEUV"
Content-Disposition: inline
In-Reply-To: <fb720b66-8b5f-bd84-2cb6-aa7d7d14b2db@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add a "how to" to ./README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, qemu-block@nongnu.org


--CaPKgh3XHpq3rEUV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 07:16:34AM -0500, Eric Blake wrote:
> On 07/21/2017 04:34 AM, Stefan Hajnoczi wrote:
> > There is not much getting started documentation for qemu-iotests.  This
> > patch explains how to create a new test and covers the overall testing
> > approach.
> >=20
> > Cc: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
>=20
> > +3. Assign groups to the test
> > +
> > +Add your test to the ./group file.  This file is the index of tests an=
d assigns
> > +them to functional groups like "rw" for read-write tests.  Most tests =
belong to
> > +the "rw" and "auto" groups.  "auto" means the test runs when ./check i=
s invoked
> > +without a -g argument.
> > +
> > +Consider adding your test to the "quick" group if it executes quickly =
(<1s).
>=20
> We have several tests going up to 5s (and I have a patch pending to
> remove two tests that took longer) - I think 1s is a bit on the short
> end for still classifying a test as quick.

I'm happy to accept any number blessed by Kevin.  I do think that 1
second is a safe maximum and no one should get in trouble for adding a
test that takes 1 second to the "quick" group.

> > +This group is run by "make check-block" and is often included as part =
of build
> > +tests in continuous integration systems.
>=20
> It would still be nice to have 'make check' run 'make check-block'...
> but that's independent of this patch.

Yes, there is a separate discussion about that on the list right now.
Hopefully it will be added back.

> > +Once you are happy with the test output it can be used as the golden m=
aster
> > +with "mv <test-number>.out.bad <test-number>.out".  Rerun the test to =
verify
> > +that it passes.
> > +
> > +Congratulations, you've created a new test!
>=20
> Maybe a reminder to 'git add' the new files, then submit the patch?

I thought about this too but decided not to get into the git and patch
submission business.  I carefully worded it to be about "creating" tests
rather than "adding" them to qemu.git because I wanted to limit the
scope of this README :).

Stefan

--CaPKgh3XHpq3rEUV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZciMSAAoJEJykq7OBq3PIpvoH/j83KWUjvfvyrJwEM457sbDu
bqrvwzU85I6swD1tpYnATWh+Aefz5E/e9smAYxysreobhIzYezlplTwf3FKF3pmx
dM4syMN34kDnbXSm+uEqnjLbnTs9w8UgjyEByIe6qBNQP9/b4h1zln8mwadqowsB
dh/jnQ0aF3IpBoXfEzujnfgx70ydNCg731yg5RUH/c/xUPejrnuKF4QGvl1XGEaf
pSOjFTHiis/qjnlxSkyNq8kqfB82+Rrtot3H+dj96HVtl/d3GJXOYRPTsITiGc2j
3xKXIuk7lPSs1Hn21Cj2o1tuIGEy8n0Vo8wjglsKiOEifvUdyWVPU5TLOOym2II=
=wTY2
-----END PGP SIGNATURE-----

--CaPKgh3XHpq3rEUV--
