Received: from eggs.gnu.org ([2001:4830:134:3::10]:40450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eniie-0006GC-M0
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 05:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eniia-0007Ov-LH
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 05:30:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eniia-0007OZ-HS
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 05:30:44 -0500
Date: Mon, 19 Feb 2018 11:30:34 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180219103034.zbqxtdises26loqb@sirius.home.kraxel.org>
References: <CABLmASGFPBQV8y1Omm+S53P92Dew_aWBBbDoap+c2b2PVxeLzg@mail.gmail.com>
	<ab4612a8-5c82-5abf-cbc3-d5ec47cd9498@tuxfamily.org>
	<CABLmASFG_cT768zVJwKwrOAB=xhbhvzLa_wvJ4qjRkE6GoZvrA@mail.gmail.com>
	<20180219085648.kgkeo36adbk2tp6g@sirius.home.kraxel.org>
	<CABLmASFgZaV3OgFMykpSi3Ok46+xQ+FW0GNTM+0-wgZyhh8qNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABLmASFgZaV3OgFMykpSi3Ok46+xQ+FW0GNTM+0-wgZyhh8qNw@mail.gmail.com>
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

> >> Hi,
> >>
> >> With SDL, unlike GTK, the mouse does not move outside the window. So I
> >> have to use Ctrl-Alt-G to release focus and then click in the other
> >> window. After two switches the reported issue occurs. Indeed, the Alt
> >> key seems to go into a state in which it is stuck. When trying to
> >> exclude my own keyboard being at fault, I've also noticed the right
> >> Alt key on my keyboard cannot be used for the release.
> >
> > Which qemu version?  There have been a bunch of SDL2 fixes in the 2.12
> > devel cycle already, so if you are on 2.11 still please try git master
> > and see whenever that improves things.
> >
> > cheers,
> >   Gerd
> >
> 
> Hi.
> 
> This was with my own qemu master builds as of yesterday.

Including most recent ui pull request (commit 5e8d6a12d643a38b82a0a713a77d1192117dbdca) ?

I'm wondering that you need Ctrl-Alt-G in the first place, sdl2 and gtk
should have identical behavior here (i.e. no ctrl-alt-g needed in case a
tablet or other absolute ptr device is present).

cheers,
  Gerd
