Received: from eggs.gnu.org ([2001:4830:134:3::10]:51740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo4bh-0007yt-Fc
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eo4bd-0005K5-Dr
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:53:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eo4bd-0005Jo-9H
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:53:01 -0500
Date: Tue, 20 Feb 2018 10:52:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180220095254.aoi6y65xbvprhg3i@sirius.home.kraxel.org>
References: <CABLmASGFPBQV8y1Omm+S53P92Dew_aWBBbDoap+c2b2PVxeLzg@mail.gmail.com>
	<ab4612a8-5c82-5abf-cbc3-d5ec47cd9498@tuxfamily.org>
	<CABLmASFG_cT768zVJwKwrOAB=xhbhvzLa_wvJ4qjRkE6GoZvrA@mail.gmail.com>
	<20180219085648.kgkeo36adbk2tp6g@sirius.home.kraxel.org>
	<CABLmASFgZaV3OgFMykpSi3Ok46+xQ+FW0GNTM+0-wgZyhh8qNw@mail.gmail.com>
	<20180219103034.zbqxtdises26loqb@sirius.home.kraxel.org>
	<CABLmASFziChKARGJ-+R0ZJr-F4rbVFZFaixC-CZ8mPF2Sfr=9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABLmASFziChKARGJ-+R0ZJr-F4rbVFZFaixC-CZ8mPF2Sfr=9w@mail.gmail.com>
Subject: Re: [Qemu-devel] Qemu SDL2 bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

> Hi,
> 
> I went on to compile dgibson's rep which includes that commit. But the
> issue remains.
> I normally use -usb-mouse -usb-kbd in the command line, as these work
> for Mac OS 9.x up to 10.5. Using -usb-tablet allows the mouse to
> travel outside the GUI and seems to circumvent the issue in OSX
> guests, but Mac OS 9.x  guests do not work with -usb-tablet.

can you try
https://www.kraxel.org/cgit/qemu/log/?h=sirius/sdl2-hotkey-keyup
?

cheers,
  Gerd
