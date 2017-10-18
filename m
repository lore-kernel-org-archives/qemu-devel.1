Received: from eggs.gnu.org ([2001:4830:134:3::10]:49995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e4q4j-0001Vt-JL
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e4q4g-00043X-Dj
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:16:05 -0400
Date: Wed, 18 Oct 2017 17:15:56 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171018151556.GA31848@stefanha-x1.localdomain>
References: <20171016202912.1117-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171016202912.1117-1-sw@weilnetz.de>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Fix compiler warning and some
 data types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On Mon, Oct 16, 2017 at 10:29:12PM +0200, Stefan Weil wrote:
> gcc warning:
>=20
> /qemu/util/oslib-posix.c:304:11: error:
>  variable =E2=80=98addr=E2=80=99 might be clobbered by =E2=80=98longjmp=
=E2=80=99 or =E2=80=98vfork=E2=80=99
>  [-Werror=3Dclobbered]
>=20
> Fix also some related data types:
>=20
> numpages, hpagesize are used as pointer offset.
> Always use size_t for them and also for the derived
> numpages_per_thread and size_per_thread.
>=20
> Avoid a type cast by declaring addr volatile.

I dropped this outdated line when merging the patch.

>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>=20
> v2: Fix more data types (partially as discussed with Richard)
>=20
> v3: Keep volatile type cast (suggested by Philippe and Paolo)
>=20
> Regards
> Stefan
>=20
>  util/oslib-posix.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan
