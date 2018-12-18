Received: from eggs.gnu.org ([2001:4830:134:3::10]:44153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZDMA-0007On-0d
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gZDM9-00018B-2z
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:16:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gZDM8-00017j-Rm
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 06:16:08 -0500
Date: Tue, 18 Dec 2018 11:16:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181218111603.GE22638@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
	<20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
	<f3d7a0ed-785d-4176-147d-26a4d58d1a36@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3d7a0ed-785d-4176-147d-26a4d58d1a36@ilande.co.uk>
Subject: Re: [Qemu-devel] Monitor and serial output window broken with SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Tue, Dec 18, 2018 at 10:54:06AM +0000, Mark Cave-Ayland wrote:
> On 17/12/2018 14:56, BALATON Zoltan wrote:
> 
> > I still have this problem after updating everything on my machine, latest QEMU and
> > SDL 2.0.9 so it's not likely to be a bug in some external component. If I just start
> > qemu-system-ppc (compiled with --disable-gtk) and try to open monitor console with
> > Ctrl-Alt-2 I see QEMU monitor but when I type in this window the serial output window
> > contents flash in this window. At the same time the window that opens for Ctrl-Alt-3
> > which should have the serial output is empty. It looks like an index may be off
> > somewhere or window contents are not associated with the right window but I have no
> > idea where to look for it. Can you reproduce it now and do you have any idea what
> > could cause this?
> 
> Are you using Fedora Core 29 at all? I know Howard has been experiencing redraw
> issues since upgrading from FC 28 to FC 29. A couple of other things to check:

There is no "Fedora Core" since Fedora Core 6, just Fedora :-P

But seriously, I teted on Fedora 29 and didn't see any problem, so there
must be some more specific scenario that is hurting it.

> 1) Does QEMU 3.0 work correctly? If so, a bisection would help.
> 2) Are you using an Nvidia graphics card with the nouveau driver?

This second point is a good idea to consider.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
