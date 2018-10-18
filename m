Received: from eggs.gnu.org ([2001:4830:134:3::10]:42498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gD4ll-0003I1-3V
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 05:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gD4lk-0007zh-78
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 05:39:05 -0400
From: gengdongjiu <gengdongjiu@huawei.com>
Date: Thu, 18 Oct 2018 09:38:40 +0000
Message-ID: 9239E1F2-6FF6-4C64-9A3E-C71F0D9F5479
References: <1538067351-23931-1-git-send-email-gengdongjiu@huawei.com>,
	<CAFEAcA97eSpOzU_xJZLFgFBZUCW1Z8mYDMzYsdpK99S5WiPf=A@mail.gmail.com>
In-Reply-To: <CAFEAcA97eSpOzU_xJZLFgFBZUCW1Z8mYDMzYsdpK99S5WiPf=A@mail.gmail.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "zhengxiang (A)" <zhengxiang9@huawei.com>

Hi peter,

    Thanks very much for this comments and very sorry for my late response =
due to business trave.

     Yes, the reason that tag the patchset to RFC is that it just  hasn't b=
een tested on 32-bit. if someone else can test it on 32-bit platform, it wi=
ll be great.

    I do not have 32-bit environment, so only tested it on 64-bit.


On 27 September 2018 at 17:55, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> Support KVM_GET/SET_VCPU_EVENTS to get/set the SError exception state, an=
d
> support the state migration.
>
> Now the VCPU event only includes the SError exception status, it can be
> extended if needed. When do migration, If source machine has serror pendi=
ng,
> the target machine is also needed to pend this serror regardless of wheth=
er
> target machine can support to set the serror syndrome.
>
> Note: Because I do not have arm32 environment, I only this patch in the K=
VM64,
> not test it in the KVM32. So I need someone else test it in the 32 bit KV=
M platform.
> Thanks.

Hi; could you clarify why this patchset is tagged RFC, please?
Is it just that it hasn't been tested on 32-bit ?

thanks
-- PMM
