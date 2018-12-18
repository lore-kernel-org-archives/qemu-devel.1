Received: from eggs.gnu.org ([2001:4830:134:3::10]:43141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZ8Ke-00025B-3Q
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 00:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZ8Ka-0006Wd-SR
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 00:54:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZ8Ka-0006Ux-KZ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 00:54:12 -0500
Date: Tue, 18 Dec 2018 06:54:08 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181218055408.6yxxumlhw56vzzus@sirius.home.kraxel.org>
References: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
	<20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
	<20181217150028.GL30264@redhat.com>
	<alpine.BSF.2.21.9999.1812172255250.25213@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1812172255250.25213@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] Monitor and serial output window broken with SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, qemu-devel@nongnu.org

  Hi,

> > > > > Doesn't reproduce too.  It's also not clear why x86_64 should behave
> > > > > different that ppc.  There is no arch-specific code ui/, so there should
> > > > > be no difference, exept for hardware like paralle ports which are not
> > > > > supported by all machine types.
> > > > > 
> > > > > Any chance you have tested an old ppc binary?
> > > > 
> > > > Not likely because I did make distclean and a clean build before testing
> > > > to avoid any possible mismatch. It still does not work for me though.
> > > > While
> > > 
> > > I still have this problem after updating everything on my machine, latest
> > > QEMU and SDL 2.0.9 so it's not likely to be a bug in some external
> > > component. If I just start qemu-system-ppc (compiled with --disable-gtk) and
> > > try to open monitor console with Ctrl-Alt-2 I see QEMU monitor but when I
> > > type in this window the serial output window contents flash in this window.
> > > At the same time the window that opens for Ctrl-Alt-3 which should have the
> > > serial output is empty. It looks like an index may be off somewhere or
> > > window contents are not associated with the right window but I have no idea
> > > where to look for it. Can you reproduce it now and do you have any idea what
> > > could cause this?
> > 
> > Could you share an example command line which can be used to reproduce
> > the problem.
> 
> As I wrote above ust "qemu-system-ppc" without any options reproduces the
> problem here.

Still doesn't reproduce, using "qemu-system-ppc -display sdl".  x86_64
is fine too.  Also using SDL 2.0.9.

"struct sdl2_console" holds the per-window state, you could try to
sprinkle some debug printfs (or add trace points) to sdl2_window_create,
sdl2_redraw, ...

HTH,
  Gerd
