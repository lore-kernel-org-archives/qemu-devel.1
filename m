Received: from eggs.gnu.org ([2001:4830:134:3::10]:47690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhvfD-0007zO-2d
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhvfC-0002AU-9B
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:39:35 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:42417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhvfC-0002A3-3h
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:39:34 -0400
Received: by mail-oi0-x241.google.com with SMTP id n84-v6so6856477oib.9
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 04:39:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703020017.1032-1-programmingkidx@gmail.com>
References: <20180703020017.1032-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 12:39:12 +0100
Message-ID: <CAFEAcA_jx0pW_PfQG4=FTndZ73MqJPG_RK-41amudgQpaDsk5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] ui/cocoa.m: prevent stuck command key
 when going into full screen mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 July 2018 at 03:00, John Arbuckle <programmingkidx@gmail.com> wrote:
> When the user pushes Command-F in QEMU while the mouse is ungrabbed, QEMU
> goes into full screen mode. When the user finally releases the command key,
> it is sent to the guest as an event. The makes the guest operating system
> think the command key is down when it is really up. To prevent this situation
> from happening, we simply drop the first command key event after the user has
> gone into full screen mode using Command-F.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---

I feel like there might be a more elegant way to handle this
(surely the NSEventTypeFlagsChanged event can have some way
to query the current state of the modifier flags even if it's
got a keycode value? the current code which has different
approaches for "have a keycode" vs not seems a bit fragile),
but this fix should work. Applied to master for 3.0, thanks.

-- PMM
