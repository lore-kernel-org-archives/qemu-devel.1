Received: from eggs.gnu.org ([2001:4830:134:3::10]:44019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCPza-0006d3-CN
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gCPzZ-0004Ov-KW
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:06:38 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gCPzZ-0004O0-G0
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 10:06:37 -0400
Received: by mail-ot1-x342.google.com with SMTP id c32so22634909otb.8
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 07:06:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1538067351-23931-2-git-send-email-gengdongjiu@huawei.com>
References: <1538067351-23931-1-git-send-email-gengdongjiu@huawei.com>
	<1538067351-23931-2-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 15:06:16 +0100
Message-ID: <CAFEAcA8PAuGQUTLNB_R8QRcpeATGP9yFm2ZXC-p32r=fyAvuwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC v11 1/2] linux-headers: Update to linux
 kernel 4.19-rc5
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
> Update our kernel headers to upstream 4.19-rc5
> (kernel commit 6bf4ca7fbc85d80446ac0)
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  include/standard-headers/linux/input.h |  9 +++++----
>  linux-headers/asm-arm/kvm.h            | 13 +++++++++++++
>  linux-headers/asm-arm64/kvm.h          | 13 +++++++++++++
>  linux-headers/asm-x86/kvm.h            |  1 +
>  linux-headers/linux/kvm.h              |  2 ++
>  linux-headers/linux/vhost.h            |  2 +-
>  6 files changed, 35 insertions(+), 5 deletions(-)

It looks like a kernel header sync has hit master since this series
was posted, so this patch isn't required any more.

thanks
-- PMM
