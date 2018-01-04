Received: from eggs.gnu.org ([2001:4830:134:3::10]:53297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX9qg-0001xP-1m
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX9qc-0002YO-Q9
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:02:38 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:47936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eX9qc-0002Vi-FS
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 13:02:34 -0500
Date: Thu, 4 Jan 2018 19:02:32 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180104180232.k4lw52jlchknnhhd@var.youpi.perso.aquilenet.fr>
References: <aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com>
	<20180104152402.fv52umjmlb2g22wc@var.youpi.perso.aquilenet.fr>
	<b1a86fed-8a98-cc1d-46ca-5462f8be3fc7@redhat.com>
	<20180104153219.wsxtkzuznu2iwra7@var.youpi.perso.aquilenet.fr>
	<bb6eae87-85b2-4bf2-ad36-26fa95816315@redhat.com>
	<9b392599-a318-90c5-daa8-89ade40c64e5@redhat.com>
	<20180104155640.6rznzu4koy354pyn@var.youpi.perso.aquilenet.fr>
	<4055e106-b24f-09b5-29cd-a4927ecad433@redhat.com>
	<20180104174545.5p2aaypp2asbdoxx@var.youpi.perso.aquilenet.fr>
	<d6e1a2a2-5246-c160-eb20-450d0598247c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e1a2a2-5246-c160-eb20-450d0598247c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, kraxel@redhat.com, qemu-devel@nongnu.org

Paolo Bonzini, on jeu. 04 janv. 2018 18:57:18 +0100, wrote:
> On 04/01/2018 18:45, Samuel Thibault wrote:
> > Paolo Bonzini, on jeu. 04 janv. 2018 18:11:00 +0100, wrote:
> >> On 04/01/2018 16:56, Samuel Thibault wrote:
> >>>> However, adding magic to "-device usb-braille" that creates both a
> >>>> front-end and a back-end is completely the opposite of sane...
> >>> Well, this is also what happens with -device usb-mouse, usb-kbd etc.:
> >>> they also plug with keyboard & mouse pipes of the qemu graphical
> >>> frontend. braille is just the same vein for the user.
> >>
> >> No, they don't create a new UI object magically that wasn't there
> >> before.  They just let you add a device, e.g. a USB tablet, that listens
> >> on an _existing_ UI (GTK+ or SDL or similar).
> > 
> > Technically for the qemu developper, yes.
> > 
> > But for the user, no.
> 
> That's not true.   With or without "-usbdevice tablet", you use the same
> mouse or keyboard device as the input source.

Yes, because it preexists in the mind of the user. That's the same for
braille. The fact that braille has to go through a character-to-brlapi
conversion is not the business of the user, he just wants braille out.

Samuel
