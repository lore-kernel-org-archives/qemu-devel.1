Received: from eggs.gnu.org ([2001:4830:134:3::10]:58924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyCJZ-0003rG-Ds
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 04:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eyCJU-0006Vs-Dk
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 04:08:13 -0400
References: <1521530809-11780-1-git-send-email-zhaoshenglong@huawei.com>
	<1521530809-11780-2-git-send-email-zhaoshenglong@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <95234cb8-c6a5-be7b-f3da-60c24a3c2d2d@redhat.com>
Date: Tue, 20 Mar 2018 09:07:39 +0100
MIME-Version: 1.0
In-Reply-To: <1521530809-11780-2-git-send-email-zhaoshenglong@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] arm_gicv3_kvm: increase clroffset
 accordingly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

Hi Shannon,

On 20/03/18 08:26, Shannon Zhao wrote:
> It forgot to increase clroffset during the loop. So it only clear the
> first 4 bytes.

Fixes 367b9f527becdd20ddf116e17a3c0c2bbc486920
 ("hw/intc/arm_gicv3_kvm: Implement get/put functions")
> 
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Nice catch!

Thanks

Eric

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
> 
