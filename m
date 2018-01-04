Received: from eggs.gnu.org ([2001:4830:134:3::10]:43427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX67T-0002Wl-Mf
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:03:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX67Q-0001QM-Uv
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:03:43 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:58857)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eX67Q-0001Lp-Jf
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:03:40 -0500
Date: Thu, 4 Jan 2018 14:26:00 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180104132600.ikr4migzznhantmt@var.youpi.perso.aquilenet.fr>
References: <1515068847-20311-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515068847-20311-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Hello,

I'm afraid I can't even work out how to replace -usbdevice braille (or
-usbdevice serial, all questions below apply, except making chardev
default to braille):

... -usbdevice braille

-usbdevice braille: '-usbdevice' is deprecated, please use '-device usb-...' instead

but -device usb-serial is not actually documented in the manual page
(same for usb-keyboard, usb-tablet, etc. for instance I can't find in
the manpage anything about replacement for -usbdevice host:nnnn:nnnn)



... -device usb-braille 

-device usb-braille: No 'usb-bus' bus found for device 'usb-braille'

... -device usb-bus -device usb-braille

-device usb-bus: 'usb-bus' is not a valid device model name

So the error message above should suggest -usb.



But then

... -usb -device usb-braille

-device usb-braille: Property chardev is required

that used to be a default, could we keep it a default when using
-device?  Hardly anybody would want to use usb-braille with something
else than chardev braille.



... -usb -device usb-braille,chardev=braille

-device usb-serial,chardev=braille: Property 'usb-serial.chardev' can't find value 'braille'

Uh?  It seems there is a parsing issue here?


So I'm afraid a lot is still missing here.

Samuel
