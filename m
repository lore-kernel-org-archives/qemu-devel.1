Received: from eggs.gnu.org ([2001:4830:134:3::10]:33082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eFiDw-0004cp-Bk
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eFiDr-0001Dg-Fe
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:06:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eFiDr-0001CS-99
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 10:06:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 767FEC058EBE
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 15:06:26 +0000 (UTC)
Date: Fri, 17 Nov 2017 15:06:22 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171117150622.GY25830@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171117103046.15943-1-kraxel@redhat.com>
	<20171117103046.15943-2-kraxel@redhat.com>
	<20171117142130.GU25830@redhat.com>
	<20171117144906.4z36tvqclc2gah2d@sirius.home.kraxel.org>
	<20171117145954.GX25830@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171117145954.GX25830@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/24] sdl: remove -no-frame support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Fri, Nov 17, 2017 at 02:59:54PM +0000, Daniel P. Berrange wrote:
> On Fri, Nov 17, 2017 at 03:49:06PM +0100, Gerd Hoffmann wrote:
> > On Fri, Nov 17, 2017 at 02:21:30PM +0000, Daniel P. Berrange wrote:
> > > On Fri, Nov 17, 2017 at 11:30:23AM +0100, Gerd Hoffmann wrote:
> > > > SDL2 doesn't support this any more, the SDL_NOFRAME window flag is gone.
> > > > Drop the code, print a notice when the option is still used.
> > > > 
> > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > > ---
> > > >  include/ui/console.h |  5 ++---
> > > >  ui/sdl.c             |  8 +-------
> > > >  ui/sdl2.c            |  7 +------
> > > >  vl.c                 | 15 ++++-----------
> > > >  4 files changed, 8 insertions(+), 27 deletions(-)
> > > 
> > > This needs to go through the deprecation process before we can
> > > drop it. There's still time to get it into 2.11 deprecated list
> > > which would cut the time needed to wait for real deletion.
> > 
> > I fail to see the point.  SDL2 simply doesn't support it, so it never
> > worked with SDL2.  We switched to SDL2 as default recently.  So it seems
> > fair to me to just say so instead of silently ignoring the option ...
> 
> We still support SDL don't we, which does support it, and which this
> option was targetted at ?

Perhaps we might even consider deprecating SDL1 as a whole, then the
deprecation of -no-frame is a natural side effect ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
