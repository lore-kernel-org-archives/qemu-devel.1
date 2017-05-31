Received: from eggs.gnu.org ([2001:4830:134:3::10]:58699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2yc-00034x-8n
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2yb-0005KG-Kb
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:43:50 -0400
Date: Wed, 31 May 2017 13:43:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531124341.GV16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-22-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3jK+0sHr6j/jwA0V"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-22-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 21/29] qed: Add return value to
 qed_aio_write_inplace/alloc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--3jK+0sHr6j/jwA0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:22:02PM +0200, Kevin Wolf wrote:
> Don't recurse into qed_aio_next_io() and qed_aio_complete() here, but
> just return an error code and let the caller handle it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 43 ++++++++++++++++++++-----------------------
>  1 file changed, 20 insertions(+), 23 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3jK+0sHr6j/jwA0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrp9AAoJEJykq7OBq3PIirYH/3298aqvWc83jLIWbfsDOoT/
UAlNrIi4PH+DX9YFEfYQIb41IMsMV7A5TPTkJb/Zgf3QX/1+JlaMOLrbpKZ9IPmQ
jxrIzfUaRTSuTVWPSB5+fznpcAgAD5JGPqgsmN7Hve7X8ZIu5Cfka6cZPjRVwqm/
+WfNvND0xGRKiDiN2tkxIg9qkB9RkN/zhUNcFuDkmUH+1/+84vbFq6mcISITp2G4
Gkgp0o1G4BIVxg+JBHBmf8VcdevK3cKJ1yHbROdOYGrqCtCRGpmiSCP7H6lsNSu8
8HET9hr67A9D/TXvtFqR41N6KYiQEhLC9kiPtOzZQNBIRjofAnAl+rYcM/5AFEw=
=KbXo
-----END PGP SIGNATURE-----

--3jK+0sHr6j/jwA0V--
