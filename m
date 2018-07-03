Received: from eggs.gnu.org ([2001:4830:134:3::10]:36335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faPL2-0002VL-Rm
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faPL2-0006Sx-2z
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:43:40 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faPL1-0006Si-T5
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 13:43:40 -0400
Received: by mail-oi0-x244.google.com with SMTP id v8-v6so5503127oie.5
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 10:43:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703082851.17959-1-kraxel@redhat.com>
References: <20180703082851.17959-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 18:43:18 +0100
Message-ID: <CAFEAcA-eY2HR_PmT7-NnwL2L9YCdQkmTnpNuHtfL8kt8uAEL2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Usb 20180703 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 July 2018 at 09:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c656:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into staging (2018-07-02 17:57:46 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20180703-pull-request
>
> for you to fetch changes up to 8f36ec708834dfad58af6feb0b69bb0be6077f0f:
>
>   xhci: fix guest-triggerable assert (2018-07-03 09:50:39 +0200)
>
> ----------------------------------------------------------------
> usb: bugfixes for ehci and xhci.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   xhci: fix guest-triggerable assert
>
> Sebastian Bauer (1):
>   ehci: Don't fetch a NULL current qtd but advance the queue instead.
>
>  hw/usb/hcd-ehci.c | 3 ++-
>  hw/usb/hcd-xhci.c | 7 ++++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)

Applied, thanks.

-- PMM
