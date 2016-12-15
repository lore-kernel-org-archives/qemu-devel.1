Received: from eggs.gnu.org ([2001:4830:134:3::10]:38667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cHXda-0005xe-BG
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 10:08:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cHXdU-0006vt-5D
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 10:08:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cHXdT-0006vZ-Vs
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 10:07:56 -0500
Date: Thu, 15 Dec 2016 17:07:53 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20161215170523-mutt-send-email-mst@kernel.org>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
	<20161215075028.GD26169@stefanha-x1.localdomain>
	<1481793479.21413.6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481793479.21413.6.camel@redhat.com>
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

On Thu, Dec 15, 2016 at 10:17:59AM +0100, Gerd Hoffmann wrote:
> On Do, 2016-12-15 at 07:50 +0000, Stefan Hajnoczi wrote:
> > On Thu, Dec 15, 2016 at 06:35:39AM +0200, Michael S. Tsirkin wrote:
> > > The problem always reproduces for me:
> > > - start qemu with -sdl
> > > - wait for guest to boot
> > > - click anywhere within guest screen
> > > - message "press ctrl+alt to exit capture" appears on screen,
> > >   but pressing that immediately restarts capture again
> > > 
> > > Note:
> > > - had to exit to another VT and kill qemu
> > > - why was I able to do that?
> > >   should not ctrl-alt-Fn be captured too?
> > 
> > Sounds related to:
> > 
> > commit 56f289f383a871e871f944c7226920b35794efe6
> > Author: Cole Robinson <crobinso@redhat.com>
> > Date:   Fri May 6 14:03:06 2016 -0400
> > 
> >     ui: sdl2: Release grab before opening console window
> > 
> > Stefan
> 
> Doesn't look related to me, also this is in the v2.7 release already.
> There are no SDL updates in 2.8.  Hmm.  /me looks a bit puzzled.
> 
> What is the known-good setup?
> 
> cheers,
>   Gerd



2.7 has the same bug (requires --disable-werror to build).
2.6 works fine (requires --with-sdlabi=2.0 to build).

I only tested --target-list=x86_64-softmmu .

I'd say SDL is mostly useless with this bug.

Do we fix this or disable SDL altogether?

-- 
MST
