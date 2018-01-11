Received: from eggs.gnu.org ([2001:4830:134:3::10]:39810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZhHu-0003bu-MW
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZhHt-0003UX-JZ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:09:14 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:45363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZhHt-0003UC-DM
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:09:13 -0500
Received: by mail-oi0-x242.google.com with SMTP id j129so2203420oib.12
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:09:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a490bac7-e88b-cd4c-9922-f50461c591bc@linaro.org>
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-7-git-send-email-mjc@sifive.com>
	<a490bac7-e88b-cd4c-9922-f50461c591bc@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 12 Jan 2018 07:09:12 +1300
Message-ID: <CAHNT7Ns5GKU0g9V2DwbQWO0ahjE67+OO0gYnEyU+88BjXghKJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 06/21] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Fri, Jan 12, 2018 at 4:31 AM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 01/10/2018 06:21 PM, Michael Clark wrote:
> > Helper routines for FPU instructions and NaN definitions.
> >
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > ---
> >  fpu/softfloat-specialize.h |   7 +-
> >  target/riscv/fpu_helper.c  | 591 ++++++++++++++++++++++++++++++
> +++++++++++++++
> >  2 files changed, 595 insertions(+), 3 deletions(-)
> >  create mode 100644 target/riscv/fpu_helper.c
>
> It doesn't look like you have addressed any of my comments against v1 here.


No I haven't sorry. I'll go back through your feedback.

I'm going to have to defer looking at this until the weekend as i've used
all of my QEMU "background time" this week.

I don't know if tininess is one of the comments. i.e. setting underflow
before of after rounding. RISC-V sets underflow after rounding and we need
to figure out how to do that.

The RISC-V QEMU port is presently quite usable, and we have fedora and
debian folk both working on packacking for RISC-V. The general sentiment is
does our port need to be perfect to be accepted in-tree? or can we work on
clean-ups and bug fixes in tree? We're pretty committed to transforming it
into a high quality port and we will have plently of time going forward to
address any issues. We have to balance cleanups and bug fixes for corner
cases with adding and improve device emulation support. So far all of the
recent effort has gone into the former, i.e. clean-ups and bug fixes, so
you can be sure we will attend to any remaining issues in the comitted
blocks of time we have available to work on the port.
