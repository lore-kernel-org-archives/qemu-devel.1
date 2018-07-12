Received: from eggs.gnu.org ([2001:4830:134:3::10]:55789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fdeU3-0003uk-HG
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fdeU2-0004LP-7g
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 12:30:23 -0400
Date: Thu, 12 Jul 2018 17:30:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180712163014.GB23738@stefanha-x1.localdomain>
References: <20180709154549.7df475b9.cohuck@redhat.com>
	<20180711130617.GH31228@stefanha-x1.localdomain>
	<20180711151545.7e55234a.cohuck@redhat.com>
	<20180711153321.15d2237a.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <20180711153321.15d2237a.cohuck@redhat.com>
Subject: Re: [Qemu-devel] qemu-nbd vs 'simple' trace backend vs iotest 147
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 11, 2018 at 03:33:21PM +0200, Cornelia Huck wrote:
> The other qemu-nbds (the inet and the unix socket ones from the first
> run, the second inet one from the second run) have a single thread with
> the same backtrace I posted above.

We just discussed this on IRC, but for the record:

qemu-nbd --fork will fork the process after the simpletrace write-out
thread has been spawned.  The child process lacks this thread (due to
how fork(2) handles multithreading).  Either qemu-nbd needs to
initialize tracing later (but that means we cannot trace early init) or
simpletrace needs a way to respawn the write-out thread.

I have put this on my TODO list but I'm not sure how soon I'll get
around to it.

Stefan

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbR4IWAAoJEJykq7OBq3PIxksIAJpCeY2PIULfwY46Aeke93n8
pGTwOssYOhPd2hbIv6Hgjs6TMz6+gCyjKrNGs+XVaSKwbt7bOjPqVudFP8JFib2R
toKZjYpqCnU+egrKP0QBaMEOJqvmlbnPt5p9z0UJHQM3wTqOMznLQigfQiU+IpGa
QN7b0hJiYkhbHGvrH2JaDGM876ohnpyG3sLQROJ6zFwCl7r399E3/axF4zGrBjnW
dZFmqa0nQDdTBUS5/eg1qbaXnhC++Z+E/f8nhPQafWovcxKx/GbVK+lDKb4l/nF4
luXOCRCB1d443yF8MpxOk0N5j40VGN4Jnfc+JcABimRyL/CopqJ+6LcGBLc/5FU=
=xglf
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
