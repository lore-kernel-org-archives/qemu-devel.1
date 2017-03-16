Received: from eggs.gnu.org ([2001:4830:134:3::10]:39864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coU9V-0004NE-Fv
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coU9U-0006aG-BE
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:05:09 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coU9U-0006Ya-4l
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:05:08 -0400
Received: by mail-wm0-x22e.google.com with SMTP id t189so45880878wmt.1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 05:05:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489631689-6382-1-git-send-email-mst@redhat.com>
References: <1489631689-6382-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 12:04:46 +0000
Message-ID: <CAFEAcA9zHXENN6uvuDwfwo9WCsvCzji92h8u7YMA7TwOv7M0=A@mail.gmail.com>
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

Applied, thanks.

-- PMM
