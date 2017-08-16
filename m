Received: from eggs.gnu.org ([2001:4830:134:3::10]:58552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhtM9-0003wS-F4
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhtM4-0005FX-EB
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:07:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhtM4-0005F2-4p
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 04:07:08 -0400
Date: Wed, 16 Aug 2017 10:07:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170816100701.7848141a.cohuck@redhat.com>
In-Reply-To: <f0c15434-53cf-9721-8eb4-efc77dff33f8@redhat.com>
References: <1502721197-32717-1-git-send-email-mst@redhat.com>
	<20170814173335.58f0e84f.cohuck@redhat.com>
	<2f4dafd1-ba08-0f61-735a-31edefcff1e3@linaro.org>
	<f0c15434-53cf-9721-8eb4-efc77dff33f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: switch tests to accel=kvm:tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Tue, 15 Aug 2017 21:49:16 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 15.08.2017 17:47, Richard Henderson wrote:
> > On 08/14/2017 08:33 AM, Cornelia Huck wrote:  
> >> On Mon, 14 Aug 2017 17:34:15 +0300
> >> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >>  
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
> >>>  tests/boot-serial-test.c | 2 +-
> >>>  tests/pnv-xscom-test.c   | 4 ++--
> >>>  tests/prom-env-test.c    | 2 +-
> >>>  3 files changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> >>> index 11f48b0..c3b2e4e 100644
> >>> --- a/tests/boot-serial-test.c
> >>> +++ b/tests/boot-serial-test.c
> >>> @@ -78,7 +78,7 @@ static void test_machine(const void *data)
> >>>      fd = mkstemp(tmpname);
> >>>      g_assert(fd != -1);
> >>>  
> >>> -    args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
> >>> +    args = g_strdup_printf("-M %s,accel=kvm:tcg -chardev file,id=serial0,path=%s"
> >>>                             " -no-shutdown -serial chardev:serial0 %s",
> >>>                             test->machine, tmpname, test->extra);  
> >>
> >> This has already been changed upstream.  
> > 
> > Ouch.  This is the only real smoke test we have for the tcg backend for the
> > host.  While it is still going to test tcg for whatever machines do not run
> > natively on the host, I can't help think we've lost testing.  
> 
> Ah, well, I didn't think of that when I suggested to use "kvm:tcg"
> here... I rather thought that kvm would be preferable to speed up the
> test. But since the test is already quite fast anyway, it's likely also
> OK to use "tcg:kvm" here. (But we should keep "kvm:tcg" in the pxe-test
> since that is quite slow with TCG, at least on ppc64).

That all means to me that we need more documentation, at least some
comments.

Will there be a -rc4? I can send a patch that reverses the accelerators
and adds a comment today.
