Received: from eggs.gnu.org ([2001:4830:134:3::10]:40198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZhxm-0004TY-13
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:24:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZhxl-0002e6-4d
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:24:46 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:35568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZhxk-0002dE-V9
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 15:24:45 -0400
Received: by mail-ot0-x233.google.com with SMTP id j8-v6so12424931otl.2
	for <qemu-devel@nongnu.org>; Sun, 01 Jul 2018 12:24:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5BE60DE6-10C2-4B62-B34D-50F6C014EE7A@gmail.com>
References: <20180608200150.7032-1-programmingkidx@gmail.com>
	<CAFEAcA9F1sTX_9b5PJL61K5eRsP9XoY3KKje_4CNh71JKiw39w@mail.gmail.com>
	<5BE60DE6-10C2-4B62-B34D-50F6C014EE7A@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Jul 2018 20:24:23 +0100
Message-ID: <CAFEAcA9sX8xJZM-TgC9BJcYrhYTw5FOZukYkHCj-7BLUuHfyWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: fix absolute mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 18 June 2018 at 23:24, Programmingkid <programmingkidx@gmail.com> wrote:
> When using an usb-tablet device in QEMU, the Cocoa UI uses absolute
>mode code to handle mouse events. The absolute mode code does not
>correctly determine where QEMU's window is located. Tests indicate
>the current code thinks the window is located in the bottom left
>of the screen.

I guess this is happening because of the note in the
NSEvent locationInWindow method docs that the event
can have a nil window, in which case it gives you the
event location in screen coordinates:
https://developer.apple.com/documentation/appkit/nsevent/1529068-locationinwindow

Those docs also say that the common way to deal with this
is to use the NSView convert method to get the window-relative
coordinates that you want. Maybe we just need to do that?

thanks
-- PMM
