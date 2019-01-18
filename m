Received: from eggs.gnu.org ([209.51.188.92]:44597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gkU7a-00035s-0e
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gkU7Y-00019G-R4
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:23:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gkU7Y-0000XX-Gb
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:23:40 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so15002937wrs.8
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 05:23:18 -0800 (PST)
MIME-Version: 1.0
References: <1547732292-14021-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-q4T4B+rxZj+734W6K5R5jHB0AW2rFKDQKgwB_oacmVw@mail.gmail.com>
	<adf15088-93e0-8cf5-988b-067afe39f6e1@redhat.com>
In-Reply-To: <adf15088-93e0-8cf5-988b-067afe39f6e1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 18 Jan 2019 14:23:06 +0100
Message-ID: <CAP+75-Xt-DvOZs5JLm5TB+iP=yCee4oVHZ5XvEt+sEU5E=LKiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/28] ivshmem deprecation, qtests,
 typedefs and gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@163.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Fri, Jan 18, 2019 at 2:15 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 1/18/19 12:47 PM, Peter Maydell wrote:
> > On Thu, 17 Jan 2019 at 13:38, Thomas Huth <thuth@redhat.com> wrote:
> >>
> >>  Hi Peter!
> >>
> >> The following changes since commit 6f2f34177a25bffd6fd92a05e6e66c8d22d=
97094:
> >>
> >>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault'=
 into staging (2019-01-15 18:32:57 +0000)
> >>
> >> are available in the git repository at:
> >>
> >>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-01-17
> >>
> >> for you to fetch changes up to 3f0832c85380321ef697d64342b389648f8abb1=
c:
> >>
> >>   tests/hexloader-test: Don't pass -nographic to the QEMU under test (=
2019-01-17 14:25:12 +0100)
> >>
> >> ----------------------------------------------------------------
> >> - Remove deprecated "ivshmem" legacy device
> >> - Bug fix for vhost-user-test
> >> - Use more CONFIG Makefile switches for qtests
> >> - Get rid of global_qtests in some more qtests
> >> - typedef cleanups
> >> - Fixes for compiling with Clang
> >> - Force C standard to gnu99
> >> ----------------------------------------------------------------
> >
> > In the netbsd VM, the ipmi-bt-test is consistently failing:
> >
> > MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> > QTEST_QEMU_BINARY=3Di386-softmmu
> > /qemu-system-i386 QTEST_QEMU_IMG=3Dqemu-img tests/ipmi-bt-test -m=3Dqui=
ck
> > -k --tap < /dev/null | ./s
> > cripts/tap-driver.pl --test-name=3D"ipmi-bt-test"
> > **
> > ERROR:tests/ipmi-bt-test.c:319:test_connect: assertion failed: (rv =3D=
=3D 1)
> > ERROR - too few tests run (expected 4, got 0)
> > [1]   Abort trap (core dumped) MALLOC_PERTURB_=3D... |
> >       Done(1)                 ./scripts/tap-dr...
> > /var/tmp/qemu-test.7opHvo/tests/Makefile.include:856: recipe for
> > target 'check-qtest-i386' faile
> > d
> > gmake: *** [check-qtest-i386] Error 1
> > gmake: *** Waiting for unfinished jobs....
> >
> >
> > This has been kind of intermittent for a while, I've seen
> > it on-and-off, but with this pullreq it's failed four times
> > in a row, so maybe something in here is making it less
> > intermittent.
>
> This file does:
>
>     qtest_add_func("/ipmi/extern/connect", test_connect);
>     qtest_add_func("/ipmi/extern/bt_base", test_bt_base);
>     qtest_add_func("/ipmi/extern/bt_enable_irq", test_enable_irq);
>     qtest_add_func("/ipmi/extern/bt_base_irq", test_bt_base);
>     ret =3D g_test_run();
>
> The first "test" test_connect() binds emu_lfd, the 2nd test
> test_bt_base() calls bt_cmd() which also use emu_lfd... could it be unbou=
nd?

I meant 'emu_fd' (not emu_lfd) in both cases.

> This is racy, since (from g_test_run() doc):
>
> "In general, the tests and sub-suites within each suite are run in the
> order in which they are defined. [...]
> However, you should never make the actual result of a test depend on the
> order that tests are run in. If you need to ensure that some particular
> code runs before or after a given test case, use g_test_add(), which
> lets you specify setup and teardown functions."
