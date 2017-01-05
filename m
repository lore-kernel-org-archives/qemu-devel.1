Received: from eggs.gnu.org ([2001:4830:134:3::10]:40426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPAXW-0007Dw-7b
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPAXV-0000oV-L1
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:05:18 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:36581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPAXV-0000oG-FK
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:05:17 -0500
Received: by mail-ua0-x229.google.com with SMTP id 88so376617597uaq.3
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 08:05:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161231011808.4037-2-zxq_yx_007@163.com>
References: <20161231011808.4037-1-zxq_yx_007@163.com>
	<20161231011808.4037-2-zxq_yx_007@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 16:04:56 +0000
Message-ID: <CAFEAcA9j8NaHWH+tsr5rqo4Cq2mbe32VsT-=oYmQ9UV8qAnN5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/2] hw/char: QOM'ify
 exynos4210_uart.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Fabien Chouteau <chouteau@adacore.com>

On 31 December 2016 at 01:18, xiaoqiang zhao <zxq_yx_007@163.com> wrote:
> Drop the old Sysbus init and use instance_init and
> DeviceClass::realize instead
>
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
> ---
>  hw/char/exynos4210_uart.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Applied this patch to target-arm.next, thanks.

-- PMM
