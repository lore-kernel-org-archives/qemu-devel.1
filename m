Received: from eggs.gnu.org ([2001:4830:134:3::10]:52180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX7ss-0005ts-Py
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX7so-00019x-CB
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:56:46 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:42101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eX7so-00017T-1q
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:56:42 -0500
Date: Thu, 4 Jan 2018 16:56:40 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180104155640.6rznzu4koy354pyn@var.youpi.perso.aquilenet.fr>
References: <20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
	<a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
	<20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
	<20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
	<aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com>
	<20180104152402.fv52umjmlb2g22wc@var.youpi.perso.aquilenet.fr>
	<b1a86fed-8a98-cc1d-46ca-5462f8be3fc7@redhat.com>
	<20180104153219.wsxtkzuznu2iwra7@var.youpi.perso.aquilenet.fr>
	<bb6eae87-85b2-4bf2-ad36-26fa95816315@redhat.com>
	<9b392599-a318-90c5-daa8-89ade40c64e5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b392599-a318-90c5-daa8-89ade40c64e5@redhat.com>
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

Paolo Bonzini, on jeu. 04 janv. 2018 16:47:16 +0100, wrote:
> The point of deprecation is not to make the interface simpler, it is to
> avoid cases where one option is doing too much and/or crossing
> abstraction boundaries, for example -net creating both a device and a
> hub port.
> 
> "-serial" is okay because it only creates the front-end, it's the board
> that decides how to attach it to the back-end.
> 
> -usbdevice creating both a front-end and a back-end is not a problem per
> se.  The issue with -usbdevice is just that it's too much code.
> 
> However, adding magic to "-device usb-braille" that creates both a
> front-end and a back-end is completely the opposite of sane...

Well, this is also what happens with -device usb-mouse, usb-kbd etc.:
they also plug with keyboard & mouse pipes of the qemu graphical
frontend. braille is just the same vein for the user.

Samuel
