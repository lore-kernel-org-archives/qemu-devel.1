Received: from eggs.gnu.org ([2001:4830:134:3::10]:50606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyFLW-0008Hn-8c
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyFLV-0004TN-Ao
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:22:26 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyFLV-0004Sh-5j
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:22:25 -0400
Received: by mail-ot0-x243.google.com with SMTP id m7-v6so1275831otd.1
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 04:22:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521530809-11780-3-git-send-email-zhaoshenglong@huawei.com>
References: <1521530809-11780-1-git-send-email-zhaoshenglong@huawei.com>
	<1521530809-11780-3-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 11:22:03 +0000
Message-ID: <CAFEAcA96qV_f7i_36Yzb-QV7W9SRHKfJpg=rvv3tia2X-Xi7QQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 2/2] arm_gicv3_kvm:
 kvm_dist_get/put: skip the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On 20 March 2018 at 07:26, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> While we skip the GIC_INTERNAL irqs, we don't change the register offset
> accordingly. This will overlap the GICR registers value and leave the
> last GIC_INTERNAL irq's registers out of update.
>
> Fix this by skipping the registers banked by GICR.
>

I'm still not entirely sure what the underlying problem
you're trying to fix is...

Do we fail to correctly migrate a VM without this change?
Does the code work on some host CPU/GIC implementations but
not others? Is this just improving efficiency by avoiding
doing some unnecessary work?

thanks
-- PMM
