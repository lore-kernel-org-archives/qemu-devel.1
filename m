Received: from eggs.gnu.org ([2001:4830:134:3::10]:48591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gaN3h-0006Lf-1Y
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gaN3g-00020D-84
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:49:52 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:44358)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gaN3g-0001zl-0S
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 10:49:52 -0500
Received: by mail-ot1-x32f.google.com with SMTP id f18so5454998otl.11
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 07:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20181220183059.20726-1-mst@redhat.com>
In-Reply-To: <20181220183059.20726-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Dec 2018 15:49:39 +0000
Message-ID: <CAFEAcA8rjyKBFogQU24iE1MN16SeAM5H012aTY+F55a1ZJASKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/44] pci, pc, virtio: fixes, features
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

On Thu, 20 Dec 2018 at 18:37, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit b72566a4ffaddbc0c0c1f6f5ee91b42ab13ff429:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-patches-pull-request' into staging (2018-12-19 15:31:02 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 47748bbba24d4f4680b77da3dc5b4da531cd17d4:
>
>   x86-iommu: turn on IR by default if proper (2018-12-20 13:25:11 -0500)
>
> ----------------------------------------------------------------
> pci, pc, virtio: fixes, features
>
> VTD fixes
> IR and split irqchip are now the default for Q35
> ACPI refactoring
> hotplug refactoring
> new names for virtio devices
> multiple pcie link width/speeds
> PCI fixes
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
