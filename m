Received: from eggs.gnu.org ([2001:4830:134:3::10]:38749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fj4Dh-0007C0-1W
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fj4Dg-0004zU-8X
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:59:53 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fj4Df-0004yS-Va
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:59:52 -0400
Received: by mail-oi0-x243.google.com with SMTP id k12-v6so9548888oiw.8
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 07:59:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1532701430.git.damien.hedde@greensocs.com>
References: <cover.1532701430.git.damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jul 2018 15:59:30 +0100
Message-ID: <CAFEAcA-X=eziUHurc0SEcGEeM25t4YgkTczsVeF8myWHjfp3MQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] Clock and power gating support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Damien Hedde <damien.hedde@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Sai Pavan Boddu <saipava@xilinx.com>, Luc Michel <luc.michel@greensocs.com>, Alistair Francis <alistair@alistair23.me>

On 27 July 2018 at 15:37, Damien Hedde <damien.hedde@greensocs.com> wrote:
> This set of patches add support for power and clock gating in device objects.
> It adds two booleans to the state, one for power state and one of clock state.
>
> The state is controlled trough 2 functions, one for power and one for clock.
> Two new methods *power_update* and *clock_update* is added to the device class
> which are called on state change and can be overriden.

So, you folks at Greensocs had a series a couple of years ago to try
to add clocktree support (which included handling things like guests
configuring clock rates, some clocks being "downstream" of others, and
so on). It didn't make it into mainline, though it did get a fair amount
of design/code review. How does this approach fit into / compare with
that ?

thanks
-- PMM
