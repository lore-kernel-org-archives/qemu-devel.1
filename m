Received: from eggs.gnu.org ([2001:4830:134:3::10]:41328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb7xU-0000GZ-00
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb7xS-0007gv-Sb
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:45:32 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb7xS-0007gM-KQ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:45:30 -0500
Received: by mail-wm0-x22c.google.com with SMTP id v77so160254615wmv.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 07:45:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
References: <1484558821-15512-1-git-send-email-zhaoshenglong@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 15:45:08 +0000
Message-ID: <CAFEAcA_Sn+MSVv8VcjL=o9VNR1+6VpTFFUhf6Mmr1-YGxt5gvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH RFC 0/6] target-arm: KVM64: Cross type vCPU
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, wu.wubin@huawei.com

On 16 January 2017 at 09:26, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
>
> This patch set support use cross type vCPU when using KVM on ARM and add
> two new CPU types: generic and cortex-a72.
>
> You can test this patch set with QEMU using
> -cpu cortex-a53/cortex-a57/generic/cortex-a72
>
> These patches can be fetched from:
> https://git.linaro.org/people/shannon.zhao/qemu.git cross_vcpu_rfc
>
> You corresponding KVM patches can be fetched from:
> https://git.linaro.org/people/shannon.zhao/linux-mainline.git cross_vcpu_rfc

We should really document the "generic" option for -cpu somewhere
and what it means. Unfortunately I'm not entirely sure where
that should be :-(  Suggestions welcomed but this isn't a blocker
for this series.

thanks
-- PMM
