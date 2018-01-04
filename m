Received: from eggs.gnu.org ([2001:4830:134:3::10]:46550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX6OL-0008Vm-O2
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX6OG-0006kA-F4
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:21:09 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:62747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eX6OG-0006fX-2U
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:21:04 -0500
Date: Thu, 4 Jan 2018 15:21:01 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
References: <1515071752-22961-1-git-send-email-thuth@redhat.com>
	<20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
	<a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
	<20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org

Samuel Thibault, on jeu. 04 janv. 2018 15:15:24 +0100, wrote:
> I'm however still unable to make usb-serial and usb-braille work, as
> mentioned in my other mail :)

Ah, now with the documentation I understand, one has to also pass
-chardev braille,chardev=foobar, and then
-device usb-braille,chardev=foobar works.

Would it be possible to make this automatic?  Before I could tell people
"use -usbdevice braille to test braille", and now it would be
"use -chardev braille,chardev=foobar -device usb-braille,chardev=foobar"
...

Samuel
