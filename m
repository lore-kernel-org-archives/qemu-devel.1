Received: from eggs.gnu.org ([2001:4830:134:3::10]:44080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeTxS-0003W3-LS
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 17:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeTxR-00043Z-Tj
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 17:55:54 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eeTxR-00042a-NA
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 17:55:53 -0500
Received: by mail-oi0-x243.google.com with SMTP id a28so3984281oiy.12
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 14:55:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516814467-25906-1-git-send-email-mst@redhat.com>
References: <1516814467-25906-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Jan 2018 22:55:32 +0000
Message-ID: <CAFEAcA_qo46mGDfVePndm8QV=vbqBNEataHdHb+A51E_y_fZGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/3] virtio: quick fix
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

On 24 January 2018 at 17:22, Michael S. Tsirkin <mst@redhat.com> wrote:
> So this just reverts Gal's patches. I hope he'll be able to resubmit
> shortly but it's causing too many issues to too many people to try to do
> incremental fixups, and this way there's no timing pressure on anyone.
>
> The following changes since commit 52483b067cce4a88ffbf8fbeea26de7549d2ad23:
>
>   Merge remote-tracking branch 'remotes/huth/tags/pull-request-2018-01-22' into staging (2018-01-23 10:15:09 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to e044c0f8dd028ea296396ad8066ba436e9acf350:
>
>   Revert "qemu: add a cleanup callback function to EventNotifier" (2018-01-24 19:20:19 +0200)
>
> ----------------------------------------------------------------
> virtio: quick fix
>
> Fixes a regression in virtio that's causing issues
> for many people.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Michael S. Tsirkin (3):
>       Revert "virtio: improve virtio devices initialization time"
>       Revert "virtio: postpone the execution of event_notifier_cleanup function"
>       Revert "qemu: add a cleanup callback function to EventNotifier"

Applied, thanks.

-- PMM
