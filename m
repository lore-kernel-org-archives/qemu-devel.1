Received: from eggs.gnu.org ([2001:4830:134:3::10]:45998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUA7x-0007Xl-3H
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:48:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUA7w-0003yk-C0
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:48:37 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUA7w-0003y7-0B
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 07:48:36 -0500
Received: by mail-ot1-x344.google.com with SMTP id s5so15003593oth.7
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 04:48:35 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-oFFz-NtfwHmORxQd4rHsfKa1=tV1kyvPuGQoOZwDB3A@mail.gmail.com>
	<201812040841510784684@zte.com.cn>
	<CAFEAcA8hw_PHrBTC+v9rr8VoeU5uiV3Z6nMRknDM7WWdG1Ti5g@mail.gmail.com>
	<20181204120547.x5qa7q6usq6bfgkw@kamzik.brq.redhat.com>
In-Reply-To: <20181204120547.x5qa7q6usq6bfgkw@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 12:48:23 +0000
Message-ID: <CAFEAcA-JCAvgGCLVPRHGRM47Mw_G_9utG3NUn-FRaT+txJSfXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V11 0/8] add pvpanic mmio support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 4 Dec 2018 at 12:05, Andrew Jones <drjones@redhat.com> wrote:
> To muddy the waters a bit more, while I'm not opposed to this device
> being a PCI device, there is a chance that someone will still want a
> platform-mmio version as well. I'm not sure how everything will
> eventually fall into place, but I've seen some super minimal guest
> configs proposed for the VMs-used-like-containers use cases, even
> configs that choose to use virtio-mmio over virtio-pci, and then not
> provide a PCI bus at all to the vm.
>
> Maybe this series and the current kernel series can be allowed to
> continue as they are, and if later there's a demand for a pci version,
> it could just be yet another variant added later?

I like the PCI device idea because it avoids adding yet
another complication to the virt board. Adding the MMIO
variant now and the PCI device later doesn't let us avoid
the complication or even remove it in the future.

The last I heard we were still thinking about deprecating
virtio-mmio entirely.

thanks
-- PMM
