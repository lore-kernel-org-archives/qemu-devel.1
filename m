Received: from eggs.gnu.org ([2001:4830:134:3::10]:34977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cHeXt-0007Z8-Aq
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 17:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cHeXp-0001LK-Sy
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 17:30:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cHeXp-0001KZ-N8
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 17:30:33 -0500
Date: Fri, 16 Dec 2016 00:30:31 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161216002706-mutt-send-email-mst@kernel.org>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
	<20161215075028.GD26169@stefanha-x1.localdomain>
	<1481793479.21413.6.camel@redhat.com>
	<20161215170523-mutt-send-email-mst@kernel.org>
	<1481819150.21413.21.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481819150.21413.21.camel@redhat.com>
Subject: Re: [Qemu-devel] regression in 2.8: unable to exit screen grab in
 SDL mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>

On Thu, Dec 15, 2016 at 05:25:50PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > > > The problem always reproduces for me:
> > > > > - start qemu with -sdl
> > > > > - wait for guest to boot
> > > > > - click anywhere within guest screen
> > > > > - message "press ctrl+alt to exit capture" appears on screen,
> > > > >   but pressing that immediately restarts capture again
> 
> [ 2.6 good, 2.7, 2.8 bad ]
> 
> > I'd say SDL is mostly useless with this bug.
> > 
> > Do we fix this or disable SDL altogether?
> 
> Well, it can't be *that* bad, otherwise it would not went unnoticed for
> a whole release cycle.
> 
> It doesn't reproduce here.  There must be some other factor which is
> needed to trigger this.  What desktop you are using?  gnome?  kde?
> something else?  Xorg or wayland?
> 
> Can you try to bisect it?
> 
> cheers,
>   Gerd


Looks like 2.6 does not work either :( Gerd, are you using F25?
Steps
- launch fedora guest with kvm, default pc graphics and SDL ui
- wait until graphical login prompt starts
- click within window

afterwards, clicking Ctrl-Alt exits and immediately restarts grab.



-- 
MST
