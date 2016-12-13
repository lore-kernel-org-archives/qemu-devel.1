Received: from eggs.gnu.org ([2001:4830:134:3::10]:38965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGn26-0001vw-Kk
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGn23-00011T-Hq
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:22:14 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cGn23-000119-5d
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:22:11 -0500
Received: by mail-vk0-f41.google.com with SMTP id p9so60564176vkd.3
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 05:22:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1479133935-63848-3-git-send-email-agraf@suse.de>
References: <1479133935-63848-1-git-send-email-agraf@suse.de>
	<1479133935-63848-3-git-send-email-agraf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Dec 2016 13:20:50 +0000
Message-ID: <CAFEAcA9yW+pOcdE6d6-FUxtVZtEcEXZyEkjwACZa89CbnJ9Y8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH RFC v2 2/2] ARM: KVM: Enable in-kernel
 timers with user space gic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm-devel <kvm@vger.kernel.org>, qemu-arm <qemu-arm@nongnu.org>

On 14 November 2016 at 14:32, Alexander Graf <agraf@suse.de> wrote:
> When running with KVM enabled, you can choose between emulating the
> gic in kernel or user space. If the kernel supports in-kernel virtualization
> of the interrupt controller, it will default to that. If not, if will
> default to user space emulation.
>
> Unfortunately when running in user mode gic emulation, we miss out on
> timer events which are only available from kernel space. This patch leverages
> the new kernel/user space pending line synchronization for those timer events.
>
> Signed-off-by: Alexander Graf <agraf@suse.de>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
