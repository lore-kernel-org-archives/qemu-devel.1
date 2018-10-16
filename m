Received: from eggs.gnu.org ([2001:4830:134:3::10]:43910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCPz6-0006P8-82
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCPz5-0003sa-5s
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:06:08 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCPz4-0003qd-UE
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:06:07 -0400
Received: by mail-ot1-x343.google.com with SMTP id x4so21224304otg.3
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 07:06:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538067351-23931-3-git-send-email-gengdongjiu@huawei.com>
References: <1538067351-23931-1-git-send-email-gengdongjiu@huawei.com>
	<1538067351-23931-3-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 15:05:45 +0100
Message-ID: <CAFEAcA83hcHqsZRzn8+PiVCTyQT=H_uXubxZPU=0H+tycoia-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC v11 2/2] target/arm: Add support for
 VCPU event states
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
> This patch extends the qemu-kvm state sync logic with support for
> KVM_GET/SET_VCPU_EVENTS, giving access to yet missing SError exception.
> And also it can support the exception state migration.
>
> The SError exception states include SError pending state and ESR value,
> the kvm_put/get_vcpu_events() will be called when set or get system
> registers. When do migration, if source machine has SError pending,
> QEMU will do this migration regardless whether the target machine supports
> to specify guest ESR value, because if target machine does not support that,
> it can also inject the SError with zero ESR value.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
