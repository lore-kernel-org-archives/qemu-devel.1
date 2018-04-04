Received: from eggs.gnu.org ([2001:4830:134:3::10]:53477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3du1-0006UU-FF
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3du0-0002nD-Oi
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:36:21 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:42036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3du0-0002mL-JI
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 04:36:20 -0400
Received: by mail-ot0-x244.google.com with SMTP id h55-v6so20938422ote.9
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 01:36:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180403083625.15297-1-cohuck@redhat.com>
References: <20180403083625.15297-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Apr 2018 09:35:59 +0100
Message-ID: <CAFEAcA9EfCw4bjyt8exi=HpBC=ZUWAnqqr7hD55Zb5NFzRtKxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.12 0/3] s390x fixes for -rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 3 April 2018 at 09:36, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit f184de7553272223d6af731d7d623a7cebf710b5:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-critical-fixes' into staging (2018-03-31 09:42:33 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180403
>
> for you to fetch changes up to d3b6e3bb6dc582099b8572c439fa651b3672de89:
>
>   pc-bios/s390-ccw: update image (2018-04-03 10:03:38 +0200)
>
> ----------------------------------------------------------------
> - fix a memory leak in the ipl code introduced with this release
> - increase timeout in the bios to avoid hangs during migration (and
>   rebuild bios to activate the change)
>
> ----------------------------------------------------------------
>
> Cornelia Huck (1):
>   pc-bios/s390-ccw: update image
>
> Greg Kurz (1):
>   hw/s390x: fix memory leak in s390_init_ipl_dev()
>
> Thomas Huth (1):
>   pc-bios/s390-ccw: Increase virtio timeout to 30 seconds
>
>  hw/s390x/s390-virtio-ccw.c |   5 ++++-
>  pc-bios/s390-ccw.img       | Bin 34568 -> 30568 bytes
>  pc-bios/s390-ccw/virtio.c  |   2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)

Applied, thanks.

-- PMM
