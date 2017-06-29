Received: from eggs.gnu.org ([2001:4830:134:3::10]:38102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQbHF-0008Me-Dw
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQbHE-0007wb-HT
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:22:41 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:34151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQbHE-0007wB-Ay
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:22:40 -0400
Received: by mail-wm0-x234.google.com with SMTP id 70so543199wmo.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 08:22:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498577737-130264-1-git-send-email-agraf@suse.de>
References: <1498577737-130264-1-git-send-email-agraf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 16:22:18 +0100
Message-ID: <CAFEAcA_fFgcZb0Zrhn3gN0bYd6JjAzyzRdn1fbqDzp_1=G_ebg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] ARM: KVM: Enable in-kernel timers with
 user space gic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>, Christoffer Dall <cdall@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>

On 27 June 2017 at 16:35, Alexander Graf <agraf@suse.de> wrote:
> When running with KVM enabled, you can choose between emulating the
> gic in kernel or user space. If the kernel supports in-kernel virtualization
> of the interrupt controller, it will default to that. If not, if will
> default to user space emulation.
>
> Unfortunately when running in user mode gic emulation, we miss out on
> interrupt events which are only available from kernel space, such as the timer.
> This patch leverages the new kernel/user space pending line synchronization for
> timer events. It does not handle PMU events yet.
>
> Signed-off-by: Alexander Graf <agraf@suse.de>
> Reviewed-by: Andrew Jones <drjones@redhat.com>



Applied to target-arm.next, thanks.

-- PMM
