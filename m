Received: from eggs.gnu.org ([209.51.188.92]:39105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h1Dxs-0004C4-2s
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h1Dxr-00037v-Di
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:34:52 -0500
Date: Tue, 5 Mar 2019 17:25:13 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190305172513.GC13806@stefanha-x1.localdomain>
References: <1551457277-884-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Content-Disposition: inline
In-Reply-To: <1551457277-884-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Do not use "\n" in g_test_message()
 strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 05:21:17PM +0100, Thomas Huth wrote:
> g_test_message() takes care of the newline on its own, so we
> should not use \n in the strings here.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/ivshmem-test.c         |  4 ++--
>  tests/m48t59-test.c          |  4 ++--
>  tests/migration-test.c       |  4 ++--
>  tests/rtc-test.c             |  4 ++--
>  tests/rtl8139-test.c         |  6 +++---
>  tests/test-aio-multithread.c |  8 ++++----
>  tests/test-coroutine.c       | 10 ++++------
>  tests/vhost-user-test.c      | 14 +++++++-------
>  8 files changed, 26 insertions(+), 28 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcfrD5AAoJEJykq7OBq3PIGpYH/ikCAYAW4TOKAQt42VCeUXq4
W4isCPukg2LBEthp8ArGT5kwAek08F9w8tHQZuETFjcp2hxU+nZcESOPfsDetEXj
QpPjV/0rOwQsfrwpSs68tUPBbPLt95H8vLHaxk7TuhIOKJW52u1mce84Ixf3qe/z
ohI9WTcZ2PywVMtYH23yq/7znjXgWvQnSXZiqW3UYqWbhbAzALWIF0BaFWpSZc7E
s2ax8p6mSlHVnZLaFu4cyKxtiorQZsaizrYtT5Fo36tNoqVIgN6FfqBU0MRtFc65
UwCgdhyD8nkgX5FVwDCDmbAWhKWEroltDzsuF0rM75kYGHTvKN39lqrtx1EBYIg=
=w0Cp
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
