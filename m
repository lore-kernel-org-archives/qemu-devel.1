Received: from eggs.gnu.org ([2001:4830:134:3::10]:48291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTC8g-0004HD-EP
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTC8f-0003SC-PB
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:36:18 -0500
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:35786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTC8f-0003S6-Hc
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 13:36:17 -0500
Received: by mail-ua0-x22e.google.com with SMTP id y9so87511667uae.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 10:36:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484132292-21458-1-git-send-email-kraxel@redhat.com>
References: <1484132292-21458-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 18:35:55 +0000
Message-ID: <CAFEAcA-X3mXPR5GX0_Xqs6uXiv3ur6rimb4Yoeixop87ZuMaWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] cocoa: stop using MOUSE_EVENT_*
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

On 11 January 2017 at 10:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
> No need to go the indirect route with a bitfield and mapping the bits to
> INPUT_BUTTON_*.  We can use a bool array and INPUT_BUTTON_* directly
> instead.
>
> Untested, not even compiled, due to lack of a osx^Wmacos machine.
> Test results are very welcome.

So what does the patch gain us? We'll now loop round
that button array for every event rather than only
the ones where the button state changed, which I
don't suppose is a big deal but does somewhat incline
me towards "just leave the code the way it is"...

thanks
-- PMM
