Received: from eggs.gnu.org ([2001:4830:134:3::10]:55136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFhxB-0005om-9S
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eFhx7-0007Th-5a
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:49:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eFhx6-0007Ss-VP
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 09:49:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA9817655D
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 14:49:07 +0000 (UTC)
Date: Fri, 17 Nov 2017 15:49:06 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171117144906.4z36tvqclc2gah2d@sirius.home.kraxel.org>
References: <20171117103046.15943-1-kraxel@redhat.com>
	<20171117103046.15943-2-kraxel@redhat.com>
	<20171117142130.GU25830@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171117142130.GU25830@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/24] sdl: remove -no-frame support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Nov 17, 2017 at 02:21:30PM +0000, Daniel P. Berrange wrote:
> On Fri, Nov 17, 2017 at 11:30:23AM +0100, Gerd Hoffmann wrote:
> > SDL2 doesn't support this any more, the SDL_NOFRAME window flag is gone.
> > Drop the code, print a notice when the option is still used.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  include/ui/console.h |  5 ++---
> >  ui/sdl.c             |  8 +-------
> >  ui/sdl2.c            |  7 +------
> >  vl.c                 | 15 ++++-----------
> >  4 files changed, 8 insertions(+), 27 deletions(-)
> 
> This needs to go through the deprecation process before we can
> drop it. There's still time to get it into 2.11 deprecated list
> which would cut the time needed to wait for real deletion.

I fail to see the point.  SDL2 simply doesn't support it, so it never
worked with SDL2.  We switched to SDL2 as default recently.  So it seems
fair to me to just say so instead of silently ignoring the option ...

cheers,
  Gerd
