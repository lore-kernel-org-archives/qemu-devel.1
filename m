Received: from eggs.gnu.org ([2001:4830:134:3::10]:34641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1caiQe-0008M6-Um
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1caiQe-0000vo-7G
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:29:56 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:33847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1caiQe-0000vd-0E
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 07:29:56 -0500
Received: by mail-wm0-x233.google.com with SMTP id 196so33832089wmm.1
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 04:29:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486380501-13431-1-git-send-email-kraxel@redhat.com>
References: <1486380501-13431-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Feb 2017 12:29:34 +0000
Message-ID: <CAFEAcA-sn7kNxcBBqwLN6ye8xr7ZfHg9qUPKXcmQ9LUzQd8ZRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/9] usb: various bugfixes, mostly xhci.
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

On 6 February 2017 at 11:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here is the usb patch queue, with a collection of xhci bugfixes,
> also some other usb fixes in various places.
>
> please pull,
>   Gerd
>
> The following changes since commit a951316b8a5c3c63254f20a826afeed940dd4cba:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-02-03 14:41:49 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-usb-20170206-1
>
> for you to fetch changes up to 7da76e12cc5cc902dda4c168d8d608fd4e61cbc5:
>
>   xhci: fix event queue IRQ handling (2017-02-06 12:12:26 +0100)
>
> ----------------------------------------------------------------
> usb: various bugfixes, mostly xhci.
>
> ----------------------------------------------------------------
> Gerd Hoffmann (7):
>       usb/uas: more verbose error message
>       usb: accept usb3 control requests
>       xhci: only free completed transfers
>       xhci: rename xhci_complete_packet to xhci_try_complete_packet
>       xhci: don't kick in xhci_submit and xhci_fire_ctl_transfer
>       xhci: guard xhci_kick_epctx against recursive calls
>       xhci: fix event queue IRQ handling
>
> Phil Dennis-Jordan (1):
>       hw/usb/dev-hid: Improve guest compatibility of usb-tablet
>
> Prasad J Pandit (1):
>       usb: ccid: check ccid apdu length

Applied, thanks.

-- PMM
