Received: from eggs.gnu.org ([209.51.188.92]:54998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1hBxj7-000215-6O
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1hBxj5-0003eA-TO
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:28:01 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:33864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1hBxj5-0003bw-If
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 04:27:59 -0400
Received: by mail-lf1-x144.google.com with SMTP id y18so1170548lfe.1
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 01:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <1552644466-24625-1-git-send-email-hongbo.zhang@linaro.org>
	<1552644466-24625-2-git-send-email-hongbo.zhang@linaro.org>
	<CAKv+Gu-aZeYwegzFQ7pPqvm28ySR5xC6rZh8FBvQaWiNykgPEg@mail.gmail.com>
	<CAHmQWvD8byf+4=J7+rnU9CiGRKnuA4NnRPHRw1Zki4-m4anwOA@mail.gmail.com>
	<CAKv+Gu9cWgkH-ZTDQ42_HnN-LfAMoL-k7ysd1Hz07RrP+Pp94g@mail.gmail.com>
In-Reply-To: <CAKv+Gu9cWgkH-ZTDQ42_HnN-LfAMoL-k7ysd1Hz07RrP+Pp94g@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Thu, 4 Apr 2019 16:27:43 +0800
Message-ID: <CAHmQWvArKFj9WPwaLjHs11x75iD0Rk9PBsTRq8mXrhm-LZt7=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 1/2] hw/arm: Add arm SBSA reference
 machine, skeleton part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

I would like to wait for more days to see if there are any further
comments, and if no I will send another iteration with memory map
slightly changed.

On Wed, 20 Mar 2019 at 18:27, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Mon, 18 Mar 2019 at 03:39, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> >
> > On Fri, 15 Mar 2019 at 18:41, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Fri, 15 Mar 2019 at 11:08, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> > > >
> > > > For the Aarch64, there is one machine 'virt', it is primarily meant to
> > > > run on KVM and execute virtualization workloads, but we need an
> > > > environment as faithful as possible to physical hardware, for supporting
> > > > firmware and OS development for pysical Aarch64 machines.
> > > >
> > > > This patch introduces new machine type 'sbsa-ref' with main features:
> > > >  - Based on 'virt' machine type.
> > > >  - A new memory map.
> > > >  - CPU type cortex-a57.
> > > >  - EL2 and EL3 are enabled.
> > > >  - GIC version 3.
> > > >  - System bus AHCI controller.
> > > >  - System bus EHCI controller.
> > >
> > > Hello Hongbo,
> > >
> > > Apologies for bringing this up now, but I seem to remember that the
> > > EHCI does not support 64-bit DMA. Did you run into any issues with
> > > this? Or was this fixed in QEMU in the mean time?
> > >
> > Hi Ard,
> > Which EHCI do you mean?
> > This time I use a newly introduced system bus EHCI, commit 114529f7
> > and I only tested USB mouse and key board, didn't test DMA function.
> >
>
> The host controller doesn't work without DMA, so if mouse and keyboard
> worked for you, and no DRAM exists below the 4 GB mark, this has
> apparently been fixed in QEMU.
