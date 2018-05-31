Received: from eggs.gnu.org ([2001:4830:134:3::10]:35152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOO46-0001dT-DR
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOO45-0000WH-L0
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:56:30 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOO45-0000Vt-EA
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:56:29 -0400
Received: by mail-oi0-x243.google.com with SMTP id t22-v6so16134687oih.6
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 06:56:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1527750994-14360-1-git-send-email-zhaoshenglong@huawei.com>
References: <1527750994-14360-1-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 14:56:08 +0100
Message-ID: <CAFEAcA-+59XXTDypmyyDTjVVuMY=b8MF5HusVfAhZnWy=Q-56Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] KVM: GIC: Fix memory leak due to calling
 kvm_init_irq_routing twice
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

On 31 May 2018 at 08:16, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> kvm_irqchip_create called by kvm_init will call kvm_init_irq_routing to
> initialize global capability variables. If we call kvm_init_irq_routing in
> GIC realize function, previous allocated memory will leak.
>
> Fix this by deleting the unnecessary call.
>
> Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>



Applied to target-arm.next, thanks.

-- PMM
