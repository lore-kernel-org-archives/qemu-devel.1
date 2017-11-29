Received: from eggs.gnu.org ([2001:4830:134:3::10]:57767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eK31e-00087h-6p
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eK31Y-0001Nk-3m
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:07:46 -0500
Date: Wed, 29 Nov 2017 14:07:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171129140737.GE4281@stefanha-x1.localdomain>
References: <20171129102513.9153-1-pbonzini@redhat.com>
	<20171129102513.9153-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline
In-Reply-To: <20171129102513.9153-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/4] blockjob: reimplement
 block_job_sleep_ns to allow cancellation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 11:25:13AM +0100, Paolo Bonzini wrote:
> This reverts the effects of commit 4afeffc857 ("blockjob: do not allow
> coroutine double entry or entry-after-completion", 2017-11-21)
>=20
> This fixed the symptom of a bug rather than the root cause. Canceling the
> wait on a sleeping blockjob coroutine is generally fine, we just need to
> make it work correctly across AioContexts.  To do so, use a QEMUTimer
> that calls block_job_enter.  Use a mutex to ensure that block_job_enter
> synchronizes correctly with block_job_sleep_ns.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c                   | 57 +++++++++++++++++++++++++++++++++++---=
------
>  include/block/blockjob.h     |  5 +++-
>  include/block/blockjob_int.h |  4 ++--
>  3 files changed, 52 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaHr8pAAoJEJykq7OBq3PI6u8H/1WTx4oPGrwuhDxI16ptLgHO
D+lDBpuFd0bCevOddcN1OyMvEU5AIrop3sbopelNxFvqQtKWIqV6e9lqev4zkw9o
o4ICIj3UWrVztQCJ589AytaHLIthEyOQ8CtMBOw21AtG8CXaxr20uKAX9CuPog4r
9akN3/5T47jJWB+fTK3euQ02+VhwyEZvN6EQi+EQ7IfitkdihQYBfmjj0ZW+hvs9
3IUnlrlhqmnARKkeXn5WDQ8uCH8ZwLNyYkcakYUN1cCbLsaI5aVzjZ0kZw6HuIoA
RHjsrmxIo2i1jx9xo6qCIC82VxFpRRzz4PXVIcuRINykoINAB9ZphHeDSLMjBso=
=icXJ
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
