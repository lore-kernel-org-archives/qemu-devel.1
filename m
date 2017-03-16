Received: from eggs.gnu.org ([2001:4830:134:3::10]:52999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coW7A-0007m3-Vn
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coW79-0005Ns-SK
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:10:52 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coW79-0005Ng-M1
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:10:51 -0400
Received: by mail-wm0-x22d.google.com with SMTP id t189so48935105wmt.1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 07:10:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489631689-6382-1-git-send-email-mst@redhat.com>
References: <1489631689-6382-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 14:10:30 +0000
Message-ID: <CAFEAcA_bH=sY_or4WfKpWDdv6-P8_z=aESKM3gNHYviMshV7PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/5] virtio, pci: fixes
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

On 16 March 2017 at 02:34, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 1883ff34b540daacae948f493b0ba525edf5f642:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-03-15 18:44:05 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to bdf4c4ec53f293ea1baa7ce7c31fe0301887b513:
>
>   virtio-serial-bus: Delete timer from list before free it (2017-03-16 01:46:42 +0200)
>
> ----------------------------------------------------------------
> virtio, pci: fixes
>
> More fixes missed in the previous pull request.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Marcel Apfelbaum (4):
>       hw/pcie: fix Extended Configuration Space for devices with no Extended Capabilities
>       hw/virtio: fix error enabling flags in Device Control register
>       hw/virtio: fix Link Control Register for PCI Express virtio devices
>       hw/virtio: fix Power Management Control Register for PCI Express virtio devices
>
> zhanghailiang (1):
>       virtio-serial-bus: Delete timer from list before free it
>
>  hw/virtio/virtio-pci.h      | 12 ++++++++++++
>  include/hw/compat.h         | 16 ++++++++++++++++
>  include/hw/pci/pci.h        |  2 ++
>  include/hw/pci/pcie.h       |  5 +++++
>  hw/char/virtio-serial-bus.c |  1 +
>  hw/pci/pci.c                |  2 ++
>  hw/pci/pcie.c               | 20 ++++++++++++++++++++
>  hw/virtio/virtio-pci.c      | 31 +++++++++++++++++++++++++++++++
>  dtc                         |  2 +-
>  9 files changed, 90 insertions(+), 1 deletion(-)

This has an incorrect submodule revert in it, and I missed it before
pushing it to master :-(

This is the second pullreq from you this release cycle with a bogus
submodule change in it -- please can you fix your workflow/checks
somehow to prevent this happening?

thanks
-- PMM
