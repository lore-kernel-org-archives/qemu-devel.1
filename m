Received: from eggs.gnu.org ([2001:4830:134:3::10]:52402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coEms-0004pl-Gz
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 15:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coEmr-0006KZ-J7
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 15:40:46 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coEmr-0006K7-Bl
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 15:40:45 -0400
Received: by mail-wr0-x22c.google.com with SMTP id u108so18035175wrb.3
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 12:40:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489600837-11541-1-git-send-email-mst@redhat.com>
References: <1489600837-11541-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Mar 2017 19:40:23 +0000
Message-ID: <CAFEAcA-t65L=PiLffoFw_MPqaTJRm5Zq4TdQO88rjcWb0P-M4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/7] virtio, pc: fixes
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

On 15 March 2017 at 18:01, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit d84f714eafedd8bb9d4aaec8b76417bef8e3535e:
>
>   Update version for v2.9.0-rc0 release (2017-03-14 19:18:23 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 60a8d8023473dd24957b3a66824f66cd35b80d64:
>
>   virtio-pci: reset modern vq meta data (2017-03-15 19:59:18 +0200)
>
> ----------------------------------------------------------------
> virtio, pc: fixes
>
> Some fixes to fallback from using virtio caching,
> pls a minor vm gen id fix.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Ben Warren (1):
>       Bugfix: Handle error if VM Generation ID device not present
>
> Jason Wang (6):
>       virtio: guard against NULL pfn
>       virtio: destroy region cache during reset
>       virtio: validate address space cache during init
>       pci: introduce a bus master container
>       Revert "virtio: unbreak virtio-pci with IOMMU after caching ring translations"
>       virtio-pci: reset modern vq meta data

Applied, thanks.

-- PMM
