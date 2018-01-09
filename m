Received: from eggs.gnu.org ([2001:4830:134:3::10]:56855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eYuDT-0006uV-P1
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eYuDP-00045D-Ri
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:45:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eYuDP-000449-Kq
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:45:19 -0500
Date: Tue, 9 Jan 2018 14:45:16 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180109134516.vom4czb23tfd4ic4@sirius.home.kraxel.org>
References: <20180104153219.wsxtkzuznu2iwra7@var.youpi.perso.aquilenet.fr>
	<bb6eae87-85b2-4bf2-ad36-26fa95816315@redhat.com>
	<9b392599-a318-90c5-daa8-89ade40c64e5@redhat.com>
	<eba50062-de89-2091-8799-b6de3c88acaf@redhat.com>
	<64a364f0-3dc0-87c4-f0b0-a79365032a8e@redhat.com>
	<351493cf-fa56-491c-c646-49727e6611ed@redhat.com>
	<6900aa32-7774-366f-32a5-9e75b70350db@redhat.com>
	<b6a25497-5353-fe1f-6550-1479b5c4c1f4@redhat.com>
	<ff5a872c-9438-3fa9-6a65-9792c846b151@redhat.com>
	<536d4bc3-8ad6-367e-5011-5e6fb9af1dec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536d4bc3-8ad6-367e-5011-5e6fb9af1dec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@gnu.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

  Hi,

> > We can and should say no.  Sometimes we can also say yes though. :)
> > 
> > I just think that Braille is worth a special case because a subset of
> > our user base (blind people) will use it 100% of the time, plus it is
> > not supported by libvirt and hence virt-manager.
> 
> OK, then let's go forward and use your "-braille serial|usb" patch, and
> nuke the -usbdevice option completely (assuming Gerd agrees, being the
> USB maintainer).

Hmm.  I'm not sure it is a good idea to rush new convinience shortcuts.

In the discussion I've seen a bunch of different possible approaches ...

  (1) new -braille option, hardcoded.
  (2) new -braille option, with some "replace shortcuts with long
      versions" mechanism we could use for other shortcuts too.
  (3) magically create chardev in usb-braille realize.
  (4) allow chardev properties have a default.
  (5) stick with -usbdevice.

... with no clear winnner.

I think nobody wants (5), but I think it is the best short-term option
while we are busy hashing out which of options 1 ... 4 (or possibly
something else) works best long-term.

Also it's not clear what is supposed to happen for "-braille serial".
Will that effectively transform from one shortcut to another (-serial
...)?

So I'd suggest to simply drop the usb_legacy_register() calls +
registered functions from most (all but braille?) devices.

cheers,
  Gerd
