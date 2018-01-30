Received: from eggs.gnu.org ([2001:4830:134:3::10]:48350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egXNL-0007Fi-6v
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egXNF-0002f9-GK
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:59:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egXNF-0002el-8Q
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:59:01 -0500
Date: Tue, 30 Jan 2018 15:58:58 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180130145858.hczpqjfzdjziosj6@sirius.home.kraxel.org>
References: <CAE5jQCeSL5fRXBh5F9L3G5JkkwmS=sU9VS6Bu82Xpq5fMd=K8Q@mail.gmail.com>
	<20180129082727.jvh4nc2cquuqylrv@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1801291701130.88941@zero.eik.bme.hu>
	<20180130092101.hiuru6lnzbjw2jiy@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1801301425250.81470@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1801301425250.81470@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] SDL2 UI behavior of switching views
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org

On Tue, Jan 30, 2018 at 02:35:02PM +0100, BALATON Zoltan wrote:
> On Tue, 30 Jan 2018, Gerd Hoffmann wrote:
> > On Mon, Jan 29, 2018 at 07:21:02PM +0100, BALATON Zoltan wrote:
> > > Is there an option also to get back the old SDL1 behaviour with SDL2? Could
> > > that be made the default to make the transition easier?
> > 
> > Well, that kind of flexibility is alot harder to do with SDL as it
> > doesn't offer widgets to manage views ...
> 
> How did it work with SDL1 and what prevents it from working the same way
> with SDL2?

SDL1 has a single window for all consoles.
SDL2 has one window for each console.

Fixed.  Not switchable, neither for SDL1 nor for SDL2.

It sure is possible to make it runtime switchable, but I expect it is
more much difficuilt to code up when compared to gtk due to the lack of
widgets.  gtk has one widget per console, I can hook the console widgets
into my widget/window tree as I like and gtk handles alot of the
management for me.

But feel free to try and send patches.

> > How about using gtk instead?
> 
> That's not a solution to the problem. Why do we have other backends than gtk
> if they aren't meant to be used?

Well, I personally prefer the gtk ui, so my personal focus is there.
I basically run SDL only when testing patches or when touching qemu
console interfaces and coding up the SDL part of it.

BTW: Is anyone who uses SDL more regularely than I do willing to (co-)
maintain the SDL interface?

> (Others already gave reasons to prefer SDL
> over gtk such as leaner, simpler interface

Can't see much of a difference here.  gtk has a menu bar, sdl hasn't,
otherwise the two look the same and most hotkeys are the same too.

Adding an option to hide the gtk menu bar shouldn't be much of an issue,
some code for that is already there as gtk hides the menu bar in
fullscreen mode.

> which is also faster to start up,

qemu startup is instant for me no matter which UI (maybe because I run
gnome so all the shared libs are already in memory).

> also useful if one dosen't need any of the frills the gtk interface provides

You can just ignore the stuff you don't need, it doesn't hurt ...

> or uses QEMU on a low-end system or

Seriously?  Running virtual machines on a system that low-end that gtk
overhead is is an issue?

> platform where gtk is not supported.)

Do we have any?

I think at the end of the day it boils down to personal preference.
Which is perfectly fine.  But it needs someone who finds sdl important
enough to step up and care about it.

cheers,
  Gerd
