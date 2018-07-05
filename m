Received: from eggs.gnu.org ([2001:4830:134:3::10]:46821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb0ZV-000491-Li
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb0ZU-0000Tn-Pm
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:29:05 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb0ZU-0000Sm-Jb
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:29:04 -0400
Received: by mail-oi0-x241.google.com with SMTP id s198-v6so15539567oih.11
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 02:29:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d4a776fc-2022-979e-cc68-beb3123d35bd@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-21-luc.michel@greensocs.com>
	<d8062fb6-8eef-eff3-fa92-9f9f791ee669@web.de>
	<a199e550-4576-3a03-a7c1-8c21bb502cf5@web.de>
	<d4a776fc-2022-979e-cc68-beb3123d35bd@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 10:28:43 +0100
Message-ID: <CAFEAcA9yuiXF5UH3nwit09+VxVOmB9pmRVZsZUqnfbXCMaVU=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 20/20] arm/virt: Add support for GICv2
 virtualization extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: Jan Kiszka <jan.kiszka@web.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>

On 5 July 2018 at 09:46, Luc Michel <luc.michel@greensocs.com> wrote:
> Yes I encountered the same issue with Xen in SMP (see my cover letter).
> Re-reading the GICv2 specs, it's now clear to me that a read to
> ITARGETSR0 to ITARGETSR7 should return "the number of the processor
> performing the read". Reading the message of commit 2bb3135 in Linux, it
> seems that older versions of the GIC exposed this value in IRQs 29, 30,
> 31, hence the
>    if (irq >= 29 && irq <= 31) { res = cm; }
> in the current QEMU implementation.
>
> I should probably add a patch to fix that. I'll have to dig in specs of
> older GIC revisions to see when this behaviour actually appeared.
>
> Maybe I wait for some reviews before sending a new re-roll?
> Peter, any thoughts?

I'm probably not going to have time to look at any of this
GICv2 stuff for a bit (due to softfreeze and other for-3.0
work), so don't wait for my responses if you think a reroll
makes sense.

thanks
-- PMM
