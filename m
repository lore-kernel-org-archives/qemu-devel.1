Received: from eggs.gnu.org ([2001:4830:134:3::10]:57883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duIsi-0001Dr-Rt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1duIsi-0005GG-0V
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:48:08 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:47555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1duIsh-0005Fy-Q4
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:48:07 -0400
Received: by mail-wm0-x229.google.com with SMTP id 13so76224wmq.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 06:48:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170919124440.30017-1-pbonzini@redhat.com>
References: <20170919124440.30017-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Sep 2017 14:47:45 +0100
Message-ID: <CAFEAcA-PffxsdgohV3nO=bPW+ACVEAAExZoCha5eDiaR2w5O1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/50] Misc patches for 2017-09-19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 September 2017 at 13:44, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 11e06ce1ed28fd0ffcbc1e2436b72f3412b4ecc8:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2017-09-19 10:13:51 +0100)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 793d286eab5c6eedf68667a081f676a0323210b2:
>
>   docker: fix creation of archives (2017-09-19 14:43:11 +0200)
>
> ----------------------------------------------------------------

Hi. This fails to link tests/ptimer_test on OSX:

  LINK    tests/ptimer-test
duplicate symbol _qemu_bh_delete in:
    tests/ptimer-test-stubs.o
    libqemuutil.a(async.o)
duplicate symbol _qemu_clock_get_ns in:
    tests/ptimer-test-stubs.o
    libqemuutil.a(qemu-timer.o)
duplicate symbol _timer_init_tl in:
    tests/ptimer-test-stubs.o
    libqemuutil.a(qemu-timer.o)
duplicate symbol _qemu_clock_deadline_ns_all in:
    tests/ptimer-test-stubs.o
    libqemuutil.a(qemu-timer.o)
duplicate symbol _timer_del in:
    tests/ptimer-test-stubs.o
    libqemuutil.a(qemu-timer.o)
duplicate symbol _main_loop_tlg in:
    tests/ptimer-test-stubs.o
    libqemuutil.a(qemu-timer.o)
duplicate symbol _timer_mod in:
    tests/ptimer-test-stubs.o
    libqemuutil.a(qemu-timer.o)
duplicate symbol _qemu_bh_new in:
    tests/ptimer-test-stubs.o
    libqemuutil.a(main-loop.o)
ld: 8 duplicate symbols for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)

(I'll leave the rest of the merge tests running to see if they
find anything else.)

thanks
-- PMM
