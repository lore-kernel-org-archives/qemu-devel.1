Received: from eggs.gnu.org ([2001:4830:134:3::10]:34592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eOmIF-0005wj-Ep
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:16:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eOmI9-0001RC-Oe
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 10:16:27 -0500
Date: Tue, 12 Dec 2017 16:16:05 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20171212151605.v2eoestysaogzymm@kamzik.brq.redhat.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-3-git-send-email-peter.maydell@linaro.org>
	<20171212144513.sutjfenbjh33fm5n@kamzik.brq.redhat.com>
	<CAFEAcA-DyuObZjx-g2k9SkofLZ_akadfGYZCMum=3hQQLEdN_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-DyuObZjx-g2k9SkofLZ_akadfGYZCMum=3hQQLEdN_w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/arm/virt: Add another UART to the
 virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>

On Tue, Dec 12, 2017 at 02:50:50PM +0000, Peter Maydell wrote:
> On 12 December 2017 at 14:45, Andrew Jones <drjones@redhat.com> wrote:
> > Should this be
> >
> >     if (!vmc->no_second_uart && serial_hds[uart_count] != NULL) {
> >
> > A bit late now, but maybe the other UART resource allocations should have
> > been conditional on actually being wired up too?
> 
> What does x86 do?

Looks like they provide the io-ports unconditionally.

> 
> I think the conclusion we came to about UARTs in general was that
> boards should always create the devices, and the UART models
> should cope with being passed a NULL chardev backend. (This
> is like real hardware, where the 2nd UART always exists even
> if you haven't plugged a cable into the 2nd serial port on the
> back of the box.)

Yes, I guess the real hardware analogy provides the justification
for doing it this way.

OK, so this patch is fine, but it kills my suggestion for AAVMF to
only output debug messages to a debug port when the debug port is
actually useful. Now it won't be able to tell the difference unless
we can inform it some other way.

Thanks,
drew

> 
> thanks
> -- PMM
> 
