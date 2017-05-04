Received: from eggs.gnu.org ([2001:4830:134:3::10]:33183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6EOJ-0003h4-VF
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6EOF-00014X-3U
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:53:48 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1d6EOE-00013z-Rv
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:53:43 -0400
Received: by mail-wm0-x244.google.com with SMTP id u65so2450951wmu.3
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 03:53:42 -0700 (PDT)
Date: Thu, 4 May 2017 11:53:39 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504105339.GB32376@stefanha-x1.localdomain>
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <20170419144219.20371-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/11] blockjob: introduce
 block_job_cancel_async, check iostatus invariants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 04:42:15PM +0200, Paolo Bonzini wrote:
> The new functions helps respecting the invariant that the coroutine
> is entered with false user_resume, zero pause count and no error
> recorded in the iostatus.
>=20
> Resetting the iostatus is now common to all of block_job_cancel_async,
> block_job_user_resume and block_job_iostatus_reset, albeit with slight
> differences:
>=20
> - block_job_cancel_async resets the iostatus, and resumes the job if
> there was an error, but the coroutine is not restarted immediately.
> For example the caller may continue with a call to block_job_finish_sync.
>=20
> - block_job_user_resume resets the iostatus.  It wants to resume the job
> unconditionally, even if there was no error.
>=20
> - block_job_iostatus_reset doesn't resume the job at all.  Maybe that's
> a bug but it should be fixed separately.
>=20
> block_job_iostatus_reset does the least common denominator, so add some
> checking but otherwise leave it as the entry point for resetting the
> iostatus.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: rewritten
>=20
>  blockjob.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCwgzAAoJEJykq7OBq3PIyR0IAJ+fQg8k2grgfamG7tVC287f
BWewAwHcq6fSVPhlaDLTvI6G/JcLYLkt1AmShjVgK4yXJPYTHa3e6ezjTmZ1qTsj
qJvZOoTG8kQKcP33X8hcZu4UX9/T9kRtQZFVl2C2jtx8AKRxNeCY1NnqjVkbL7cW
rTBcIh2HLbdnragyY/FLP8obvtr6wYso0kkiS/zDJU7XEa11+F8eIGKf2QPxWcDl
vSIcr/QRL1Wp1ZlVraw+2YQ69zS/S/8jEuW9bIGk9mSMnkF5kULOLz/80o4Ypzj2
lA7k2N492mGdJQ2xebxjPzB7KdeQIvC3qfr1yeUTYv2PIQfWLb9sXSCnsnjk+CU=
=Og3w
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
