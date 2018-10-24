Received: from eggs.gnu.org ([2001:4830:134:3::10]:34055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFL6E-0002Fq-Tk
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 11:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFL6D-0006yF-9y
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 11:29:34 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:38659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gFL6C-0006xT-Tp
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 11:29:33 -0400
Received: by mail-oi1-x22b.google.com with SMTP id k19-v6so4419100oiw.5
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 08:29:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4ad07cff.15b5b.166a5cab84c.Coremail.wj193102@163.com>
References: <4ad07cff.15b5b.166a5cab84c.Coremail.wj193102@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Oct 2018 16:29:09 +0100
Message-ID: <CAFEAcA9dC5acqJV4gjoaf=-mRK2H2gnzTORbfr90m+7_RnuUVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu3.0.0 use wine for the application of X86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wj193102 <wj193102@163.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 October 2018 at 12:16, wj193102 <wj193102@163.com> wrote:
> Hi=EF=BC=8Ceverybody=E3=80=82
> Now I have installed QEMU3.0.0. I want to launch wine by QEMU. But I can'=
t find qemu-runtime-i386-XXX.tar.gz and qemu-XXX-i386-wine.tar.gz on the QE=
MU web page.
> Please tell me how I can get them  and use the wine by QEMU? Thank you ve=
ry much.

I'm not sure what you think those tarballs are or why they
would be on the QEMU web page? If you've installed QEMU then
you should be able to run an i386 wine binary in it, like
any other guest binary, but we don't provide guest binaries.
We assume you already have those.

PS: try something simple first, like an "ls" binary, to
check your setup is working, before you try to get wine
running under QEMU.

PPS: do you really want i386 and not x86-64 ?

thanks
-- PMM
