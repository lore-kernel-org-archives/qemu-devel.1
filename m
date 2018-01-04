Received: from eggs.gnu.org ([2001:4830:134:3::10]:37963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX6J8-0003ZZ-O4
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:16:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX6Is-0007Mh-Q1
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:15:46 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:32218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eX6Is-0007KA-EC
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:15:30 -0500
Date: Thu, 4 Jan 2018 15:15:24 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
References: <1515071752-22961-1-git-send-email-thuth@redhat.com>
	<20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
	<a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
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

Thomas Huth, on jeu. 04 janv. 2018 15:12:56 +0100, wrote:
> On 04.01.2018 15:09, Samuel Thibault wrote:
> > Thomas Huth, on jeu. 04 janv. 2018 14:15:52 +0100, wrote:
> >> -@item host:@var{bus}.@var{addr}
> >> -Pass through the host device identified by @var{bus}.@var{addr} (Linux only).
> >> -
> >> -@item host:@var{vendor_id}:@var{product_id}
> >> -Pass through the host device identified by @var{vendor_id}:@var{product_id}
> >> -(Linux only).
> >> -
> >> -@item serial:[vendorid=@var{vendor_id}][,productid=@var{product_id}]:@var{dev}
> >> -Serial converter to host character device @var{dev}, see @code{-serial} for the
> >> -available devices.
> > 
> > as mentioned in my other mail, I don't find any place in the manpage
> > where that is now documented.  I believe this -usbdevice foo
> > documentation needs to be converted to -device usb-foo instead of
> > removed. Otherwise as it is now there is no way to even know that
> > -device usb-mouse, -device usb-disk, etc. are available at all.
> 
> I already did convert the chapter that describes the USB devices a
> couple of months ago, you can find it in our qemu-doc.html here:
> 
> https://qemu.weilnetz.de/doc/qemu-doc.html#usb_005fdevices

Ah, ok, thanks.

I'm however still unable to make usb-serial and usb-braille work, as
mentioned in my other mail :)

Samuel
