Received: from eggs.gnu.org ([209.51.188.92]:46339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@linaro.org>) id 1goQ8F-0006vx-Qn
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@linaro.org>) id 1goQ8D-000584-QK
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:56:39 -0500
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31]:45714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <christophe.lyon@linaro.org>)
	id 1goQ8B-0004zV-R0
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:56:35 -0500
Received: by mail-vs1-xe31.google.com with SMTP id x28so11573555vsh.12
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 01:56:22 -0800 (PST)
MIME-Version: 1.0
References: <154842501977.29408.13715859935418850955.malonedeb@soybean.canonical.com>
	<20190129025352.GB3264@stefanha-x1.localdomain>
In-Reply-To: <20190129025352.GB3264@stefanha-x1.localdomain>
From: Christophe Lyon <christophe.lyon@linaro.org>
Date: Tue, 29 Jan 2019 10:56:09 +0100
Message-ID: <CAKdteOZ1faQ9crPSR67RB_c6UvUgSfQW2u+mSrikkhjCqkk52Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1813305] [NEW] trace-root.h is not
 regerenerated after re-configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Bug 1813305 <1813305@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 29 Jan 2019 at 03:55, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Fri, Jan 25, 2019 at 02:03:39PM -0000, Christophe Lyon wrote:
> > I've just realized that after I reconfigured my qemu with
> > ../configure --target-list=arm-softmmu,arm-linux-user,aarch64-softmmu,aarch64-linux-user --enable-trace-backends=simple
> >
> > $ make
> > did rebuild some stuff for the 'simple' trace, but it did not update trace-root.h until after I
> > $ make clean
> >
> >
> > I took me while to understand why I didn't get the traces I wanted (my trace-root.h still thought it was configured for the default 'log').
> >
> > I didn't check how easy it is to fix this in the build system.
>
> Thank you for reporting this.  I have sent a patch to fix the makefile.
>

Thanks for the quick patch.

> Stefan
