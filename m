Received: from eggs.gnu.org ([2001:4830:134:3::10]:50202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCOvh-0003OR-J9
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCOvb-0003jI-E8
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:58:30 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCOvW-0003Pp-Sj
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:58:25 -0400
Received: by mail-oi1-x243.google.com with SMTP id j68-v6so17932808oib.7
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 05:58:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538067351-23931-1-git-send-email-gengdongjiu@huawei.com>
References: <1538067351-23931-1-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 13:57:50 +0100
Message-ID: <CAFEAcA97eSpOzU_xJZLFgFBZUCW1Z8mYDMzYsdpK99S5WiPf=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC v11 0/2] add support for VCPU event
 states
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Andrew Jones <drjones@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Zheng Xiang <zhengxiang9@huawei.com>

On 27 September 2018 at 17:55, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> Support KVM_GET/SET_VCPU_EVENTS to get/set the SError exception state, and
> support the state migration.
>
> Now the VCPU event only includes the SError exception status, it can be
> extended if needed. When do migration, If source machine has serror pending,
> the target machine is also needed to pend this serror regardless of whether
> target machine can support to set the serror syndrome.
>
> Note: Because I do not have arm32 environment, I only this patch in the KVM64,
> not test it in the KVM32. So I need someone else test it in the 32 bit KVM platform.
> Thanks.

Hi; could you clarify why this patchset is tagged RFC, please?
Is it just that it hasn't been tested on 32-bit ?

thanks
-- PMM
