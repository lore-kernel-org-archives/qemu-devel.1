Received: from eggs.gnu.org ([2001:4830:134:3::10]:52203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5TKg-0007lM-8L
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5TKd-0005TQ-3I
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:43:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5TKc-0005T2-VJ
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:43:23 -0400
Date: Mon, 9 Apr 2018 11:43:21 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180409094321.ekuzanlgynm3nb2o@sirius.home.kraxel.org>
References: <20180321135041.15768-1-kraxel@redhat.com>
	<alpine.BSF.2.21.1804081251340.49362@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1804081251340.49362@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 0/5] sdl2 text console fixes and cleanups.
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

On Sun, Apr 08, 2018 at 12:52:18PM +0200, BALATON Zoltan wrote:
> On Wed, 21 Mar 2018, Gerd Hoffmann wrote:
> > Gerd Hoffmann (5):
> >  ui: add ctrl modifier support to kbd_put_qcode_console()
> >  sdl2: track kbd modifier state unconditionally
> >  sdl2: enable ctrl modifier keys for text consoles
> >  sdl2: drop QEMU_KEY_BACKSPACE special case
> >  sdl2: drop dead code
> > 
> > include/ui/console.h |  2 +-
> > ui/console.c         | 15 +++++++++++++--
> > ui/gtk.c             |  4 ++--
> > ui/sdl2-input.c      | 46 ++++++++++++++++++++--------------------------
> > 4 files changed, 36 insertions(+), 31 deletions(-)
> 
> Will this be included in 2.12? I haven't seen it reaching master yet.

Oops.  Thanks for the reminder.  Pull request sent.

cheers,
  Gerd
