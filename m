Received: from eggs.gnu.org ([2001:4830:134:3::10]:55972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIC6y-0008Do-4d
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIC6x-0006tR-Di
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:25:36 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eIC6x-0006sJ-5o
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:25:35 -0500
Received: by mail-oi0-x242.google.com with SMTP id a81so14871403oii.13
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 03:25:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171124095949.16323-1-cohuck@redhat.com>
References: <20171124095949.16323-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Nov 2017 11:25:13 +0000
Message-ID: <CAFEAcA_wo=t7qgDfMhzbJxY5tLxpG+ui4v992AyZxO+Ou6j8ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.11 0/1] s390x: headers deletion fallout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 24 November 2017 at 09:59, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit c65d5e4e1d6841524c49a07bcdd56094f49982a4:
>
>   configure: Deal with OpenBSD/i386 emulation linker (2017-11-23 16:52:24 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20171124
>
> for you to fetch changes up to c1c4c2192c1c063a6c53c600bb97f20555b2a528:
>
>   s390/kvm_virtio/linux-headers: remove traces of old virtio transport (2017-11-24 10:52:05 +0100)
>
> ----------------------------------------------------------------
> Deal with the fallout from the deletion of the old s390 virtio header
> in Linux master.
>
> ----------------------------------------------------------------
>
> Christian Borntraeger (1):
>   s390/kvm_virtio/linux-headers: remove traces of old virtio transport
>
>  hw/s390x/s390-virtio-hcall.h                   |  6 ++-
>  include/standard-headers/asm-s390/kvm_virtio.h | 64 --------------------------
>  scripts/update-linux-headers.sh                |  1 -
>  3 files changed, 4 insertions(+), 67 deletions(-)
>  delete mode 100644 include/standard-headers/asm-s390/kvm_virtio.h

Applied, thanks.

-- PMM
