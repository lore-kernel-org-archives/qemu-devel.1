Received: from eggs.gnu.org ([2001:4830:134:3::10]:47010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctamP-0002cS-Rj
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctamP-0000x3-5c
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:10:25 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctamO-0000wl-Q2
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:10:25 -0400
Received: by mail-wr0-x22f.google.com with SMTP id w11so61392059wrc.3
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 07:10:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490880938-90331-1-git-send-email-agraf@suse.de>
References: <1490880938-90331-1-git-send-email-agraf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Mar 2017 15:10:03 +0100
Message-ID: <CAFEAcA-qOqEW5t_=yG3pssetX3kDowoWwp52_MQBdBc2K8b0RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] input: Add trace events for polled
 keyboard input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 30 March 2017 at 14:35, Alexander Graf <agraf@suse.de> wrote:
> When driving QEMU from the outside, we have basically no chance to
> determine how quickly the guest OS picks up key events, so we usually
> have to limit ourselves to very slow keyboard presses to make sure
> the guest always has enough chance to pick them up.
>
> This patch adds trace events for when the guest polls for HID keyboard
> events. That way we can be reasonably safely assume that the guest
> handled that one key event and can type the next.

This feels like the wrong way to solve the problem to me.
Maybe we should have something like the network and
UART device models do where they can say "my queue is
full, I cannot accept any more data from the outside
world" ?

thanks
-- PMM
