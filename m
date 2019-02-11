Received: from eggs.gnu.org ([209.51.188.92]:38891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gtE63-0004T5-VA
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gtE62-0005Q5-Qr
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:06:15 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:38414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gtE61-0005OQ-Uk
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:06:14 -0500
Received: by mail-wr1-f46.google.com with SMTP id v13so5334078wrw.5
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 08:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20190205170510.21984-1-peter.maydell@linaro.org>
	<20190205170510.21984-12-peter.maydell@linaro.org>
	<CAP+75-Xsn5VvHLung5V03YZLQOiqP+VSugzj6d2c3ovkyKsCKw@mail.gmail.com>
	<874l9awbv1.fsf@zen.linaroharston>
In-Reply-To: <874l9awbv1.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 11 Feb 2019 17:05:59 +0100
Message-ID: <CAP+75-VzXey7M3RDLA1W7=RcjcXw5noS6rR6Es_YQ_762JpD3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 11/22] tests/tcg/aarch64: Add pauth smoke
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Mon, Feb 11, 2019 at 5:04 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> >
> > Travis-CI is getting an error with this test:
> >
> > tests/docker/docker.py cc --user 2000 --cc aarch64-linux-gnu-gcc -i
> > qemu:debian-arm64-cross -s . --   -Wall -O0 -g -fno-strict-aliasing
> > tests/tcg/aarch64/pauth-1.c -o pauth-1  -static
> > /tmp/ccHrAqV2.s: Assembler messages:
> > /tmp/ccHrAqV2.s:7: Error: unknown architecture `armv8.4-a'
> > /tmp/ccHrAqV2.s:41: Error: selected processor does not support `pacdza =
x0'
> > /tmp/ccHrAqV2.s:56: Error: selected processor does not support `pacdza =
x0'
> > tests/tcg/Makefile:79: recipe for target 'pauth-1' failed
> > make[2]: *** [pauth-1] Error 1
> > make[2]: Leaving directory 'aarch64-linux-user/tests'
> > tests/tcg/Makefile.include:52: recipe for target
> > 'docker-build-guest-tests' failed
> > make[1]: *** [docker-build-guest-tests] Error 2
> > make[1]: Leaving directory 'aarch64-linux-user'
> > tests/Makefile.include:1030: recipe for target
> > 'build-tcg-tests-aarch64-linux-user' failed
> > make: *** [build-tcg-tests-aarch64-linux-user] Error 2
>
> The fix for that is in my latest PR.

Thanks Alex!
