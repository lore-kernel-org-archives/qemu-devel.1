Received: from eggs.gnu.org ([2001:4830:134:3::10]:57537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhtJM-0002O0-NK
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhtJH-0002Jd-PI
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:04:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhtJH-0002JS-FW
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:04:15 -0400
Date: Wed, 16 Aug 2017 10:04:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170816100407.75c8cf4b.cohuck@redhat.com>
In-Reply-To: <f6da168f-2d33-55e9-1b52-3ede15a7f5c1@amsat.org>
References: <1502721197-32717-1-git-send-email-mst@redhat.com>
	<20170814173335.58f0e84f.cohuck@redhat.com>
	<2f4dafd1-ba08-0f61-735a-31edefcff1e3@linaro.org>
	<f6da168f-2d33-55e9-1b52-3ede15a7f5c1@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: switch tests to accel=kvm:tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Tue, 15 Aug 2017 17:04:35 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 08/15/2017 12:47 PM, Richard Henderson wrote:
> > On 08/14/2017 08:33 AM, Cornelia Huck wrote: =20
> >> On Mon, 14 Aug 2017 17:34:15 +0300
> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> =20
> >>> Speed up tests on host systems with kvm support.
> >>> In particular, this fixes tests with --disable-tcg.
> >>>
> >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>> Cc: Thomas Huth <thuth@redhat.com>
> >>> Cc: Laurent Vivier <lvivier@redhat.com>
> >>> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> >>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>> ---
> >>>
> >>> Tested on x86 only.
> >>>
> >>>   tests/boot-serial-test.c | 2 +-
> >>>   tests/pnv-xscom-test.c   | 4 ++--
> >>>   tests/prom-env-test.c    | 2 +-
> >>>   3 files changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> >>> index 11f48b0..c3b2e4e 100644
> >>> --- a/tests/boot-serial-test.c
> >>> +++ b/tests/boot-serial-test.c
> >>> @@ -78,7 +78,7 @@ static void test_machine(const void *data)
> >>>       fd =3D mkstemp(tmpname);
> >>>       g_assert(fd !=3D -1);
> >>>  =20
> >>> -    args =3D g_strdup_printf("-M %s,accel=3Dtcg -chardev file,id=3Ds=
erial0,path=3D%s"
> >>> +    args =3D g_strdup_printf("-M %s,accel=3Dkvm:tcg -chardev file,id=
=3Dserial0,path=3D%s"
> >>>                              " -no-shutdown -serial chardev:serial0 %=
s",
> >>>                              test->machine, tmpname, test->extra); =20
> >>
> >> This has already been changed upstream. =20
> >=20
> > Ouch.  This is the only real smoke test we have for the tcg backend for=
 the
> > host.  While it is still going to test tcg for whatever machines do not=
 run
> > natively on the host, I can't help think we've lost testing.
> >=20
> > Can we use accel=3Dtcg:kvm instead? =20
>=20
> can we use the following in this test main()?
>=20
> /* This test is fast fast enough to use to test the host TCG backend,
>   * so use "tcg" as default accel if available. */
> #ifdef CONFIG_TCG
> static const char *accel =3D "tcg";
> #else
> static const char *accel =3D "kvm";
> #endif

accel=3Dtcg:kvm should already have the same effect, no?

(But adding a comment may be a good idea.)
