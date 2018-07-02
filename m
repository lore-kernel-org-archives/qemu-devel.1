Received: from eggs.gnu.org ([2001:4830:134:3::10]:40207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa8f8-00046N-PX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa8f7-0005mw-Je
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:55:18 -0400
Received: from mail-vk0-x22e.google.com ([2607:f8b0:400c:c05::22e]:37744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fa8f7-0005mX-Dp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 19:55:17 -0400
Received: by mail-vk0-x22e.google.com with SMTP id h22-v6so82081vke.4
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 16:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180702135806.7087-1-shorne@gmail.com>
	<87y3et8xdn.fsf@linaro.org>
In-Reply-To: <87y3et8xdn.fsf@linaro.org>
From: Stafford Horne <shorne@gmail.com>
Date: Tue, 3 Jul 2018 08:55:04 +0900
Message-ID: <CAAfxs77L67ShYcmQ9TnCOAjVXqJZSZhCH-Xm8ghtwJ3puhEWMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/25] OpenRISC updates for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

Hello Alex,

On Tue, Jul 3, 2018, 12:34 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:

>
> Stafford Horne <shorne@gmail.com> writes:
>
> <snip>
> > ----------------------------------------------------------------
> > OpenRISC cleanups and Fixes for QEMU 3.0
>
> In the interests of getting the tests/tcg/openrisc stuff up and running
> again could you tell me if there are any distros that currently package
> the or1k compilers as cross compilers?
>

There are no distros, there is/was a copyright issue with the old gcc
toolchain.  However, that should be fixed now as I and Richard did a
cleanroom rewrite of the gcc backend for openrisc meaning we should be able
upstream after we sort out the last bugs.  I believe distros would be able
to pick it up after that.

Many of these fixes in this series were find during the compiler testing.

I use binaries I built here:

https://github.com/stffrdhrn/gcc/releases/tag/or1k-9.0.0-20180613

Perhaps you can use those?

Out of interest what do you develop/test on?
>

I test on Fedora 27 or so.  As mentioned above with my own toolchain.

-Stafford

>
