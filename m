Received: from eggs.gnu.org ([2001:4830:134:3::10]:41229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cteQP-0007OC-CE
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 14:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cteQO-0001pX-Jc
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 14:03:57 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cteQO-0001ob-Ct
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 14:03:56 -0400
Received: by mail-wr0-x231.google.com with SMTP id w43so71439961wrb.0
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 11:03:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490890571-2786-1-git-send-email-mst@redhat.com>
References: <1490890571-2786-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Mar 2017 19:03:34 +0100
Message-ID: <CAFEAcA95vm-tjJ1ry5vPv=XMWFEWRQgQr9m4wsYBux0OBTgJmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] vhost, pc: fixes
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

On 30 March 2017 at 17:16, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit e839001d5bb6c84932e2d82bd383477b2023f407:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2017-03-30 15:28:19 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 0d876080a394993a8dea494ebf2d806dc0983107:
>
>   tests/acpi: don't pack a structure (2017-03-30 19:12:44 +0300)
>
> ----------------------------------------------------------------
> vhost, pc: fixes
>
> More fixes for 2.9. Region caching is still causing
> issues around reset, but we seem to be getting there.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Jason Wang (1):
>       vhost: generalize iommu memory region
>
> Michael S. Tsirkin (1):
>       tests/acpi: don't pack a structure
>
>  include/hw/virtio/vhost.h | 11 +++++++
>  tests/acpi-utils.h        |  2 +-
>  hw/virtio/vhost.c         | 84 ++++++++++++++++++++++++++++++++++++-----------
>  3 files changed, 76 insertions(+), 21 deletions(-)

Applied, thanks.

-- PMM
