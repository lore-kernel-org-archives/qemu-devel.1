Received: from eggs.gnu.org ([2001:4830:134:3::10]:39125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLpWQ-0005BZ-2o
	for qemu-devel@nongnu.org; Thu, 24 May 2018 08:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLpWO-0008CK-Uj
	for qemu-devel@nongnu.org; Thu, 24 May 2018 08:39:10 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:43811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLpWO-0008C7-Pv
	for qemu-devel@nongnu.org; Thu, 24 May 2018 08:39:08 -0400
Received: by mail-ot0-x242.google.com with SMTP id y10-v6so1710811otg.10
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 05:39:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527047633-12368-1-git-send-email-zhaoshenglong@huawei.com>
References: <1527047633-12368-1-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 13:38:47 +0100
Message-ID: <CAFEAcA-2kQ2pHz=8Hm=fE-3qJ8U29nmUaPC6SdEtmC7pJVKWeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V3 1/2] arm_gicv3_kvm: increase clroffset
 accordingly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 23 May 2018 at 04:53, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> It forgot to increase clroffset during the loop. So it only clear the
> first 4 bytes.
>
> Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
> Changes in V3: Add reviewed-by tag
> ---
>  hw/intc/arm_gicv3_kvm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index ec37177..3536795 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -243,6 +243,7 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
>          if (clroffset != 0) {
>              reg = 0;
>              kvm_gicd_access(s, clroffset, &reg, true);
> +            clroffset += 4;
>          }
>          reg = *gic_bmp_ptr32(bmp, irq);
>          kvm_gicd_access(s, offset, &reg, true);
> --

Applied this patch to target-arm.next.

PS: if you could remember to always provide a cover letter
for multi-patch series that would be helpful.

thanks
-- PMM
