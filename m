Received: from eggs.gnu.org ([2001:4830:134:3::10]:54917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOltr-0008WH-Qv
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOltn-0002fS-SS
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:51:15 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:45094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOltn-0002fF-MU
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:51:11 -0500
Received: by mail-oi0-x241.google.com with SMTP id x20so14133957oix.12
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 06:51:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171212144513.sutjfenbjh33fm5n@kamzik.brq.redhat.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-3-git-send-email-peter.maydell@linaro.org>
	<20171212144513.sutjfenbjh33fm5n@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2017 14:50:50 +0000
Message-ID: <CAFEAcA-DyuObZjx-g2k9SkofLZ_akadfGYZCMum=3hQQLEdN_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Shannon Zhao <shannon.zhao@linaro.org>

On 12 December 2017 at 14:45, Andrew Jones <drjones@redhat.com> wrote:
> Should this be
>
>     if (!vmc->no_second_uart && serial_hds[uart_count] != NULL) {
>
> A bit late now, but maybe the other UART resource allocations should have
> been conditional on actually being wired up too?

What does x86 do?

I think the conclusion we came to about UARTs in general was that
boards should always create the devices, and the UART models
should cope with being passed a NULL chardev backend. (This
is like real hardware, where the 2nd UART always exists even
if you haven't plugged a cable into the 2nd serial port on the
back of the box.)

thanks
-- PMM
