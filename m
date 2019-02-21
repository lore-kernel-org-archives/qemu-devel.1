Received: from eggs.gnu.org ([209.51.188.92]:37475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwohI-0003St-7O
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:47:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwohG-0007YI-3x
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:47:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gwohD-0007UK-N3
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:47:29 -0500
Date: Thu, 21 Feb 2019 14:47:19 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190221134719.632iw3jjoa5hf234@sirius.home.kraxel.org>
References: <155049381165.1196.17842630458734820476.reportbug@cerebro.laendle>
	<eb69a590-ed69-dbe1-edfd-365dbc559d84@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb69a590-ed69-dbe1-edfd-365dbc559d84@msgid.tls.msk.ru>
Subject: Re: [Qemu-devel] Bug#922612: qemu-system: black screen when guest
 goes to powersave, does not come back
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: 922612@bugs.debian.org, qemu-devel qemu-devel <qemu-devel@nongnu.org>

  Hi,

> > That is, when I run either a standard ubuntu 17.10 or windows 10 (with
> > qxl-dod driver), then by default they switch off the screen after a while,
> > which results in black screen in qemu, as expected.

Just the screen saver I guess.

> > If I let the systems idle for longer (say, half an hour), then they seem
> > to go into a deeper powersave, and pressing a key or moving the mouse does
> > NOT restore the screen - it stays black.

Probably "systemctl suspend".

> > When the vm is in this state, I have not found a way to get the display
> > back, the only way that works is to quit qemu and start it again (meaning
> > boot the guest again in a new qemu instance, I have not tried to
> > suspend/resume a vm).
> > 
> > I have verified that mouse inputs and keypresses are registered correctly
> > by the guest in this state, so I assume it does try to switch on the
> > virtual monitor.

Doesn't reproduce.

Can you log into the machine (serial console, network)?
If so: anything suspicious in the kernel log?

Also: it is possible to disable suspend support (libvirt xml):

  <pm>
    <suspend-to-mem enabled='no'/>
    <suspend-to-disk enabled='no'/>
  </pm>

Suspending virtual machines typically adds little benefit and isn't
tested that well, so I'd recommend doing that.

Bugs can be in both host (qemu) and guest (linux kernel driver).   Often
it is quite difficult to debug and to figure who is actually at fault
here.

cheers,
  Gerd
