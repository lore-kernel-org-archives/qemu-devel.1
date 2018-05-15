Received: from eggs.gnu.org ([2001:4830:134:3::10]:42840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fITfu-0004dX-BT
	for qemu-devel@nongnu.org; Tue, 15 May 2018 02:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fITfp-0006aq-BX
	for qemu-devel@nongnu.org; Tue, 15 May 2018 02:43:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fITfp-0006af-6u
	for qemu-devel@nongnu.org; Tue, 15 May 2018 02:43:01 -0400
Date: Tue, 15 May 2018 08:42:59 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180515064259.6uh7pngns5in57fn@sirius.home.kraxel.org>
References: <CA+EEy5tEYtEXPH-vXcdcb1XsAD_5MEaz_JQ+_rwK3RfZn4b+nQ@mail.gmail.com>
	<20180514131320.GC5182@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514131320.GC5182@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Question about QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?utf-8?B?7Jyg7JuQ7IOB?= <wonsange@gmail.com>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

  Hi,

> > I have a problem about screen resolution.
> > Recommended resolution of my guest OS is 1920x1080.
> > If a QEMU window size is 1920x1080, it is clear.
> > But, if I change smaller of a QEMU window size, it does not display
> > clearly.(ex: 1280x720)
> > In this case, QEMU windows size in host is 1280x720, and guest screen
> > resolution is 1920x1080.

virtio-gpu signals to the guest that the window size has changed, and
expected guest behavior is that it changes the guest screen resolution
accordingly.

> > I want to hold the resolution of the guest OS and scale the QEMU windows in
> > the host OS.

Why?

Setting GL_TEXTURE_{MIN,MAG}_FILTER to GL_LINEAR for the virtio-gpu
textures surely is possible.  But using a guest screen resolution
matching the host window size will still give better results than
doing any kind of scaling.

cheers,
  Gerd
