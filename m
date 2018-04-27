Received: from eggs.gnu.org ([2001:4830:134:3::10]:39954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC00O-0001oG-Q8
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC00N-0008Bd-Si
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:49:28 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:45391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC00N-0008BN-Np
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:49:27 -0400
Received: by mail-oi0-x241.google.com with SMTP id b130-v6so1051065oif.12
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 02:49:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1524799751-151698-1-git-send-email-mst@redhat.com>
References: <1524799751-151698-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 10:49:06 +0100
Message-ID: <CAFEAcA-FNy7cdKkUDctnf08Ska-piZo7QKwRD90G=zB5_QsS_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] pc, pci, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 April 2018 at 04:29, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 4743c23509a51bd4ee85cc272287a41917d1be35:
>
>   Update version for v2.12.0 release (2018-04-24 16:44:55 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to fb6fd86f712c73a40fbe0c6be86d4635239b1304:
>
>   virtio-balloon: add hugetlb page allocation counts (2018-04-27 06:25:27 +0300)
>
> ----------------------------------------------------------------
> pc, pci, virtio: fixes, features
>
> A bugfix that just missed 2.12, a new PCI,
> and a new virtio balloon stat.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

> Peter Xu (1):
>       intel-iommu: send PSI always when notify_unmap set

This patch is still missing:
 * a clear description of when the bug applies and its severity
 * a cc:stable marking

Please can you fix that and resend?

thanks
-- PMM
