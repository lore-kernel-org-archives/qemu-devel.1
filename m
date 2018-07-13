Received: from eggs.gnu.org ([2001:4830:134:3::10]:53653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fdyWD-00005X-43
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fdyWC-00065N-As
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:53:57 -0400
Date: Fri, 13 Jul 2018 14:53:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180713135346.GD13835@stefanha-x1.localdomain>
References: <20180709154549.7df475b9.cohuck@redhat.com>
	<20180711130617.GH31228@stefanha-x1.localdomain>
	<20180711151545.7e55234a.cohuck@redhat.com>
	<20180711153321.15d2237a.cohuck@redhat.com>
	<20180712163014.GB23738@stefanha-x1.localdomain>
	<eb3dd1ec-a420-1ede-d42a-4a01c8e9892f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline
In-Reply-To: <eb3dd1ec-a420-1ede-d42a-4a01c8e9892f@redhat.com>
Subject: Re: [Qemu-devel] qemu-nbd vs 'simple' trace backend vs iotest 147
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 13, 2018 at 08:40:19AM +0200, Paolo Bonzini wrote:
> On 12/07/2018 18:30, Stefan Hajnoczi wrote:
> > On Wed, Jul 11, 2018 at 03:33:21PM +0200, Cornelia Huck wrote:
> >> The other qemu-nbds (the inet and the unix socket ones from the first
> >> run, the second inet one from the second run) have a single thread with
> >> the same backtrace I posted above.
> >=20
> > We just discussed this on IRC, but for the record:
> >=20
> > qemu-nbd --fork will fork the process after the simpletrace write-out
> > thread has been spawned.  The child process lacks this thread (due to
> > how fork(2) handles multithreading).  Either qemu-nbd needs to
> > initialize tracing later (but that means we cannot trace early init) or
> > simpletrace needs a way to respawn the write-out thread.
>=20
> You can use pthread_atfork for this.

Thanks.  The man page says:

  The intent of  pthread_atfork()  was  to provide  a  mechanism
  whereby  the application (or a library) could ensure that mutexes and
  other process and thread state would be restored to a consistent
  state.  In practice, this task is generally too difficult to be
  practicable.

Challenge accepted!

Stefan

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbSK7qAAoJEJykq7OBq3PIHU8H/2jz+o6L/go7thJjDOEQueWT
Q/xWr/+WSM4SW85CTlEWSSbHhV9y6wW5feQaBquxdQIBjGRvzgbfj426ioIuDj6c
9iCV9s/SdPyqDH8zp5kF7ONP9S2pt1YtujsvWNV0wjnoEiv8sropSs43PoGLQf2m
sxA/9oWmzrr+nsG/f6vDqWK0pFnCeECpQRiUf060F75CLJwDqZi/uUi3GV6+iiKR
nS/h5dbJ4rEXYvOXT7zTCH9c7hZopKNdg+A7JTRRmY9vEJd8j6QybR0hvHFOiNi7
lnntkZCzklzBW5VbPJ2me9K6zo3KsJObg8yB7jd3HIlgfPOJ6XCig14r80PjkWA=
=3s2w
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
