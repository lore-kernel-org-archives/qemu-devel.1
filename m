Received: from eggs.gnu.org ([2001:4830:134:3::10]:57829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evHWy-0003jV-4d
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 03:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1evHWt-00014e-6Y
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 03:06:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1evHWt-00013e-2c
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 03:05:55 -0400
Date: Mon, 12 Mar 2018 08:05:45 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180312070545.ktvvgp2kn2uxjpzk@sirius.home.kraxel.org>
References: <1520786414-8806-1-git-send-email-aishwaryakadlag@gmail.com>
	<6666720e-6f5c-0e8c-6c5a-ac36d708e314@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6666720e-6f5c-0e8c-6c5a-ac36d708e314@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V1]sm501: dead code removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Aishwarya Kadlag <aishwaryakadlag@gmail.com>, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>

  Hi,

> I don't know the hw/display code very well, but I think it's not that
> easy... Putting Gerd on CC:, maybe he can describe the details of that
> BiteSizeTask a little bit better.

[ Side note: Is there a wiki page for this? ]

Might be it actually is that easy.

Historically qemu created DisplaySurfaces according to the needs of user
interface code, which could be all kinds of formats, and the rendering
code of the display emulation had to deal with it.

These days you always get 32bpp DisplaySurfaces unless you explicitly
do something else.  Code which uses qemu_console_resize() +
qemu_console_surface() or qemu_create_displaysurface() only need to
handle 32bpp rendering outout (PIXMAN_x8r8g8b8 to be exact, i.e. xRGB in
host native byte order).

But note that this applies to rendering only.  Sometimes there is pixel
bit shuffeling code which is part of the device emulation (the cirrus
blitter for example).  This must continue to support all formats of
course.

cheers,
  Gerd
