Received: from eggs.gnu.org ([2001:4830:134:3::10]:52560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAZj0-00085P-OH
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAZiv-00063O-76
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:01:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAZiv-00062c-0t
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:01:17 -0400
Message-ID: <1509706872.31823.20.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Nov 2017 12:01:12 +0100
In-Reply-To: <CAFEAcA_DbZ_1WxjtN5NiY3drFgqmJpZwxcrKSeYtqqkjkq0hUA@mail.gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-5-makovick@gmail.com>
	<1509532830.3856.7.camel@redhat.com>
	<CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
	<1509701213.31823.11.camel@redhat.com>
	<CAFEAcA8RbiuAwwW4oqD_i2NGMeAao8KU=pWP7faM0QbajHgMYw@mail.gmail.com>
	<1509705342.31823.16.camel@redhat.com>
	<CAFEAcA_DbZ_1WxjtN5NiY3drFgqmJpZwxcrKSeYtqqkjkq0hUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] sdl2: Only accept the hotkeys on the
 main window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Jind=C5=99ich_Makovi=C4=8Dka?= <makovick@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> There's a patch in-flight to switch cocoa to ctrl-alt-g.
> (If you think that's a bad idea it would be useful to reply
> to that patch.)

I personally don't mind much.  I rarely use it.  With a tablet added to
the guest (which I expect most people do these days) mouse grabs don't
happen anyway.

But when switching cocoa it makes sense to switch sdl too for
consistency.

> Using plain ctrl-alt for ungrab has the disadvantage that you
> then can't send the guest any ctrl-alt-anything combos at all,
> I think.

I think it works, because SDL does the ungrab on ctrl-alt key
*release*.

cheers,
  Gerd
