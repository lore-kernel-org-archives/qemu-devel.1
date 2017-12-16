Received: from eggs.gnu.org ([2001:4830:134:3::10]:55639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQ8V8-0002rz-9w
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQ8V3-00064O-7G
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:11:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQ8V3-000641-0w
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 04:11:17 -0500
Date: Sat, 16 Dec 2017 09:11:08 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171216091108.GB12533@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-16-peterx@redhat.com>
	<20171213184358.GF8317@stefanha-x1.localdomain>
	<20171216061211.GC22308@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <20171216061211.GC22308@xz-mi>
Subject: Re: [Qemu-devel] [RFC v5 15/26] monitor: let suspend_cnt be thread
 safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2017 at 02:12:11PM +0800, Peter Xu wrote:
> On Wed, Dec 13, 2017 at 06:43:58PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Dec 05, 2017 at 01:51:49PM +0800, Peter Xu wrote:
> > > Monitor code now can be run in more than one thread.  Let it be thread
> > > safe when accessing suspend_cnt counter.
> >=20
> > Please add doc comments to the functions explaining which thread they
> > may be called from (especially public functions).  Without this
> > information other people will have a hard time keeping code thread-safe.
>=20
> The two public functions would be monitor_resume() and
> monitor_suspend().  IIUC as long as these functions are using atomic
> operations correctly they should be able to be called anywhere?
>=20
> Could you help point out what I missed?

I don't mean just the public functions.  How are other people supposed
to know which monitor function executes in which thread without first
studying all the monitor code?  This is where comments, naming schemes,
or grouping functions helps.

Not every function needs to be documented in detail, but there needs to
be some structure to help people understand what happens in the IOThread
and what happens in the main loop.

Just adding threading to the existing code without leaving clues for
people who come after you is likely to result in future bugs.

Stefan

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaNOMrAAoJEJykq7OBq3PIDF8H/2XG26psh2LzL0+Hdcp7pGNS
oOxswevu6rhVRPEVmrEseFWmmmqLHPE3BY9ly0s9Gcc4E4bPgSUoHUGokU0FMUZ/
3X0KutBO0pIN2FmP+fBtPAQVwNuWVX7tPiAGWMWlULyylD11iMvKxekYVAkuPSBs
lox6JlvFPKRMhZRMIFvSwUYbv7+ZH9G4BKjxhkGUyaHNWR+S6XXjFM9m4uUCOSzd
0DHywNLUWxbzctgR0di59Lid0UCtova2MD1txSr1u5BVf2xntRg51qzjBmT40pEj
GREqoef1UAhUPXq8Gb4yHiHXCqFMKXztu4X56uEMapkf3PG4WdQPSRyFHYcTOMs=
=XEed
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
