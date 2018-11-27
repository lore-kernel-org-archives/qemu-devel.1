Received: from eggs.gnu.org ([2001:4830:134:3::10]:55102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRbTa-0002g3-Oz
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRbTZ-0007Of-U3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:24:22 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRbTZ-0007ON-Q6
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:24:21 -0500
Received: by mail-oi1-x244.google.com with SMTP id x23so18944586oix.3
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 03:24:21 -0800 (PST)
MIME-Version: 1.0
References: <1540498768-8736-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540498768-8736-4-git-send-email-aleksandar.markovic@rt-rk.com>
	<03cea7f3-cbb7-6e4d-3104-01aba47cde09@weilnetz.de>
In-Reply-To: <03cea7f3-cbb7-6e4d-3104-01aba47cde09@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 11:24:09 +0000
Message-ID: <CAFEAcA_==cEJ0JTXdHZw3OVTywF0cJn_i62achSTLvSKA1OFoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 3/3] target/mips: Add disassembler support
 for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, 8 Nov 2018 at 08:00, Stefan Weil <sw@weilnetz.de> wrote:
>
> On 25.10.18 22:19, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Add disassembler support for nanoMIPS.
> >
> > Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
> > Signed-off-by: Matthew Fortune <matthew.fortune@mips.com>
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >  MAINTAINERS           |     2 +
> >  configure             |     3 +
> >  disas/Makefile.objs   |     1 +
> >  disas/nanomips.cpp    | 22242 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  disas/nanomips.h      |  1099 +++
> >  include/disas/bfd.h   |     1 +
> >  include/exec/poison.h |     1 +
> >  target/mips/cpu.c     |    13 +-
> >  8 files changed, 23360 insertions(+), 2 deletions(-)
> >  create mode 100644 disas/nanomips.cpp
> >  create mode 100644 disas/nanomips.h
>
>
> Hi,
>
> the disassembler needs more work for the next QEMU release: it uses lots
> of wrong format strings which will result in wrong output at least on
> big endian hosts.

Hi Stefan; by "for the next QEMU release" do you mean:
(a) this is a release-critical bug which we need to fix for 3.1
(b) this is not critical for this release, but we should
fix it in the next release (4.0)

?

thanks
-- PMM
