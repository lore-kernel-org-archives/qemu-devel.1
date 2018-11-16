Received: from eggs.gnu.org ([2001:4830:134:3::10]:52665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1gNUkW-00033S-Lo
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1gNUkV-0007Kq-GN
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:24:52 -0500
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34]:35819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1gNUkU-0007EZ-Om
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:24:51 -0500
Received: by mail-io1-xd34.google.com with SMTP id u19so11862538ioc.2
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 19:24:35 -0800 (PST)
MIME-Version: 1.0
References: <20181115085808.GH27915@xz-x1>
	<162b1a37-79d7-8133-22ee-688748fe62b1@redhat.com>
	<20181116025304.GC11565@xz-x1>
In-Reply-To: <20181116025304.GC11565@xz-x1>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 15 Nov 2018 20:24:23 -0700
Message-ID: <CANCZdfrozw4f+ntOyUuX+N1Ny1j+BBEqhuowPXk2sRTSBzCGEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Are FreeBSD guest images working?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peterx@redhat.com
Cc: philmd@redhat.com, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, armbru@redhat.com

On Thu, Nov 15, 2018 at 7:54 PM Peter Xu <peterx@redhat.com> wrote:

> On Thu, Nov 15, 2018 at 11:05:33AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 15/11/18 9:58, Peter Xu wrote:
> > > Hi, the list,
> > >
> > > I am trying to boot a FreeBSD guest but failed.  It hangs at the
> > > kernel booting phase:
> > >
> > > /boot/ker]el/kernel text=3D0x14ed860 data=3D0x132538+0x4baa68
> syms=3D[0x8+0x159ee8+0x8
> > > Booting...
> > > (nothing more)
> > >
> > > It's just as simple as downloading the image and boot so I can't thin=
k
> > > of anything strange within my procedures so far:
> > >
> > > https://wiki.qemu.org/Hosts/BSD#FreeBSD
> > >
> > > I also tried the latest image here:
> > >
> > >
> https://download.freebsd.org/ftp/releases/VM-IMAGES/11.2-RELEASE/amd64/La=
test/FreeBSD-11.2-RELEASE-amd64.qcow2.xz
> > >
> > > but it's having the same problem as 11.0.
> > >
> > > Am downloading an fresh ISO, but before I continue I'm just curious o=
n
> > > whether anyone is using these images and whether there's quick answer=
s
> > > to what I have encountered.
> > >
> > > Thanks in advance,
> >
> > I use 'make vm-build-freebsd' which works, but the image comes
> > pre-installed.
>
> It's because I'm always with no-gui mode and FreeBSD images has no
> serial enabled by default.  I was possibly spoiled by the nice
> virt-builder before with consoles setup already for all Linux guest
> images.  Thanks for answering!
>

I'm coming to the game late...

I run FreeBSD in qemu all the time, but I build images from source to test
the boot loader and it's all serial and my test scripts are tuned to that.
I rarely use the pre-built images, however.

If there's ways that we can build images that work better than we're doing
right now to make the experience better, like making sure we enable the
dual console support for them... We're late in our release cycle, but if
what we need to change is what I think we need to change, we still have
time for it.

In the mean time I'll read through wiki and see if there's anything
obviously wrong...

Warner
