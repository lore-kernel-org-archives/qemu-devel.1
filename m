Received: from eggs.gnu.org ([2001:4830:134:3::10]:54389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhhVj-0005x7-91
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhhVe-0007YX-6z
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:28:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dhhVe-0007Xw-0K
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 15:28:14 -0400
Date: Tue, 15 Aug 2017 22:28:11 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170815222611-mutt-send-email-mst@kernel.org>
References: <1502721197-32717-1-git-send-email-mst@redhat.com>
	<20170814173335.58f0e84f.cohuck@redhat.com>
	<2f4dafd1-ba08-0f61-735a-31edefcff1e3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f4dafd1-ba08-0f61-735a-31edefcff1e3@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] tests: switch tests to accel=kvm:tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Tue, Aug 15, 2017 at 08:47:35AM -0700, Richard Henderson wrote:
> On 08/14/2017 08:33 AM, Cornelia Huck wrote:
> > On Mon, 14 Aug 2017 17:34:15 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> >> Speed up tests on host systems with kvm support.
> >> In particular, this fixes tests with --disable-tcg.
> >>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Thomas Huth <thuth@redhat.com>
> >> Cc: Laurent Vivier <lvivier@redhat.com>
> >> Suggested-by: Cornelia Huck <cohuck@redhat.com>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> ---
> >>
> >> Tested on x86 only.
> >>
> >>  tests/boot-serial-test.c | 2 +-
> >>  tests/pnv-xscom-test.c   | 4 ++--
> >>  tests/prom-env-test.c    | 2 +-
> >>  3 files changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> >> index 11f48b0..c3b2e4e 100644
> >> --- a/tests/boot-serial-test.c
> >> +++ b/tests/boot-serial-test.c
> >> @@ -78,7 +78,7 @@ static void test_machine(const void *data)
> >>      fd = mkstemp(tmpname);
> >>      g_assert(fd != -1);
> >>  
> >> -    args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
> >> +    args = g_strdup_printf("-M %s,accel=kvm:tcg -chardev file,id=serial0,path=%s"
> >>                             " -no-shutdown -serial chardev:serial0 %s",
> >>                             test->machine, tmpname, test->extra);
> > 
> > This has already been changed upstream.
> 
> Ouch.  This is the only real smoke test we have for the tcg backend for the
> host.  While it is still going to test tcg for whatever machines do not run
> natively on the host, I can't help think we've lost testing.
> 
> Can we use accel=tcg:kvm instead?
> 
> 
> r~

We can add an environment to disable kvm on qemu side,
for e.g. CI systems who have spare time.

-- 
MST
