Received: from eggs.gnu.org ([209.51.188.92]:59465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj59H-0008AY-QB
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gj59F-0008Sv-Te
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:31:39 -0500
Date: Mon, 14 Jan 2019 16:31:17 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190114163117.GA521@stefanha-x1.localdomain>
References: <20190109110144.18633-1-stefanha@redhat.com>
	<w51pnt57slp.fsf@maestria.local.igalia.com>
	<w51tvifqqlr.fsf@maestria.local.igalia.com>
	<20190111132416.GI5010@dhcp-200-186.str.redhat.com>
	<w51pnt3qo27.fsf@maestria.local.igalia.com>
	<20190114133553.GE7038@stefanha-x1.localdomain>
	<w51won7480o.fsf@maestria.local.igalia.com>
	<20190114161525.GA32304@stefanha-x1.localdomain>
	<w51zhs32ojb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <w51zhs32ojb.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: fix restart coroutine
 iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 05:26:48PM +0100, Alberto Garcia wrote:
> On Mon 14 Jan 2019 05:15:25 PM CET, Stefan Hajnoczi wrote:
> >> > I've been able to reproduce this in an iotest, please see v2 of this
> >> > series.
> >>=20
> >> That iotest doesn't crash for me :-?
> >
> > Does my iotest pass for you?
>=20
> Yes, it does. I'm trying to figure out why because if I run the QMP
> commands by hand then it does crash.

I ran the iotest 20 times on my machine and it segfaulted every time
(with the fix not yet applied).

Stefan

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcPLlVAAoJEJykq7OBq3PI3WwIAKi9n3eEt29sxUiwIcZCw2tG
14IHtUFzOMgYWVCAzRHGQMx00MviMhdUWtKzSrjflV9q3hb8vCTqqCu7Q+v7HBvq
/lM4jdGq8R60tZoazobhqaXTYXO82zFMy9s+WwwE1YqrR2sENbwUNcdq5EgVAlcN
FXiWvHrPJoTrJhMJcNRDmWXV/s+Va0IgE6tj9MZs+g1Zt0qYD1VhWTfO8Ay6OCL5
1F6Ke4yZykQnsmw8eAzTMeXrr1YeF9/B2idNkTKwDSyqiTYF0E3s+X3++6fP/ETZ
cWP6UXfC3Y6cftk1nDoi07CjvQ8ycPWIRmPwosA71qi/tATaEzQeqwTYnrla0Aw=
=fKj6
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
