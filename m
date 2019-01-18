Received: from eggs.gnu.org ([209.51.188.92]:42986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkYw3-0005W3-Ue
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkYvw-0005PH-Ib
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:32:04 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:43273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkYvw-0005OX-0T
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:32:00 -0500
Received: by mail-ot1-x32e.google.com with SMTP id a11so15204353otr.10
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 10:31:59 -0800 (PST)
MIME-Version: 1.0
References: <1547732292-14021-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-q4T4B+rxZj+734W6K5R5jHB0AW2rFKDQKgwB_oacmVw@mail.gmail.com>
	<CAFEAcA-xfLEEW6qrcoHPsyxt1QGMwJ7ez_TKTTpUX1LA6zDFOw@mail.gmail.com>
	<408291c7-e4ba-d9a4-bfd6-cd27aebb7354@redhat.com>
In-Reply-To: <408291c7-e4ba-d9a4-bfd6-cd27aebb7354@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 18:31:47 +0000
Message-ID: <CAFEAcA9F3UTmWbwEQEdNtNcMFpn3i0t7sosAQk2dK6rEOk8U4A@mail.gmail.com>
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@163.com>, Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Fri, 18 Jan 2019 at 18:26, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 1/18/19 3:20 PM, Peter Maydell wrote:
> > I tried the "raise the timeout" change you suggested on IRC.
> > That gave me a pass the first time around but the same failure
> > second time I tried it:
> >
> > MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> > QTEST_QEMU_BINARY=3Di386-softmmu/qemu-system-i386
> > QTEST_QEMU_IMG=3Dqemu-img tests/ipmi-bt-test -m=3Dquick -k --tap <
> > /dev/null | ./scripts/tap-driver.pl --test-name=3D"ipmi-bt-test"
> > **
> > ERROR:tests/ipmi-bt-test.c:319:test_connect: assertion failed: (rv =3D=
=3D 1)
> > ERROR - too few tests run (expected 4, got 0)
> > [1]   Abort trap (core dumped) MALLOC_PERTURB_=3D... |
> >       Done(1)                 ./scripts/tap-dr...
> > /var/tmp/qemu-test.TATvqX/tests/Makefile.include:856: recipe for
> > target 'check-qtest-i386' failed
>
> I guess I finally figured it out, the test binds IPv4 and on the NetBSD
> VM, 'localhost' resolves as IPv6 so the guest can't connect to the test.

This theory doesn't explain why the test sometimes passes and
sometimes fails, though...

thanks
-- PMM
