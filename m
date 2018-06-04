Received: from eggs.gnu.org ([2001:4830:134:3::10]:50099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPrqc-0007da-MO
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPrqb-00006B-O4
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:56:42 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPrqb-00005M-GD
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 11:56:41 -0400
Received: by mail-ot0-x244.google.com with SMTP id 101-v6so15794409oth.4
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 08:56:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527816987-16108-1-git-send-email-zhaoshenglong@huawei.com>
References: <1527816987-16108-1-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 16:56:20 +0100
Message-ID: <CAFEAcA9xHSoRqWJMD-MkUugy0TxZgBa5euP0s=tPdf5wiD+U2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6] arm_gicv3_kvm: kvm_dist_get/put: skip
 the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-stable <qemu-stable@nongnu.org>

On 1 June 2018 at 02:36, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> While we skip the GIC_INTERNAL irqs, we don't change the register offset
> accordingly. This will overlap the GICR registers value and leave the
> last GIC_INTERNAL irq's registers out of update.
>
> Fix this by skipping the registers banked by GICR.
>
> Also for migration compatibility if the migration source (old version
> qemu) doesn't send gicd_no_migration_shift_bug = 1 to destination, then
> we shift the data of PPI to get the right data for SPI.
>
> Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
> ---



Applied to target-arm.next, thanks.

-- PMM
