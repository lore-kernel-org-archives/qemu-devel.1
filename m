Received: from eggs.gnu.org ([2001:4830:134:3::10]:34133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ede91-0005fZ-OF
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ede90-0001wX-Tz
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:36:23 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ede90-0001wD-O2
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:36:22 -0500
Received: by mail-oi0-x241.google.com with SMTP id m83so3731191oik.8
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 07:36:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180119145756.7629-1-luc.michel@greensocs.com>
References: <20180119145756.7629-1-luc.michel@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 15:36:01 +0000
Message-ID: <CAFEAcA-zY_MO6Tati1ybi3VQ8dZis-=P6NsNRGT7t3xxjNN0GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/4] arm_gic: Various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luc.michel@greensocs.com
Cc: QEMU Developers <qemu-devel@nongnu.org>, Luc MICHEL <luc.michel@git.antfield.fr>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>

On 19 January 2018 at 14:57,  <luc.michel@greensocs.com> wrote:
> Here is a patch set for issues I found in the GIC. I found those by
> writing unitary tests for the GIC, and compared the result against
> real hardware (a Zynq UltraScale+ board with a GICv2).
>
> The first patch prevents the GIC from signaling an IRQ that is in the
> "active and pending" state. I encountered this bug in a test where I
> split end of interrupt and interrupt deactivation. The GIC was
> re-signaling the IRQ after priority drop if it was raised again, while
> it has not been deactivated yet (and thus was in the "active and
> pending" state).
>
> The second patch returns a correct "Idle priority" value when reading
> C_RPR if there is no active interrupt.
>
> The last two patches fix issues around the Binary Point Register (the
> group priority computation of group 1 IRQs when C_CTRL.CBPR is 0, and
> the non-secure view of C_BPR when C_CTRL.CBPR is 1).

Thanks for this patchset, and in particular for the detailed
commit messages that made it really easy to review.
Since there were only a couple of minor nits in the patchset
(an extra assert, a comment typo) I'm going to take this into
target-arm.next and fix those things there, rather than ask you
to respin the patchset.

thanks
-- PMM
