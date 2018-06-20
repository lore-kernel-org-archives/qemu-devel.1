Received: from eggs.gnu.org ([2001:4830:134:3::10]:46044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVeDm-0001s9-IY
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVeDl-00009B-6m
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:36:29 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVeDl-00008e-1Q
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:36:29 -0400
Received: by mail-oi0-x241.google.com with SMTP id t133-v6so3200029oif.10
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 07:36:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529072910-16156-1-git-send-email-eric.auger@redhat.com>
References: <1529072910-16156-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 15:36:07 +0100
Message-ID: <CAFEAcA8sAo6MfcMNw9cqEJWyzR1ig8RyP6pVuMZ+EnU47aturQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 00/11] KVM/ARM: virt-3.0: Multiple
 redistributor regions and 256MB ECAM region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <marc.zyngier@arm.com>

On 15 June 2018 at 15:28, Eric Auger <eric.auger@redhat.com> wrote:
> This series increases the number of vcpus usable in accelerated mode
> along with GICv3 and allows up to 256 PCIe busses.
>
> It is a combination of 2 series:
> [1] [RFC v3 0/8] KVM/ARM: Relax the max 123 vcpus limitation along
>     with KVM GICv3
> [2] [PATCH 0/2] ARM virt: Support up to 256 PCIe buses
>
> Both add features to the new 3.0 virt machine model.

Applied to target-arm.next, thanks.

-- PMM
