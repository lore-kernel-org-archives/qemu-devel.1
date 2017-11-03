Received: from eggs.gnu.org ([2001:4830:134:3::10]:38589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAalG-0004wq-OS
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAalC-0004fs-QE
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:07:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAalC-0004f1-Iu
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 08:07:42 -0400
Message-ID: <1509710857.31823.22.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Nov 2017 13:07:37 +0100
In-Reply-To: <CAFEAcA9kLX19tWACRLEGSd6iuRahTkBrORJqt1GSBSAA4bwr6g@mail.gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-5-makovick@gmail.com>
	<1509532830.3856.7.camel@redhat.com>
	<CAHmvugcYmaujAYGwpb+ObistFr522W1XsuV-6jUgi543VgfvTA@mail.gmail.com>
	<1509701213.31823.11.camel@redhat.com>
	<CAFEAcA8RbiuAwwW4oqD_i2NGMeAao8KU=pWP7faM0QbajHgMYw@mail.gmail.com>
	<1509705342.31823.16.camel@redhat.com>
	<CAFEAcA_DbZ_1WxjtN5NiY3drFgqmJpZwxcrKSeYtqqkjkq0hUA@mail.gmail.com>
	<1509706872.31823.20.camel@redhat.com>
	<CAFEAcA9kLX19tWACRLEGSd6iuRahTkBrORJqt1GSBSAA4bwr6g@mail.gmail.com>
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

> I don't think we have the same grab semantics exactly on all
> UI frontends either, so I dunno that that "doesn't grab on tablet"
> is true either.

Well, there are pointer grabs and keyboard grabs.

Pointer grabs happen in relative mouse mode only, and I'm pretty sure
we are consistent here.

Keyboard grabs typically happen if the mouse is within the qemu window,
so keys usually captured by the window manager go to the guest instead.
  Allows to alt-tab cycle through the guest windows instead of the host
windows.  gtk has a menu option for that to enable/disable, for sdl it
is always on.  Dunno about cocoa.

cheers,
  Gerd
