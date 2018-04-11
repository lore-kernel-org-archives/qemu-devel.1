Received: from eggs.gnu.org ([2001:4830:134:3::10]:45088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f6BFQ-0006tJ-Th
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f6BFN-0003Ch-1Z
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 04:36:56 -0400
Date: Wed, 11 Apr 2018 10:36:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180411103641.3b09ff33.cohuck@redhat.com>
In-Reply-To: <20180410193919.28026-21-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-21-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 20/24] tests/tcg: enable building for
 s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, famz@redhat.com, cota@braap.org, "open list:S390" <qemu-s390x@nongnu.org>

On Tue, 10 Apr 2018 20:39:15 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> This doesn't add any additional tests but enables building the
> multiarch tests for s390x.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/s390x/Makefile.include | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tests/tcg/s390x/Makefile.include
>=20
> diff --git a/tests/tcg/s390x/Makefile.include b/tests/tcg/s390x/Makefile.=
include
> new file mode 100644
> index 0000000000..1f58115d96
> --- /dev/null
> +++ b/tests/tcg/s390x/Makefile.include
> @@ -0,0 +1,2 @@
> +DOCKER_IMAGE=3Ddebian-s390x-cross
> +DOCKER_CROSS_COMPILER=3Ds390x-linux-gnu-gcc

Acked-by: Cornelia Huck <cohuck@redhat.com>
