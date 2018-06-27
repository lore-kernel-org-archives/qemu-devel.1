Received: from eggs.gnu.org ([2001:4830:134:3::10]:34782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY95M-0006ZZ-FK
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY95L-0002YJ-R3
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:58:08 -0400
Date: Wed, 27 Jun 2018 12:58:01 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627115801.GL5955@stefanha-x1.localdomain>
References: <20180626142434.22090-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y+Z5jE7Arku/2GrR"
Content-Disposition: inline
In-Reply-To: <20180626142434.22090-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] file-posix: Make
 truncate/preallocate asynchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--Y+Z5jE7Arku/2GrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 04:24:28PM +0200, Kevin Wolf wrote:
> This fixes the problem that blockdev-create on a local file blocks the
> main loop despite being a background job. This was caused by file-posix
> preallocating the image with blocking syscalls rather than moving this
> to the thread pool and yielding the coroutine meanwhile.
>=20
> v2:
> - Add locking to qcow2_co_discard()
> - Extra qcow2 fix and cleanup related to the locking code
> - Use tracked requests infrastructure for serialising I/O requests
>   against truncate in newly allocated areas

Looks good!

--Y+Z5jE7Arku/2GrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM3vJAAoJEJykq7OBq3PIsOMIALze/r6BL4w/4cMHxaI+2AiX
jQUNE8zKFdre4vS7vPEI2pvRy3tAJb+Mkjat1zWHSWb/C/RK4VjYHqP6czX5/XvM
npgZtMNCUs4f0NQRSbjgU5cs//lyscyLtMWe5c+rgcQcKoHze4vIbLtnAchnZLnc
fYapVe6e1+FLfipNAti2ILz4ske4H8+5M3YfWbx92HSnUdqPVcAoENganMlwDJ7T
nrFcLAE7DlUuVgoCkT65ynIFptxCiSzyG0gHt8Stsb4QlklTEknbApOlveq8/hcO
9Wd+Y/A92lx3IzSyub0ka+v4gdZLoZao4mIRtNglq+iUBivNfw7TXlBA559kZQA=
=MHpT
-----END PGP SIGNATURE-----

--Y+Z5jE7Arku/2GrR--
