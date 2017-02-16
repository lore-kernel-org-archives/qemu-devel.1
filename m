Received: from eggs.gnu.org ([2001:4830:134:3::10]:46324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ceOX5-0008Gd-VM
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ceOX5-0002o9-6j
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:03:47 -0500
Date: Thu, 16 Feb 2017 16:03:33 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170216160333.GA1022@stefanha-x1.localdomain>
References: <20170213181244.16297-1-pbonzini@redhat.com>
	<20170213181244.16297-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20170213181244.16297-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/6] coroutine-lock: make CoMutex
 thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 07:12:39PM +0100, Paolo Bonzini wrote:
> diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
> index 534807d..ada8c48 100644
> --- a/tests/test-aio-multithread.c
> +++ b/tests/test-aio-multithread.c
> @@ -196,6 +196,88 @@ static void test_multi_co_schedule_10(void)
>      test_multi_co_schedule(10);
>  }
> =20
> +/* CoMutex thread-safety.  */
> +
> +static uint32_t atomic_counter;
> +static uint32_t running;
> +static uint32_t counter;
> +static CoMutex comutex;
> +
> +static void test_multi_co_mutex_entry(void *opaque)

Minor nit: missing coroutine_fn.

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYpc1VAAoJEJykq7OBq3PIPD8H/iXUQy00yXW3896QILN23ys4
zGnwOxQ3uzp9kv3lXdpOgKjMArntdBvtT8l+9Xs7AXVw+aOPhNCM+VBPAmSRBIsR
y/LDzsD20zuof4FLnEXKD/5ig9BkhkW3xm2fgoCgMU5qvptgvFsRVElyMrl77c+e
ZBB59Omj9OcGMy1rJlp3aG0PQbA4cut8DofCu2juU0RiYsBgtrJPpv5YYYboo25e
55/7f9a2bRf+ebYjLmI1Twp+spJ8HkuSs6gs4tBbfvtclReWOPlcJgOpsffva726
BPSTtugIyTK93vtXbLhUN1uROtGTS0S2pflRSPUUuxqnMsiCnPAI6XA/4ajntQY=
=9cD6
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
