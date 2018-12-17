Received: from eggs.gnu.org ([2001:4830:134:3::10]:54581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gYuNs-00057f-1C
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:00:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gYuNm-0005iC-07
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:00:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gYuNl-0005h8-O4
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:00:33 -0500
Date: Mon, 17 Dec 2018 15:00:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181217150028.GL30264@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
	<20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Mon, Dec 17, 2018 at 03:56:49PM +0100, BALATON Zoltan wrote:
> On Wed, 21 Mar 2018, BALATON Zoltan wrote:
> > On Wed, 21 Mar 2018, Gerd Hoffmann wrote:
> > > > while the serial output seems to be behind the monitor output in the window
> > > > opening with Ctrl+Alt+2 and flashes when I type in this window. (This
> > > > doesn't seem to happen with qemu-system-x86_64, maybe that's why
> > > > it was not catched.)
> > > 
> > > Doesn't reproduce too.  It's also not clear why x86_64 should behave
> > > different that ppc.  There is no arch-specific code ui/, so there should
> > > be no difference, exept for hardware like paralle ports which are not
> > > supported by all machine types.
> > > 
> > > Any chance you have tested an old ppc binary?
> > 
> > Not likely because I did make distclean and a clean build before testing
> > to avoid any possible mismatch. It still does not work for me though.
> > While
> 
> I still have this problem after updating everything on my machine, latest
> QEMU and SDL 2.0.9 so it's not likely to be a bug in some external
> component. If I just start qemu-system-ppc (compiled with --disable-gtk) and
> try to open monitor console with Ctrl-Alt-2 I see QEMU monitor but when I
> type in this window the serial output window contents flash in this window.
> At the same time the window that opens for Ctrl-Alt-3 which should have the
> serial output is empty. It looks like an index may be off somewhere or
> window contents are not associated with the right window but I have no idea
> where to look for it. Can you reproduce it now and do you have any idea what
> could cause this?

Could you share an example command line which can be used to reproduce
the problem.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
