Received: from eggs.gnu.org ([2001:4830:134:3::10]:55516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1egcFM-0004Mt-AV
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 15:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1egcEI-0002Np-5b
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 15:11:12 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:50898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1egcEH-00023M-LY
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 15:10:05 -0500
Date: Tue, 30 Jan 2018 21:09:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180130145858.hczpqjfzdjziosj6@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.1801302047290.89551@zero.eik.bme.hu>
References: <CAE5jQCeSL5fRXBh5F9L3G5JkkwmS=sU9VS6Bu82Xpq5fMd=K8Q@mail.gmail.com>
	<20180129082727.jvh4nc2cquuqylrv@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1801291701130.88941@zero.eik.bme.hu>
	<20180130092101.hiuru6lnzbjw2jiy@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1801301425250.81470@zero.eik.bme.hu>
	<20180130145858.hczpqjfzdjziosj6@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] SDL2 UI behavior of switching views
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 30 Jan 2018, Gerd Hoffmann wrote:
> SDL1 has a single window for all consoles.
> SDL2 has one window for each console.
>
> Fixed.  Not switchable, neither for SDL1 nor for SDL2.
>
> It sure is possible to make it runtime switchable, but I expect it is
> more much difficuilt to code up when compared to gtk due to the lack of
> widgets.  gtk has one widget per console, I can hook the console widgets
> into my widget/window tree as I like and gtk handles alot of the
> management for me.

I think it does not have to be runtime switchable in the sense that the 
setting does not need to be changable during run (like in gtk) because we 
don't have a UI for changing it anyway. It's enough to have an option to 
decide it once at startup, in case that's easier to implement. If not then 
I guess this will remain as it is now but it's unfortunate to change the 
previous behaviour with a version change for no good reason.

> But feel free to try and send patches.

Unortunately I know nothing about this code and don't have time nor much 
inclination to learn it now. So unless you can at least give some hints on 
what would need to be done I can't send patches for this.

> Can't see much of a difference here.  gtk has a menu bar, sdl hasn't,
> otherwise the two look the same and most hotkeys are the same too.
>
> Adding an option to hide the gtk menu bar shouldn't be much of an issue,
> some code for that is already there as gtk hides the menu bar in
> fullscreen mode.

There's also a version change going on on the gtk side moving from gtk 2 
to 3 which brought similar issues: old behaviour is changed and not 
working the same way any more, themes are broken, more dependencies 
introduced and so on. (Not specifically in QEMU but generally for all gtk 
apps.) Using SDL was also a way to avoid those problems, but then it all 
happens there again.

> I think at the end of the day it boils down to personal preference.
> Which is perfectly fine.  But it needs someone who finds sdl important
> enough to step up and care about it.

I think people who used SDL so far were happy with the way it worked 
before and that's why there wasn't a need to change until now that a 
version update brought unexpected UI changes.

Regards,
BALATON Zoltan
