Received: from eggs.gnu.org ([2001:4830:134:3::10]:55262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jenia.ivlev@gmail.com>) id 1dAQaX-0006O8-5t
	for qemu-devel@nongnu.org; Mon, 15 May 2017 20:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jenia.ivlev@gmail.com>) id 1dAQaW-0001Ic-3T
	for qemu-devel@nongnu.org; Mon, 15 May 2017 20:43:45 -0400
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:35034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jenia.ivlev@gmail.com>)
	id 1dAQaV-0001Hm-Tm
	for qemu-devel@nongnu.org; Mon, 15 May 2017 20:43:44 -0400
Received: by mail-yw0-x243.google.com with SMTP id p144so6943718ywp.2
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 17:43:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170515013613.GA23262@lemon.lan>
References: <87efvrovn7.fsf@gmail.com> <20170515013613.GA23262@lemon.lan>
From: jenia mtl <jenia.ivlev@gmail.com>
Date: Mon, 15 May 2017 20:43:42 -0400
Message-ID: <CAJO5WKtVJQcq2c=nOPz0ezXsb48H3qj77+3LWA3ruTGB2=qnhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Installing Windows with virtio (was: QEMU,
 increase graphics memory)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

Hello Fam.


I managed to installed Windows with the *Virtio* drivers. Thanks for your
tip.

It has made a change in that I got 2X more graphics memory. But not nearly
enough. I need 512 and now I have 16.

How do I specify to Virtio how much memory to allocate?

Thanks
Jenia

On Sun, May 14, 2017 at 9:36 PM, Fam Zheng <famz@redhat.com> wrote:

> On Sun, 05/14 19:39, jenia.ivlev wrote:
> >
> > I wanted to get more graphics memory on my QEMU Windows client.
> >
> > I decided to install **Virtio** drivers for QEMU to achieve that purpose.
> >
> > I create an *imagine_file* like this:
> >
> >
> >     qemu-img create -f raw image_file 4G
> >
> >
> > Also, I ran the windows-install like this:
> >
> >
> >     qemu-system-x86_64 -enable-kvm -m 4G -cdrom "OS.iso" -boot order=c
> -drive file=image_file,if=virtio
> >
> >
> > But when Windows ran, it didn't find any hard-drive (the *image_file*
> > basically). It asked for some drivers instead. I think it wanted drivers
> > to communicate with the hard-drive (*image_file*).
> >
> > Running the install without Virtio works though:
> >
> >
> >     qemu-system-x86_64 -enable-kvm -m 4G -cdrom "OS.iso" -boot order=d
> -drive file=image_file,format=raw
> >
> >
> > The difference betweeen the two commands is:
> >
> >
> >     order=c vs order=d
> >
> >
> > and
> >
> >
> >     if=virtio vs format=raw
> >
> >
> > How do I install windows with Virtio in QEMU?
> >
> > My original goal is to get 512 MB of graphics memory on Windows (running
> > as a guest in QEMU). Unfortunately, by default  (no Virtio) I get 8MB of
> > video memory which is not enough for my purposes
> >
> >
> > Thanks
> >
> > P.S. My OS is Arch-Linux
>
> Since you use ArchLinux, wiki.archlinux.org is rather helpful, as
> always.  Yes,
> you need virtio drivers:
>
> https://wiki.archlinux.org/index.php/QEMU#New_Install_of_Windows
>
>
> Fam
>
