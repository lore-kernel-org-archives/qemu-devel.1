Received: from eggs.gnu.org ([2001:4830:134:3::10]:51504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f87H1-000609-4T
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f87H0-0002MU-0P
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:46:35 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:46102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f87Gz-0002LY-Qp
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:46:33 -0400
Received: by mail-ot0-x241.google.com with SMTP id v64-v6so18125727otb.13
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 09:46:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523518688-26674-8-git-send-email-eric.auger@redhat.com>
References: <1523518688-26674-1-git-send-email-eric.auger@redhat.com>
	<1523518688-26674-8-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 17:46:12 +0100
Message-ID: <CAFEAcA9HJSjumMzL7N6BuS+VJiEuFXRd6iuEPmqaSNjb4F8JZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 07/17] hw/arm/smmuv3: Implement MMIO
 write operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <cdall@kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On 12 April 2018 at 08:37, Eric Auger <eric.auger@redhat.com> wrote:
> Now we have relevant helpers for queue and irq
> management, let's implement MMIO write operations.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>

> -int smmuv3_cmdq_consume(SMMUv3State *s)
> +static int smmuv3_cmdq_consume(SMMUv3State *s)
>  {
>      SMMUCmdError cmd_error = SMMU_CERROR_NONE;
>      SMMUQueue *q = &s->cmdq;
> @@ -269,11 +270,170 @@ int smmuv3_cmdq_consume(SMMUv3State *s)
>      return 0;
>  }
>
> -static MemTxResult smmu_write_mmio(void *opaque, hwaddr offset, uint64_t data,

You changed the name of the argument here from 'value' to 'data', which
is why the diff has come out looking a bit awkward like this.
Better to be consistent with the name from the start.

> +static MemTxResult smmu_writell(SMMUv3State *s, hwaddr offset,
> +                               uint64_t value, MemTxAttrs attrs)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
