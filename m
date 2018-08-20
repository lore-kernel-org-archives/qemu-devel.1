Received: from eggs.gnu.org ([2001:4830:134:3::10]:53610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frh2j-0005db-Ny
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frgta-0001P9-CE
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:54:46 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frgta-0001Ov-6w
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:54:46 -0400
Received: by mail-oi0-x243.google.com with SMTP id m11-v6so24795816oic.2
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 02:54:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180803101943.23722-1-peter.maydell@linaro.org>
References: <20180803101943.23722-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 10:54:25 +0100
Message-ID: <CAFEAcA8ZPjHzy_OvKN16JJtJtsXNqER3w1TOmw+r0x61zV__2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/intc/apic: Switch away from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 3 August 2018 at 11:19, Peter Maydell <peter.maydell@linaro.org> wrote:
> Switch the apic away from using the old_mmio MemoryRegionOps
> accessor functions.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I think this is the last old_mmio user. We can clean up the
> core code once all the on-list patches get into master.
> ---
>  hw/intc/apic.c | 42 ++++++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
>

Pinging the x86 maintainers -- this patch has been reviewed,
can you take it into your tree, please?

thanks
-- PMM
