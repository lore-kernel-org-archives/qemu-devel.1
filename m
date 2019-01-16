Received: from eggs.gnu.org ([209.51.188.92]:43842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjjme-0002nn-4P
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gjjmb-0005x5-KA
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:54:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gjjmZ-0005nq-EI
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:54:55 -0500
Date: Wed, 16 Jan 2019 12:47:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190116124748.7c64c90e.cohuck@redhat.com>
In-Reply-To: <20190116041712.130183-1-aik@ozlabs.ru>
References: <20190116041712.130183-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu 0/2] linux-headers: Update to v5.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 16 Jan 2019 15:17:10 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> Here is the update script update and what it did to the v5.0-rc2 kernel.
> 
> This is based on sha1
> a0a8bff Greg Kurz "target/ppc/kvm: Drop useless include directive".
> 
> Please comment. Thanks.

Hm, Paolo had already posted an update to -rc1 (including an update of
the script). Not sure what the status of that one is?

> Alexey Kardashevskiy (2):
>   update-linux-headers.sh: Copy new headers
>   linux-headers: Update to v5.0-rc2
> 
>  include/standard-headers/drm/drm_fourcc.h     |   63 +
>  include/standard-headers/linux/ethtool.h      |   19 +-
>  .../linux/input-event-codes.h                 |   19 +
>  include/standard-headers/linux/pci_regs.h     |    1 +
>  .../standard-headers/linux/virtio_balloon.h   |    8 +
>  include/standard-headers/linux/virtio_blk.h   |   54 +
>  .../standard-headers/linux/virtio_config.h    |    3 +
>  include/standard-headers/linux/virtio_gpu.h   |   18 +
>  include/standard-headers/linux/virtio_ring.h  |   52 +
>  linux-headers/asm-arm/unistd-common.h         |    1 +
>  linux-headers/asm-arm64/unistd.h              |    1 +
>  linux-headers/asm-generic/unistd.h            |   10 +-
>  linux-headers/asm-mips/sgidefs.h              |    8 -
>  linux-headers/asm-mips/unistd.h               | 1074 +----------------
>  linux-headers/asm-mips/unistd_n32.h           |  338 ++++++
>  linux-headers/asm-mips/unistd_n64.h           |  334 +++++
>  linux-headers/asm-mips/unistd_o32.h           |  374 ++++++
>  linux-headers/asm-powerpc/unistd.h            |  389 +-----
>  linux-headers/asm-powerpc/unistd_32.h         |  381 ++++++
>  linux-headers/asm-powerpc/unistd_64.h         |  372 ++++++
>  linux-headers/linux/kvm.h                     |   29 +
>  linux-headers/linux/vfio.h                    |   92 ++
>  linux-headers/linux/vhost.h                   |  113 +-
>  linux-headers/linux/vhost_types.h             |  128 ++
>  scripts/update-linux-headers.sh               |   11 +-
>  25 files changed, 2302 insertions(+), 1590 deletions(-)
>  create mode 100644 linux-headers/asm-mips/unistd_n32.h
>  create mode 100644 linux-headers/asm-mips/unistd_n64.h
>  create mode 100644 linux-headers/asm-mips/unistd_o32.h
>  create mode 100644 linux-headers/asm-powerpc/unistd_32.h
>  create mode 100644 linux-headers/asm-powerpc/unistd_64.h
>  create mode 100644 linux-headers/linux/vhost_types.h
> 
