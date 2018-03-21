Received: from eggs.gnu.org ([2001:4830:134:3::10]:57549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eyeOT-0003bX-My
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eyeON-0000Uw-VY
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:07:09 -0400
Date: Wed, 21 Mar 2018 15:06:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
References: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Tue, Mar 20, 2018 at 11:43:08PM +0100, BALATON Zoltan wrote:
> Hello,
> 
> With SDL2 the monitor and serial output windows behave differently than they
> used to with SDL1.2 in that they are opening in separate windows. This is an
> unexpected change we've discussed before but other than this there are
> actual bugs with SDL2:
> 
> 1. Scrollback does not work. With SDL1.2 it is possible to scroll the
> monitor (and maybe other output windows as well, I'm not sure about that)
> with Ctrl+PgUp/PgDn but this does not work with SDL2. Without this the small
> monitor window is not really usable.

Fixed (patches on the list).

> 2. With at least qemu-system-ppc the serial and parallel output are not
> accessible (Ctrl+Alt+3 opens an empty window and Ctrl+Alt+4 does nothing)

Doesn't reproduce.  Ctrl-Alt-3 open serial for me, which shows some
openbios output.  Ctrl-Alt-4 shows parallel.  powermac (default machine
type).

Tried ppc64 too.  pseries (also default machine type).  Seems there is
no parallel port.  Serial works fine though (shows SLOF output).

> while the serial output seems to be behind the monitor output in the window
> opening with Ctrl+Alt+2 and flashes when I type in this window. (This
> doesn't seem to happen with qemu-system-x86_64, maybe that's why it was not
> catched.)

Doesn't reproduce too.  It's also not clear why x86_64 should behave
different that ppc.  There is no arch-specific code ui/, so there should
be no difference, exept for hardware like paralle ports which are not
supported by all machine types.

Any chance you have tested an old ppc binary?

> Could these be fixed please to make SDL2 a viable alternative before
> deprecating SDL1.2?

SDL-1.2 will stay deprecated.  Actually dropping SDL-1.2 support will
possibly be delayed though, depending on SDL2 state.  SDL2 in 2.12
should already be alot better than in 2.11.  Switching the default
appearently causes many people try SDL2 and report issues, we have quite
a number of bugs fixed in response to these reports.

cheers,
  Gerd
