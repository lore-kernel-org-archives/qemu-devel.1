Received: from eggs.gnu.org ([2001:4830:134:3::10]:44186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9RTU-0003Kp-PA
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9RTU-0008DN-1Y
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:32:56 -0400
Date: Fri, 20 Apr 2018 16:32:47 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420083247.GL15181@stefanha-x1.localdomain>
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9JSHP372f+2dzJ8X"
Content-Disposition: inline
In-Reply-To: <20180416165849.28864-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/9] block: BLK_PERM_WRITE
 includes ..._UNCHANGED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--9JSHP372f+2dzJ8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2018 at 06:58:42PM +0200, Max Reitz wrote:
> Currently we never actually check whether the WRITE_UNCHANGED
> permission has been taken for unchanging writes.  But the one check that
> is commented out checks both WRITE and WRITE_UNCHANGED; and considering
> that WRITE_UNCHANGED is already documented as being weaker then WRITE,

s/then/than/

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9JSHP372f+2dzJ8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJa2aWvAAoJEJykq7OBq3PIKpkH+MH66CKHUb00ePoai+nd1uQ8
T8Tt3x1Vr+juhp9kac2ZVZcOAECid7LSdI5V4SeiP1BiKmCNPaWWlrm+ZE4NH/cD
iQHIT5/NVxRqCp9DAu/qXEq27GTqnNzB1tjEdXityPmS8x71BoluDRSqo5KUGmpd
r/5E6s1zN5NH8yKotp7tQG6clolKeGXP9YD7xaO6hdddTPWNRqY1xE7loKvCRAZ8
vHoLUOz3fRHNrwFq0oXohW/Mt7hViBe8W33fCHwhdXHfi9+AwYLkziwY2iSK1sKA
YrXochr745lo83tiUotwIsYy0fQdrrJZvSHVhPEUnhl7j+pNqLNOVqpJxQYPoA==
=u4B2
-----END PGP SIGNATURE-----

--9JSHP372f+2dzJ8X--
