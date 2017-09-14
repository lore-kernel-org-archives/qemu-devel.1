Received: from eggs.gnu.org ([2001:4830:134:3::10]:32779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsVir-0007wD-PH
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsViq-0003Zs-M2
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:06:33 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:47102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsViq-0003Yh-FS
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:06:32 -0400
Received: by mail-wr0-x22a.google.com with SMTP id o42so6163212wrb.3
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 08:06:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505296004-6798-1-git-send-email-eric.auger@redhat.com>
References: <1505296004-6798-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 16:06:10 +0100
Message-ID: <CAFEAcA-=VeQ=B0h0e9Qd2rnGLoeZ2jaXuARcPXMBppX8WHhnUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/3] Generic PCIe host bridge INTx
 determination for INTx routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Alexander Graf <agraf@suse.de>, Pranavkumar Sawargaonkar <pranavkumar@linaro.org>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>

On 13 September 2017 at 10:46, Eric Auger <eric.auger@redhat.com> wrote:
> This series implements INTx to gsi routing for ARM VIRT/Gpex. This is
> a respin of [1] which was lost in limbo.
>
> ARM virt uses GPEX PCIe bridge. This latter does not implement INTx
> to GSI routing. PCIe/INTx assignment works but the consequence is
> irqfd is not used along with INTx interrupts and VFIO INTx handlers
> are executed on userspace leading to an important performance degradation.
>
> This issue is witnessed by the following messages;
>
> qemu-system-aarch64: -device vfio-pci,host=0006:90:00.0: PCI: Bug -
> unimplemented PCI INTx routing (gpex-pcihost)
> qemu-system-aarch64: PCI: Bug - unimplemented PCI INTx routing (gpex-pcihost)
> qemu-system-aarch64: PCI: Bug - unimplemented PCI INTx routing (gpex-pcihost)
>
> So with this series, irqfd is set up for PCIe/INTx passthrough and we get
> the optimal performance. Also we get rid of the above messages.
>
> This series can be found at:
> https://github.com/eauger/qemu/tree/v2.10.0-gpex-v4
>
> References:
> [1] Generic PCIe host bridge INTx determination for INTx routing
>    https://lists.gnu.org/archive/html/qemu-devel/2015-09/msg04975.html

Applied to target-arm.next, thanks.

-- PMM
