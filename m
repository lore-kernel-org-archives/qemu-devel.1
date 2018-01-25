Received: from eggs.gnu.org ([2001:4830:134:3::10]:39633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eekKf-0008H4-TE
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eekKa-0007bT-8o
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:24:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eekKa-0007b1-3I
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:24:52 -0500
Date: Thu, 25 Jan 2018 17:24:50 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180125162450.4dguzk5ifvo3njcb@sirius.home.kraxel.org>
References: <20180125091643.26195-1-kraxel@redhat.com>
	<CAFEAcA_U7Dw4m+wLeqHRij5YUO9eFkkpwwRjTWKr099Ux12+cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_U7Dw4m+wLeqHRij5YUO9eFkkpwwRjTWKr099Ux12+cw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/3] Usb 20180125 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 25, 2018 at 03:28:38PM +0000, Peter Maydell wrote:
> On 25 January 2018 at 09:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > Thomas Huth (1):
> >   usb: Remove legacy -usbdevice options (host, serial, disk and net)
> 
> Hi. This fails to build on FreeBSD:
> 
>   LINK    arm-softmmu/qemu-system-arm
> ../vl.o: In function `usb_device_add':
> /root/qemu/vl.c:1471: undefined reference to `usb_host_device_open'
> 
> There's still a call to that function in vl.c inside an
> ifndef CONFIG_LINUX...
> 
> If we can really remove the function we should get rid of the
> stub in hw/usb/host-stub.c and the prototype in usb.h too.

Indeed.  I'll fix it up.

The lines in vl.c dead code anyway since we switched to libusb and
dropped the linux/bsd specific usb-host code, so it all can simply be
deleted.

cheers,
  Gerd
