Received: from eggs.gnu.org ([2001:4830:134:3::10]:34579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNfUP-00004r-BO
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNfUO-0006y1-JW
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:20:41 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNfUO-0006xj-Ep
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:20:40 -0400
Received: by mail-oi0-x243.google.com with SMTP id d5-v6so10166522oib.5
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 07:20:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527247371-10592-2-git-send-email-zhaoshenglong@huawei.com>
References: <1527247371-10592-1-git-send-email-zhaoshenglong@huawei.com>
	<1527247371-10592-2-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 15:20:19 +0100
Message-ID: <CAFEAcA-Um2dCAUJ2uxjZW6foBsrEYMnKNmFwex=kD63vLUJ2Ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 1/2] arm_gicv3_kvm:
 kvm_dist_get/put_priority: skip the registers banked by GICR_IPRIORITYR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 25 May 2018 at 12:22, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> While for_each_dist_irq_reg loop starts from GIC_INTERNAL, it forgot to
> offset the date array and index. This will overlap the GICR registers
> value and leave the last GIC_INTERNAL irq's registers out of update.
>
> Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> ---
>  hw/intc/arm_gicv3_kvm.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
