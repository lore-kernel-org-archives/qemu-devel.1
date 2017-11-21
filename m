Received: from eggs.gnu.org ([2001:4830:134:3::10]:59933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7IZ-0001H6-TZ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7IQ-0008Kc-Dy
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:07 -0500
Date: Tue, 21 Nov 2017 10:17:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171121101734.GC23759@stefanha-x1.localdomain>
References: <cover.1511145863.git.jcody@redhat.com>
	<0c039d00e03331d863ee249810d9778313670803.1511145863.git.jcody@redhat.com>
	<20171120114334.GD4516@stefanha-x1.localdomain>
	<20171120134521.GB32161@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <20171120134521.GB32161@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/5] coroutines: abort if we
 try to enter a still-sleeping coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2017 at 08:45:21AM -0500, Jeff Cody wrote:
> On Mon, Nov 20, 2017 at 11:43:34AM +0000, Stefan Hajnoczi wrote:
> > On Sun, Nov 19, 2017 at 09:46:44PM -0500, Jeff Cody wrote:
> > BTW an alternative to adding individual bools is to implement a finite
> > state machine for the entire coroutine lifecycle.  A single function can
> > validate all state transitions:
> >=20
> >   void check_state_transition(CoState old, CoState new,
> >                               const char *action)
> >   {
> >       const char *errmsg =3D fsm[old][new];
> >       if (!errmsg) {
> >           return; /* valid transition! */
> >       }
> >=20
> >       fprintf(stderr, "Cannot %s coroutine from %s state\n",
> >               action, state_name[old]);
> >       abort();
> >   }
> >=20
> > Specifying fsm[][] forces us to think through all possible state
> > transitions.  This approach is proactive whereas adding bool flags is
> > reactive since it only covers a subset of states that were encountered
> > after crashes.  I'm not sure if it's worth it though :).
>=20
> Interesting idea; maybe more for 2.12 instead of 2.11, though?

Sure.

Stefan

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaE/0+AAoJEJykq7OBq3PIyHwH/3nxY4xdZcwL22F3MyxN5W51
G/WTdyW42O1BN8djBkEJwWO5yxQOeYUvLo41jsnLQm7GBLzw/I2xZqhdJOGQCG7Y
l7mv3/JgLKqUb7LjwrrgJDU6LTXvxu0jYGWLgbdrltC7Oqu7Gl6j/ez6TzwE6X32
SuY8Pciv+neiU73L4POAWDfwkrtZUQdBSrNNompY+tD9VnwaeQ5lV9kXlpB+caT+
szb1O685lrrRIhfY1j6Yd0zR0fQ/+cWOO7LqjND7Kqiu9cg4x+vv407RLdmICYlE
LThwz/5GexU6QpJTaNAN35ZiQ7j6TPDLxoMpGIIBxq/9QnFCf3KLV/iktRTZVD4=
=gAnk
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
