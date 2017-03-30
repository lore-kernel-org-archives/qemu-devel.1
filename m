Received: from eggs.gnu.org ([2001:4830:134:3::10]:41384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctaVm-0001JT-26
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctaVl-0007VH-BC
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:53:14 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctaVl-0007UD-5C
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 09:53:13 -0400
Received: by mail-wr0-x236.google.com with SMTP id k6so56153636wre.2
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 06:53:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490750257-19907-1-git-send-email-mst@redhat.com>
References: <1490750257-19907-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Mar 2017 14:52:51 +0100
Message-ID: <CAFEAcA8mS2aNroJTn-hruZiNcuRtt_TyTL7JPV0X9qaXBNK=wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] virtio, pci: fixes
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

On 29 March 2017 at 02:18, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit df9046363220e57d45818312759b954c033c58ab:
>
>   Update version for v2.9.0-rc2 release (2017-03-28 19:11:16 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to b8adbc657802482e4da1767bf983ebfdf9bfe9fc:
>
>   virtio: fix vring_align() on 64-bit windows (2017-03-29 02:35:24 +0300)
>
> ----------------------------------------------------------------
> virtio, pci: fixes
>
> More fixes for 2.9.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Alexey Kardashevskiy (1):
>       pci: Add missing drop of bus master AS reference
>
> Andrew Baumann (1):
>       virtio: fix vring_align() on 64-bit windows
>
> Halil Pasic (1):
>       event_notifier: prevent accidental use after close
>
>  include/hw/virtio/virtio.h  | 2 +-
>  hw/pci/pci.c                | 2 ++
>  util/event_notifier-posix.c | 2 ++
>  util/event_notifier-win32.c | 1 +
>  4 files changed, 6 insertions(+), 1 deletion(-)

Applied, thanks.

-- PMM
