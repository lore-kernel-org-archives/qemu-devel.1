Received: from eggs.gnu.org ([2001:4830:134:3::10]:57710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faTRE-0006H4-R5
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 18:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faTRD-0000qx-PQ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 18:06:20 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:35381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faTRD-0000qk-Iu
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 18:06:19 -0400
Received: by mail-oi0-x232.google.com with SMTP id i12-v6so6897535oik.2
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 15:06:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703094508.25987-1-kraxel@redhat.com>
References: <20180703094508.25987-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 23:05:58 +0100
Message-ID: <CAFEAcA-nkSH0bOkPW9tDOsX4Jv_VkcpZGmCcaoCh=OXXf3GX6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Vga 20180703 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 3 July 2018 at 10:45, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c656:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into staging (2018-07-02 17:57:46 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20180703-pull-request
>
> for you to fetch changes up to 1fcfdc435a3e25ab9037f6f7b8ab4bdf89ba1269:
>
>   vga: disable global_vmstate for 3.0+ machine types (2018-07-03 11:19:49 +0200)
>
> ----------------------------------------------------------------
> vga: disable global_vmstate, virtio-gpu scanout tracking fixes.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (4):
>   virtio-gpu: tweak scanout disable.
>   virtio-gpu: update old resource too.
>   virtio-gpu: disable scanout when backing resource is destroyed
>   vga: disable global_vmstate for 3.0+ machine types
>
>  hw/display/vga_int.h    |  3 ++-
>  include/hw/compat.h     | 16 +++++++++++++
>  hw/display/cirrus_vga.c |  9 ++++---
>  hw/display/qxl.c        |  3 ++-
>  hw/display/vga-isa-mm.c |  3 ++-
>  hw/display/vga-isa.c    |  3 ++-
>  hw/display/vga-pci.c    |  5 ++--
>  hw/display/vga.c        |  4 ++--
>  hw/display/virtio-gpu.c | 64 ++++++++++++++++++++++++++++++++++---------------
>  hw/display/virtio-vga.c |  2 +-
>  hw/display/vmware_vga.c |  4 +++-
>  11 files changed, 84 insertions(+), 32 deletions(-)

Applied, thanks.

-- PMM
