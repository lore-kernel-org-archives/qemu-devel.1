Received: from eggs.gnu.org ([2001:4830:134:3::10]:36104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAxTk-0003Yz-Un
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gAxTj-0003i5-TD
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:27:44 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gAxTj-0003h9-F5
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:27:43 -0400
Received: by mail-oi1-x244.google.com with SMTP id s69-v6so9830099oie.10
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 06:27:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d8b39811-4584-f05c-6f6d-6e8c8cd8ac3f@greensocs.com>
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
	<20181002142443.30976-8-damien.hedde@greensocs.com>
	<7621d3ab-7cfe-0dca-bc0e-dad913052b25@redhat.com>
	<d8b39811-4584-f05c-6f6d-6e8c8cd8ac3f@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Oct 2018 14:27:22 +0100
Message-ID: <CAFEAcA-=pUuPg4u9wQgmh=YemSdbqO7moSH5ZcjRcBx+oQLzaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 7/9] hw/misc/zynq_slcr: add clock
 generation for uarts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Damien Hedde <damien.hedde@greensocs.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, konrad@adacore.com, Luc Michel <luc.michel@greensocs.com>

On 12 October 2018 at 14:24, Damien Hedde <damien.hedde@greensocs.com> wrote:
> I'm wondering if in such a case (a fixed frequency base clock), we
> should have a way to change the frequency through command line ? (In
> order to start the machine with, for example, a 50MHz base clock).
> But I don't know what's the right way to do it and if it needs some kind
> of special support in the clock object or in the machine object, like a
> frequency property.

New command line arguments are a complexity you don't want to get in to.
Just have the board model the frequency at whatever it typically is.
It seems vanishingly rare that a user would really care to model the
board frequency as something different.

thanks
-- PMM
