Received: from eggs.gnu.org ([2001:4830:134:3::10]:35877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wonsange@gmail.com>) id 1fJ71j-0000Ud-9x
	for qemu-devel@nongnu.org; Wed, 16 May 2018 20:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wonsange@gmail.com>) id 1fJ71i-0007Cz-9i
	for qemu-devel@nongnu.org; Wed, 16 May 2018 20:44:15 -0400
Received: from mail-it0-x22c.google.com ([2607:f8b0:4001:c0b::22c]:32980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wonsange@gmail.com>) id 1fJ71i-0007CK-1n
	for qemu-devel@nongnu.org; Wed, 16 May 2018 20:44:14 -0400
Received: by mail-it0-x22c.google.com with SMTP id e185-v6so2943376ita.0
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 17:44:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180515064259.6uh7pngns5in57fn@sirius.home.kraxel.org>
References: <CA+EEy5tEYtEXPH-vXcdcb1XsAD_5MEaz_JQ+_rwK3RfZn4b+nQ@mail.gmail.com>
	<20180514131320.GC5182@stefanha-x1.localdomain>
	<20180515064259.6uh7pngns5in57fn@sirius.home.kraxel.org>
From: =?UTF-8?B?7Jyg7JuQ7IOB?= <wonsange@gmail.com>
Date: Thu, 17 May 2018 09:44:11 +0900
Message-ID: <CA+EEy5uT_pvp1uXDfTLVBb3b_2rhiWxvX+40Cf97Vbdu67qzgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Question about QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

Thank you for your reply.

I understand your suggestion.
But, our embedded OS is very light, so it does not still support to change
screen resolution.
It has fixed resolution(1920x1080).
So, I want a MultiSampling(anti-aliasing) in QEMU & virglrenderer.

I know the embedded OS supports changing resolution is best.
But, QEMU window size is very flexible, but resolution of guest os is very
limit.
I think many developer want to scale fixed resolution.
For example, many android developer use the emulator.
Android emulator can scale windows fixed resolution.

I checked MULTISAMPLING features in virglrenderer, but QEMU not using it.
In QEMU source, I saw "virgl_renderer_resource_create" function call in
virtio-gpu-3d.c.
How can I control nr_samples argument?
Or, do you have another solution for multisampling(anti-aliasing) in QEMU?

Regards,
Wonsang Ryu.

2018-05-15 15:42 GMT+09:00 Gerd Hoffmann <kraxel@redhat.com>:

>   Hi,
>
> > > I have a problem about screen resolution.
> > > Recommended resolution of my guest OS is 1920x1080.
> > > If a QEMU window size is 1920x1080, it is clear.
> > > But, if I change smaller of a QEMU window size, it does not display
> > > clearly.(ex: 1280x720)
> > > In this case, QEMU windows size in host is 1280x720, and guest screen
> > > resolution is 1920x1080.
>
> virtio-gpu signals to the guest that the window size has changed, and
> expected guest behavior is that it changes the guest screen resolution
> accordingly.
>
> > > I want to hold the resolution of the guest OS and scale the QEMU
> windows in
> > > the host OS.
>
> Why?
>
> Setting GL_TEXTURE_{MIN,MAG}_FILTER to GL_LINEAR for the virtio-gpu
> textures surely is possible.  But using a guest screen resolution
> matching the host window size will still give better results than
> doing any kind of scaling.
>
> cheers,
>   Gerd
>
>
